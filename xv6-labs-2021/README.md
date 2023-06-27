# Multithreading #
使用Pthread和lock机制完成实验  
- `User Thread`  
    XV6系统中一个进程仅包含一个`User Thread`，`User Thread`切换时将`Callee Register`及重要的`ra`、`sp`寄存器保存至`trapframe`中  
- `Kernel Thread`  
  而`Kernel Thread`切换时则是将各种工作环境保存至`context`对象中，同时`Kernel Thread`于XV6中是共享内存的
***  
## Labs ##  
### Uthread: switching between threads ###  
完善`/user/uthread.c`中代码，以实现用户线程的切换(线程工作状态的保存与恢复)  
#### 重要提示 ####  
- 可以自定义结构体以保存`user thread`的工作环境
- 线程初始化时，`ra`、`sp`寄存器的值就应当初始化
- `/user/uthread.S`可以仿照`/kernel/switch.S`完成
***  
### Using threads ###  
该实验实现了一个哈希表的操作，需要通过`lock`机制实现哈希表的多线程使用  
#### 重要提示 ####  
- 可以为哈希表每一个`bucket`创建一个锁进行保护  
- 按照提示中在`put`、`get`中添加对应的申请锁与解锁  
- 记得为每一个锁初始化
***  
### Barrier ###  
该实验实现指定`wait`线程数量，达到要求数量后一同唤醒所有线程  
#### 重要提示 ####  
- `pthread_cond_wait(&cond, &mutex)`可以使线程`wait`
- `pthread_cond_broadcast(&cond)`可以唤醒`wait`的线程
- `pthread_mutex_unlock(&lock)`应当在`pthread_cond_broadcast(&cond)`之后进行
- 由于等待线程计数变量同样是线程间共享变量，则需要锁对其进行保护
