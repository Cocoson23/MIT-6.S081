#include "kernel/types.h"
#include "user/user.h"

int main()
{
  // f2c father to child
  // c2f child to father
  int f2c[2], c2f[2];
  pipe(f2c);
  pipe(c2f);

  int pid = fork();
  // father process
  if(pid > 0) {
    // close f2c read
    // close c2f write
    close(f2c[0]);
    close(c2f[1]);
    // send message to child
    write(f2c[1], "1", 1);
    // close f2c write after write
    close(f2c[1]);
    // wait child to reveive
    wait(0);

    char buf[10];
    // receive child message
    if(read(c2f[0], buf, 1) > 0) {
      int child_pid = getpid();
      printf("%d: received pong\n", child_pid);
    }
    // close c2f read after read
    close(c2f[0]);
    exit(0);
  }
  // child process
  if(pid == 0) {
    // close pipe not use
    close(f2c[1]);
    close(c2f[0]);
    // sleep for a while 
    // wait father send message 
    sleep(1);
    // read father's message
    char buf[10];
    if(read(f2c[0], buf, 1)) {

      int father_pid = getpid();
      printf("%d: received ping\n", father_pid);
      }
    // close f2c read after read
    close(f2c[0]);
    
    // write message to father
    write(c2f[1], "1", 1);
    // close c2f after write
    close(c2f[1]);
    exit(0);
  }
  return 0;
}
