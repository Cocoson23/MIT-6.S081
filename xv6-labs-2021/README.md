# Lab3 Page table #  
## Speed up system calls ##  
用户需要使用系统调用时，需要切换到特殊状态，而通过设置`user space`与`kernel`之间的共享区域，用户态下可以直接访问共享区域数据而不需要切换状态，提升系统调用的速度。  
该实验通过设置共享区域改进getpid()函数，提升该系统调用的速度。  
### 实验步骤 ###  
- 在`proc.c`文件的`allocproc()`函数中添加，为进程分配usyscall页表并初始化代码。  
  - 此时每个进程创建并分配页表的同时也拥有了usyscall页表。  
  - 但此时页表并没有完成与用户态之间的共享，仅仅知晓了usyscall页表的PA，并在该页表起始位置存储了含有`pid`的结构体。  
- 在同文件下的`freeproc()`函数中添加释放usyscall页表内存的代码。  
- 于`proc_pagetable()`函数中仿照`trampoline`使用`mappages()`完成VA USYSCALL与页表PA usyscall的映射。  
- 并于`proc_freepagetable()`函数中添加取消USYSCALL与页表usyscall映射的代码。  
## Print a page table ##
打印第一个进程的页表的内容  
### 重要提示 ###  
- 在`vm.c`文件`vmprint()`函数中实现目标功能  
- `riscv.h`文件中有关页表状态位的宏定义对实验有很大帮助  
- `freewalk()`函数也有较大提示作用  
- 为在`exec.c`文件中调用所实现的`vmprint()`函数，需在`kernel/defs.h`中添加其函数声明  
- 使用`%p`可以在`printf()`中完整打印64位地址  
### 实验步骤 ###  
- 在`exec.c`文件`exec()`函数`return argc`前添加对`vmprint()`函数的调用  
- 在`defs.h`文件中添加`vmprint()`函数的声明  
- 在`vm.c`中实现函数`vmprint()`  
  - 详细阅读`freewalk()`函数实现  
  - 仿造`freewalk()`函数完成对页表层级的递归访问  
    - 其中**PTE_V**作为重要的页表有效性判断条件  
    - 同时当页表为最底层时，**PTE_R|PTE_W|PTE_X**等于1  
  - 借助层级关系更利于输出实验要求的格式(设置辅助函数，当层级为第一层时输出".."，第二层时".. .."以此类推)  
## Detecting which pages have been accessed ##  
实现一个名为`sys_pgaccess()`的系统调用，其功能是在指定起始地址页表开始在一定范围内搜寻近期被访问过的页表，并将结果通过`copyout()`传给用户层。  
该系统调用接收**页表起始地址、搜寻个数、结果输出地址**  
## 重要提示 ##
- 在`kernel/sysproc.c`中完成系统调用`sys_pgaccess()`  
  - 可以通过`argaddr()`与`argint()`完成系统调用的参数解析  
  - 在系统调用内部完成对所实现的`pgaccess()`函数调用  
- 在`riscv.h`中完成`PTE_A`的宏定义，以便使用  
- 在`vm.c`中完成实现实验目标功能的函数`pgaccess()`
  - 在指定个数内循环使用`walk`获取对应VA的PTE  
  - 对PTE的`PTE_A`位进行判断  
  - 对`PTE_A`位判断成功的PTE进行结果保存  
  - 最终对保存的结果使用`copyout()`传给用户层  

