
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <prime>:
#include "kernel/types.h"
#include "user/user.h"

// important:
//      child can read 0 after father close all write
void prime(int* pip) {
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
   a:	84aa                	mv	s1,a0
    // disable child write left pipe
    close(pip[1]);
   c:	4148                	lw	a0,4(a0)
   e:	00000097          	auipc	ra,0x0
  12:	400080e7          	jalr	1024(ra) # 40e <close>
    int read_len, primes;
    // if read_len = 0, pipe is empty, exit
    read_len = read(pip[0], &primes, sizeof(primes));
  16:	4611                	li	a2,4
  18:	fdc40593          	addi	a1,s0,-36
  1c:	4088                	lw	a0,0(s1)
  1e:	00000097          	auipc	ra,0x0
  22:	3e0080e7          	jalr	992(ra) # 3fe <read>
    if(read_len == 0) {
  26:	e919                	bnez	a0,3c <prime+0x3c>
        close(pip[0]);
  28:	4088                	lw	a0,0(s1)
  2a:	00000097          	auipc	ra,0x0
  2e:	3e4080e7          	jalr	996(ra) # 40e <close>
        exit(0);
  32:	4501                	li	a0,0
  34:	00000097          	auipc	ra,0x0
  38:	3b2080e7          	jalr	946(ra) # 3e6 <exit>
    }
    // show message
    printf("prime: %d\n", primes);
  3c:	fdc42583          	lw	a1,-36(s0)
  40:	00001517          	auipc	a0,0x1
  44:	8c050513          	addi	a0,a0,-1856 # 900 <malloc+0xe8>
  48:	00000097          	auipc	ra,0x0
  4c:	718080e7          	jalr	1816(ra) # 760 <printf>

    // create new pipe
    int pp[2];
    pipe(pp);
  50:	fd040513          	addi	a0,s0,-48
  54:	00000097          	auipc	ra,0x0
  58:	3a2080e7          	jalr	930(ra) # 3f6 <pipe>
    // create grandson
    int pid = fork();
  5c:	00000097          	auipc	ra,0x0
  60:	382080e7          	jalr	898(ra) # 3de <fork>
    if(pid > 0) {
  64:	00a04963          	bgtz	a0,76 <prime+0x76>
        close(pp[1]);
        close(pip[0]);
        // wait grandson exit...
        wait(0);
    }
    if(pid == 0) {
  68:	e53d                	bnez	a0,d6 <prime+0xd6>
        // recursion
        prime(pp);
  6a:	fd040513          	addi	a0,s0,-48
  6e:	00000097          	auipc	ra,0x0
  72:	f92080e7          	jalr	-110(ra) # 0 <prime>
        close(pp[0]);
  76:	fd042503          	lw	a0,-48(s0)
  7a:	00000097          	auipc	ra,0x0
  7e:	394080e7          	jalr	916(ra) # 40e <close>
        while(read(pip[0], &read_num, sizeof(read_num))) {
  82:	4611                	li	a2,4
  84:	fcc40593          	addi	a1,s0,-52
  88:	4088                	lw	a0,0(s1)
  8a:	00000097          	auipc	ra,0x0
  8e:	374080e7          	jalr	884(ra) # 3fe <read>
  92:	c115                	beqz	a0,b6 <prime+0xb6>
            if(read_num % primes != 0)
  94:	fcc42783          	lw	a5,-52(s0)
  98:	fdc42703          	lw	a4,-36(s0)
  9c:	02e7e7bb          	remw	a5,a5,a4
  a0:	d3ed                	beqz	a5,82 <prime+0x82>
                write(pp[1], &read_num, sizeof(read_num));
  a2:	4611                	li	a2,4
  a4:	fcc40593          	addi	a1,s0,-52
  a8:	fd442503          	lw	a0,-44(s0)
  ac:	00000097          	auipc	ra,0x0
  b0:	35a080e7          	jalr	858(ra) # 406 <write>
  b4:	b7f9                	j	82 <prime+0x82>
        close(pp[1]);
  b6:	fd442503          	lw	a0,-44(s0)
  ba:	00000097          	auipc	ra,0x0
  be:	354080e7          	jalr	852(ra) # 40e <close>
        close(pip[0]);
  c2:	4088                	lw	a0,0(s1)
  c4:	00000097          	auipc	ra,0x0
  c8:	34a080e7          	jalr	842(ra) # 40e <close>
        wait(0);
  cc:	4501                	li	a0,0
  ce:	00000097          	auipc	ra,0x0
  d2:	320080e7          	jalr	800(ra) # 3ee <wait>
    }
    exit(0);
  d6:	4501                	li	a0,0
  d8:	00000097          	auipc	ra,0x0
  dc:	30e080e7          	jalr	782(ra) # 3e6 <exit>

00000000000000e0 <main>:
}

int main()
{
  e0:	7179                	addi	sp,sp,-48
  e2:	f406                	sd	ra,40(sp)
  e4:	f022                	sd	s0,32(sp)
  e6:	ec26                	sd	s1,24(sp)
  e8:	e84a                	sd	s2,16(sp)
  ea:	1800                	addi	s0,sp,48
    // create pipe
    int pip[2];
    pipe(pip);
  ec:	fd840513          	addi	a0,s0,-40
  f0:	00000097          	auipc	ra,0x0
  f4:	306080e7          	jalr	774(ra) # 3f6 <pipe>
    int pid = fork();
  f8:	00000097          	auipc	ra,0x0
  fc:	2e6080e7          	jalr	742(ra) # 3de <fork>
    if(pid > 0) {
 100:	00a04963          	bgtz	a0,112 <main+0x32>
    // disable father write after write
        close(pip[1]);
        wait(0);
    }
    // call func
    else if(pid == 0) {
 104:	e929                	bnez	a0,156 <main+0x76>
        prime(pip);
 106:	fd840513          	addi	a0,s0,-40
 10a:	00000097          	auipc	ra,0x0
 10e:	ef6080e7          	jalr	-266(ra) # 0 <prime>
        close(pip[0]);
 112:	fd842503          	lw	a0,-40(s0)
 116:	00000097          	auipc	ra,0x0
 11a:	2f8080e7          	jalr	760(ra) # 40e <close>
 11e:	4489                	li	s1,2
        for(int i = 0; i <= 33; i++) {
 120:	02400913          	li	s2,36
            int tmp = i+2;
 124:	fc942a23          	sw	s1,-44(s0)
            write(pip[1], &tmp, sizeof(tmp));
 128:	4611                	li	a2,4
 12a:	fd440593          	addi	a1,s0,-44
 12e:	fdc42503          	lw	a0,-36(s0)
 132:	00000097          	auipc	ra,0x0
 136:	2d4080e7          	jalr	724(ra) # 406 <write>
        for(int i = 0; i <= 33; i++) {
 13a:	2485                	addiw	s1,s1,1
 13c:	ff2494e3          	bne	s1,s2,124 <main+0x44>
        close(pip[1]);
 140:	fdc42503          	lw	a0,-36(s0)
 144:	00000097          	auipc	ra,0x0
 148:	2ca080e7          	jalr	714(ra) # 40e <close>
        wait(0);
 14c:	4501                	li	a0,0
 14e:	00000097          	auipc	ra,0x0
 152:	2a0080e7          	jalr	672(ra) # 3ee <wait>
    } 
    exit(0);
 156:	4501                	li	a0,0
 158:	00000097          	auipc	ra,0x0
 15c:	28e080e7          	jalr	654(ra) # 3e6 <exit>

0000000000000160 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 160:	1141                	addi	sp,sp,-16
 162:	e406                	sd	ra,8(sp)
 164:	e022                	sd	s0,0(sp)
 166:	0800                	addi	s0,sp,16
  extern int main();
  main();
 168:	00000097          	auipc	ra,0x0
 16c:	f78080e7          	jalr	-136(ra) # e0 <main>
  exit(0);
 170:	4501                	li	a0,0
 172:	00000097          	auipc	ra,0x0
 176:	274080e7          	jalr	628(ra) # 3e6 <exit>

000000000000017a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 17a:	1141                	addi	sp,sp,-16
 17c:	e422                	sd	s0,8(sp)
 17e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 180:	87aa                	mv	a5,a0
 182:	0585                	addi	a1,a1,1
 184:	0785                	addi	a5,a5,1
 186:	fff5c703          	lbu	a4,-1(a1)
 18a:	fee78fa3          	sb	a4,-1(a5)
 18e:	fb75                	bnez	a4,182 <strcpy+0x8>
    ;
  return os;
}
 190:	6422                	ld	s0,8(sp)
 192:	0141                	addi	sp,sp,16
 194:	8082                	ret

0000000000000196 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 196:	1141                	addi	sp,sp,-16
 198:	e422                	sd	s0,8(sp)
 19a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 19c:	00054783          	lbu	a5,0(a0)
 1a0:	cb91                	beqz	a5,1b4 <strcmp+0x1e>
 1a2:	0005c703          	lbu	a4,0(a1)
 1a6:	00f71763          	bne	a4,a5,1b4 <strcmp+0x1e>
    p++, q++;
 1aa:	0505                	addi	a0,a0,1
 1ac:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ae:	00054783          	lbu	a5,0(a0)
 1b2:	fbe5                	bnez	a5,1a2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1b4:	0005c503          	lbu	a0,0(a1)
}
 1b8:	40a7853b          	subw	a0,a5,a0
 1bc:	6422                	ld	s0,8(sp)
 1be:	0141                	addi	sp,sp,16
 1c0:	8082                	ret

00000000000001c2 <strlen>:

uint
strlen(const char *s)
{
 1c2:	1141                	addi	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1c8:	00054783          	lbu	a5,0(a0)
 1cc:	cf91                	beqz	a5,1e8 <strlen+0x26>
 1ce:	0505                	addi	a0,a0,1
 1d0:	87aa                	mv	a5,a0
 1d2:	4685                	li	a3,1
 1d4:	9e89                	subw	a3,a3,a0
 1d6:	00f6853b          	addw	a0,a3,a5
 1da:	0785                	addi	a5,a5,1
 1dc:	fff7c703          	lbu	a4,-1(a5)
 1e0:	fb7d                	bnez	a4,1d6 <strlen+0x14>
    ;
  return n;
}
 1e2:	6422                	ld	s0,8(sp)
 1e4:	0141                	addi	sp,sp,16
 1e6:	8082                	ret
  for(n = 0; s[n]; n++)
 1e8:	4501                	li	a0,0
 1ea:	bfe5                	j	1e2 <strlen+0x20>

00000000000001ec <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ec:	1141                	addi	sp,sp,-16
 1ee:	e422                	sd	s0,8(sp)
 1f0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1f2:	ca19                	beqz	a2,208 <memset+0x1c>
 1f4:	87aa                	mv	a5,a0
 1f6:	1602                	slli	a2,a2,0x20
 1f8:	9201                	srli	a2,a2,0x20
 1fa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 202:	0785                	addi	a5,a5,1
 204:	fee79de3          	bne	a5,a4,1fe <memset+0x12>
  }
  return dst;
}
 208:	6422                	ld	s0,8(sp)
 20a:	0141                	addi	sp,sp,16
 20c:	8082                	ret

000000000000020e <strchr>:

char*
strchr(const char *s, char c)
{
 20e:	1141                	addi	sp,sp,-16
 210:	e422                	sd	s0,8(sp)
 212:	0800                	addi	s0,sp,16
  for(; *s; s++)
 214:	00054783          	lbu	a5,0(a0)
 218:	cb99                	beqz	a5,22e <strchr+0x20>
    if(*s == c)
 21a:	00f58763          	beq	a1,a5,228 <strchr+0x1a>
  for(; *s; s++)
 21e:	0505                	addi	a0,a0,1
 220:	00054783          	lbu	a5,0(a0)
 224:	fbfd                	bnez	a5,21a <strchr+0xc>
      return (char*)s;
  return 0;
 226:	4501                	li	a0,0
}
 228:	6422                	ld	s0,8(sp)
 22a:	0141                	addi	sp,sp,16
 22c:	8082                	ret
  return 0;
 22e:	4501                	li	a0,0
 230:	bfe5                	j	228 <strchr+0x1a>

0000000000000232 <gets>:

char*
gets(char *buf, int max)
{
 232:	711d                	addi	sp,sp,-96
 234:	ec86                	sd	ra,88(sp)
 236:	e8a2                	sd	s0,80(sp)
 238:	e4a6                	sd	s1,72(sp)
 23a:	e0ca                	sd	s2,64(sp)
 23c:	fc4e                	sd	s3,56(sp)
 23e:	f852                	sd	s4,48(sp)
 240:	f456                	sd	s5,40(sp)
 242:	f05a                	sd	s6,32(sp)
 244:	ec5e                	sd	s7,24(sp)
 246:	1080                	addi	s0,sp,96
 248:	8baa                	mv	s7,a0
 24a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24c:	892a                	mv	s2,a0
 24e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 250:	4aa9                	li	s5,10
 252:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 254:	89a6                	mv	s3,s1
 256:	2485                	addiw	s1,s1,1
 258:	0344d863          	bge	s1,s4,288 <gets+0x56>
    cc = read(0, &c, 1);
 25c:	4605                	li	a2,1
 25e:	faf40593          	addi	a1,s0,-81
 262:	4501                	li	a0,0
 264:	00000097          	auipc	ra,0x0
 268:	19a080e7          	jalr	410(ra) # 3fe <read>
    if(cc < 1)
 26c:	00a05e63          	blez	a0,288 <gets+0x56>
    buf[i++] = c;
 270:	faf44783          	lbu	a5,-81(s0)
 274:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 278:	01578763          	beq	a5,s5,286 <gets+0x54>
 27c:	0905                	addi	s2,s2,1
 27e:	fd679be3          	bne	a5,s6,254 <gets+0x22>
  for(i=0; i+1 < max; ){
 282:	89a6                	mv	s3,s1
 284:	a011                	j	288 <gets+0x56>
 286:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 288:	99de                	add	s3,s3,s7
 28a:	00098023          	sb	zero,0(s3)
  return buf;
}
 28e:	855e                	mv	a0,s7
 290:	60e6                	ld	ra,88(sp)
 292:	6446                	ld	s0,80(sp)
 294:	64a6                	ld	s1,72(sp)
 296:	6906                	ld	s2,64(sp)
 298:	79e2                	ld	s3,56(sp)
 29a:	7a42                	ld	s4,48(sp)
 29c:	7aa2                	ld	s5,40(sp)
 29e:	7b02                	ld	s6,32(sp)
 2a0:	6be2                	ld	s7,24(sp)
 2a2:	6125                	addi	sp,sp,96
 2a4:	8082                	ret

00000000000002a6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a6:	1101                	addi	sp,sp,-32
 2a8:	ec06                	sd	ra,24(sp)
 2aa:	e822                	sd	s0,16(sp)
 2ac:	e426                	sd	s1,8(sp)
 2ae:	e04a                	sd	s2,0(sp)
 2b0:	1000                	addi	s0,sp,32
 2b2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b4:	4581                	li	a1,0
 2b6:	00000097          	auipc	ra,0x0
 2ba:	170080e7          	jalr	368(ra) # 426 <open>
  if(fd < 0)
 2be:	02054563          	bltz	a0,2e8 <stat+0x42>
 2c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2c4:	85ca                	mv	a1,s2
 2c6:	00000097          	auipc	ra,0x0
 2ca:	178080e7          	jalr	376(ra) # 43e <fstat>
 2ce:	892a                	mv	s2,a0
  close(fd);
 2d0:	8526                	mv	a0,s1
 2d2:	00000097          	auipc	ra,0x0
 2d6:	13c080e7          	jalr	316(ra) # 40e <close>
  return r;
}
 2da:	854a                	mv	a0,s2
 2dc:	60e2                	ld	ra,24(sp)
 2de:	6442                	ld	s0,16(sp)
 2e0:	64a2                	ld	s1,8(sp)
 2e2:	6902                	ld	s2,0(sp)
 2e4:	6105                	addi	sp,sp,32
 2e6:	8082                	ret
    return -1;
 2e8:	597d                	li	s2,-1
 2ea:	bfc5                	j	2da <stat+0x34>

00000000000002ec <atoi>:

int
atoi(const char *s)
{
 2ec:	1141                	addi	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f2:	00054683          	lbu	a3,0(a0)
 2f6:	fd06879b          	addiw	a5,a3,-48
 2fa:	0ff7f793          	zext.b	a5,a5
 2fe:	4625                	li	a2,9
 300:	02f66863          	bltu	a2,a5,330 <atoi+0x44>
 304:	872a                	mv	a4,a0
  n = 0;
 306:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 308:	0705                	addi	a4,a4,1
 30a:	0025179b          	slliw	a5,a0,0x2
 30e:	9fa9                	addw	a5,a5,a0
 310:	0017979b          	slliw	a5,a5,0x1
 314:	9fb5                	addw	a5,a5,a3
 316:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 31a:	00074683          	lbu	a3,0(a4)
 31e:	fd06879b          	addiw	a5,a3,-48
 322:	0ff7f793          	zext.b	a5,a5
 326:	fef671e3          	bgeu	a2,a5,308 <atoi+0x1c>
  return n;
}
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret
  n = 0;
 330:	4501                	li	a0,0
 332:	bfe5                	j	32a <atoi+0x3e>

0000000000000334 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 334:	1141                	addi	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 33a:	02b57463          	bgeu	a0,a1,362 <memmove+0x2e>
    while(n-- > 0)
 33e:	00c05f63          	blez	a2,35c <memmove+0x28>
 342:	1602                	slli	a2,a2,0x20
 344:	9201                	srli	a2,a2,0x20
 346:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 34a:	872a                	mv	a4,a0
      *dst++ = *src++;
 34c:	0585                	addi	a1,a1,1
 34e:	0705                	addi	a4,a4,1
 350:	fff5c683          	lbu	a3,-1(a1)
 354:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 358:	fee79ae3          	bne	a5,a4,34c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 35c:	6422                	ld	s0,8(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret
    dst += n;
 362:	00c50733          	add	a4,a0,a2
    src += n;
 366:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 368:	fec05ae3          	blez	a2,35c <memmove+0x28>
 36c:	fff6079b          	addiw	a5,a2,-1
 370:	1782                	slli	a5,a5,0x20
 372:	9381                	srli	a5,a5,0x20
 374:	fff7c793          	not	a5,a5
 378:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 37a:	15fd                	addi	a1,a1,-1
 37c:	177d                	addi	a4,a4,-1
 37e:	0005c683          	lbu	a3,0(a1)
 382:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 386:	fee79ae3          	bne	a5,a4,37a <memmove+0x46>
 38a:	bfc9                	j	35c <memmove+0x28>

000000000000038c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 38c:	1141                	addi	sp,sp,-16
 38e:	e422                	sd	s0,8(sp)
 390:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 392:	ca05                	beqz	a2,3c2 <memcmp+0x36>
 394:	fff6069b          	addiw	a3,a2,-1
 398:	1682                	slli	a3,a3,0x20
 39a:	9281                	srli	a3,a3,0x20
 39c:	0685                	addi	a3,a3,1
 39e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3a0:	00054783          	lbu	a5,0(a0)
 3a4:	0005c703          	lbu	a4,0(a1)
 3a8:	00e79863          	bne	a5,a4,3b8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3ac:	0505                	addi	a0,a0,1
    p2++;
 3ae:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3b0:	fed518e3          	bne	a0,a3,3a0 <memcmp+0x14>
  }
  return 0;
 3b4:	4501                	li	a0,0
 3b6:	a019                	j	3bc <memcmp+0x30>
      return *p1 - *p2;
 3b8:	40e7853b          	subw	a0,a5,a4
}
 3bc:	6422                	ld	s0,8(sp)
 3be:	0141                	addi	sp,sp,16
 3c0:	8082                	ret
  return 0;
 3c2:	4501                	li	a0,0
 3c4:	bfe5                	j	3bc <memcmp+0x30>

00000000000003c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3c6:	1141                	addi	sp,sp,-16
 3c8:	e406                	sd	ra,8(sp)
 3ca:	e022                	sd	s0,0(sp)
 3cc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3ce:	00000097          	auipc	ra,0x0
 3d2:	f66080e7          	jalr	-154(ra) # 334 <memmove>
}
 3d6:	60a2                	ld	ra,8(sp)
 3d8:	6402                	ld	s0,0(sp)
 3da:	0141                	addi	sp,sp,16
 3dc:	8082                	ret

00000000000003de <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3de:	4885                	li	a7,1
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3e6:	4889                	li	a7,2
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <wait>:
.global wait
wait:
 li a7, SYS_wait
 3ee:	488d                	li	a7,3
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3f6:	4891                	li	a7,4
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <read>:
.global read
read:
 li a7, SYS_read
 3fe:	4895                	li	a7,5
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <write>:
.global write
write:
 li a7, SYS_write
 406:	48c1                	li	a7,16
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <close>:
.global close
close:
 li a7, SYS_close
 40e:	48d5                	li	a7,21
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <kill>:
.global kill
kill:
 li a7, SYS_kill
 416:	4899                	li	a7,6
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <exec>:
.global exec
exec:
 li a7, SYS_exec
 41e:	489d                	li	a7,7
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <open>:
.global open
open:
 li a7, SYS_open
 426:	48bd                	li	a7,15
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 42e:	48c5                	li	a7,17
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 436:	48c9                	li	a7,18
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 43e:	48a1                	li	a7,8
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <link>:
.global link
link:
 li a7, SYS_link
 446:	48cd                	li	a7,19
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 44e:	48d1                	li	a7,20
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 456:	48a5                	li	a7,9
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <dup>:
.global dup
dup:
 li a7, SYS_dup
 45e:	48a9                	li	a7,10
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 466:	48ad                	li	a7,11
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 46e:	48b1                	li	a7,12
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 476:	48b5                	li	a7,13
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 47e:	48b9                	li	a7,14
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 486:	1101                	addi	sp,sp,-32
 488:	ec06                	sd	ra,24(sp)
 48a:	e822                	sd	s0,16(sp)
 48c:	1000                	addi	s0,sp,32
 48e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 492:	4605                	li	a2,1
 494:	fef40593          	addi	a1,s0,-17
 498:	00000097          	auipc	ra,0x0
 49c:	f6e080e7          	jalr	-146(ra) # 406 <write>
}
 4a0:	60e2                	ld	ra,24(sp)
 4a2:	6442                	ld	s0,16(sp)
 4a4:	6105                	addi	sp,sp,32
 4a6:	8082                	ret

00000000000004a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4a8:	7139                	addi	sp,sp,-64
 4aa:	fc06                	sd	ra,56(sp)
 4ac:	f822                	sd	s0,48(sp)
 4ae:	f426                	sd	s1,40(sp)
 4b0:	f04a                	sd	s2,32(sp)
 4b2:	ec4e                	sd	s3,24(sp)
 4b4:	0080                	addi	s0,sp,64
 4b6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4b8:	c299                	beqz	a3,4be <printint+0x16>
 4ba:	0805c963          	bltz	a1,54c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4be:	2581                	sext.w	a1,a1
  neg = 0;
 4c0:	4881                	li	a7,0
 4c2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4c6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4c8:	2601                	sext.w	a2,a2
 4ca:	00000517          	auipc	a0,0x0
 4ce:	4a650513          	addi	a0,a0,1190 # 970 <digits>
 4d2:	883a                	mv	a6,a4
 4d4:	2705                	addiw	a4,a4,1
 4d6:	02c5f7bb          	remuw	a5,a1,a2
 4da:	1782                	slli	a5,a5,0x20
 4dc:	9381                	srli	a5,a5,0x20
 4de:	97aa                	add	a5,a5,a0
 4e0:	0007c783          	lbu	a5,0(a5)
 4e4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4e8:	0005879b          	sext.w	a5,a1
 4ec:	02c5d5bb          	divuw	a1,a1,a2
 4f0:	0685                	addi	a3,a3,1
 4f2:	fec7f0e3          	bgeu	a5,a2,4d2 <printint+0x2a>
  if(neg)
 4f6:	00088c63          	beqz	a7,50e <printint+0x66>
    buf[i++] = '-';
 4fa:	fd070793          	addi	a5,a4,-48
 4fe:	00878733          	add	a4,a5,s0
 502:	02d00793          	li	a5,45
 506:	fef70823          	sb	a5,-16(a4)
 50a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 50e:	02e05863          	blez	a4,53e <printint+0x96>
 512:	fc040793          	addi	a5,s0,-64
 516:	00e78933          	add	s2,a5,a4
 51a:	fff78993          	addi	s3,a5,-1
 51e:	99ba                	add	s3,s3,a4
 520:	377d                	addiw	a4,a4,-1
 522:	1702                	slli	a4,a4,0x20
 524:	9301                	srli	a4,a4,0x20
 526:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 52a:	fff94583          	lbu	a1,-1(s2)
 52e:	8526                	mv	a0,s1
 530:	00000097          	auipc	ra,0x0
 534:	f56080e7          	jalr	-170(ra) # 486 <putc>
  while(--i >= 0)
 538:	197d                	addi	s2,s2,-1
 53a:	ff3918e3          	bne	s2,s3,52a <printint+0x82>
}
 53e:	70e2                	ld	ra,56(sp)
 540:	7442                	ld	s0,48(sp)
 542:	74a2                	ld	s1,40(sp)
 544:	7902                	ld	s2,32(sp)
 546:	69e2                	ld	s3,24(sp)
 548:	6121                	addi	sp,sp,64
 54a:	8082                	ret
    x = -xx;
 54c:	40b005bb          	negw	a1,a1
    neg = 1;
 550:	4885                	li	a7,1
    x = -xx;
 552:	bf85                	j	4c2 <printint+0x1a>

0000000000000554 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 554:	7119                	addi	sp,sp,-128
 556:	fc86                	sd	ra,120(sp)
 558:	f8a2                	sd	s0,112(sp)
 55a:	f4a6                	sd	s1,104(sp)
 55c:	f0ca                	sd	s2,96(sp)
 55e:	ecce                	sd	s3,88(sp)
 560:	e8d2                	sd	s4,80(sp)
 562:	e4d6                	sd	s5,72(sp)
 564:	e0da                	sd	s6,64(sp)
 566:	fc5e                	sd	s7,56(sp)
 568:	f862                	sd	s8,48(sp)
 56a:	f466                	sd	s9,40(sp)
 56c:	f06a                	sd	s10,32(sp)
 56e:	ec6e                	sd	s11,24(sp)
 570:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 572:	0005c903          	lbu	s2,0(a1)
 576:	18090f63          	beqz	s2,714 <vprintf+0x1c0>
 57a:	8aaa                	mv	s5,a0
 57c:	8b32                	mv	s6,a2
 57e:	00158493          	addi	s1,a1,1
  state = 0;
 582:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 584:	02500a13          	li	s4,37
 588:	4c55                	li	s8,21
 58a:	00000c97          	auipc	s9,0x0
 58e:	38ec8c93          	addi	s9,s9,910 # 918 <malloc+0x100>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 592:	02800d93          	li	s11,40
  putc(fd, 'x');
 596:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 598:	00000b97          	auipc	s7,0x0
 59c:	3d8b8b93          	addi	s7,s7,984 # 970 <digits>
 5a0:	a839                	j	5be <vprintf+0x6a>
        putc(fd, c);
 5a2:	85ca                	mv	a1,s2
 5a4:	8556                	mv	a0,s5
 5a6:	00000097          	auipc	ra,0x0
 5aa:	ee0080e7          	jalr	-288(ra) # 486 <putc>
 5ae:	a019                	j	5b4 <vprintf+0x60>
    } else if(state == '%'){
 5b0:	01498d63          	beq	s3,s4,5ca <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 5b4:	0485                	addi	s1,s1,1
 5b6:	fff4c903          	lbu	s2,-1(s1)
 5ba:	14090d63          	beqz	s2,714 <vprintf+0x1c0>
    if(state == 0){
 5be:	fe0999e3          	bnez	s3,5b0 <vprintf+0x5c>
      if(c == '%'){
 5c2:	ff4910e3          	bne	s2,s4,5a2 <vprintf+0x4e>
        state = '%';
 5c6:	89d2                	mv	s3,s4
 5c8:	b7f5                	j	5b4 <vprintf+0x60>
      if(c == 'd'){
 5ca:	11490c63          	beq	s2,s4,6e2 <vprintf+0x18e>
 5ce:	f9d9079b          	addiw	a5,s2,-99
 5d2:	0ff7f793          	zext.b	a5,a5
 5d6:	10fc6e63          	bltu	s8,a5,6f2 <vprintf+0x19e>
 5da:	f9d9079b          	addiw	a5,s2,-99
 5de:	0ff7f713          	zext.b	a4,a5
 5e2:	10ec6863          	bltu	s8,a4,6f2 <vprintf+0x19e>
 5e6:	00271793          	slli	a5,a4,0x2
 5ea:	97e6                	add	a5,a5,s9
 5ec:	439c                	lw	a5,0(a5)
 5ee:	97e6                	add	a5,a5,s9
 5f0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5f2:	008b0913          	addi	s2,s6,8
 5f6:	4685                	li	a3,1
 5f8:	4629                	li	a2,10
 5fa:	000b2583          	lw	a1,0(s6)
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	ea8080e7          	jalr	-344(ra) # 4a8 <printint>
 608:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 60a:	4981                	li	s3,0
 60c:	b765                	j	5b4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 60e:	008b0913          	addi	s2,s6,8
 612:	4681                	li	a3,0
 614:	4629                	li	a2,10
 616:	000b2583          	lw	a1,0(s6)
 61a:	8556                	mv	a0,s5
 61c:	00000097          	auipc	ra,0x0
 620:	e8c080e7          	jalr	-372(ra) # 4a8 <printint>
 624:	8b4a                	mv	s6,s2
      state = 0;
 626:	4981                	li	s3,0
 628:	b771                	j	5b4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 62a:	008b0913          	addi	s2,s6,8
 62e:	4681                	li	a3,0
 630:	866a                	mv	a2,s10
 632:	000b2583          	lw	a1,0(s6)
 636:	8556                	mv	a0,s5
 638:	00000097          	auipc	ra,0x0
 63c:	e70080e7          	jalr	-400(ra) # 4a8 <printint>
 640:	8b4a                	mv	s6,s2
      state = 0;
 642:	4981                	li	s3,0
 644:	bf85                	j	5b4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 646:	008b0793          	addi	a5,s6,8
 64a:	f8f43423          	sd	a5,-120(s0)
 64e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 652:	03000593          	li	a1,48
 656:	8556                	mv	a0,s5
 658:	00000097          	auipc	ra,0x0
 65c:	e2e080e7          	jalr	-466(ra) # 486 <putc>
  putc(fd, 'x');
 660:	07800593          	li	a1,120
 664:	8556                	mv	a0,s5
 666:	00000097          	auipc	ra,0x0
 66a:	e20080e7          	jalr	-480(ra) # 486 <putc>
 66e:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 670:	03c9d793          	srli	a5,s3,0x3c
 674:	97de                	add	a5,a5,s7
 676:	0007c583          	lbu	a1,0(a5)
 67a:	8556                	mv	a0,s5
 67c:	00000097          	auipc	ra,0x0
 680:	e0a080e7          	jalr	-502(ra) # 486 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 684:	0992                	slli	s3,s3,0x4
 686:	397d                	addiw	s2,s2,-1
 688:	fe0914e3          	bnez	s2,670 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 68c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 690:	4981                	li	s3,0
 692:	b70d                	j	5b4 <vprintf+0x60>
        s = va_arg(ap, char*);
 694:	008b0913          	addi	s2,s6,8
 698:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 69c:	02098163          	beqz	s3,6be <vprintf+0x16a>
        while(*s != 0){
 6a0:	0009c583          	lbu	a1,0(s3)
 6a4:	c5ad                	beqz	a1,70e <vprintf+0x1ba>
          putc(fd, *s);
 6a6:	8556                	mv	a0,s5
 6a8:	00000097          	auipc	ra,0x0
 6ac:	dde080e7          	jalr	-546(ra) # 486 <putc>
          s++;
 6b0:	0985                	addi	s3,s3,1
        while(*s != 0){
 6b2:	0009c583          	lbu	a1,0(s3)
 6b6:	f9e5                	bnez	a1,6a6 <vprintf+0x152>
        s = va_arg(ap, char*);
 6b8:	8b4a                	mv	s6,s2
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	bde5                	j	5b4 <vprintf+0x60>
          s = "(null)";
 6be:	00000997          	auipc	s3,0x0
 6c2:	25298993          	addi	s3,s3,594 # 910 <malloc+0xf8>
        while(*s != 0){
 6c6:	85ee                	mv	a1,s11
 6c8:	bff9                	j	6a6 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 6ca:	008b0913          	addi	s2,s6,8
 6ce:	000b4583          	lbu	a1,0(s6)
 6d2:	8556                	mv	a0,s5
 6d4:	00000097          	auipc	ra,0x0
 6d8:	db2080e7          	jalr	-590(ra) # 486 <putc>
 6dc:	8b4a                	mv	s6,s2
      state = 0;
 6de:	4981                	li	s3,0
 6e0:	bdd1                	j	5b4 <vprintf+0x60>
        putc(fd, c);
 6e2:	85d2                	mv	a1,s4
 6e4:	8556                	mv	a0,s5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	da0080e7          	jalr	-608(ra) # 486 <putc>
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	b5d1                	j	5b4 <vprintf+0x60>
        putc(fd, '%');
 6f2:	85d2                	mv	a1,s4
 6f4:	8556                	mv	a0,s5
 6f6:	00000097          	auipc	ra,0x0
 6fa:	d90080e7          	jalr	-624(ra) # 486 <putc>
        putc(fd, c);
 6fe:	85ca                	mv	a1,s2
 700:	8556                	mv	a0,s5
 702:	00000097          	auipc	ra,0x0
 706:	d84080e7          	jalr	-636(ra) # 486 <putc>
      state = 0;
 70a:	4981                	li	s3,0
 70c:	b565                	j	5b4 <vprintf+0x60>
        s = va_arg(ap, char*);
 70e:	8b4a                	mv	s6,s2
      state = 0;
 710:	4981                	li	s3,0
 712:	b54d                	j	5b4 <vprintf+0x60>
    }
  }
}
 714:	70e6                	ld	ra,120(sp)
 716:	7446                	ld	s0,112(sp)
 718:	74a6                	ld	s1,104(sp)
 71a:	7906                	ld	s2,96(sp)
 71c:	69e6                	ld	s3,88(sp)
 71e:	6a46                	ld	s4,80(sp)
 720:	6aa6                	ld	s5,72(sp)
 722:	6b06                	ld	s6,64(sp)
 724:	7be2                	ld	s7,56(sp)
 726:	7c42                	ld	s8,48(sp)
 728:	7ca2                	ld	s9,40(sp)
 72a:	7d02                	ld	s10,32(sp)
 72c:	6de2                	ld	s11,24(sp)
 72e:	6109                	addi	sp,sp,128
 730:	8082                	ret

0000000000000732 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 732:	715d                	addi	sp,sp,-80
 734:	ec06                	sd	ra,24(sp)
 736:	e822                	sd	s0,16(sp)
 738:	1000                	addi	s0,sp,32
 73a:	e010                	sd	a2,0(s0)
 73c:	e414                	sd	a3,8(s0)
 73e:	e818                	sd	a4,16(s0)
 740:	ec1c                	sd	a5,24(s0)
 742:	03043023          	sd	a6,32(s0)
 746:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 74a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 74e:	8622                	mv	a2,s0
 750:	00000097          	auipc	ra,0x0
 754:	e04080e7          	jalr	-508(ra) # 554 <vprintf>
}
 758:	60e2                	ld	ra,24(sp)
 75a:	6442                	ld	s0,16(sp)
 75c:	6161                	addi	sp,sp,80
 75e:	8082                	ret

0000000000000760 <printf>:

void
printf(const char *fmt, ...)
{
 760:	711d                	addi	sp,sp,-96
 762:	ec06                	sd	ra,24(sp)
 764:	e822                	sd	s0,16(sp)
 766:	1000                	addi	s0,sp,32
 768:	e40c                	sd	a1,8(s0)
 76a:	e810                	sd	a2,16(s0)
 76c:	ec14                	sd	a3,24(s0)
 76e:	f018                	sd	a4,32(s0)
 770:	f41c                	sd	a5,40(s0)
 772:	03043823          	sd	a6,48(s0)
 776:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 77a:	00840613          	addi	a2,s0,8
 77e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 782:	85aa                	mv	a1,a0
 784:	4505                	li	a0,1
 786:	00000097          	auipc	ra,0x0
 78a:	dce080e7          	jalr	-562(ra) # 554 <vprintf>
}
 78e:	60e2                	ld	ra,24(sp)
 790:	6442                	ld	s0,16(sp)
 792:	6125                	addi	sp,sp,96
 794:	8082                	ret

0000000000000796 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 796:	1141                	addi	sp,sp,-16
 798:	e422                	sd	s0,8(sp)
 79a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 79c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a0:	00001797          	auipc	a5,0x1
 7a4:	8607b783          	ld	a5,-1952(a5) # 1000 <freep>
 7a8:	a02d                	j	7d2 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7aa:	4618                	lw	a4,8(a2)
 7ac:	9f2d                	addw	a4,a4,a1
 7ae:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b2:	6398                	ld	a4,0(a5)
 7b4:	6310                	ld	a2,0(a4)
 7b6:	a83d                	j	7f4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7b8:	ff852703          	lw	a4,-8(a0)
 7bc:	9f31                	addw	a4,a4,a2
 7be:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7c0:	ff053683          	ld	a3,-16(a0)
 7c4:	a091                	j	808 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c6:	6398                	ld	a4,0(a5)
 7c8:	00e7e463          	bltu	a5,a4,7d0 <free+0x3a>
 7cc:	00e6ea63          	bltu	a3,a4,7e0 <free+0x4a>
{
 7d0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d2:	fed7fae3          	bgeu	a5,a3,7c6 <free+0x30>
 7d6:	6398                	ld	a4,0(a5)
 7d8:	00e6e463          	bltu	a3,a4,7e0 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7dc:	fee7eae3          	bltu	a5,a4,7d0 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7e0:	ff852583          	lw	a1,-8(a0)
 7e4:	6390                	ld	a2,0(a5)
 7e6:	02059813          	slli	a6,a1,0x20
 7ea:	01c85713          	srli	a4,a6,0x1c
 7ee:	9736                	add	a4,a4,a3
 7f0:	fae60de3          	beq	a2,a4,7aa <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7f4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7f8:	4790                	lw	a2,8(a5)
 7fa:	02061593          	slli	a1,a2,0x20
 7fe:	01c5d713          	srli	a4,a1,0x1c
 802:	973e                	add	a4,a4,a5
 804:	fae68ae3          	beq	a3,a4,7b8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 808:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 80a:	00000717          	auipc	a4,0x0
 80e:	7ef73b23          	sd	a5,2038(a4) # 1000 <freep>
}
 812:	6422                	ld	s0,8(sp)
 814:	0141                	addi	sp,sp,16
 816:	8082                	ret

0000000000000818 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 818:	7139                	addi	sp,sp,-64
 81a:	fc06                	sd	ra,56(sp)
 81c:	f822                	sd	s0,48(sp)
 81e:	f426                	sd	s1,40(sp)
 820:	f04a                	sd	s2,32(sp)
 822:	ec4e                	sd	s3,24(sp)
 824:	e852                	sd	s4,16(sp)
 826:	e456                	sd	s5,8(sp)
 828:	e05a                	sd	s6,0(sp)
 82a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 82c:	02051493          	slli	s1,a0,0x20
 830:	9081                	srli	s1,s1,0x20
 832:	04bd                	addi	s1,s1,15
 834:	8091                	srli	s1,s1,0x4
 836:	0014899b          	addiw	s3,s1,1
 83a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 83c:	00000517          	auipc	a0,0x0
 840:	7c453503          	ld	a0,1988(a0) # 1000 <freep>
 844:	c515                	beqz	a0,870 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 846:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 848:	4798                	lw	a4,8(a5)
 84a:	02977f63          	bgeu	a4,s1,888 <malloc+0x70>
 84e:	8a4e                	mv	s4,s3
 850:	0009871b          	sext.w	a4,s3
 854:	6685                	lui	a3,0x1
 856:	00d77363          	bgeu	a4,a3,85c <malloc+0x44>
 85a:	6a05                	lui	s4,0x1
 85c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 860:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 864:	00000917          	auipc	s2,0x0
 868:	79c90913          	addi	s2,s2,1948 # 1000 <freep>
  if(p == (char*)-1)
 86c:	5afd                	li	s5,-1
 86e:	a895                	j	8e2 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 870:	00000797          	auipc	a5,0x0
 874:	7a078793          	addi	a5,a5,1952 # 1010 <base>
 878:	00000717          	auipc	a4,0x0
 87c:	78f73423          	sd	a5,1928(a4) # 1000 <freep>
 880:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 882:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 886:	b7e1                	j	84e <malloc+0x36>
      if(p->s.size == nunits)
 888:	02e48c63          	beq	s1,a4,8c0 <malloc+0xa8>
        p->s.size -= nunits;
 88c:	4137073b          	subw	a4,a4,s3
 890:	c798                	sw	a4,8(a5)
        p += p->s.size;
 892:	02071693          	slli	a3,a4,0x20
 896:	01c6d713          	srli	a4,a3,0x1c
 89a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 89c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8a0:	00000717          	auipc	a4,0x0
 8a4:	76a73023          	sd	a0,1888(a4) # 1000 <freep>
      return (void*)(p + 1);
 8a8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8ac:	70e2                	ld	ra,56(sp)
 8ae:	7442                	ld	s0,48(sp)
 8b0:	74a2                	ld	s1,40(sp)
 8b2:	7902                	ld	s2,32(sp)
 8b4:	69e2                	ld	s3,24(sp)
 8b6:	6a42                	ld	s4,16(sp)
 8b8:	6aa2                	ld	s5,8(sp)
 8ba:	6b02                	ld	s6,0(sp)
 8bc:	6121                	addi	sp,sp,64
 8be:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8c0:	6398                	ld	a4,0(a5)
 8c2:	e118                	sd	a4,0(a0)
 8c4:	bff1                	j	8a0 <malloc+0x88>
  hp->s.size = nu;
 8c6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ca:	0541                	addi	a0,a0,16
 8cc:	00000097          	auipc	ra,0x0
 8d0:	eca080e7          	jalr	-310(ra) # 796 <free>
  return freep;
 8d4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8d8:	d971                	beqz	a0,8ac <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8da:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8dc:	4798                	lw	a4,8(a5)
 8de:	fa9775e3          	bgeu	a4,s1,888 <malloc+0x70>
    if(p == freep)
 8e2:	00093703          	ld	a4,0(s2)
 8e6:	853e                	mv	a0,a5
 8e8:	fef719e3          	bne	a4,a5,8da <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8ec:	8552                	mv	a0,s4
 8ee:	00000097          	auipc	ra,0x0
 8f2:	b80080e7          	jalr	-1152(ra) # 46e <sbrk>
  if(p == (char*)-1)
 8f6:	fd5518e3          	bne	a0,s5,8c6 <malloc+0xae>
        return 0;
 8fa:	4501                	li	a0,0
 8fc:	bf45                	j	8ac <malloc+0x94>
