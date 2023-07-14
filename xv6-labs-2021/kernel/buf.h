struct buf {
  int valid;   // has data been read from disk? 是否从磁盘读取数据到buffer中
  int disk;    // does disk "own" buf? 是否将buffer中内容写入了磁盘
  uint dev;
  uint blockno;
  struct sleeplock lock;
  uint refcnt;
  struct buf *prev; // LRU cache list
  struct buf *next;
  uchar data[BSIZE];
  uint lastuse;
};

