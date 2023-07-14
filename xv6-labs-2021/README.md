# Lock #  
通过编程，将`Memory allocator`与`Buffer cache`中修改为细粒度的`lock`。  
**READ**  

    Chapter 6: "Locking" and the corresponding code.
    Section 3.5: "Code: Physical memory allocator"
    Section 8.1 through 8.3: "Overview", "Buffer cache layer", and "Code: Buffer cache"  
***
## Memory allocator ##
内存块仅由一个`lock`进行管理，当多进程并发获取内存时，则会产生过多的等待，将原本的`lock`机制修改为细粒度的`lock`能够有效较少该问题。  
### Important ###  
- 原本的`free PA page`均在`freelist`上，根据实验`hints`所提供提示，可以将原本的大链表拆分成`N * little freelist`，由各个CPU单独管理其`lock`。可以将`pa_start`到`pa_end`中的地址直接拆分成`NCPU`段，并分别插入到对应的`freelist`中。也可以将所有的地址直接分配到运行kinit的CPU的`freelist`上，等待后续需要时插入其它链表。  
- 使用`push_off()`及`pop_off()`实现对中断的控制，避免递归获取多个`lock`时发生死锁。
### Steps ###

- 定义kmem数组，将原本单独list与lock拆分成`NCPU`个list与lock  
  `struct kmem kmems[NCPU];`
- 在`kernel/kalloc.c/kfree()`中实现将内存也插入到当前list  
    ```
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
    ```
- 在`kernel/kalloc.c/kalloc()`中实现`free page`的获取
  当前`list`中剩有`free page`时直接分配，若无则遍历搜寻其余`CPU free list`中剩余`free page`进行分配。
***  
## Buffer cache ##
文件系统中，`buffer cache`负责同步对磁盘块的访问及缓存使用较多的磁盘块以提高访问速度。当xv6中使用的是一个粗粒度的锁对整个`buffer cache`进行管理，同样存在过多等待锁的情况，通过改进锁机制实现细粒度的锁同样可以提高该块性能。  
**其思想类似于上述实验，根据`hints`所提示，将原本结构可以化作哈希表来进行修改，即每一个`bukcet`一个`lock`**  
### Steps ###
- 于`struct bcache`中将整个双向链表拆分为多个双向链表，同时为每个双向链表添加对应的`lock`，并设置整体大锁以避免死锁
```
    struct {
    struct spinlock lock[NBUCKETS];
    struct buf buf[NBUF];
    struct buf head[NBUCKETS];
    struct spinlock biglock;
  } bcache;
```
- 在`binit()`中实现锁的初始化，并将`buffer`均插入`bucket 0`中  
- `bget()`实现查找对应的`block`，分为了三种情况分别处理  
  - 于当前`bucket`中查找到对应`block`则直接处理并返回
  - 若当前`bucket`并未缓存则在当前`bucket`中查找未使用且满足LRU算法的`block`使用
  - 若当前`bucket`不满足上述两种情况，则在其余`buffer cache bukcet`中寻找合适的`block`
- 修改`brelse()`中`refcnt == 0`的处理方法为直接更新其时间戳
- 对应更新`bpin()`与`bunpin()`中对`bcache.lock`的使用  
## Reference ##
- [Lab Lock Blog A](https://www.cnblogs.com/duile/p/16389164.html)  
- [Lab Lock Blog B](https://zhuanlan.zhihu.com/p/463598780)
- [Lab Lock Code](https://github.com/computer-net/MIT-6.S081-2020/blob/master/lab8-lock/kernel/bio.c)
