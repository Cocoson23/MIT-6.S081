# Cocoson23/MIT S6.081 #
For personal practice  
## Ho to run ##
xv6-riscv -> xv6 based on riscv  

- Run the xv6 kernel  
`make qemu`
- Quit  
`click x after Ctrl+a`

xv6-labs-2021 -> environment to get your grade  

- Test your code  
`make grade`
## Ho to use gdb ##  
- Install gdb-multiarch  
`sudo apt-get install gdb-multiarch`  
- create .gdbinit  
edit "YOUR_PATH"  
`echo "add-auto-load-safe-path YOUR_PATH/xv6-labs-2021/.gdbinit " >> ~/.gdbinit`  
- make qemu-gdb  
`make qemu-gdb`  
- run gdb command in another terminal  
`gdb-multiarch`  
***
## Document ##  
Official Docs
- [Official XV6 Link](https://github.com/mit-pdos/xv6-riscv)  

Chinese Docs
- [XV6-RISCV-Book-Chinese](https://github.com/FrankZn/xv6-riscv-book-Chinese)
- [MIT 6.S081 to chinese](https://github.com/huihongxiao/MIT6.S081)  
