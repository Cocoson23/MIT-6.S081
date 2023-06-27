#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <assert.h>
#include <pthread.h>

// 测试用例指定的等待线程数
static int nthread = 1;
// 第几轮等待
static int round = 0;

struct barrier {
  pthread_mutex_t barrier_mutex;
  pthread_cond_t barrier_cond;
  int nthread;      // Number of threads that have reached this round of the barrier
  int round;     // Barrier round
} bstate;

static void
barrier_init(void)
{
  assert(pthread_mutex_init(&bstate.barrier_mutex, NULL) == 0);
  assert(pthread_cond_init(&bstate.barrier_cond, NULL) == 0);
  bstate.nthread = 0;
}

static void 
barrier()
{
  // YOUR CODE HERE
  //
  // Block until all threads have called barrier() and
  // then increment bstate.round.
  //
  // barrier_mutex是多线程共享的数据，对其进行修改时需要进行加锁保护
  pthread_mutex_lock(&bstate.barrier_mutex);
  // 每次线程进入barrier时，则将当前轮的线程计数+1
  bstate.nthread++;
  // 当当前轮次线程数量达到测试用例设置数量时，广播告知所有等待的线程wakeup
  if(bstate.nthread == nthread) {
      // 同时轮次+1，计数清零
      bstate.round++;
      bstate.nthread = 0;
      pthread_cond_broadcast(&bstate.barrier_cond);
      // 解锁mutex为后续轮线程申请锁提供条件
      pthread_mutex_unlock(&bstate.barrier_mutex);
  }
  // 当计数量未达到等待数量要求时，将线程wait等待，并将锁解锁，以便后续线程申请
  else {
      pthread_cond_wait(&bstate.barrier_cond, &bstate.barrier_mutex);
      pthread_mutex_unlock(&bstate.barrier_mutex);
  }
}

static void *
thread(void *xa)
{
  long n = (long) xa;
  long delay;
  int i;

  for (i = 0; i < 20000; i++) {
    int t = bstate.round;
    assert (i == t);
    barrier();
    usleep(random() % 100);
  }

  return 0;
}

int
main(int argc, char *argv[])
{
  pthread_t *tha;
  void *value;
  long i;
  double t1, t0;

  if (argc < 2) {
    fprintf(stderr, "%s: %s nthread\n", argv[0], argv[0]);
    exit(-1);
  }
  nthread = atoi(argv[1]);
  tha = malloc(sizeof(pthread_t) * nthread);
  srandom(0);

  barrier_init();

  for(i = 0; i < nthread; i++) {
    assert(pthread_create(&tha[i], NULL, thread, (void *) i) == 0);
  }
  for(i = 0; i < nthread; i++) {
    assert(pthread_join(tha[i], &value) == 0);
  }
  printf("OK; passed\n");
}
