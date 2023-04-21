
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   e:	00000097          	auipc	ra,0x0
  12:	2f2080e7          	jalr	754(ra) # 300 <strlen>
  16:	02051593          	slli	a1,a0,0x20
  1a:	9181                	srli	a1,a1,0x20
  1c:	95a6                	add	a1,a1,s1
  1e:	02f00713          	li	a4,47
  22:	0095e963          	bltu	a1,s1,34 <fmtname+0x34>
  26:	0005c783          	lbu	a5,0(a1)
  2a:	00e78563          	beq	a5,a4,34 <fmtname+0x34>
  2e:	15fd                	addi	a1,a1,-1
  30:	fe95fbe3          	bgeu	a1,s1,26 <fmtname+0x26>
    ;
  p++;
  34:	00158493          	addi	s1,a1,1

  memmove(buf, p, strlen(p));
  38:	8526                	mv	a0,s1
  3a:	00000097          	auipc	ra,0x0
  3e:	2c6080e7          	jalr	710(ra) # 300 <strlen>
  42:	00001917          	auipc	s2,0x1
  46:	fce90913          	addi	s2,s2,-50 # 1010 <buf.0>
  4a:	0005061b          	sext.w	a2,a0
  4e:	85a6                	mv	a1,s1
  50:	854a                	mv	a0,s2
  52:	00000097          	auipc	ra,0x0
  56:	420080e7          	jalr	1056(ra) # 472 <memmove>
  buf[strlen(p)] = 0;
  5a:	8526                	mv	a0,s1
  5c:	00000097          	auipc	ra,0x0
  60:	2a4080e7          	jalr	676(ra) # 300 <strlen>
  64:	1502                	slli	a0,a0,0x20
  66:	9101                	srli	a0,a0,0x20
  68:	954a                	add	a0,a0,s2
  6a:	00050023          	sb	zero,0(a0)
  return buf;
}
  6e:	854a                	mv	a0,s2
  70:	60e2                	ld	ra,24(sp)
  72:	6442                	ld	s0,16(sp)
  74:	64a2                	ld	s1,8(sp)
  76:	6902                	ld	s2,0(sp)
  78:	6105                	addi	sp,sp,32
  7a:	8082                	ret

000000000000007c <find>:

void
find(char *path, const char* filename)
{
  7c:	d9010113          	addi	sp,sp,-624
  80:	26113423          	sd	ra,616(sp)
  84:	26813023          	sd	s0,608(sp)
  88:	24913c23          	sd	s1,600(sp)
  8c:	25213823          	sd	s2,592(sp)
  90:	25313423          	sd	s3,584(sp)
  94:	25413023          	sd	s4,576(sp)
  98:	23513c23          	sd	s5,568(sp)
  9c:	23613823          	sd	s6,560(sp)
  a0:	1c80                	addi	s0,sp,624
  a2:	892a                	mv	s2,a0
  a4:	89ae                	mv	s3,a1
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  a6:	4581                	li	a1,0
  a8:	00000097          	auipc	ra,0x0
  ac:	4bc080e7          	jalr	1212(ra) # 564 <open>
  b0:	06054863          	bltz	a0,120 <find+0xa4>
  b4:	84aa                	mv	s1,a0
    fprintf(2, "find: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  b6:	d9840593          	addi	a1,s0,-616
  ba:	00000097          	auipc	ra,0x0
  be:	4c2080e7          	jalr	1218(ra) # 57c <fstat>
  c2:	06054a63          	bltz	a0,136 <find+0xba>
    fprintf(2, "find: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  c6:	da041783          	lh	a5,-608(s0)
  ca:	0007869b          	sext.w	a3,a5
  ce:	4705                	li	a4,1
  d0:	08e68d63          	beq	a3,a4,16a <find+0xee>
  d4:	4709                	li	a4,2
  d6:	00e69d63          	bne	a3,a4,f0 <find+0x74>
  case T_FILE:
    if(strcmp(fmtname(path),filename) == 0)
  da:	854a                	mv	a0,s2
  dc:	00000097          	auipc	ra,0x0
  e0:	f24080e7          	jalr	-220(ra) # 0 <fmtname>
  e4:	85ce                	mv	a1,s3
  e6:	00000097          	auipc	ra,0x0
  ea:	1ee080e7          	jalr	494(ra) # 2d4 <strcmp>
  ee:	c525                	beqz	a0,156 <find+0xda>
      }
      find(buf, filename);
    }
    break;
  }
  close(fd);
  f0:	8526                	mv	a0,s1
  f2:	00000097          	auipc	ra,0x0
  f6:	45a080e7          	jalr	1114(ra) # 54c <close>
}
  fa:	26813083          	ld	ra,616(sp)
  fe:	26013403          	ld	s0,608(sp)
 102:	25813483          	ld	s1,600(sp)
 106:	25013903          	ld	s2,592(sp)
 10a:	24813983          	ld	s3,584(sp)
 10e:	24013a03          	ld	s4,576(sp)
 112:	23813a83          	ld	s5,568(sp)
 116:	23013b03          	ld	s6,560(sp)
 11a:	27010113          	addi	sp,sp,624
 11e:	8082                	ret
    fprintf(2, "find: cannot open %s\n", path);
 120:	864a                	mv	a2,s2
 122:	00001597          	auipc	a1,0x1
 126:	91e58593          	addi	a1,a1,-1762 # a40 <malloc+0xea>
 12a:	4509                	li	a0,2
 12c:	00000097          	auipc	ra,0x0
 130:	744080e7          	jalr	1860(ra) # 870 <fprintf>
    return;
 134:	b7d9                	j	fa <find+0x7e>
    fprintf(2, "find: cannot stat %s\n", path);
 136:	864a                	mv	a2,s2
 138:	00001597          	auipc	a1,0x1
 13c:	92058593          	addi	a1,a1,-1760 # a58 <malloc+0x102>
 140:	4509                	li	a0,2
 142:	00000097          	auipc	ra,0x0
 146:	72e080e7          	jalr	1838(ra) # 870 <fprintf>
    close(fd);
 14a:	8526                	mv	a0,s1
 14c:	00000097          	auipc	ra,0x0
 150:	400080e7          	jalr	1024(ra) # 54c <close>
    return;
 154:	b75d                	j	fa <find+0x7e>
        printf("%s\n",path);
 156:	85ca                	mv	a1,s2
 158:	00001517          	auipc	a0,0x1
 15c:	91850513          	addi	a0,a0,-1768 # a70 <malloc+0x11a>
 160:	00000097          	auipc	ra,0x0
 164:	73e080e7          	jalr	1854(ra) # 89e <printf>
 168:	b761                	j	f0 <find+0x74>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 16a:	854a                	mv	a0,s2
 16c:	00000097          	auipc	ra,0x0
 170:	194080e7          	jalr	404(ra) # 300 <strlen>
 174:	2541                	addiw	a0,a0,16
 176:	20000793          	li	a5,512
 17a:	00a7fb63          	bgeu	a5,a0,190 <find+0x114>
      printf("find: path too long\n");
 17e:	00001517          	auipc	a0,0x1
 182:	8fa50513          	addi	a0,a0,-1798 # a78 <malloc+0x122>
 186:	00000097          	auipc	ra,0x0
 18a:	718080e7          	jalr	1816(ra) # 89e <printf>
      break;
 18e:	b78d                	j	f0 <find+0x74>
    strcpy(buf, path);
 190:	85ca                	mv	a1,s2
 192:	dc040513          	addi	a0,s0,-576
 196:	00000097          	auipc	ra,0x0
 19a:	122080e7          	jalr	290(ra) # 2b8 <strcpy>
    p = buf+strlen(buf);
 19e:	dc040513          	addi	a0,s0,-576
 1a2:	00000097          	auipc	ra,0x0
 1a6:	15e080e7          	jalr	350(ra) # 300 <strlen>
 1aa:	1502                	slli	a0,a0,0x20
 1ac:	9101                	srli	a0,a0,0x20
 1ae:	dc040793          	addi	a5,s0,-576
 1b2:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 1b6:	00190b13          	addi	s6,s2,1
 1ba:	02f00793          	li	a5,47
 1be:	00f90023          	sb	a5,0(s2)
      if(de.inum == 0 || strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 1c2:	00001a17          	auipc	s4,0x1
 1c6:	8cea0a13          	addi	s4,s4,-1842 # a90 <malloc+0x13a>
 1ca:	00001a97          	auipc	s5,0x1
 1ce:	8cea8a93          	addi	s5,s5,-1842 # a98 <malloc+0x142>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1d2:	4641                	li	a2,16
 1d4:	db040593          	addi	a1,s0,-592
 1d8:	8526                	mv	a0,s1
 1da:	00000097          	auipc	ra,0x0
 1de:	362080e7          	jalr	866(ra) # 53c <read>
 1e2:	47c1                	li	a5,16
 1e4:	f0f516e3          	bne	a0,a5,f0 <find+0x74>
      if(de.inum == 0 || strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 1e8:	db045783          	lhu	a5,-592(s0)
 1ec:	d3fd                	beqz	a5,1d2 <find+0x156>
 1ee:	85d2                	mv	a1,s4
 1f0:	db240513          	addi	a0,s0,-590
 1f4:	00000097          	auipc	ra,0x0
 1f8:	0e0080e7          	jalr	224(ra) # 2d4 <strcmp>
 1fc:	d979                	beqz	a0,1d2 <find+0x156>
 1fe:	85d6                	mv	a1,s5
 200:	db240513          	addi	a0,s0,-590
 204:	00000097          	auipc	ra,0x0
 208:	0d0080e7          	jalr	208(ra) # 2d4 <strcmp>
 20c:	d179                	beqz	a0,1d2 <find+0x156>
      memmove(p, de.name, DIRSIZ);
 20e:	4639                	li	a2,14
 210:	db240593          	addi	a1,s0,-590
 214:	855a                	mv	a0,s6
 216:	00000097          	auipc	ra,0x0
 21a:	25c080e7          	jalr	604(ra) # 472 <memmove>
      p[DIRSIZ] = 0;
 21e:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 222:	d9840593          	addi	a1,s0,-616
 226:	dc040513          	addi	a0,s0,-576
 22a:	00000097          	auipc	ra,0x0
 22e:	1ba080e7          	jalr	442(ra) # 3e4 <stat>
 232:	00054a63          	bltz	a0,246 <find+0x1ca>
      find(buf, filename);
 236:	85ce                	mv	a1,s3
 238:	dc040513          	addi	a0,s0,-576
 23c:	00000097          	auipc	ra,0x0
 240:	e40080e7          	jalr	-448(ra) # 7c <find>
 244:	b779                	j	1d2 <find+0x156>
        printf("find: cannot stat %s\n", buf);
 246:	dc040593          	addi	a1,s0,-576
 24a:	00001517          	auipc	a0,0x1
 24e:	80e50513          	addi	a0,a0,-2034 # a58 <malloc+0x102>
 252:	00000097          	auipc	ra,0x0
 256:	64c080e7          	jalr	1612(ra) # 89e <printf>
        continue;
 25a:	bfa5                	j	1d2 <find+0x156>

000000000000025c <main>:

int
main(int argc, char *argv[])
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e406                	sd	ra,8(sp)
 260:	e022                	sd	s0,0(sp)
 262:	0800                	addi	s0,sp,16
  if(argc != 3){
 264:	470d                	li	a4,3
 266:	02e50063          	beq	a0,a4,286 <main+0x2a>
    fprintf(2, "find: error param\n");
 26a:	00001597          	auipc	a1,0x1
 26e:	83658593          	addi	a1,a1,-1994 # aa0 <malloc+0x14a>
 272:	4509                	li	a0,2
 274:	00000097          	auipc	ra,0x0
 278:	5fc080e7          	jalr	1532(ra) # 870 <fprintf>
    exit(0);
 27c:	4501                	li	a0,0
 27e:	00000097          	auipc	ra,0x0
 282:	2a6080e7          	jalr	678(ra) # 524 <exit>
 286:	87ae                	mv	a5,a1
  }
  
  find(argv[1], argv[2]);
 288:	698c                	ld	a1,16(a1)
 28a:	6788                	ld	a0,8(a5)
 28c:	00000097          	auipc	ra,0x0
 290:	df0080e7          	jalr	-528(ra) # 7c <find>
  exit(0);
 294:	4501                	li	a0,0
 296:	00000097          	auipc	ra,0x0
 29a:	28e080e7          	jalr	654(ra) # 524 <exit>

000000000000029e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 29e:	1141                	addi	sp,sp,-16
 2a0:	e406                	sd	ra,8(sp)
 2a2:	e022                	sd	s0,0(sp)
 2a4:	0800                	addi	s0,sp,16
  extern int main();
  main();
 2a6:	00000097          	auipc	ra,0x0
 2aa:	fb6080e7          	jalr	-74(ra) # 25c <main>
  exit(0);
 2ae:	4501                	li	a0,0
 2b0:	00000097          	auipc	ra,0x0
 2b4:	274080e7          	jalr	628(ra) # 524 <exit>

00000000000002b8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2b8:	1141                	addi	sp,sp,-16
 2ba:	e422                	sd	s0,8(sp)
 2bc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2be:	87aa                	mv	a5,a0
 2c0:	0585                	addi	a1,a1,1
 2c2:	0785                	addi	a5,a5,1
 2c4:	fff5c703          	lbu	a4,-1(a1)
 2c8:	fee78fa3          	sb	a4,-1(a5)
 2cc:	fb75                	bnez	a4,2c0 <strcpy+0x8>
    ;
  return os;
}
 2ce:	6422                	ld	s0,8(sp)
 2d0:	0141                	addi	sp,sp,16
 2d2:	8082                	ret

00000000000002d4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2d4:	1141                	addi	sp,sp,-16
 2d6:	e422                	sd	s0,8(sp)
 2d8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2da:	00054783          	lbu	a5,0(a0)
 2de:	cb91                	beqz	a5,2f2 <strcmp+0x1e>
 2e0:	0005c703          	lbu	a4,0(a1)
 2e4:	00f71763          	bne	a4,a5,2f2 <strcmp+0x1e>
    p++, q++;
 2e8:	0505                	addi	a0,a0,1
 2ea:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2ec:	00054783          	lbu	a5,0(a0)
 2f0:	fbe5                	bnez	a5,2e0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2f2:	0005c503          	lbu	a0,0(a1)
}
 2f6:	40a7853b          	subw	a0,a5,a0
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <strlen>:

uint
strlen(const char *s)
{
 300:	1141                	addi	sp,sp,-16
 302:	e422                	sd	s0,8(sp)
 304:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 306:	00054783          	lbu	a5,0(a0)
 30a:	cf91                	beqz	a5,326 <strlen+0x26>
 30c:	0505                	addi	a0,a0,1
 30e:	87aa                	mv	a5,a0
 310:	4685                	li	a3,1
 312:	9e89                	subw	a3,a3,a0
 314:	00f6853b          	addw	a0,a3,a5
 318:	0785                	addi	a5,a5,1
 31a:	fff7c703          	lbu	a4,-1(a5)
 31e:	fb7d                	bnez	a4,314 <strlen+0x14>
    ;
  return n;
}
 320:	6422                	ld	s0,8(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret
  for(n = 0; s[n]; n++)
 326:	4501                	li	a0,0
 328:	bfe5                	j	320 <strlen+0x20>

000000000000032a <memset>:

void*
memset(void *dst, int c, uint n)
{
 32a:	1141                	addi	sp,sp,-16
 32c:	e422                	sd	s0,8(sp)
 32e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 330:	ca19                	beqz	a2,346 <memset+0x1c>
 332:	87aa                	mv	a5,a0
 334:	1602                	slli	a2,a2,0x20
 336:	9201                	srli	a2,a2,0x20
 338:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 33c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 340:	0785                	addi	a5,a5,1
 342:	fee79de3          	bne	a5,a4,33c <memset+0x12>
  }
  return dst;
}
 346:	6422                	ld	s0,8(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret

000000000000034c <strchr>:

char*
strchr(const char *s, char c)
{
 34c:	1141                	addi	sp,sp,-16
 34e:	e422                	sd	s0,8(sp)
 350:	0800                	addi	s0,sp,16
  for(; *s; s++)
 352:	00054783          	lbu	a5,0(a0)
 356:	cb99                	beqz	a5,36c <strchr+0x20>
    if(*s == c)
 358:	00f58763          	beq	a1,a5,366 <strchr+0x1a>
  for(; *s; s++)
 35c:	0505                	addi	a0,a0,1
 35e:	00054783          	lbu	a5,0(a0)
 362:	fbfd                	bnez	a5,358 <strchr+0xc>
      return (char*)s;
  return 0;
 364:	4501                	li	a0,0
}
 366:	6422                	ld	s0,8(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret
  return 0;
 36c:	4501                	li	a0,0
 36e:	bfe5                	j	366 <strchr+0x1a>

0000000000000370 <gets>:

char*
gets(char *buf, int max)
{
 370:	711d                	addi	sp,sp,-96
 372:	ec86                	sd	ra,88(sp)
 374:	e8a2                	sd	s0,80(sp)
 376:	e4a6                	sd	s1,72(sp)
 378:	e0ca                	sd	s2,64(sp)
 37a:	fc4e                	sd	s3,56(sp)
 37c:	f852                	sd	s4,48(sp)
 37e:	f456                	sd	s5,40(sp)
 380:	f05a                	sd	s6,32(sp)
 382:	ec5e                	sd	s7,24(sp)
 384:	1080                	addi	s0,sp,96
 386:	8baa                	mv	s7,a0
 388:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 38a:	892a                	mv	s2,a0
 38c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 38e:	4aa9                	li	s5,10
 390:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 392:	89a6                	mv	s3,s1
 394:	2485                	addiw	s1,s1,1
 396:	0344d863          	bge	s1,s4,3c6 <gets+0x56>
    cc = read(0, &c, 1);
 39a:	4605                	li	a2,1
 39c:	faf40593          	addi	a1,s0,-81
 3a0:	4501                	li	a0,0
 3a2:	00000097          	auipc	ra,0x0
 3a6:	19a080e7          	jalr	410(ra) # 53c <read>
    if(cc < 1)
 3aa:	00a05e63          	blez	a0,3c6 <gets+0x56>
    buf[i++] = c;
 3ae:	faf44783          	lbu	a5,-81(s0)
 3b2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3b6:	01578763          	beq	a5,s5,3c4 <gets+0x54>
 3ba:	0905                	addi	s2,s2,1
 3bc:	fd679be3          	bne	a5,s6,392 <gets+0x22>
  for(i=0; i+1 < max; ){
 3c0:	89a6                	mv	s3,s1
 3c2:	a011                	j	3c6 <gets+0x56>
 3c4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3c6:	99de                	add	s3,s3,s7
 3c8:	00098023          	sb	zero,0(s3)
  return buf;
}
 3cc:	855e                	mv	a0,s7
 3ce:	60e6                	ld	ra,88(sp)
 3d0:	6446                	ld	s0,80(sp)
 3d2:	64a6                	ld	s1,72(sp)
 3d4:	6906                	ld	s2,64(sp)
 3d6:	79e2                	ld	s3,56(sp)
 3d8:	7a42                	ld	s4,48(sp)
 3da:	7aa2                	ld	s5,40(sp)
 3dc:	7b02                	ld	s6,32(sp)
 3de:	6be2                	ld	s7,24(sp)
 3e0:	6125                	addi	sp,sp,96
 3e2:	8082                	ret

00000000000003e4 <stat>:

int
stat(const char *n, struct stat *st)
{
 3e4:	1101                	addi	sp,sp,-32
 3e6:	ec06                	sd	ra,24(sp)
 3e8:	e822                	sd	s0,16(sp)
 3ea:	e426                	sd	s1,8(sp)
 3ec:	e04a                	sd	s2,0(sp)
 3ee:	1000                	addi	s0,sp,32
 3f0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3f2:	4581                	li	a1,0
 3f4:	00000097          	auipc	ra,0x0
 3f8:	170080e7          	jalr	368(ra) # 564 <open>
  if(fd < 0)
 3fc:	02054563          	bltz	a0,426 <stat+0x42>
 400:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 402:	85ca                	mv	a1,s2
 404:	00000097          	auipc	ra,0x0
 408:	178080e7          	jalr	376(ra) # 57c <fstat>
 40c:	892a                	mv	s2,a0
  close(fd);
 40e:	8526                	mv	a0,s1
 410:	00000097          	auipc	ra,0x0
 414:	13c080e7          	jalr	316(ra) # 54c <close>
  return r;
}
 418:	854a                	mv	a0,s2
 41a:	60e2                	ld	ra,24(sp)
 41c:	6442                	ld	s0,16(sp)
 41e:	64a2                	ld	s1,8(sp)
 420:	6902                	ld	s2,0(sp)
 422:	6105                	addi	sp,sp,32
 424:	8082                	ret
    return -1;
 426:	597d                	li	s2,-1
 428:	bfc5                	j	418 <stat+0x34>

000000000000042a <atoi>:

int
atoi(const char *s)
{
 42a:	1141                	addi	sp,sp,-16
 42c:	e422                	sd	s0,8(sp)
 42e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 430:	00054683          	lbu	a3,0(a0)
 434:	fd06879b          	addiw	a5,a3,-48
 438:	0ff7f793          	zext.b	a5,a5
 43c:	4625                	li	a2,9
 43e:	02f66863          	bltu	a2,a5,46e <atoi+0x44>
 442:	872a                	mv	a4,a0
  n = 0;
 444:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 446:	0705                	addi	a4,a4,1
 448:	0025179b          	slliw	a5,a0,0x2
 44c:	9fa9                	addw	a5,a5,a0
 44e:	0017979b          	slliw	a5,a5,0x1
 452:	9fb5                	addw	a5,a5,a3
 454:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 458:	00074683          	lbu	a3,0(a4)
 45c:	fd06879b          	addiw	a5,a3,-48
 460:	0ff7f793          	zext.b	a5,a5
 464:	fef671e3          	bgeu	a2,a5,446 <atoi+0x1c>
  return n;
}
 468:	6422                	ld	s0,8(sp)
 46a:	0141                	addi	sp,sp,16
 46c:	8082                	ret
  n = 0;
 46e:	4501                	li	a0,0
 470:	bfe5                	j	468 <atoi+0x3e>

0000000000000472 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 472:	1141                	addi	sp,sp,-16
 474:	e422                	sd	s0,8(sp)
 476:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 478:	02b57463          	bgeu	a0,a1,4a0 <memmove+0x2e>
    while(n-- > 0)
 47c:	00c05f63          	blez	a2,49a <memmove+0x28>
 480:	1602                	slli	a2,a2,0x20
 482:	9201                	srli	a2,a2,0x20
 484:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 488:	872a                	mv	a4,a0
      *dst++ = *src++;
 48a:	0585                	addi	a1,a1,1
 48c:	0705                	addi	a4,a4,1
 48e:	fff5c683          	lbu	a3,-1(a1)
 492:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 496:	fee79ae3          	bne	a5,a4,48a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 49a:	6422                	ld	s0,8(sp)
 49c:	0141                	addi	sp,sp,16
 49e:	8082                	ret
    dst += n;
 4a0:	00c50733          	add	a4,a0,a2
    src += n;
 4a4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4a6:	fec05ae3          	blez	a2,49a <memmove+0x28>
 4aa:	fff6079b          	addiw	a5,a2,-1
 4ae:	1782                	slli	a5,a5,0x20
 4b0:	9381                	srli	a5,a5,0x20
 4b2:	fff7c793          	not	a5,a5
 4b6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4b8:	15fd                	addi	a1,a1,-1
 4ba:	177d                	addi	a4,a4,-1
 4bc:	0005c683          	lbu	a3,0(a1)
 4c0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4c4:	fee79ae3          	bne	a5,a4,4b8 <memmove+0x46>
 4c8:	bfc9                	j	49a <memmove+0x28>

00000000000004ca <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4ca:	1141                	addi	sp,sp,-16
 4cc:	e422                	sd	s0,8(sp)
 4ce:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4d0:	ca05                	beqz	a2,500 <memcmp+0x36>
 4d2:	fff6069b          	addiw	a3,a2,-1
 4d6:	1682                	slli	a3,a3,0x20
 4d8:	9281                	srli	a3,a3,0x20
 4da:	0685                	addi	a3,a3,1
 4dc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4de:	00054783          	lbu	a5,0(a0)
 4e2:	0005c703          	lbu	a4,0(a1)
 4e6:	00e79863          	bne	a5,a4,4f6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4ea:	0505                	addi	a0,a0,1
    p2++;
 4ec:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4ee:	fed518e3          	bne	a0,a3,4de <memcmp+0x14>
  }
  return 0;
 4f2:	4501                	li	a0,0
 4f4:	a019                	j	4fa <memcmp+0x30>
      return *p1 - *p2;
 4f6:	40e7853b          	subw	a0,a5,a4
}
 4fa:	6422                	ld	s0,8(sp)
 4fc:	0141                	addi	sp,sp,16
 4fe:	8082                	ret
  return 0;
 500:	4501                	li	a0,0
 502:	bfe5                	j	4fa <memcmp+0x30>

0000000000000504 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 504:	1141                	addi	sp,sp,-16
 506:	e406                	sd	ra,8(sp)
 508:	e022                	sd	s0,0(sp)
 50a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 50c:	00000097          	auipc	ra,0x0
 510:	f66080e7          	jalr	-154(ra) # 472 <memmove>
}
 514:	60a2                	ld	ra,8(sp)
 516:	6402                	ld	s0,0(sp)
 518:	0141                	addi	sp,sp,16
 51a:	8082                	ret

000000000000051c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 51c:	4885                	li	a7,1
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <exit>:
.global exit
exit:
 li a7, SYS_exit
 524:	4889                	li	a7,2
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <wait>:
.global wait
wait:
 li a7, SYS_wait
 52c:	488d                	li	a7,3
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 534:	4891                	li	a7,4
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <read>:
.global read
read:
 li a7, SYS_read
 53c:	4895                	li	a7,5
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <write>:
.global write
write:
 li a7, SYS_write
 544:	48c1                	li	a7,16
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <close>:
.global close
close:
 li a7, SYS_close
 54c:	48d5                	li	a7,21
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <kill>:
.global kill
kill:
 li a7, SYS_kill
 554:	4899                	li	a7,6
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <exec>:
.global exec
exec:
 li a7, SYS_exec
 55c:	489d                	li	a7,7
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <open>:
.global open
open:
 li a7, SYS_open
 564:	48bd                	li	a7,15
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 56c:	48c5                	li	a7,17
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 574:	48c9                	li	a7,18
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 57c:	48a1                	li	a7,8
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <link>:
.global link
link:
 li a7, SYS_link
 584:	48cd                	li	a7,19
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 58c:	48d1                	li	a7,20
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 594:	48a5                	li	a7,9
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <dup>:
.global dup
dup:
 li a7, SYS_dup
 59c:	48a9                	li	a7,10
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5a4:	48ad                	li	a7,11
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5ac:	48b1                	li	a7,12
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5b4:	48b5                	li	a7,13
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5bc:	48b9                	li	a7,14
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5c4:	1101                	addi	sp,sp,-32
 5c6:	ec06                	sd	ra,24(sp)
 5c8:	e822                	sd	s0,16(sp)
 5ca:	1000                	addi	s0,sp,32
 5cc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5d0:	4605                	li	a2,1
 5d2:	fef40593          	addi	a1,s0,-17
 5d6:	00000097          	auipc	ra,0x0
 5da:	f6e080e7          	jalr	-146(ra) # 544 <write>
}
 5de:	60e2                	ld	ra,24(sp)
 5e0:	6442                	ld	s0,16(sp)
 5e2:	6105                	addi	sp,sp,32
 5e4:	8082                	ret

00000000000005e6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5e6:	7139                	addi	sp,sp,-64
 5e8:	fc06                	sd	ra,56(sp)
 5ea:	f822                	sd	s0,48(sp)
 5ec:	f426                	sd	s1,40(sp)
 5ee:	f04a                	sd	s2,32(sp)
 5f0:	ec4e                	sd	s3,24(sp)
 5f2:	0080                	addi	s0,sp,64
 5f4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5f6:	c299                	beqz	a3,5fc <printint+0x16>
 5f8:	0805c963          	bltz	a1,68a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5fc:	2581                	sext.w	a1,a1
  neg = 0;
 5fe:	4881                	li	a7,0
 600:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 604:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 606:	2601                	sext.w	a2,a2
 608:	00000517          	auipc	a0,0x0
 60c:	51050513          	addi	a0,a0,1296 # b18 <digits>
 610:	883a                	mv	a6,a4
 612:	2705                	addiw	a4,a4,1
 614:	02c5f7bb          	remuw	a5,a1,a2
 618:	1782                	slli	a5,a5,0x20
 61a:	9381                	srli	a5,a5,0x20
 61c:	97aa                	add	a5,a5,a0
 61e:	0007c783          	lbu	a5,0(a5)
 622:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 626:	0005879b          	sext.w	a5,a1
 62a:	02c5d5bb          	divuw	a1,a1,a2
 62e:	0685                	addi	a3,a3,1
 630:	fec7f0e3          	bgeu	a5,a2,610 <printint+0x2a>
  if(neg)
 634:	00088c63          	beqz	a7,64c <printint+0x66>
    buf[i++] = '-';
 638:	fd070793          	addi	a5,a4,-48
 63c:	00878733          	add	a4,a5,s0
 640:	02d00793          	li	a5,45
 644:	fef70823          	sb	a5,-16(a4)
 648:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 64c:	02e05863          	blez	a4,67c <printint+0x96>
 650:	fc040793          	addi	a5,s0,-64
 654:	00e78933          	add	s2,a5,a4
 658:	fff78993          	addi	s3,a5,-1
 65c:	99ba                	add	s3,s3,a4
 65e:	377d                	addiw	a4,a4,-1
 660:	1702                	slli	a4,a4,0x20
 662:	9301                	srli	a4,a4,0x20
 664:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 668:	fff94583          	lbu	a1,-1(s2)
 66c:	8526                	mv	a0,s1
 66e:	00000097          	auipc	ra,0x0
 672:	f56080e7          	jalr	-170(ra) # 5c4 <putc>
  while(--i >= 0)
 676:	197d                	addi	s2,s2,-1
 678:	ff3918e3          	bne	s2,s3,668 <printint+0x82>
}
 67c:	70e2                	ld	ra,56(sp)
 67e:	7442                	ld	s0,48(sp)
 680:	74a2                	ld	s1,40(sp)
 682:	7902                	ld	s2,32(sp)
 684:	69e2                	ld	s3,24(sp)
 686:	6121                	addi	sp,sp,64
 688:	8082                	ret
    x = -xx;
 68a:	40b005bb          	negw	a1,a1
    neg = 1;
 68e:	4885                	li	a7,1
    x = -xx;
 690:	bf85                	j	600 <printint+0x1a>

0000000000000692 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 692:	7119                	addi	sp,sp,-128
 694:	fc86                	sd	ra,120(sp)
 696:	f8a2                	sd	s0,112(sp)
 698:	f4a6                	sd	s1,104(sp)
 69a:	f0ca                	sd	s2,96(sp)
 69c:	ecce                	sd	s3,88(sp)
 69e:	e8d2                	sd	s4,80(sp)
 6a0:	e4d6                	sd	s5,72(sp)
 6a2:	e0da                	sd	s6,64(sp)
 6a4:	fc5e                	sd	s7,56(sp)
 6a6:	f862                	sd	s8,48(sp)
 6a8:	f466                	sd	s9,40(sp)
 6aa:	f06a                	sd	s10,32(sp)
 6ac:	ec6e                	sd	s11,24(sp)
 6ae:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6b0:	0005c903          	lbu	s2,0(a1)
 6b4:	18090f63          	beqz	s2,852 <vprintf+0x1c0>
 6b8:	8aaa                	mv	s5,a0
 6ba:	8b32                	mv	s6,a2
 6bc:	00158493          	addi	s1,a1,1
  state = 0;
 6c0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6c2:	02500a13          	li	s4,37
 6c6:	4c55                	li	s8,21
 6c8:	00000c97          	auipc	s9,0x0
 6cc:	3f8c8c93          	addi	s9,s9,1016 # ac0 <malloc+0x16a>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6d0:	02800d93          	li	s11,40
  putc(fd, 'x');
 6d4:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d6:	00000b97          	auipc	s7,0x0
 6da:	442b8b93          	addi	s7,s7,1090 # b18 <digits>
 6de:	a839                	j	6fc <vprintf+0x6a>
        putc(fd, c);
 6e0:	85ca                	mv	a1,s2
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	ee0080e7          	jalr	-288(ra) # 5c4 <putc>
 6ec:	a019                	j	6f2 <vprintf+0x60>
    } else if(state == '%'){
 6ee:	01498d63          	beq	s3,s4,708 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 6f2:	0485                	addi	s1,s1,1
 6f4:	fff4c903          	lbu	s2,-1(s1)
 6f8:	14090d63          	beqz	s2,852 <vprintf+0x1c0>
    if(state == 0){
 6fc:	fe0999e3          	bnez	s3,6ee <vprintf+0x5c>
      if(c == '%'){
 700:	ff4910e3          	bne	s2,s4,6e0 <vprintf+0x4e>
        state = '%';
 704:	89d2                	mv	s3,s4
 706:	b7f5                	j	6f2 <vprintf+0x60>
      if(c == 'd'){
 708:	11490c63          	beq	s2,s4,820 <vprintf+0x18e>
 70c:	f9d9079b          	addiw	a5,s2,-99
 710:	0ff7f793          	zext.b	a5,a5
 714:	10fc6e63          	bltu	s8,a5,830 <vprintf+0x19e>
 718:	f9d9079b          	addiw	a5,s2,-99
 71c:	0ff7f713          	zext.b	a4,a5
 720:	10ec6863          	bltu	s8,a4,830 <vprintf+0x19e>
 724:	00271793          	slli	a5,a4,0x2
 728:	97e6                	add	a5,a5,s9
 72a:	439c                	lw	a5,0(a5)
 72c:	97e6                	add	a5,a5,s9
 72e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 730:	008b0913          	addi	s2,s6,8
 734:	4685                	li	a3,1
 736:	4629                	li	a2,10
 738:	000b2583          	lw	a1,0(s6)
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	ea8080e7          	jalr	-344(ra) # 5e6 <printint>
 746:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 748:	4981                	li	s3,0
 74a:	b765                	j	6f2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 74c:	008b0913          	addi	s2,s6,8
 750:	4681                	li	a3,0
 752:	4629                	li	a2,10
 754:	000b2583          	lw	a1,0(s6)
 758:	8556                	mv	a0,s5
 75a:	00000097          	auipc	ra,0x0
 75e:	e8c080e7          	jalr	-372(ra) # 5e6 <printint>
 762:	8b4a                	mv	s6,s2
      state = 0;
 764:	4981                	li	s3,0
 766:	b771                	j	6f2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 768:	008b0913          	addi	s2,s6,8
 76c:	4681                	li	a3,0
 76e:	866a                	mv	a2,s10
 770:	000b2583          	lw	a1,0(s6)
 774:	8556                	mv	a0,s5
 776:	00000097          	auipc	ra,0x0
 77a:	e70080e7          	jalr	-400(ra) # 5e6 <printint>
 77e:	8b4a                	mv	s6,s2
      state = 0;
 780:	4981                	li	s3,0
 782:	bf85                	j	6f2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 784:	008b0793          	addi	a5,s6,8
 788:	f8f43423          	sd	a5,-120(s0)
 78c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 790:	03000593          	li	a1,48
 794:	8556                	mv	a0,s5
 796:	00000097          	auipc	ra,0x0
 79a:	e2e080e7          	jalr	-466(ra) # 5c4 <putc>
  putc(fd, 'x');
 79e:	07800593          	li	a1,120
 7a2:	8556                	mv	a0,s5
 7a4:	00000097          	auipc	ra,0x0
 7a8:	e20080e7          	jalr	-480(ra) # 5c4 <putc>
 7ac:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7ae:	03c9d793          	srli	a5,s3,0x3c
 7b2:	97de                	add	a5,a5,s7
 7b4:	0007c583          	lbu	a1,0(a5)
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	e0a080e7          	jalr	-502(ra) # 5c4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7c2:	0992                	slli	s3,s3,0x4
 7c4:	397d                	addiw	s2,s2,-1
 7c6:	fe0914e3          	bnez	s2,7ae <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 7ca:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	b70d                	j	6f2 <vprintf+0x60>
        s = va_arg(ap, char*);
 7d2:	008b0913          	addi	s2,s6,8
 7d6:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 7da:	02098163          	beqz	s3,7fc <vprintf+0x16a>
        while(*s != 0){
 7de:	0009c583          	lbu	a1,0(s3)
 7e2:	c5ad                	beqz	a1,84c <vprintf+0x1ba>
          putc(fd, *s);
 7e4:	8556                	mv	a0,s5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	dde080e7          	jalr	-546(ra) # 5c4 <putc>
          s++;
 7ee:	0985                	addi	s3,s3,1
        while(*s != 0){
 7f0:	0009c583          	lbu	a1,0(s3)
 7f4:	f9e5                	bnez	a1,7e4 <vprintf+0x152>
        s = va_arg(ap, char*);
 7f6:	8b4a                	mv	s6,s2
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	bde5                	j	6f2 <vprintf+0x60>
          s = "(null)";
 7fc:	00000997          	auipc	s3,0x0
 800:	2bc98993          	addi	s3,s3,700 # ab8 <malloc+0x162>
        while(*s != 0){
 804:	85ee                	mv	a1,s11
 806:	bff9                	j	7e4 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 808:	008b0913          	addi	s2,s6,8
 80c:	000b4583          	lbu	a1,0(s6)
 810:	8556                	mv	a0,s5
 812:	00000097          	auipc	ra,0x0
 816:	db2080e7          	jalr	-590(ra) # 5c4 <putc>
 81a:	8b4a                	mv	s6,s2
      state = 0;
 81c:	4981                	li	s3,0
 81e:	bdd1                	j	6f2 <vprintf+0x60>
        putc(fd, c);
 820:	85d2                	mv	a1,s4
 822:	8556                	mv	a0,s5
 824:	00000097          	auipc	ra,0x0
 828:	da0080e7          	jalr	-608(ra) # 5c4 <putc>
      state = 0;
 82c:	4981                	li	s3,0
 82e:	b5d1                	j	6f2 <vprintf+0x60>
        putc(fd, '%');
 830:	85d2                	mv	a1,s4
 832:	8556                	mv	a0,s5
 834:	00000097          	auipc	ra,0x0
 838:	d90080e7          	jalr	-624(ra) # 5c4 <putc>
        putc(fd, c);
 83c:	85ca                	mv	a1,s2
 83e:	8556                	mv	a0,s5
 840:	00000097          	auipc	ra,0x0
 844:	d84080e7          	jalr	-636(ra) # 5c4 <putc>
      state = 0;
 848:	4981                	li	s3,0
 84a:	b565                	j	6f2 <vprintf+0x60>
        s = va_arg(ap, char*);
 84c:	8b4a                	mv	s6,s2
      state = 0;
 84e:	4981                	li	s3,0
 850:	b54d                	j	6f2 <vprintf+0x60>
    }
  }
}
 852:	70e6                	ld	ra,120(sp)
 854:	7446                	ld	s0,112(sp)
 856:	74a6                	ld	s1,104(sp)
 858:	7906                	ld	s2,96(sp)
 85a:	69e6                	ld	s3,88(sp)
 85c:	6a46                	ld	s4,80(sp)
 85e:	6aa6                	ld	s5,72(sp)
 860:	6b06                	ld	s6,64(sp)
 862:	7be2                	ld	s7,56(sp)
 864:	7c42                	ld	s8,48(sp)
 866:	7ca2                	ld	s9,40(sp)
 868:	7d02                	ld	s10,32(sp)
 86a:	6de2                	ld	s11,24(sp)
 86c:	6109                	addi	sp,sp,128
 86e:	8082                	ret

0000000000000870 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 870:	715d                	addi	sp,sp,-80
 872:	ec06                	sd	ra,24(sp)
 874:	e822                	sd	s0,16(sp)
 876:	1000                	addi	s0,sp,32
 878:	e010                	sd	a2,0(s0)
 87a:	e414                	sd	a3,8(s0)
 87c:	e818                	sd	a4,16(s0)
 87e:	ec1c                	sd	a5,24(s0)
 880:	03043023          	sd	a6,32(s0)
 884:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 888:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 88c:	8622                	mv	a2,s0
 88e:	00000097          	auipc	ra,0x0
 892:	e04080e7          	jalr	-508(ra) # 692 <vprintf>
}
 896:	60e2                	ld	ra,24(sp)
 898:	6442                	ld	s0,16(sp)
 89a:	6161                	addi	sp,sp,80
 89c:	8082                	ret

000000000000089e <printf>:

void
printf(const char *fmt, ...)
{
 89e:	711d                	addi	sp,sp,-96
 8a0:	ec06                	sd	ra,24(sp)
 8a2:	e822                	sd	s0,16(sp)
 8a4:	1000                	addi	s0,sp,32
 8a6:	e40c                	sd	a1,8(s0)
 8a8:	e810                	sd	a2,16(s0)
 8aa:	ec14                	sd	a3,24(s0)
 8ac:	f018                	sd	a4,32(s0)
 8ae:	f41c                	sd	a5,40(s0)
 8b0:	03043823          	sd	a6,48(s0)
 8b4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8b8:	00840613          	addi	a2,s0,8
 8bc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8c0:	85aa                	mv	a1,a0
 8c2:	4505                	li	a0,1
 8c4:	00000097          	auipc	ra,0x0
 8c8:	dce080e7          	jalr	-562(ra) # 692 <vprintf>
}
 8cc:	60e2                	ld	ra,24(sp)
 8ce:	6442                	ld	s0,16(sp)
 8d0:	6125                	addi	sp,sp,96
 8d2:	8082                	ret

00000000000008d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d4:	1141                	addi	sp,sp,-16
 8d6:	e422                	sd	s0,8(sp)
 8d8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8da:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8de:	00000797          	auipc	a5,0x0
 8e2:	7227b783          	ld	a5,1826(a5) # 1000 <freep>
 8e6:	a02d                	j	910 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8e8:	4618                	lw	a4,8(a2)
 8ea:	9f2d                	addw	a4,a4,a1
 8ec:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f0:	6398                	ld	a4,0(a5)
 8f2:	6310                	ld	a2,0(a4)
 8f4:	a83d                	j	932 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8f6:	ff852703          	lw	a4,-8(a0)
 8fa:	9f31                	addw	a4,a4,a2
 8fc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8fe:	ff053683          	ld	a3,-16(a0)
 902:	a091                	j	946 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 904:	6398                	ld	a4,0(a5)
 906:	00e7e463          	bltu	a5,a4,90e <free+0x3a>
 90a:	00e6ea63          	bltu	a3,a4,91e <free+0x4a>
{
 90e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 910:	fed7fae3          	bgeu	a5,a3,904 <free+0x30>
 914:	6398                	ld	a4,0(a5)
 916:	00e6e463          	bltu	a3,a4,91e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91a:	fee7eae3          	bltu	a5,a4,90e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 91e:	ff852583          	lw	a1,-8(a0)
 922:	6390                	ld	a2,0(a5)
 924:	02059813          	slli	a6,a1,0x20
 928:	01c85713          	srli	a4,a6,0x1c
 92c:	9736                	add	a4,a4,a3
 92e:	fae60de3          	beq	a2,a4,8e8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 932:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 936:	4790                	lw	a2,8(a5)
 938:	02061593          	slli	a1,a2,0x20
 93c:	01c5d713          	srli	a4,a1,0x1c
 940:	973e                	add	a4,a4,a5
 942:	fae68ae3          	beq	a3,a4,8f6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 946:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 948:	00000717          	auipc	a4,0x0
 94c:	6af73c23          	sd	a5,1720(a4) # 1000 <freep>
}
 950:	6422                	ld	s0,8(sp)
 952:	0141                	addi	sp,sp,16
 954:	8082                	ret

0000000000000956 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 956:	7139                	addi	sp,sp,-64
 958:	fc06                	sd	ra,56(sp)
 95a:	f822                	sd	s0,48(sp)
 95c:	f426                	sd	s1,40(sp)
 95e:	f04a                	sd	s2,32(sp)
 960:	ec4e                	sd	s3,24(sp)
 962:	e852                	sd	s4,16(sp)
 964:	e456                	sd	s5,8(sp)
 966:	e05a                	sd	s6,0(sp)
 968:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 96a:	02051493          	slli	s1,a0,0x20
 96e:	9081                	srli	s1,s1,0x20
 970:	04bd                	addi	s1,s1,15
 972:	8091                	srli	s1,s1,0x4
 974:	0014899b          	addiw	s3,s1,1
 978:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 97a:	00000517          	auipc	a0,0x0
 97e:	68653503          	ld	a0,1670(a0) # 1000 <freep>
 982:	c515                	beqz	a0,9ae <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 984:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 986:	4798                	lw	a4,8(a5)
 988:	02977f63          	bgeu	a4,s1,9c6 <malloc+0x70>
 98c:	8a4e                	mv	s4,s3
 98e:	0009871b          	sext.w	a4,s3
 992:	6685                	lui	a3,0x1
 994:	00d77363          	bgeu	a4,a3,99a <malloc+0x44>
 998:	6a05                	lui	s4,0x1
 99a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 99e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9a2:	00000917          	auipc	s2,0x0
 9a6:	65e90913          	addi	s2,s2,1630 # 1000 <freep>
  if(p == (char*)-1)
 9aa:	5afd                	li	s5,-1
 9ac:	a895                	j	a20 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9ae:	00000797          	auipc	a5,0x0
 9b2:	67278793          	addi	a5,a5,1650 # 1020 <base>
 9b6:	00000717          	auipc	a4,0x0
 9ba:	64f73523          	sd	a5,1610(a4) # 1000 <freep>
 9be:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9c0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9c4:	b7e1                	j	98c <malloc+0x36>
      if(p->s.size == nunits)
 9c6:	02e48c63          	beq	s1,a4,9fe <malloc+0xa8>
        p->s.size -= nunits;
 9ca:	4137073b          	subw	a4,a4,s3
 9ce:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9d0:	02071693          	slli	a3,a4,0x20
 9d4:	01c6d713          	srli	a4,a3,0x1c
 9d8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9da:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9de:	00000717          	auipc	a4,0x0
 9e2:	62a73123          	sd	a0,1570(a4) # 1000 <freep>
      return (void*)(p + 1);
 9e6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9ea:	70e2                	ld	ra,56(sp)
 9ec:	7442                	ld	s0,48(sp)
 9ee:	74a2                	ld	s1,40(sp)
 9f0:	7902                	ld	s2,32(sp)
 9f2:	69e2                	ld	s3,24(sp)
 9f4:	6a42                	ld	s4,16(sp)
 9f6:	6aa2                	ld	s5,8(sp)
 9f8:	6b02                	ld	s6,0(sp)
 9fa:	6121                	addi	sp,sp,64
 9fc:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9fe:	6398                	ld	a4,0(a5)
 a00:	e118                	sd	a4,0(a0)
 a02:	bff1                	j	9de <malloc+0x88>
  hp->s.size = nu;
 a04:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a08:	0541                	addi	a0,a0,16
 a0a:	00000097          	auipc	ra,0x0
 a0e:	eca080e7          	jalr	-310(ra) # 8d4 <free>
  return freep;
 a12:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a16:	d971                	beqz	a0,9ea <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a18:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a1a:	4798                	lw	a4,8(a5)
 a1c:	fa9775e3          	bgeu	a4,s1,9c6 <malloc+0x70>
    if(p == freep)
 a20:	00093703          	ld	a4,0(s2)
 a24:	853e                	mv	a0,a5
 a26:	fef719e3          	bne	a4,a5,a18 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a2a:	8552                	mv	a0,s4
 a2c:	00000097          	auipc	ra,0x0
 a30:	b80080e7          	jalr	-1152(ra) # 5ac <sbrk>
  if(p == (char*)-1)
 a34:	fd5518e3          	bne	a0,s5,a04 <malloc+0xae>
        return 0;
 a38:	4501                	li	a0,0
 a3a:	bf45                	j	9ea <malloc+0x94>
