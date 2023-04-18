
user/_sleep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

// 实现调用system call sleep()
// 当shell调用sleep()，却无后续参数时报错
// 正确调用时执行sleep()并通过exit()返回
int main(int argc, char* argv[])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(argc < 2) {
   8:	4785                	li	a5,1
   a:	02a7d063          	bge	a5,a0,2a <main+0x2a>
    char* errorStr = "sleep parameters error\n";
    write(1, errorStr, strlen(errorStr));
    exit(1);
  }
  sleep(atoi(argv[1]));
   e:	6588                	ld	a0,8(a1)
  10:	00000097          	auipc	ra,0x0
  14:	1d6080e7          	jalr	470(ra) # 1e6 <atoi>
  18:	00000097          	auipc	ra,0x0
  1c:	358080e7          	jalr	856(ra) # 370 <sleep>

  exit(0);
  20:	4501                	li	a0,0
  22:	00000097          	auipc	ra,0x0
  26:	2be080e7          	jalr	702(ra) # 2e0 <exit>
    write(1, errorStr, strlen(errorStr));
  2a:	00000517          	auipc	a0,0x0
  2e:	7d650513          	addi	a0,a0,2006 # 800 <malloc+0xee>
  32:	00000097          	auipc	ra,0x0
  36:	08a080e7          	jalr	138(ra) # bc <strlen>
  3a:	0005061b          	sext.w	a2,a0
  3e:	00000597          	auipc	a1,0x0
  42:	7c258593          	addi	a1,a1,1986 # 800 <malloc+0xee>
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	2b8080e7          	jalr	696(ra) # 300 <write>
    exit(1);
  50:	4505                	li	a0,1
  52:	00000097          	auipc	ra,0x0
  56:	28e080e7          	jalr	654(ra) # 2e0 <exit>

000000000000005a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  5a:	1141                	addi	sp,sp,-16
  5c:	e406                	sd	ra,8(sp)
  5e:	e022                	sd	s0,0(sp)
  60:	0800                	addi	s0,sp,16
  extern int main();
  main();
  62:	00000097          	auipc	ra,0x0
  66:	f9e080e7          	jalr	-98(ra) # 0 <main>
  exit(0);
  6a:	4501                	li	a0,0
  6c:	00000097          	auipc	ra,0x0
  70:	274080e7          	jalr	628(ra) # 2e0 <exit>

0000000000000074 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  74:	1141                	addi	sp,sp,-16
  76:	e422                	sd	s0,8(sp)
  78:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	87aa                	mv	a5,a0
  7c:	0585                	addi	a1,a1,1
  7e:	0785                	addi	a5,a5,1
  80:	fff5c703          	lbu	a4,-1(a1)
  84:	fee78fa3          	sb	a4,-1(a5)
  88:	fb75                	bnez	a4,7c <strcpy+0x8>
    ;
  return os;
}
  8a:	6422                	ld	s0,8(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret

0000000000000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	1141                	addi	sp,sp,-16
  92:	e422                	sd	s0,8(sp)
  94:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  96:	00054783          	lbu	a5,0(a0)
  9a:	cb91                	beqz	a5,ae <strcmp+0x1e>
  9c:	0005c703          	lbu	a4,0(a1)
  a0:	00f71763          	bne	a4,a5,ae <strcmp+0x1e>
    p++, q++;
  a4:	0505                	addi	a0,a0,1
  a6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  a8:	00054783          	lbu	a5,0(a0)
  ac:	fbe5                	bnez	a5,9c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  ae:	0005c503          	lbu	a0,0(a1)
}
  b2:	40a7853b          	subw	a0,a5,a0
  b6:	6422                	ld	s0,8(sp)
  b8:	0141                	addi	sp,sp,16
  ba:	8082                	ret

00000000000000bc <strlen>:

uint
strlen(const char *s)
{
  bc:	1141                	addi	sp,sp,-16
  be:	e422                	sd	s0,8(sp)
  c0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c2:	00054783          	lbu	a5,0(a0)
  c6:	cf91                	beqz	a5,e2 <strlen+0x26>
  c8:	0505                	addi	a0,a0,1
  ca:	87aa                	mv	a5,a0
  cc:	4685                	li	a3,1
  ce:	9e89                	subw	a3,a3,a0
  d0:	00f6853b          	addw	a0,a3,a5
  d4:	0785                	addi	a5,a5,1
  d6:	fff7c703          	lbu	a4,-1(a5)
  da:	fb7d                	bnez	a4,d0 <strlen+0x14>
    ;
  return n;
}
  dc:	6422                	ld	s0,8(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret
  for(n = 0; s[n]; n++)
  e2:	4501                	li	a0,0
  e4:	bfe5                	j	dc <strlen+0x20>

00000000000000e6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ec:	ca19                	beqz	a2,102 <memset+0x1c>
  ee:	87aa                	mv	a5,a0
  f0:	1602                	slli	a2,a2,0x20
  f2:	9201                	srli	a2,a2,0x20
  f4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  f8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  fc:	0785                	addi	a5,a5,1
  fe:	fee79de3          	bne	a5,a4,f8 <memset+0x12>
  }
  return dst;
}
 102:	6422                	ld	s0,8(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret

0000000000000108 <strchr>:

char*
strchr(const char *s, char c)
{
 108:	1141                	addi	sp,sp,-16
 10a:	e422                	sd	s0,8(sp)
 10c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 10e:	00054783          	lbu	a5,0(a0)
 112:	cb99                	beqz	a5,128 <strchr+0x20>
    if(*s == c)
 114:	00f58763          	beq	a1,a5,122 <strchr+0x1a>
  for(; *s; s++)
 118:	0505                	addi	a0,a0,1
 11a:	00054783          	lbu	a5,0(a0)
 11e:	fbfd                	bnez	a5,114 <strchr+0xc>
      return (char*)s;
  return 0;
 120:	4501                	li	a0,0
}
 122:	6422                	ld	s0,8(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret
  return 0;
 128:	4501                	li	a0,0
 12a:	bfe5                	j	122 <strchr+0x1a>

000000000000012c <gets>:

char*
gets(char *buf, int max)
{
 12c:	711d                	addi	sp,sp,-96
 12e:	ec86                	sd	ra,88(sp)
 130:	e8a2                	sd	s0,80(sp)
 132:	e4a6                	sd	s1,72(sp)
 134:	e0ca                	sd	s2,64(sp)
 136:	fc4e                	sd	s3,56(sp)
 138:	f852                	sd	s4,48(sp)
 13a:	f456                	sd	s5,40(sp)
 13c:	f05a                	sd	s6,32(sp)
 13e:	ec5e                	sd	s7,24(sp)
 140:	1080                	addi	s0,sp,96
 142:	8baa                	mv	s7,a0
 144:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 146:	892a                	mv	s2,a0
 148:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14a:	4aa9                	li	s5,10
 14c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 14e:	89a6                	mv	s3,s1
 150:	2485                	addiw	s1,s1,1
 152:	0344d863          	bge	s1,s4,182 <gets+0x56>
    cc = read(0, &c, 1);
 156:	4605                	li	a2,1
 158:	faf40593          	addi	a1,s0,-81
 15c:	4501                	li	a0,0
 15e:	00000097          	auipc	ra,0x0
 162:	19a080e7          	jalr	410(ra) # 2f8 <read>
    if(cc < 1)
 166:	00a05e63          	blez	a0,182 <gets+0x56>
    buf[i++] = c;
 16a:	faf44783          	lbu	a5,-81(s0)
 16e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 172:	01578763          	beq	a5,s5,180 <gets+0x54>
 176:	0905                	addi	s2,s2,1
 178:	fd679be3          	bne	a5,s6,14e <gets+0x22>
  for(i=0; i+1 < max; ){
 17c:	89a6                	mv	s3,s1
 17e:	a011                	j	182 <gets+0x56>
 180:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 182:	99de                	add	s3,s3,s7
 184:	00098023          	sb	zero,0(s3)
  return buf;
}
 188:	855e                	mv	a0,s7
 18a:	60e6                	ld	ra,88(sp)
 18c:	6446                	ld	s0,80(sp)
 18e:	64a6                	ld	s1,72(sp)
 190:	6906                	ld	s2,64(sp)
 192:	79e2                	ld	s3,56(sp)
 194:	7a42                	ld	s4,48(sp)
 196:	7aa2                	ld	s5,40(sp)
 198:	7b02                	ld	s6,32(sp)
 19a:	6be2                	ld	s7,24(sp)
 19c:	6125                	addi	sp,sp,96
 19e:	8082                	ret

00000000000001a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a0:	1101                	addi	sp,sp,-32
 1a2:	ec06                	sd	ra,24(sp)
 1a4:	e822                	sd	s0,16(sp)
 1a6:	e426                	sd	s1,8(sp)
 1a8:	e04a                	sd	s2,0(sp)
 1aa:	1000                	addi	s0,sp,32
 1ac:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ae:	4581                	li	a1,0
 1b0:	00000097          	auipc	ra,0x0
 1b4:	170080e7          	jalr	368(ra) # 320 <open>
  if(fd < 0)
 1b8:	02054563          	bltz	a0,1e2 <stat+0x42>
 1bc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1be:	85ca                	mv	a1,s2
 1c0:	00000097          	auipc	ra,0x0
 1c4:	178080e7          	jalr	376(ra) # 338 <fstat>
 1c8:	892a                	mv	s2,a0
  close(fd);
 1ca:	8526                	mv	a0,s1
 1cc:	00000097          	auipc	ra,0x0
 1d0:	13c080e7          	jalr	316(ra) # 308 <close>
  return r;
}
 1d4:	854a                	mv	a0,s2
 1d6:	60e2                	ld	ra,24(sp)
 1d8:	6442                	ld	s0,16(sp)
 1da:	64a2                	ld	s1,8(sp)
 1dc:	6902                	ld	s2,0(sp)
 1de:	6105                	addi	sp,sp,32
 1e0:	8082                	ret
    return -1;
 1e2:	597d                	li	s2,-1
 1e4:	bfc5                	j	1d4 <stat+0x34>

00000000000001e6 <atoi>:

int
atoi(const char *s)
{
 1e6:	1141                	addi	sp,sp,-16
 1e8:	e422                	sd	s0,8(sp)
 1ea:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ec:	00054683          	lbu	a3,0(a0)
 1f0:	fd06879b          	addiw	a5,a3,-48
 1f4:	0ff7f793          	zext.b	a5,a5
 1f8:	4625                	li	a2,9
 1fa:	02f66863          	bltu	a2,a5,22a <atoi+0x44>
 1fe:	872a                	mv	a4,a0
  n = 0;
 200:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 202:	0705                	addi	a4,a4,1
 204:	0025179b          	slliw	a5,a0,0x2
 208:	9fa9                	addw	a5,a5,a0
 20a:	0017979b          	slliw	a5,a5,0x1
 20e:	9fb5                	addw	a5,a5,a3
 210:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 214:	00074683          	lbu	a3,0(a4)
 218:	fd06879b          	addiw	a5,a3,-48
 21c:	0ff7f793          	zext.b	a5,a5
 220:	fef671e3          	bgeu	a2,a5,202 <atoi+0x1c>
  return n;
}
 224:	6422                	ld	s0,8(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret
  n = 0;
 22a:	4501                	li	a0,0
 22c:	bfe5                	j	224 <atoi+0x3e>

000000000000022e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 234:	02b57463          	bgeu	a0,a1,25c <memmove+0x2e>
    while(n-- > 0)
 238:	00c05f63          	blez	a2,256 <memmove+0x28>
 23c:	1602                	slli	a2,a2,0x20
 23e:	9201                	srli	a2,a2,0x20
 240:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 244:	872a                	mv	a4,a0
      *dst++ = *src++;
 246:	0585                	addi	a1,a1,1
 248:	0705                	addi	a4,a4,1
 24a:	fff5c683          	lbu	a3,-1(a1)
 24e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 252:	fee79ae3          	bne	a5,a4,246 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret
    dst += n;
 25c:	00c50733          	add	a4,a0,a2
    src += n;
 260:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 262:	fec05ae3          	blez	a2,256 <memmove+0x28>
 266:	fff6079b          	addiw	a5,a2,-1
 26a:	1782                	slli	a5,a5,0x20
 26c:	9381                	srli	a5,a5,0x20
 26e:	fff7c793          	not	a5,a5
 272:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 274:	15fd                	addi	a1,a1,-1
 276:	177d                	addi	a4,a4,-1
 278:	0005c683          	lbu	a3,0(a1)
 27c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 280:	fee79ae3          	bne	a5,a4,274 <memmove+0x46>
 284:	bfc9                	j	256 <memmove+0x28>

0000000000000286 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 286:	1141                	addi	sp,sp,-16
 288:	e422                	sd	s0,8(sp)
 28a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 28c:	ca05                	beqz	a2,2bc <memcmp+0x36>
 28e:	fff6069b          	addiw	a3,a2,-1
 292:	1682                	slli	a3,a3,0x20
 294:	9281                	srli	a3,a3,0x20
 296:	0685                	addi	a3,a3,1
 298:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 29a:	00054783          	lbu	a5,0(a0)
 29e:	0005c703          	lbu	a4,0(a1)
 2a2:	00e79863          	bne	a5,a4,2b2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2a6:	0505                	addi	a0,a0,1
    p2++;
 2a8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2aa:	fed518e3          	bne	a0,a3,29a <memcmp+0x14>
  }
  return 0;
 2ae:	4501                	li	a0,0
 2b0:	a019                	j	2b6 <memcmp+0x30>
      return *p1 - *p2;
 2b2:	40e7853b          	subw	a0,a5,a4
}
 2b6:	6422                	ld	s0,8(sp)
 2b8:	0141                	addi	sp,sp,16
 2ba:	8082                	ret
  return 0;
 2bc:	4501                	li	a0,0
 2be:	bfe5                	j	2b6 <memcmp+0x30>

00000000000002c0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c0:	1141                	addi	sp,sp,-16
 2c2:	e406                	sd	ra,8(sp)
 2c4:	e022                	sd	s0,0(sp)
 2c6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2c8:	00000097          	auipc	ra,0x0
 2cc:	f66080e7          	jalr	-154(ra) # 22e <memmove>
}
 2d0:	60a2                	ld	ra,8(sp)
 2d2:	6402                	ld	s0,0(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret

00000000000002d8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2d8:	4885                	li	a7,1
 ecall
 2da:	00000073          	ecall
 ret
 2de:	8082                	ret

00000000000002e0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2e0:	4889                	li	a7,2
 ecall
 2e2:	00000073          	ecall
 ret
 2e6:	8082                	ret

00000000000002e8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2e8:	488d                	li	a7,3
 ecall
 2ea:	00000073          	ecall
 ret
 2ee:	8082                	ret

00000000000002f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2f0:	4891                	li	a7,4
 ecall
 2f2:	00000073          	ecall
 ret
 2f6:	8082                	ret

00000000000002f8 <read>:
.global read
read:
 li a7, SYS_read
 2f8:	4895                	li	a7,5
 ecall
 2fa:	00000073          	ecall
 ret
 2fe:	8082                	ret

0000000000000300 <write>:
.global write
write:
 li a7, SYS_write
 300:	48c1                	li	a7,16
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <close>:
.global close
close:
 li a7, SYS_close
 308:	48d5                	li	a7,21
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <kill>:
.global kill
kill:
 li a7, SYS_kill
 310:	4899                	li	a7,6
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <exec>:
.global exec
exec:
 li a7, SYS_exec
 318:	489d                	li	a7,7
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <open>:
.global open
open:
 li a7, SYS_open
 320:	48bd                	li	a7,15
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 328:	48c5                	li	a7,17
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 330:	48c9                	li	a7,18
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 338:	48a1                	li	a7,8
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <link>:
.global link
link:
 li a7, SYS_link
 340:	48cd                	li	a7,19
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 348:	48d1                	li	a7,20
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 350:	48a5                	li	a7,9
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <dup>:
.global dup
dup:
 li a7, SYS_dup
 358:	48a9                	li	a7,10
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 360:	48ad                	li	a7,11
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 368:	48b1                	li	a7,12
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 370:	48b5                	li	a7,13
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 378:	48b9                	li	a7,14
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 380:	1101                	addi	sp,sp,-32
 382:	ec06                	sd	ra,24(sp)
 384:	e822                	sd	s0,16(sp)
 386:	1000                	addi	s0,sp,32
 388:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 38c:	4605                	li	a2,1
 38e:	fef40593          	addi	a1,s0,-17
 392:	00000097          	auipc	ra,0x0
 396:	f6e080e7          	jalr	-146(ra) # 300 <write>
}
 39a:	60e2                	ld	ra,24(sp)
 39c:	6442                	ld	s0,16(sp)
 39e:	6105                	addi	sp,sp,32
 3a0:	8082                	ret

00000000000003a2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3a2:	7139                	addi	sp,sp,-64
 3a4:	fc06                	sd	ra,56(sp)
 3a6:	f822                	sd	s0,48(sp)
 3a8:	f426                	sd	s1,40(sp)
 3aa:	f04a                	sd	s2,32(sp)
 3ac:	ec4e                	sd	s3,24(sp)
 3ae:	0080                	addi	s0,sp,64
 3b0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b2:	c299                	beqz	a3,3b8 <printint+0x16>
 3b4:	0805c963          	bltz	a1,446 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3b8:	2581                	sext.w	a1,a1
  neg = 0;
 3ba:	4881                	li	a7,0
 3bc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3c0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3c2:	2601                	sext.w	a2,a2
 3c4:	00000517          	auipc	a0,0x0
 3c8:	4b450513          	addi	a0,a0,1204 # 878 <digits>
 3cc:	883a                	mv	a6,a4
 3ce:	2705                	addiw	a4,a4,1
 3d0:	02c5f7bb          	remuw	a5,a1,a2
 3d4:	1782                	slli	a5,a5,0x20
 3d6:	9381                	srli	a5,a5,0x20
 3d8:	97aa                	add	a5,a5,a0
 3da:	0007c783          	lbu	a5,0(a5)
 3de:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3e2:	0005879b          	sext.w	a5,a1
 3e6:	02c5d5bb          	divuw	a1,a1,a2
 3ea:	0685                	addi	a3,a3,1
 3ec:	fec7f0e3          	bgeu	a5,a2,3cc <printint+0x2a>
  if(neg)
 3f0:	00088c63          	beqz	a7,408 <printint+0x66>
    buf[i++] = '-';
 3f4:	fd070793          	addi	a5,a4,-48
 3f8:	00878733          	add	a4,a5,s0
 3fc:	02d00793          	li	a5,45
 400:	fef70823          	sb	a5,-16(a4)
 404:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 408:	02e05863          	blez	a4,438 <printint+0x96>
 40c:	fc040793          	addi	a5,s0,-64
 410:	00e78933          	add	s2,a5,a4
 414:	fff78993          	addi	s3,a5,-1
 418:	99ba                	add	s3,s3,a4
 41a:	377d                	addiw	a4,a4,-1
 41c:	1702                	slli	a4,a4,0x20
 41e:	9301                	srli	a4,a4,0x20
 420:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 424:	fff94583          	lbu	a1,-1(s2)
 428:	8526                	mv	a0,s1
 42a:	00000097          	auipc	ra,0x0
 42e:	f56080e7          	jalr	-170(ra) # 380 <putc>
  while(--i >= 0)
 432:	197d                	addi	s2,s2,-1
 434:	ff3918e3          	bne	s2,s3,424 <printint+0x82>
}
 438:	70e2                	ld	ra,56(sp)
 43a:	7442                	ld	s0,48(sp)
 43c:	74a2                	ld	s1,40(sp)
 43e:	7902                	ld	s2,32(sp)
 440:	69e2                	ld	s3,24(sp)
 442:	6121                	addi	sp,sp,64
 444:	8082                	ret
    x = -xx;
 446:	40b005bb          	negw	a1,a1
    neg = 1;
 44a:	4885                	li	a7,1
    x = -xx;
 44c:	bf85                	j	3bc <printint+0x1a>

000000000000044e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 44e:	7119                	addi	sp,sp,-128
 450:	fc86                	sd	ra,120(sp)
 452:	f8a2                	sd	s0,112(sp)
 454:	f4a6                	sd	s1,104(sp)
 456:	f0ca                	sd	s2,96(sp)
 458:	ecce                	sd	s3,88(sp)
 45a:	e8d2                	sd	s4,80(sp)
 45c:	e4d6                	sd	s5,72(sp)
 45e:	e0da                	sd	s6,64(sp)
 460:	fc5e                	sd	s7,56(sp)
 462:	f862                	sd	s8,48(sp)
 464:	f466                	sd	s9,40(sp)
 466:	f06a                	sd	s10,32(sp)
 468:	ec6e                	sd	s11,24(sp)
 46a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 46c:	0005c903          	lbu	s2,0(a1)
 470:	18090f63          	beqz	s2,60e <vprintf+0x1c0>
 474:	8aaa                	mv	s5,a0
 476:	8b32                	mv	s6,a2
 478:	00158493          	addi	s1,a1,1
  state = 0;
 47c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 47e:	02500a13          	li	s4,37
 482:	4c55                	li	s8,21
 484:	00000c97          	auipc	s9,0x0
 488:	39cc8c93          	addi	s9,s9,924 # 820 <malloc+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 48c:	02800d93          	li	s11,40
  putc(fd, 'x');
 490:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 492:	00000b97          	auipc	s7,0x0
 496:	3e6b8b93          	addi	s7,s7,998 # 878 <digits>
 49a:	a839                	j	4b8 <vprintf+0x6a>
        putc(fd, c);
 49c:	85ca                	mv	a1,s2
 49e:	8556                	mv	a0,s5
 4a0:	00000097          	auipc	ra,0x0
 4a4:	ee0080e7          	jalr	-288(ra) # 380 <putc>
 4a8:	a019                	j	4ae <vprintf+0x60>
    } else if(state == '%'){
 4aa:	01498d63          	beq	s3,s4,4c4 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 4ae:	0485                	addi	s1,s1,1
 4b0:	fff4c903          	lbu	s2,-1(s1)
 4b4:	14090d63          	beqz	s2,60e <vprintf+0x1c0>
    if(state == 0){
 4b8:	fe0999e3          	bnez	s3,4aa <vprintf+0x5c>
      if(c == '%'){
 4bc:	ff4910e3          	bne	s2,s4,49c <vprintf+0x4e>
        state = '%';
 4c0:	89d2                	mv	s3,s4
 4c2:	b7f5                	j	4ae <vprintf+0x60>
      if(c == 'd'){
 4c4:	11490c63          	beq	s2,s4,5dc <vprintf+0x18e>
 4c8:	f9d9079b          	addiw	a5,s2,-99
 4cc:	0ff7f793          	zext.b	a5,a5
 4d0:	10fc6e63          	bltu	s8,a5,5ec <vprintf+0x19e>
 4d4:	f9d9079b          	addiw	a5,s2,-99
 4d8:	0ff7f713          	zext.b	a4,a5
 4dc:	10ec6863          	bltu	s8,a4,5ec <vprintf+0x19e>
 4e0:	00271793          	slli	a5,a4,0x2
 4e4:	97e6                	add	a5,a5,s9
 4e6:	439c                	lw	a5,0(a5)
 4e8:	97e6                	add	a5,a5,s9
 4ea:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 4ec:	008b0913          	addi	s2,s6,8
 4f0:	4685                	li	a3,1
 4f2:	4629                	li	a2,10
 4f4:	000b2583          	lw	a1,0(s6)
 4f8:	8556                	mv	a0,s5
 4fa:	00000097          	auipc	ra,0x0
 4fe:	ea8080e7          	jalr	-344(ra) # 3a2 <printint>
 502:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 504:	4981                	li	s3,0
 506:	b765                	j	4ae <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 508:	008b0913          	addi	s2,s6,8
 50c:	4681                	li	a3,0
 50e:	4629                	li	a2,10
 510:	000b2583          	lw	a1,0(s6)
 514:	8556                	mv	a0,s5
 516:	00000097          	auipc	ra,0x0
 51a:	e8c080e7          	jalr	-372(ra) # 3a2 <printint>
 51e:	8b4a                	mv	s6,s2
      state = 0;
 520:	4981                	li	s3,0
 522:	b771                	j	4ae <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 524:	008b0913          	addi	s2,s6,8
 528:	4681                	li	a3,0
 52a:	866a                	mv	a2,s10
 52c:	000b2583          	lw	a1,0(s6)
 530:	8556                	mv	a0,s5
 532:	00000097          	auipc	ra,0x0
 536:	e70080e7          	jalr	-400(ra) # 3a2 <printint>
 53a:	8b4a                	mv	s6,s2
      state = 0;
 53c:	4981                	li	s3,0
 53e:	bf85                	j	4ae <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 540:	008b0793          	addi	a5,s6,8
 544:	f8f43423          	sd	a5,-120(s0)
 548:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 54c:	03000593          	li	a1,48
 550:	8556                	mv	a0,s5
 552:	00000097          	auipc	ra,0x0
 556:	e2e080e7          	jalr	-466(ra) # 380 <putc>
  putc(fd, 'x');
 55a:	07800593          	li	a1,120
 55e:	8556                	mv	a0,s5
 560:	00000097          	auipc	ra,0x0
 564:	e20080e7          	jalr	-480(ra) # 380 <putc>
 568:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 56a:	03c9d793          	srli	a5,s3,0x3c
 56e:	97de                	add	a5,a5,s7
 570:	0007c583          	lbu	a1,0(a5)
 574:	8556                	mv	a0,s5
 576:	00000097          	auipc	ra,0x0
 57a:	e0a080e7          	jalr	-502(ra) # 380 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 57e:	0992                	slli	s3,s3,0x4
 580:	397d                	addiw	s2,s2,-1
 582:	fe0914e3          	bnez	s2,56a <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 586:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 58a:	4981                	li	s3,0
 58c:	b70d                	j	4ae <vprintf+0x60>
        s = va_arg(ap, char*);
 58e:	008b0913          	addi	s2,s6,8
 592:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 596:	02098163          	beqz	s3,5b8 <vprintf+0x16a>
        while(*s != 0){
 59a:	0009c583          	lbu	a1,0(s3)
 59e:	c5ad                	beqz	a1,608 <vprintf+0x1ba>
          putc(fd, *s);
 5a0:	8556                	mv	a0,s5
 5a2:	00000097          	auipc	ra,0x0
 5a6:	dde080e7          	jalr	-546(ra) # 380 <putc>
          s++;
 5aa:	0985                	addi	s3,s3,1
        while(*s != 0){
 5ac:	0009c583          	lbu	a1,0(s3)
 5b0:	f9e5                	bnez	a1,5a0 <vprintf+0x152>
        s = va_arg(ap, char*);
 5b2:	8b4a                	mv	s6,s2
      state = 0;
 5b4:	4981                	li	s3,0
 5b6:	bde5                	j	4ae <vprintf+0x60>
          s = "(null)";
 5b8:	00000997          	auipc	s3,0x0
 5bc:	26098993          	addi	s3,s3,608 # 818 <malloc+0x106>
        while(*s != 0){
 5c0:	85ee                	mv	a1,s11
 5c2:	bff9                	j	5a0 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 5c4:	008b0913          	addi	s2,s6,8
 5c8:	000b4583          	lbu	a1,0(s6)
 5cc:	8556                	mv	a0,s5
 5ce:	00000097          	auipc	ra,0x0
 5d2:	db2080e7          	jalr	-590(ra) # 380 <putc>
 5d6:	8b4a                	mv	s6,s2
      state = 0;
 5d8:	4981                	li	s3,0
 5da:	bdd1                	j	4ae <vprintf+0x60>
        putc(fd, c);
 5dc:	85d2                	mv	a1,s4
 5de:	8556                	mv	a0,s5
 5e0:	00000097          	auipc	ra,0x0
 5e4:	da0080e7          	jalr	-608(ra) # 380 <putc>
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	b5d1                	j	4ae <vprintf+0x60>
        putc(fd, '%');
 5ec:	85d2                	mv	a1,s4
 5ee:	8556                	mv	a0,s5
 5f0:	00000097          	auipc	ra,0x0
 5f4:	d90080e7          	jalr	-624(ra) # 380 <putc>
        putc(fd, c);
 5f8:	85ca                	mv	a1,s2
 5fa:	8556                	mv	a0,s5
 5fc:	00000097          	auipc	ra,0x0
 600:	d84080e7          	jalr	-636(ra) # 380 <putc>
      state = 0;
 604:	4981                	li	s3,0
 606:	b565                	j	4ae <vprintf+0x60>
        s = va_arg(ap, char*);
 608:	8b4a                	mv	s6,s2
      state = 0;
 60a:	4981                	li	s3,0
 60c:	b54d                	j	4ae <vprintf+0x60>
    }
  }
}
 60e:	70e6                	ld	ra,120(sp)
 610:	7446                	ld	s0,112(sp)
 612:	74a6                	ld	s1,104(sp)
 614:	7906                	ld	s2,96(sp)
 616:	69e6                	ld	s3,88(sp)
 618:	6a46                	ld	s4,80(sp)
 61a:	6aa6                	ld	s5,72(sp)
 61c:	6b06                	ld	s6,64(sp)
 61e:	7be2                	ld	s7,56(sp)
 620:	7c42                	ld	s8,48(sp)
 622:	7ca2                	ld	s9,40(sp)
 624:	7d02                	ld	s10,32(sp)
 626:	6de2                	ld	s11,24(sp)
 628:	6109                	addi	sp,sp,128
 62a:	8082                	ret

000000000000062c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 62c:	715d                	addi	sp,sp,-80
 62e:	ec06                	sd	ra,24(sp)
 630:	e822                	sd	s0,16(sp)
 632:	1000                	addi	s0,sp,32
 634:	e010                	sd	a2,0(s0)
 636:	e414                	sd	a3,8(s0)
 638:	e818                	sd	a4,16(s0)
 63a:	ec1c                	sd	a5,24(s0)
 63c:	03043023          	sd	a6,32(s0)
 640:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 644:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 648:	8622                	mv	a2,s0
 64a:	00000097          	auipc	ra,0x0
 64e:	e04080e7          	jalr	-508(ra) # 44e <vprintf>
}
 652:	60e2                	ld	ra,24(sp)
 654:	6442                	ld	s0,16(sp)
 656:	6161                	addi	sp,sp,80
 658:	8082                	ret

000000000000065a <printf>:

void
printf(const char *fmt, ...)
{
 65a:	711d                	addi	sp,sp,-96
 65c:	ec06                	sd	ra,24(sp)
 65e:	e822                	sd	s0,16(sp)
 660:	1000                	addi	s0,sp,32
 662:	e40c                	sd	a1,8(s0)
 664:	e810                	sd	a2,16(s0)
 666:	ec14                	sd	a3,24(s0)
 668:	f018                	sd	a4,32(s0)
 66a:	f41c                	sd	a5,40(s0)
 66c:	03043823          	sd	a6,48(s0)
 670:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 674:	00840613          	addi	a2,s0,8
 678:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 67c:	85aa                	mv	a1,a0
 67e:	4505                	li	a0,1
 680:	00000097          	auipc	ra,0x0
 684:	dce080e7          	jalr	-562(ra) # 44e <vprintf>
}
 688:	60e2                	ld	ra,24(sp)
 68a:	6442                	ld	s0,16(sp)
 68c:	6125                	addi	sp,sp,96
 68e:	8082                	ret

0000000000000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	1141                	addi	sp,sp,-16
 692:	e422                	sd	s0,8(sp)
 694:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 696:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69a:	00001797          	auipc	a5,0x1
 69e:	9667b783          	ld	a5,-1690(a5) # 1000 <freep>
 6a2:	a02d                	j	6cc <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6a4:	4618                	lw	a4,8(a2)
 6a6:	9f2d                	addw	a4,a4,a1
 6a8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ac:	6398                	ld	a4,0(a5)
 6ae:	6310                	ld	a2,0(a4)
 6b0:	a83d                	j	6ee <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6b2:	ff852703          	lw	a4,-8(a0)
 6b6:	9f31                	addw	a4,a4,a2
 6b8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6ba:	ff053683          	ld	a3,-16(a0)
 6be:	a091                	j	702 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c0:	6398                	ld	a4,0(a5)
 6c2:	00e7e463          	bltu	a5,a4,6ca <free+0x3a>
 6c6:	00e6ea63          	bltu	a3,a4,6da <free+0x4a>
{
 6ca:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6cc:	fed7fae3          	bgeu	a5,a3,6c0 <free+0x30>
 6d0:	6398                	ld	a4,0(a5)
 6d2:	00e6e463          	bltu	a3,a4,6da <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d6:	fee7eae3          	bltu	a5,a4,6ca <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 6da:	ff852583          	lw	a1,-8(a0)
 6de:	6390                	ld	a2,0(a5)
 6e0:	02059813          	slli	a6,a1,0x20
 6e4:	01c85713          	srli	a4,a6,0x1c
 6e8:	9736                	add	a4,a4,a3
 6ea:	fae60de3          	beq	a2,a4,6a4 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 6ee:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6f2:	4790                	lw	a2,8(a5)
 6f4:	02061593          	slli	a1,a2,0x20
 6f8:	01c5d713          	srli	a4,a1,0x1c
 6fc:	973e                	add	a4,a4,a5
 6fe:	fae68ae3          	beq	a3,a4,6b2 <free+0x22>
    p->s.ptr = bp->s.ptr;
 702:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 704:	00001717          	auipc	a4,0x1
 708:	8ef73e23          	sd	a5,-1796(a4) # 1000 <freep>
}
 70c:	6422                	ld	s0,8(sp)
 70e:	0141                	addi	sp,sp,16
 710:	8082                	ret

0000000000000712 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 712:	7139                	addi	sp,sp,-64
 714:	fc06                	sd	ra,56(sp)
 716:	f822                	sd	s0,48(sp)
 718:	f426                	sd	s1,40(sp)
 71a:	f04a                	sd	s2,32(sp)
 71c:	ec4e                	sd	s3,24(sp)
 71e:	e852                	sd	s4,16(sp)
 720:	e456                	sd	s5,8(sp)
 722:	e05a                	sd	s6,0(sp)
 724:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 726:	02051493          	slli	s1,a0,0x20
 72a:	9081                	srli	s1,s1,0x20
 72c:	04bd                	addi	s1,s1,15
 72e:	8091                	srli	s1,s1,0x4
 730:	0014899b          	addiw	s3,s1,1
 734:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 736:	00001517          	auipc	a0,0x1
 73a:	8ca53503          	ld	a0,-1846(a0) # 1000 <freep>
 73e:	c515                	beqz	a0,76a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 740:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 742:	4798                	lw	a4,8(a5)
 744:	02977f63          	bgeu	a4,s1,782 <malloc+0x70>
 748:	8a4e                	mv	s4,s3
 74a:	0009871b          	sext.w	a4,s3
 74e:	6685                	lui	a3,0x1
 750:	00d77363          	bgeu	a4,a3,756 <malloc+0x44>
 754:	6a05                	lui	s4,0x1
 756:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 75a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 75e:	00001917          	auipc	s2,0x1
 762:	8a290913          	addi	s2,s2,-1886 # 1000 <freep>
  if(p == (char*)-1)
 766:	5afd                	li	s5,-1
 768:	a895                	j	7dc <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 76a:	00001797          	auipc	a5,0x1
 76e:	8a678793          	addi	a5,a5,-1882 # 1010 <base>
 772:	00001717          	auipc	a4,0x1
 776:	88f73723          	sd	a5,-1906(a4) # 1000 <freep>
 77a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 77c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 780:	b7e1                	j	748 <malloc+0x36>
      if(p->s.size == nunits)
 782:	02e48c63          	beq	s1,a4,7ba <malloc+0xa8>
        p->s.size -= nunits;
 786:	4137073b          	subw	a4,a4,s3
 78a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 78c:	02071693          	slli	a3,a4,0x20
 790:	01c6d713          	srli	a4,a3,0x1c
 794:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 796:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 79a:	00001717          	auipc	a4,0x1
 79e:	86a73323          	sd	a0,-1946(a4) # 1000 <freep>
      return (void*)(p + 1);
 7a2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7a6:	70e2                	ld	ra,56(sp)
 7a8:	7442                	ld	s0,48(sp)
 7aa:	74a2                	ld	s1,40(sp)
 7ac:	7902                	ld	s2,32(sp)
 7ae:	69e2                	ld	s3,24(sp)
 7b0:	6a42                	ld	s4,16(sp)
 7b2:	6aa2                	ld	s5,8(sp)
 7b4:	6b02                	ld	s6,0(sp)
 7b6:	6121                	addi	sp,sp,64
 7b8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7ba:	6398                	ld	a4,0(a5)
 7bc:	e118                	sd	a4,0(a0)
 7be:	bff1                	j	79a <malloc+0x88>
  hp->s.size = nu;
 7c0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7c4:	0541                	addi	a0,a0,16
 7c6:	00000097          	auipc	ra,0x0
 7ca:	eca080e7          	jalr	-310(ra) # 690 <free>
  return freep;
 7ce:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 7d2:	d971                	beqz	a0,7a6 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7d6:	4798                	lw	a4,8(a5)
 7d8:	fa9775e3          	bgeu	a4,s1,782 <malloc+0x70>
    if(p == freep)
 7dc:	00093703          	ld	a4,0(s2)
 7e0:	853e                	mv	a0,a5
 7e2:	fef719e3          	bne	a4,a5,7d4 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 7e6:	8552                	mv	a0,s4
 7e8:	00000097          	auipc	ra,0x0
 7ec:	b80080e7          	jalr	-1152(ra) # 368 <sbrk>
  if(p == (char*)-1)
 7f0:	fd5518e3          	bne	a0,s5,7c0 <malloc+0xae>
        return 0;
 7f4:	4501                	li	a0,0
 7f6:	bf45                	j	7a6 <malloc+0x94>
