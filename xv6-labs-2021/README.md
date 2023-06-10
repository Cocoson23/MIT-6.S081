# Traps #
xv6中traps分为如下三类  
- 系统调用  
- 设备中断  
- 异常  
***  
区分为从user space还是kernel space陷入traps，对各种情况分别处理。  
- trap frome user space  
`uservec` swap a0与sscratch后将当前工作环境保存至trapframe中。  
`uservec` 调用 `usertrap`检查trap原因并调用相应`handler`进行处理，处理完毕后调用`usertrapret`返回。  
`usertrapret` 重置trap环境，为下次trap处理准备并调用`userret`。  
`userret` 切换页表并返回trap发生前代码处。  
- trap from kernel space  
`kernelvec` 保存当前工作环境，并调用`kerneltrap`。
`kerneltrap` 检测trap原因调用相应`handler`。  
`sret` 返回trap前状态。
**struct trapframe保存trap前当前进程的各项工作状态，为恢复trap前状态发挥重要作用**  
## Labs ##
### RISC-V assembly ###
由于对汇编不熟悉故跳过  
### Backtrace ###  
实现一个名为`backtrace()`的函数，在`bttest`时将递归栈中的每个stackframe中的return address打印出来  
#### 重要提示 ####  
- `r_fp()` return pointer to stack frame of current stack page  
- lecture notes docs中对于栈帧的图解需要重点理解  
- `PGROUNDDOWN()`、`PGROUNDUP()`可获取 stack page的top和bottom，可用作循环遍历stack page的范围  
### Alarm ###  
**该实验让学生模拟实现了类似一次trap的过程**  
实现系统调用`sigalarm(n, fn)`,每n个CPU ticks内核调用一次fn，结束后返回调用处  
### 重要提示 ###  
- 可在时钟中断时(`which_dev == 2`)检测ticks次数  
- 可用一个`trapframe`保存当前运行状态以便fn结束后返回
