# Lab3 Page table #  
## Speed up system calls ##  
用户需要使用系统调用时，需要切换到特殊状态，而通过设置`user space`与`kernel`之间的共享区域，用户态下可以直接访问共享区域数据而不需要切换状态，提升系统调用的速度。  
该实验通过设置共享区域改进getpid()函数，提升该系统调用的速度。  
实验步骤：  
- 在`proc.c`文件的`allocproc()`函数中添加，为进程分配usyscall页表并初始化代码。  
  - 此时每个进程创建并分配页表的同时也拥有了usyscall页表。  
  - 但此时页表并没有完成与用户态之间的共享，仅仅知晓了usyscall页表的PA，并在该页表起始位置存储了含有`pid`的结构体。  
- 在同文件下的`freeproc()`函数中添加释放usyscall页表内存的代码。  
- 于`proc_pagetable()`函数中仿照`trampoline`使用`mappages()`完成虚拟地质USYSCALL与页表usyscall的映射。  
- 并于`proc_freepagetable()`函数中添加取消USYSCALL与页表usyscall映射的代码。
