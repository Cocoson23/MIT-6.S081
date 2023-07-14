// Physical memory allocator, for user processes,
// kernel stacks, page-table pages,
// and pipe buffers. Allocates whole 4096-byte pages.

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "defs.h"

void freerange(void *pa_start, void *pa_end);

extern char end[]; // first address after kernel.
                   // defined by kernel.ld.

struct run {
  struct run *next;
};

struct kmem{
  struct spinlock lock;
  struct run *freelist;
} kmem;
// 将原list拆分为N个CPU单独使用的多个小list
// 且每个小list单独使用一个lock
struct kmem kmems[NCPU];

void
kinit()
{
  // 初始化所有CPU的小list lock
  for(int i = 0; i < NCPU; i++)
      initlock(&(kmems[i].lock), "kmem");
  
  freerange(end, (void*)PHYSTOP);
}

void
freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);

  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    kfree(p);
}

// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);

  r = (struct run*)pa;

  // 将pa页插入到当前CPU的list中 
  // get cpu id
  int cpu_id;
  // 关中断
  push_off();
  cpu_id = cpuid();
  acquire(&(kmems[cpu_id]).lock);
  r->next = kmems[cpu_id].freelist;
  kmems[cpu_id].freelist = r;
  release(&(kmems[cpu_id]).lock);

  // 开中断
  pop_off();
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
  struct run *r;

  // 关中断，避免同时获取两个lock发生死锁
  push_off();
  int cpu_id = cpuid();

  acquire(&(kmems[cpu_id]).lock);
  r = kmems[cpu_id].freelist;
  
  // 若当前CPU list中有free的page则直接分配
  if(r) {
    kmems[cpu_id].freelist = r->next;
  }
  // 若无则去其余CPU的list中寻找并插入当前list
  else {
      for(int i = 0 ; i < NCPU; i++) {
          if(i == cpu_id)
              continue;
          // 遍历获取其余CPU id
          acquire(&(kmems[i]).lock);
          r = kmems[i].freelist;
          if(r) {
              kmems[i].freelist = r->next;
              release(&(kmems[i]).lock);
              break;
          }
          release(&(kmems[i]).lock);
      }
  }

  release(&(kmems[cpu_id]).lock);
  // 开中断
  pop_off();
  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
  return (void*)r;
}
