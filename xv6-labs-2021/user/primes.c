#include "kernel/types.h"
#include "user/user.h"

// important:
//      child can read 0 after father close all write
void prime(int* pip) {
    // disable child write left pipe
    close(pip[1]);
    int read_len, primes;
    // if read_len = 0, pipe is empty, exit
    read_len = read(pip[0], &primes, sizeof(primes));
    if(read_len == 0) {
        close(pip[0]);
        exit(0);
    }
    // show message
    printf("prime %d\n", primes);

    // create new pipe
    int pp[2];
    pipe(pp);
    // create grandson
    int pid = fork();
    if(pid > 0) {
        // disable son read new pipe
        close(pp[0]);
        
        int read_num;
        // son read old pipe and write correct message to new pipe
        while(read(pip[0], &read_num, sizeof(read_num))) {
            if(read_num % primes != 0)
                write(pp[1], &read_num, sizeof(read_num));
        }
        // disable son read old pipe and write new pipe 
        close(pp[1]);
        close(pip[0]);
        // wait grandson exit...
        wait(0);
    }
    if(pid == 0) {
        // recursion
        prime(pp);
    }
    exit(0);
}

int main()
{
    // create pipe
    int pip[2];
    pipe(pip);
    int pid = fork();
    if(pid > 0) {
    // disable father read pipe
        close(pip[0]);
    // write nums to pipe
        for(int i = 0; i <= 33; i++) {
            int tmp = i+2;
            write(pip[1], &tmp, sizeof(tmp));
        }
    // disable father write after write
        close(pip[1]);
        wait(0);
    }
    // call func
    else if(pid == 0) {
        prime(pip);
    } 
    exit(0);
}
