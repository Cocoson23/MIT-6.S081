# File System #  

    Before writing code, you should read "Chapter 8: File system" from the xv6 book and study the corresponding code.  
XV6中实现了较为简易的文件系统，该实验对应章节讲解了文件系统的结构层次，及每一层次对应的功能与特点。  
![1689580790165.jpg](https://s2.loli.net/2023/07/17/Gadp1PJIZzMTfVR.png)  
其中每个文件有对应的数据结构inode对其信息进行标识，对文件的修改与文件系统的恢复则依赖Logging。当需要对文件进行操作时，对应的读写操作会以事务的形式存储到Log，然后以原子操作的表现形式完成。    

***
## Large files ##
文件系统中每个文件拥有自身对应的`inode`数据结构，其中内存块对应了磁盘上的磁盘块(多个扇区)。目前XV6中inode含有`type` `major` `minor` `nlink` `size` 及12个`direct block` 与 1个 `indirect block`，而`indirect block`为一级索引其指向了一个含有256个`block`地址的块，表明当前支持文件大小最大为 `12 + 256 = 268` 个数据块。  
**该实验则是希望通过修改inode结构扩大XV6文件系统支持的文件大小至65803个block**  
![1689580635809.jpg](https://s2.loli.net/2023/07/17/38qxFkSnCBsjVNZ.png)    
### Important ###  
- 根据`hints`提示，可以将`direct block`区域减少一个`block`，将剩余的`block`扩展为二级索引的`indirect block`
- 修改后`code`中`bn0 - bn10`即为`data block`，`bn11`即为单层索引`block`对应了`256个data block`，`bn12`即为二层索引`block`对应了`256 * 256个data block`  
  `12 + 256 + 256 * 256 = 65804 data blocks`
- `kernel/fs.h`中`NDIRECT`原为12，减少一个块后应修改为11
- `kernel/fs.h`的`struct dinode`与`kernel/file.h`的`struct inode`中`uint addrs[NDIRECT+1]`由于`NDIRECT`减小了1应修改为`uint addrs[NDIRECT+2]`，整体inode大小并未改变
- 于`kernel/fs.c/bmap()`中添加双层索引的映射，并于`kernel/fs.c/itrunc()`中添加对双层索引的取消映射

***  
## Symbolic links ##
XV6文件系统仅实现了硬链接，通过该实验将为XV6文件系统实现软链接。  
- 硬链接：多个文件名链接指向同一文件，即一个文件拥有多个有效路径名，可以防止“误删”的情况，当且仅当当前文件硬链接计数为0了才会彻底删除当前文件
- 软连接：类似于Windows下的快捷方式，以符号链接文件形式存在，其中记录了链接对象文件的位置信息  
### Important ###
- 根据`hints`添加系统调用
- 于`kernel/sysfile.c`中实现`sys_symlink()`系统调用，即获取`src`与`target`路径并根据`src`路径创建符号链接文件inode并将`target`文件路径写入inode中
  **注意create返回的inode均已上锁，末尾需要解锁**
- 相对原本XV6文件系统新增了`symbolic link`文件，故系统调用`sys_open()`中需要增加对应部分
  - 当前文件是符号链接时，需要使用`readi()`将符号链接中目标文件的路径读出
  - 随即使用`namei()`根据读出的路径获取目标文件的inode
  - 即可完成通过符号链接文件对目标文件的`open`操作
  - 但当符号链接存储对象仍为符号链接(即递归链接)时，则需递归打开符号链接文件，此处根据`hints`可以将递归打开深度设置为10
## Reference ##
- [Lab Lock Blog](https://zhuanlan.zhihu.com/p/430816131)  
- [Linux soft and hard link](https://zhuanlan.zhihu.com/p/67366919)

