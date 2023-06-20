# COW(Copy On Write) #
使用COW实现基于COW的fork  
**该实验难度很高**  

写时复制（Copy-on-write，简称COW）是一种计算机程序设计领域的优化策略。其核心思想是，如果有多个调用者（callers）同时请求相同资源（如内存或磁盘上的数据存储），他们会共同获取相同的指针指向相同的资源，直到某个调用者试图修改资源的内容时，系统才会真正复制一份专用副本（private copy）给该调用者，而其他调用者所见到的最初的资源仍然保持不变。这过程对其他的调用者都是透明的。此作法主要的优点是如果调用者没有修改该资源，就不会有副本（private copy）被创建，因此多个调用者只是读取操作时可以共享同一份资源。
***  
## 提示 ##
根据`hints`中提示，对如下文件进行修改：  
- `uvmcopy()`  
   fork时会调用`uvmcopy()`将父进程内存完全copy一份给子进程，而此时使用COW思想，则只是将子进程的PTE与父进程的PA进行映射，同时将二者`PTE`的`flags`中`PTE_W`置0，变为不可写.
- `usertrap()`  
  当`uvmcopy()`中将`PTE_W`置0后，当程序对该页尝试写操作则会引发对应的页错误`s_cause() == 15`, 于`usertrap()`中捕获该页错误，并调用自定义的COW功能函数`cowalloc()`.
- `cowalloc()`
  自定义函数`cowalloc()`负责接收发生页错误的`VA`与`Pagetable`进行`COW Page`判定，并将当前页表项恢复可写状态，若是`COW Page`则还需为其分配新的`PA`.分配完毕后，则将原`PTE`与`PA`间的映射取消，并完成新分配`PA`与`PTE`间的映射。
- `kalloc.c`
  于`kalloc.c`中定义`PA`引用量记录数组`refcount`,通过在`kinit`、`kfree`、`kalloc`及`freerange`中相应修改`refcount`值(`kinit`中初始化其值，每`kree`一次减一直至等于0时释放页，分配页时`kalloc`将其置一...)
- `copyout()`
  同样当`copyout`遇到`COW Page`时也调用`cowalloc()`进行处理.
## Important ##
- 官方QA视频中老师所讲实验思想值得学习
- 自定义的函数需补充至`defs.h`
- 可以使用`kalloc.c`中自带的`kmem.lock`，也可自定义锁
- 可自定义`PTE_COW`辅助判断`COW Page`
