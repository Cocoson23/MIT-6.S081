// Buffer cache.
//
// The buffer cache is a linked list of buf structures holding
// cached copies of disk block contents.  Caching disk blocks
// in memory reduces the number of disk reads and also provides
// a synchronization point for disk blocks used by multiple processes.
//
// Interface:
// * To get a buffer for a particular disk block, call bread.
// * After changing buffer data, call bwrite to write it to disk.
// * When done with the buffer, call brelse.
// * Do not use the buffer after calling brelse.
// * Only one process at a time can use a buffer,
//     so do not keep them longer than necessary.


#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "riscv.h"
#include "defs.h"
#include "fs.h"
#include "buf.h"

#define NBUCKETS 13

// 将原list转变为哈希表，并为每一个bucket实现一个lock以减少lock竞争提升性能
struct {
  struct spinlock lock[NBUCKETS];
  struct buf buf[NBUF];

  // Linked list of all buffers, through prev/next.
  // Sorted by how recently the buffer was used.
  // head.next is most recent, head.prev is least.
  struct buf head[NBUCKETS];
  struct spinlock biglock;
} bcache;

int hash(int blockno, uint dev) {
    return (blockno + dev) % NBUCKETS;
}

void
binit(void)
{
  struct buf *b;

  initlock(&bcache.biglock, "biglock");
  // 将原本link list lock转变为哈希表，对每个bucket实行小lock
  // 初始化lock
  for(int i = 0; i < NBUCKETS; i++) {
      initlock(&bcache.lock[i], "bcache");
      // Create linked list of buffers
      bcache.head[i].prev = &bcache.head[i];
      bcache.head[i].next = &bcache.head[i];
  }

  // 暂时将所有的buffer均插入到bucket0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->lastuse = ticks;
    b->next = bcache.head[0].next;
    b->prev = &bcache.head[0];
    initsleeplock(&b->lock, "buffer");
    bcache.head[0].next->prev = b;
    bcache.head[0].next = b;
  }
}

// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;
  int min_tick = 0;
  int pos = hash(blockno, dev);

  // 使用biglock尽量减少死锁发生(在当前bucket未找到对应block且无free block时acquire了其它block的lock则可能发生死锁)
  acquire(&bcache.biglock);
  acquire(&bcache.lock[pos]);

  // Is the block already cached?
  // 若寻找的block已经缓存了则直接返回
  for(b = bcache.head[pos].next; b != &bcache.head[pos]; b = b->next){
    if(b->dev == dev && b->blockno == blockno){
      b->refcnt++;
      release(&bcache.lock[pos]);
      release(&bcache.biglock);
      acquiresleep(&b->lock);
      return b;
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  // 若未缓存，则在当前bucket中使用LRU思想寻找未使用的buffer
  for(b = bcache.head[pos].prev; b != &bcache.head[pos]; b = b->prev){
    if(b->refcnt == 0 && b->lastuse >= min_tick) {
      min_tick = b->lastuse;

      b->dev = dev;
      b->blockno = blockno;
      b->valid = 0;
      b->refcnt = 1;
      release(&bcache.lock[pos]);
      release(&bcache.biglock);
      acquiresleep(&b->lock);
      return b;
    }
  }

  release(&bcache.lock[pos]);
  // No cached and No free space in current list
  // Try the others list
  // 若未缓存且当前bucket没有free block则去其余bucket寻找
  for(int i = hash(pos+1, b->dev); i != pos; i = hash(i + 1, b->dev)) {
      if(i == pos)
          continue;
      acquire(&bcache.lock[i]);

      for(b = bcache.head[i].next; b != &bcache.head[i]; b = b->prev) {
          if(b->refcnt == 0 && b->lastuse >= min_tick) {
              min_tick = b->lastuse;
              b->dev = dev;
              b->blockno = blockno;
              b->valid = 0;
              b->refcnt = 1;

              // 将找到的block断链
              b->next->prev = b->prev;
              b->prev->next = b->next;

              // 插入到指定bucket的位置中
              b->next = bcache.head[pos].next;
              b->prev = &bcache.head[pos];
              bcache.head[pos].next->prev = b;
              bcache.head[pos].next = b;
              release(&bcache.lock[i]);
              release(&bcache.biglock);
              acquiresleep(&b->lock);
              return b;
          }
      }
      release(&bcache.lock[i]);
  }
  release(&bcache.biglock);
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  virtio_disk_rw(b, 1);
}

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");

  int pos = hash(b->blockno, b->dev);
  releasesleep(&b->lock);

  acquire(&bcache.lock[pos]);
  b->refcnt--;
  if (b->refcnt == 0) {
      /*
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head[pos].next;
    b->prev = &bcache.head[pos];
    bcache.head[pos].next->prev = b;
    bcache.head[pos].next = b;
    */
    b->lastuse = ticks;
  }
  release(&bcache.lock[pos]);
}
void
bpin(struct buf *b) {
  acquire(&bcache.lock[hash(b->blockno, b->dev)]);
  b->refcnt++;
  release(&bcache.lock[hash(b->blockno, b->dev)]);
}

void
bunpin(struct buf *b) {
  acquire(&bcache.lock[hash(b->blockno, b->dev)]);
  b->refcnt--;
  release(&bcache.lock[hash(b->blockno, b->dev)]);
}

