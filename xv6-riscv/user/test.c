#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/wait.h>

void prime(int* pip) {
    int pp[2];
    pipe(pp);
    int pid = fork();
    if(pid > 0) {
        close(pp[0]);
        close(pip[1]);
        int num;
        if(read(pip[0], &num, sizeof(num))>0)
            printf("prime: %d\n", num);
        int read_num;
        while(read(pip[0], &read_num, sizeof(read_num))) {
            if(read_num % num != 0)
                write(pp[1], &read_num, sizeof(read_num));
        }
        close(pp[1]);
        close(pip[0]);
        exit(0);
    }
    if(pid == 0) {
        prime(pp);
        exit(0);
    }
}

int main()
{
    // create pipe
    int pip[2];
    pipe(pip);
    int pid = fork();
    if(pid > 0) {
        close(pip[0]);
    // write nums to pipe
        for(int i = 0; i <= 33; i++) {
            int tmp = i+2;
            write(pip[1], &tmp, sizeof(tmp));
        }
    // disable father read pipe
        close(pip[1]);
        wait(0);
        exit(0);
    }
    if(pid == 0) {
        prime(pip);
        exit(0);
    } 
    return 0;
}
