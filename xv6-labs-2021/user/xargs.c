#include "kernel/types.h"
#include "user/user.h"
#include "kernel/param.h"

int main(int argc, char* argv[])
{
    // exit when command is too short or too long
    if(argc < 2) {
        fprintf(2, "xargs: command is too short\n");
        exit(1);
    }
    if(argc + 1 > MAXARG) {
        fprintf(2, "xargs: command is too long\n");
        exit(1);
    }
    
    char* command[MAXARG];
    char buf[MAXARG];
    memset(buf, 0, sizeof(buf));
    memset(command, 0, sizeof(command));

    // copy whole command except xargs
    for(int i = 0; i < argc-1; i++) {
        command[i] = argv[i+1];
    }
    // end flag
    command[argc] = 0;

    while(1) {
        int i = 0;
        while(read(0, &buf[i], 1)) {
            // break when a line end
            if(buf[i] == '\n')
                break;
            i++;
        }
        // break when 
        if(i == 0)
            break;
        buf[i] = 0;

        // add buf to command[argc-1]
        command[argc-1] = buf;
    
        // create process to exec command
        if(fork() == 0) {
            exec(command[0], command);
            exit(0);
        }
        // wait son finish
        else if(fork() > 0) {
            wait(0);
            exit(0);
        }
    }
    return 0;
}

