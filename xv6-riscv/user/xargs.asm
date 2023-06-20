
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/param.h"

int main(int argc, char* argv[])
{
   0:	710d                	addi	sp,sp,-352
   2:	ee86                	sd	ra,344(sp)
   4:	eaa2                	sd	s0,336(sp)
   6:	e6a6                	sd	s1,328(sp)
   8:	e2ca                	sd	s2,320(sp)
   a:	fe4e                	sd	s3,312(sp)
   c:	fa52                	sd	s4,304(sp)
   e:	f656                	sd	s5,296(sp)
  10:	f25a                	sd	s6,288(sp)
  12:	1280                	addi	s0,sp,352
    // exit when command is too short or too long
    if(argc < 2) {
  14:	4785                	li	a5,1
  16:	06a7df63          	bge	a5,a0,94 <main+0x94>
  1a:	892a                	mv	s2,a0
  1c:	84ae                	mv	s1,a1
        fprintf(2, "xargs: command is too short\n");
        exit(1);
    }
    if(argc + 1 > MAXARG) {
  1e:	47fd                	li	a5,31
  20:	08a7c863          	blt	a5,a0,b0 <main+0xb0>
        exit(1);
    }
    
    char* command[MAXARG];
    char buf[MAXARG];
    memset(buf, 0, sizeof(buf));
  24:	02000613          	li	a2,32
  28:	4581                	li	a1,0
  2a:	ea040513          	addi	a0,s0,-352
  2e:	00000097          	auipc	ra,0x0
  32:	1bc080e7          	jalr	444(ra) # 1ea <memset>
    memset(command, 0, sizeof(command));
  36:	10000613          	li	a2,256
  3a:	4581                	li	a1,0
  3c:	ec040513          	addi	a0,s0,-320
  40:	00000097          	auipc	ra,0x0
  44:	1aa080e7          	jalr	426(ra) # 1ea <memset>

    // copy whole command except xargs
    for(int i = 0; i < argc-1; i++) {
  48:	fff90a9b          	addiw	s5,s2,-1
  4c:	00848713          	addi	a4,s1,8
  50:	ec040793          	addi	a5,s0,-320
  54:	ffe9061b          	addiw	a2,s2,-2
  58:	02061693          	slli	a3,a2,0x20
  5c:	01d6d613          	srli	a2,a3,0x1d
  60:	ec840693          	addi	a3,s0,-312
  64:	9636                	add	a2,a2,a3
        command[i] = argv[i+1];
  66:	6314                	ld	a3,0(a4)
  68:	e394                	sd	a3,0(a5)
    for(int i = 0; i < argc-1; i++) {
  6a:	0721                	addi	a4,a4,8
  6c:	07a1                	addi	a5,a5,8
  6e:	fec79ce3          	bne	a5,a2,66 <main+0x66>
    }
    // end flag
    command[argc] = 0;
  72:	00391793          	slli	a5,s2,0x3
  76:	fc078793          	addi	a5,a5,-64
  7a:	97a2                	add	a5,a5,s0
  7c:	f007b023          	sd	zero,-256(a5)

    while(1) {
        int i = 0;
  80:	4981                	li	s3,0
        while(read(0, &buf[i], 1)) {
            // break when a line end
            if(buf[i] == '\n')
  82:	4a29                	li	s4,10
        if(i == 0)
            break;
        buf[i] = 0;

        // add buf to command[argc-1]
        command[argc-1] = buf;
  84:	0a8e                	slli	s5,s5,0x3
  86:	fc0a8793          	addi	a5,s5,-64
  8a:	00878ab3          	add	s5,a5,s0
  8e:	ea040b13          	addi	s6,s0,-352
  92:	a095                	j	f6 <main+0xf6>
        fprintf(2, "xargs: command is too short\n");
  94:	00001597          	auipc	a1,0x1
  98:	86c58593          	addi	a1,a1,-1940 # 900 <malloc+0xea>
  9c:	4509                	li	a0,2
  9e:	00000097          	auipc	ra,0x0
  a2:	692080e7          	jalr	1682(ra) # 730 <fprintf>
        exit(1);
  a6:	4505                	li	a0,1
  a8:	00000097          	auipc	ra,0x0
  ac:	33c080e7          	jalr	828(ra) # 3e4 <exit>
        fprintf(2, "xargs: command is too long\n");
  b0:	00001597          	auipc	a1,0x1
  b4:	87058593          	addi	a1,a1,-1936 # 920 <malloc+0x10a>
  b8:	4509                	li	a0,2
  ba:	00000097          	auipc	ra,0x0
  be:	676080e7          	jalr	1654(ra) # 730 <fprintf>
        exit(1);
  c2:	4505                	li	a0,1
  c4:	00000097          	auipc	ra,0x0
  c8:	320080e7          	jalr	800(ra) # 3e4 <exit>
        if(i == 0)
  cc:	06090e63          	beqz	s2,148 <main+0x148>
        buf[i] = 0;
  d0:	fc090793          	addi	a5,s2,-64
  d4:	00878933          	add	s2,a5,s0
  d8:	ee090023          	sb	zero,-288(s2)
        command[argc-1] = buf;
  dc:	f16ab023          	sd	s6,-256(s5)
    
        // create process to exec command
        if(fork() == 0) {
  e0:	00000097          	auipc	ra,0x0
  e4:	2fc080e7          	jalr	764(ra) # 3dc <fork>
  e8:	c90d                	beqz	a0,11a <main+0x11a>
            exec(command[0], command);
            exit(0);
        }
        // wait son finish
        else if(fork() > 0) {
  ea:	00000097          	auipc	ra,0x0
  ee:	2f2080e7          	jalr	754(ra) # 3dc <fork>
  f2:	04a04163          	bgtz	a0,134 <main+0x134>
        while(read(0, &buf[i], 1)) {
  f6:	ea040493          	addi	s1,s0,-352
        int i = 0;
  fa:	894e                	mv	s2,s3
        while(read(0, &buf[i], 1)) {
  fc:	4605                	li	a2,1
  fe:	85a6                	mv	a1,s1
 100:	854e                	mv	a0,s3
 102:	00000097          	auipc	ra,0x0
 106:	2fa080e7          	jalr	762(ra) # 3fc <read>
 10a:	d169                	beqz	a0,cc <main+0xcc>
            if(buf[i] == '\n')
 10c:	0485                	addi	s1,s1,1
 10e:	fff4c783          	lbu	a5,-1(s1)
 112:	fb478de3          	beq	a5,s4,cc <main+0xcc>
            i++;
 116:	2905                	addiw	s2,s2,1
 118:	b7d5                	j	fc <main+0xfc>
            exec(command[0], command);
 11a:	ec040593          	addi	a1,s0,-320
 11e:	ec043503          	ld	a0,-320(s0)
 122:	00000097          	auipc	ra,0x0
 126:	2fa080e7          	jalr	762(ra) # 41c <exec>
            exit(0);
 12a:	4501                	li	a0,0
 12c:	00000097          	auipc	ra,0x0
 130:	2b8080e7          	jalr	696(ra) # 3e4 <exit>
            wait(0);
 134:	4501                	li	a0,0
 136:	00000097          	auipc	ra,0x0
 13a:	2b6080e7          	jalr	694(ra) # 3ec <wait>
            exit(0);
 13e:	4501                	li	a0,0
 140:	00000097          	auipc	ra,0x0
 144:	2a4080e7          	jalr	676(ra) # 3e4 <exit>
        }
    }
    return 0;
}
 148:	4501                	li	a0,0
 14a:	60f6                	ld	ra,344(sp)
 14c:	6456                	ld	s0,336(sp)
 14e:	64b6                	ld	s1,328(sp)
 150:	6916                	ld	s2,320(sp)
 152:	79f2                	ld	s3,312(sp)
 154:	7a52                	ld	s4,304(sp)
 156:	7ab2                	ld	s5,296(sp)
 158:	7b12                	ld	s6,288(sp)
 15a:	6135                	addi	sp,sp,352
 15c:	8082                	ret

000000000000015e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 15e:	1141                	addi	sp,sp,-16
 160:	e406                	sd	ra,8(sp)
 162:	e022                	sd	s0,0(sp)
 164:	0800                	addi	s0,sp,16
  extern int main();
  main();
 166:	00000097          	auipc	ra,0x0
 16a:	e9a080e7          	jalr	-358(ra) # 0 <main>
  exit(0);
 16e:	4501                	li	a0,0
 170:	00000097          	auipc	ra,0x0
 174:	274080e7          	jalr	628(ra) # 3e4 <exit>

0000000000000178 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 178:	1141                	addi	sp,sp,-16
 17a:	e422                	sd	s0,8(sp)
 17c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 17e:	87aa                	mv	a5,a0
 180:	0585                	addi	a1,a1,1
 182:	0785                	addi	a5,a5,1
 184:	fff5c703          	lbu	a4,-1(a1)
 188:	fee78fa3          	sb	a4,-1(a5)
 18c:	fb75                	bnez	a4,180 <strcpy+0x8>
    ;
  return os;
}
 18e:	6422                	ld	s0,8(sp)
 190:	0141                	addi	sp,sp,16
 192:	8082                	ret

0000000000000194 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 194:	1141                	addi	sp,sp,-16
 196:	e422                	sd	s0,8(sp)
 198:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 19a:	00054783          	lbu	a5,0(a0)
 19e:	cb91                	beqz	a5,1b2 <strcmp+0x1e>
 1a0:	0005c703          	lbu	a4,0(a1)
 1a4:	00f71763          	bne	a4,a5,1b2 <strcmp+0x1e>
    p++, q++;
 1a8:	0505                	addi	a0,a0,1
 1aa:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ac:	00054783          	lbu	a5,0(a0)
 1b0:	fbe5                	bnez	a5,1a0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1b2:	0005c503          	lbu	a0,0(a1)
}
 1b6:	40a7853b          	subw	a0,a5,a0
 1ba:	6422                	ld	s0,8(sp)
 1bc:	0141                	addi	sp,sp,16
 1be:	8082                	ret

00000000000001c0 <strlen>:

uint
strlen(const char *s)
{
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cf91                	beqz	a5,1e6 <strlen+0x26>
 1cc:	0505                	addi	a0,a0,1
 1ce:	87aa                	mv	a5,a0
 1d0:	4685                	li	a3,1
 1d2:	9e89                	subw	a3,a3,a0
 1d4:	00f6853b          	addw	a0,a3,a5
 1d8:	0785                	addi	a5,a5,1
 1da:	fff7c703          	lbu	a4,-1(a5)
 1de:	fb7d                	bnez	a4,1d4 <strlen+0x14>
    ;
  return n;
}
 1e0:	6422                	ld	s0,8(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret
  for(n = 0; s[n]; n++)
 1e6:	4501                	li	a0,0
 1e8:	bfe5                	j	1e0 <strlen+0x20>

00000000000001ea <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e422                	sd	s0,8(sp)
 1ee:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1f0:	ca19                	beqz	a2,206 <memset+0x1c>
 1f2:	87aa                	mv	a5,a0
 1f4:	1602                	slli	a2,a2,0x20
 1f6:	9201                	srli	a2,a2,0x20
 1f8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1fc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 200:	0785                	addi	a5,a5,1
 202:	fee79de3          	bne	a5,a4,1fc <memset+0x12>
  }
  return dst;
}
 206:	6422                	ld	s0,8(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret

000000000000020c <strchr>:

char*
strchr(const char *s, char c)
{
 20c:	1141                	addi	sp,sp,-16
 20e:	e422                	sd	s0,8(sp)
 210:	0800                	addi	s0,sp,16
  for(; *s; s++)
 212:	00054783          	lbu	a5,0(a0)
 216:	cb99                	beqz	a5,22c <strchr+0x20>
    if(*s == c)
 218:	00f58763          	beq	a1,a5,226 <strchr+0x1a>
  for(; *s; s++)
 21c:	0505                	addi	a0,a0,1
 21e:	00054783          	lbu	a5,0(a0)
 222:	fbfd                	bnez	a5,218 <strchr+0xc>
      return (char*)s;
  return 0;
 224:	4501                	li	a0,0
}
 226:	6422                	ld	s0,8(sp)
 228:	0141                	addi	sp,sp,16
 22a:	8082                	ret
  return 0;
 22c:	4501                	li	a0,0
 22e:	bfe5                	j	226 <strchr+0x1a>

0000000000000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	711d                	addi	sp,sp,-96
 232:	ec86                	sd	ra,88(sp)
 234:	e8a2                	sd	s0,80(sp)
 236:	e4a6                	sd	s1,72(sp)
 238:	e0ca                	sd	s2,64(sp)
 23a:	fc4e                	sd	s3,56(sp)
 23c:	f852                	sd	s4,48(sp)
 23e:	f456                	sd	s5,40(sp)
 240:	f05a                	sd	s6,32(sp)
 242:	ec5e                	sd	s7,24(sp)
 244:	1080                	addi	s0,sp,96
 246:	8baa                	mv	s7,a0
 248:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24a:	892a                	mv	s2,a0
 24c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 24e:	4aa9                	li	s5,10
 250:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 252:	89a6                	mv	s3,s1
 254:	2485                	addiw	s1,s1,1
 256:	0344d863          	bge	s1,s4,286 <gets+0x56>
    cc = read(0, &c, 1);
 25a:	4605                	li	a2,1
 25c:	faf40593          	addi	a1,s0,-81
 260:	4501                	li	a0,0
 262:	00000097          	auipc	ra,0x0
 266:	19a080e7          	jalr	410(ra) # 3fc <read>
    if(cc < 1)
 26a:	00a05e63          	blez	a0,286 <gets+0x56>
    buf[i++] = c;
 26e:	faf44783          	lbu	a5,-81(s0)
 272:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 276:	01578763          	beq	a5,s5,284 <gets+0x54>
 27a:	0905                	addi	s2,s2,1
 27c:	fd679be3          	bne	a5,s6,252 <gets+0x22>
  for(i=0; i+1 < max; ){
 280:	89a6                	mv	s3,s1
 282:	a011                	j	286 <gets+0x56>
 284:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 286:	99de                	add	s3,s3,s7
 288:	00098023          	sb	zero,0(s3)
  return buf;
}
 28c:	855e                	mv	a0,s7
 28e:	60e6                	ld	ra,88(sp)
 290:	6446                	ld	s0,80(sp)
 292:	64a6                	ld	s1,72(sp)
 294:	6906                	ld	s2,64(sp)
 296:	79e2                	ld	s3,56(sp)
 298:	7a42                	ld	s4,48(sp)
 29a:	7aa2                	ld	s5,40(sp)
 29c:	7b02                	ld	s6,32(sp)
 29e:	6be2                	ld	s7,24(sp)
 2a0:	6125                	addi	sp,sp,96
 2a2:	8082                	ret

00000000000002a4 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a4:	1101                	addi	sp,sp,-32
 2a6:	ec06                	sd	ra,24(sp)
 2a8:	e822                	sd	s0,16(sp)
 2aa:	e426                	sd	s1,8(sp)
 2ac:	e04a                	sd	s2,0(sp)
 2ae:	1000                	addi	s0,sp,32
 2b0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b2:	4581                	li	a1,0
 2b4:	00000097          	auipc	ra,0x0
 2b8:	170080e7          	jalr	368(ra) # 424 <open>
  if(fd < 0)
 2bc:	02054563          	bltz	a0,2e6 <stat+0x42>
 2c0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2c2:	85ca                	mv	a1,s2
 2c4:	00000097          	auipc	ra,0x0
 2c8:	178080e7          	jalr	376(ra) # 43c <fstat>
 2cc:	892a                	mv	s2,a0
  close(fd);
 2ce:	8526                	mv	a0,s1
 2d0:	00000097          	auipc	ra,0x0
 2d4:	13c080e7          	jalr	316(ra) # 40c <close>
  return r;
}
 2d8:	854a                	mv	a0,s2
 2da:	60e2                	ld	ra,24(sp)
 2dc:	6442                	ld	s0,16(sp)
 2de:	64a2                	ld	s1,8(sp)
 2e0:	6902                	ld	s2,0(sp)
 2e2:	6105                	addi	sp,sp,32
 2e4:	8082                	ret
    return -1;
 2e6:	597d                	li	s2,-1
 2e8:	bfc5                	j	2d8 <stat+0x34>

00000000000002ea <atoi>:

int
atoi(const char *s)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e422                	sd	s0,8(sp)
 2ee:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f0:	00054683          	lbu	a3,0(a0)
 2f4:	fd06879b          	addiw	a5,a3,-48
 2f8:	0ff7f793          	zext.b	a5,a5
 2fc:	4625                	li	a2,9
 2fe:	02f66863          	bltu	a2,a5,32e <atoi+0x44>
 302:	872a                	mv	a4,a0
  n = 0;
 304:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 306:	0705                	addi	a4,a4,1
 308:	0025179b          	slliw	a5,a0,0x2
 30c:	9fa9                	addw	a5,a5,a0
 30e:	0017979b          	slliw	a5,a5,0x1
 312:	9fb5                	addw	a5,a5,a3
 314:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 318:	00074683          	lbu	a3,0(a4)
 31c:	fd06879b          	addiw	a5,a3,-48
 320:	0ff7f793          	zext.b	a5,a5
 324:	fef671e3          	bgeu	a2,a5,306 <atoi+0x1c>
  return n;
}
 328:	6422                	ld	s0,8(sp)
 32a:	0141                	addi	sp,sp,16
 32c:	8082                	ret
  n = 0;
 32e:	4501                	li	a0,0
 330:	bfe5                	j	328 <atoi+0x3e>

0000000000000332 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 332:	1141                	addi	sp,sp,-16
 334:	e422                	sd	s0,8(sp)
 336:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 338:	02b57463          	bgeu	a0,a1,360 <memmove+0x2e>
    while(n-- > 0)
 33c:	00c05f63          	blez	a2,35a <memmove+0x28>
 340:	1602                	slli	a2,a2,0x20
 342:	9201                	srli	a2,a2,0x20
 344:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 348:	872a                	mv	a4,a0
      *dst++ = *src++;
 34a:	0585                	addi	a1,a1,1
 34c:	0705                	addi	a4,a4,1
 34e:	fff5c683          	lbu	a3,-1(a1)
 352:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 356:	fee79ae3          	bne	a5,a4,34a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 35a:	6422                	ld	s0,8(sp)
 35c:	0141                	addi	sp,sp,16
 35e:	8082                	ret
    dst += n;
 360:	00c50733          	add	a4,a0,a2
    src += n;
 364:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 366:	fec05ae3          	blez	a2,35a <memmove+0x28>
 36a:	fff6079b          	addiw	a5,a2,-1
 36e:	1782                	slli	a5,a5,0x20
 370:	9381                	srli	a5,a5,0x20
 372:	fff7c793          	not	a5,a5
 376:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 378:	15fd                	addi	a1,a1,-1
 37a:	177d                	addi	a4,a4,-1
 37c:	0005c683          	lbu	a3,0(a1)
 380:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 384:	fee79ae3          	bne	a5,a4,378 <memmove+0x46>
 388:	bfc9                	j	35a <memmove+0x28>

000000000000038a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 38a:	1141                	addi	sp,sp,-16
 38c:	e422                	sd	s0,8(sp)
 38e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 390:	ca05                	beqz	a2,3c0 <memcmp+0x36>
 392:	fff6069b          	addiw	a3,a2,-1
 396:	1682                	slli	a3,a3,0x20
 398:	9281                	srli	a3,a3,0x20
 39a:	0685                	addi	a3,a3,1
 39c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 39e:	00054783          	lbu	a5,0(a0)
 3a2:	0005c703          	lbu	a4,0(a1)
 3a6:	00e79863          	bne	a5,a4,3b6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3aa:	0505                	addi	a0,a0,1
    p2++;
 3ac:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3ae:	fed518e3          	bne	a0,a3,39e <memcmp+0x14>
  }
  return 0;
 3b2:	4501                	li	a0,0
 3b4:	a019                	j	3ba <memcmp+0x30>
      return *p1 - *p2;
 3b6:	40e7853b          	subw	a0,a5,a4
}
 3ba:	6422                	ld	s0,8(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret
  return 0;
 3c0:	4501                	li	a0,0
 3c2:	bfe5                	j	3ba <memcmp+0x30>

00000000000003c4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3c4:	1141                	addi	sp,sp,-16
 3c6:	e406                	sd	ra,8(sp)
 3c8:	e022                	sd	s0,0(sp)
 3ca:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3cc:	00000097          	auipc	ra,0x0
 3d0:	f66080e7          	jalr	-154(ra) # 332 <memmove>
}
 3d4:	60a2                	ld	ra,8(sp)
 3d6:	6402                	ld	s0,0(sp)
 3d8:	0141                	addi	sp,sp,16
 3da:	8082                	ret

00000000000003dc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3dc:	4885                	li	a7,1
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3e4:	4889                	li	a7,2
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <wait>:
.global wait
wait:
 li a7, SYS_wait
 3ec:	488d                	li	a7,3
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3f4:	4891                	li	a7,4
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <read>:
.global read
read:
 li a7, SYS_read
 3fc:	4895                	li	a7,5
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <write>:
.global write
write:
 li a7, SYS_write
 404:	48c1                	li	a7,16
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <close>:
.global close
close:
 li a7, SYS_close
 40c:	48d5                	li	a7,21
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <kill>:
.global kill
kill:
 li a7, SYS_kill
 414:	4899                	li	a7,6
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <exec>:
.global exec
exec:
 li a7, SYS_exec
 41c:	489d                	li	a7,7
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <open>:
.global open
open:
 li a7, SYS_open
 424:	48bd                	li	a7,15
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 42c:	48c5                	li	a7,17
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 434:	48c9                	li	a7,18
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 43c:	48a1                	li	a7,8
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <link>:
.global link
link:
 li a7, SYS_link
 444:	48cd                	li	a7,19
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 44c:	48d1                	li	a7,20
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 454:	48a5                	li	a7,9
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <dup>:
.global dup
dup:
 li a7, SYS_dup
 45c:	48a9                	li	a7,10
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 464:	48ad                	li	a7,11
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 46c:	48b1                	li	a7,12
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 474:	48b5                	li	a7,13
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 47c:	48b9                	li	a7,14
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 484:	1101                	addi	sp,sp,-32
 486:	ec06                	sd	ra,24(sp)
 488:	e822                	sd	s0,16(sp)
 48a:	1000                	addi	s0,sp,32
 48c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 490:	4605                	li	a2,1
 492:	fef40593          	addi	a1,s0,-17
 496:	00000097          	auipc	ra,0x0
 49a:	f6e080e7          	jalr	-146(ra) # 404 <write>
}
 49e:	60e2                	ld	ra,24(sp)
 4a0:	6442                	ld	s0,16(sp)
 4a2:	6105                	addi	sp,sp,32
 4a4:	8082                	ret

00000000000004a6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4a6:	7139                	addi	sp,sp,-64
 4a8:	fc06                	sd	ra,56(sp)
 4aa:	f822                	sd	s0,48(sp)
 4ac:	f426                	sd	s1,40(sp)
 4ae:	f04a                	sd	s2,32(sp)
 4b0:	ec4e                	sd	s3,24(sp)
 4b2:	0080                	addi	s0,sp,64
 4b4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4b6:	c299                	beqz	a3,4bc <printint+0x16>
 4b8:	0805c963          	bltz	a1,54a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4bc:	2581                	sext.w	a1,a1
  neg = 0;
 4be:	4881                	li	a7,0
 4c0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4c4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4c6:	2601                	sext.w	a2,a2
 4c8:	00000517          	auipc	a0,0x0
 4cc:	4d850513          	addi	a0,a0,1240 # 9a0 <digits>
 4d0:	883a                	mv	a6,a4
 4d2:	2705                	addiw	a4,a4,1
 4d4:	02c5f7bb          	remuw	a5,a1,a2
 4d8:	1782                	slli	a5,a5,0x20
 4da:	9381                	srli	a5,a5,0x20
 4dc:	97aa                	add	a5,a5,a0
 4de:	0007c783          	lbu	a5,0(a5)
 4e2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4e6:	0005879b          	sext.w	a5,a1
 4ea:	02c5d5bb          	divuw	a1,a1,a2
 4ee:	0685                	addi	a3,a3,1
 4f0:	fec7f0e3          	bgeu	a5,a2,4d0 <printint+0x2a>
  if(neg)
 4f4:	00088c63          	beqz	a7,50c <printint+0x66>
    buf[i++] = '-';
 4f8:	fd070793          	addi	a5,a4,-48
 4fc:	00878733          	add	a4,a5,s0
 500:	02d00793          	li	a5,45
 504:	fef70823          	sb	a5,-16(a4)
 508:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 50c:	02e05863          	blez	a4,53c <printint+0x96>
 510:	fc040793          	addi	a5,s0,-64
 514:	00e78933          	add	s2,a5,a4
 518:	fff78993          	addi	s3,a5,-1
 51c:	99ba                	add	s3,s3,a4
 51e:	377d                	addiw	a4,a4,-1
 520:	1702                	slli	a4,a4,0x20
 522:	9301                	srli	a4,a4,0x20
 524:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 528:	fff94583          	lbu	a1,-1(s2)
 52c:	8526                	mv	a0,s1
 52e:	00000097          	auipc	ra,0x0
 532:	f56080e7          	jalr	-170(ra) # 484 <putc>
  while(--i >= 0)
 536:	197d                	addi	s2,s2,-1
 538:	ff3918e3          	bne	s2,s3,528 <printint+0x82>
}
 53c:	70e2                	ld	ra,56(sp)
 53e:	7442                	ld	s0,48(sp)
 540:	74a2                	ld	s1,40(sp)
 542:	7902                	ld	s2,32(sp)
 544:	69e2                	ld	s3,24(sp)
 546:	6121                	addi	sp,sp,64
 548:	8082                	ret
    x = -xx;
 54a:	40b005bb          	negw	a1,a1
    neg = 1;
 54e:	4885                	li	a7,1
    x = -xx;
 550:	bf85                	j	4c0 <printint+0x1a>

0000000000000552 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 552:	7119                	addi	sp,sp,-128
 554:	fc86                	sd	ra,120(sp)
 556:	f8a2                	sd	s0,112(sp)
 558:	f4a6                	sd	s1,104(sp)
 55a:	f0ca                	sd	s2,96(sp)
 55c:	ecce                	sd	s3,88(sp)
 55e:	e8d2                	sd	s4,80(sp)
 560:	e4d6                	sd	s5,72(sp)
 562:	e0da                	sd	s6,64(sp)
 564:	fc5e                	sd	s7,56(sp)
 566:	f862                	sd	s8,48(sp)
 568:	f466                	sd	s9,40(sp)
 56a:	f06a                	sd	s10,32(sp)
 56c:	ec6e                	sd	s11,24(sp)
 56e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 570:	0005c903          	lbu	s2,0(a1)
 574:	18090f63          	beqz	s2,712 <vprintf+0x1c0>
 578:	8aaa                	mv	s5,a0
 57a:	8b32                	mv	s6,a2
 57c:	00158493          	addi	s1,a1,1
  state = 0;
 580:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 582:	02500a13          	li	s4,37
 586:	4c55                	li	s8,21
 588:	00000c97          	auipc	s9,0x0
 58c:	3c0c8c93          	addi	s9,s9,960 # 948 <malloc+0x132>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 590:	02800d93          	li	s11,40
  putc(fd, 'x');
 594:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 596:	00000b97          	auipc	s7,0x0
 59a:	40ab8b93          	addi	s7,s7,1034 # 9a0 <digits>
 59e:	a839                	j	5bc <vprintf+0x6a>
        putc(fd, c);
 5a0:	85ca                	mv	a1,s2
 5a2:	8556                	mv	a0,s5
 5a4:	00000097          	auipc	ra,0x0
 5a8:	ee0080e7          	jalr	-288(ra) # 484 <putc>
 5ac:	a019                	j	5b2 <vprintf+0x60>
    } else if(state == '%'){
 5ae:	01498d63          	beq	s3,s4,5c8 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 5b2:	0485                	addi	s1,s1,1
 5b4:	fff4c903          	lbu	s2,-1(s1)
 5b8:	14090d63          	beqz	s2,712 <vprintf+0x1c0>
    if(state == 0){
 5bc:	fe0999e3          	bnez	s3,5ae <vprintf+0x5c>
      if(c == '%'){
 5c0:	ff4910e3          	bne	s2,s4,5a0 <vprintf+0x4e>
        state = '%';
 5c4:	89d2                	mv	s3,s4
 5c6:	b7f5                	j	5b2 <vprintf+0x60>
      if(c == 'd'){
 5c8:	11490c63          	beq	s2,s4,6e0 <vprintf+0x18e>
 5cc:	f9d9079b          	addiw	a5,s2,-99
 5d0:	0ff7f793          	zext.b	a5,a5
 5d4:	10fc6e63          	bltu	s8,a5,6f0 <vprintf+0x19e>
 5d8:	f9d9079b          	addiw	a5,s2,-99
 5dc:	0ff7f713          	zext.b	a4,a5
 5e0:	10ec6863          	bltu	s8,a4,6f0 <vprintf+0x19e>
 5e4:	00271793          	slli	a5,a4,0x2
 5e8:	97e6                	add	a5,a5,s9
 5ea:	439c                	lw	a5,0(a5)
 5ec:	97e6                	add	a5,a5,s9
 5ee:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5f0:	008b0913          	addi	s2,s6,8
 5f4:	4685                	li	a3,1
 5f6:	4629                	li	a2,10
 5f8:	000b2583          	lw	a1,0(s6)
 5fc:	8556                	mv	a0,s5
 5fe:	00000097          	auipc	ra,0x0
 602:	ea8080e7          	jalr	-344(ra) # 4a6 <printint>
 606:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 608:	4981                	li	s3,0
 60a:	b765                	j	5b2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 60c:	008b0913          	addi	s2,s6,8
 610:	4681                	li	a3,0
 612:	4629                	li	a2,10
 614:	000b2583          	lw	a1,0(s6)
 618:	8556                	mv	a0,s5
 61a:	00000097          	auipc	ra,0x0
 61e:	e8c080e7          	jalr	-372(ra) # 4a6 <printint>
 622:	8b4a                	mv	s6,s2
      state = 0;
 624:	4981                	li	s3,0
 626:	b771                	j	5b2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 628:	008b0913          	addi	s2,s6,8
 62c:	4681                	li	a3,0
 62e:	866a                	mv	a2,s10
 630:	000b2583          	lw	a1,0(s6)
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	e70080e7          	jalr	-400(ra) # 4a6 <printint>
 63e:	8b4a                	mv	s6,s2
      state = 0;
 640:	4981                	li	s3,0
 642:	bf85                	j	5b2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 644:	008b0793          	addi	a5,s6,8
 648:	f8f43423          	sd	a5,-120(s0)
 64c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 650:	03000593          	li	a1,48
 654:	8556                	mv	a0,s5
 656:	00000097          	auipc	ra,0x0
 65a:	e2e080e7          	jalr	-466(ra) # 484 <putc>
  putc(fd, 'x');
 65e:	07800593          	li	a1,120
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	e20080e7          	jalr	-480(ra) # 484 <putc>
 66c:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 66e:	03c9d793          	srli	a5,s3,0x3c
 672:	97de                	add	a5,a5,s7
 674:	0007c583          	lbu	a1,0(a5)
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	e0a080e7          	jalr	-502(ra) # 484 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 682:	0992                	slli	s3,s3,0x4
 684:	397d                	addiw	s2,s2,-1
 686:	fe0914e3          	bnez	s2,66e <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 68a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 68e:	4981                	li	s3,0
 690:	b70d                	j	5b2 <vprintf+0x60>
        s = va_arg(ap, char*);
 692:	008b0913          	addi	s2,s6,8
 696:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 69a:	02098163          	beqz	s3,6bc <vprintf+0x16a>
        while(*s != 0){
 69e:	0009c583          	lbu	a1,0(s3)
 6a2:	c5ad                	beqz	a1,70c <vprintf+0x1ba>
          putc(fd, *s);
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	dde080e7          	jalr	-546(ra) # 484 <putc>
          s++;
 6ae:	0985                	addi	s3,s3,1
        while(*s != 0){
 6b0:	0009c583          	lbu	a1,0(s3)
 6b4:	f9e5                	bnez	a1,6a4 <vprintf+0x152>
        s = va_arg(ap, char*);
 6b6:	8b4a                	mv	s6,s2
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	bde5                	j	5b2 <vprintf+0x60>
          s = "(null)";
 6bc:	00000997          	auipc	s3,0x0
 6c0:	28498993          	addi	s3,s3,644 # 940 <malloc+0x12a>
        while(*s != 0){
 6c4:	85ee                	mv	a1,s11
 6c6:	bff9                	j	6a4 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 6c8:	008b0913          	addi	s2,s6,8
 6cc:	000b4583          	lbu	a1,0(s6)
 6d0:	8556                	mv	a0,s5
 6d2:	00000097          	auipc	ra,0x0
 6d6:	db2080e7          	jalr	-590(ra) # 484 <putc>
 6da:	8b4a                	mv	s6,s2
      state = 0;
 6dc:	4981                	li	s3,0
 6de:	bdd1                	j	5b2 <vprintf+0x60>
        putc(fd, c);
 6e0:	85d2                	mv	a1,s4
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	da0080e7          	jalr	-608(ra) # 484 <putc>
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	b5d1                	j	5b2 <vprintf+0x60>
        putc(fd, '%');
 6f0:	85d2                	mv	a1,s4
 6f2:	8556                	mv	a0,s5
 6f4:	00000097          	auipc	ra,0x0
 6f8:	d90080e7          	jalr	-624(ra) # 484 <putc>
        putc(fd, c);
 6fc:	85ca                	mv	a1,s2
 6fe:	8556                	mv	a0,s5
 700:	00000097          	auipc	ra,0x0
 704:	d84080e7          	jalr	-636(ra) # 484 <putc>
      state = 0;
 708:	4981                	li	s3,0
 70a:	b565                	j	5b2 <vprintf+0x60>
        s = va_arg(ap, char*);
 70c:	8b4a                	mv	s6,s2
      state = 0;
 70e:	4981                	li	s3,0
 710:	b54d                	j	5b2 <vprintf+0x60>
    }
  }
}
 712:	70e6                	ld	ra,120(sp)
 714:	7446                	ld	s0,112(sp)
 716:	74a6                	ld	s1,104(sp)
 718:	7906                	ld	s2,96(sp)
 71a:	69e6                	ld	s3,88(sp)
 71c:	6a46                	ld	s4,80(sp)
 71e:	6aa6                	ld	s5,72(sp)
 720:	6b06                	ld	s6,64(sp)
 722:	7be2                	ld	s7,56(sp)
 724:	7c42                	ld	s8,48(sp)
 726:	7ca2                	ld	s9,40(sp)
 728:	7d02                	ld	s10,32(sp)
 72a:	6de2                	ld	s11,24(sp)
 72c:	6109                	addi	sp,sp,128
 72e:	8082                	ret

0000000000000730 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 730:	715d                	addi	sp,sp,-80
 732:	ec06                	sd	ra,24(sp)
 734:	e822                	sd	s0,16(sp)
 736:	1000                	addi	s0,sp,32
 738:	e010                	sd	a2,0(s0)
 73a:	e414                	sd	a3,8(s0)
 73c:	e818                	sd	a4,16(s0)
 73e:	ec1c                	sd	a5,24(s0)
 740:	03043023          	sd	a6,32(s0)
 744:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 748:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 74c:	8622                	mv	a2,s0
 74e:	00000097          	auipc	ra,0x0
 752:	e04080e7          	jalr	-508(ra) # 552 <vprintf>
}
 756:	60e2                	ld	ra,24(sp)
 758:	6442                	ld	s0,16(sp)
 75a:	6161                	addi	sp,sp,80
 75c:	8082                	ret

000000000000075e <printf>:

void
printf(const char *fmt, ...)
{
 75e:	711d                	addi	sp,sp,-96
 760:	ec06                	sd	ra,24(sp)
 762:	e822                	sd	s0,16(sp)
 764:	1000                	addi	s0,sp,32
 766:	e40c                	sd	a1,8(s0)
 768:	e810                	sd	a2,16(s0)
 76a:	ec14                	sd	a3,24(s0)
 76c:	f018                	sd	a4,32(s0)
 76e:	f41c                	sd	a5,40(s0)
 770:	03043823          	sd	a6,48(s0)
 774:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 778:	00840613          	addi	a2,s0,8
 77c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 780:	85aa                	mv	a1,a0
 782:	4505                	li	a0,1
 784:	00000097          	auipc	ra,0x0
 788:	dce080e7          	jalr	-562(ra) # 552 <vprintf>
}
 78c:	60e2                	ld	ra,24(sp)
 78e:	6442                	ld	s0,16(sp)
 790:	6125                	addi	sp,sp,96
 792:	8082                	ret

0000000000000794 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 794:	1141                	addi	sp,sp,-16
 796:	e422                	sd	s0,8(sp)
 798:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 79a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79e:	00001797          	auipc	a5,0x1
 7a2:	8627b783          	ld	a5,-1950(a5) # 1000 <freep>
 7a6:	a02d                	j	7d0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7a8:	4618                	lw	a4,8(a2)
 7aa:	9f2d                	addw	a4,a4,a1
 7ac:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b0:	6398                	ld	a4,0(a5)
 7b2:	6310                	ld	a2,0(a4)
 7b4:	a83d                	j	7f2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7b6:	ff852703          	lw	a4,-8(a0)
 7ba:	9f31                	addw	a4,a4,a2
 7bc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7be:	ff053683          	ld	a3,-16(a0)
 7c2:	a091                	j	806 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c4:	6398                	ld	a4,0(a5)
 7c6:	00e7e463          	bltu	a5,a4,7ce <free+0x3a>
 7ca:	00e6ea63          	bltu	a3,a4,7de <free+0x4a>
{
 7ce:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d0:	fed7fae3          	bgeu	a5,a3,7c4 <free+0x30>
 7d4:	6398                	ld	a4,0(a5)
 7d6:	00e6e463          	bltu	a3,a4,7de <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7da:	fee7eae3          	bltu	a5,a4,7ce <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7de:	ff852583          	lw	a1,-8(a0)
 7e2:	6390                	ld	a2,0(a5)
 7e4:	02059813          	slli	a6,a1,0x20
 7e8:	01c85713          	srli	a4,a6,0x1c
 7ec:	9736                	add	a4,a4,a3
 7ee:	fae60de3          	beq	a2,a4,7a8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7f2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7f6:	4790                	lw	a2,8(a5)
 7f8:	02061593          	slli	a1,a2,0x20
 7fc:	01c5d713          	srli	a4,a1,0x1c
 800:	973e                	add	a4,a4,a5
 802:	fae68ae3          	beq	a3,a4,7b6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 806:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 808:	00000717          	auipc	a4,0x0
 80c:	7ef73c23          	sd	a5,2040(a4) # 1000 <freep>
}
 810:	6422                	ld	s0,8(sp)
 812:	0141                	addi	sp,sp,16
 814:	8082                	ret

0000000000000816 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 816:	7139                	addi	sp,sp,-64
 818:	fc06                	sd	ra,56(sp)
 81a:	f822                	sd	s0,48(sp)
 81c:	f426                	sd	s1,40(sp)
 81e:	f04a                	sd	s2,32(sp)
 820:	ec4e                	sd	s3,24(sp)
 822:	e852                	sd	s4,16(sp)
 824:	e456                	sd	s5,8(sp)
 826:	e05a                	sd	s6,0(sp)
 828:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 82a:	02051493          	slli	s1,a0,0x20
 82e:	9081                	srli	s1,s1,0x20
 830:	04bd                	addi	s1,s1,15
 832:	8091                	srli	s1,s1,0x4
 834:	0014899b          	addiw	s3,s1,1
 838:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 83a:	00000517          	auipc	a0,0x0
 83e:	7c653503          	ld	a0,1990(a0) # 1000 <freep>
 842:	c515                	beqz	a0,86e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 844:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 846:	4798                	lw	a4,8(a5)
 848:	02977f63          	bgeu	a4,s1,886 <malloc+0x70>
 84c:	8a4e                	mv	s4,s3
 84e:	0009871b          	sext.w	a4,s3
 852:	6685                	lui	a3,0x1
 854:	00d77363          	bgeu	a4,a3,85a <malloc+0x44>
 858:	6a05                	lui	s4,0x1
 85a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 85e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 862:	00000917          	auipc	s2,0x0
 866:	79e90913          	addi	s2,s2,1950 # 1000 <freep>
  if(p == (char*)-1)
 86a:	5afd                	li	s5,-1
 86c:	a895                	j	8e0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 86e:	00000797          	auipc	a5,0x0
 872:	7a278793          	addi	a5,a5,1954 # 1010 <base>
 876:	00000717          	auipc	a4,0x0
 87a:	78f73523          	sd	a5,1930(a4) # 1000 <freep>
 87e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 880:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 884:	b7e1                	j	84c <malloc+0x36>
      if(p->s.size == nunits)
 886:	02e48c63          	beq	s1,a4,8be <malloc+0xa8>
        p->s.size -= nunits;
 88a:	4137073b          	subw	a4,a4,s3
 88e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 890:	02071693          	slli	a3,a4,0x20
 894:	01c6d713          	srli	a4,a3,0x1c
 898:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 89a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 89e:	00000717          	auipc	a4,0x0
 8a2:	76a73123          	sd	a0,1890(a4) # 1000 <freep>
      return (void*)(p + 1);
 8a6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8aa:	70e2                	ld	ra,56(sp)
 8ac:	7442                	ld	s0,48(sp)
 8ae:	74a2                	ld	s1,40(sp)
 8b0:	7902                	ld	s2,32(sp)
 8b2:	69e2                	ld	s3,24(sp)
 8b4:	6a42                	ld	s4,16(sp)
 8b6:	6aa2                	ld	s5,8(sp)
 8b8:	6b02                	ld	s6,0(sp)
 8ba:	6121                	addi	sp,sp,64
 8bc:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8be:	6398                	ld	a4,0(a5)
 8c0:	e118                	sd	a4,0(a0)
 8c2:	bff1                	j	89e <malloc+0x88>
  hp->s.size = nu;
 8c4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8c8:	0541                	addi	a0,a0,16
 8ca:	00000097          	auipc	ra,0x0
 8ce:	eca080e7          	jalr	-310(ra) # 794 <free>
  return freep;
 8d2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8d6:	d971                	beqz	a0,8aa <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8da:	4798                	lw	a4,8(a5)
 8dc:	fa9775e3          	bgeu	a4,s1,886 <malloc+0x70>
    if(p == freep)
 8e0:	00093703          	ld	a4,0(s2)
 8e4:	853e                	mv	a0,a5
 8e6:	fef719e3          	bne	a4,a5,8d8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8ea:	8552                	mv	a0,s4
 8ec:	00000097          	auipc	ra,0x0
 8f0:	b80080e7          	jalr	-1152(ra) # 46c <sbrk>
  if(p == (char*)-1)
 8f4:	fd5518e3          	bne	a0,s5,8c4 <malloc+0xae>
        return 0;
 8f8:	4501                	li	a0,0
 8fa:	bf45                	j	8aa <malloc+0x94>
