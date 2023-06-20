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

struct {
  struct spinlock lock;
  struct run *freelist;
} kmem;

int refcount[PHYSTOP / PGSIZE];

void
kinit()
{
  initlock(&kmem.lock, "kmem");
  freerange(end, (void*)PHYSTOP);
}

void
freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE) {
    // 因为随即调用的kfree中致使refcount--了，此处置一才能抵消
    refcount[(uint64)p / PGSIZE] = 1;
    kfree(p);
  }
}

// ref add 1
void
refadd(uint64 pa)
{
    int idx = pa/PGSIZE;
    acquire(&kmem.lock);
    if(pa >= PHYSTOP || refcount[idx] < 1)
        panic("refadd");
    refcount[idx] += 1;
    release(&kmem.lock);
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

  // kfree含义变更为，当且仅当refcount == 0时才释放页面，>0时refcount--
  acquire(&kmem.lock);
  int idx = (uint64)pa / PGSIZE;
  if(refcount[idx] < 1)
      panic("kfree");
  refcount[idx] -= 1;
  release(&kmem.lock);
  if(refcount[idx] > 0)
      return ;

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);

  r = (struct run*)pa;

  acquire(&kmem.lock);
  r->next = kmem.freelist;
  kmem.freelist = r;
  release(&kmem.lock);
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
  struct run *r;

  acquire(&kmem.lock);
  r = kmem.freelist;
  if(r) {
    kmem.freelist = r->next;
    int idx = (uint64)r / PGSIZE;
    if(refcount[idx] != 0)
        panic("kalloc ref");
    refcount[idx] = 1;
  }
  release(&kmem.lock);

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
  return (void*)r;
}
