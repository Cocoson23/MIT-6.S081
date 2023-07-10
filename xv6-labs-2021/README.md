# Networking #
阅读xv6及E1000用户手册，完成网卡驱动中`e1000_transmit()`及`e1000_recv()`函数。发送与接收数据分别设置了对应的缓冲区描述符数组及缓冲区地址数组，其实现思路为循环队列。  
## Lab ##
- `e1000_transmit()`  
    实现网卡驱动发送数据功能，将待发送数据插入到`tx ring`尾部。  
      · 按照hints中首先获取`tx ring`尾部索引  
      · 并对该索引对应缓冲区描述符结构体中的`status`做对应检查  
      · 若尾部索引对应发送缓冲区中存有内容，则清空  
      · 将`struct mbuf *m`中对应内容放入对应缓冲区结构体  
      · 剩余转发工作则由硬件进行处理  
- `e1000_recv()`  
    实现网卡驱动接收数据功能，当网卡硬件发出中断时，调用该函数对数据进行解封装并存入对应缓冲区。  
      · 按照hints中首先获取`rx ring`尾部+1索引  
      · 检查`status`中`E1000_RXD_STAT_DD`状态位，当且仅当当前数据帧被网卡硬件处理完毕才进行下一步解封装操作  
      · 使用`net_rx()`函数对数据帧进行解封装  
      · 将数据帧中对应内容放入对应`rx_mbufs[rx_index]`缓冲区结构体  
      · 更新接收缓冲区尾部索引`E1000_RDT`
## Important ##  
    Section 2 is essential and gives an overview of the entire device.
    Section 3.2 gives an overview of packet receiving.
    Section 3.3 gives an overview of packet transmission, alongside section 3.4.
    Section 13 gives an overview of the registers used by the E1000.
    Section 14 may help you understand the init code that we've provided.
***  
## Reference ##
- [Lab Networking Blog](https://blog.csdn.net/LostUnravel/article/details/121437373)
- [E1000 Software Developer's Manual](https://pdos.csail.mit.edu/6.S081/2021/readings/8254x_GBe_SDM.pdf)
