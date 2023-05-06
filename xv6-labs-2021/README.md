
# Note #
Lab2 实验：  
Target： 了解系统调用  
- trace
- sysinfo  
![7bc70b6f66994c529524cba9b6835d70.png](https://s2.loli.net/2023/05/06/87XJ1r5gGhqz3Nj.png)
## XV6系统调用流程 ##

    用户使用`user/user.h`中的函数，通过`user/usys.pl`脚本生成系统调用代码`user/usys.S`，从而通过`ecall`进入内核态。  
    于内核态中使用内核函数，可通过`copyout`将data发送到用户态。
    通过内核与用户之间的隔离保证了系统的稳定与安全。

![853921-20220113171702431-1887170168.png](https://s2.loli.net/2023/05/06/BuS1tnfUxjQXO2G.png)  


  
 ## 参考链接 ##
 <https://www.cnblogs.com/YuanZiming/p/14218997.html>(图片原址)  
 <https://zhuanlan.zhihu.com/p/407169754>
