#include "kernel/types.h"
#include "user/user.h"

// 实现调用system call sleep()
// 当shell调用sleep()，却无后续参数时报错
// 正确调用时执行sleep()并通过exit()返回
int main(int argc, char* argv[])
{
  if(argc < 2) {
    char* errorStr = "sleep parameters error\n";
    write(1, errorStr, strlen(errorStr));
    exit(1);
  }
  sleep(atoi(argv[1]));

  exit(0);
}
