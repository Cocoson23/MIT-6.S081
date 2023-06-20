
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	bf0080e7          	jalr	-1040(ra) # 5c00 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	bde080e7          	jalr	-1058(ra) # 5c00 <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	0a250513          	addi	a0,a0,162 # 60e0 <malloc+0xee>
      46:	00006097          	auipc	ra,0x6
      4a:	ef4080e7          	jalr	-268(ra) # 5f3a <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00006097          	auipc	ra,0x6
      54:	b70080e7          	jalr	-1168(ra) # 5bc0 <exit>

0000000000000058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      58:	0000a797          	auipc	a5,0xa
      5c:	51078793          	addi	a5,a5,1296 # a568 <uninit>
      60:	0000d697          	auipc	a3,0xd
      64:	c1868693          	addi	a3,a3,-1000 # cc78 <buf>
    if(uninit[i] != '\0'){
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      6e:	0785                	addi	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
{
      76:	1141                	addi	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	08050513          	addi	a0,a0,128 # 6100 <malloc+0x10e>
      88:	00006097          	auipc	ra,0x6
      8c:	eb2080e7          	jalr	-334(ra) # 5f3a <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00006097          	auipc	ra,0x6
      96:	b2e080e7          	jalr	-1234(ra) # 5bc0 <exit>

000000000000009a <opentest>:
{
      9a:	1101                	addi	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	addi	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	07050513          	addi	a0,a0,112 # 6118 <malloc+0x126>
      b0:	00006097          	auipc	ra,0x6
      b4:	b50080e7          	jalr	-1200(ra) # 5c00 <open>
  if(fd < 0){
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00006097          	auipc	ra,0x6
      c0:	b2c080e7          	jalr	-1236(ra) # 5be8 <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	07250513          	addi	a0,a0,114 # 6138 <malloc+0x146>
      ce:	00006097          	auipc	ra,0x6
      d2:	b32080e7          	jalr	-1230(ra) # 5c00 <open>
  if(fd >= 0){
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	addi	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	03a50513          	addi	a0,a0,58 # 6120 <malloc+0x12e>
      ee:	00006097          	auipc	ra,0x6
      f2:	e4c080e7          	jalr	-436(ra) # 5f3a <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00006097          	auipc	ra,0x6
      fc:	ac8080e7          	jalr	-1336(ra) # 5bc0 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	04650513          	addi	a0,a0,70 # 6148 <malloc+0x156>
     10a:	00006097          	auipc	ra,0x6
     10e:	e30080e7          	jalr	-464(ra) # 5f3a <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00006097          	auipc	ra,0x6
     118:	aac080e7          	jalr	-1364(ra) # 5bc0 <exit>

000000000000011c <truncate2>:
{
     11c:	7179                	addi	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	addi	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	04450513          	addi	a0,a0,68 # 6170 <malloc+0x17e>
     134:	00006097          	auipc	ra,0x6
     138:	adc080e7          	jalr	-1316(ra) # 5c10 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	03050513          	addi	a0,a0,48 # 6170 <malloc+0x17e>
     148:	00006097          	auipc	ra,0x6
     14c:	ab8080e7          	jalr	-1352(ra) # 5c00 <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	02c58593          	addi	a1,a1,44 # 6180 <malloc+0x18e>
     15c:	00006097          	auipc	ra,0x6
     160:	a84080e7          	jalr	-1404(ra) # 5be0 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	00850513          	addi	a0,a0,8 # 6170 <malloc+0x17e>
     170:	00006097          	auipc	ra,0x6
     174:	a90080e7          	jalr	-1392(ra) # 5c00 <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	00c58593          	addi	a1,a1,12 # 6188 <malloc+0x196>
     184:	8526                	mv	a0,s1
     186:	00006097          	auipc	ra,0x6
     18a:	a5a080e7          	jalr	-1446(ra) # 5be0 <write>
  if(n != -1){
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	fdc50513          	addi	a0,a0,-36 # 6170 <malloc+0x17e>
     19c:	00006097          	auipc	ra,0x6
     1a0:	a74080e7          	jalr	-1420(ra) # 5c10 <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00006097          	auipc	ra,0x6
     1aa:	a42080e7          	jalr	-1470(ra) # 5be8 <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00006097          	auipc	ra,0x6
     1b4:	a38080e7          	jalr	-1480(ra) # 5be8 <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	addi	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	fc650513          	addi	a0,a0,-58 # 6190 <malloc+0x19e>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	d68080e7          	jalr	-664(ra) # 5f3a <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00006097          	auipc	ra,0x6
     1e0:	9e4080e7          	jalr	-1564(ra) # 5bc0 <exit>

00000000000001e4 <createtest>:
{
     1e4:	7179                	addi	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	addi	a0,s0,-40
     210:	00006097          	auipc	ra,0x6
     214:	9f0080e7          	jalr	-1552(ra) # 5c00 <open>
    close(fd);
     218:	00006097          	auipc	ra,0x6
     21c:	9d0080e7          	jalr	-1584(ra) # 5be8 <close>
  for(i = 0; i < N; i++){
     220:	2485                	addiw	s1,s1,1
     222:	0ff4f493          	zext.b	s1,s1
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	addi	a0,s0,-40
     246:	00006097          	auipc	ra,0x6
     24a:	9ca080e7          	jalr	-1590(ra) # 5c10 <unlink>
  for(i = 0; i < N; i++){
     24e:	2485                	addiw	s1,s1,1
     250:	0ff4f493          	zext.b	s1,s1
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
{
     264:	715d                	addi	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	addi	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	f3c50513          	addi	a0,a0,-196 # 61b8 <malloc+0x1c6>
     284:	00006097          	auipc	ra,0x6
     288:	98c080e7          	jalr	-1652(ra) # 5c10 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	f28a8a93          	addi	s5,s5,-216 # 61b8 <malloc+0x1c6>
      int cc = write(fd, buf, sz);
     298:	0000da17          	auipc	s4,0xd
     29c:	9e0a0a13          	addi	s4,s4,-1568 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	addi	s6,s6,457 # 31c9 <diskfull+0x7>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00006097          	auipc	ra,0x6
     2b0:	954080e7          	jalr	-1708(ra) # 5c00 <open>
     2b4:	892a                	mv	s2,a0
    if(fd < 0){
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00006097          	auipc	ra,0x6
     2c2:	922080e7          	jalr	-1758(ra) # 5be0 <write>
     2c6:	89aa                	mv	s3,a0
      if(cc != sz){
     2c8:	06a49263          	bne	s1,a0,32c <bigwrite+0xc8>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00006097          	auipc	ra,0x6
     2d6:	90e080e7          	jalr	-1778(ra) # 5be0 <write>
      if(cc != sz){
     2da:	04951a63          	bne	a0,s1,32e <bigwrite+0xca>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00006097          	auipc	ra,0x6
     2e4:	908080e7          	jalr	-1784(ra) # 5be8 <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00006097          	auipc	ra,0x6
     2ee:	926080e7          	jalr	-1754(ra) # 5c10 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f2:	1d74849b          	addiw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	addi	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	eb650513          	addi	a0,a0,-330 # 61c8 <malloc+0x1d6>
     31a:	00006097          	auipc	ra,0x6
     31e:	c20080e7          	jalr	-992(ra) # 5f3a <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00006097          	auipc	ra,0x6
     328:	89c080e7          	jalr	-1892(ra) # 5bc0 <exit>
      if(cc != sz){
     32c:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     32e:	86aa                	mv	a3,a0
     330:	864e                	mv	a2,s3
     332:	85de                	mv	a1,s7
     334:	00006517          	auipc	a0,0x6
     338:	eb450513          	addi	a0,a0,-332 # 61e8 <malloc+0x1f6>
     33c:	00006097          	auipc	ra,0x6
     340:	bfe080e7          	jalr	-1026(ra) # 5f3a <printf>
        exit(1);
     344:	4505                	li	a0,1
     346:	00006097          	auipc	ra,0x6
     34a:	87a080e7          	jalr	-1926(ra) # 5bc0 <exit>

000000000000034e <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     34e:	7179                	addi	sp,sp,-48
     350:	f406                	sd	ra,40(sp)
     352:	f022                	sd	s0,32(sp)
     354:	ec26                	sd	s1,24(sp)
     356:	e84a                	sd	s2,16(sp)
     358:	e44e                	sd	s3,8(sp)
     35a:	e052                	sd	s4,0(sp)
     35c:	1800                	addi	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
     35e:	00006517          	auipc	a0,0x6
     362:	ea250513          	addi	a0,a0,-350 # 6200 <malloc+0x20e>
     366:	00006097          	auipc	ra,0x6
     36a:	8aa080e7          	jalr	-1878(ra) # 5c10 <unlink>
     36e:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     372:	00006997          	auipc	s3,0x6
     376:	e8e98993          	addi	s3,s3,-370 # 6200 <malloc+0x20e>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     37a:	5a7d                	li	s4,-1
     37c:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     380:	20100593          	li	a1,513
     384:	854e                	mv	a0,s3
     386:	00006097          	auipc	ra,0x6
     38a:	87a080e7          	jalr	-1926(ra) # 5c00 <open>
     38e:	84aa                	mv	s1,a0
    if(fd < 0){
     390:	06054b63          	bltz	a0,406 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
     394:	4605                	li	a2,1
     396:	85d2                	mv	a1,s4
     398:	00006097          	auipc	ra,0x6
     39c:	848080e7          	jalr	-1976(ra) # 5be0 <write>
    close(fd);
     3a0:	8526                	mv	a0,s1
     3a2:	00006097          	auipc	ra,0x6
     3a6:	846080e7          	jalr	-1978(ra) # 5be8 <close>
    unlink("junk");
     3aa:	854e                	mv	a0,s3
     3ac:	00006097          	auipc	ra,0x6
     3b0:	864080e7          	jalr	-1948(ra) # 5c10 <unlink>
  for(int i = 0; i < assumed_free; i++){
     3b4:	397d                	addiw	s2,s2,-1
     3b6:	fc0915e3          	bnez	s2,380 <badwrite+0x32>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     3ba:	20100593          	li	a1,513
     3be:	00006517          	auipc	a0,0x6
     3c2:	e4250513          	addi	a0,a0,-446 # 6200 <malloc+0x20e>
     3c6:	00006097          	auipc	ra,0x6
     3ca:	83a080e7          	jalr	-1990(ra) # 5c00 <open>
     3ce:	84aa                	mv	s1,a0
  if(fd < 0){
     3d0:	04054863          	bltz	a0,420 <badwrite+0xd2>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     3d4:	4605                	li	a2,1
     3d6:	00006597          	auipc	a1,0x6
     3da:	db258593          	addi	a1,a1,-590 # 6188 <malloc+0x196>
     3de:	00006097          	auipc	ra,0x6
     3e2:	802080e7          	jalr	-2046(ra) # 5be0 <write>
     3e6:	4785                	li	a5,1
     3e8:	04f50963          	beq	a0,a5,43a <badwrite+0xec>
    printf("write failed\n");
     3ec:	00006517          	auipc	a0,0x6
     3f0:	e3450513          	addi	a0,a0,-460 # 6220 <malloc+0x22e>
     3f4:	00006097          	auipc	ra,0x6
     3f8:	b46080e7          	jalr	-1210(ra) # 5f3a <printf>
    exit(1);
     3fc:	4505                	li	a0,1
     3fe:	00005097          	auipc	ra,0x5
     402:	7c2080e7          	jalr	1986(ra) # 5bc0 <exit>
      printf("open junk failed\n");
     406:	00006517          	auipc	a0,0x6
     40a:	e0250513          	addi	a0,a0,-510 # 6208 <malloc+0x216>
     40e:	00006097          	auipc	ra,0x6
     412:	b2c080e7          	jalr	-1236(ra) # 5f3a <printf>
      exit(1);
     416:	4505                	li	a0,1
     418:	00005097          	auipc	ra,0x5
     41c:	7a8080e7          	jalr	1960(ra) # 5bc0 <exit>
    printf("open junk failed\n");
     420:	00006517          	auipc	a0,0x6
     424:	de850513          	addi	a0,a0,-536 # 6208 <malloc+0x216>
     428:	00006097          	auipc	ra,0x6
     42c:	b12080e7          	jalr	-1262(ra) # 5f3a <printf>
    exit(1);
     430:	4505                	li	a0,1
     432:	00005097          	auipc	ra,0x5
     436:	78e080e7          	jalr	1934(ra) # 5bc0 <exit>
  }
  close(fd);
     43a:	8526                	mv	a0,s1
     43c:	00005097          	auipc	ra,0x5
     440:	7ac080e7          	jalr	1964(ra) # 5be8 <close>
  unlink("junk");
     444:	00006517          	auipc	a0,0x6
     448:	dbc50513          	addi	a0,a0,-580 # 6200 <malloc+0x20e>
     44c:	00005097          	auipc	ra,0x5
     450:	7c4080e7          	jalr	1988(ra) # 5c10 <unlink>

  exit(0);
     454:	4501                	li	a0,0
     456:	00005097          	auipc	ra,0x5
     45a:	76a080e7          	jalr	1898(ra) # 5bc0 <exit>

000000000000045e <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     45e:	715d                	addi	sp,sp,-80
     460:	e486                	sd	ra,72(sp)
     462:	e0a2                	sd	s0,64(sp)
     464:	fc26                	sd	s1,56(sp)
     466:	f84a                	sd	s2,48(sp)
     468:	f44e                	sd	s3,40(sp)
     46a:	0880                	addi	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     46c:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     46e:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     472:	40000993          	li	s3,1024
    name[0] = 'z';
     476:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     47a:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     47e:	41f4d71b          	sraiw	a4,s1,0x1f
     482:	01b7571b          	srliw	a4,a4,0x1b
     486:	009707bb          	addw	a5,a4,s1
     48a:	4057d69b          	sraiw	a3,a5,0x5
     48e:	0306869b          	addiw	a3,a3,48
     492:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     496:	8bfd                	andi	a5,a5,31
     498:	9f99                	subw	a5,a5,a4
     49a:	0307879b          	addiw	a5,a5,48
     49e:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     4a2:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     4a6:	fb040513          	addi	a0,s0,-80
     4aa:	00005097          	auipc	ra,0x5
     4ae:	766080e7          	jalr	1894(ra) # 5c10 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     4b2:	60200593          	li	a1,1538
     4b6:	fb040513          	addi	a0,s0,-80
     4ba:	00005097          	auipc	ra,0x5
     4be:	746080e7          	jalr	1862(ra) # 5c00 <open>
    if(fd < 0){
     4c2:	00054963          	bltz	a0,4d4 <outofinodes+0x76>
      // failure is eventually expected.
      break;
    }
    close(fd);
     4c6:	00005097          	auipc	ra,0x5
     4ca:	722080e7          	jalr	1826(ra) # 5be8 <close>
  for(int i = 0; i < nzz; i++){
     4ce:	2485                	addiw	s1,s1,1
     4d0:	fb3493e3          	bne	s1,s3,476 <outofinodes+0x18>
     4d4:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     4d6:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     4da:	40000993          	li	s3,1024
    name[0] = 'z';
     4de:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     4e2:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     4e6:	41f4d71b          	sraiw	a4,s1,0x1f
     4ea:	01b7571b          	srliw	a4,a4,0x1b
     4ee:	009707bb          	addw	a5,a4,s1
     4f2:	4057d69b          	sraiw	a3,a5,0x5
     4f6:	0306869b          	addiw	a3,a3,48
     4fa:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     4fe:	8bfd                	andi	a5,a5,31
     500:	9f99                	subw	a5,a5,a4
     502:	0307879b          	addiw	a5,a5,48
     506:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     50a:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     50e:	fb040513          	addi	a0,s0,-80
     512:	00005097          	auipc	ra,0x5
     516:	6fe080e7          	jalr	1790(ra) # 5c10 <unlink>
  for(int i = 0; i < nzz; i++){
     51a:	2485                	addiw	s1,s1,1
     51c:	fd3491e3          	bne	s1,s3,4de <outofinodes+0x80>
  }
}
     520:	60a6                	ld	ra,72(sp)
     522:	6406                	ld	s0,64(sp)
     524:	74e2                	ld	s1,56(sp)
     526:	7942                	ld	s2,48(sp)
     528:	79a2                	ld	s3,40(sp)
     52a:	6161                	addi	sp,sp,80
     52c:	8082                	ret

000000000000052e <copyin>:
{
     52e:	715d                	addi	sp,sp,-80
     530:	e486                	sd	ra,72(sp)
     532:	e0a2                	sd	s0,64(sp)
     534:	fc26                	sd	s1,56(sp)
     536:	f84a                	sd	s2,48(sp)
     538:	f44e                	sd	s3,40(sp)
     53a:	f052                	sd	s4,32(sp)
     53c:	0880                	addi	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     53e:	4785                	li	a5,1
     540:	07fe                	slli	a5,a5,0x1f
     542:	fcf43023          	sd	a5,-64(s0)
     546:	57fd                	li	a5,-1
     548:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     54c:	fc040913          	addi	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     550:	00006a17          	auipc	s4,0x6
     554:	ce0a0a13          	addi	s4,s4,-800 # 6230 <malloc+0x23e>
    uint64 addr = addrs[ai];
     558:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     55c:	20100593          	li	a1,513
     560:	8552                	mv	a0,s4
     562:	00005097          	auipc	ra,0x5
     566:	69e080e7          	jalr	1694(ra) # 5c00 <open>
     56a:	84aa                	mv	s1,a0
    if(fd < 0){
     56c:	08054863          	bltz	a0,5fc <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     570:	6609                	lui	a2,0x2
     572:	85ce                	mv	a1,s3
     574:	00005097          	auipc	ra,0x5
     578:	66c080e7          	jalr	1644(ra) # 5be0 <write>
    if(n >= 0){
     57c:	08055d63          	bgez	a0,616 <copyin+0xe8>
    close(fd);
     580:	8526                	mv	a0,s1
     582:	00005097          	auipc	ra,0x5
     586:	666080e7          	jalr	1638(ra) # 5be8 <close>
    unlink("copyin1");
     58a:	8552                	mv	a0,s4
     58c:	00005097          	auipc	ra,0x5
     590:	684080e7          	jalr	1668(ra) # 5c10 <unlink>
    n = write(1, (char*)addr, 8192);
     594:	6609                	lui	a2,0x2
     596:	85ce                	mv	a1,s3
     598:	4505                	li	a0,1
     59a:	00005097          	auipc	ra,0x5
     59e:	646080e7          	jalr	1606(ra) # 5be0 <write>
    if(n > 0){
     5a2:	08a04963          	bgtz	a0,634 <copyin+0x106>
    if(pipe(fds) < 0){
     5a6:	fb840513          	addi	a0,s0,-72
     5aa:	00005097          	auipc	ra,0x5
     5ae:	626080e7          	jalr	1574(ra) # 5bd0 <pipe>
     5b2:	0a054063          	bltz	a0,652 <copyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
     5b6:	6609                	lui	a2,0x2
     5b8:	85ce                	mv	a1,s3
     5ba:	fbc42503          	lw	a0,-68(s0)
     5be:	00005097          	auipc	ra,0x5
     5c2:	622080e7          	jalr	1570(ra) # 5be0 <write>
    if(n > 0){
     5c6:	0aa04363          	bgtz	a0,66c <copyin+0x13e>
    close(fds[0]);
     5ca:	fb842503          	lw	a0,-72(s0)
     5ce:	00005097          	auipc	ra,0x5
     5d2:	61a080e7          	jalr	1562(ra) # 5be8 <close>
    close(fds[1]);
     5d6:	fbc42503          	lw	a0,-68(s0)
     5da:	00005097          	auipc	ra,0x5
     5de:	60e080e7          	jalr	1550(ra) # 5be8 <close>
  for(int ai = 0; ai < 2; ai++){
     5e2:	0921                	addi	s2,s2,8
     5e4:	fd040793          	addi	a5,s0,-48
     5e8:	f6f918e3          	bne	s2,a5,558 <copyin+0x2a>
}
     5ec:	60a6                	ld	ra,72(sp)
     5ee:	6406                	ld	s0,64(sp)
     5f0:	74e2                	ld	s1,56(sp)
     5f2:	7942                	ld	s2,48(sp)
     5f4:	79a2                	ld	s3,40(sp)
     5f6:	7a02                	ld	s4,32(sp)
     5f8:	6161                	addi	sp,sp,80
     5fa:	8082                	ret
      printf("open(copyin1) failed\n");
     5fc:	00006517          	auipc	a0,0x6
     600:	c3c50513          	addi	a0,a0,-964 # 6238 <malloc+0x246>
     604:	00006097          	auipc	ra,0x6
     608:	936080e7          	jalr	-1738(ra) # 5f3a <printf>
      exit(1);
     60c:	4505                	li	a0,1
     60e:	00005097          	auipc	ra,0x5
     612:	5b2080e7          	jalr	1458(ra) # 5bc0 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     616:	862a                	mv	a2,a0
     618:	85ce                	mv	a1,s3
     61a:	00006517          	auipc	a0,0x6
     61e:	c3650513          	addi	a0,a0,-970 # 6250 <malloc+0x25e>
     622:	00006097          	auipc	ra,0x6
     626:	918080e7          	jalr	-1768(ra) # 5f3a <printf>
      exit(1);
     62a:	4505                	li	a0,1
     62c:	00005097          	auipc	ra,0x5
     630:	594080e7          	jalr	1428(ra) # 5bc0 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     634:	862a                	mv	a2,a0
     636:	85ce                	mv	a1,s3
     638:	00006517          	auipc	a0,0x6
     63c:	c4850513          	addi	a0,a0,-952 # 6280 <malloc+0x28e>
     640:	00006097          	auipc	ra,0x6
     644:	8fa080e7          	jalr	-1798(ra) # 5f3a <printf>
      exit(1);
     648:	4505                	li	a0,1
     64a:	00005097          	auipc	ra,0x5
     64e:	576080e7          	jalr	1398(ra) # 5bc0 <exit>
      printf("pipe() failed\n");
     652:	00006517          	auipc	a0,0x6
     656:	c5e50513          	addi	a0,a0,-930 # 62b0 <malloc+0x2be>
     65a:	00006097          	auipc	ra,0x6
     65e:	8e0080e7          	jalr	-1824(ra) # 5f3a <printf>
      exit(1);
     662:	4505                	li	a0,1
     664:	00005097          	auipc	ra,0x5
     668:	55c080e7          	jalr	1372(ra) # 5bc0 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     66c:	862a                	mv	a2,a0
     66e:	85ce                	mv	a1,s3
     670:	00006517          	auipc	a0,0x6
     674:	c5050513          	addi	a0,a0,-944 # 62c0 <malloc+0x2ce>
     678:	00006097          	auipc	ra,0x6
     67c:	8c2080e7          	jalr	-1854(ra) # 5f3a <printf>
      exit(1);
     680:	4505                	li	a0,1
     682:	00005097          	auipc	ra,0x5
     686:	53e080e7          	jalr	1342(ra) # 5bc0 <exit>

000000000000068a <copyout>:
{
     68a:	711d                	addi	sp,sp,-96
     68c:	ec86                	sd	ra,88(sp)
     68e:	e8a2                	sd	s0,80(sp)
     690:	e4a6                	sd	s1,72(sp)
     692:	e0ca                	sd	s2,64(sp)
     694:	fc4e                	sd	s3,56(sp)
     696:	f852                	sd	s4,48(sp)
     698:	f456                	sd	s5,40(sp)
     69a:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     69c:	4785                	li	a5,1
     69e:	07fe                	slli	a5,a5,0x1f
     6a0:	faf43823          	sd	a5,-80(s0)
     6a4:	57fd                	li	a5,-1
     6a6:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     6aa:	fb040913          	addi	s2,s0,-80
    int fd = open("README", 0);
     6ae:	00006a17          	auipc	s4,0x6
     6b2:	c42a0a13          	addi	s4,s4,-958 # 62f0 <malloc+0x2fe>
    n = write(fds[1], "x", 1);
     6b6:	00006a97          	auipc	s5,0x6
     6ba:	ad2a8a93          	addi	s5,s5,-1326 # 6188 <malloc+0x196>
    uint64 addr = addrs[ai];
     6be:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     6c2:	4581                	li	a1,0
     6c4:	8552                	mv	a0,s4
     6c6:	00005097          	auipc	ra,0x5
     6ca:	53a080e7          	jalr	1338(ra) # 5c00 <open>
     6ce:	84aa                	mv	s1,a0
    if(fd < 0){
     6d0:	08054663          	bltz	a0,75c <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     6d4:	6609                	lui	a2,0x2
     6d6:	85ce                	mv	a1,s3
     6d8:	00005097          	auipc	ra,0x5
     6dc:	500080e7          	jalr	1280(ra) # 5bd8 <read>
    if(n > 0){
     6e0:	08a04b63          	bgtz	a0,776 <copyout+0xec>
    close(fd);
     6e4:	8526                	mv	a0,s1
     6e6:	00005097          	auipc	ra,0x5
     6ea:	502080e7          	jalr	1282(ra) # 5be8 <close>
    if(pipe(fds) < 0){
     6ee:	fa840513          	addi	a0,s0,-88
     6f2:	00005097          	auipc	ra,0x5
     6f6:	4de080e7          	jalr	1246(ra) # 5bd0 <pipe>
     6fa:	08054d63          	bltz	a0,794 <copyout+0x10a>
    n = write(fds[1], "x", 1);
     6fe:	4605                	li	a2,1
     700:	85d6                	mv	a1,s5
     702:	fac42503          	lw	a0,-84(s0)
     706:	00005097          	auipc	ra,0x5
     70a:	4da080e7          	jalr	1242(ra) # 5be0 <write>
    if(n != 1){
     70e:	4785                	li	a5,1
     710:	08f51f63          	bne	a0,a5,7ae <copyout+0x124>
    n = read(fds[0], (void*)addr, 8192);
     714:	6609                	lui	a2,0x2
     716:	85ce                	mv	a1,s3
     718:	fa842503          	lw	a0,-88(s0)
     71c:	00005097          	auipc	ra,0x5
     720:	4bc080e7          	jalr	1212(ra) # 5bd8 <read>
    if(n > 0){
     724:	0aa04263          	bgtz	a0,7c8 <copyout+0x13e>
    close(fds[0]);
     728:	fa842503          	lw	a0,-88(s0)
     72c:	00005097          	auipc	ra,0x5
     730:	4bc080e7          	jalr	1212(ra) # 5be8 <close>
    close(fds[1]);
     734:	fac42503          	lw	a0,-84(s0)
     738:	00005097          	auipc	ra,0x5
     73c:	4b0080e7          	jalr	1200(ra) # 5be8 <close>
  for(int ai = 0; ai < 2; ai++){
     740:	0921                	addi	s2,s2,8
     742:	fc040793          	addi	a5,s0,-64
     746:	f6f91ce3          	bne	s2,a5,6be <copyout+0x34>
}
     74a:	60e6                	ld	ra,88(sp)
     74c:	6446                	ld	s0,80(sp)
     74e:	64a6                	ld	s1,72(sp)
     750:	6906                	ld	s2,64(sp)
     752:	79e2                	ld	s3,56(sp)
     754:	7a42                	ld	s4,48(sp)
     756:	7aa2                	ld	s5,40(sp)
     758:	6125                	addi	sp,sp,96
     75a:	8082                	ret
      printf("open(README) failed\n");
     75c:	00006517          	auipc	a0,0x6
     760:	b9c50513          	addi	a0,a0,-1124 # 62f8 <malloc+0x306>
     764:	00005097          	auipc	ra,0x5
     768:	7d6080e7          	jalr	2006(ra) # 5f3a <printf>
      exit(1);
     76c:	4505                	li	a0,1
     76e:	00005097          	auipc	ra,0x5
     772:	452080e7          	jalr	1106(ra) # 5bc0 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     776:	862a                	mv	a2,a0
     778:	85ce                	mv	a1,s3
     77a:	00006517          	auipc	a0,0x6
     77e:	b9650513          	addi	a0,a0,-1130 # 6310 <malloc+0x31e>
     782:	00005097          	auipc	ra,0x5
     786:	7b8080e7          	jalr	1976(ra) # 5f3a <printf>
      exit(1);
     78a:	4505                	li	a0,1
     78c:	00005097          	auipc	ra,0x5
     790:	434080e7          	jalr	1076(ra) # 5bc0 <exit>
      printf("pipe() failed\n");
     794:	00006517          	auipc	a0,0x6
     798:	b1c50513          	addi	a0,a0,-1252 # 62b0 <malloc+0x2be>
     79c:	00005097          	auipc	ra,0x5
     7a0:	79e080e7          	jalr	1950(ra) # 5f3a <printf>
      exit(1);
     7a4:	4505                	li	a0,1
     7a6:	00005097          	auipc	ra,0x5
     7aa:	41a080e7          	jalr	1050(ra) # 5bc0 <exit>
      printf("pipe write failed\n");
     7ae:	00006517          	auipc	a0,0x6
     7b2:	b9250513          	addi	a0,a0,-1134 # 6340 <malloc+0x34e>
     7b6:	00005097          	auipc	ra,0x5
     7ba:	784080e7          	jalr	1924(ra) # 5f3a <printf>
      exit(1);
     7be:	4505                	li	a0,1
     7c0:	00005097          	auipc	ra,0x5
     7c4:	400080e7          	jalr	1024(ra) # 5bc0 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     7c8:	862a                	mv	a2,a0
     7ca:	85ce                	mv	a1,s3
     7cc:	00006517          	auipc	a0,0x6
     7d0:	b8c50513          	addi	a0,a0,-1140 # 6358 <malloc+0x366>
     7d4:	00005097          	auipc	ra,0x5
     7d8:	766080e7          	jalr	1894(ra) # 5f3a <printf>
      exit(1);
     7dc:	4505                	li	a0,1
     7de:	00005097          	auipc	ra,0x5
     7e2:	3e2080e7          	jalr	994(ra) # 5bc0 <exit>

00000000000007e6 <truncate1>:
{
     7e6:	711d                	addi	sp,sp,-96
     7e8:	ec86                	sd	ra,88(sp)
     7ea:	e8a2                	sd	s0,80(sp)
     7ec:	e4a6                	sd	s1,72(sp)
     7ee:	e0ca                	sd	s2,64(sp)
     7f0:	fc4e                	sd	s3,56(sp)
     7f2:	f852                	sd	s4,48(sp)
     7f4:	f456                	sd	s5,40(sp)
     7f6:	1080                	addi	s0,sp,96
     7f8:	8aaa                	mv	s5,a0
  unlink("truncfile");
     7fa:	00006517          	auipc	a0,0x6
     7fe:	97650513          	addi	a0,a0,-1674 # 6170 <malloc+0x17e>
     802:	00005097          	auipc	ra,0x5
     806:	40e080e7          	jalr	1038(ra) # 5c10 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     80a:	60100593          	li	a1,1537
     80e:	00006517          	auipc	a0,0x6
     812:	96250513          	addi	a0,a0,-1694 # 6170 <malloc+0x17e>
     816:	00005097          	auipc	ra,0x5
     81a:	3ea080e7          	jalr	1002(ra) # 5c00 <open>
     81e:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     820:	4611                	li	a2,4
     822:	00006597          	auipc	a1,0x6
     826:	95e58593          	addi	a1,a1,-1698 # 6180 <malloc+0x18e>
     82a:	00005097          	auipc	ra,0x5
     82e:	3b6080e7          	jalr	950(ra) # 5be0 <write>
  close(fd1);
     832:	8526                	mv	a0,s1
     834:	00005097          	auipc	ra,0x5
     838:	3b4080e7          	jalr	948(ra) # 5be8 <close>
  int fd2 = open("truncfile", O_RDONLY);
     83c:	4581                	li	a1,0
     83e:	00006517          	auipc	a0,0x6
     842:	93250513          	addi	a0,a0,-1742 # 6170 <malloc+0x17e>
     846:	00005097          	auipc	ra,0x5
     84a:	3ba080e7          	jalr	954(ra) # 5c00 <open>
     84e:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     850:	02000613          	li	a2,32
     854:	fa040593          	addi	a1,s0,-96
     858:	00005097          	auipc	ra,0x5
     85c:	380080e7          	jalr	896(ra) # 5bd8 <read>
  if(n != 4){
     860:	4791                	li	a5,4
     862:	0cf51e63          	bne	a0,a5,93e <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     866:	40100593          	li	a1,1025
     86a:	00006517          	auipc	a0,0x6
     86e:	90650513          	addi	a0,a0,-1786 # 6170 <malloc+0x17e>
     872:	00005097          	auipc	ra,0x5
     876:	38e080e7          	jalr	910(ra) # 5c00 <open>
     87a:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     87c:	4581                	li	a1,0
     87e:	00006517          	auipc	a0,0x6
     882:	8f250513          	addi	a0,a0,-1806 # 6170 <malloc+0x17e>
     886:	00005097          	auipc	ra,0x5
     88a:	37a080e7          	jalr	890(ra) # 5c00 <open>
     88e:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     890:	02000613          	li	a2,32
     894:	fa040593          	addi	a1,s0,-96
     898:	00005097          	auipc	ra,0x5
     89c:	340080e7          	jalr	832(ra) # 5bd8 <read>
     8a0:	8a2a                	mv	s4,a0
  if(n != 0){
     8a2:	ed4d                	bnez	a0,95c <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     8a4:	02000613          	li	a2,32
     8a8:	fa040593          	addi	a1,s0,-96
     8ac:	8526                	mv	a0,s1
     8ae:	00005097          	auipc	ra,0x5
     8b2:	32a080e7          	jalr	810(ra) # 5bd8 <read>
     8b6:	8a2a                	mv	s4,a0
  if(n != 0){
     8b8:	e971                	bnez	a0,98c <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     8ba:	4619                	li	a2,6
     8bc:	00006597          	auipc	a1,0x6
     8c0:	b2c58593          	addi	a1,a1,-1236 # 63e8 <malloc+0x3f6>
     8c4:	854e                	mv	a0,s3
     8c6:	00005097          	auipc	ra,0x5
     8ca:	31a080e7          	jalr	794(ra) # 5be0 <write>
  n = read(fd3, buf, sizeof(buf));
     8ce:	02000613          	li	a2,32
     8d2:	fa040593          	addi	a1,s0,-96
     8d6:	854a                	mv	a0,s2
     8d8:	00005097          	auipc	ra,0x5
     8dc:	300080e7          	jalr	768(ra) # 5bd8 <read>
  if(n != 6){
     8e0:	4799                	li	a5,6
     8e2:	0cf51d63          	bne	a0,a5,9bc <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     8e6:	02000613          	li	a2,32
     8ea:	fa040593          	addi	a1,s0,-96
     8ee:	8526                	mv	a0,s1
     8f0:	00005097          	auipc	ra,0x5
     8f4:	2e8080e7          	jalr	744(ra) # 5bd8 <read>
  if(n != 2){
     8f8:	4789                	li	a5,2
     8fa:	0ef51063          	bne	a0,a5,9da <truncate1+0x1f4>
  unlink("truncfile");
     8fe:	00006517          	auipc	a0,0x6
     902:	87250513          	addi	a0,a0,-1934 # 6170 <malloc+0x17e>
     906:	00005097          	auipc	ra,0x5
     90a:	30a080e7          	jalr	778(ra) # 5c10 <unlink>
  close(fd1);
     90e:	854e                	mv	a0,s3
     910:	00005097          	auipc	ra,0x5
     914:	2d8080e7          	jalr	728(ra) # 5be8 <close>
  close(fd2);
     918:	8526                	mv	a0,s1
     91a:	00005097          	auipc	ra,0x5
     91e:	2ce080e7          	jalr	718(ra) # 5be8 <close>
  close(fd3);
     922:	854a                	mv	a0,s2
     924:	00005097          	auipc	ra,0x5
     928:	2c4080e7          	jalr	708(ra) # 5be8 <close>
}
     92c:	60e6                	ld	ra,88(sp)
     92e:	6446                	ld	s0,80(sp)
     930:	64a6                	ld	s1,72(sp)
     932:	6906                	ld	s2,64(sp)
     934:	79e2                	ld	s3,56(sp)
     936:	7a42                	ld	s4,48(sp)
     938:	7aa2                	ld	s5,40(sp)
     93a:	6125                	addi	sp,sp,96
     93c:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     93e:	862a                	mv	a2,a0
     940:	85d6                	mv	a1,s5
     942:	00006517          	auipc	a0,0x6
     946:	a4650513          	addi	a0,a0,-1466 # 6388 <malloc+0x396>
     94a:	00005097          	auipc	ra,0x5
     94e:	5f0080e7          	jalr	1520(ra) # 5f3a <printf>
    exit(1);
     952:	4505                	li	a0,1
     954:	00005097          	auipc	ra,0x5
     958:	26c080e7          	jalr	620(ra) # 5bc0 <exit>
    printf("aaa fd3=%d\n", fd3);
     95c:	85ca                	mv	a1,s2
     95e:	00006517          	auipc	a0,0x6
     962:	a4a50513          	addi	a0,a0,-1462 # 63a8 <malloc+0x3b6>
     966:	00005097          	auipc	ra,0x5
     96a:	5d4080e7          	jalr	1492(ra) # 5f3a <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     96e:	8652                	mv	a2,s4
     970:	85d6                	mv	a1,s5
     972:	00006517          	auipc	a0,0x6
     976:	a4650513          	addi	a0,a0,-1466 # 63b8 <malloc+0x3c6>
     97a:	00005097          	auipc	ra,0x5
     97e:	5c0080e7          	jalr	1472(ra) # 5f3a <printf>
    exit(1);
     982:	4505                	li	a0,1
     984:	00005097          	auipc	ra,0x5
     988:	23c080e7          	jalr	572(ra) # 5bc0 <exit>
    printf("bbb fd2=%d\n", fd2);
     98c:	85a6                	mv	a1,s1
     98e:	00006517          	auipc	a0,0x6
     992:	a4a50513          	addi	a0,a0,-1462 # 63d8 <malloc+0x3e6>
     996:	00005097          	auipc	ra,0x5
     99a:	5a4080e7          	jalr	1444(ra) # 5f3a <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     99e:	8652                	mv	a2,s4
     9a0:	85d6                	mv	a1,s5
     9a2:	00006517          	auipc	a0,0x6
     9a6:	a1650513          	addi	a0,a0,-1514 # 63b8 <malloc+0x3c6>
     9aa:	00005097          	auipc	ra,0x5
     9ae:	590080e7          	jalr	1424(ra) # 5f3a <printf>
    exit(1);
     9b2:	4505                	li	a0,1
     9b4:	00005097          	auipc	ra,0x5
     9b8:	20c080e7          	jalr	524(ra) # 5bc0 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     9bc:	862a                	mv	a2,a0
     9be:	85d6                	mv	a1,s5
     9c0:	00006517          	auipc	a0,0x6
     9c4:	a3050513          	addi	a0,a0,-1488 # 63f0 <malloc+0x3fe>
     9c8:	00005097          	auipc	ra,0x5
     9cc:	572080e7          	jalr	1394(ra) # 5f3a <printf>
    exit(1);
     9d0:	4505                	li	a0,1
     9d2:	00005097          	auipc	ra,0x5
     9d6:	1ee080e7          	jalr	494(ra) # 5bc0 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     9da:	862a                	mv	a2,a0
     9dc:	85d6                	mv	a1,s5
     9de:	00006517          	auipc	a0,0x6
     9e2:	a3250513          	addi	a0,a0,-1486 # 6410 <malloc+0x41e>
     9e6:	00005097          	auipc	ra,0x5
     9ea:	554080e7          	jalr	1364(ra) # 5f3a <printf>
    exit(1);
     9ee:	4505                	li	a0,1
     9f0:	00005097          	auipc	ra,0x5
     9f4:	1d0080e7          	jalr	464(ra) # 5bc0 <exit>

00000000000009f8 <writetest>:
{
     9f8:	7139                	addi	sp,sp,-64
     9fa:	fc06                	sd	ra,56(sp)
     9fc:	f822                	sd	s0,48(sp)
     9fe:	f426                	sd	s1,40(sp)
     a00:	f04a                	sd	s2,32(sp)
     a02:	ec4e                	sd	s3,24(sp)
     a04:	e852                	sd	s4,16(sp)
     a06:	e456                	sd	s5,8(sp)
     a08:	e05a                	sd	s6,0(sp)
     a0a:	0080                	addi	s0,sp,64
     a0c:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     a0e:	20200593          	li	a1,514
     a12:	00006517          	auipc	a0,0x6
     a16:	a1e50513          	addi	a0,a0,-1506 # 6430 <malloc+0x43e>
     a1a:	00005097          	auipc	ra,0x5
     a1e:	1e6080e7          	jalr	486(ra) # 5c00 <open>
  if(fd < 0){
     a22:	0a054d63          	bltz	a0,adc <writetest+0xe4>
     a26:	892a                	mv	s2,a0
     a28:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a2a:	00006997          	auipc	s3,0x6
     a2e:	a2e98993          	addi	s3,s3,-1490 # 6458 <malloc+0x466>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a32:	00006a97          	auipc	s5,0x6
     a36:	a5ea8a93          	addi	s5,s5,-1442 # 6490 <malloc+0x49e>
  for(i = 0; i < N; i++){
     a3a:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a3e:	4629                	li	a2,10
     a40:	85ce                	mv	a1,s3
     a42:	854a                	mv	a0,s2
     a44:	00005097          	auipc	ra,0x5
     a48:	19c080e7          	jalr	412(ra) # 5be0 <write>
     a4c:	47a9                	li	a5,10
     a4e:	0af51563          	bne	a0,a5,af8 <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a52:	4629                	li	a2,10
     a54:	85d6                	mv	a1,s5
     a56:	854a                	mv	a0,s2
     a58:	00005097          	auipc	ra,0x5
     a5c:	188080e7          	jalr	392(ra) # 5be0 <write>
     a60:	47a9                	li	a5,10
     a62:	0af51a63          	bne	a0,a5,b16 <writetest+0x11e>
  for(i = 0; i < N; i++){
     a66:	2485                	addiw	s1,s1,1
     a68:	fd449be3          	bne	s1,s4,a3e <writetest+0x46>
  close(fd);
     a6c:	854a                	mv	a0,s2
     a6e:	00005097          	auipc	ra,0x5
     a72:	17a080e7          	jalr	378(ra) # 5be8 <close>
  fd = open("small", O_RDONLY);
     a76:	4581                	li	a1,0
     a78:	00006517          	auipc	a0,0x6
     a7c:	9b850513          	addi	a0,a0,-1608 # 6430 <malloc+0x43e>
     a80:	00005097          	auipc	ra,0x5
     a84:	180080e7          	jalr	384(ra) # 5c00 <open>
     a88:	84aa                	mv	s1,a0
  if(fd < 0){
     a8a:	0a054563          	bltz	a0,b34 <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     a8e:	7d000613          	li	a2,2000
     a92:	0000c597          	auipc	a1,0xc
     a96:	1e658593          	addi	a1,a1,486 # cc78 <buf>
     a9a:	00005097          	auipc	ra,0x5
     a9e:	13e080e7          	jalr	318(ra) # 5bd8 <read>
  if(i != N*SZ*2){
     aa2:	7d000793          	li	a5,2000
     aa6:	0af51563          	bne	a0,a5,b50 <writetest+0x158>
  close(fd);
     aaa:	8526                	mv	a0,s1
     aac:	00005097          	auipc	ra,0x5
     ab0:	13c080e7          	jalr	316(ra) # 5be8 <close>
  if(unlink("small") < 0){
     ab4:	00006517          	auipc	a0,0x6
     ab8:	97c50513          	addi	a0,a0,-1668 # 6430 <malloc+0x43e>
     abc:	00005097          	auipc	ra,0x5
     ac0:	154080e7          	jalr	340(ra) # 5c10 <unlink>
     ac4:	0a054463          	bltz	a0,b6c <writetest+0x174>
}
     ac8:	70e2                	ld	ra,56(sp)
     aca:	7442                	ld	s0,48(sp)
     acc:	74a2                	ld	s1,40(sp)
     ace:	7902                	ld	s2,32(sp)
     ad0:	69e2                	ld	s3,24(sp)
     ad2:	6a42                	ld	s4,16(sp)
     ad4:	6aa2                	ld	s5,8(sp)
     ad6:	6b02                	ld	s6,0(sp)
     ad8:	6121                	addi	sp,sp,64
     ada:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     adc:	85da                	mv	a1,s6
     ade:	00006517          	auipc	a0,0x6
     ae2:	95a50513          	addi	a0,a0,-1702 # 6438 <malloc+0x446>
     ae6:	00005097          	auipc	ra,0x5
     aea:	454080e7          	jalr	1108(ra) # 5f3a <printf>
    exit(1);
     aee:	4505                	li	a0,1
     af0:	00005097          	auipc	ra,0x5
     af4:	0d0080e7          	jalr	208(ra) # 5bc0 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     af8:	8626                	mv	a2,s1
     afa:	85da                	mv	a1,s6
     afc:	00006517          	auipc	a0,0x6
     b00:	96c50513          	addi	a0,a0,-1684 # 6468 <malloc+0x476>
     b04:	00005097          	auipc	ra,0x5
     b08:	436080e7          	jalr	1078(ra) # 5f3a <printf>
      exit(1);
     b0c:	4505                	li	a0,1
     b0e:	00005097          	auipc	ra,0x5
     b12:	0b2080e7          	jalr	178(ra) # 5bc0 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     b16:	8626                	mv	a2,s1
     b18:	85da                	mv	a1,s6
     b1a:	00006517          	auipc	a0,0x6
     b1e:	98650513          	addi	a0,a0,-1658 # 64a0 <malloc+0x4ae>
     b22:	00005097          	auipc	ra,0x5
     b26:	418080e7          	jalr	1048(ra) # 5f3a <printf>
      exit(1);
     b2a:	4505                	li	a0,1
     b2c:	00005097          	auipc	ra,0x5
     b30:	094080e7          	jalr	148(ra) # 5bc0 <exit>
    printf("%s: error: open small failed!\n", s);
     b34:	85da                	mv	a1,s6
     b36:	00006517          	auipc	a0,0x6
     b3a:	99250513          	addi	a0,a0,-1646 # 64c8 <malloc+0x4d6>
     b3e:	00005097          	auipc	ra,0x5
     b42:	3fc080e7          	jalr	1020(ra) # 5f3a <printf>
    exit(1);
     b46:	4505                	li	a0,1
     b48:	00005097          	auipc	ra,0x5
     b4c:	078080e7          	jalr	120(ra) # 5bc0 <exit>
    printf("%s: read failed\n", s);
     b50:	85da                	mv	a1,s6
     b52:	00006517          	auipc	a0,0x6
     b56:	99650513          	addi	a0,a0,-1642 # 64e8 <malloc+0x4f6>
     b5a:	00005097          	auipc	ra,0x5
     b5e:	3e0080e7          	jalr	992(ra) # 5f3a <printf>
    exit(1);
     b62:	4505                	li	a0,1
     b64:	00005097          	auipc	ra,0x5
     b68:	05c080e7          	jalr	92(ra) # 5bc0 <exit>
    printf("%s: unlink small failed\n", s);
     b6c:	85da                	mv	a1,s6
     b6e:	00006517          	auipc	a0,0x6
     b72:	99250513          	addi	a0,a0,-1646 # 6500 <malloc+0x50e>
     b76:	00005097          	auipc	ra,0x5
     b7a:	3c4080e7          	jalr	964(ra) # 5f3a <printf>
    exit(1);
     b7e:	4505                	li	a0,1
     b80:	00005097          	auipc	ra,0x5
     b84:	040080e7          	jalr	64(ra) # 5bc0 <exit>

0000000000000b88 <writebig>:
{
     b88:	7139                	addi	sp,sp,-64
     b8a:	fc06                	sd	ra,56(sp)
     b8c:	f822                	sd	s0,48(sp)
     b8e:	f426                	sd	s1,40(sp)
     b90:	f04a                	sd	s2,32(sp)
     b92:	ec4e                	sd	s3,24(sp)
     b94:	e852                	sd	s4,16(sp)
     b96:	e456                	sd	s5,8(sp)
     b98:	0080                	addi	s0,sp,64
     b9a:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     b9c:	20200593          	li	a1,514
     ba0:	00006517          	auipc	a0,0x6
     ba4:	98050513          	addi	a0,a0,-1664 # 6520 <malloc+0x52e>
     ba8:	00005097          	auipc	ra,0x5
     bac:	058080e7          	jalr	88(ra) # 5c00 <open>
     bb0:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     bb2:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     bb4:	0000c917          	auipc	s2,0xc
     bb8:	0c490913          	addi	s2,s2,196 # cc78 <buf>
  for(i = 0; i < MAXFILE; i++){
     bbc:	10c00a13          	li	s4,268
  if(fd < 0){
     bc0:	06054c63          	bltz	a0,c38 <writebig+0xb0>
    ((int*)buf)[0] = i;
     bc4:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     bc8:	40000613          	li	a2,1024
     bcc:	85ca                	mv	a1,s2
     bce:	854e                	mv	a0,s3
     bd0:	00005097          	auipc	ra,0x5
     bd4:	010080e7          	jalr	16(ra) # 5be0 <write>
     bd8:	40000793          	li	a5,1024
     bdc:	06f51c63          	bne	a0,a5,c54 <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
     be0:	2485                	addiw	s1,s1,1
     be2:	ff4491e3          	bne	s1,s4,bc4 <writebig+0x3c>
  close(fd);
     be6:	854e                	mv	a0,s3
     be8:	00005097          	auipc	ra,0x5
     bec:	000080e7          	jalr	ra # 5be8 <close>
  fd = open("big", O_RDONLY);
     bf0:	4581                	li	a1,0
     bf2:	00006517          	auipc	a0,0x6
     bf6:	92e50513          	addi	a0,a0,-1746 # 6520 <malloc+0x52e>
     bfa:	00005097          	auipc	ra,0x5
     bfe:	006080e7          	jalr	6(ra) # 5c00 <open>
     c02:	89aa                	mv	s3,a0
  n = 0;
     c04:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     c06:	0000c917          	auipc	s2,0xc
     c0a:	07290913          	addi	s2,s2,114 # cc78 <buf>
  if(fd < 0){
     c0e:	06054263          	bltz	a0,c72 <writebig+0xea>
    i = read(fd, buf, BSIZE);
     c12:	40000613          	li	a2,1024
     c16:	85ca                	mv	a1,s2
     c18:	854e                	mv	a0,s3
     c1a:	00005097          	auipc	ra,0x5
     c1e:	fbe080e7          	jalr	-66(ra) # 5bd8 <read>
    if(i == 0){
     c22:	c535                	beqz	a0,c8e <writebig+0x106>
    } else if(i != BSIZE){
     c24:	40000793          	li	a5,1024
     c28:	0af51f63          	bne	a0,a5,ce6 <writebig+0x15e>
    if(((int*)buf)[0] != n){
     c2c:	00092683          	lw	a3,0(s2)
     c30:	0c969a63          	bne	a3,s1,d04 <writebig+0x17c>
    n++;
     c34:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     c36:	bff1                	j	c12 <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     c38:	85d6                	mv	a1,s5
     c3a:	00006517          	auipc	a0,0x6
     c3e:	8ee50513          	addi	a0,a0,-1810 # 6528 <malloc+0x536>
     c42:	00005097          	auipc	ra,0x5
     c46:	2f8080e7          	jalr	760(ra) # 5f3a <printf>
    exit(1);
     c4a:	4505                	li	a0,1
     c4c:	00005097          	auipc	ra,0x5
     c50:	f74080e7          	jalr	-140(ra) # 5bc0 <exit>
      printf("%s: error: write big file failed\n", s, i);
     c54:	8626                	mv	a2,s1
     c56:	85d6                	mv	a1,s5
     c58:	00006517          	auipc	a0,0x6
     c5c:	8f050513          	addi	a0,a0,-1808 # 6548 <malloc+0x556>
     c60:	00005097          	auipc	ra,0x5
     c64:	2da080e7          	jalr	730(ra) # 5f3a <printf>
      exit(1);
     c68:	4505                	li	a0,1
     c6a:	00005097          	auipc	ra,0x5
     c6e:	f56080e7          	jalr	-170(ra) # 5bc0 <exit>
    printf("%s: error: open big failed!\n", s);
     c72:	85d6                	mv	a1,s5
     c74:	00006517          	auipc	a0,0x6
     c78:	8fc50513          	addi	a0,a0,-1796 # 6570 <malloc+0x57e>
     c7c:	00005097          	auipc	ra,0x5
     c80:	2be080e7          	jalr	702(ra) # 5f3a <printf>
    exit(1);
     c84:	4505                	li	a0,1
     c86:	00005097          	auipc	ra,0x5
     c8a:	f3a080e7          	jalr	-198(ra) # 5bc0 <exit>
      if(n == MAXFILE - 1){
     c8e:	10b00793          	li	a5,267
     c92:	02f48a63          	beq	s1,a5,cc6 <writebig+0x13e>
  close(fd);
     c96:	854e                	mv	a0,s3
     c98:	00005097          	auipc	ra,0x5
     c9c:	f50080e7          	jalr	-176(ra) # 5be8 <close>
  if(unlink("big") < 0){
     ca0:	00006517          	auipc	a0,0x6
     ca4:	88050513          	addi	a0,a0,-1920 # 6520 <malloc+0x52e>
     ca8:	00005097          	auipc	ra,0x5
     cac:	f68080e7          	jalr	-152(ra) # 5c10 <unlink>
     cb0:	06054963          	bltz	a0,d22 <writebig+0x19a>
}
     cb4:	70e2                	ld	ra,56(sp)
     cb6:	7442                	ld	s0,48(sp)
     cb8:	74a2                	ld	s1,40(sp)
     cba:	7902                	ld	s2,32(sp)
     cbc:	69e2                	ld	s3,24(sp)
     cbe:	6a42                	ld	s4,16(sp)
     cc0:	6aa2                	ld	s5,8(sp)
     cc2:	6121                	addi	sp,sp,64
     cc4:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     cc6:	10b00613          	li	a2,267
     cca:	85d6                	mv	a1,s5
     ccc:	00006517          	auipc	a0,0x6
     cd0:	8c450513          	addi	a0,a0,-1852 # 6590 <malloc+0x59e>
     cd4:	00005097          	auipc	ra,0x5
     cd8:	266080e7          	jalr	614(ra) # 5f3a <printf>
        exit(1);
     cdc:	4505                	li	a0,1
     cde:	00005097          	auipc	ra,0x5
     ce2:	ee2080e7          	jalr	-286(ra) # 5bc0 <exit>
      printf("%s: read failed %d\n", s, i);
     ce6:	862a                	mv	a2,a0
     ce8:	85d6                	mv	a1,s5
     cea:	00006517          	auipc	a0,0x6
     cee:	8ce50513          	addi	a0,a0,-1842 # 65b8 <malloc+0x5c6>
     cf2:	00005097          	auipc	ra,0x5
     cf6:	248080e7          	jalr	584(ra) # 5f3a <printf>
      exit(1);
     cfa:	4505                	li	a0,1
     cfc:	00005097          	auipc	ra,0x5
     d00:	ec4080e7          	jalr	-316(ra) # 5bc0 <exit>
      printf("%s: read content of block %d is %d\n", s,
     d04:	8626                	mv	a2,s1
     d06:	85d6                	mv	a1,s5
     d08:	00006517          	auipc	a0,0x6
     d0c:	8c850513          	addi	a0,a0,-1848 # 65d0 <malloc+0x5de>
     d10:	00005097          	auipc	ra,0x5
     d14:	22a080e7          	jalr	554(ra) # 5f3a <printf>
      exit(1);
     d18:	4505                	li	a0,1
     d1a:	00005097          	auipc	ra,0x5
     d1e:	ea6080e7          	jalr	-346(ra) # 5bc0 <exit>
    printf("%s: unlink big failed\n", s);
     d22:	85d6                	mv	a1,s5
     d24:	00006517          	auipc	a0,0x6
     d28:	8d450513          	addi	a0,a0,-1836 # 65f8 <malloc+0x606>
     d2c:	00005097          	auipc	ra,0x5
     d30:	20e080e7          	jalr	526(ra) # 5f3a <printf>
    exit(1);
     d34:	4505                	li	a0,1
     d36:	00005097          	auipc	ra,0x5
     d3a:	e8a080e7          	jalr	-374(ra) # 5bc0 <exit>

0000000000000d3e <unlinkread>:
{
     d3e:	7179                	addi	sp,sp,-48
     d40:	f406                	sd	ra,40(sp)
     d42:	f022                	sd	s0,32(sp)
     d44:	ec26                	sd	s1,24(sp)
     d46:	e84a                	sd	s2,16(sp)
     d48:	e44e                	sd	s3,8(sp)
     d4a:	1800                	addi	s0,sp,48
     d4c:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     d4e:	20200593          	li	a1,514
     d52:	00006517          	auipc	a0,0x6
     d56:	8be50513          	addi	a0,a0,-1858 # 6610 <malloc+0x61e>
     d5a:	00005097          	auipc	ra,0x5
     d5e:	ea6080e7          	jalr	-346(ra) # 5c00 <open>
  if(fd < 0){
     d62:	0e054563          	bltz	a0,e4c <unlinkread+0x10e>
     d66:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     d68:	4615                	li	a2,5
     d6a:	00006597          	auipc	a1,0x6
     d6e:	8d658593          	addi	a1,a1,-1834 # 6640 <malloc+0x64e>
     d72:	00005097          	auipc	ra,0x5
     d76:	e6e080e7          	jalr	-402(ra) # 5be0 <write>
  close(fd);
     d7a:	8526                	mv	a0,s1
     d7c:	00005097          	auipc	ra,0x5
     d80:	e6c080e7          	jalr	-404(ra) # 5be8 <close>
  fd = open("unlinkread", O_RDWR);
     d84:	4589                	li	a1,2
     d86:	00006517          	auipc	a0,0x6
     d8a:	88a50513          	addi	a0,a0,-1910 # 6610 <malloc+0x61e>
     d8e:	00005097          	auipc	ra,0x5
     d92:	e72080e7          	jalr	-398(ra) # 5c00 <open>
     d96:	84aa                	mv	s1,a0
  if(fd < 0){
     d98:	0c054863          	bltz	a0,e68 <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     d9c:	00006517          	auipc	a0,0x6
     da0:	87450513          	addi	a0,a0,-1932 # 6610 <malloc+0x61e>
     da4:	00005097          	auipc	ra,0x5
     da8:	e6c080e7          	jalr	-404(ra) # 5c10 <unlink>
     dac:	ed61                	bnez	a0,e84 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     dae:	20200593          	li	a1,514
     db2:	00006517          	auipc	a0,0x6
     db6:	85e50513          	addi	a0,a0,-1954 # 6610 <malloc+0x61e>
     dba:	00005097          	auipc	ra,0x5
     dbe:	e46080e7          	jalr	-442(ra) # 5c00 <open>
     dc2:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     dc4:	460d                	li	a2,3
     dc6:	00006597          	auipc	a1,0x6
     dca:	8c258593          	addi	a1,a1,-1854 # 6688 <malloc+0x696>
     dce:	00005097          	auipc	ra,0x5
     dd2:	e12080e7          	jalr	-494(ra) # 5be0 <write>
  close(fd1);
     dd6:	854a                	mv	a0,s2
     dd8:	00005097          	auipc	ra,0x5
     ddc:	e10080e7          	jalr	-496(ra) # 5be8 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     de0:	660d                	lui	a2,0x3
     de2:	0000c597          	auipc	a1,0xc
     de6:	e9658593          	addi	a1,a1,-362 # cc78 <buf>
     dea:	8526                	mv	a0,s1
     dec:	00005097          	auipc	ra,0x5
     df0:	dec080e7          	jalr	-532(ra) # 5bd8 <read>
     df4:	4795                	li	a5,5
     df6:	0af51563          	bne	a0,a5,ea0 <unlinkread+0x162>
  if(buf[0] != 'h'){
     dfa:	0000c717          	auipc	a4,0xc
     dfe:	e7e74703          	lbu	a4,-386(a4) # cc78 <buf>
     e02:	06800793          	li	a5,104
     e06:	0af71b63          	bne	a4,a5,ebc <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     e0a:	4629                	li	a2,10
     e0c:	0000c597          	auipc	a1,0xc
     e10:	e6c58593          	addi	a1,a1,-404 # cc78 <buf>
     e14:	8526                	mv	a0,s1
     e16:	00005097          	auipc	ra,0x5
     e1a:	dca080e7          	jalr	-566(ra) # 5be0 <write>
     e1e:	47a9                	li	a5,10
     e20:	0af51c63          	bne	a0,a5,ed8 <unlinkread+0x19a>
  close(fd);
     e24:	8526                	mv	a0,s1
     e26:	00005097          	auipc	ra,0x5
     e2a:	dc2080e7          	jalr	-574(ra) # 5be8 <close>
  unlink("unlinkread");
     e2e:	00005517          	auipc	a0,0x5
     e32:	7e250513          	addi	a0,a0,2018 # 6610 <malloc+0x61e>
     e36:	00005097          	auipc	ra,0x5
     e3a:	dda080e7          	jalr	-550(ra) # 5c10 <unlink>
}
     e3e:	70a2                	ld	ra,40(sp)
     e40:	7402                	ld	s0,32(sp)
     e42:	64e2                	ld	s1,24(sp)
     e44:	6942                	ld	s2,16(sp)
     e46:	69a2                	ld	s3,8(sp)
     e48:	6145                	addi	sp,sp,48
     e4a:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     e4c:	85ce                	mv	a1,s3
     e4e:	00005517          	auipc	a0,0x5
     e52:	7d250513          	addi	a0,a0,2002 # 6620 <malloc+0x62e>
     e56:	00005097          	auipc	ra,0x5
     e5a:	0e4080e7          	jalr	228(ra) # 5f3a <printf>
    exit(1);
     e5e:	4505                	li	a0,1
     e60:	00005097          	auipc	ra,0x5
     e64:	d60080e7          	jalr	-672(ra) # 5bc0 <exit>
    printf("%s: open unlinkread failed\n", s);
     e68:	85ce                	mv	a1,s3
     e6a:	00005517          	auipc	a0,0x5
     e6e:	7de50513          	addi	a0,a0,2014 # 6648 <malloc+0x656>
     e72:	00005097          	auipc	ra,0x5
     e76:	0c8080e7          	jalr	200(ra) # 5f3a <printf>
    exit(1);
     e7a:	4505                	li	a0,1
     e7c:	00005097          	auipc	ra,0x5
     e80:	d44080e7          	jalr	-700(ra) # 5bc0 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     e84:	85ce                	mv	a1,s3
     e86:	00005517          	auipc	a0,0x5
     e8a:	7e250513          	addi	a0,a0,2018 # 6668 <malloc+0x676>
     e8e:	00005097          	auipc	ra,0x5
     e92:	0ac080e7          	jalr	172(ra) # 5f3a <printf>
    exit(1);
     e96:	4505                	li	a0,1
     e98:	00005097          	auipc	ra,0x5
     e9c:	d28080e7          	jalr	-728(ra) # 5bc0 <exit>
    printf("%s: unlinkread read failed", s);
     ea0:	85ce                	mv	a1,s3
     ea2:	00005517          	auipc	a0,0x5
     ea6:	7ee50513          	addi	a0,a0,2030 # 6690 <malloc+0x69e>
     eaa:	00005097          	auipc	ra,0x5
     eae:	090080e7          	jalr	144(ra) # 5f3a <printf>
    exit(1);
     eb2:	4505                	li	a0,1
     eb4:	00005097          	auipc	ra,0x5
     eb8:	d0c080e7          	jalr	-756(ra) # 5bc0 <exit>
    printf("%s: unlinkread wrong data\n", s);
     ebc:	85ce                	mv	a1,s3
     ebe:	00005517          	auipc	a0,0x5
     ec2:	7f250513          	addi	a0,a0,2034 # 66b0 <malloc+0x6be>
     ec6:	00005097          	auipc	ra,0x5
     eca:	074080e7          	jalr	116(ra) # 5f3a <printf>
    exit(1);
     ece:	4505                	li	a0,1
     ed0:	00005097          	auipc	ra,0x5
     ed4:	cf0080e7          	jalr	-784(ra) # 5bc0 <exit>
    printf("%s: unlinkread write failed\n", s);
     ed8:	85ce                	mv	a1,s3
     eda:	00005517          	auipc	a0,0x5
     ede:	7f650513          	addi	a0,a0,2038 # 66d0 <malloc+0x6de>
     ee2:	00005097          	auipc	ra,0x5
     ee6:	058080e7          	jalr	88(ra) # 5f3a <printf>
    exit(1);
     eea:	4505                	li	a0,1
     eec:	00005097          	auipc	ra,0x5
     ef0:	cd4080e7          	jalr	-812(ra) # 5bc0 <exit>

0000000000000ef4 <linktest>:
{
     ef4:	1101                	addi	sp,sp,-32
     ef6:	ec06                	sd	ra,24(sp)
     ef8:	e822                	sd	s0,16(sp)
     efa:	e426                	sd	s1,8(sp)
     efc:	e04a                	sd	s2,0(sp)
     efe:	1000                	addi	s0,sp,32
     f00:	892a                	mv	s2,a0
  unlink("lf1");
     f02:	00005517          	auipc	a0,0x5
     f06:	7ee50513          	addi	a0,a0,2030 # 66f0 <malloc+0x6fe>
     f0a:	00005097          	auipc	ra,0x5
     f0e:	d06080e7          	jalr	-762(ra) # 5c10 <unlink>
  unlink("lf2");
     f12:	00005517          	auipc	a0,0x5
     f16:	7e650513          	addi	a0,a0,2022 # 66f8 <malloc+0x706>
     f1a:	00005097          	auipc	ra,0x5
     f1e:	cf6080e7          	jalr	-778(ra) # 5c10 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     f22:	20200593          	li	a1,514
     f26:	00005517          	auipc	a0,0x5
     f2a:	7ca50513          	addi	a0,a0,1994 # 66f0 <malloc+0x6fe>
     f2e:	00005097          	auipc	ra,0x5
     f32:	cd2080e7          	jalr	-814(ra) # 5c00 <open>
  if(fd < 0){
     f36:	10054763          	bltz	a0,1044 <linktest+0x150>
     f3a:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     f3c:	4615                	li	a2,5
     f3e:	00005597          	auipc	a1,0x5
     f42:	70258593          	addi	a1,a1,1794 # 6640 <malloc+0x64e>
     f46:	00005097          	auipc	ra,0x5
     f4a:	c9a080e7          	jalr	-870(ra) # 5be0 <write>
     f4e:	4795                	li	a5,5
     f50:	10f51863          	bne	a0,a5,1060 <linktest+0x16c>
  close(fd);
     f54:	8526                	mv	a0,s1
     f56:	00005097          	auipc	ra,0x5
     f5a:	c92080e7          	jalr	-878(ra) # 5be8 <close>
  if(link("lf1", "lf2") < 0){
     f5e:	00005597          	auipc	a1,0x5
     f62:	79a58593          	addi	a1,a1,1946 # 66f8 <malloc+0x706>
     f66:	00005517          	auipc	a0,0x5
     f6a:	78a50513          	addi	a0,a0,1930 # 66f0 <malloc+0x6fe>
     f6e:	00005097          	auipc	ra,0x5
     f72:	cb2080e7          	jalr	-846(ra) # 5c20 <link>
     f76:	10054363          	bltz	a0,107c <linktest+0x188>
  unlink("lf1");
     f7a:	00005517          	auipc	a0,0x5
     f7e:	77650513          	addi	a0,a0,1910 # 66f0 <malloc+0x6fe>
     f82:	00005097          	auipc	ra,0x5
     f86:	c8e080e7          	jalr	-882(ra) # 5c10 <unlink>
  if(open("lf1", 0) >= 0){
     f8a:	4581                	li	a1,0
     f8c:	00005517          	auipc	a0,0x5
     f90:	76450513          	addi	a0,a0,1892 # 66f0 <malloc+0x6fe>
     f94:	00005097          	auipc	ra,0x5
     f98:	c6c080e7          	jalr	-916(ra) # 5c00 <open>
     f9c:	0e055e63          	bgez	a0,1098 <linktest+0x1a4>
  fd = open("lf2", 0);
     fa0:	4581                	li	a1,0
     fa2:	00005517          	auipc	a0,0x5
     fa6:	75650513          	addi	a0,a0,1878 # 66f8 <malloc+0x706>
     faa:	00005097          	auipc	ra,0x5
     fae:	c56080e7          	jalr	-938(ra) # 5c00 <open>
     fb2:	84aa                	mv	s1,a0
  if(fd < 0){
     fb4:	10054063          	bltz	a0,10b4 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     fb8:	660d                	lui	a2,0x3
     fba:	0000c597          	auipc	a1,0xc
     fbe:	cbe58593          	addi	a1,a1,-834 # cc78 <buf>
     fc2:	00005097          	auipc	ra,0x5
     fc6:	c16080e7          	jalr	-1002(ra) # 5bd8 <read>
     fca:	4795                	li	a5,5
     fcc:	10f51263          	bne	a0,a5,10d0 <linktest+0x1dc>
  close(fd);
     fd0:	8526                	mv	a0,s1
     fd2:	00005097          	auipc	ra,0x5
     fd6:	c16080e7          	jalr	-1002(ra) # 5be8 <close>
  if(link("lf2", "lf2") >= 0){
     fda:	00005597          	auipc	a1,0x5
     fde:	71e58593          	addi	a1,a1,1822 # 66f8 <malloc+0x706>
     fe2:	852e                	mv	a0,a1
     fe4:	00005097          	auipc	ra,0x5
     fe8:	c3c080e7          	jalr	-964(ra) # 5c20 <link>
     fec:	10055063          	bgez	a0,10ec <linktest+0x1f8>
  unlink("lf2");
     ff0:	00005517          	auipc	a0,0x5
     ff4:	70850513          	addi	a0,a0,1800 # 66f8 <malloc+0x706>
     ff8:	00005097          	auipc	ra,0x5
     ffc:	c18080e7          	jalr	-1000(ra) # 5c10 <unlink>
  if(link("lf2", "lf1") >= 0){
    1000:	00005597          	auipc	a1,0x5
    1004:	6f058593          	addi	a1,a1,1776 # 66f0 <malloc+0x6fe>
    1008:	00005517          	auipc	a0,0x5
    100c:	6f050513          	addi	a0,a0,1776 # 66f8 <malloc+0x706>
    1010:	00005097          	auipc	ra,0x5
    1014:	c10080e7          	jalr	-1008(ra) # 5c20 <link>
    1018:	0e055863          	bgez	a0,1108 <linktest+0x214>
  if(link(".", "lf1") >= 0){
    101c:	00005597          	auipc	a1,0x5
    1020:	6d458593          	addi	a1,a1,1748 # 66f0 <malloc+0x6fe>
    1024:	00005517          	auipc	a0,0x5
    1028:	7dc50513          	addi	a0,a0,2012 # 6800 <malloc+0x80e>
    102c:	00005097          	auipc	ra,0x5
    1030:	bf4080e7          	jalr	-1036(ra) # 5c20 <link>
    1034:	0e055863          	bgez	a0,1124 <linktest+0x230>
}
    1038:	60e2                	ld	ra,24(sp)
    103a:	6442                	ld	s0,16(sp)
    103c:	64a2                	ld	s1,8(sp)
    103e:	6902                	ld	s2,0(sp)
    1040:	6105                	addi	sp,sp,32
    1042:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    1044:	85ca                	mv	a1,s2
    1046:	00005517          	auipc	a0,0x5
    104a:	6ba50513          	addi	a0,a0,1722 # 6700 <malloc+0x70e>
    104e:	00005097          	auipc	ra,0x5
    1052:	eec080e7          	jalr	-276(ra) # 5f3a <printf>
    exit(1);
    1056:	4505                	li	a0,1
    1058:	00005097          	auipc	ra,0x5
    105c:	b68080e7          	jalr	-1176(ra) # 5bc0 <exit>
    printf("%s: write lf1 failed\n", s);
    1060:	85ca                	mv	a1,s2
    1062:	00005517          	auipc	a0,0x5
    1066:	6b650513          	addi	a0,a0,1718 # 6718 <malloc+0x726>
    106a:	00005097          	auipc	ra,0x5
    106e:	ed0080e7          	jalr	-304(ra) # 5f3a <printf>
    exit(1);
    1072:	4505                	li	a0,1
    1074:	00005097          	auipc	ra,0x5
    1078:	b4c080e7          	jalr	-1204(ra) # 5bc0 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    107c:	85ca                	mv	a1,s2
    107e:	00005517          	auipc	a0,0x5
    1082:	6b250513          	addi	a0,a0,1714 # 6730 <malloc+0x73e>
    1086:	00005097          	auipc	ra,0x5
    108a:	eb4080e7          	jalr	-332(ra) # 5f3a <printf>
    exit(1);
    108e:	4505                	li	a0,1
    1090:	00005097          	auipc	ra,0x5
    1094:	b30080e7          	jalr	-1232(ra) # 5bc0 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    1098:	85ca                	mv	a1,s2
    109a:	00005517          	auipc	a0,0x5
    109e:	6b650513          	addi	a0,a0,1718 # 6750 <malloc+0x75e>
    10a2:	00005097          	auipc	ra,0x5
    10a6:	e98080e7          	jalr	-360(ra) # 5f3a <printf>
    exit(1);
    10aa:	4505                	li	a0,1
    10ac:	00005097          	auipc	ra,0x5
    10b0:	b14080e7          	jalr	-1260(ra) # 5bc0 <exit>
    printf("%s: open lf2 failed\n", s);
    10b4:	85ca                	mv	a1,s2
    10b6:	00005517          	auipc	a0,0x5
    10ba:	6ca50513          	addi	a0,a0,1738 # 6780 <malloc+0x78e>
    10be:	00005097          	auipc	ra,0x5
    10c2:	e7c080e7          	jalr	-388(ra) # 5f3a <printf>
    exit(1);
    10c6:	4505                	li	a0,1
    10c8:	00005097          	auipc	ra,0x5
    10cc:	af8080e7          	jalr	-1288(ra) # 5bc0 <exit>
    printf("%s: read lf2 failed\n", s);
    10d0:	85ca                	mv	a1,s2
    10d2:	00005517          	auipc	a0,0x5
    10d6:	6c650513          	addi	a0,a0,1734 # 6798 <malloc+0x7a6>
    10da:	00005097          	auipc	ra,0x5
    10de:	e60080e7          	jalr	-416(ra) # 5f3a <printf>
    exit(1);
    10e2:	4505                	li	a0,1
    10e4:	00005097          	auipc	ra,0x5
    10e8:	adc080e7          	jalr	-1316(ra) # 5bc0 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    10ec:	85ca                	mv	a1,s2
    10ee:	00005517          	auipc	a0,0x5
    10f2:	6c250513          	addi	a0,a0,1730 # 67b0 <malloc+0x7be>
    10f6:	00005097          	auipc	ra,0x5
    10fa:	e44080e7          	jalr	-444(ra) # 5f3a <printf>
    exit(1);
    10fe:	4505                	li	a0,1
    1100:	00005097          	auipc	ra,0x5
    1104:	ac0080e7          	jalr	-1344(ra) # 5bc0 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
    1108:	85ca                	mv	a1,s2
    110a:	00005517          	auipc	a0,0x5
    110e:	6ce50513          	addi	a0,a0,1742 # 67d8 <malloc+0x7e6>
    1112:	00005097          	auipc	ra,0x5
    1116:	e28080e7          	jalr	-472(ra) # 5f3a <printf>
    exit(1);
    111a:	4505                	li	a0,1
    111c:	00005097          	auipc	ra,0x5
    1120:	aa4080e7          	jalr	-1372(ra) # 5bc0 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    1124:	85ca                	mv	a1,s2
    1126:	00005517          	auipc	a0,0x5
    112a:	6e250513          	addi	a0,a0,1762 # 6808 <malloc+0x816>
    112e:	00005097          	auipc	ra,0x5
    1132:	e0c080e7          	jalr	-500(ra) # 5f3a <printf>
    exit(1);
    1136:	4505                	li	a0,1
    1138:	00005097          	auipc	ra,0x5
    113c:	a88080e7          	jalr	-1400(ra) # 5bc0 <exit>

0000000000001140 <validatetest>:
{
    1140:	7139                	addi	sp,sp,-64
    1142:	fc06                	sd	ra,56(sp)
    1144:	f822                	sd	s0,48(sp)
    1146:	f426                	sd	s1,40(sp)
    1148:	f04a                	sd	s2,32(sp)
    114a:	ec4e                	sd	s3,24(sp)
    114c:	e852                	sd	s4,16(sp)
    114e:	e456                	sd	s5,8(sp)
    1150:	e05a                	sd	s6,0(sp)
    1152:	0080                	addi	s0,sp,64
    1154:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1156:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    1158:	00005997          	auipc	s3,0x5
    115c:	6d098993          	addi	s3,s3,1744 # 6828 <malloc+0x836>
    1160:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1162:	6a85                	lui	s5,0x1
    1164:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    1168:	85a6                	mv	a1,s1
    116a:	854e                	mv	a0,s3
    116c:	00005097          	auipc	ra,0x5
    1170:	ab4080e7          	jalr	-1356(ra) # 5c20 <link>
    1174:	01251f63          	bne	a0,s2,1192 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1178:	94d6                	add	s1,s1,s5
    117a:	ff4497e3          	bne	s1,s4,1168 <validatetest+0x28>
}
    117e:	70e2                	ld	ra,56(sp)
    1180:	7442                	ld	s0,48(sp)
    1182:	74a2                	ld	s1,40(sp)
    1184:	7902                	ld	s2,32(sp)
    1186:	69e2                	ld	s3,24(sp)
    1188:	6a42                	ld	s4,16(sp)
    118a:	6aa2                	ld	s5,8(sp)
    118c:	6b02                	ld	s6,0(sp)
    118e:	6121                	addi	sp,sp,64
    1190:	8082                	ret
      printf("%s: link should not succeed\n", s);
    1192:	85da                	mv	a1,s6
    1194:	00005517          	auipc	a0,0x5
    1198:	6a450513          	addi	a0,a0,1700 # 6838 <malloc+0x846>
    119c:	00005097          	auipc	ra,0x5
    11a0:	d9e080e7          	jalr	-610(ra) # 5f3a <printf>
      exit(1);
    11a4:	4505                	li	a0,1
    11a6:	00005097          	auipc	ra,0x5
    11aa:	a1a080e7          	jalr	-1510(ra) # 5bc0 <exit>

00000000000011ae <bigdir>:
{
    11ae:	715d                	addi	sp,sp,-80
    11b0:	e486                	sd	ra,72(sp)
    11b2:	e0a2                	sd	s0,64(sp)
    11b4:	fc26                	sd	s1,56(sp)
    11b6:	f84a                	sd	s2,48(sp)
    11b8:	f44e                	sd	s3,40(sp)
    11ba:	f052                	sd	s4,32(sp)
    11bc:	ec56                	sd	s5,24(sp)
    11be:	e85a                	sd	s6,16(sp)
    11c0:	0880                	addi	s0,sp,80
    11c2:	89aa                	mv	s3,a0
  unlink("bd");
    11c4:	00005517          	auipc	a0,0x5
    11c8:	69450513          	addi	a0,a0,1684 # 6858 <malloc+0x866>
    11cc:	00005097          	auipc	ra,0x5
    11d0:	a44080e7          	jalr	-1468(ra) # 5c10 <unlink>
  fd = open("bd", O_CREATE);
    11d4:	20000593          	li	a1,512
    11d8:	00005517          	auipc	a0,0x5
    11dc:	68050513          	addi	a0,a0,1664 # 6858 <malloc+0x866>
    11e0:	00005097          	auipc	ra,0x5
    11e4:	a20080e7          	jalr	-1504(ra) # 5c00 <open>
  if(fd < 0){
    11e8:	0c054963          	bltz	a0,12ba <bigdir+0x10c>
  close(fd);
    11ec:	00005097          	auipc	ra,0x5
    11f0:	9fc080e7          	jalr	-1540(ra) # 5be8 <close>
  for(i = 0; i < N; i++){
    11f4:	4901                	li	s2,0
    name[0] = 'x';
    11f6:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    11fa:	00005a17          	auipc	s4,0x5
    11fe:	65ea0a13          	addi	s4,s4,1630 # 6858 <malloc+0x866>
  for(i = 0; i < N; i++){
    1202:	1f400b13          	li	s6,500
    name[0] = 'x';
    1206:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    120a:	41f9571b          	sraiw	a4,s2,0x1f
    120e:	01a7571b          	srliw	a4,a4,0x1a
    1212:	012707bb          	addw	a5,a4,s2
    1216:	4067d69b          	sraiw	a3,a5,0x6
    121a:	0306869b          	addiw	a3,a3,48
    121e:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1222:	03f7f793          	andi	a5,a5,63
    1226:	9f99                	subw	a5,a5,a4
    1228:	0307879b          	addiw	a5,a5,48
    122c:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1230:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    1234:	fb040593          	addi	a1,s0,-80
    1238:	8552                	mv	a0,s4
    123a:	00005097          	auipc	ra,0x5
    123e:	9e6080e7          	jalr	-1562(ra) # 5c20 <link>
    1242:	84aa                	mv	s1,a0
    1244:	e949                	bnez	a0,12d6 <bigdir+0x128>
  for(i = 0; i < N; i++){
    1246:	2905                	addiw	s2,s2,1
    1248:	fb691fe3          	bne	s2,s6,1206 <bigdir+0x58>
  unlink("bd");
    124c:	00005517          	auipc	a0,0x5
    1250:	60c50513          	addi	a0,a0,1548 # 6858 <malloc+0x866>
    1254:	00005097          	auipc	ra,0x5
    1258:	9bc080e7          	jalr	-1604(ra) # 5c10 <unlink>
    name[0] = 'x';
    125c:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    1260:	1f400a13          	li	s4,500
    name[0] = 'x';
    1264:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    1268:	41f4d71b          	sraiw	a4,s1,0x1f
    126c:	01a7571b          	srliw	a4,a4,0x1a
    1270:	009707bb          	addw	a5,a4,s1
    1274:	4067d69b          	sraiw	a3,a5,0x6
    1278:	0306869b          	addiw	a3,a3,48
    127c:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1280:	03f7f793          	andi	a5,a5,63
    1284:	9f99                	subw	a5,a5,a4
    1286:	0307879b          	addiw	a5,a5,48
    128a:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    128e:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    1292:	fb040513          	addi	a0,s0,-80
    1296:	00005097          	auipc	ra,0x5
    129a:	97a080e7          	jalr	-1670(ra) # 5c10 <unlink>
    129e:	ed21                	bnez	a0,12f6 <bigdir+0x148>
  for(i = 0; i < N; i++){
    12a0:	2485                	addiw	s1,s1,1
    12a2:	fd4491e3          	bne	s1,s4,1264 <bigdir+0xb6>
}
    12a6:	60a6                	ld	ra,72(sp)
    12a8:	6406                	ld	s0,64(sp)
    12aa:	74e2                	ld	s1,56(sp)
    12ac:	7942                	ld	s2,48(sp)
    12ae:	79a2                	ld	s3,40(sp)
    12b0:	7a02                	ld	s4,32(sp)
    12b2:	6ae2                	ld	s5,24(sp)
    12b4:	6b42                	ld	s6,16(sp)
    12b6:	6161                	addi	sp,sp,80
    12b8:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    12ba:	85ce                	mv	a1,s3
    12bc:	00005517          	auipc	a0,0x5
    12c0:	5a450513          	addi	a0,a0,1444 # 6860 <malloc+0x86e>
    12c4:	00005097          	auipc	ra,0x5
    12c8:	c76080e7          	jalr	-906(ra) # 5f3a <printf>
    exit(1);
    12cc:	4505                	li	a0,1
    12ce:	00005097          	auipc	ra,0x5
    12d2:	8f2080e7          	jalr	-1806(ra) # 5bc0 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    12d6:	fb040613          	addi	a2,s0,-80
    12da:	85ce                	mv	a1,s3
    12dc:	00005517          	auipc	a0,0x5
    12e0:	5a450513          	addi	a0,a0,1444 # 6880 <malloc+0x88e>
    12e4:	00005097          	auipc	ra,0x5
    12e8:	c56080e7          	jalr	-938(ra) # 5f3a <printf>
      exit(1);
    12ec:	4505                	li	a0,1
    12ee:	00005097          	auipc	ra,0x5
    12f2:	8d2080e7          	jalr	-1838(ra) # 5bc0 <exit>
      printf("%s: bigdir unlink failed", s);
    12f6:	85ce                	mv	a1,s3
    12f8:	00005517          	auipc	a0,0x5
    12fc:	5a850513          	addi	a0,a0,1448 # 68a0 <malloc+0x8ae>
    1300:	00005097          	auipc	ra,0x5
    1304:	c3a080e7          	jalr	-966(ra) # 5f3a <printf>
      exit(1);
    1308:	4505                	li	a0,1
    130a:	00005097          	auipc	ra,0x5
    130e:	8b6080e7          	jalr	-1866(ra) # 5bc0 <exit>

0000000000001312 <pgbug>:
{
    1312:	7179                	addi	sp,sp,-48
    1314:	f406                	sd	ra,40(sp)
    1316:	f022                	sd	s0,32(sp)
    1318:	ec26                	sd	s1,24(sp)
    131a:	1800                	addi	s0,sp,48
  argv[0] = 0;
    131c:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1320:	00008497          	auipc	s1,0x8
    1324:	ce048493          	addi	s1,s1,-800 # 9000 <big>
    1328:	fd840593          	addi	a1,s0,-40
    132c:	6088                	ld	a0,0(s1)
    132e:	00005097          	auipc	ra,0x5
    1332:	8ca080e7          	jalr	-1846(ra) # 5bf8 <exec>
  pipe(big);
    1336:	6088                	ld	a0,0(s1)
    1338:	00005097          	auipc	ra,0x5
    133c:	898080e7          	jalr	-1896(ra) # 5bd0 <pipe>
  exit(0);
    1340:	4501                	li	a0,0
    1342:	00005097          	auipc	ra,0x5
    1346:	87e080e7          	jalr	-1922(ra) # 5bc0 <exit>

000000000000134a <badarg>:
{
    134a:	7139                	addi	sp,sp,-64
    134c:	fc06                	sd	ra,56(sp)
    134e:	f822                	sd	s0,48(sp)
    1350:	f426                	sd	s1,40(sp)
    1352:	f04a                	sd	s2,32(sp)
    1354:	ec4e                	sd	s3,24(sp)
    1356:	0080                	addi	s0,sp,64
    1358:	64b1                	lui	s1,0xc
    135a:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    135e:	597d                	li	s2,-1
    1360:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    1364:	00005997          	auipc	s3,0x5
    1368:	db498993          	addi	s3,s3,-588 # 6118 <malloc+0x126>
    argv[0] = (char*)0xffffffff;
    136c:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1370:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1374:	fc040593          	addi	a1,s0,-64
    1378:	854e                	mv	a0,s3
    137a:	00005097          	auipc	ra,0x5
    137e:	87e080e7          	jalr	-1922(ra) # 5bf8 <exec>
  for(int i = 0; i < 50000; i++){
    1382:	34fd                	addiw	s1,s1,-1
    1384:	f4e5                	bnez	s1,136c <badarg+0x22>
  exit(0);
    1386:	4501                	li	a0,0
    1388:	00005097          	auipc	ra,0x5
    138c:	838080e7          	jalr	-1992(ra) # 5bc0 <exit>

0000000000001390 <copyinstr2>:
{
    1390:	7155                	addi	sp,sp,-208
    1392:	e586                	sd	ra,200(sp)
    1394:	e1a2                	sd	s0,192(sp)
    1396:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    1398:	f6840793          	addi	a5,s0,-152
    139c:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    13a0:	07800713          	li	a4,120
    13a4:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    13a8:	0785                	addi	a5,a5,1
    13aa:	fed79de3          	bne	a5,a3,13a4 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    13ae:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    13b2:	f6840513          	addi	a0,s0,-152
    13b6:	00005097          	auipc	ra,0x5
    13ba:	85a080e7          	jalr	-1958(ra) # 5c10 <unlink>
  if(ret != -1){
    13be:	57fd                	li	a5,-1
    13c0:	0ef51063          	bne	a0,a5,14a0 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    13c4:	20100593          	li	a1,513
    13c8:	f6840513          	addi	a0,s0,-152
    13cc:	00005097          	auipc	ra,0x5
    13d0:	834080e7          	jalr	-1996(ra) # 5c00 <open>
  if(fd != -1){
    13d4:	57fd                	li	a5,-1
    13d6:	0ef51563          	bne	a0,a5,14c0 <copyinstr2+0x130>
  ret = link(b, b);
    13da:	f6840593          	addi	a1,s0,-152
    13de:	852e                	mv	a0,a1
    13e0:	00005097          	auipc	ra,0x5
    13e4:	840080e7          	jalr	-1984(ra) # 5c20 <link>
  if(ret != -1){
    13e8:	57fd                	li	a5,-1
    13ea:	0ef51b63          	bne	a0,a5,14e0 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    13ee:	00006797          	auipc	a5,0x6
    13f2:	70a78793          	addi	a5,a5,1802 # 7af8 <malloc+0x1b06>
    13f6:	f4f43c23          	sd	a5,-168(s0)
    13fa:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    13fe:	f5840593          	addi	a1,s0,-168
    1402:	f6840513          	addi	a0,s0,-152
    1406:	00004097          	auipc	ra,0x4
    140a:	7f2080e7          	jalr	2034(ra) # 5bf8 <exec>
  if(ret != -1){
    140e:	57fd                	li	a5,-1
    1410:	0ef51963          	bne	a0,a5,1502 <copyinstr2+0x172>
  int pid = fork();
    1414:	00004097          	auipc	ra,0x4
    1418:	7a4080e7          	jalr	1956(ra) # 5bb8 <fork>
  if(pid < 0){
    141c:	10054363          	bltz	a0,1522 <copyinstr2+0x192>
  if(pid == 0){
    1420:	12051463          	bnez	a0,1548 <copyinstr2+0x1b8>
    1424:	00008797          	auipc	a5,0x8
    1428:	13c78793          	addi	a5,a5,316 # 9560 <big.0>
    142c:	00009697          	auipc	a3,0x9
    1430:	13468693          	addi	a3,a3,308 # a560 <big.0+0x1000>
      big[i] = 'x';
    1434:	07800713          	li	a4,120
    1438:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    143c:	0785                	addi	a5,a5,1
    143e:	fed79de3          	bne	a5,a3,1438 <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    1442:	00009797          	auipc	a5,0x9
    1446:	10078f23          	sb	zero,286(a5) # a560 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    144a:	00007797          	auipc	a5,0x7
    144e:	0ee78793          	addi	a5,a5,238 # 8538 <malloc+0x2546>
    1452:	6390                	ld	a2,0(a5)
    1454:	6794                	ld	a3,8(a5)
    1456:	6b98                	ld	a4,16(a5)
    1458:	6f9c                	ld	a5,24(a5)
    145a:	f2c43823          	sd	a2,-208(s0)
    145e:	f2d43c23          	sd	a3,-200(s0)
    1462:	f4e43023          	sd	a4,-192(s0)
    1466:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    146a:	f3040593          	addi	a1,s0,-208
    146e:	00005517          	auipc	a0,0x5
    1472:	caa50513          	addi	a0,a0,-854 # 6118 <malloc+0x126>
    1476:	00004097          	auipc	ra,0x4
    147a:	782080e7          	jalr	1922(ra) # 5bf8 <exec>
    if(ret != -1){
    147e:	57fd                	li	a5,-1
    1480:	0af50e63          	beq	a0,a5,153c <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    1484:	55fd                	li	a1,-1
    1486:	00005517          	auipc	a0,0x5
    148a:	4c250513          	addi	a0,a0,1218 # 6948 <malloc+0x956>
    148e:	00005097          	auipc	ra,0x5
    1492:	aac080e7          	jalr	-1364(ra) # 5f3a <printf>
      exit(1);
    1496:	4505                	li	a0,1
    1498:	00004097          	auipc	ra,0x4
    149c:	728080e7          	jalr	1832(ra) # 5bc0 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    14a0:	862a                	mv	a2,a0
    14a2:	f6840593          	addi	a1,s0,-152
    14a6:	00005517          	auipc	a0,0x5
    14aa:	41a50513          	addi	a0,a0,1050 # 68c0 <malloc+0x8ce>
    14ae:	00005097          	auipc	ra,0x5
    14b2:	a8c080e7          	jalr	-1396(ra) # 5f3a <printf>
    exit(1);
    14b6:	4505                	li	a0,1
    14b8:	00004097          	auipc	ra,0x4
    14bc:	708080e7          	jalr	1800(ra) # 5bc0 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    14c0:	862a                	mv	a2,a0
    14c2:	f6840593          	addi	a1,s0,-152
    14c6:	00005517          	auipc	a0,0x5
    14ca:	41a50513          	addi	a0,a0,1050 # 68e0 <malloc+0x8ee>
    14ce:	00005097          	auipc	ra,0x5
    14d2:	a6c080e7          	jalr	-1428(ra) # 5f3a <printf>
    exit(1);
    14d6:	4505                	li	a0,1
    14d8:	00004097          	auipc	ra,0x4
    14dc:	6e8080e7          	jalr	1768(ra) # 5bc0 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    14e0:	86aa                	mv	a3,a0
    14e2:	f6840613          	addi	a2,s0,-152
    14e6:	85b2                	mv	a1,a2
    14e8:	00005517          	auipc	a0,0x5
    14ec:	41850513          	addi	a0,a0,1048 # 6900 <malloc+0x90e>
    14f0:	00005097          	auipc	ra,0x5
    14f4:	a4a080e7          	jalr	-1462(ra) # 5f3a <printf>
    exit(1);
    14f8:	4505                	li	a0,1
    14fa:	00004097          	auipc	ra,0x4
    14fe:	6c6080e7          	jalr	1734(ra) # 5bc0 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1502:	567d                	li	a2,-1
    1504:	f6840593          	addi	a1,s0,-152
    1508:	00005517          	auipc	a0,0x5
    150c:	42050513          	addi	a0,a0,1056 # 6928 <malloc+0x936>
    1510:	00005097          	auipc	ra,0x5
    1514:	a2a080e7          	jalr	-1494(ra) # 5f3a <printf>
    exit(1);
    1518:	4505                	li	a0,1
    151a:	00004097          	auipc	ra,0x4
    151e:	6a6080e7          	jalr	1702(ra) # 5bc0 <exit>
    printf("fork failed\n");
    1522:	00006517          	auipc	a0,0x6
    1526:	88650513          	addi	a0,a0,-1914 # 6da8 <malloc+0xdb6>
    152a:	00005097          	auipc	ra,0x5
    152e:	a10080e7          	jalr	-1520(ra) # 5f3a <printf>
    exit(1);
    1532:	4505                	li	a0,1
    1534:	00004097          	auipc	ra,0x4
    1538:	68c080e7          	jalr	1676(ra) # 5bc0 <exit>
    exit(747); // OK
    153c:	2eb00513          	li	a0,747
    1540:	00004097          	auipc	ra,0x4
    1544:	680080e7          	jalr	1664(ra) # 5bc0 <exit>
  int st = 0;
    1548:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    154c:	f5440513          	addi	a0,s0,-172
    1550:	00004097          	auipc	ra,0x4
    1554:	678080e7          	jalr	1656(ra) # 5bc8 <wait>
  if(st != 747){
    1558:	f5442703          	lw	a4,-172(s0)
    155c:	2eb00793          	li	a5,747
    1560:	00f71663          	bne	a4,a5,156c <copyinstr2+0x1dc>
}
    1564:	60ae                	ld	ra,200(sp)
    1566:	640e                	ld	s0,192(sp)
    1568:	6169                	addi	sp,sp,208
    156a:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    156c:	00005517          	auipc	a0,0x5
    1570:	40450513          	addi	a0,a0,1028 # 6970 <malloc+0x97e>
    1574:	00005097          	auipc	ra,0x5
    1578:	9c6080e7          	jalr	-1594(ra) # 5f3a <printf>
    exit(1);
    157c:	4505                	li	a0,1
    157e:	00004097          	auipc	ra,0x4
    1582:	642080e7          	jalr	1602(ra) # 5bc0 <exit>

0000000000001586 <truncate3>:
{
    1586:	7159                	addi	sp,sp,-112
    1588:	f486                	sd	ra,104(sp)
    158a:	f0a2                	sd	s0,96(sp)
    158c:	eca6                	sd	s1,88(sp)
    158e:	e8ca                	sd	s2,80(sp)
    1590:	e4ce                	sd	s3,72(sp)
    1592:	e0d2                	sd	s4,64(sp)
    1594:	fc56                	sd	s5,56(sp)
    1596:	1880                	addi	s0,sp,112
    1598:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    159a:	60100593          	li	a1,1537
    159e:	00005517          	auipc	a0,0x5
    15a2:	bd250513          	addi	a0,a0,-1070 # 6170 <malloc+0x17e>
    15a6:	00004097          	auipc	ra,0x4
    15aa:	65a080e7          	jalr	1626(ra) # 5c00 <open>
    15ae:	00004097          	auipc	ra,0x4
    15b2:	63a080e7          	jalr	1594(ra) # 5be8 <close>
  pid = fork();
    15b6:	00004097          	auipc	ra,0x4
    15ba:	602080e7          	jalr	1538(ra) # 5bb8 <fork>
  if(pid < 0){
    15be:	08054063          	bltz	a0,163e <truncate3+0xb8>
  if(pid == 0){
    15c2:	e969                	bnez	a0,1694 <truncate3+0x10e>
    15c4:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    15c8:	00005a17          	auipc	s4,0x5
    15cc:	ba8a0a13          	addi	s4,s4,-1112 # 6170 <malloc+0x17e>
      int n = write(fd, "1234567890", 10);
    15d0:	00005a97          	auipc	s5,0x5
    15d4:	400a8a93          	addi	s5,s5,1024 # 69d0 <malloc+0x9de>
      int fd = open("truncfile", O_WRONLY);
    15d8:	4585                	li	a1,1
    15da:	8552                	mv	a0,s4
    15dc:	00004097          	auipc	ra,0x4
    15e0:	624080e7          	jalr	1572(ra) # 5c00 <open>
    15e4:	84aa                	mv	s1,a0
      if(fd < 0){
    15e6:	06054a63          	bltz	a0,165a <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    15ea:	4629                	li	a2,10
    15ec:	85d6                	mv	a1,s5
    15ee:	00004097          	auipc	ra,0x4
    15f2:	5f2080e7          	jalr	1522(ra) # 5be0 <write>
      if(n != 10){
    15f6:	47a9                	li	a5,10
    15f8:	06f51f63          	bne	a0,a5,1676 <truncate3+0xf0>
      close(fd);
    15fc:	8526                	mv	a0,s1
    15fe:	00004097          	auipc	ra,0x4
    1602:	5ea080e7          	jalr	1514(ra) # 5be8 <close>
      fd = open("truncfile", O_RDONLY);
    1606:	4581                	li	a1,0
    1608:	8552                	mv	a0,s4
    160a:	00004097          	auipc	ra,0x4
    160e:	5f6080e7          	jalr	1526(ra) # 5c00 <open>
    1612:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1614:	02000613          	li	a2,32
    1618:	f9840593          	addi	a1,s0,-104
    161c:	00004097          	auipc	ra,0x4
    1620:	5bc080e7          	jalr	1468(ra) # 5bd8 <read>
      close(fd);
    1624:	8526                	mv	a0,s1
    1626:	00004097          	auipc	ra,0x4
    162a:	5c2080e7          	jalr	1474(ra) # 5be8 <close>
    for(int i = 0; i < 100; i++){
    162e:	39fd                	addiw	s3,s3,-1
    1630:	fa0994e3          	bnez	s3,15d8 <truncate3+0x52>
    exit(0);
    1634:	4501                	li	a0,0
    1636:	00004097          	auipc	ra,0x4
    163a:	58a080e7          	jalr	1418(ra) # 5bc0 <exit>
    printf("%s: fork failed\n", s);
    163e:	85ca                	mv	a1,s2
    1640:	00005517          	auipc	a0,0x5
    1644:	36050513          	addi	a0,a0,864 # 69a0 <malloc+0x9ae>
    1648:	00005097          	auipc	ra,0x5
    164c:	8f2080e7          	jalr	-1806(ra) # 5f3a <printf>
    exit(1);
    1650:	4505                	li	a0,1
    1652:	00004097          	auipc	ra,0x4
    1656:	56e080e7          	jalr	1390(ra) # 5bc0 <exit>
        printf("%s: open failed\n", s);
    165a:	85ca                	mv	a1,s2
    165c:	00005517          	auipc	a0,0x5
    1660:	35c50513          	addi	a0,a0,860 # 69b8 <malloc+0x9c6>
    1664:	00005097          	auipc	ra,0x5
    1668:	8d6080e7          	jalr	-1834(ra) # 5f3a <printf>
        exit(1);
    166c:	4505                	li	a0,1
    166e:	00004097          	auipc	ra,0x4
    1672:	552080e7          	jalr	1362(ra) # 5bc0 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1676:	862a                	mv	a2,a0
    1678:	85ca                	mv	a1,s2
    167a:	00005517          	auipc	a0,0x5
    167e:	36650513          	addi	a0,a0,870 # 69e0 <malloc+0x9ee>
    1682:	00005097          	auipc	ra,0x5
    1686:	8b8080e7          	jalr	-1864(ra) # 5f3a <printf>
        exit(1);
    168a:	4505                	li	a0,1
    168c:	00004097          	auipc	ra,0x4
    1690:	534080e7          	jalr	1332(ra) # 5bc0 <exit>
    1694:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    1698:	00005a17          	auipc	s4,0x5
    169c:	ad8a0a13          	addi	s4,s4,-1320 # 6170 <malloc+0x17e>
    int n = write(fd, "xxx", 3);
    16a0:	00005a97          	auipc	s5,0x5
    16a4:	360a8a93          	addi	s5,s5,864 # 6a00 <malloc+0xa0e>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    16a8:	60100593          	li	a1,1537
    16ac:	8552                	mv	a0,s4
    16ae:	00004097          	auipc	ra,0x4
    16b2:	552080e7          	jalr	1362(ra) # 5c00 <open>
    16b6:	84aa                	mv	s1,a0
    if(fd < 0){
    16b8:	04054763          	bltz	a0,1706 <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    16bc:	460d                	li	a2,3
    16be:	85d6                	mv	a1,s5
    16c0:	00004097          	auipc	ra,0x4
    16c4:	520080e7          	jalr	1312(ra) # 5be0 <write>
    if(n != 3){
    16c8:	478d                	li	a5,3
    16ca:	04f51c63          	bne	a0,a5,1722 <truncate3+0x19c>
    close(fd);
    16ce:	8526                	mv	a0,s1
    16d0:	00004097          	auipc	ra,0x4
    16d4:	518080e7          	jalr	1304(ra) # 5be8 <close>
  for(int i = 0; i < 150; i++){
    16d8:	39fd                	addiw	s3,s3,-1
    16da:	fc0997e3          	bnez	s3,16a8 <truncate3+0x122>
  wait(&xstatus);
    16de:	fbc40513          	addi	a0,s0,-68
    16e2:	00004097          	auipc	ra,0x4
    16e6:	4e6080e7          	jalr	1254(ra) # 5bc8 <wait>
  unlink("truncfile");
    16ea:	00005517          	auipc	a0,0x5
    16ee:	a8650513          	addi	a0,a0,-1402 # 6170 <malloc+0x17e>
    16f2:	00004097          	auipc	ra,0x4
    16f6:	51e080e7          	jalr	1310(ra) # 5c10 <unlink>
  exit(xstatus);
    16fa:	fbc42503          	lw	a0,-68(s0)
    16fe:	00004097          	auipc	ra,0x4
    1702:	4c2080e7          	jalr	1218(ra) # 5bc0 <exit>
      printf("%s: open failed\n", s);
    1706:	85ca                	mv	a1,s2
    1708:	00005517          	auipc	a0,0x5
    170c:	2b050513          	addi	a0,a0,688 # 69b8 <malloc+0x9c6>
    1710:	00005097          	auipc	ra,0x5
    1714:	82a080e7          	jalr	-2006(ra) # 5f3a <printf>
      exit(1);
    1718:	4505                	li	a0,1
    171a:	00004097          	auipc	ra,0x4
    171e:	4a6080e7          	jalr	1190(ra) # 5bc0 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1722:	862a                	mv	a2,a0
    1724:	85ca                	mv	a1,s2
    1726:	00005517          	auipc	a0,0x5
    172a:	2e250513          	addi	a0,a0,738 # 6a08 <malloc+0xa16>
    172e:	00005097          	auipc	ra,0x5
    1732:	80c080e7          	jalr	-2036(ra) # 5f3a <printf>
      exit(1);
    1736:	4505                	li	a0,1
    1738:	00004097          	auipc	ra,0x4
    173c:	488080e7          	jalr	1160(ra) # 5bc0 <exit>

0000000000001740 <exectest>:
{
    1740:	715d                	addi	sp,sp,-80
    1742:	e486                	sd	ra,72(sp)
    1744:	e0a2                	sd	s0,64(sp)
    1746:	fc26                	sd	s1,56(sp)
    1748:	f84a                	sd	s2,48(sp)
    174a:	0880                	addi	s0,sp,80
    174c:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    174e:	00005797          	auipc	a5,0x5
    1752:	9ca78793          	addi	a5,a5,-1590 # 6118 <malloc+0x126>
    1756:	fcf43023          	sd	a5,-64(s0)
    175a:	00005797          	auipc	a5,0x5
    175e:	2ce78793          	addi	a5,a5,718 # 6a28 <malloc+0xa36>
    1762:	fcf43423          	sd	a5,-56(s0)
    1766:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    176a:	00005517          	auipc	a0,0x5
    176e:	2c650513          	addi	a0,a0,710 # 6a30 <malloc+0xa3e>
    1772:	00004097          	auipc	ra,0x4
    1776:	49e080e7          	jalr	1182(ra) # 5c10 <unlink>
  pid = fork();
    177a:	00004097          	auipc	ra,0x4
    177e:	43e080e7          	jalr	1086(ra) # 5bb8 <fork>
  if(pid < 0) {
    1782:	04054663          	bltz	a0,17ce <exectest+0x8e>
    1786:	84aa                	mv	s1,a0
  if(pid == 0) {
    1788:	e959                	bnez	a0,181e <exectest+0xde>
    close(1);
    178a:	4505                	li	a0,1
    178c:	00004097          	auipc	ra,0x4
    1790:	45c080e7          	jalr	1116(ra) # 5be8 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1794:	20100593          	li	a1,513
    1798:	00005517          	auipc	a0,0x5
    179c:	29850513          	addi	a0,a0,664 # 6a30 <malloc+0xa3e>
    17a0:	00004097          	auipc	ra,0x4
    17a4:	460080e7          	jalr	1120(ra) # 5c00 <open>
    if(fd < 0) {
    17a8:	04054163          	bltz	a0,17ea <exectest+0xaa>
    if(fd != 1) {
    17ac:	4785                	li	a5,1
    17ae:	04f50c63          	beq	a0,a5,1806 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    17b2:	85ca                	mv	a1,s2
    17b4:	00005517          	auipc	a0,0x5
    17b8:	29c50513          	addi	a0,a0,668 # 6a50 <malloc+0xa5e>
    17bc:	00004097          	auipc	ra,0x4
    17c0:	77e080e7          	jalr	1918(ra) # 5f3a <printf>
      exit(1);
    17c4:	4505                	li	a0,1
    17c6:	00004097          	auipc	ra,0x4
    17ca:	3fa080e7          	jalr	1018(ra) # 5bc0 <exit>
     printf("%s: fork failed\n", s);
    17ce:	85ca                	mv	a1,s2
    17d0:	00005517          	auipc	a0,0x5
    17d4:	1d050513          	addi	a0,a0,464 # 69a0 <malloc+0x9ae>
    17d8:	00004097          	auipc	ra,0x4
    17dc:	762080e7          	jalr	1890(ra) # 5f3a <printf>
     exit(1);
    17e0:	4505                	li	a0,1
    17e2:	00004097          	auipc	ra,0x4
    17e6:	3de080e7          	jalr	990(ra) # 5bc0 <exit>
      printf("%s: create failed\n", s);
    17ea:	85ca                	mv	a1,s2
    17ec:	00005517          	auipc	a0,0x5
    17f0:	24c50513          	addi	a0,a0,588 # 6a38 <malloc+0xa46>
    17f4:	00004097          	auipc	ra,0x4
    17f8:	746080e7          	jalr	1862(ra) # 5f3a <printf>
      exit(1);
    17fc:	4505                	li	a0,1
    17fe:	00004097          	auipc	ra,0x4
    1802:	3c2080e7          	jalr	962(ra) # 5bc0 <exit>
    if(exec("echo", echoargv) < 0){
    1806:	fc040593          	addi	a1,s0,-64
    180a:	00005517          	auipc	a0,0x5
    180e:	90e50513          	addi	a0,a0,-1778 # 6118 <malloc+0x126>
    1812:	00004097          	auipc	ra,0x4
    1816:	3e6080e7          	jalr	998(ra) # 5bf8 <exec>
    181a:	02054163          	bltz	a0,183c <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    181e:	fdc40513          	addi	a0,s0,-36
    1822:	00004097          	auipc	ra,0x4
    1826:	3a6080e7          	jalr	934(ra) # 5bc8 <wait>
    182a:	02951763          	bne	a0,s1,1858 <exectest+0x118>
  if(xstatus != 0)
    182e:	fdc42503          	lw	a0,-36(s0)
    1832:	cd0d                	beqz	a0,186c <exectest+0x12c>
    exit(xstatus);
    1834:	00004097          	auipc	ra,0x4
    1838:	38c080e7          	jalr	908(ra) # 5bc0 <exit>
      printf("%s: exec echo failed\n", s);
    183c:	85ca                	mv	a1,s2
    183e:	00005517          	auipc	a0,0x5
    1842:	22250513          	addi	a0,a0,546 # 6a60 <malloc+0xa6e>
    1846:	00004097          	auipc	ra,0x4
    184a:	6f4080e7          	jalr	1780(ra) # 5f3a <printf>
      exit(1);
    184e:	4505                	li	a0,1
    1850:	00004097          	auipc	ra,0x4
    1854:	370080e7          	jalr	880(ra) # 5bc0 <exit>
    printf("%s: wait failed!\n", s);
    1858:	85ca                	mv	a1,s2
    185a:	00005517          	auipc	a0,0x5
    185e:	21e50513          	addi	a0,a0,542 # 6a78 <malloc+0xa86>
    1862:	00004097          	auipc	ra,0x4
    1866:	6d8080e7          	jalr	1752(ra) # 5f3a <printf>
    186a:	b7d1                	j	182e <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    186c:	4581                	li	a1,0
    186e:	00005517          	auipc	a0,0x5
    1872:	1c250513          	addi	a0,a0,450 # 6a30 <malloc+0xa3e>
    1876:	00004097          	auipc	ra,0x4
    187a:	38a080e7          	jalr	906(ra) # 5c00 <open>
  if(fd < 0) {
    187e:	02054a63          	bltz	a0,18b2 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    1882:	4609                	li	a2,2
    1884:	fb840593          	addi	a1,s0,-72
    1888:	00004097          	auipc	ra,0x4
    188c:	350080e7          	jalr	848(ra) # 5bd8 <read>
    1890:	4789                	li	a5,2
    1892:	02f50e63          	beq	a0,a5,18ce <exectest+0x18e>
    printf("%s: read failed\n", s);
    1896:	85ca                	mv	a1,s2
    1898:	00005517          	auipc	a0,0x5
    189c:	c5050513          	addi	a0,a0,-944 # 64e8 <malloc+0x4f6>
    18a0:	00004097          	auipc	ra,0x4
    18a4:	69a080e7          	jalr	1690(ra) # 5f3a <printf>
    exit(1);
    18a8:	4505                	li	a0,1
    18aa:	00004097          	auipc	ra,0x4
    18ae:	316080e7          	jalr	790(ra) # 5bc0 <exit>
    printf("%s: open failed\n", s);
    18b2:	85ca                	mv	a1,s2
    18b4:	00005517          	auipc	a0,0x5
    18b8:	10450513          	addi	a0,a0,260 # 69b8 <malloc+0x9c6>
    18bc:	00004097          	auipc	ra,0x4
    18c0:	67e080e7          	jalr	1662(ra) # 5f3a <printf>
    exit(1);
    18c4:	4505                	li	a0,1
    18c6:	00004097          	auipc	ra,0x4
    18ca:	2fa080e7          	jalr	762(ra) # 5bc0 <exit>
  unlink("echo-ok");
    18ce:	00005517          	auipc	a0,0x5
    18d2:	16250513          	addi	a0,a0,354 # 6a30 <malloc+0xa3e>
    18d6:	00004097          	auipc	ra,0x4
    18da:	33a080e7          	jalr	826(ra) # 5c10 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    18de:	fb844703          	lbu	a4,-72(s0)
    18e2:	04f00793          	li	a5,79
    18e6:	00f71863          	bne	a4,a5,18f6 <exectest+0x1b6>
    18ea:	fb944703          	lbu	a4,-71(s0)
    18ee:	04b00793          	li	a5,75
    18f2:	02f70063          	beq	a4,a5,1912 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    18f6:	85ca                	mv	a1,s2
    18f8:	00005517          	auipc	a0,0x5
    18fc:	19850513          	addi	a0,a0,408 # 6a90 <malloc+0xa9e>
    1900:	00004097          	auipc	ra,0x4
    1904:	63a080e7          	jalr	1594(ra) # 5f3a <printf>
    exit(1);
    1908:	4505                	li	a0,1
    190a:	00004097          	auipc	ra,0x4
    190e:	2b6080e7          	jalr	694(ra) # 5bc0 <exit>
    exit(0);
    1912:	4501                	li	a0,0
    1914:	00004097          	auipc	ra,0x4
    1918:	2ac080e7          	jalr	684(ra) # 5bc0 <exit>

000000000000191c <pipe1>:
{
    191c:	711d                	addi	sp,sp,-96
    191e:	ec86                	sd	ra,88(sp)
    1920:	e8a2                	sd	s0,80(sp)
    1922:	e4a6                	sd	s1,72(sp)
    1924:	e0ca                	sd	s2,64(sp)
    1926:	fc4e                	sd	s3,56(sp)
    1928:	f852                	sd	s4,48(sp)
    192a:	f456                	sd	s5,40(sp)
    192c:	f05a                	sd	s6,32(sp)
    192e:	ec5e                	sd	s7,24(sp)
    1930:	1080                	addi	s0,sp,96
    1932:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    1934:	fa840513          	addi	a0,s0,-88
    1938:	00004097          	auipc	ra,0x4
    193c:	298080e7          	jalr	664(ra) # 5bd0 <pipe>
    1940:	e93d                	bnez	a0,19b6 <pipe1+0x9a>
    1942:	84aa                	mv	s1,a0
  pid = fork();
    1944:	00004097          	auipc	ra,0x4
    1948:	274080e7          	jalr	628(ra) # 5bb8 <fork>
    194c:	8a2a                	mv	s4,a0
  if(pid == 0){
    194e:	c151                	beqz	a0,19d2 <pipe1+0xb6>
  } else if(pid > 0){
    1950:	16a05d63          	blez	a0,1aca <pipe1+0x1ae>
    close(fds[1]);
    1954:	fac42503          	lw	a0,-84(s0)
    1958:	00004097          	auipc	ra,0x4
    195c:	290080e7          	jalr	656(ra) # 5be8 <close>
    total = 0;
    1960:	8a26                	mv	s4,s1
    cc = 1;
    1962:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    1964:	0000ba97          	auipc	s5,0xb
    1968:	314a8a93          	addi	s5,s5,788 # cc78 <buf>
      if(cc > sizeof(buf))
    196c:	6b0d                	lui	s6,0x3
    while((n = read(fds[0], buf, cc)) > 0){
    196e:	864e                	mv	a2,s3
    1970:	85d6                	mv	a1,s5
    1972:	fa842503          	lw	a0,-88(s0)
    1976:	00004097          	auipc	ra,0x4
    197a:	262080e7          	jalr	610(ra) # 5bd8 <read>
    197e:	10a05163          	blez	a0,1a80 <pipe1+0x164>
      for(i = 0; i < n; i++){
    1982:	0000b717          	auipc	a4,0xb
    1986:	2f670713          	addi	a4,a4,758 # cc78 <buf>
    198a:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    198e:	00074683          	lbu	a3,0(a4)
    1992:	0ff4f793          	zext.b	a5,s1
    1996:	2485                	addiw	s1,s1,1
    1998:	0cf69063          	bne	a3,a5,1a58 <pipe1+0x13c>
      for(i = 0; i < n; i++){
    199c:	0705                	addi	a4,a4,1
    199e:	fec498e3          	bne	s1,a2,198e <pipe1+0x72>
      total += n;
    19a2:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    19a6:	0019979b          	slliw	a5,s3,0x1
    19aa:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    19ae:	fd3b70e3          	bgeu	s6,s3,196e <pipe1+0x52>
        cc = sizeof(buf);
    19b2:	89da                	mv	s3,s6
    19b4:	bf6d                	j	196e <pipe1+0x52>
    printf("%s: pipe() failed\n", s);
    19b6:	85ca                	mv	a1,s2
    19b8:	00005517          	auipc	a0,0x5
    19bc:	0f050513          	addi	a0,a0,240 # 6aa8 <malloc+0xab6>
    19c0:	00004097          	auipc	ra,0x4
    19c4:	57a080e7          	jalr	1402(ra) # 5f3a <printf>
    exit(1);
    19c8:	4505                	li	a0,1
    19ca:	00004097          	auipc	ra,0x4
    19ce:	1f6080e7          	jalr	502(ra) # 5bc0 <exit>
    close(fds[0]);
    19d2:	fa842503          	lw	a0,-88(s0)
    19d6:	00004097          	auipc	ra,0x4
    19da:	212080e7          	jalr	530(ra) # 5be8 <close>
    for(n = 0; n < N; n++){
    19de:	0000bb17          	auipc	s6,0xb
    19e2:	29ab0b13          	addi	s6,s6,666 # cc78 <buf>
    19e6:	416004bb          	negw	s1,s6
    19ea:	0ff4f493          	zext.b	s1,s1
    19ee:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    19f2:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    19f4:	6a85                	lui	s5,0x1
    19f6:	42da8a93          	addi	s5,s5,1069 # 142d <copyinstr2+0x9d>
{
    19fa:	87da                	mv	a5,s6
        buf[i] = seq++;
    19fc:	0097873b          	addw	a4,a5,s1
    1a00:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1a04:	0785                	addi	a5,a5,1
    1a06:	fef99be3          	bne	s3,a5,19fc <pipe1+0xe0>
        buf[i] = seq++;
    1a0a:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1a0e:	40900613          	li	a2,1033
    1a12:	85de                	mv	a1,s7
    1a14:	fac42503          	lw	a0,-84(s0)
    1a18:	00004097          	auipc	ra,0x4
    1a1c:	1c8080e7          	jalr	456(ra) # 5be0 <write>
    1a20:	40900793          	li	a5,1033
    1a24:	00f51c63          	bne	a0,a5,1a3c <pipe1+0x120>
    for(n = 0; n < N; n++){
    1a28:	24a5                	addiw	s1,s1,9
    1a2a:	0ff4f493          	zext.b	s1,s1
    1a2e:	fd5a16e3          	bne	s4,s5,19fa <pipe1+0xde>
    exit(0);
    1a32:	4501                	li	a0,0
    1a34:	00004097          	auipc	ra,0x4
    1a38:	18c080e7          	jalr	396(ra) # 5bc0 <exit>
        printf("%s: pipe1 oops 1\n", s);
    1a3c:	85ca                	mv	a1,s2
    1a3e:	00005517          	auipc	a0,0x5
    1a42:	08250513          	addi	a0,a0,130 # 6ac0 <malloc+0xace>
    1a46:	00004097          	auipc	ra,0x4
    1a4a:	4f4080e7          	jalr	1268(ra) # 5f3a <printf>
        exit(1);
    1a4e:	4505                	li	a0,1
    1a50:	00004097          	auipc	ra,0x4
    1a54:	170080e7          	jalr	368(ra) # 5bc0 <exit>
          printf("%s: pipe1 oops 2\n", s);
    1a58:	85ca                	mv	a1,s2
    1a5a:	00005517          	auipc	a0,0x5
    1a5e:	07e50513          	addi	a0,a0,126 # 6ad8 <malloc+0xae6>
    1a62:	00004097          	auipc	ra,0x4
    1a66:	4d8080e7          	jalr	1240(ra) # 5f3a <printf>
}
    1a6a:	60e6                	ld	ra,88(sp)
    1a6c:	6446                	ld	s0,80(sp)
    1a6e:	64a6                	ld	s1,72(sp)
    1a70:	6906                	ld	s2,64(sp)
    1a72:	79e2                	ld	s3,56(sp)
    1a74:	7a42                	ld	s4,48(sp)
    1a76:	7aa2                	ld	s5,40(sp)
    1a78:	7b02                	ld	s6,32(sp)
    1a7a:	6be2                	ld	s7,24(sp)
    1a7c:	6125                	addi	sp,sp,96
    1a7e:	8082                	ret
    if(total != N * SZ){
    1a80:	6785                	lui	a5,0x1
    1a82:	42d78793          	addi	a5,a5,1069 # 142d <copyinstr2+0x9d>
    1a86:	02fa0063          	beq	s4,a5,1aa6 <pipe1+0x18a>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1a8a:	85d2                	mv	a1,s4
    1a8c:	00005517          	auipc	a0,0x5
    1a90:	06450513          	addi	a0,a0,100 # 6af0 <malloc+0xafe>
    1a94:	00004097          	auipc	ra,0x4
    1a98:	4a6080e7          	jalr	1190(ra) # 5f3a <printf>
      exit(1);
    1a9c:	4505                	li	a0,1
    1a9e:	00004097          	auipc	ra,0x4
    1aa2:	122080e7          	jalr	290(ra) # 5bc0 <exit>
    close(fds[0]);
    1aa6:	fa842503          	lw	a0,-88(s0)
    1aaa:	00004097          	auipc	ra,0x4
    1aae:	13e080e7          	jalr	318(ra) # 5be8 <close>
    wait(&xstatus);
    1ab2:	fa440513          	addi	a0,s0,-92
    1ab6:	00004097          	auipc	ra,0x4
    1aba:	112080e7          	jalr	274(ra) # 5bc8 <wait>
    exit(xstatus);
    1abe:	fa442503          	lw	a0,-92(s0)
    1ac2:	00004097          	auipc	ra,0x4
    1ac6:	0fe080e7          	jalr	254(ra) # 5bc0 <exit>
    printf("%s: fork() failed\n", s);
    1aca:	85ca                	mv	a1,s2
    1acc:	00005517          	auipc	a0,0x5
    1ad0:	04450513          	addi	a0,a0,68 # 6b10 <malloc+0xb1e>
    1ad4:	00004097          	auipc	ra,0x4
    1ad8:	466080e7          	jalr	1126(ra) # 5f3a <printf>
    exit(1);
    1adc:	4505                	li	a0,1
    1ade:	00004097          	auipc	ra,0x4
    1ae2:	0e2080e7          	jalr	226(ra) # 5bc0 <exit>

0000000000001ae6 <exitwait>:
{
    1ae6:	7139                	addi	sp,sp,-64
    1ae8:	fc06                	sd	ra,56(sp)
    1aea:	f822                	sd	s0,48(sp)
    1aec:	f426                	sd	s1,40(sp)
    1aee:	f04a                	sd	s2,32(sp)
    1af0:	ec4e                	sd	s3,24(sp)
    1af2:	e852                	sd	s4,16(sp)
    1af4:	0080                	addi	s0,sp,64
    1af6:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1af8:	4901                	li	s2,0
    1afa:	06400993          	li	s3,100
    pid = fork();
    1afe:	00004097          	auipc	ra,0x4
    1b02:	0ba080e7          	jalr	186(ra) # 5bb8 <fork>
    1b06:	84aa                	mv	s1,a0
    if(pid < 0){
    1b08:	02054a63          	bltz	a0,1b3c <exitwait+0x56>
    if(pid){
    1b0c:	c151                	beqz	a0,1b90 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    1b0e:	fcc40513          	addi	a0,s0,-52
    1b12:	00004097          	auipc	ra,0x4
    1b16:	0b6080e7          	jalr	182(ra) # 5bc8 <wait>
    1b1a:	02951f63          	bne	a0,s1,1b58 <exitwait+0x72>
      if(i != xstate) {
    1b1e:	fcc42783          	lw	a5,-52(s0)
    1b22:	05279963          	bne	a5,s2,1b74 <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    1b26:	2905                	addiw	s2,s2,1
    1b28:	fd391be3          	bne	s2,s3,1afe <exitwait+0x18>
}
    1b2c:	70e2                	ld	ra,56(sp)
    1b2e:	7442                	ld	s0,48(sp)
    1b30:	74a2                	ld	s1,40(sp)
    1b32:	7902                	ld	s2,32(sp)
    1b34:	69e2                	ld	s3,24(sp)
    1b36:	6a42                	ld	s4,16(sp)
    1b38:	6121                	addi	sp,sp,64
    1b3a:	8082                	ret
      printf("%s: fork failed\n", s);
    1b3c:	85d2                	mv	a1,s4
    1b3e:	00005517          	auipc	a0,0x5
    1b42:	e6250513          	addi	a0,a0,-414 # 69a0 <malloc+0x9ae>
    1b46:	00004097          	auipc	ra,0x4
    1b4a:	3f4080e7          	jalr	1012(ra) # 5f3a <printf>
      exit(1);
    1b4e:	4505                	li	a0,1
    1b50:	00004097          	auipc	ra,0x4
    1b54:	070080e7          	jalr	112(ra) # 5bc0 <exit>
        printf("%s: wait wrong pid\n", s);
    1b58:	85d2                	mv	a1,s4
    1b5a:	00005517          	auipc	a0,0x5
    1b5e:	fce50513          	addi	a0,a0,-50 # 6b28 <malloc+0xb36>
    1b62:	00004097          	auipc	ra,0x4
    1b66:	3d8080e7          	jalr	984(ra) # 5f3a <printf>
        exit(1);
    1b6a:	4505                	li	a0,1
    1b6c:	00004097          	auipc	ra,0x4
    1b70:	054080e7          	jalr	84(ra) # 5bc0 <exit>
        printf("%s: wait wrong exit status\n", s);
    1b74:	85d2                	mv	a1,s4
    1b76:	00005517          	auipc	a0,0x5
    1b7a:	fca50513          	addi	a0,a0,-54 # 6b40 <malloc+0xb4e>
    1b7e:	00004097          	auipc	ra,0x4
    1b82:	3bc080e7          	jalr	956(ra) # 5f3a <printf>
        exit(1);
    1b86:	4505                	li	a0,1
    1b88:	00004097          	auipc	ra,0x4
    1b8c:	038080e7          	jalr	56(ra) # 5bc0 <exit>
      exit(i);
    1b90:	854a                	mv	a0,s2
    1b92:	00004097          	auipc	ra,0x4
    1b96:	02e080e7          	jalr	46(ra) # 5bc0 <exit>

0000000000001b9a <twochildren>:
{
    1b9a:	1101                	addi	sp,sp,-32
    1b9c:	ec06                	sd	ra,24(sp)
    1b9e:	e822                	sd	s0,16(sp)
    1ba0:	e426                	sd	s1,8(sp)
    1ba2:	e04a                	sd	s2,0(sp)
    1ba4:	1000                	addi	s0,sp,32
    1ba6:	892a                	mv	s2,a0
    1ba8:	3e800493          	li	s1,1000
    int pid1 = fork();
    1bac:	00004097          	auipc	ra,0x4
    1bb0:	00c080e7          	jalr	12(ra) # 5bb8 <fork>
    if(pid1 < 0){
    1bb4:	02054c63          	bltz	a0,1bec <twochildren+0x52>
    if(pid1 == 0){
    1bb8:	c921                	beqz	a0,1c08 <twochildren+0x6e>
      int pid2 = fork();
    1bba:	00004097          	auipc	ra,0x4
    1bbe:	ffe080e7          	jalr	-2(ra) # 5bb8 <fork>
      if(pid2 < 0){
    1bc2:	04054763          	bltz	a0,1c10 <twochildren+0x76>
      if(pid2 == 0){
    1bc6:	c13d                	beqz	a0,1c2c <twochildren+0x92>
        wait(0);
    1bc8:	4501                	li	a0,0
    1bca:	00004097          	auipc	ra,0x4
    1bce:	ffe080e7          	jalr	-2(ra) # 5bc8 <wait>
        wait(0);
    1bd2:	4501                	li	a0,0
    1bd4:	00004097          	auipc	ra,0x4
    1bd8:	ff4080e7          	jalr	-12(ra) # 5bc8 <wait>
  for(int i = 0; i < 1000; i++){
    1bdc:	34fd                	addiw	s1,s1,-1
    1bde:	f4f9                	bnez	s1,1bac <twochildren+0x12>
}
    1be0:	60e2                	ld	ra,24(sp)
    1be2:	6442                	ld	s0,16(sp)
    1be4:	64a2                	ld	s1,8(sp)
    1be6:	6902                	ld	s2,0(sp)
    1be8:	6105                	addi	sp,sp,32
    1bea:	8082                	ret
      printf("%s: fork failed\n", s);
    1bec:	85ca                	mv	a1,s2
    1bee:	00005517          	auipc	a0,0x5
    1bf2:	db250513          	addi	a0,a0,-590 # 69a0 <malloc+0x9ae>
    1bf6:	00004097          	auipc	ra,0x4
    1bfa:	344080e7          	jalr	836(ra) # 5f3a <printf>
      exit(1);
    1bfe:	4505                	li	a0,1
    1c00:	00004097          	auipc	ra,0x4
    1c04:	fc0080e7          	jalr	-64(ra) # 5bc0 <exit>
      exit(0);
    1c08:	00004097          	auipc	ra,0x4
    1c0c:	fb8080e7          	jalr	-72(ra) # 5bc0 <exit>
        printf("%s: fork failed\n", s);
    1c10:	85ca                	mv	a1,s2
    1c12:	00005517          	auipc	a0,0x5
    1c16:	d8e50513          	addi	a0,a0,-626 # 69a0 <malloc+0x9ae>
    1c1a:	00004097          	auipc	ra,0x4
    1c1e:	320080e7          	jalr	800(ra) # 5f3a <printf>
        exit(1);
    1c22:	4505                	li	a0,1
    1c24:	00004097          	auipc	ra,0x4
    1c28:	f9c080e7          	jalr	-100(ra) # 5bc0 <exit>
        exit(0);
    1c2c:	00004097          	auipc	ra,0x4
    1c30:	f94080e7          	jalr	-108(ra) # 5bc0 <exit>

0000000000001c34 <forkfork>:
{
    1c34:	7179                	addi	sp,sp,-48
    1c36:	f406                	sd	ra,40(sp)
    1c38:	f022                	sd	s0,32(sp)
    1c3a:	ec26                	sd	s1,24(sp)
    1c3c:	1800                	addi	s0,sp,48
    1c3e:	84aa                	mv	s1,a0
    int pid = fork();
    1c40:	00004097          	auipc	ra,0x4
    1c44:	f78080e7          	jalr	-136(ra) # 5bb8 <fork>
    if(pid < 0){
    1c48:	04054163          	bltz	a0,1c8a <forkfork+0x56>
    if(pid == 0){
    1c4c:	cd29                	beqz	a0,1ca6 <forkfork+0x72>
    int pid = fork();
    1c4e:	00004097          	auipc	ra,0x4
    1c52:	f6a080e7          	jalr	-150(ra) # 5bb8 <fork>
    if(pid < 0){
    1c56:	02054a63          	bltz	a0,1c8a <forkfork+0x56>
    if(pid == 0){
    1c5a:	c531                	beqz	a0,1ca6 <forkfork+0x72>
    wait(&xstatus);
    1c5c:	fdc40513          	addi	a0,s0,-36
    1c60:	00004097          	auipc	ra,0x4
    1c64:	f68080e7          	jalr	-152(ra) # 5bc8 <wait>
    if(xstatus != 0) {
    1c68:	fdc42783          	lw	a5,-36(s0)
    1c6c:	ebbd                	bnez	a5,1ce2 <forkfork+0xae>
    wait(&xstatus);
    1c6e:	fdc40513          	addi	a0,s0,-36
    1c72:	00004097          	auipc	ra,0x4
    1c76:	f56080e7          	jalr	-170(ra) # 5bc8 <wait>
    if(xstatus != 0) {
    1c7a:	fdc42783          	lw	a5,-36(s0)
    1c7e:	e3b5                	bnez	a5,1ce2 <forkfork+0xae>
}
    1c80:	70a2                	ld	ra,40(sp)
    1c82:	7402                	ld	s0,32(sp)
    1c84:	64e2                	ld	s1,24(sp)
    1c86:	6145                	addi	sp,sp,48
    1c88:	8082                	ret
      printf("%s: fork failed", s);
    1c8a:	85a6                	mv	a1,s1
    1c8c:	00005517          	auipc	a0,0x5
    1c90:	ed450513          	addi	a0,a0,-300 # 6b60 <malloc+0xb6e>
    1c94:	00004097          	auipc	ra,0x4
    1c98:	2a6080e7          	jalr	678(ra) # 5f3a <printf>
      exit(1);
    1c9c:	4505                	li	a0,1
    1c9e:	00004097          	auipc	ra,0x4
    1ca2:	f22080e7          	jalr	-222(ra) # 5bc0 <exit>
{
    1ca6:	0c800493          	li	s1,200
        int pid1 = fork();
    1caa:	00004097          	auipc	ra,0x4
    1cae:	f0e080e7          	jalr	-242(ra) # 5bb8 <fork>
        if(pid1 < 0){
    1cb2:	00054f63          	bltz	a0,1cd0 <forkfork+0x9c>
        if(pid1 == 0){
    1cb6:	c115                	beqz	a0,1cda <forkfork+0xa6>
        wait(0);
    1cb8:	4501                	li	a0,0
    1cba:	00004097          	auipc	ra,0x4
    1cbe:	f0e080e7          	jalr	-242(ra) # 5bc8 <wait>
      for(int j = 0; j < 200; j++){
    1cc2:	34fd                	addiw	s1,s1,-1
    1cc4:	f0fd                	bnez	s1,1caa <forkfork+0x76>
      exit(0);
    1cc6:	4501                	li	a0,0
    1cc8:	00004097          	auipc	ra,0x4
    1ccc:	ef8080e7          	jalr	-264(ra) # 5bc0 <exit>
          exit(1);
    1cd0:	4505                	li	a0,1
    1cd2:	00004097          	auipc	ra,0x4
    1cd6:	eee080e7          	jalr	-274(ra) # 5bc0 <exit>
          exit(0);
    1cda:	00004097          	auipc	ra,0x4
    1cde:	ee6080e7          	jalr	-282(ra) # 5bc0 <exit>
      printf("%s: fork in child failed", s);
    1ce2:	85a6                	mv	a1,s1
    1ce4:	00005517          	auipc	a0,0x5
    1ce8:	e8c50513          	addi	a0,a0,-372 # 6b70 <malloc+0xb7e>
    1cec:	00004097          	auipc	ra,0x4
    1cf0:	24e080e7          	jalr	590(ra) # 5f3a <printf>
      exit(1);
    1cf4:	4505                	li	a0,1
    1cf6:	00004097          	auipc	ra,0x4
    1cfa:	eca080e7          	jalr	-310(ra) # 5bc0 <exit>

0000000000001cfe <reparent2>:
{
    1cfe:	1101                	addi	sp,sp,-32
    1d00:	ec06                	sd	ra,24(sp)
    1d02:	e822                	sd	s0,16(sp)
    1d04:	e426                	sd	s1,8(sp)
    1d06:	1000                	addi	s0,sp,32
    1d08:	32000493          	li	s1,800
    int pid1 = fork();
    1d0c:	00004097          	auipc	ra,0x4
    1d10:	eac080e7          	jalr	-340(ra) # 5bb8 <fork>
    if(pid1 < 0){
    1d14:	00054f63          	bltz	a0,1d32 <reparent2+0x34>
    if(pid1 == 0){
    1d18:	c915                	beqz	a0,1d4c <reparent2+0x4e>
    wait(0);
    1d1a:	4501                	li	a0,0
    1d1c:	00004097          	auipc	ra,0x4
    1d20:	eac080e7          	jalr	-340(ra) # 5bc8 <wait>
  for(int i = 0; i < 800; i++){
    1d24:	34fd                	addiw	s1,s1,-1
    1d26:	f0fd                	bnez	s1,1d0c <reparent2+0xe>
  exit(0);
    1d28:	4501                	li	a0,0
    1d2a:	00004097          	auipc	ra,0x4
    1d2e:	e96080e7          	jalr	-362(ra) # 5bc0 <exit>
      printf("fork failed\n");
    1d32:	00005517          	auipc	a0,0x5
    1d36:	07650513          	addi	a0,a0,118 # 6da8 <malloc+0xdb6>
    1d3a:	00004097          	auipc	ra,0x4
    1d3e:	200080e7          	jalr	512(ra) # 5f3a <printf>
      exit(1);
    1d42:	4505                	li	a0,1
    1d44:	00004097          	auipc	ra,0x4
    1d48:	e7c080e7          	jalr	-388(ra) # 5bc0 <exit>
      fork();
    1d4c:	00004097          	auipc	ra,0x4
    1d50:	e6c080e7          	jalr	-404(ra) # 5bb8 <fork>
      fork();
    1d54:	00004097          	auipc	ra,0x4
    1d58:	e64080e7          	jalr	-412(ra) # 5bb8 <fork>
      exit(0);
    1d5c:	4501                	li	a0,0
    1d5e:	00004097          	auipc	ra,0x4
    1d62:	e62080e7          	jalr	-414(ra) # 5bc0 <exit>

0000000000001d66 <createdelete>:
{
    1d66:	7175                	addi	sp,sp,-144
    1d68:	e506                	sd	ra,136(sp)
    1d6a:	e122                	sd	s0,128(sp)
    1d6c:	fca6                	sd	s1,120(sp)
    1d6e:	f8ca                	sd	s2,112(sp)
    1d70:	f4ce                	sd	s3,104(sp)
    1d72:	f0d2                	sd	s4,96(sp)
    1d74:	ecd6                	sd	s5,88(sp)
    1d76:	e8da                	sd	s6,80(sp)
    1d78:	e4de                	sd	s7,72(sp)
    1d7a:	e0e2                	sd	s8,64(sp)
    1d7c:	fc66                	sd	s9,56(sp)
    1d7e:	0900                	addi	s0,sp,144
    1d80:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1d82:	4901                	li	s2,0
    1d84:	4991                	li	s3,4
    pid = fork();
    1d86:	00004097          	auipc	ra,0x4
    1d8a:	e32080e7          	jalr	-462(ra) # 5bb8 <fork>
    1d8e:	84aa                	mv	s1,a0
    if(pid < 0){
    1d90:	02054f63          	bltz	a0,1dce <createdelete+0x68>
    if(pid == 0){
    1d94:	c939                	beqz	a0,1dea <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1d96:	2905                	addiw	s2,s2,1
    1d98:	ff3917e3          	bne	s2,s3,1d86 <createdelete+0x20>
    1d9c:	4491                	li	s1,4
    wait(&xstatus);
    1d9e:	f7c40513          	addi	a0,s0,-132
    1da2:	00004097          	auipc	ra,0x4
    1da6:	e26080e7          	jalr	-474(ra) # 5bc8 <wait>
    if(xstatus != 0)
    1daa:	f7c42903          	lw	s2,-132(s0)
    1dae:	0e091263          	bnez	s2,1e92 <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    1db2:	34fd                	addiw	s1,s1,-1
    1db4:	f4ed                	bnez	s1,1d9e <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1db6:	f8040123          	sb	zero,-126(s0)
    1dba:	03000993          	li	s3,48
    1dbe:	5a7d                	li	s4,-1
    1dc0:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1dc4:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1dc6:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1dc8:	07400a93          	li	s5,116
    1dcc:	a29d                	j	1f32 <createdelete+0x1cc>
      printf("fork failed\n", s);
    1dce:	85e6                	mv	a1,s9
    1dd0:	00005517          	auipc	a0,0x5
    1dd4:	fd850513          	addi	a0,a0,-40 # 6da8 <malloc+0xdb6>
    1dd8:	00004097          	auipc	ra,0x4
    1ddc:	162080e7          	jalr	354(ra) # 5f3a <printf>
      exit(1);
    1de0:	4505                	li	a0,1
    1de2:	00004097          	auipc	ra,0x4
    1de6:	dde080e7          	jalr	-546(ra) # 5bc0 <exit>
      name[0] = 'p' + pi;
    1dea:	0709091b          	addiw	s2,s2,112
    1dee:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1df2:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1df6:	4951                	li	s2,20
    1df8:	a015                	j	1e1c <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1dfa:	85e6                	mv	a1,s9
    1dfc:	00005517          	auipc	a0,0x5
    1e00:	c3c50513          	addi	a0,a0,-964 # 6a38 <malloc+0xa46>
    1e04:	00004097          	auipc	ra,0x4
    1e08:	136080e7          	jalr	310(ra) # 5f3a <printf>
          exit(1);
    1e0c:	4505                	li	a0,1
    1e0e:	00004097          	auipc	ra,0x4
    1e12:	db2080e7          	jalr	-590(ra) # 5bc0 <exit>
      for(i = 0; i < N; i++){
    1e16:	2485                	addiw	s1,s1,1
    1e18:	07248863          	beq	s1,s2,1e88 <createdelete+0x122>
        name[1] = '0' + i;
    1e1c:	0304879b          	addiw	a5,s1,48
    1e20:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1e24:	20200593          	li	a1,514
    1e28:	f8040513          	addi	a0,s0,-128
    1e2c:	00004097          	auipc	ra,0x4
    1e30:	dd4080e7          	jalr	-556(ra) # 5c00 <open>
        if(fd < 0){
    1e34:	fc0543e3          	bltz	a0,1dfa <createdelete+0x94>
        close(fd);
    1e38:	00004097          	auipc	ra,0x4
    1e3c:	db0080e7          	jalr	-592(ra) # 5be8 <close>
        if(i > 0 && (i % 2 ) == 0){
    1e40:	fc905be3          	blez	s1,1e16 <createdelete+0xb0>
    1e44:	0014f793          	andi	a5,s1,1
    1e48:	f7f9                	bnez	a5,1e16 <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1e4a:	01f4d79b          	srliw	a5,s1,0x1f
    1e4e:	9fa5                	addw	a5,a5,s1
    1e50:	4017d79b          	sraiw	a5,a5,0x1
    1e54:	0307879b          	addiw	a5,a5,48
    1e58:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1e5c:	f8040513          	addi	a0,s0,-128
    1e60:	00004097          	auipc	ra,0x4
    1e64:	db0080e7          	jalr	-592(ra) # 5c10 <unlink>
    1e68:	fa0557e3          	bgez	a0,1e16 <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1e6c:	85e6                	mv	a1,s9
    1e6e:	00005517          	auipc	a0,0x5
    1e72:	d2250513          	addi	a0,a0,-734 # 6b90 <malloc+0xb9e>
    1e76:	00004097          	auipc	ra,0x4
    1e7a:	0c4080e7          	jalr	196(ra) # 5f3a <printf>
            exit(1);
    1e7e:	4505                	li	a0,1
    1e80:	00004097          	auipc	ra,0x4
    1e84:	d40080e7          	jalr	-704(ra) # 5bc0 <exit>
      exit(0);
    1e88:	4501                	li	a0,0
    1e8a:	00004097          	auipc	ra,0x4
    1e8e:	d36080e7          	jalr	-714(ra) # 5bc0 <exit>
      exit(1);
    1e92:	4505                	li	a0,1
    1e94:	00004097          	auipc	ra,0x4
    1e98:	d2c080e7          	jalr	-724(ra) # 5bc0 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1e9c:	f8040613          	addi	a2,s0,-128
    1ea0:	85e6                	mv	a1,s9
    1ea2:	00005517          	auipc	a0,0x5
    1ea6:	d0650513          	addi	a0,a0,-762 # 6ba8 <malloc+0xbb6>
    1eaa:	00004097          	auipc	ra,0x4
    1eae:	090080e7          	jalr	144(ra) # 5f3a <printf>
        exit(1);
    1eb2:	4505                	li	a0,1
    1eb4:	00004097          	auipc	ra,0x4
    1eb8:	d0c080e7          	jalr	-756(ra) # 5bc0 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ebc:	054b7163          	bgeu	s6,s4,1efe <createdelete+0x198>
      if(fd >= 0)
    1ec0:	02055a63          	bgez	a0,1ef4 <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
    1ec4:	2485                	addiw	s1,s1,1
    1ec6:	0ff4f493          	zext.b	s1,s1
    1eca:	05548c63          	beq	s1,s5,1f22 <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1ece:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1ed2:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1ed6:	4581                	li	a1,0
    1ed8:	f8040513          	addi	a0,s0,-128
    1edc:	00004097          	auipc	ra,0x4
    1ee0:	d24080e7          	jalr	-732(ra) # 5c00 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1ee4:	00090463          	beqz	s2,1eec <createdelete+0x186>
    1ee8:	fd2bdae3          	bge	s7,s2,1ebc <createdelete+0x156>
    1eec:	fa0548e3          	bltz	a0,1e9c <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ef0:	014b7963          	bgeu	s6,s4,1f02 <createdelete+0x19c>
        close(fd);
    1ef4:	00004097          	auipc	ra,0x4
    1ef8:	cf4080e7          	jalr	-780(ra) # 5be8 <close>
    1efc:	b7e1                	j	1ec4 <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1efe:	fc0543e3          	bltz	a0,1ec4 <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1f02:	f8040613          	addi	a2,s0,-128
    1f06:	85e6                	mv	a1,s9
    1f08:	00005517          	auipc	a0,0x5
    1f0c:	cc850513          	addi	a0,a0,-824 # 6bd0 <malloc+0xbde>
    1f10:	00004097          	auipc	ra,0x4
    1f14:	02a080e7          	jalr	42(ra) # 5f3a <printf>
        exit(1);
    1f18:	4505                	li	a0,1
    1f1a:	00004097          	auipc	ra,0x4
    1f1e:	ca6080e7          	jalr	-858(ra) # 5bc0 <exit>
  for(i = 0; i < N; i++){
    1f22:	2905                	addiw	s2,s2,1
    1f24:	2a05                	addiw	s4,s4,1
    1f26:	2985                	addiw	s3,s3,1
    1f28:	0ff9f993          	zext.b	s3,s3
    1f2c:	47d1                	li	a5,20
    1f2e:	02f90a63          	beq	s2,a5,1f62 <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
    1f32:	84e2                	mv	s1,s8
    1f34:	bf69                	j	1ece <createdelete+0x168>
  for(i = 0; i < N; i++){
    1f36:	2905                	addiw	s2,s2,1
    1f38:	0ff97913          	zext.b	s2,s2
    1f3c:	2985                	addiw	s3,s3,1
    1f3e:	0ff9f993          	zext.b	s3,s3
    1f42:	03490863          	beq	s2,s4,1f72 <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1f46:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1f48:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1f4c:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1f50:	f8040513          	addi	a0,s0,-128
    1f54:	00004097          	auipc	ra,0x4
    1f58:	cbc080e7          	jalr	-836(ra) # 5c10 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1f5c:	34fd                	addiw	s1,s1,-1
    1f5e:	f4ed                	bnez	s1,1f48 <createdelete+0x1e2>
    1f60:	bfd9                	j	1f36 <createdelete+0x1d0>
    1f62:	03000993          	li	s3,48
    1f66:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1f6a:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1f6c:	08400a13          	li	s4,132
    1f70:	bfd9                	j	1f46 <createdelete+0x1e0>
}
    1f72:	60aa                	ld	ra,136(sp)
    1f74:	640a                	ld	s0,128(sp)
    1f76:	74e6                	ld	s1,120(sp)
    1f78:	7946                	ld	s2,112(sp)
    1f7a:	79a6                	ld	s3,104(sp)
    1f7c:	7a06                	ld	s4,96(sp)
    1f7e:	6ae6                	ld	s5,88(sp)
    1f80:	6b46                	ld	s6,80(sp)
    1f82:	6ba6                	ld	s7,72(sp)
    1f84:	6c06                	ld	s8,64(sp)
    1f86:	7ce2                	ld	s9,56(sp)
    1f88:	6149                	addi	sp,sp,144
    1f8a:	8082                	ret

0000000000001f8c <linkunlink>:
{
    1f8c:	711d                	addi	sp,sp,-96
    1f8e:	ec86                	sd	ra,88(sp)
    1f90:	e8a2                	sd	s0,80(sp)
    1f92:	e4a6                	sd	s1,72(sp)
    1f94:	e0ca                	sd	s2,64(sp)
    1f96:	fc4e                	sd	s3,56(sp)
    1f98:	f852                	sd	s4,48(sp)
    1f9a:	f456                	sd	s5,40(sp)
    1f9c:	f05a                	sd	s6,32(sp)
    1f9e:	ec5e                	sd	s7,24(sp)
    1fa0:	e862                	sd	s8,16(sp)
    1fa2:	e466                	sd	s9,8(sp)
    1fa4:	1080                	addi	s0,sp,96
    1fa6:	84aa                	mv	s1,a0
  unlink("x");
    1fa8:	00004517          	auipc	a0,0x4
    1fac:	1e050513          	addi	a0,a0,480 # 6188 <malloc+0x196>
    1fb0:	00004097          	auipc	ra,0x4
    1fb4:	c60080e7          	jalr	-928(ra) # 5c10 <unlink>
  pid = fork();
    1fb8:	00004097          	auipc	ra,0x4
    1fbc:	c00080e7          	jalr	-1024(ra) # 5bb8 <fork>
  if(pid < 0){
    1fc0:	02054b63          	bltz	a0,1ff6 <linkunlink+0x6a>
    1fc4:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1fc6:	4c85                	li	s9,1
    1fc8:	e119                	bnez	a0,1fce <linkunlink+0x42>
    1fca:	06100c93          	li	s9,97
    1fce:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1fd2:	41c659b7          	lui	s3,0x41c65
    1fd6:	e6d9899b          	addiw	s3,s3,-403 # 41c64e6d <base+0x41c551f5>
    1fda:	690d                	lui	s2,0x3
    1fdc:	0399091b          	addiw	s2,s2,57 # 3039 <fourteen+0x1b>
    if((x % 3) == 0){
    1fe0:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    1fe2:	4b05                	li	s6,1
      unlink("x");
    1fe4:	00004a97          	auipc	s5,0x4
    1fe8:	1a4a8a93          	addi	s5,s5,420 # 6188 <malloc+0x196>
      link("cat", "x");
    1fec:	00005b97          	auipc	s7,0x5
    1ff0:	c0cb8b93          	addi	s7,s7,-1012 # 6bf8 <malloc+0xc06>
    1ff4:	a825                	j	202c <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    1ff6:	85a6                	mv	a1,s1
    1ff8:	00005517          	auipc	a0,0x5
    1ffc:	9a850513          	addi	a0,a0,-1624 # 69a0 <malloc+0x9ae>
    2000:	00004097          	auipc	ra,0x4
    2004:	f3a080e7          	jalr	-198(ra) # 5f3a <printf>
    exit(1);
    2008:	4505                	li	a0,1
    200a:	00004097          	auipc	ra,0x4
    200e:	bb6080e7          	jalr	-1098(ra) # 5bc0 <exit>
      close(open("x", O_RDWR | O_CREATE));
    2012:	20200593          	li	a1,514
    2016:	8556                	mv	a0,s5
    2018:	00004097          	auipc	ra,0x4
    201c:	be8080e7          	jalr	-1048(ra) # 5c00 <open>
    2020:	00004097          	auipc	ra,0x4
    2024:	bc8080e7          	jalr	-1080(ra) # 5be8 <close>
  for(i = 0; i < 100; i++){
    2028:	34fd                	addiw	s1,s1,-1
    202a:	c88d                	beqz	s1,205c <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    202c:	033c87bb          	mulw	a5,s9,s3
    2030:	012787bb          	addw	a5,a5,s2
    2034:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    2038:	0347f7bb          	remuw	a5,a5,s4
    203c:	dbf9                	beqz	a5,2012 <linkunlink+0x86>
    } else if((x % 3) == 1){
    203e:	01678863          	beq	a5,s6,204e <linkunlink+0xc2>
      unlink("x");
    2042:	8556                	mv	a0,s5
    2044:	00004097          	auipc	ra,0x4
    2048:	bcc080e7          	jalr	-1076(ra) # 5c10 <unlink>
    204c:	bff1                	j	2028 <linkunlink+0x9c>
      link("cat", "x");
    204e:	85d6                	mv	a1,s5
    2050:	855e                	mv	a0,s7
    2052:	00004097          	auipc	ra,0x4
    2056:	bce080e7          	jalr	-1074(ra) # 5c20 <link>
    205a:	b7f9                	j	2028 <linkunlink+0x9c>
  if(pid)
    205c:	020c0463          	beqz	s8,2084 <linkunlink+0xf8>
    wait(0);
    2060:	4501                	li	a0,0
    2062:	00004097          	auipc	ra,0x4
    2066:	b66080e7          	jalr	-1178(ra) # 5bc8 <wait>
}
    206a:	60e6                	ld	ra,88(sp)
    206c:	6446                	ld	s0,80(sp)
    206e:	64a6                	ld	s1,72(sp)
    2070:	6906                	ld	s2,64(sp)
    2072:	79e2                	ld	s3,56(sp)
    2074:	7a42                	ld	s4,48(sp)
    2076:	7aa2                	ld	s5,40(sp)
    2078:	7b02                	ld	s6,32(sp)
    207a:	6be2                	ld	s7,24(sp)
    207c:	6c42                	ld	s8,16(sp)
    207e:	6ca2                	ld	s9,8(sp)
    2080:	6125                	addi	sp,sp,96
    2082:	8082                	ret
    exit(0);
    2084:	4501                	li	a0,0
    2086:	00004097          	auipc	ra,0x4
    208a:	b3a080e7          	jalr	-1222(ra) # 5bc0 <exit>

000000000000208e <forktest>:
{
    208e:	7179                	addi	sp,sp,-48
    2090:	f406                	sd	ra,40(sp)
    2092:	f022                	sd	s0,32(sp)
    2094:	ec26                	sd	s1,24(sp)
    2096:	e84a                	sd	s2,16(sp)
    2098:	e44e                	sd	s3,8(sp)
    209a:	1800                	addi	s0,sp,48
    209c:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    209e:	4481                	li	s1,0
    20a0:	3e800913          	li	s2,1000
    pid = fork();
    20a4:	00004097          	auipc	ra,0x4
    20a8:	b14080e7          	jalr	-1260(ra) # 5bb8 <fork>
    if(pid < 0)
    20ac:	02054863          	bltz	a0,20dc <forktest+0x4e>
    if(pid == 0)
    20b0:	c115                	beqz	a0,20d4 <forktest+0x46>
  for(n=0; n<N; n++){
    20b2:	2485                	addiw	s1,s1,1
    20b4:	ff2498e3          	bne	s1,s2,20a4 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    20b8:	85ce                	mv	a1,s3
    20ba:	00005517          	auipc	a0,0x5
    20be:	b5e50513          	addi	a0,a0,-1186 # 6c18 <malloc+0xc26>
    20c2:	00004097          	auipc	ra,0x4
    20c6:	e78080e7          	jalr	-392(ra) # 5f3a <printf>
    exit(1);
    20ca:	4505                	li	a0,1
    20cc:	00004097          	auipc	ra,0x4
    20d0:	af4080e7          	jalr	-1292(ra) # 5bc0 <exit>
      exit(0);
    20d4:	00004097          	auipc	ra,0x4
    20d8:	aec080e7          	jalr	-1300(ra) # 5bc0 <exit>
  if (n == 0) {
    20dc:	cc9d                	beqz	s1,211a <forktest+0x8c>
  if(n == N){
    20de:	3e800793          	li	a5,1000
    20e2:	fcf48be3          	beq	s1,a5,20b8 <forktest+0x2a>
  for(; n > 0; n--){
    20e6:	00905b63          	blez	s1,20fc <forktest+0x6e>
    if(wait(0) < 0){
    20ea:	4501                	li	a0,0
    20ec:	00004097          	auipc	ra,0x4
    20f0:	adc080e7          	jalr	-1316(ra) # 5bc8 <wait>
    20f4:	04054163          	bltz	a0,2136 <forktest+0xa8>
  for(; n > 0; n--){
    20f8:	34fd                	addiw	s1,s1,-1
    20fa:	f8e5                	bnez	s1,20ea <forktest+0x5c>
  if(wait(0) != -1){
    20fc:	4501                	li	a0,0
    20fe:	00004097          	auipc	ra,0x4
    2102:	aca080e7          	jalr	-1334(ra) # 5bc8 <wait>
    2106:	57fd                	li	a5,-1
    2108:	04f51563          	bne	a0,a5,2152 <forktest+0xc4>
}
    210c:	70a2                	ld	ra,40(sp)
    210e:	7402                	ld	s0,32(sp)
    2110:	64e2                	ld	s1,24(sp)
    2112:	6942                	ld	s2,16(sp)
    2114:	69a2                	ld	s3,8(sp)
    2116:	6145                	addi	sp,sp,48
    2118:	8082                	ret
    printf("%s: no fork at all!\n", s);
    211a:	85ce                	mv	a1,s3
    211c:	00005517          	auipc	a0,0x5
    2120:	ae450513          	addi	a0,a0,-1308 # 6c00 <malloc+0xc0e>
    2124:	00004097          	auipc	ra,0x4
    2128:	e16080e7          	jalr	-490(ra) # 5f3a <printf>
    exit(1);
    212c:	4505                	li	a0,1
    212e:	00004097          	auipc	ra,0x4
    2132:	a92080e7          	jalr	-1390(ra) # 5bc0 <exit>
      printf("%s: wait stopped early\n", s);
    2136:	85ce                	mv	a1,s3
    2138:	00005517          	auipc	a0,0x5
    213c:	b0850513          	addi	a0,a0,-1272 # 6c40 <malloc+0xc4e>
    2140:	00004097          	auipc	ra,0x4
    2144:	dfa080e7          	jalr	-518(ra) # 5f3a <printf>
      exit(1);
    2148:	4505                	li	a0,1
    214a:	00004097          	auipc	ra,0x4
    214e:	a76080e7          	jalr	-1418(ra) # 5bc0 <exit>
    printf("%s: wait got too many\n", s);
    2152:	85ce                	mv	a1,s3
    2154:	00005517          	auipc	a0,0x5
    2158:	b0450513          	addi	a0,a0,-1276 # 6c58 <malloc+0xc66>
    215c:	00004097          	auipc	ra,0x4
    2160:	dde080e7          	jalr	-546(ra) # 5f3a <printf>
    exit(1);
    2164:	4505                	li	a0,1
    2166:	00004097          	auipc	ra,0x4
    216a:	a5a080e7          	jalr	-1446(ra) # 5bc0 <exit>

000000000000216e <kernmem>:
{
    216e:	715d                	addi	sp,sp,-80
    2170:	e486                	sd	ra,72(sp)
    2172:	e0a2                	sd	s0,64(sp)
    2174:	fc26                	sd	s1,56(sp)
    2176:	f84a                	sd	s2,48(sp)
    2178:	f44e                	sd	s3,40(sp)
    217a:	f052                	sd	s4,32(sp)
    217c:	ec56                	sd	s5,24(sp)
    217e:	0880                	addi	s0,sp,80
    2180:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2182:	4485                	li	s1,1
    2184:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    2186:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2188:	69b1                	lui	s3,0xc
    218a:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1de8>
    218e:	1003d937          	lui	s2,0x1003d
    2192:	090e                	slli	s2,s2,0x3
    2194:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    2198:	00004097          	auipc	ra,0x4
    219c:	a20080e7          	jalr	-1504(ra) # 5bb8 <fork>
    if(pid < 0){
    21a0:	02054963          	bltz	a0,21d2 <kernmem+0x64>
    if(pid == 0){
    21a4:	c529                	beqz	a0,21ee <kernmem+0x80>
    wait(&xstatus);
    21a6:	fbc40513          	addi	a0,s0,-68
    21aa:	00004097          	auipc	ra,0x4
    21ae:	a1e080e7          	jalr	-1506(ra) # 5bc8 <wait>
    if(xstatus != -1)  // did kernel kill child?
    21b2:	fbc42783          	lw	a5,-68(s0)
    21b6:	05579d63          	bne	a5,s5,2210 <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    21ba:	94ce                	add	s1,s1,s3
    21bc:	fd249ee3          	bne	s1,s2,2198 <kernmem+0x2a>
}
    21c0:	60a6                	ld	ra,72(sp)
    21c2:	6406                	ld	s0,64(sp)
    21c4:	74e2                	ld	s1,56(sp)
    21c6:	7942                	ld	s2,48(sp)
    21c8:	79a2                	ld	s3,40(sp)
    21ca:	7a02                	ld	s4,32(sp)
    21cc:	6ae2                	ld	s5,24(sp)
    21ce:	6161                	addi	sp,sp,80
    21d0:	8082                	ret
      printf("%s: fork failed\n", s);
    21d2:	85d2                	mv	a1,s4
    21d4:	00004517          	auipc	a0,0x4
    21d8:	7cc50513          	addi	a0,a0,1996 # 69a0 <malloc+0x9ae>
    21dc:	00004097          	auipc	ra,0x4
    21e0:	d5e080e7          	jalr	-674(ra) # 5f3a <printf>
      exit(1);
    21e4:	4505                	li	a0,1
    21e6:	00004097          	auipc	ra,0x4
    21ea:	9da080e7          	jalr	-1574(ra) # 5bc0 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    21ee:	0004c683          	lbu	a3,0(s1)
    21f2:	8626                	mv	a2,s1
    21f4:	85d2                	mv	a1,s4
    21f6:	00005517          	auipc	a0,0x5
    21fa:	a7a50513          	addi	a0,a0,-1414 # 6c70 <malloc+0xc7e>
    21fe:	00004097          	auipc	ra,0x4
    2202:	d3c080e7          	jalr	-708(ra) # 5f3a <printf>
      exit(1);
    2206:	4505                	li	a0,1
    2208:	00004097          	auipc	ra,0x4
    220c:	9b8080e7          	jalr	-1608(ra) # 5bc0 <exit>
      exit(1);
    2210:	4505                	li	a0,1
    2212:	00004097          	auipc	ra,0x4
    2216:	9ae080e7          	jalr	-1618(ra) # 5bc0 <exit>

000000000000221a <MAXVAplus>:
{
    221a:	7179                	addi	sp,sp,-48
    221c:	f406                	sd	ra,40(sp)
    221e:	f022                	sd	s0,32(sp)
    2220:	ec26                	sd	s1,24(sp)
    2222:	e84a                	sd	s2,16(sp)
    2224:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    2226:	4785                	li	a5,1
    2228:	179a                	slli	a5,a5,0x26
    222a:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    222e:	fd843783          	ld	a5,-40(s0)
    2232:	cf85                	beqz	a5,226a <MAXVAplus+0x50>
    2234:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    2236:	54fd                	li	s1,-1
    pid = fork();
    2238:	00004097          	auipc	ra,0x4
    223c:	980080e7          	jalr	-1664(ra) # 5bb8 <fork>
    if(pid < 0){
    2240:	02054b63          	bltz	a0,2276 <MAXVAplus+0x5c>
    if(pid == 0){
    2244:	c539                	beqz	a0,2292 <MAXVAplus+0x78>
    wait(&xstatus);
    2246:	fd440513          	addi	a0,s0,-44
    224a:	00004097          	auipc	ra,0x4
    224e:	97e080e7          	jalr	-1666(ra) # 5bc8 <wait>
    if(xstatus != -1)  // did kernel kill child?
    2252:	fd442783          	lw	a5,-44(s0)
    2256:	06979463          	bne	a5,s1,22be <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    225a:	fd843783          	ld	a5,-40(s0)
    225e:	0786                	slli	a5,a5,0x1
    2260:	fcf43c23          	sd	a5,-40(s0)
    2264:	fd843783          	ld	a5,-40(s0)
    2268:	fbe1                	bnez	a5,2238 <MAXVAplus+0x1e>
}
    226a:	70a2                	ld	ra,40(sp)
    226c:	7402                	ld	s0,32(sp)
    226e:	64e2                	ld	s1,24(sp)
    2270:	6942                	ld	s2,16(sp)
    2272:	6145                	addi	sp,sp,48
    2274:	8082                	ret
      printf("%s: fork failed\n", s);
    2276:	85ca                	mv	a1,s2
    2278:	00004517          	auipc	a0,0x4
    227c:	72850513          	addi	a0,a0,1832 # 69a0 <malloc+0x9ae>
    2280:	00004097          	auipc	ra,0x4
    2284:	cba080e7          	jalr	-838(ra) # 5f3a <printf>
      exit(1);
    2288:	4505                	li	a0,1
    228a:	00004097          	auipc	ra,0x4
    228e:	936080e7          	jalr	-1738(ra) # 5bc0 <exit>
      *(char*)a = 99;
    2292:	fd843783          	ld	a5,-40(s0)
    2296:	06300713          	li	a4,99
    229a:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    229e:	fd843603          	ld	a2,-40(s0)
    22a2:	85ca                	mv	a1,s2
    22a4:	00005517          	auipc	a0,0x5
    22a8:	9ec50513          	addi	a0,a0,-1556 # 6c90 <malloc+0xc9e>
    22ac:	00004097          	auipc	ra,0x4
    22b0:	c8e080e7          	jalr	-882(ra) # 5f3a <printf>
      exit(1);
    22b4:	4505                	li	a0,1
    22b6:	00004097          	auipc	ra,0x4
    22ba:	90a080e7          	jalr	-1782(ra) # 5bc0 <exit>
      exit(1);
    22be:	4505                	li	a0,1
    22c0:	00004097          	auipc	ra,0x4
    22c4:	900080e7          	jalr	-1792(ra) # 5bc0 <exit>

00000000000022c8 <bigargtest>:
{
    22c8:	7179                	addi	sp,sp,-48
    22ca:	f406                	sd	ra,40(sp)
    22cc:	f022                	sd	s0,32(sp)
    22ce:	ec26                	sd	s1,24(sp)
    22d0:	1800                	addi	s0,sp,48
    22d2:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    22d4:	00005517          	auipc	a0,0x5
    22d8:	9d450513          	addi	a0,a0,-1580 # 6ca8 <malloc+0xcb6>
    22dc:	00004097          	auipc	ra,0x4
    22e0:	934080e7          	jalr	-1740(ra) # 5c10 <unlink>
  pid = fork();
    22e4:	00004097          	auipc	ra,0x4
    22e8:	8d4080e7          	jalr	-1836(ra) # 5bb8 <fork>
  if(pid == 0){
    22ec:	c121                	beqz	a0,232c <bigargtest+0x64>
  } else if(pid < 0){
    22ee:	0a054063          	bltz	a0,238e <bigargtest+0xc6>
  wait(&xstatus);
    22f2:	fdc40513          	addi	a0,s0,-36
    22f6:	00004097          	auipc	ra,0x4
    22fa:	8d2080e7          	jalr	-1838(ra) # 5bc8 <wait>
  if(xstatus != 0)
    22fe:	fdc42503          	lw	a0,-36(s0)
    2302:	e545                	bnez	a0,23aa <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    2304:	4581                	li	a1,0
    2306:	00005517          	auipc	a0,0x5
    230a:	9a250513          	addi	a0,a0,-1630 # 6ca8 <malloc+0xcb6>
    230e:	00004097          	auipc	ra,0x4
    2312:	8f2080e7          	jalr	-1806(ra) # 5c00 <open>
  if(fd < 0){
    2316:	08054e63          	bltz	a0,23b2 <bigargtest+0xea>
  close(fd);
    231a:	00004097          	auipc	ra,0x4
    231e:	8ce080e7          	jalr	-1842(ra) # 5be8 <close>
}
    2322:	70a2                	ld	ra,40(sp)
    2324:	7402                	ld	s0,32(sp)
    2326:	64e2                	ld	s1,24(sp)
    2328:	6145                	addi	sp,sp,48
    232a:	8082                	ret
    232c:	00007797          	auipc	a5,0x7
    2330:	13478793          	addi	a5,a5,308 # 9460 <args.1>
    2334:	00007697          	auipc	a3,0x7
    2338:	22468693          	addi	a3,a3,548 # 9558 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    233c:	00005717          	auipc	a4,0x5
    2340:	97c70713          	addi	a4,a4,-1668 # 6cb8 <malloc+0xcc6>
    2344:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    2346:	07a1                	addi	a5,a5,8
    2348:	fed79ee3          	bne	a5,a3,2344 <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    234c:	00007597          	auipc	a1,0x7
    2350:	11458593          	addi	a1,a1,276 # 9460 <args.1>
    2354:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    2358:	00004517          	auipc	a0,0x4
    235c:	dc050513          	addi	a0,a0,-576 # 6118 <malloc+0x126>
    2360:	00004097          	auipc	ra,0x4
    2364:	898080e7          	jalr	-1896(ra) # 5bf8 <exec>
    fd = open("bigarg-ok", O_CREATE);
    2368:	20000593          	li	a1,512
    236c:	00005517          	auipc	a0,0x5
    2370:	93c50513          	addi	a0,a0,-1732 # 6ca8 <malloc+0xcb6>
    2374:	00004097          	auipc	ra,0x4
    2378:	88c080e7          	jalr	-1908(ra) # 5c00 <open>
    close(fd);
    237c:	00004097          	auipc	ra,0x4
    2380:	86c080e7          	jalr	-1940(ra) # 5be8 <close>
    exit(0);
    2384:	4501                	li	a0,0
    2386:	00004097          	auipc	ra,0x4
    238a:	83a080e7          	jalr	-1990(ra) # 5bc0 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    238e:	85a6                	mv	a1,s1
    2390:	00005517          	auipc	a0,0x5
    2394:	a0850513          	addi	a0,a0,-1528 # 6d98 <malloc+0xda6>
    2398:	00004097          	auipc	ra,0x4
    239c:	ba2080e7          	jalr	-1118(ra) # 5f3a <printf>
    exit(1);
    23a0:	4505                	li	a0,1
    23a2:	00004097          	auipc	ra,0x4
    23a6:	81e080e7          	jalr	-2018(ra) # 5bc0 <exit>
    exit(xstatus);
    23aa:	00004097          	auipc	ra,0x4
    23ae:	816080e7          	jalr	-2026(ra) # 5bc0 <exit>
    printf("%s: bigarg test failed!\n", s);
    23b2:	85a6                	mv	a1,s1
    23b4:	00005517          	auipc	a0,0x5
    23b8:	a0450513          	addi	a0,a0,-1532 # 6db8 <malloc+0xdc6>
    23bc:	00004097          	auipc	ra,0x4
    23c0:	b7e080e7          	jalr	-1154(ra) # 5f3a <printf>
    exit(1);
    23c4:	4505                	li	a0,1
    23c6:	00003097          	auipc	ra,0x3
    23ca:	7fa080e7          	jalr	2042(ra) # 5bc0 <exit>

00000000000023ce <stacktest>:
{
    23ce:	7179                	addi	sp,sp,-48
    23d0:	f406                	sd	ra,40(sp)
    23d2:	f022                	sd	s0,32(sp)
    23d4:	ec26                	sd	s1,24(sp)
    23d6:	1800                	addi	s0,sp,48
    23d8:	84aa                	mv	s1,a0
  pid = fork();
    23da:	00003097          	auipc	ra,0x3
    23de:	7de080e7          	jalr	2014(ra) # 5bb8 <fork>
  if(pid == 0) {
    23e2:	c115                	beqz	a0,2406 <stacktest+0x38>
  } else if(pid < 0){
    23e4:	04054463          	bltz	a0,242c <stacktest+0x5e>
  wait(&xstatus);
    23e8:	fdc40513          	addi	a0,s0,-36
    23ec:	00003097          	auipc	ra,0x3
    23f0:	7dc080e7          	jalr	2012(ra) # 5bc8 <wait>
  if(xstatus == -1)  // kernel killed child?
    23f4:	fdc42503          	lw	a0,-36(s0)
    23f8:	57fd                	li	a5,-1
    23fa:	04f50763          	beq	a0,a5,2448 <stacktest+0x7a>
    exit(xstatus);
    23fe:	00003097          	auipc	ra,0x3
    2402:	7c2080e7          	jalr	1986(ra) # 5bc0 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    2406:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2408:	77fd                	lui	a5,0xfffff
    240a:	97ba                	add	a5,a5,a4
    240c:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    2410:	85a6                	mv	a1,s1
    2412:	00005517          	auipc	a0,0x5
    2416:	9c650513          	addi	a0,a0,-1594 # 6dd8 <malloc+0xde6>
    241a:	00004097          	auipc	ra,0x4
    241e:	b20080e7          	jalr	-1248(ra) # 5f3a <printf>
    exit(1);
    2422:	4505                	li	a0,1
    2424:	00003097          	auipc	ra,0x3
    2428:	79c080e7          	jalr	1948(ra) # 5bc0 <exit>
    printf("%s: fork failed\n", s);
    242c:	85a6                	mv	a1,s1
    242e:	00004517          	auipc	a0,0x4
    2432:	57250513          	addi	a0,a0,1394 # 69a0 <malloc+0x9ae>
    2436:	00004097          	auipc	ra,0x4
    243a:	b04080e7          	jalr	-1276(ra) # 5f3a <printf>
    exit(1);
    243e:	4505                	li	a0,1
    2440:	00003097          	auipc	ra,0x3
    2444:	780080e7          	jalr	1920(ra) # 5bc0 <exit>
    exit(0);
    2448:	4501                	li	a0,0
    244a:	00003097          	auipc	ra,0x3
    244e:	776080e7          	jalr	1910(ra) # 5bc0 <exit>

0000000000002452 <textwrite>:
{
    2452:	7179                	addi	sp,sp,-48
    2454:	f406                	sd	ra,40(sp)
    2456:	f022                	sd	s0,32(sp)
    2458:	ec26                	sd	s1,24(sp)
    245a:	1800                	addi	s0,sp,48
    245c:	84aa                	mv	s1,a0
  pid = fork();
    245e:	00003097          	auipc	ra,0x3
    2462:	75a080e7          	jalr	1882(ra) # 5bb8 <fork>
  if(pid == 0) {
    2466:	c115                	beqz	a0,248a <textwrite+0x38>
  } else if(pid < 0){
    2468:	02054963          	bltz	a0,249a <textwrite+0x48>
  wait(&xstatus);
    246c:	fdc40513          	addi	a0,s0,-36
    2470:	00003097          	auipc	ra,0x3
    2474:	758080e7          	jalr	1880(ra) # 5bc8 <wait>
  if(xstatus == -1)  // kernel killed child?
    2478:	fdc42503          	lw	a0,-36(s0)
    247c:	57fd                	li	a5,-1
    247e:	02f50c63          	beq	a0,a5,24b6 <textwrite+0x64>
    exit(xstatus);
    2482:	00003097          	auipc	ra,0x3
    2486:	73e080e7          	jalr	1854(ra) # 5bc0 <exit>
    *addr = 10;
    248a:	47a9                	li	a5,10
    248c:	00f02023          	sw	a5,0(zero) # 0 <copyinstr1>
    exit(1);
    2490:	4505                	li	a0,1
    2492:	00003097          	auipc	ra,0x3
    2496:	72e080e7          	jalr	1838(ra) # 5bc0 <exit>
    printf("%s: fork failed\n", s);
    249a:	85a6                	mv	a1,s1
    249c:	00004517          	auipc	a0,0x4
    24a0:	50450513          	addi	a0,a0,1284 # 69a0 <malloc+0x9ae>
    24a4:	00004097          	auipc	ra,0x4
    24a8:	a96080e7          	jalr	-1386(ra) # 5f3a <printf>
    exit(1);
    24ac:	4505                	li	a0,1
    24ae:	00003097          	auipc	ra,0x3
    24b2:	712080e7          	jalr	1810(ra) # 5bc0 <exit>
    exit(0);
    24b6:	4501                	li	a0,0
    24b8:	00003097          	auipc	ra,0x3
    24bc:	708080e7          	jalr	1800(ra) # 5bc0 <exit>

00000000000024c0 <manywrites>:
{
    24c0:	711d                	addi	sp,sp,-96
    24c2:	ec86                	sd	ra,88(sp)
    24c4:	e8a2                	sd	s0,80(sp)
    24c6:	e4a6                	sd	s1,72(sp)
    24c8:	e0ca                	sd	s2,64(sp)
    24ca:	fc4e                	sd	s3,56(sp)
    24cc:	f852                	sd	s4,48(sp)
    24ce:	f456                	sd	s5,40(sp)
    24d0:	f05a                	sd	s6,32(sp)
    24d2:	ec5e                	sd	s7,24(sp)
    24d4:	1080                	addi	s0,sp,96
    24d6:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    24d8:	4981                	li	s3,0
    24da:	4911                	li	s2,4
    int pid = fork();
    24dc:	00003097          	auipc	ra,0x3
    24e0:	6dc080e7          	jalr	1756(ra) # 5bb8 <fork>
    24e4:	84aa                	mv	s1,a0
    if(pid < 0){
    24e6:	02054963          	bltz	a0,2518 <manywrites+0x58>
    if(pid == 0){
    24ea:	c521                	beqz	a0,2532 <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    24ec:	2985                	addiw	s3,s3,1
    24ee:	ff2997e3          	bne	s3,s2,24dc <manywrites+0x1c>
    24f2:	4491                	li	s1,4
    int st = 0;
    24f4:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    24f8:	fa840513          	addi	a0,s0,-88
    24fc:	00003097          	auipc	ra,0x3
    2500:	6cc080e7          	jalr	1740(ra) # 5bc8 <wait>
    if(st != 0)
    2504:	fa842503          	lw	a0,-88(s0)
    2508:	ed6d                	bnez	a0,2602 <manywrites+0x142>
  for(int ci = 0; ci < nchildren; ci++){
    250a:	34fd                	addiw	s1,s1,-1
    250c:	f4e5                	bnez	s1,24f4 <manywrites+0x34>
  exit(0);
    250e:	4501                	li	a0,0
    2510:	00003097          	auipc	ra,0x3
    2514:	6b0080e7          	jalr	1712(ra) # 5bc0 <exit>
      printf("fork failed\n");
    2518:	00005517          	auipc	a0,0x5
    251c:	89050513          	addi	a0,a0,-1904 # 6da8 <malloc+0xdb6>
    2520:	00004097          	auipc	ra,0x4
    2524:	a1a080e7          	jalr	-1510(ra) # 5f3a <printf>
      exit(1);
    2528:	4505                	li	a0,1
    252a:	00003097          	auipc	ra,0x3
    252e:	696080e7          	jalr	1686(ra) # 5bc0 <exit>
      name[0] = 'b';
    2532:	06200793          	li	a5,98
    2536:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    253a:	0619879b          	addiw	a5,s3,97
    253e:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    2542:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    2546:	fa840513          	addi	a0,s0,-88
    254a:	00003097          	auipc	ra,0x3
    254e:	6c6080e7          	jalr	1734(ra) # 5c10 <unlink>
    2552:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    2554:	0000ab17          	auipc	s6,0xa
    2558:	724b0b13          	addi	s6,s6,1828 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    255c:	8a26                	mv	s4,s1
    255e:	0209ce63          	bltz	s3,259a <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    2562:	20200593          	li	a1,514
    2566:	fa840513          	addi	a0,s0,-88
    256a:	00003097          	auipc	ra,0x3
    256e:	696080e7          	jalr	1686(ra) # 5c00 <open>
    2572:	892a                	mv	s2,a0
          if(fd < 0){
    2574:	04054763          	bltz	a0,25c2 <manywrites+0x102>
          int cc = write(fd, buf, sz);
    2578:	660d                	lui	a2,0x3
    257a:	85da                	mv	a1,s6
    257c:	00003097          	auipc	ra,0x3
    2580:	664080e7          	jalr	1636(ra) # 5be0 <write>
          if(cc != sz){
    2584:	678d                	lui	a5,0x3
    2586:	04f51e63          	bne	a0,a5,25e2 <manywrites+0x122>
          close(fd);
    258a:	854a                	mv	a0,s2
    258c:	00003097          	auipc	ra,0x3
    2590:	65c080e7          	jalr	1628(ra) # 5be8 <close>
        for(int i = 0; i < ci+1; i++){
    2594:	2a05                	addiw	s4,s4,1
    2596:	fd49d6e3          	bge	s3,s4,2562 <manywrites+0xa2>
        unlink(name);
    259a:	fa840513          	addi	a0,s0,-88
    259e:	00003097          	auipc	ra,0x3
    25a2:	672080e7          	jalr	1650(ra) # 5c10 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    25a6:	3bfd                	addiw	s7,s7,-1
    25a8:	fa0b9ae3          	bnez	s7,255c <manywrites+0x9c>
      unlink(name);
    25ac:	fa840513          	addi	a0,s0,-88
    25b0:	00003097          	auipc	ra,0x3
    25b4:	660080e7          	jalr	1632(ra) # 5c10 <unlink>
      exit(0);
    25b8:	4501                	li	a0,0
    25ba:	00003097          	auipc	ra,0x3
    25be:	606080e7          	jalr	1542(ra) # 5bc0 <exit>
            printf("%s: cannot create %s\n", s, name);
    25c2:	fa840613          	addi	a2,s0,-88
    25c6:	85d6                	mv	a1,s5
    25c8:	00005517          	auipc	a0,0x5
    25cc:	83850513          	addi	a0,a0,-1992 # 6e00 <malloc+0xe0e>
    25d0:	00004097          	auipc	ra,0x4
    25d4:	96a080e7          	jalr	-1686(ra) # 5f3a <printf>
            exit(1);
    25d8:	4505                	li	a0,1
    25da:	00003097          	auipc	ra,0x3
    25de:	5e6080e7          	jalr	1510(ra) # 5bc0 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    25e2:	86aa                	mv	a3,a0
    25e4:	660d                	lui	a2,0x3
    25e6:	85d6                	mv	a1,s5
    25e8:	00004517          	auipc	a0,0x4
    25ec:	c0050513          	addi	a0,a0,-1024 # 61e8 <malloc+0x1f6>
    25f0:	00004097          	auipc	ra,0x4
    25f4:	94a080e7          	jalr	-1718(ra) # 5f3a <printf>
            exit(1);
    25f8:	4505                	li	a0,1
    25fa:	00003097          	auipc	ra,0x3
    25fe:	5c6080e7          	jalr	1478(ra) # 5bc0 <exit>
      exit(st);
    2602:	00003097          	auipc	ra,0x3
    2606:	5be080e7          	jalr	1470(ra) # 5bc0 <exit>

000000000000260a <copyinstr3>:
{
    260a:	7179                	addi	sp,sp,-48
    260c:	f406                	sd	ra,40(sp)
    260e:	f022                	sd	s0,32(sp)
    2610:	ec26                	sd	s1,24(sp)
    2612:	1800                	addi	s0,sp,48
  sbrk(8192);
    2614:	6509                	lui	a0,0x2
    2616:	00003097          	auipc	ra,0x3
    261a:	632080e7          	jalr	1586(ra) # 5c48 <sbrk>
  uint64 top = (uint64) sbrk(0);
    261e:	4501                	li	a0,0
    2620:	00003097          	auipc	ra,0x3
    2624:	628080e7          	jalr	1576(ra) # 5c48 <sbrk>
  if((top % PGSIZE) != 0){
    2628:	03451793          	slli	a5,a0,0x34
    262c:	e3c9                	bnez	a5,26ae <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    262e:	4501                	li	a0,0
    2630:	00003097          	auipc	ra,0x3
    2634:	618080e7          	jalr	1560(ra) # 5c48 <sbrk>
  if(top % PGSIZE){
    2638:	03451793          	slli	a5,a0,0x34
    263c:	e3d9                	bnez	a5,26c2 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    263e:	fff50493          	addi	s1,a0,-1 # 1fff <linkunlink+0x73>
  *b = 'x';
    2642:	07800793          	li	a5,120
    2646:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    264a:	8526                	mv	a0,s1
    264c:	00003097          	auipc	ra,0x3
    2650:	5c4080e7          	jalr	1476(ra) # 5c10 <unlink>
  if(ret != -1){
    2654:	57fd                	li	a5,-1
    2656:	08f51363          	bne	a0,a5,26dc <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    265a:	20100593          	li	a1,513
    265e:	8526                	mv	a0,s1
    2660:	00003097          	auipc	ra,0x3
    2664:	5a0080e7          	jalr	1440(ra) # 5c00 <open>
  if(fd != -1){
    2668:	57fd                	li	a5,-1
    266a:	08f51863          	bne	a0,a5,26fa <copyinstr3+0xf0>
  ret = link(b, b);
    266e:	85a6                	mv	a1,s1
    2670:	8526                	mv	a0,s1
    2672:	00003097          	auipc	ra,0x3
    2676:	5ae080e7          	jalr	1454(ra) # 5c20 <link>
  if(ret != -1){
    267a:	57fd                	li	a5,-1
    267c:	08f51e63          	bne	a0,a5,2718 <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    2680:	00005797          	auipc	a5,0x5
    2684:	47878793          	addi	a5,a5,1144 # 7af8 <malloc+0x1b06>
    2688:	fcf43823          	sd	a5,-48(s0)
    268c:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2690:	fd040593          	addi	a1,s0,-48
    2694:	8526                	mv	a0,s1
    2696:	00003097          	auipc	ra,0x3
    269a:	562080e7          	jalr	1378(ra) # 5bf8 <exec>
  if(ret != -1){
    269e:	57fd                	li	a5,-1
    26a0:	08f51c63          	bne	a0,a5,2738 <copyinstr3+0x12e>
}
    26a4:	70a2                	ld	ra,40(sp)
    26a6:	7402                	ld	s0,32(sp)
    26a8:	64e2                	ld	s1,24(sp)
    26aa:	6145                	addi	sp,sp,48
    26ac:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    26ae:	0347d513          	srli	a0,a5,0x34
    26b2:	6785                	lui	a5,0x1
    26b4:	40a7853b          	subw	a0,a5,a0
    26b8:	00003097          	auipc	ra,0x3
    26bc:	590080e7          	jalr	1424(ra) # 5c48 <sbrk>
    26c0:	b7bd                	j	262e <copyinstr3+0x24>
    printf("oops\n");
    26c2:	00004517          	auipc	a0,0x4
    26c6:	75650513          	addi	a0,a0,1878 # 6e18 <malloc+0xe26>
    26ca:	00004097          	auipc	ra,0x4
    26ce:	870080e7          	jalr	-1936(ra) # 5f3a <printf>
    exit(1);
    26d2:	4505                	li	a0,1
    26d4:	00003097          	auipc	ra,0x3
    26d8:	4ec080e7          	jalr	1260(ra) # 5bc0 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    26dc:	862a                	mv	a2,a0
    26de:	85a6                	mv	a1,s1
    26e0:	00004517          	auipc	a0,0x4
    26e4:	1e050513          	addi	a0,a0,480 # 68c0 <malloc+0x8ce>
    26e8:	00004097          	auipc	ra,0x4
    26ec:	852080e7          	jalr	-1966(ra) # 5f3a <printf>
    exit(1);
    26f0:	4505                	li	a0,1
    26f2:	00003097          	auipc	ra,0x3
    26f6:	4ce080e7          	jalr	1230(ra) # 5bc0 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    26fa:	862a                	mv	a2,a0
    26fc:	85a6                	mv	a1,s1
    26fe:	00004517          	auipc	a0,0x4
    2702:	1e250513          	addi	a0,a0,482 # 68e0 <malloc+0x8ee>
    2706:	00004097          	auipc	ra,0x4
    270a:	834080e7          	jalr	-1996(ra) # 5f3a <printf>
    exit(1);
    270e:	4505                	li	a0,1
    2710:	00003097          	auipc	ra,0x3
    2714:	4b0080e7          	jalr	1200(ra) # 5bc0 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    2718:	86aa                	mv	a3,a0
    271a:	8626                	mv	a2,s1
    271c:	85a6                	mv	a1,s1
    271e:	00004517          	auipc	a0,0x4
    2722:	1e250513          	addi	a0,a0,482 # 6900 <malloc+0x90e>
    2726:	00004097          	auipc	ra,0x4
    272a:	814080e7          	jalr	-2028(ra) # 5f3a <printf>
    exit(1);
    272e:	4505                	li	a0,1
    2730:	00003097          	auipc	ra,0x3
    2734:	490080e7          	jalr	1168(ra) # 5bc0 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    2738:	567d                	li	a2,-1
    273a:	85a6                	mv	a1,s1
    273c:	00004517          	auipc	a0,0x4
    2740:	1ec50513          	addi	a0,a0,492 # 6928 <malloc+0x936>
    2744:	00003097          	auipc	ra,0x3
    2748:	7f6080e7          	jalr	2038(ra) # 5f3a <printf>
    exit(1);
    274c:	4505                	li	a0,1
    274e:	00003097          	auipc	ra,0x3
    2752:	472080e7          	jalr	1138(ra) # 5bc0 <exit>

0000000000002756 <rwsbrk>:
{
    2756:	1101                	addi	sp,sp,-32
    2758:	ec06                	sd	ra,24(sp)
    275a:	e822                	sd	s0,16(sp)
    275c:	e426                	sd	s1,8(sp)
    275e:	e04a                	sd	s2,0(sp)
    2760:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    2762:	6509                	lui	a0,0x2
    2764:	00003097          	auipc	ra,0x3
    2768:	4e4080e7          	jalr	1252(ra) # 5c48 <sbrk>
  if(a == 0xffffffffffffffffLL) {
    276c:	57fd                	li	a5,-1
    276e:	06f50263          	beq	a0,a5,27d2 <rwsbrk+0x7c>
    2772:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    2774:	7579                	lui	a0,0xffffe
    2776:	00003097          	auipc	ra,0x3
    277a:	4d2080e7          	jalr	1234(ra) # 5c48 <sbrk>
    277e:	57fd                	li	a5,-1
    2780:	06f50663          	beq	a0,a5,27ec <rwsbrk+0x96>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    2784:	20100593          	li	a1,513
    2788:	00004517          	auipc	a0,0x4
    278c:	6d050513          	addi	a0,a0,1744 # 6e58 <malloc+0xe66>
    2790:	00003097          	auipc	ra,0x3
    2794:	470080e7          	jalr	1136(ra) # 5c00 <open>
    2798:	892a                	mv	s2,a0
  if(fd < 0){
    279a:	06054663          	bltz	a0,2806 <rwsbrk+0xb0>
  n = write(fd, (void*)(a+4096), 1024);
    279e:	6785                	lui	a5,0x1
    27a0:	94be                	add	s1,s1,a5
    27a2:	40000613          	li	a2,1024
    27a6:	85a6                	mv	a1,s1
    27a8:	00003097          	auipc	ra,0x3
    27ac:	438080e7          	jalr	1080(ra) # 5be0 <write>
    27b0:	862a                	mv	a2,a0
  if(n >= 0){
    27b2:	06054763          	bltz	a0,2820 <rwsbrk+0xca>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    27b6:	85a6                	mv	a1,s1
    27b8:	00004517          	auipc	a0,0x4
    27bc:	6c050513          	addi	a0,a0,1728 # 6e78 <malloc+0xe86>
    27c0:	00003097          	auipc	ra,0x3
    27c4:	77a080e7          	jalr	1914(ra) # 5f3a <printf>
    exit(1);
    27c8:	4505                	li	a0,1
    27ca:	00003097          	auipc	ra,0x3
    27ce:	3f6080e7          	jalr	1014(ra) # 5bc0 <exit>
    printf("sbrk(rwsbrk) failed\n");
    27d2:	00004517          	auipc	a0,0x4
    27d6:	64e50513          	addi	a0,a0,1614 # 6e20 <malloc+0xe2e>
    27da:	00003097          	auipc	ra,0x3
    27de:	760080e7          	jalr	1888(ra) # 5f3a <printf>
    exit(1);
    27e2:	4505                	li	a0,1
    27e4:	00003097          	auipc	ra,0x3
    27e8:	3dc080e7          	jalr	988(ra) # 5bc0 <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    27ec:	00004517          	auipc	a0,0x4
    27f0:	64c50513          	addi	a0,a0,1612 # 6e38 <malloc+0xe46>
    27f4:	00003097          	auipc	ra,0x3
    27f8:	746080e7          	jalr	1862(ra) # 5f3a <printf>
    exit(1);
    27fc:	4505                	li	a0,1
    27fe:	00003097          	auipc	ra,0x3
    2802:	3c2080e7          	jalr	962(ra) # 5bc0 <exit>
    printf("open(rwsbrk) failed\n");
    2806:	00004517          	auipc	a0,0x4
    280a:	65a50513          	addi	a0,a0,1626 # 6e60 <malloc+0xe6e>
    280e:	00003097          	auipc	ra,0x3
    2812:	72c080e7          	jalr	1836(ra) # 5f3a <printf>
    exit(1);
    2816:	4505                	li	a0,1
    2818:	00003097          	auipc	ra,0x3
    281c:	3a8080e7          	jalr	936(ra) # 5bc0 <exit>
  close(fd);
    2820:	854a                	mv	a0,s2
    2822:	00003097          	auipc	ra,0x3
    2826:	3c6080e7          	jalr	966(ra) # 5be8 <close>
  unlink("rwsbrk");
    282a:	00004517          	auipc	a0,0x4
    282e:	62e50513          	addi	a0,a0,1582 # 6e58 <malloc+0xe66>
    2832:	00003097          	auipc	ra,0x3
    2836:	3de080e7          	jalr	990(ra) # 5c10 <unlink>
  fd = open("README", O_RDONLY);
    283a:	4581                	li	a1,0
    283c:	00004517          	auipc	a0,0x4
    2840:	ab450513          	addi	a0,a0,-1356 # 62f0 <malloc+0x2fe>
    2844:	00003097          	auipc	ra,0x3
    2848:	3bc080e7          	jalr	956(ra) # 5c00 <open>
    284c:	892a                	mv	s2,a0
  if(fd < 0){
    284e:	02054963          	bltz	a0,2880 <rwsbrk+0x12a>
  n = read(fd, (void*)(a+4096), 10);
    2852:	4629                	li	a2,10
    2854:	85a6                	mv	a1,s1
    2856:	00003097          	auipc	ra,0x3
    285a:	382080e7          	jalr	898(ra) # 5bd8 <read>
    285e:	862a                	mv	a2,a0
  if(n >= 0){
    2860:	02054d63          	bltz	a0,289a <rwsbrk+0x144>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    2864:	85a6                	mv	a1,s1
    2866:	00004517          	auipc	a0,0x4
    286a:	64250513          	addi	a0,a0,1602 # 6ea8 <malloc+0xeb6>
    286e:	00003097          	auipc	ra,0x3
    2872:	6cc080e7          	jalr	1740(ra) # 5f3a <printf>
    exit(1);
    2876:	4505                	li	a0,1
    2878:	00003097          	auipc	ra,0x3
    287c:	348080e7          	jalr	840(ra) # 5bc0 <exit>
    printf("open(rwsbrk) failed\n");
    2880:	00004517          	auipc	a0,0x4
    2884:	5e050513          	addi	a0,a0,1504 # 6e60 <malloc+0xe6e>
    2888:	00003097          	auipc	ra,0x3
    288c:	6b2080e7          	jalr	1714(ra) # 5f3a <printf>
    exit(1);
    2890:	4505                	li	a0,1
    2892:	00003097          	auipc	ra,0x3
    2896:	32e080e7          	jalr	814(ra) # 5bc0 <exit>
  close(fd);
    289a:	854a                	mv	a0,s2
    289c:	00003097          	auipc	ra,0x3
    28a0:	34c080e7          	jalr	844(ra) # 5be8 <close>
  exit(0);
    28a4:	4501                	li	a0,0
    28a6:	00003097          	auipc	ra,0x3
    28aa:	31a080e7          	jalr	794(ra) # 5bc0 <exit>

00000000000028ae <sbrkbasic>:
{
    28ae:	7139                	addi	sp,sp,-64
    28b0:	fc06                	sd	ra,56(sp)
    28b2:	f822                	sd	s0,48(sp)
    28b4:	f426                	sd	s1,40(sp)
    28b6:	f04a                	sd	s2,32(sp)
    28b8:	ec4e                	sd	s3,24(sp)
    28ba:	e852                	sd	s4,16(sp)
    28bc:	0080                	addi	s0,sp,64
    28be:	8a2a                	mv	s4,a0
  pid = fork();
    28c0:	00003097          	auipc	ra,0x3
    28c4:	2f8080e7          	jalr	760(ra) # 5bb8 <fork>
  if(pid < 0){
    28c8:	02054c63          	bltz	a0,2900 <sbrkbasic+0x52>
  if(pid == 0){
    28cc:	ed21                	bnez	a0,2924 <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    28ce:	40000537          	lui	a0,0x40000
    28d2:	00003097          	auipc	ra,0x3
    28d6:	376080e7          	jalr	886(ra) # 5c48 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    28da:	57fd                	li	a5,-1
    28dc:	02f50f63          	beq	a0,a5,291a <sbrkbasic+0x6c>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28e0:	400007b7          	lui	a5,0x40000
    28e4:	97aa                	add	a5,a5,a0
      *b = 99;
    28e6:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    28ea:	6705                	lui	a4,0x1
      *b = 99;
    28ec:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28f0:	953a                	add	a0,a0,a4
    28f2:	fef51de3          	bne	a0,a5,28ec <sbrkbasic+0x3e>
    exit(1);
    28f6:	4505                	li	a0,1
    28f8:	00003097          	auipc	ra,0x3
    28fc:	2c8080e7          	jalr	712(ra) # 5bc0 <exit>
    printf("fork failed in sbrkbasic\n");
    2900:	00004517          	auipc	a0,0x4
    2904:	5d050513          	addi	a0,a0,1488 # 6ed0 <malloc+0xede>
    2908:	00003097          	auipc	ra,0x3
    290c:	632080e7          	jalr	1586(ra) # 5f3a <printf>
    exit(1);
    2910:	4505                	li	a0,1
    2912:	00003097          	auipc	ra,0x3
    2916:	2ae080e7          	jalr	686(ra) # 5bc0 <exit>
      exit(0);
    291a:	4501                	li	a0,0
    291c:	00003097          	auipc	ra,0x3
    2920:	2a4080e7          	jalr	676(ra) # 5bc0 <exit>
  wait(&xstatus);
    2924:	fcc40513          	addi	a0,s0,-52
    2928:	00003097          	auipc	ra,0x3
    292c:	2a0080e7          	jalr	672(ra) # 5bc8 <wait>
  if(xstatus == 1){
    2930:	fcc42703          	lw	a4,-52(s0)
    2934:	4785                	li	a5,1
    2936:	00f70d63          	beq	a4,a5,2950 <sbrkbasic+0xa2>
  a = sbrk(0);
    293a:	4501                	li	a0,0
    293c:	00003097          	auipc	ra,0x3
    2940:	30c080e7          	jalr	780(ra) # 5c48 <sbrk>
    2944:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2946:	4901                	li	s2,0
    2948:	6985                	lui	s3,0x1
    294a:	38898993          	addi	s3,s3,904 # 1388 <badarg+0x3e>
    294e:	a005                	j	296e <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    2950:	85d2                	mv	a1,s4
    2952:	00004517          	auipc	a0,0x4
    2956:	59e50513          	addi	a0,a0,1438 # 6ef0 <malloc+0xefe>
    295a:	00003097          	auipc	ra,0x3
    295e:	5e0080e7          	jalr	1504(ra) # 5f3a <printf>
    exit(1);
    2962:	4505                	li	a0,1
    2964:	00003097          	auipc	ra,0x3
    2968:	25c080e7          	jalr	604(ra) # 5bc0 <exit>
    a = b + 1;
    296c:	84be                	mv	s1,a5
    b = sbrk(1);
    296e:	4505                	li	a0,1
    2970:	00003097          	auipc	ra,0x3
    2974:	2d8080e7          	jalr	728(ra) # 5c48 <sbrk>
    if(b != a){
    2978:	04951c63          	bne	a0,s1,29d0 <sbrkbasic+0x122>
    *b = 1;
    297c:	4785                	li	a5,1
    297e:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    2982:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    2986:	2905                	addiw	s2,s2,1
    2988:	ff3912e3          	bne	s2,s3,296c <sbrkbasic+0xbe>
  pid = fork();
    298c:	00003097          	auipc	ra,0x3
    2990:	22c080e7          	jalr	556(ra) # 5bb8 <fork>
    2994:	892a                	mv	s2,a0
  if(pid < 0){
    2996:	04054e63          	bltz	a0,29f2 <sbrkbasic+0x144>
  c = sbrk(1);
    299a:	4505                	li	a0,1
    299c:	00003097          	auipc	ra,0x3
    29a0:	2ac080e7          	jalr	684(ra) # 5c48 <sbrk>
  c = sbrk(1);
    29a4:	4505                	li	a0,1
    29a6:	00003097          	auipc	ra,0x3
    29aa:	2a2080e7          	jalr	674(ra) # 5c48 <sbrk>
  if(c != a + 1){
    29ae:	0489                	addi	s1,s1,2
    29b0:	04a48f63          	beq	s1,a0,2a0e <sbrkbasic+0x160>
    printf("%s: sbrk test failed post-fork\n", s);
    29b4:	85d2                	mv	a1,s4
    29b6:	00004517          	auipc	a0,0x4
    29ba:	59a50513          	addi	a0,a0,1434 # 6f50 <malloc+0xf5e>
    29be:	00003097          	auipc	ra,0x3
    29c2:	57c080e7          	jalr	1404(ra) # 5f3a <printf>
    exit(1);
    29c6:	4505                	li	a0,1
    29c8:	00003097          	auipc	ra,0x3
    29cc:	1f8080e7          	jalr	504(ra) # 5bc0 <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    29d0:	872a                	mv	a4,a0
    29d2:	86a6                	mv	a3,s1
    29d4:	864a                	mv	a2,s2
    29d6:	85d2                	mv	a1,s4
    29d8:	00004517          	auipc	a0,0x4
    29dc:	53850513          	addi	a0,a0,1336 # 6f10 <malloc+0xf1e>
    29e0:	00003097          	auipc	ra,0x3
    29e4:	55a080e7          	jalr	1370(ra) # 5f3a <printf>
      exit(1);
    29e8:	4505                	li	a0,1
    29ea:	00003097          	auipc	ra,0x3
    29ee:	1d6080e7          	jalr	470(ra) # 5bc0 <exit>
    printf("%s: sbrk test fork failed\n", s);
    29f2:	85d2                	mv	a1,s4
    29f4:	00004517          	auipc	a0,0x4
    29f8:	53c50513          	addi	a0,a0,1340 # 6f30 <malloc+0xf3e>
    29fc:	00003097          	auipc	ra,0x3
    2a00:	53e080e7          	jalr	1342(ra) # 5f3a <printf>
    exit(1);
    2a04:	4505                	li	a0,1
    2a06:	00003097          	auipc	ra,0x3
    2a0a:	1ba080e7          	jalr	442(ra) # 5bc0 <exit>
  if(pid == 0)
    2a0e:	00091763          	bnez	s2,2a1c <sbrkbasic+0x16e>
    exit(0);
    2a12:	4501                	li	a0,0
    2a14:	00003097          	auipc	ra,0x3
    2a18:	1ac080e7          	jalr	428(ra) # 5bc0 <exit>
  wait(&xstatus);
    2a1c:	fcc40513          	addi	a0,s0,-52
    2a20:	00003097          	auipc	ra,0x3
    2a24:	1a8080e7          	jalr	424(ra) # 5bc8 <wait>
  exit(xstatus);
    2a28:	fcc42503          	lw	a0,-52(s0)
    2a2c:	00003097          	auipc	ra,0x3
    2a30:	194080e7          	jalr	404(ra) # 5bc0 <exit>

0000000000002a34 <sbrkmuch>:
{
    2a34:	7179                	addi	sp,sp,-48
    2a36:	f406                	sd	ra,40(sp)
    2a38:	f022                	sd	s0,32(sp)
    2a3a:	ec26                	sd	s1,24(sp)
    2a3c:	e84a                	sd	s2,16(sp)
    2a3e:	e44e                	sd	s3,8(sp)
    2a40:	e052                	sd	s4,0(sp)
    2a42:	1800                	addi	s0,sp,48
    2a44:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2a46:	4501                	li	a0,0
    2a48:	00003097          	auipc	ra,0x3
    2a4c:	200080e7          	jalr	512(ra) # 5c48 <sbrk>
    2a50:	892a                	mv	s2,a0
  a = sbrk(0);
    2a52:	4501                	li	a0,0
    2a54:	00003097          	auipc	ra,0x3
    2a58:	1f4080e7          	jalr	500(ra) # 5c48 <sbrk>
    2a5c:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2a5e:	06400537          	lui	a0,0x6400
    2a62:	9d05                	subw	a0,a0,s1
    2a64:	00003097          	auipc	ra,0x3
    2a68:	1e4080e7          	jalr	484(ra) # 5c48 <sbrk>
  if (p != a) {
    2a6c:	0ca49863          	bne	s1,a0,2b3c <sbrkmuch+0x108>
  char *eee = sbrk(0);
    2a70:	4501                	li	a0,0
    2a72:	00003097          	auipc	ra,0x3
    2a76:	1d6080e7          	jalr	470(ra) # 5c48 <sbrk>
    2a7a:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    2a7c:	00a4f963          	bgeu	s1,a0,2a8e <sbrkmuch+0x5a>
    *pp = 1;
    2a80:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2a82:	6705                	lui	a4,0x1
    *pp = 1;
    2a84:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    2a88:	94ba                	add	s1,s1,a4
    2a8a:	fef4ede3          	bltu	s1,a5,2a84 <sbrkmuch+0x50>
  *lastaddr = 99;
    2a8e:	064007b7          	lui	a5,0x6400
    2a92:	06300713          	li	a4,99
    2a96:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    2a9a:	4501                	li	a0,0
    2a9c:	00003097          	auipc	ra,0x3
    2aa0:	1ac080e7          	jalr	428(ra) # 5c48 <sbrk>
    2aa4:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2aa6:	757d                	lui	a0,0xfffff
    2aa8:	00003097          	auipc	ra,0x3
    2aac:	1a0080e7          	jalr	416(ra) # 5c48 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2ab0:	57fd                	li	a5,-1
    2ab2:	0af50363          	beq	a0,a5,2b58 <sbrkmuch+0x124>
  c = sbrk(0);
    2ab6:	4501                	li	a0,0
    2ab8:	00003097          	auipc	ra,0x3
    2abc:	190080e7          	jalr	400(ra) # 5c48 <sbrk>
  if(c != a - PGSIZE){
    2ac0:	77fd                	lui	a5,0xfffff
    2ac2:	97a6                	add	a5,a5,s1
    2ac4:	0af51863          	bne	a0,a5,2b74 <sbrkmuch+0x140>
  a = sbrk(0);
    2ac8:	4501                	li	a0,0
    2aca:	00003097          	auipc	ra,0x3
    2ace:	17e080e7          	jalr	382(ra) # 5c48 <sbrk>
    2ad2:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2ad4:	6505                	lui	a0,0x1
    2ad6:	00003097          	auipc	ra,0x3
    2ada:	172080e7          	jalr	370(ra) # 5c48 <sbrk>
    2ade:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2ae0:	0aa49a63          	bne	s1,a0,2b94 <sbrkmuch+0x160>
    2ae4:	4501                	li	a0,0
    2ae6:	00003097          	auipc	ra,0x3
    2aea:	162080e7          	jalr	354(ra) # 5c48 <sbrk>
    2aee:	6785                	lui	a5,0x1
    2af0:	97a6                	add	a5,a5,s1
    2af2:	0af51163          	bne	a0,a5,2b94 <sbrkmuch+0x160>
  if(*lastaddr == 99){
    2af6:	064007b7          	lui	a5,0x6400
    2afa:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    2afe:	06300793          	li	a5,99
    2b02:	0af70963          	beq	a4,a5,2bb4 <sbrkmuch+0x180>
  a = sbrk(0);
    2b06:	4501                	li	a0,0
    2b08:	00003097          	auipc	ra,0x3
    2b0c:	140080e7          	jalr	320(ra) # 5c48 <sbrk>
    2b10:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2b12:	4501                	li	a0,0
    2b14:	00003097          	auipc	ra,0x3
    2b18:	134080e7          	jalr	308(ra) # 5c48 <sbrk>
    2b1c:	40a9053b          	subw	a0,s2,a0
    2b20:	00003097          	auipc	ra,0x3
    2b24:	128080e7          	jalr	296(ra) # 5c48 <sbrk>
  if(c != a){
    2b28:	0aa49463          	bne	s1,a0,2bd0 <sbrkmuch+0x19c>
}
    2b2c:	70a2                	ld	ra,40(sp)
    2b2e:	7402                	ld	s0,32(sp)
    2b30:	64e2                	ld	s1,24(sp)
    2b32:	6942                	ld	s2,16(sp)
    2b34:	69a2                	ld	s3,8(sp)
    2b36:	6a02                	ld	s4,0(sp)
    2b38:	6145                	addi	sp,sp,48
    2b3a:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    2b3c:	85ce                	mv	a1,s3
    2b3e:	00004517          	auipc	a0,0x4
    2b42:	43250513          	addi	a0,a0,1074 # 6f70 <malloc+0xf7e>
    2b46:	00003097          	auipc	ra,0x3
    2b4a:	3f4080e7          	jalr	1012(ra) # 5f3a <printf>
    exit(1);
    2b4e:	4505                	li	a0,1
    2b50:	00003097          	auipc	ra,0x3
    2b54:	070080e7          	jalr	112(ra) # 5bc0 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2b58:	85ce                	mv	a1,s3
    2b5a:	00004517          	auipc	a0,0x4
    2b5e:	45e50513          	addi	a0,a0,1118 # 6fb8 <malloc+0xfc6>
    2b62:	00003097          	auipc	ra,0x3
    2b66:	3d8080e7          	jalr	984(ra) # 5f3a <printf>
    exit(1);
    2b6a:	4505                	li	a0,1
    2b6c:	00003097          	auipc	ra,0x3
    2b70:	054080e7          	jalr	84(ra) # 5bc0 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    2b74:	86aa                	mv	a3,a0
    2b76:	8626                	mv	a2,s1
    2b78:	85ce                	mv	a1,s3
    2b7a:	00004517          	auipc	a0,0x4
    2b7e:	45e50513          	addi	a0,a0,1118 # 6fd8 <malloc+0xfe6>
    2b82:	00003097          	auipc	ra,0x3
    2b86:	3b8080e7          	jalr	952(ra) # 5f3a <printf>
    exit(1);
    2b8a:	4505                	li	a0,1
    2b8c:	00003097          	auipc	ra,0x3
    2b90:	034080e7          	jalr	52(ra) # 5bc0 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2b94:	86d2                	mv	a3,s4
    2b96:	8626                	mv	a2,s1
    2b98:	85ce                	mv	a1,s3
    2b9a:	00004517          	auipc	a0,0x4
    2b9e:	47e50513          	addi	a0,a0,1150 # 7018 <malloc+0x1026>
    2ba2:	00003097          	auipc	ra,0x3
    2ba6:	398080e7          	jalr	920(ra) # 5f3a <printf>
    exit(1);
    2baa:	4505                	li	a0,1
    2bac:	00003097          	auipc	ra,0x3
    2bb0:	014080e7          	jalr	20(ra) # 5bc0 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2bb4:	85ce                	mv	a1,s3
    2bb6:	00004517          	auipc	a0,0x4
    2bba:	49250513          	addi	a0,a0,1170 # 7048 <malloc+0x1056>
    2bbe:	00003097          	auipc	ra,0x3
    2bc2:	37c080e7          	jalr	892(ra) # 5f3a <printf>
    exit(1);
    2bc6:	4505                	li	a0,1
    2bc8:	00003097          	auipc	ra,0x3
    2bcc:	ff8080e7          	jalr	-8(ra) # 5bc0 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2bd0:	86aa                	mv	a3,a0
    2bd2:	8626                	mv	a2,s1
    2bd4:	85ce                	mv	a1,s3
    2bd6:	00004517          	auipc	a0,0x4
    2bda:	4aa50513          	addi	a0,a0,1194 # 7080 <malloc+0x108e>
    2bde:	00003097          	auipc	ra,0x3
    2be2:	35c080e7          	jalr	860(ra) # 5f3a <printf>
    exit(1);
    2be6:	4505                	li	a0,1
    2be8:	00003097          	auipc	ra,0x3
    2bec:	fd8080e7          	jalr	-40(ra) # 5bc0 <exit>

0000000000002bf0 <sbrkarg>:
{
    2bf0:	7179                	addi	sp,sp,-48
    2bf2:	f406                	sd	ra,40(sp)
    2bf4:	f022                	sd	s0,32(sp)
    2bf6:	ec26                	sd	s1,24(sp)
    2bf8:	e84a                	sd	s2,16(sp)
    2bfa:	e44e                	sd	s3,8(sp)
    2bfc:	1800                	addi	s0,sp,48
    2bfe:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2c00:	6505                	lui	a0,0x1
    2c02:	00003097          	auipc	ra,0x3
    2c06:	046080e7          	jalr	70(ra) # 5c48 <sbrk>
    2c0a:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2c0c:	20100593          	li	a1,513
    2c10:	00004517          	auipc	a0,0x4
    2c14:	49850513          	addi	a0,a0,1176 # 70a8 <malloc+0x10b6>
    2c18:	00003097          	auipc	ra,0x3
    2c1c:	fe8080e7          	jalr	-24(ra) # 5c00 <open>
    2c20:	84aa                	mv	s1,a0
  unlink("sbrk");
    2c22:	00004517          	auipc	a0,0x4
    2c26:	48650513          	addi	a0,a0,1158 # 70a8 <malloc+0x10b6>
    2c2a:	00003097          	auipc	ra,0x3
    2c2e:	fe6080e7          	jalr	-26(ra) # 5c10 <unlink>
  if(fd < 0)  {
    2c32:	0404c163          	bltz	s1,2c74 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2c36:	6605                	lui	a2,0x1
    2c38:	85ca                	mv	a1,s2
    2c3a:	8526                	mv	a0,s1
    2c3c:	00003097          	auipc	ra,0x3
    2c40:	fa4080e7          	jalr	-92(ra) # 5be0 <write>
    2c44:	04054663          	bltz	a0,2c90 <sbrkarg+0xa0>
  close(fd);
    2c48:	8526                	mv	a0,s1
    2c4a:	00003097          	auipc	ra,0x3
    2c4e:	f9e080e7          	jalr	-98(ra) # 5be8 <close>
  a = sbrk(PGSIZE);
    2c52:	6505                	lui	a0,0x1
    2c54:	00003097          	auipc	ra,0x3
    2c58:	ff4080e7          	jalr	-12(ra) # 5c48 <sbrk>
  if(pipe((int *) a) != 0){
    2c5c:	00003097          	auipc	ra,0x3
    2c60:	f74080e7          	jalr	-140(ra) # 5bd0 <pipe>
    2c64:	e521                	bnez	a0,2cac <sbrkarg+0xbc>
}
    2c66:	70a2                	ld	ra,40(sp)
    2c68:	7402                	ld	s0,32(sp)
    2c6a:	64e2                	ld	s1,24(sp)
    2c6c:	6942                	ld	s2,16(sp)
    2c6e:	69a2                	ld	s3,8(sp)
    2c70:	6145                	addi	sp,sp,48
    2c72:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2c74:	85ce                	mv	a1,s3
    2c76:	00004517          	auipc	a0,0x4
    2c7a:	43a50513          	addi	a0,a0,1082 # 70b0 <malloc+0x10be>
    2c7e:	00003097          	auipc	ra,0x3
    2c82:	2bc080e7          	jalr	700(ra) # 5f3a <printf>
    exit(1);
    2c86:	4505                	li	a0,1
    2c88:	00003097          	auipc	ra,0x3
    2c8c:	f38080e7          	jalr	-200(ra) # 5bc0 <exit>
    printf("%s: write sbrk failed\n", s);
    2c90:	85ce                	mv	a1,s3
    2c92:	00004517          	auipc	a0,0x4
    2c96:	43650513          	addi	a0,a0,1078 # 70c8 <malloc+0x10d6>
    2c9a:	00003097          	auipc	ra,0x3
    2c9e:	2a0080e7          	jalr	672(ra) # 5f3a <printf>
    exit(1);
    2ca2:	4505                	li	a0,1
    2ca4:	00003097          	auipc	ra,0x3
    2ca8:	f1c080e7          	jalr	-228(ra) # 5bc0 <exit>
    printf("%s: pipe() failed\n", s);
    2cac:	85ce                	mv	a1,s3
    2cae:	00004517          	auipc	a0,0x4
    2cb2:	dfa50513          	addi	a0,a0,-518 # 6aa8 <malloc+0xab6>
    2cb6:	00003097          	auipc	ra,0x3
    2cba:	284080e7          	jalr	644(ra) # 5f3a <printf>
    exit(1);
    2cbe:	4505                	li	a0,1
    2cc0:	00003097          	auipc	ra,0x3
    2cc4:	f00080e7          	jalr	-256(ra) # 5bc0 <exit>

0000000000002cc8 <argptest>:
{
    2cc8:	1101                	addi	sp,sp,-32
    2cca:	ec06                	sd	ra,24(sp)
    2ccc:	e822                	sd	s0,16(sp)
    2cce:	e426                	sd	s1,8(sp)
    2cd0:	e04a                	sd	s2,0(sp)
    2cd2:	1000                	addi	s0,sp,32
    2cd4:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2cd6:	4581                	li	a1,0
    2cd8:	00004517          	auipc	a0,0x4
    2cdc:	40850513          	addi	a0,a0,1032 # 70e0 <malloc+0x10ee>
    2ce0:	00003097          	auipc	ra,0x3
    2ce4:	f20080e7          	jalr	-224(ra) # 5c00 <open>
  if (fd < 0) {
    2ce8:	02054b63          	bltz	a0,2d1e <argptest+0x56>
    2cec:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2cee:	4501                	li	a0,0
    2cf0:	00003097          	auipc	ra,0x3
    2cf4:	f58080e7          	jalr	-168(ra) # 5c48 <sbrk>
    2cf8:	567d                	li	a2,-1
    2cfa:	fff50593          	addi	a1,a0,-1
    2cfe:	8526                	mv	a0,s1
    2d00:	00003097          	auipc	ra,0x3
    2d04:	ed8080e7          	jalr	-296(ra) # 5bd8 <read>
  close(fd);
    2d08:	8526                	mv	a0,s1
    2d0a:	00003097          	auipc	ra,0x3
    2d0e:	ede080e7          	jalr	-290(ra) # 5be8 <close>
}
    2d12:	60e2                	ld	ra,24(sp)
    2d14:	6442                	ld	s0,16(sp)
    2d16:	64a2                	ld	s1,8(sp)
    2d18:	6902                	ld	s2,0(sp)
    2d1a:	6105                	addi	sp,sp,32
    2d1c:	8082                	ret
    printf("%s: open failed\n", s);
    2d1e:	85ca                	mv	a1,s2
    2d20:	00004517          	auipc	a0,0x4
    2d24:	c9850513          	addi	a0,a0,-872 # 69b8 <malloc+0x9c6>
    2d28:	00003097          	auipc	ra,0x3
    2d2c:	212080e7          	jalr	530(ra) # 5f3a <printf>
    exit(1);
    2d30:	4505                	li	a0,1
    2d32:	00003097          	auipc	ra,0x3
    2d36:	e8e080e7          	jalr	-370(ra) # 5bc0 <exit>

0000000000002d3a <sbrkbugs>:
{
    2d3a:	1141                	addi	sp,sp,-16
    2d3c:	e406                	sd	ra,8(sp)
    2d3e:	e022                	sd	s0,0(sp)
    2d40:	0800                	addi	s0,sp,16
  int pid = fork();
    2d42:	00003097          	auipc	ra,0x3
    2d46:	e76080e7          	jalr	-394(ra) # 5bb8 <fork>
  if(pid < 0){
    2d4a:	02054263          	bltz	a0,2d6e <sbrkbugs+0x34>
  if(pid == 0){
    2d4e:	ed0d                	bnez	a0,2d88 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2d50:	00003097          	auipc	ra,0x3
    2d54:	ef8080e7          	jalr	-264(ra) # 5c48 <sbrk>
    sbrk(-sz);
    2d58:	40a0053b          	negw	a0,a0
    2d5c:	00003097          	auipc	ra,0x3
    2d60:	eec080e7          	jalr	-276(ra) # 5c48 <sbrk>
    exit(0);
    2d64:	4501                	li	a0,0
    2d66:	00003097          	auipc	ra,0x3
    2d6a:	e5a080e7          	jalr	-422(ra) # 5bc0 <exit>
    printf("fork failed\n");
    2d6e:	00004517          	auipc	a0,0x4
    2d72:	03a50513          	addi	a0,a0,58 # 6da8 <malloc+0xdb6>
    2d76:	00003097          	auipc	ra,0x3
    2d7a:	1c4080e7          	jalr	452(ra) # 5f3a <printf>
    exit(1);
    2d7e:	4505                	li	a0,1
    2d80:	00003097          	auipc	ra,0x3
    2d84:	e40080e7          	jalr	-448(ra) # 5bc0 <exit>
  wait(0);
    2d88:	4501                	li	a0,0
    2d8a:	00003097          	auipc	ra,0x3
    2d8e:	e3e080e7          	jalr	-450(ra) # 5bc8 <wait>
  pid = fork();
    2d92:	00003097          	auipc	ra,0x3
    2d96:	e26080e7          	jalr	-474(ra) # 5bb8 <fork>
  if(pid < 0){
    2d9a:	02054563          	bltz	a0,2dc4 <sbrkbugs+0x8a>
  if(pid == 0){
    2d9e:	e121                	bnez	a0,2dde <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2da0:	00003097          	auipc	ra,0x3
    2da4:	ea8080e7          	jalr	-344(ra) # 5c48 <sbrk>
    sbrk(-(sz - 3500));
    2da8:	6785                	lui	a5,0x1
    2daa:	dac7879b          	addiw	a5,a5,-596 # dac <unlinkread+0x6e>
    2dae:	40a7853b          	subw	a0,a5,a0
    2db2:	00003097          	auipc	ra,0x3
    2db6:	e96080e7          	jalr	-362(ra) # 5c48 <sbrk>
    exit(0);
    2dba:	4501                	li	a0,0
    2dbc:	00003097          	auipc	ra,0x3
    2dc0:	e04080e7          	jalr	-508(ra) # 5bc0 <exit>
    printf("fork failed\n");
    2dc4:	00004517          	auipc	a0,0x4
    2dc8:	fe450513          	addi	a0,a0,-28 # 6da8 <malloc+0xdb6>
    2dcc:	00003097          	auipc	ra,0x3
    2dd0:	16e080e7          	jalr	366(ra) # 5f3a <printf>
    exit(1);
    2dd4:	4505                	li	a0,1
    2dd6:	00003097          	auipc	ra,0x3
    2dda:	dea080e7          	jalr	-534(ra) # 5bc0 <exit>
  wait(0);
    2dde:	4501                	li	a0,0
    2de0:	00003097          	auipc	ra,0x3
    2de4:	de8080e7          	jalr	-536(ra) # 5bc8 <wait>
  pid = fork();
    2de8:	00003097          	auipc	ra,0x3
    2dec:	dd0080e7          	jalr	-560(ra) # 5bb8 <fork>
  if(pid < 0){
    2df0:	02054a63          	bltz	a0,2e24 <sbrkbugs+0xea>
  if(pid == 0){
    2df4:	e529                	bnez	a0,2e3e <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2df6:	00003097          	auipc	ra,0x3
    2dfa:	e52080e7          	jalr	-430(ra) # 5c48 <sbrk>
    2dfe:	67ad                	lui	a5,0xb
    2e00:	8007879b          	addiw	a5,a5,-2048 # a800 <uninit+0x298>
    2e04:	40a7853b          	subw	a0,a5,a0
    2e08:	00003097          	auipc	ra,0x3
    2e0c:	e40080e7          	jalr	-448(ra) # 5c48 <sbrk>
    sbrk(-10);
    2e10:	5559                	li	a0,-10
    2e12:	00003097          	auipc	ra,0x3
    2e16:	e36080e7          	jalr	-458(ra) # 5c48 <sbrk>
    exit(0);
    2e1a:	4501                	li	a0,0
    2e1c:	00003097          	auipc	ra,0x3
    2e20:	da4080e7          	jalr	-604(ra) # 5bc0 <exit>
    printf("fork failed\n");
    2e24:	00004517          	auipc	a0,0x4
    2e28:	f8450513          	addi	a0,a0,-124 # 6da8 <malloc+0xdb6>
    2e2c:	00003097          	auipc	ra,0x3
    2e30:	10e080e7          	jalr	270(ra) # 5f3a <printf>
    exit(1);
    2e34:	4505                	li	a0,1
    2e36:	00003097          	auipc	ra,0x3
    2e3a:	d8a080e7          	jalr	-630(ra) # 5bc0 <exit>
  wait(0);
    2e3e:	4501                	li	a0,0
    2e40:	00003097          	auipc	ra,0x3
    2e44:	d88080e7          	jalr	-632(ra) # 5bc8 <wait>
  exit(0);
    2e48:	4501                	li	a0,0
    2e4a:	00003097          	auipc	ra,0x3
    2e4e:	d76080e7          	jalr	-650(ra) # 5bc0 <exit>

0000000000002e52 <sbrklast>:
{
    2e52:	7179                	addi	sp,sp,-48
    2e54:	f406                	sd	ra,40(sp)
    2e56:	f022                	sd	s0,32(sp)
    2e58:	ec26                	sd	s1,24(sp)
    2e5a:	e84a                	sd	s2,16(sp)
    2e5c:	e44e                	sd	s3,8(sp)
    2e5e:	e052                	sd	s4,0(sp)
    2e60:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2e62:	4501                	li	a0,0
    2e64:	00003097          	auipc	ra,0x3
    2e68:	de4080e7          	jalr	-540(ra) # 5c48 <sbrk>
  if((top % 4096) != 0)
    2e6c:	03451793          	slli	a5,a0,0x34
    2e70:	ebd9                	bnez	a5,2f06 <sbrklast+0xb4>
  sbrk(4096);
    2e72:	6505                	lui	a0,0x1
    2e74:	00003097          	auipc	ra,0x3
    2e78:	dd4080e7          	jalr	-556(ra) # 5c48 <sbrk>
  sbrk(10);
    2e7c:	4529                	li	a0,10
    2e7e:	00003097          	auipc	ra,0x3
    2e82:	dca080e7          	jalr	-566(ra) # 5c48 <sbrk>
  sbrk(-20);
    2e86:	5531                	li	a0,-20
    2e88:	00003097          	auipc	ra,0x3
    2e8c:	dc0080e7          	jalr	-576(ra) # 5c48 <sbrk>
  top = (uint64) sbrk(0);
    2e90:	4501                	li	a0,0
    2e92:	00003097          	auipc	ra,0x3
    2e96:	db6080e7          	jalr	-586(ra) # 5c48 <sbrk>
    2e9a:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2e9c:	fc050913          	addi	s2,a0,-64 # fc0 <linktest+0xcc>
  p[0] = 'x';
    2ea0:	07800a13          	li	s4,120
    2ea4:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2ea8:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2eac:	20200593          	li	a1,514
    2eb0:	854a                	mv	a0,s2
    2eb2:	00003097          	auipc	ra,0x3
    2eb6:	d4e080e7          	jalr	-690(ra) # 5c00 <open>
    2eba:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2ebc:	4605                	li	a2,1
    2ebe:	85ca                	mv	a1,s2
    2ec0:	00003097          	auipc	ra,0x3
    2ec4:	d20080e7          	jalr	-736(ra) # 5be0 <write>
  close(fd);
    2ec8:	854e                	mv	a0,s3
    2eca:	00003097          	auipc	ra,0x3
    2ece:	d1e080e7          	jalr	-738(ra) # 5be8 <close>
  fd = open(p, O_RDWR);
    2ed2:	4589                	li	a1,2
    2ed4:	854a                	mv	a0,s2
    2ed6:	00003097          	auipc	ra,0x3
    2eda:	d2a080e7          	jalr	-726(ra) # 5c00 <open>
  p[0] = '\0';
    2ede:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2ee2:	4605                	li	a2,1
    2ee4:	85ca                	mv	a1,s2
    2ee6:	00003097          	auipc	ra,0x3
    2eea:	cf2080e7          	jalr	-782(ra) # 5bd8 <read>
  if(p[0] != 'x')
    2eee:	fc04c783          	lbu	a5,-64(s1)
    2ef2:	03479463          	bne	a5,s4,2f1a <sbrklast+0xc8>
}
    2ef6:	70a2                	ld	ra,40(sp)
    2ef8:	7402                	ld	s0,32(sp)
    2efa:	64e2                	ld	s1,24(sp)
    2efc:	6942                	ld	s2,16(sp)
    2efe:	69a2                	ld	s3,8(sp)
    2f00:	6a02                	ld	s4,0(sp)
    2f02:	6145                	addi	sp,sp,48
    2f04:	8082                	ret
    sbrk(4096 - (top % 4096));
    2f06:	0347d513          	srli	a0,a5,0x34
    2f0a:	6785                	lui	a5,0x1
    2f0c:	40a7853b          	subw	a0,a5,a0
    2f10:	00003097          	auipc	ra,0x3
    2f14:	d38080e7          	jalr	-712(ra) # 5c48 <sbrk>
    2f18:	bfa9                	j	2e72 <sbrklast+0x20>
    exit(1);
    2f1a:	4505                	li	a0,1
    2f1c:	00003097          	auipc	ra,0x3
    2f20:	ca4080e7          	jalr	-860(ra) # 5bc0 <exit>

0000000000002f24 <sbrk8000>:
{
    2f24:	1141                	addi	sp,sp,-16
    2f26:	e406                	sd	ra,8(sp)
    2f28:	e022                	sd	s0,0(sp)
    2f2a:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2f2c:	80000537          	lui	a0,0x80000
    2f30:	0511                	addi	a0,a0,4 # ffffffff80000004 <base+0xffffffff7fff038c>
    2f32:	00003097          	auipc	ra,0x3
    2f36:	d16080e7          	jalr	-746(ra) # 5c48 <sbrk>
  volatile char *top = sbrk(0);
    2f3a:	4501                	li	a0,0
    2f3c:	00003097          	auipc	ra,0x3
    2f40:	d0c080e7          	jalr	-756(ra) # 5c48 <sbrk>
  *(top-1) = *(top-1) + 1;
    2f44:	fff54783          	lbu	a5,-1(a0)
    2f48:	2785                	addiw	a5,a5,1 # 1001 <linktest+0x10d>
    2f4a:	0ff7f793          	zext.b	a5,a5
    2f4e:	fef50fa3          	sb	a5,-1(a0)
}
    2f52:	60a2                	ld	ra,8(sp)
    2f54:	6402                	ld	s0,0(sp)
    2f56:	0141                	addi	sp,sp,16
    2f58:	8082                	ret

0000000000002f5a <execout>:
{
    2f5a:	715d                	addi	sp,sp,-80
    2f5c:	e486                	sd	ra,72(sp)
    2f5e:	e0a2                	sd	s0,64(sp)
    2f60:	fc26                	sd	s1,56(sp)
    2f62:	f84a                	sd	s2,48(sp)
    2f64:	f44e                	sd	s3,40(sp)
    2f66:	f052                	sd	s4,32(sp)
    2f68:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2f6a:	4901                	li	s2,0
    2f6c:	49bd                	li	s3,15
    int pid = fork();
    2f6e:	00003097          	auipc	ra,0x3
    2f72:	c4a080e7          	jalr	-950(ra) # 5bb8 <fork>
    2f76:	84aa                	mv	s1,a0
    if(pid < 0){
    2f78:	02054063          	bltz	a0,2f98 <execout+0x3e>
    } else if(pid == 0){
    2f7c:	c91d                	beqz	a0,2fb2 <execout+0x58>
      wait((int*)0);
    2f7e:	4501                	li	a0,0
    2f80:	00003097          	auipc	ra,0x3
    2f84:	c48080e7          	jalr	-952(ra) # 5bc8 <wait>
  for(int avail = 0; avail < 15; avail++){
    2f88:	2905                	addiw	s2,s2,1
    2f8a:	ff3912e3          	bne	s2,s3,2f6e <execout+0x14>
  exit(0);
    2f8e:	4501                	li	a0,0
    2f90:	00003097          	auipc	ra,0x3
    2f94:	c30080e7          	jalr	-976(ra) # 5bc0 <exit>
      printf("fork failed\n");
    2f98:	00004517          	auipc	a0,0x4
    2f9c:	e1050513          	addi	a0,a0,-496 # 6da8 <malloc+0xdb6>
    2fa0:	00003097          	auipc	ra,0x3
    2fa4:	f9a080e7          	jalr	-102(ra) # 5f3a <printf>
      exit(1);
    2fa8:	4505                	li	a0,1
    2faa:	00003097          	auipc	ra,0x3
    2fae:	c16080e7          	jalr	-1002(ra) # 5bc0 <exit>
        if(a == 0xffffffffffffffffLL)
    2fb2:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2fb4:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2fb6:	6505                	lui	a0,0x1
    2fb8:	00003097          	auipc	ra,0x3
    2fbc:	c90080e7          	jalr	-880(ra) # 5c48 <sbrk>
        if(a == 0xffffffffffffffffLL)
    2fc0:	01350763          	beq	a0,s3,2fce <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2fc4:	6785                	lui	a5,0x1
    2fc6:	97aa                	add	a5,a5,a0
    2fc8:	ff478fa3          	sb	s4,-1(a5) # fff <linktest+0x10b>
      while(1){
    2fcc:	b7ed                	j	2fb6 <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2fce:	01205a63          	blez	s2,2fe2 <execout+0x88>
        sbrk(-4096);
    2fd2:	757d                	lui	a0,0xfffff
    2fd4:	00003097          	auipc	ra,0x3
    2fd8:	c74080e7          	jalr	-908(ra) # 5c48 <sbrk>
      for(int i = 0; i < avail; i++)
    2fdc:	2485                	addiw	s1,s1,1
    2fde:	ff249ae3          	bne	s1,s2,2fd2 <execout+0x78>
      close(1);
    2fe2:	4505                	li	a0,1
    2fe4:	00003097          	auipc	ra,0x3
    2fe8:	c04080e7          	jalr	-1020(ra) # 5be8 <close>
      char *args[] = { "echo", "x", 0 };
    2fec:	00003517          	auipc	a0,0x3
    2ff0:	12c50513          	addi	a0,a0,300 # 6118 <malloc+0x126>
    2ff4:	faa43c23          	sd	a0,-72(s0)
    2ff8:	00003797          	auipc	a5,0x3
    2ffc:	19078793          	addi	a5,a5,400 # 6188 <malloc+0x196>
    3000:	fcf43023          	sd	a5,-64(s0)
    3004:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    3008:	fb840593          	addi	a1,s0,-72
    300c:	00003097          	auipc	ra,0x3
    3010:	bec080e7          	jalr	-1044(ra) # 5bf8 <exec>
      exit(0);
    3014:	4501                	li	a0,0
    3016:	00003097          	auipc	ra,0x3
    301a:	baa080e7          	jalr	-1110(ra) # 5bc0 <exit>

000000000000301e <fourteen>:
{
    301e:	1101                	addi	sp,sp,-32
    3020:	ec06                	sd	ra,24(sp)
    3022:	e822                	sd	s0,16(sp)
    3024:	e426                	sd	s1,8(sp)
    3026:	1000                	addi	s0,sp,32
    3028:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    302a:	00004517          	auipc	a0,0x4
    302e:	28e50513          	addi	a0,a0,654 # 72b8 <malloc+0x12c6>
    3032:	00003097          	auipc	ra,0x3
    3036:	bf6080e7          	jalr	-1034(ra) # 5c28 <mkdir>
    303a:	e165                	bnez	a0,311a <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    303c:	00004517          	auipc	a0,0x4
    3040:	0d450513          	addi	a0,a0,212 # 7110 <malloc+0x111e>
    3044:	00003097          	auipc	ra,0x3
    3048:	be4080e7          	jalr	-1052(ra) # 5c28 <mkdir>
    304c:	e56d                	bnez	a0,3136 <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    304e:	20000593          	li	a1,512
    3052:	00004517          	auipc	a0,0x4
    3056:	11650513          	addi	a0,a0,278 # 7168 <malloc+0x1176>
    305a:	00003097          	auipc	ra,0x3
    305e:	ba6080e7          	jalr	-1114(ra) # 5c00 <open>
  if(fd < 0){
    3062:	0e054863          	bltz	a0,3152 <fourteen+0x134>
  close(fd);
    3066:	00003097          	auipc	ra,0x3
    306a:	b82080e7          	jalr	-1150(ra) # 5be8 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    306e:	4581                	li	a1,0
    3070:	00004517          	auipc	a0,0x4
    3074:	17050513          	addi	a0,a0,368 # 71e0 <malloc+0x11ee>
    3078:	00003097          	auipc	ra,0x3
    307c:	b88080e7          	jalr	-1144(ra) # 5c00 <open>
  if(fd < 0){
    3080:	0e054763          	bltz	a0,316e <fourteen+0x150>
  close(fd);
    3084:	00003097          	auipc	ra,0x3
    3088:	b64080e7          	jalr	-1180(ra) # 5be8 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    308c:	00004517          	auipc	a0,0x4
    3090:	1c450513          	addi	a0,a0,452 # 7250 <malloc+0x125e>
    3094:	00003097          	auipc	ra,0x3
    3098:	b94080e7          	jalr	-1132(ra) # 5c28 <mkdir>
    309c:	c57d                	beqz	a0,318a <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    309e:	00004517          	auipc	a0,0x4
    30a2:	20a50513          	addi	a0,a0,522 # 72a8 <malloc+0x12b6>
    30a6:	00003097          	auipc	ra,0x3
    30aa:	b82080e7          	jalr	-1150(ra) # 5c28 <mkdir>
    30ae:	cd65                	beqz	a0,31a6 <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    30b0:	00004517          	auipc	a0,0x4
    30b4:	1f850513          	addi	a0,a0,504 # 72a8 <malloc+0x12b6>
    30b8:	00003097          	auipc	ra,0x3
    30bc:	b58080e7          	jalr	-1192(ra) # 5c10 <unlink>
  unlink("12345678901234/12345678901234");
    30c0:	00004517          	auipc	a0,0x4
    30c4:	19050513          	addi	a0,a0,400 # 7250 <malloc+0x125e>
    30c8:	00003097          	auipc	ra,0x3
    30cc:	b48080e7          	jalr	-1208(ra) # 5c10 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    30d0:	00004517          	auipc	a0,0x4
    30d4:	11050513          	addi	a0,a0,272 # 71e0 <malloc+0x11ee>
    30d8:	00003097          	auipc	ra,0x3
    30dc:	b38080e7          	jalr	-1224(ra) # 5c10 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    30e0:	00004517          	auipc	a0,0x4
    30e4:	08850513          	addi	a0,a0,136 # 7168 <malloc+0x1176>
    30e8:	00003097          	auipc	ra,0x3
    30ec:	b28080e7          	jalr	-1240(ra) # 5c10 <unlink>
  unlink("12345678901234/123456789012345");
    30f0:	00004517          	auipc	a0,0x4
    30f4:	02050513          	addi	a0,a0,32 # 7110 <malloc+0x111e>
    30f8:	00003097          	auipc	ra,0x3
    30fc:	b18080e7          	jalr	-1256(ra) # 5c10 <unlink>
  unlink("12345678901234");
    3100:	00004517          	auipc	a0,0x4
    3104:	1b850513          	addi	a0,a0,440 # 72b8 <malloc+0x12c6>
    3108:	00003097          	auipc	ra,0x3
    310c:	b08080e7          	jalr	-1272(ra) # 5c10 <unlink>
}
    3110:	60e2                	ld	ra,24(sp)
    3112:	6442                	ld	s0,16(sp)
    3114:	64a2                	ld	s1,8(sp)
    3116:	6105                	addi	sp,sp,32
    3118:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    311a:	85a6                	mv	a1,s1
    311c:	00004517          	auipc	a0,0x4
    3120:	fcc50513          	addi	a0,a0,-52 # 70e8 <malloc+0x10f6>
    3124:	00003097          	auipc	ra,0x3
    3128:	e16080e7          	jalr	-490(ra) # 5f3a <printf>
    exit(1);
    312c:	4505                	li	a0,1
    312e:	00003097          	auipc	ra,0x3
    3132:	a92080e7          	jalr	-1390(ra) # 5bc0 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    3136:	85a6                	mv	a1,s1
    3138:	00004517          	auipc	a0,0x4
    313c:	ff850513          	addi	a0,a0,-8 # 7130 <malloc+0x113e>
    3140:	00003097          	auipc	ra,0x3
    3144:	dfa080e7          	jalr	-518(ra) # 5f3a <printf>
    exit(1);
    3148:	4505                	li	a0,1
    314a:	00003097          	auipc	ra,0x3
    314e:	a76080e7          	jalr	-1418(ra) # 5bc0 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    3152:	85a6                	mv	a1,s1
    3154:	00004517          	auipc	a0,0x4
    3158:	04450513          	addi	a0,a0,68 # 7198 <malloc+0x11a6>
    315c:	00003097          	auipc	ra,0x3
    3160:	dde080e7          	jalr	-546(ra) # 5f3a <printf>
    exit(1);
    3164:	4505                	li	a0,1
    3166:	00003097          	auipc	ra,0x3
    316a:	a5a080e7          	jalr	-1446(ra) # 5bc0 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    316e:	85a6                	mv	a1,s1
    3170:	00004517          	auipc	a0,0x4
    3174:	0a050513          	addi	a0,a0,160 # 7210 <malloc+0x121e>
    3178:	00003097          	auipc	ra,0x3
    317c:	dc2080e7          	jalr	-574(ra) # 5f3a <printf>
    exit(1);
    3180:	4505                	li	a0,1
    3182:	00003097          	auipc	ra,0x3
    3186:	a3e080e7          	jalr	-1474(ra) # 5bc0 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    318a:	85a6                	mv	a1,s1
    318c:	00004517          	auipc	a0,0x4
    3190:	0e450513          	addi	a0,a0,228 # 7270 <malloc+0x127e>
    3194:	00003097          	auipc	ra,0x3
    3198:	da6080e7          	jalr	-602(ra) # 5f3a <printf>
    exit(1);
    319c:	4505                	li	a0,1
    319e:	00003097          	auipc	ra,0x3
    31a2:	a22080e7          	jalr	-1502(ra) # 5bc0 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    31a6:	85a6                	mv	a1,s1
    31a8:	00004517          	auipc	a0,0x4
    31ac:	12050513          	addi	a0,a0,288 # 72c8 <malloc+0x12d6>
    31b0:	00003097          	auipc	ra,0x3
    31b4:	d8a080e7          	jalr	-630(ra) # 5f3a <printf>
    exit(1);
    31b8:	4505                	li	a0,1
    31ba:	00003097          	auipc	ra,0x3
    31be:	a06080e7          	jalr	-1530(ra) # 5bc0 <exit>

00000000000031c2 <diskfull>:
{
    31c2:	b9010113          	addi	sp,sp,-1136
    31c6:	46113423          	sd	ra,1128(sp)
    31ca:	46813023          	sd	s0,1120(sp)
    31ce:	44913c23          	sd	s1,1112(sp)
    31d2:	45213823          	sd	s2,1104(sp)
    31d6:	45313423          	sd	s3,1096(sp)
    31da:	45413023          	sd	s4,1088(sp)
    31de:	43513c23          	sd	s5,1080(sp)
    31e2:	43613823          	sd	s6,1072(sp)
    31e6:	43713423          	sd	s7,1064(sp)
    31ea:	43813023          	sd	s8,1056(sp)
    31ee:	47010413          	addi	s0,sp,1136
    31f2:	8c2a                	mv	s8,a0
  unlink("diskfulldir");
    31f4:	00004517          	auipc	a0,0x4
    31f8:	10c50513          	addi	a0,a0,268 # 7300 <malloc+0x130e>
    31fc:	00003097          	auipc	ra,0x3
    3200:	a14080e7          	jalr	-1516(ra) # 5c10 <unlink>
  for(fi = 0; done == 0; fi++){
    3204:	4a01                	li	s4,0
    name[0] = 'b';
    3206:	06200b13          	li	s6,98
    name[1] = 'i';
    320a:	06900a93          	li	s5,105
    name[2] = 'g';
    320e:	06700993          	li	s3,103
    3212:	10c00b93          	li	s7,268
    3216:	aabd                	j	3394 <diskfull+0x1d2>
      printf("%s: could not create file %s\n", s, name);
    3218:	b9040613          	addi	a2,s0,-1136
    321c:	85e2                	mv	a1,s8
    321e:	00004517          	auipc	a0,0x4
    3222:	0f250513          	addi	a0,a0,242 # 7310 <malloc+0x131e>
    3226:	00003097          	auipc	ra,0x3
    322a:	d14080e7          	jalr	-748(ra) # 5f3a <printf>
      break;
    322e:	a821                	j	3246 <diskfull+0x84>
        close(fd);
    3230:	854a                	mv	a0,s2
    3232:	00003097          	auipc	ra,0x3
    3236:	9b6080e7          	jalr	-1610(ra) # 5be8 <close>
    close(fd);
    323a:	854a                	mv	a0,s2
    323c:	00003097          	auipc	ra,0x3
    3240:	9ac080e7          	jalr	-1620(ra) # 5be8 <close>
  for(fi = 0; done == 0; fi++){
    3244:	2a05                	addiw	s4,s4,1
  for(int i = 0; i < nzz; i++){
    3246:	4481                	li	s1,0
    name[0] = 'z';
    3248:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    324c:	08000993          	li	s3,128
    name[0] = 'z';
    3250:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    3254:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    3258:	41f4d71b          	sraiw	a4,s1,0x1f
    325c:	01b7571b          	srliw	a4,a4,0x1b
    3260:	009707bb          	addw	a5,a4,s1
    3264:	4057d69b          	sraiw	a3,a5,0x5
    3268:	0306869b          	addiw	a3,a3,48
    326c:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    3270:	8bfd                	andi	a5,a5,31
    3272:	9f99                	subw	a5,a5,a4
    3274:	0307879b          	addiw	a5,a5,48
    3278:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    327c:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3280:	bb040513          	addi	a0,s0,-1104
    3284:	00003097          	auipc	ra,0x3
    3288:	98c080e7          	jalr	-1652(ra) # 5c10 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    328c:	60200593          	li	a1,1538
    3290:	bb040513          	addi	a0,s0,-1104
    3294:	00003097          	auipc	ra,0x3
    3298:	96c080e7          	jalr	-1684(ra) # 5c00 <open>
    if(fd < 0)
    329c:	00054963          	bltz	a0,32ae <diskfull+0xec>
    close(fd);
    32a0:	00003097          	auipc	ra,0x3
    32a4:	948080e7          	jalr	-1720(ra) # 5be8 <close>
  for(int i = 0; i < nzz; i++){
    32a8:	2485                	addiw	s1,s1,1
    32aa:	fb3493e3          	bne	s1,s3,3250 <diskfull+0x8e>
  if(mkdir("diskfulldir") == 0)
    32ae:	00004517          	auipc	a0,0x4
    32b2:	05250513          	addi	a0,a0,82 # 7300 <malloc+0x130e>
    32b6:	00003097          	auipc	ra,0x3
    32ba:	972080e7          	jalr	-1678(ra) # 5c28 <mkdir>
    32be:	12050963          	beqz	a0,33f0 <diskfull+0x22e>
  unlink("diskfulldir");
    32c2:	00004517          	auipc	a0,0x4
    32c6:	03e50513          	addi	a0,a0,62 # 7300 <malloc+0x130e>
    32ca:	00003097          	auipc	ra,0x3
    32ce:	946080e7          	jalr	-1722(ra) # 5c10 <unlink>
  for(int i = 0; i < nzz; i++){
    32d2:	4481                	li	s1,0
    name[0] = 'z';
    32d4:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    32d8:	08000993          	li	s3,128
    name[0] = 'z';
    32dc:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    32e0:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    32e4:	41f4d71b          	sraiw	a4,s1,0x1f
    32e8:	01b7571b          	srliw	a4,a4,0x1b
    32ec:	009707bb          	addw	a5,a4,s1
    32f0:	4057d69b          	sraiw	a3,a5,0x5
    32f4:	0306869b          	addiw	a3,a3,48
    32f8:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    32fc:	8bfd                	andi	a5,a5,31
    32fe:	9f99                	subw	a5,a5,a4
    3300:	0307879b          	addiw	a5,a5,48
    3304:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3308:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    330c:	bb040513          	addi	a0,s0,-1104
    3310:	00003097          	auipc	ra,0x3
    3314:	900080e7          	jalr	-1792(ra) # 5c10 <unlink>
  for(int i = 0; i < nzz; i++){
    3318:	2485                	addiw	s1,s1,1
    331a:	fd3491e3          	bne	s1,s3,32dc <diskfull+0x11a>
  for(int i = 0; i < fi; i++){
    331e:	03405e63          	blez	s4,335a <diskfull+0x198>
    3322:	4481                	li	s1,0
    name[0] = 'b';
    3324:	06200a93          	li	s5,98
    name[1] = 'i';
    3328:	06900993          	li	s3,105
    name[2] = 'g';
    332c:	06700913          	li	s2,103
    name[0] = 'b';
    3330:	bb540823          	sb	s5,-1104(s0)
    name[1] = 'i';
    3334:	bb3408a3          	sb	s3,-1103(s0)
    name[2] = 'g';
    3338:	bb240923          	sb	s2,-1102(s0)
    name[3] = '0' + i;
    333c:	0304879b          	addiw	a5,s1,48
    3340:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3344:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3348:	bb040513          	addi	a0,s0,-1104
    334c:	00003097          	auipc	ra,0x3
    3350:	8c4080e7          	jalr	-1852(ra) # 5c10 <unlink>
  for(int i = 0; i < fi; i++){
    3354:	2485                	addiw	s1,s1,1
    3356:	fd449de3          	bne	s1,s4,3330 <diskfull+0x16e>
}
    335a:	46813083          	ld	ra,1128(sp)
    335e:	46013403          	ld	s0,1120(sp)
    3362:	45813483          	ld	s1,1112(sp)
    3366:	45013903          	ld	s2,1104(sp)
    336a:	44813983          	ld	s3,1096(sp)
    336e:	44013a03          	ld	s4,1088(sp)
    3372:	43813a83          	ld	s5,1080(sp)
    3376:	43013b03          	ld	s6,1072(sp)
    337a:	42813b83          	ld	s7,1064(sp)
    337e:	42013c03          	ld	s8,1056(sp)
    3382:	47010113          	addi	sp,sp,1136
    3386:	8082                	ret
    close(fd);
    3388:	854a                	mv	a0,s2
    338a:	00003097          	auipc	ra,0x3
    338e:	85e080e7          	jalr	-1954(ra) # 5be8 <close>
  for(fi = 0; done == 0; fi++){
    3392:	2a05                	addiw	s4,s4,1
    name[0] = 'b';
    3394:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    3398:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    339c:	b9340923          	sb	s3,-1134(s0)
    name[3] = '0' + fi;
    33a0:	030a079b          	addiw	a5,s4,48
    33a4:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    33a8:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    33ac:	b9040513          	addi	a0,s0,-1136
    33b0:	00003097          	auipc	ra,0x3
    33b4:	860080e7          	jalr	-1952(ra) # 5c10 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    33b8:	60200593          	li	a1,1538
    33bc:	b9040513          	addi	a0,s0,-1136
    33c0:	00003097          	auipc	ra,0x3
    33c4:	840080e7          	jalr	-1984(ra) # 5c00 <open>
    33c8:	892a                	mv	s2,a0
    if(fd < 0){
    33ca:	e40547e3          	bltz	a0,3218 <diskfull+0x56>
    33ce:	84de                	mv	s1,s7
      if(write(fd, buf, BSIZE) != BSIZE){
    33d0:	40000613          	li	a2,1024
    33d4:	bb040593          	addi	a1,s0,-1104
    33d8:	854a                	mv	a0,s2
    33da:	00003097          	auipc	ra,0x3
    33de:	806080e7          	jalr	-2042(ra) # 5be0 <write>
    33e2:	40000793          	li	a5,1024
    33e6:	e4f515e3          	bne	a0,a5,3230 <diskfull+0x6e>
    for(int i = 0; i < MAXFILE; i++){
    33ea:	34fd                	addiw	s1,s1,-1
    33ec:	f0f5                	bnez	s1,33d0 <diskfull+0x20e>
    33ee:	bf69                	j	3388 <diskfull+0x1c6>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    33f0:	00004517          	auipc	a0,0x4
    33f4:	f4050513          	addi	a0,a0,-192 # 7330 <malloc+0x133e>
    33f8:	00003097          	auipc	ra,0x3
    33fc:	b42080e7          	jalr	-1214(ra) # 5f3a <printf>
    3400:	b5c9                	j	32c2 <diskfull+0x100>

0000000000003402 <iputtest>:
{
    3402:	1101                	addi	sp,sp,-32
    3404:	ec06                	sd	ra,24(sp)
    3406:	e822                	sd	s0,16(sp)
    3408:	e426                	sd	s1,8(sp)
    340a:	1000                	addi	s0,sp,32
    340c:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    340e:	00004517          	auipc	a0,0x4
    3412:	f5250513          	addi	a0,a0,-174 # 7360 <malloc+0x136e>
    3416:	00003097          	auipc	ra,0x3
    341a:	812080e7          	jalr	-2030(ra) # 5c28 <mkdir>
    341e:	04054563          	bltz	a0,3468 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    3422:	00004517          	auipc	a0,0x4
    3426:	f3e50513          	addi	a0,a0,-194 # 7360 <malloc+0x136e>
    342a:	00003097          	auipc	ra,0x3
    342e:	806080e7          	jalr	-2042(ra) # 5c30 <chdir>
    3432:	04054963          	bltz	a0,3484 <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    3436:	00004517          	auipc	a0,0x4
    343a:	f6a50513          	addi	a0,a0,-150 # 73a0 <malloc+0x13ae>
    343e:	00002097          	auipc	ra,0x2
    3442:	7d2080e7          	jalr	2002(ra) # 5c10 <unlink>
    3446:	04054d63          	bltz	a0,34a0 <iputtest+0x9e>
  if(chdir("/") < 0){
    344a:	00004517          	auipc	a0,0x4
    344e:	f8650513          	addi	a0,a0,-122 # 73d0 <malloc+0x13de>
    3452:	00002097          	auipc	ra,0x2
    3456:	7de080e7          	jalr	2014(ra) # 5c30 <chdir>
    345a:	06054163          	bltz	a0,34bc <iputtest+0xba>
}
    345e:	60e2                	ld	ra,24(sp)
    3460:	6442                	ld	s0,16(sp)
    3462:	64a2                	ld	s1,8(sp)
    3464:	6105                	addi	sp,sp,32
    3466:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3468:	85a6                	mv	a1,s1
    346a:	00004517          	auipc	a0,0x4
    346e:	efe50513          	addi	a0,a0,-258 # 7368 <malloc+0x1376>
    3472:	00003097          	auipc	ra,0x3
    3476:	ac8080e7          	jalr	-1336(ra) # 5f3a <printf>
    exit(1);
    347a:	4505                	li	a0,1
    347c:	00002097          	auipc	ra,0x2
    3480:	744080e7          	jalr	1860(ra) # 5bc0 <exit>
    printf("%s: chdir iputdir failed\n", s);
    3484:	85a6                	mv	a1,s1
    3486:	00004517          	auipc	a0,0x4
    348a:	efa50513          	addi	a0,a0,-262 # 7380 <malloc+0x138e>
    348e:	00003097          	auipc	ra,0x3
    3492:	aac080e7          	jalr	-1364(ra) # 5f3a <printf>
    exit(1);
    3496:	4505                	li	a0,1
    3498:	00002097          	auipc	ra,0x2
    349c:	728080e7          	jalr	1832(ra) # 5bc0 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    34a0:	85a6                	mv	a1,s1
    34a2:	00004517          	auipc	a0,0x4
    34a6:	f0e50513          	addi	a0,a0,-242 # 73b0 <malloc+0x13be>
    34aa:	00003097          	auipc	ra,0x3
    34ae:	a90080e7          	jalr	-1392(ra) # 5f3a <printf>
    exit(1);
    34b2:	4505                	li	a0,1
    34b4:	00002097          	auipc	ra,0x2
    34b8:	70c080e7          	jalr	1804(ra) # 5bc0 <exit>
    printf("%s: chdir / failed\n", s);
    34bc:	85a6                	mv	a1,s1
    34be:	00004517          	auipc	a0,0x4
    34c2:	f1a50513          	addi	a0,a0,-230 # 73d8 <malloc+0x13e6>
    34c6:	00003097          	auipc	ra,0x3
    34ca:	a74080e7          	jalr	-1420(ra) # 5f3a <printf>
    exit(1);
    34ce:	4505                	li	a0,1
    34d0:	00002097          	auipc	ra,0x2
    34d4:	6f0080e7          	jalr	1776(ra) # 5bc0 <exit>

00000000000034d8 <exitiputtest>:
{
    34d8:	7179                	addi	sp,sp,-48
    34da:	f406                	sd	ra,40(sp)
    34dc:	f022                	sd	s0,32(sp)
    34de:	ec26                	sd	s1,24(sp)
    34e0:	1800                	addi	s0,sp,48
    34e2:	84aa                	mv	s1,a0
  pid = fork();
    34e4:	00002097          	auipc	ra,0x2
    34e8:	6d4080e7          	jalr	1748(ra) # 5bb8 <fork>
  if(pid < 0){
    34ec:	04054663          	bltz	a0,3538 <exitiputtest+0x60>
  if(pid == 0){
    34f0:	ed45                	bnez	a0,35a8 <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    34f2:	00004517          	auipc	a0,0x4
    34f6:	e6e50513          	addi	a0,a0,-402 # 7360 <malloc+0x136e>
    34fa:	00002097          	auipc	ra,0x2
    34fe:	72e080e7          	jalr	1838(ra) # 5c28 <mkdir>
    3502:	04054963          	bltz	a0,3554 <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    3506:	00004517          	auipc	a0,0x4
    350a:	e5a50513          	addi	a0,a0,-422 # 7360 <malloc+0x136e>
    350e:	00002097          	auipc	ra,0x2
    3512:	722080e7          	jalr	1826(ra) # 5c30 <chdir>
    3516:	04054d63          	bltz	a0,3570 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    351a:	00004517          	auipc	a0,0x4
    351e:	e8650513          	addi	a0,a0,-378 # 73a0 <malloc+0x13ae>
    3522:	00002097          	auipc	ra,0x2
    3526:	6ee080e7          	jalr	1774(ra) # 5c10 <unlink>
    352a:	06054163          	bltz	a0,358c <exitiputtest+0xb4>
    exit(0);
    352e:	4501                	li	a0,0
    3530:	00002097          	auipc	ra,0x2
    3534:	690080e7          	jalr	1680(ra) # 5bc0 <exit>
    printf("%s: fork failed\n", s);
    3538:	85a6                	mv	a1,s1
    353a:	00003517          	auipc	a0,0x3
    353e:	46650513          	addi	a0,a0,1126 # 69a0 <malloc+0x9ae>
    3542:	00003097          	auipc	ra,0x3
    3546:	9f8080e7          	jalr	-1544(ra) # 5f3a <printf>
    exit(1);
    354a:	4505                	li	a0,1
    354c:	00002097          	auipc	ra,0x2
    3550:	674080e7          	jalr	1652(ra) # 5bc0 <exit>
      printf("%s: mkdir failed\n", s);
    3554:	85a6                	mv	a1,s1
    3556:	00004517          	auipc	a0,0x4
    355a:	e1250513          	addi	a0,a0,-494 # 7368 <malloc+0x1376>
    355e:	00003097          	auipc	ra,0x3
    3562:	9dc080e7          	jalr	-1572(ra) # 5f3a <printf>
      exit(1);
    3566:	4505                	li	a0,1
    3568:	00002097          	auipc	ra,0x2
    356c:	658080e7          	jalr	1624(ra) # 5bc0 <exit>
      printf("%s: child chdir failed\n", s);
    3570:	85a6                	mv	a1,s1
    3572:	00004517          	auipc	a0,0x4
    3576:	e7e50513          	addi	a0,a0,-386 # 73f0 <malloc+0x13fe>
    357a:	00003097          	auipc	ra,0x3
    357e:	9c0080e7          	jalr	-1600(ra) # 5f3a <printf>
      exit(1);
    3582:	4505                	li	a0,1
    3584:	00002097          	auipc	ra,0x2
    3588:	63c080e7          	jalr	1596(ra) # 5bc0 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    358c:	85a6                	mv	a1,s1
    358e:	00004517          	auipc	a0,0x4
    3592:	e2250513          	addi	a0,a0,-478 # 73b0 <malloc+0x13be>
    3596:	00003097          	auipc	ra,0x3
    359a:	9a4080e7          	jalr	-1628(ra) # 5f3a <printf>
      exit(1);
    359e:	4505                	li	a0,1
    35a0:	00002097          	auipc	ra,0x2
    35a4:	620080e7          	jalr	1568(ra) # 5bc0 <exit>
  wait(&xstatus);
    35a8:	fdc40513          	addi	a0,s0,-36
    35ac:	00002097          	auipc	ra,0x2
    35b0:	61c080e7          	jalr	1564(ra) # 5bc8 <wait>
  exit(xstatus);
    35b4:	fdc42503          	lw	a0,-36(s0)
    35b8:	00002097          	auipc	ra,0x2
    35bc:	608080e7          	jalr	1544(ra) # 5bc0 <exit>

00000000000035c0 <dirtest>:
{
    35c0:	1101                	addi	sp,sp,-32
    35c2:	ec06                	sd	ra,24(sp)
    35c4:	e822                	sd	s0,16(sp)
    35c6:	e426                	sd	s1,8(sp)
    35c8:	1000                	addi	s0,sp,32
    35ca:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    35cc:	00004517          	auipc	a0,0x4
    35d0:	e3c50513          	addi	a0,a0,-452 # 7408 <malloc+0x1416>
    35d4:	00002097          	auipc	ra,0x2
    35d8:	654080e7          	jalr	1620(ra) # 5c28 <mkdir>
    35dc:	04054563          	bltz	a0,3626 <dirtest+0x66>
  if(chdir("dir0") < 0){
    35e0:	00004517          	auipc	a0,0x4
    35e4:	e2850513          	addi	a0,a0,-472 # 7408 <malloc+0x1416>
    35e8:	00002097          	auipc	ra,0x2
    35ec:	648080e7          	jalr	1608(ra) # 5c30 <chdir>
    35f0:	04054963          	bltz	a0,3642 <dirtest+0x82>
  if(chdir("..") < 0){
    35f4:	00004517          	auipc	a0,0x4
    35f8:	e3450513          	addi	a0,a0,-460 # 7428 <malloc+0x1436>
    35fc:	00002097          	auipc	ra,0x2
    3600:	634080e7          	jalr	1588(ra) # 5c30 <chdir>
    3604:	04054d63          	bltz	a0,365e <dirtest+0x9e>
  if(unlink("dir0") < 0){
    3608:	00004517          	auipc	a0,0x4
    360c:	e0050513          	addi	a0,a0,-512 # 7408 <malloc+0x1416>
    3610:	00002097          	auipc	ra,0x2
    3614:	600080e7          	jalr	1536(ra) # 5c10 <unlink>
    3618:	06054163          	bltz	a0,367a <dirtest+0xba>
}
    361c:	60e2                	ld	ra,24(sp)
    361e:	6442                	ld	s0,16(sp)
    3620:	64a2                	ld	s1,8(sp)
    3622:	6105                	addi	sp,sp,32
    3624:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3626:	85a6                	mv	a1,s1
    3628:	00004517          	auipc	a0,0x4
    362c:	d4050513          	addi	a0,a0,-704 # 7368 <malloc+0x1376>
    3630:	00003097          	auipc	ra,0x3
    3634:	90a080e7          	jalr	-1782(ra) # 5f3a <printf>
    exit(1);
    3638:	4505                	li	a0,1
    363a:	00002097          	auipc	ra,0x2
    363e:	586080e7          	jalr	1414(ra) # 5bc0 <exit>
    printf("%s: chdir dir0 failed\n", s);
    3642:	85a6                	mv	a1,s1
    3644:	00004517          	auipc	a0,0x4
    3648:	dcc50513          	addi	a0,a0,-564 # 7410 <malloc+0x141e>
    364c:	00003097          	auipc	ra,0x3
    3650:	8ee080e7          	jalr	-1810(ra) # 5f3a <printf>
    exit(1);
    3654:	4505                	li	a0,1
    3656:	00002097          	auipc	ra,0x2
    365a:	56a080e7          	jalr	1386(ra) # 5bc0 <exit>
    printf("%s: chdir .. failed\n", s);
    365e:	85a6                	mv	a1,s1
    3660:	00004517          	auipc	a0,0x4
    3664:	dd050513          	addi	a0,a0,-560 # 7430 <malloc+0x143e>
    3668:	00003097          	auipc	ra,0x3
    366c:	8d2080e7          	jalr	-1838(ra) # 5f3a <printf>
    exit(1);
    3670:	4505                	li	a0,1
    3672:	00002097          	auipc	ra,0x2
    3676:	54e080e7          	jalr	1358(ra) # 5bc0 <exit>
    printf("%s: unlink dir0 failed\n", s);
    367a:	85a6                	mv	a1,s1
    367c:	00004517          	auipc	a0,0x4
    3680:	dcc50513          	addi	a0,a0,-564 # 7448 <malloc+0x1456>
    3684:	00003097          	auipc	ra,0x3
    3688:	8b6080e7          	jalr	-1866(ra) # 5f3a <printf>
    exit(1);
    368c:	4505                	li	a0,1
    368e:	00002097          	auipc	ra,0x2
    3692:	532080e7          	jalr	1330(ra) # 5bc0 <exit>

0000000000003696 <subdir>:
{
    3696:	1101                	addi	sp,sp,-32
    3698:	ec06                	sd	ra,24(sp)
    369a:	e822                	sd	s0,16(sp)
    369c:	e426                	sd	s1,8(sp)
    369e:	e04a                	sd	s2,0(sp)
    36a0:	1000                	addi	s0,sp,32
    36a2:	892a                	mv	s2,a0
  unlink("ff");
    36a4:	00004517          	auipc	a0,0x4
    36a8:	eec50513          	addi	a0,a0,-276 # 7590 <malloc+0x159e>
    36ac:	00002097          	auipc	ra,0x2
    36b0:	564080e7          	jalr	1380(ra) # 5c10 <unlink>
  if(mkdir("dd") != 0){
    36b4:	00004517          	auipc	a0,0x4
    36b8:	dac50513          	addi	a0,a0,-596 # 7460 <malloc+0x146e>
    36bc:	00002097          	auipc	ra,0x2
    36c0:	56c080e7          	jalr	1388(ra) # 5c28 <mkdir>
    36c4:	38051663          	bnez	a0,3a50 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    36c8:	20200593          	li	a1,514
    36cc:	00004517          	auipc	a0,0x4
    36d0:	db450513          	addi	a0,a0,-588 # 7480 <malloc+0x148e>
    36d4:	00002097          	auipc	ra,0x2
    36d8:	52c080e7          	jalr	1324(ra) # 5c00 <open>
    36dc:	84aa                	mv	s1,a0
  if(fd < 0){
    36de:	38054763          	bltz	a0,3a6c <subdir+0x3d6>
  write(fd, "ff", 2);
    36e2:	4609                	li	a2,2
    36e4:	00004597          	auipc	a1,0x4
    36e8:	eac58593          	addi	a1,a1,-340 # 7590 <malloc+0x159e>
    36ec:	00002097          	auipc	ra,0x2
    36f0:	4f4080e7          	jalr	1268(ra) # 5be0 <write>
  close(fd);
    36f4:	8526                	mv	a0,s1
    36f6:	00002097          	auipc	ra,0x2
    36fa:	4f2080e7          	jalr	1266(ra) # 5be8 <close>
  if(unlink("dd") >= 0){
    36fe:	00004517          	auipc	a0,0x4
    3702:	d6250513          	addi	a0,a0,-670 # 7460 <malloc+0x146e>
    3706:	00002097          	auipc	ra,0x2
    370a:	50a080e7          	jalr	1290(ra) # 5c10 <unlink>
    370e:	36055d63          	bgez	a0,3a88 <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    3712:	00004517          	auipc	a0,0x4
    3716:	dc650513          	addi	a0,a0,-570 # 74d8 <malloc+0x14e6>
    371a:	00002097          	auipc	ra,0x2
    371e:	50e080e7          	jalr	1294(ra) # 5c28 <mkdir>
    3722:	38051163          	bnez	a0,3aa4 <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3726:	20200593          	li	a1,514
    372a:	00004517          	auipc	a0,0x4
    372e:	dd650513          	addi	a0,a0,-554 # 7500 <malloc+0x150e>
    3732:	00002097          	auipc	ra,0x2
    3736:	4ce080e7          	jalr	1230(ra) # 5c00 <open>
    373a:	84aa                	mv	s1,a0
  if(fd < 0){
    373c:	38054263          	bltz	a0,3ac0 <subdir+0x42a>
  write(fd, "FF", 2);
    3740:	4609                	li	a2,2
    3742:	00004597          	auipc	a1,0x4
    3746:	dee58593          	addi	a1,a1,-530 # 7530 <malloc+0x153e>
    374a:	00002097          	auipc	ra,0x2
    374e:	496080e7          	jalr	1174(ra) # 5be0 <write>
  close(fd);
    3752:	8526                	mv	a0,s1
    3754:	00002097          	auipc	ra,0x2
    3758:	494080e7          	jalr	1172(ra) # 5be8 <close>
  fd = open("dd/dd/../ff", 0);
    375c:	4581                	li	a1,0
    375e:	00004517          	auipc	a0,0x4
    3762:	dda50513          	addi	a0,a0,-550 # 7538 <malloc+0x1546>
    3766:	00002097          	auipc	ra,0x2
    376a:	49a080e7          	jalr	1178(ra) # 5c00 <open>
    376e:	84aa                	mv	s1,a0
  if(fd < 0){
    3770:	36054663          	bltz	a0,3adc <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    3774:	660d                	lui	a2,0x3
    3776:	00009597          	auipc	a1,0x9
    377a:	50258593          	addi	a1,a1,1282 # cc78 <buf>
    377e:	00002097          	auipc	ra,0x2
    3782:	45a080e7          	jalr	1114(ra) # 5bd8 <read>
  if(cc != 2 || buf[0] != 'f'){
    3786:	4789                	li	a5,2
    3788:	36f51863          	bne	a0,a5,3af8 <subdir+0x462>
    378c:	00009717          	auipc	a4,0x9
    3790:	4ec74703          	lbu	a4,1260(a4) # cc78 <buf>
    3794:	06600793          	li	a5,102
    3798:	36f71063          	bne	a4,a5,3af8 <subdir+0x462>
  close(fd);
    379c:	8526                	mv	a0,s1
    379e:	00002097          	auipc	ra,0x2
    37a2:	44a080e7          	jalr	1098(ra) # 5be8 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    37a6:	00004597          	auipc	a1,0x4
    37aa:	de258593          	addi	a1,a1,-542 # 7588 <malloc+0x1596>
    37ae:	00004517          	auipc	a0,0x4
    37b2:	d5250513          	addi	a0,a0,-686 # 7500 <malloc+0x150e>
    37b6:	00002097          	auipc	ra,0x2
    37ba:	46a080e7          	jalr	1130(ra) # 5c20 <link>
    37be:	34051b63          	bnez	a0,3b14 <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    37c2:	00004517          	auipc	a0,0x4
    37c6:	d3e50513          	addi	a0,a0,-706 # 7500 <malloc+0x150e>
    37ca:	00002097          	auipc	ra,0x2
    37ce:	446080e7          	jalr	1094(ra) # 5c10 <unlink>
    37d2:	34051f63          	bnez	a0,3b30 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    37d6:	4581                	li	a1,0
    37d8:	00004517          	auipc	a0,0x4
    37dc:	d2850513          	addi	a0,a0,-728 # 7500 <malloc+0x150e>
    37e0:	00002097          	auipc	ra,0x2
    37e4:	420080e7          	jalr	1056(ra) # 5c00 <open>
    37e8:	36055263          	bgez	a0,3b4c <subdir+0x4b6>
  if(chdir("dd") != 0){
    37ec:	00004517          	auipc	a0,0x4
    37f0:	c7450513          	addi	a0,a0,-908 # 7460 <malloc+0x146e>
    37f4:	00002097          	auipc	ra,0x2
    37f8:	43c080e7          	jalr	1084(ra) # 5c30 <chdir>
    37fc:	36051663          	bnez	a0,3b68 <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    3800:	00004517          	auipc	a0,0x4
    3804:	e2050513          	addi	a0,a0,-480 # 7620 <malloc+0x162e>
    3808:	00002097          	auipc	ra,0x2
    380c:	428080e7          	jalr	1064(ra) # 5c30 <chdir>
    3810:	36051a63          	bnez	a0,3b84 <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    3814:	00004517          	auipc	a0,0x4
    3818:	e3c50513          	addi	a0,a0,-452 # 7650 <malloc+0x165e>
    381c:	00002097          	auipc	ra,0x2
    3820:	414080e7          	jalr	1044(ra) # 5c30 <chdir>
    3824:	36051e63          	bnez	a0,3ba0 <subdir+0x50a>
  if(chdir("./..") != 0){
    3828:	00004517          	auipc	a0,0x4
    382c:	e5850513          	addi	a0,a0,-424 # 7680 <malloc+0x168e>
    3830:	00002097          	auipc	ra,0x2
    3834:	400080e7          	jalr	1024(ra) # 5c30 <chdir>
    3838:	38051263          	bnez	a0,3bbc <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    383c:	4581                	li	a1,0
    383e:	00004517          	auipc	a0,0x4
    3842:	d4a50513          	addi	a0,a0,-694 # 7588 <malloc+0x1596>
    3846:	00002097          	auipc	ra,0x2
    384a:	3ba080e7          	jalr	954(ra) # 5c00 <open>
    384e:	84aa                	mv	s1,a0
  if(fd < 0){
    3850:	38054463          	bltz	a0,3bd8 <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    3854:	660d                	lui	a2,0x3
    3856:	00009597          	auipc	a1,0x9
    385a:	42258593          	addi	a1,a1,1058 # cc78 <buf>
    385e:	00002097          	auipc	ra,0x2
    3862:	37a080e7          	jalr	890(ra) # 5bd8 <read>
    3866:	4789                	li	a5,2
    3868:	38f51663          	bne	a0,a5,3bf4 <subdir+0x55e>
  close(fd);
    386c:	8526                	mv	a0,s1
    386e:	00002097          	auipc	ra,0x2
    3872:	37a080e7          	jalr	890(ra) # 5be8 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3876:	4581                	li	a1,0
    3878:	00004517          	auipc	a0,0x4
    387c:	c8850513          	addi	a0,a0,-888 # 7500 <malloc+0x150e>
    3880:	00002097          	auipc	ra,0x2
    3884:	380080e7          	jalr	896(ra) # 5c00 <open>
    3888:	38055463          	bgez	a0,3c10 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    388c:	20200593          	li	a1,514
    3890:	00004517          	auipc	a0,0x4
    3894:	e8050513          	addi	a0,a0,-384 # 7710 <malloc+0x171e>
    3898:	00002097          	auipc	ra,0x2
    389c:	368080e7          	jalr	872(ra) # 5c00 <open>
    38a0:	38055663          	bgez	a0,3c2c <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    38a4:	20200593          	li	a1,514
    38a8:	00004517          	auipc	a0,0x4
    38ac:	e9850513          	addi	a0,a0,-360 # 7740 <malloc+0x174e>
    38b0:	00002097          	auipc	ra,0x2
    38b4:	350080e7          	jalr	848(ra) # 5c00 <open>
    38b8:	38055863          	bgez	a0,3c48 <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    38bc:	20000593          	li	a1,512
    38c0:	00004517          	auipc	a0,0x4
    38c4:	ba050513          	addi	a0,a0,-1120 # 7460 <malloc+0x146e>
    38c8:	00002097          	auipc	ra,0x2
    38cc:	338080e7          	jalr	824(ra) # 5c00 <open>
    38d0:	38055a63          	bgez	a0,3c64 <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    38d4:	4589                	li	a1,2
    38d6:	00004517          	auipc	a0,0x4
    38da:	b8a50513          	addi	a0,a0,-1142 # 7460 <malloc+0x146e>
    38de:	00002097          	auipc	ra,0x2
    38e2:	322080e7          	jalr	802(ra) # 5c00 <open>
    38e6:	38055d63          	bgez	a0,3c80 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    38ea:	4585                	li	a1,1
    38ec:	00004517          	auipc	a0,0x4
    38f0:	b7450513          	addi	a0,a0,-1164 # 7460 <malloc+0x146e>
    38f4:	00002097          	auipc	ra,0x2
    38f8:	30c080e7          	jalr	780(ra) # 5c00 <open>
    38fc:	3a055063          	bgez	a0,3c9c <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3900:	00004597          	auipc	a1,0x4
    3904:	ed058593          	addi	a1,a1,-304 # 77d0 <malloc+0x17de>
    3908:	00004517          	auipc	a0,0x4
    390c:	e0850513          	addi	a0,a0,-504 # 7710 <malloc+0x171e>
    3910:	00002097          	auipc	ra,0x2
    3914:	310080e7          	jalr	784(ra) # 5c20 <link>
    3918:	3a050063          	beqz	a0,3cb8 <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    391c:	00004597          	auipc	a1,0x4
    3920:	eb458593          	addi	a1,a1,-332 # 77d0 <malloc+0x17de>
    3924:	00004517          	auipc	a0,0x4
    3928:	e1c50513          	addi	a0,a0,-484 # 7740 <malloc+0x174e>
    392c:	00002097          	auipc	ra,0x2
    3930:	2f4080e7          	jalr	756(ra) # 5c20 <link>
    3934:	3a050063          	beqz	a0,3cd4 <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    3938:	00004597          	auipc	a1,0x4
    393c:	c5058593          	addi	a1,a1,-944 # 7588 <malloc+0x1596>
    3940:	00004517          	auipc	a0,0x4
    3944:	b4050513          	addi	a0,a0,-1216 # 7480 <malloc+0x148e>
    3948:	00002097          	auipc	ra,0x2
    394c:	2d8080e7          	jalr	728(ra) # 5c20 <link>
    3950:	3a050063          	beqz	a0,3cf0 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    3954:	00004517          	auipc	a0,0x4
    3958:	dbc50513          	addi	a0,a0,-580 # 7710 <malloc+0x171e>
    395c:	00002097          	auipc	ra,0x2
    3960:	2cc080e7          	jalr	716(ra) # 5c28 <mkdir>
    3964:	3a050463          	beqz	a0,3d0c <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    3968:	00004517          	auipc	a0,0x4
    396c:	dd850513          	addi	a0,a0,-552 # 7740 <malloc+0x174e>
    3970:	00002097          	auipc	ra,0x2
    3974:	2b8080e7          	jalr	696(ra) # 5c28 <mkdir>
    3978:	3a050863          	beqz	a0,3d28 <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    397c:	00004517          	auipc	a0,0x4
    3980:	c0c50513          	addi	a0,a0,-1012 # 7588 <malloc+0x1596>
    3984:	00002097          	auipc	ra,0x2
    3988:	2a4080e7          	jalr	676(ra) # 5c28 <mkdir>
    398c:	3a050c63          	beqz	a0,3d44 <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    3990:	00004517          	auipc	a0,0x4
    3994:	db050513          	addi	a0,a0,-592 # 7740 <malloc+0x174e>
    3998:	00002097          	auipc	ra,0x2
    399c:	278080e7          	jalr	632(ra) # 5c10 <unlink>
    39a0:	3c050063          	beqz	a0,3d60 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    39a4:	00004517          	auipc	a0,0x4
    39a8:	d6c50513          	addi	a0,a0,-660 # 7710 <malloc+0x171e>
    39ac:	00002097          	auipc	ra,0x2
    39b0:	264080e7          	jalr	612(ra) # 5c10 <unlink>
    39b4:	3c050463          	beqz	a0,3d7c <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    39b8:	00004517          	auipc	a0,0x4
    39bc:	ac850513          	addi	a0,a0,-1336 # 7480 <malloc+0x148e>
    39c0:	00002097          	auipc	ra,0x2
    39c4:	270080e7          	jalr	624(ra) # 5c30 <chdir>
    39c8:	3c050863          	beqz	a0,3d98 <subdir+0x702>
  if(chdir("dd/xx") == 0){
    39cc:	00004517          	auipc	a0,0x4
    39d0:	f5450513          	addi	a0,a0,-172 # 7920 <malloc+0x192e>
    39d4:	00002097          	auipc	ra,0x2
    39d8:	25c080e7          	jalr	604(ra) # 5c30 <chdir>
    39dc:	3c050c63          	beqz	a0,3db4 <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    39e0:	00004517          	auipc	a0,0x4
    39e4:	ba850513          	addi	a0,a0,-1112 # 7588 <malloc+0x1596>
    39e8:	00002097          	auipc	ra,0x2
    39ec:	228080e7          	jalr	552(ra) # 5c10 <unlink>
    39f0:	3e051063          	bnez	a0,3dd0 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    39f4:	00004517          	auipc	a0,0x4
    39f8:	a8c50513          	addi	a0,a0,-1396 # 7480 <malloc+0x148e>
    39fc:	00002097          	auipc	ra,0x2
    3a00:	214080e7          	jalr	532(ra) # 5c10 <unlink>
    3a04:	3e051463          	bnez	a0,3dec <subdir+0x756>
  if(unlink("dd") == 0){
    3a08:	00004517          	auipc	a0,0x4
    3a0c:	a5850513          	addi	a0,a0,-1448 # 7460 <malloc+0x146e>
    3a10:	00002097          	auipc	ra,0x2
    3a14:	200080e7          	jalr	512(ra) # 5c10 <unlink>
    3a18:	3e050863          	beqz	a0,3e08 <subdir+0x772>
  if(unlink("dd/dd") < 0){
    3a1c:	00004517          	auipc	a0,0x4
    3a20:	f7450513          	addi	a0,a0,-140 # 7990 <malloc+0x199e>
    3a24:	00002097          	auipc	ra,0x2
    3a28:	1ec080e7          	jalr	492(ra) # 5c10 <unlink>
    3a2c:	3e054c63          	bltz	a0,3e24 <subdir+0x78e>
  if(unlink("dd") < 0){
    3a30:	00004517          	auipc	a0,0x4
    3a34:	a3050513          	addi	a0,a0,-1488 # 7460 <malloc+0x146e>
    3a38:	00002097          	auipc	ra,0x2
    3a3c:	1d8080e7          	jalr	472(ra) # 5c10 <unlink>
    3a40:	40054063          	bltz	a0,3e40 <subdir+0x7aa>
}
    3a44:	60e2                	ld	ra,24(sp)
    3a46:	6442                	ld	s0,16(sp)
    3a48:	64a2                	ld	s1,8(sp)
    3a4a:	6902                	ld	s2,0(sp)
    3a4c:	6105                	addi	sp,sp,32
    3a4e:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3a50:	85ca                	mv	a1,s2
    3a52:	00004517          	auipc	a0,0x4
    3a56:	a1650513          	addi	a0,a0,-1514 # 7468 <malloc+0x1476>
    3a5a:	00002097          	auipc	ra,0x2
    3a5e:	4e0080e7          	jalr	1248(ra) # 5f3a <printf>
    exit(1);
    3a62:	4505                	li	a0,1
    3a64:	00002097          	auipc	ra,0x2
    3a68:	15c080e7          	jalr	348(ra) # 5bc0 <exit>
    printf("%s: create dd/ff failed\n", s);
    3a6c:	85ca                	mv	a1,s2
    3a6e:	00004517          	auipc	a0,0x4
    3a72:	a1a50513          	addi	a0,a0,-1510 # 7488 <malloc+0x1496>
    3a76:	00002097          	auipc	ra,0x2
    3a7a:	4c4080e7          	jalr	1220(ra) # 5f3a <printf>
    exit(1);
    3a7e:	4505                	li	a0,1
    3a80:	00002097          	auipc	ra,0x2
    3a84:	140080e7          	jalr	320(ra) # 5bc0 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3a88:	85ca                	mv	a1,s2
    3a8a:	00004517          	auipc	a0,0x4
    3a8e:	a1e50513          	addi	a0,a0,-1506 # 74a8 <malloc+0x14b6>
    3a92:	00002097          	auipc	ra,0x2
    3a96:	4a8080e7          	jalr	1192(ra) # 5f3a <printf>
    exit(1);
    3a9a:	4505                	li	a0,1
    3a9c:	00002097          	auipc	ra,0x2
    3aa0:	124080e7          	jalr	292(ra) # 5bc0 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    3aa4:	85ca                	mv	a1,s2
    3aa6:	00004517          	auipc	a0,0x4
    3aaa:	a3a50513          	addi	a0,a0,-1478 # 74e0 <malloc+0x14ee>
    3aae:	00002097          	auipc	ra,0x2
    3ab2:	48c080e7          	jalr	1164(ra) # 5f3a <printf>
    exit(1);
    3ab6:	4505                	li	a0,1
    3ab8:	00002097          	auipc	ra,0x2
    3abc:	108080e7          	jalr	264(ra) # 5bc0 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3ac0:	85ca                	mv	a1,s2
    3ac2:	00004517          	auipc	a0,0x4
    3ac6:	a4e50513          	addi	a0,a0,-1458 # 7510 <malloc+0x151e>
    3aca:	00002097          	auipc	ra,0x2
    3ace:	470080e7          	jalr	1136(ra) # 5f3a <printf>
    exit(1);
    3ad2:	4505                	li	a0,1
    3ad4:	00002097          	auipc	ra,0x2
    3ad8:	0ec080e7          	jalr	236(ra) # 5bc0 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3adc:	85ca                	mv	a1,s2
    3ade:	00004517          	auipc	a0,0x4
    3ae2:	a6a50513          	addi	a0,a0,-1430 # 7548 <malloc+0x1556>
    3ae6:	00002097          	auipc	ra,0x2
    3aea:	454080e7          	jalr	1108(ra) # 5f3a <printf>
    exit(1);
    3aee:	4505                	li	a0,1
    3af0:	00002097          	auipc	ra,0x2
    3af4:	0d0080e7          	jalr	208(ra) # 5bc0 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3af8:	85ca                	mv	a1,s2
    3afa:	00004517          	auipc	a0,0x4
    3afe:	a6e50513          	addi	a0,a0,-1426 # 7568 <malloc+0x1576>
    3b02:	00002097          	auipc	ra,0x2
    3b06:	438080e7          	jalr	1080(ra) # 5f3a <printf>
    exit(1);
    3b0a:	4505                	li	a0,1
    3b0c:	00002097          	auipc	ra,0x2
    3b10:	0b4080e7          	jalr	180(ra) # 5bc0 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3b14:	85ca                	mv	a1,s2
    3b16:	00004517          	auipc	a0,0x4
    3b1a:	a8250513          	addi	a0,a0,-1406 # 7598 <malloc+0x15a6>
    3b1e:	00002097          	auipc	ra,0x2
    3b22:	41c080e7          	jalr	1052(ra) # 5f3a <printf>
    exit(1);
    3b26:	4505                	li	a0,1
    3b28:	00002097          	auipc	ra,0x2
    3b2c:	098080e7          	jalr	152(ra) # 5bc0 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3b30:	85ca                	mv	a1,s2
    3b32:	00004517          	auipc	a0,0x4
    3b36:	a8e50513          	addi	a0,a0,-1394 # 75c0 <malloc+0x15ce>
    3b3a:	00002097          	auipc	ra,0x2
    3b3e:	400080e7          	jalr	1024(ra) # 5f3a <printf>
    exit(1);
    3b42:	4505                	li	a0,1
    3b44:	00002097          	auipc	ra,0x2
    3b48:	07c080e7          	jalr	124(ra) # 5bc0 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3b4c:	85ca                	mv	a1,s2
    3b4e:	00004517          	auipc	a0,0x4
    3b52:	a9250513          	addi	a0,a0,-1390 # 75e0 <malloc+0x15ee>
    3b56:	00002097          	auipc	ra,0x2
    3b5a:	3e4080e7          	jalr	996(ra) # 5f3a <printf>
    exit(1);
    3b5e:	4505                	li	a0,1
    3b60:	00002097          	auipc	ra,0x2
    3b64:	060080e7          	jalr	96(ra) # 5bc0 <exit>
    printf("%s: chdir dd failed\n", s);
    3b68:	85ca                	mv	a1,s2
    3b6a:	00004517          	auipc	a0,0x4
    3b6e:	a9e50513          	addi	a0,a0,-1378 # 7608 <malloc+0x1616>
    3b72:	00002097          	auipc	ra,0x2
    3b76:	3c8080e7          	jalr	968(ra) # 5f3a <printf>
    exit(1);
    3b7a:	4505                	li	a0,1
    3b7c:	00002097          	auipc	ra,0x2
    3b80:	044080e7          	jalr	68(ra) # 5bc0 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    3b84:	85ca                	mv	a1,s2
    3b86:	00004517          	auipc	a0,0x4
    3b8a:	aaa50513          	addi	a0,a0,-1366 # 7630 <malloc+0x163e>
    3b8e:	00002097          	auipc	ra,0x2
    3b92:	3ac080e7          	jalr	940(ra) # 5f3a <printf>
    exit(1);
    3b96:	4505                	li	a0,1
    3b98:	00002097          	auipc	ra,0x2
    3b9c:	028080e7          	jalr	40(ra) # 5bc0 <exit>
    printf("chdir dd/../../dd failed\n", s);
    3ba0:	85ca                	mv	a1,s2
    3ba2:	00004517          	auipc	a0,0x4
    3ba6:	abe50513          	addi	a0,a0,-1346 # 7660 <malloc+0x166e>
    3baa:	00002097          	auipc	ra,0x2
    3bae:	390080e7          	jalr	912(ra) # 5f3a <printf>
    exit(1);
    3bb2:	4505                	li	a0,1
    3bb4:	00002097          	auipc	ra,0x2
    3bb8:	00c080e7          	jalr	12(ra) # 5bc0 <exit>
    printf("%s: chdir ./.. failed\n", s);
    3bbc:	85ca                	mv	a1,s2
    3bbe:	00004517          	auipc	a0,0x4
    3bc2:	aca50513          	addi	a0,a0,-1334 # 7688 <malloc+0x1696>
    3bc6:	00002097          	auipc	ra,0x2
    3bca:	374080e7          	jalr	884(ra) # 5f3a <printf>
    exit(1);
    3bce:	4505                	li	a0,1
    3bd0:	00002097          	auipc	ra,0x2
    3bd4:	ff0080e7          	jalr	-16(ra) # 5bc0 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    3bd8:	85ca                	mv	a1,s2
    3bda:	00004517          	auipc	a0,0x4
    3bde:	ac650513          	addi	a0,a0,-1338 # 76a0 <malloc+0x16ae>
    3be2:	00002097          	auipc	ra,0x2
    3be6:	358080e7          	jalr	856(ra) # 5f3a <printf>
    exit(1);
    3bea:	4505                	li	a0,1
    3bec:	00002097          	auipc	ra,0x2
    3bf0:	fd4080e7          	jalr	-44(ra) # 5bc0 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3bf4:	85ca                	mv	a1,s2
    3bf6:	00004517          	auipc	a0,0x4
    3bfa:	aca50513          	addi	a0,a0,-1334 # 76c0 <malloc+0x16ce>
    3bfe:	00002097          	auipc	ra,0x2
    3c02:	33c080e7          	jalr	828(ra) # 5f3a <printf>
    exit(1);
    3c06:	4505                	li	a0,1
    3c08:	00002097          	auipc	ra,0x2
    3c0c:	fb8080e7          	jalr	-72(ra) # 5bc0 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3c10:	85ca                	mv	a1,s2
    3c12:	00004517          	auipc	a0,0x4
    3c16:	ace50513          	addi	a0,a0,-1330 # 76e0 <malloc+0x16ee>
    3c1a:	00002097          	auipc	ra,0x2
    3c1e:	320080e7          	jalr	800(ra) # 5f3a <printf>
    exit(1);
    3c22:	4505                	li	a0,1
    3c24:	00002097          	auipc	ra,0x2
    3c28:	f9c080e7          	jalr	-100(ra) # 5bc0 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3c2c:	85ca                	mv	a1,s2
    3c2e:	00004517          	auipc	a0,0x4
    3c32:	af250513          	addi	a0,a0,-1294 # 7720 <malloc+0x172e>
    3c36:	00002097          	auipc	ra,0x2
    3c3a:	304080e7          	jalr	772(ra) # 5f3a <printf>
    exit(1);
    3c3e:	4505                	li	a0,1
    3c40:	00002097          	auipc	ra,0x2
    3c44:	f80080e7          	jalr	-128(ra) # 5bc0 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3c48:	85ca                	mv	a1,s2
    3c4a:	00004517          	auipc	a0,0x4
    3c4e:	b0650513          	addi	a0,a0,-1274 # 7750 <malloc+0x175e>
    3c52:	00002097          	auipc	ra,0x2
    3c56:	2e8080e7          	jalr	744(ra) # 5f3a <printf>
    exit(1);
    3c5a:	4505                	li	a0,1
    3c5c:	00002097          	auipc	ra,0x2
    3c60:	f64080e7          	jalr	-156(ra) # 5bc0 <exit>
    printf("%s: create dd succeeded!\n", s);
    3c64:	85ca                	mv	a1,s2
    3c66:	00004517          	auipc	a0,0x4
    3c6a:	b0a50513          	addi	a0,a0,-1270 # 7770 <malloc+0x177e>
    3c6e:	00002097          	auipc	ra,0x2
    3c72:	2cc080e7          	jalr	716(ra) # 5f3a <printf>
    exit(1);
    3c76:	4505                	li	a0,1
    3c78:	00002097          	auipc	ra,0x2
    3c7c:	f48080e7          	jalr	-184(ra) # 5bc0 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3c80:	85ca                	mv	a1,s2
    3c82:	00004517          	auipc	a0,0x4
    3c86:	b0e50513          	addi	a0,a0,-1266 # 7790 <malloc+0x179e>
    3c8a:	00002097          	auipc	ra,0x2
    3c8e:	2b0080e7          	jalr	688(ra) # 5f3a <printf>
    exit(1);
    3c92:	4505                	li	a0,1
    3c94:	00002097          	auipc	ra,0x2
    3c98:	f2c080e7          	jalr	-212(ra) # 5bc0 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3c9c:	85ca                	mv	a1,s2
    3c9e:	00004517          	auipc	a0,0x4
    3ca2:	b1250513          	addi	a0,a0,-1262 # 77b0 <malloc+0x17be>
    3ca6:	00002097          	auipc	ra,0x2
    3caa:	294080e7          	jalr	660(ra) # 5f3a <printf>
    exit(1);
    3cae:	4505                	li	a0,1
    3cb0:	00002097          	auipc	ra,0x2
    3cb4:	f10080e7          	jalr	-240(ra) # 5bc0 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3cb8:	85ca                	mv	a1,s2
    3cba:	00004517          	auipc	a0,0x4
    3cbe:	b2650513          	addi	a0,a0,-1242 # 77e0 <malloc+0x17ee>
    3cc2:	00002097          	auipc	ra,0x2
    3cc6:	278080e7          	jalr	632(ra) # 5f3a <printf>
    exit(1);
    3cca:	4505                	li	a0,1
    3ccc:	00002097          	auipc	ra,0x2
    3cd0:	ef4080e7          	jalr	-268(ra) # 5bc0 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3cd4:	85ca                	mv	a1,s2
    3cd6:	00004517          	auipc	a0,0x4
    3cda:	b3250513          	addi	a0,a0,-1230 # 7808 <malloc+0x1816>
    3cde:	00002097          	auipc	ra,0x2
    3ce2:	25c080e7          	jalr	604(ra) # 5f3a <printf>
    exit(1);
    3ce6:	4505                	li	a0,1
    3ce8:	00002097          	auipc	ra,0x2
    3cec:	ed8080e7          	jalr	-296(ra) # 5bc0 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3cf0:	85ca                	mv	a1,s2
    3cf2:	00004517          	auipc	a0,0x4
    3cf6:	b3e50513          	addi	a0,a0,-1218 # 7830 <malloc+0x183e>
    3cfa:	00002097          	auipc	ra,0x2
    3cfe:	240080e7          	jalr	576(ra) # 5f3a <printf>
    exit(1);
    3d02:	4505                	li	a0,1
    3d04:	00002097          	auipc	ra,0x2
    3d08:	ebc080e7          	jalr	-324(ra) # 5bc0 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3d0c:	85ca                	mv	a1,s2
    3d0e:	00004517          	auipc	a0,0x4
    3d12:	b4a50513          	addi	a0,a0,-1206 # 7858 <malloc+0x1866>
    3d16:	00002097          	auipc	ra,0x2
    3d1a:	224080e7          	jalr	548(ra) # 5f3a <printf>
    exit(1);
    3d1e:	4505                	li	a0,1
    3d20:	00002097          	auipc	ra,0x2
    3d24:	ea0080e7          	jalr	-352(ra) # 5bc0 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3d28:	85ca                	mv	a1,s2
    3d2a:	00004517          	auipc	a0,0x4
    3d2e:	b4e50513          	addi	a0,a0,-1202 # 7878 <malloc+0x1886>
    3d32:	00002097          	auipc	ra,0x2
    3d36:	208080e7          	jalr	520(ra) # 5f3a <printf>
    exit(1);
    3d3a:	4505                	li	a0,1
    3d3c:	00002097          	auipc	ra,0x2
    3d40:	e84080e7          	jalr	-380(ra) # 5bc0 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3d44:	85ca                	mv	a1,s2
    3d46:	00004517          	auipc	a0,0x4
    3d4a:	b5250513          	addi	a0,a0,-1198 # 7898 <malloc+0x18a6>
    3d4e:	00002097          	auipc	ra,0x2
    3d52:	1ec080e7          	jalr	492(ra) # 5f3a <printf>
    exit(1);
    3d56:	4505                	li	a0,1
    3d58:	00002097          	auipc	ra,0x2
    3d5c:	e68080e7          	jalr	-408(ra) # 5bc0 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3d60:	85ca                	mv	a1,s2
    3d62:	00004517          	auipc	a0,0x4
    3d66:	b5e50513          	addi	a0,a0,-1186 # 78c0 <malloc+0x18ce>
    3d6a:	00002097          	auipc	ra,0x2
    3d6e:	1d0080e7          	jalr	464(ra) # 5f3a <printf>
    exit(1);
    3d72:	4505                	li	a0,1
    3d74:	00002097          	auipc	ra,0x2
    3d78:	e4c080e7          	jalr	-436(ra) # 5bc0 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3d7c:	85ca                	mv	a1,s2
    3d7e:	00004517          	auipc	a0,0x4
    3d82:	b6250513          	addi	a0,a0,-1182 # 78e0 <malloc+0x18ee>
    3d86:	00002097          	auipc	ra,0x2
    3d8a:	1b4080e7          	jalr	436(ra) # 5f3a <printf>
    exit(1);
    3d8e:	4505                	li	a0,1
    3d90:	00002097          	auipc	ra,0x2
    3d94:	e30080e7          	jalr	-464(ra) # 5bc0 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3d98:	85ca                	mv	a1,s2
    3d9a:	00004517          	auipc	a0,0x4
    3d9e:	b6650513          	addi	a0,a0,-1178 # 7900 <malloc+0x190e>
    3da2:	00002097          	auipc	ra,0x2
    3da6:	198080e7          	jalr	408(ra) # 5f3a <printf>
    exit(1);
    3daa:	4505                	li	a0,1
    3dac:	00002097          	auipc	ra,0x2
    3db0:	e14080e7          	jalr	-492(ra) # 5bc0 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3db4:	85ca                	mv	a1,s2
    3db6:	00004517          	auipc	a0,0x4
    3dba:	b7250513          	addi	a0,a0,-1166 # 7928 <malloc+0x1936>
    3dbe:	00002097          	auipc	ra,0x2
    3dc2:	17c080e7          	jalr	380(ra) # 5f3a <printf>
    exit(1);
    3dc6:	4505                	li	a0,1
    3dc8:	00002097          	auipc	ra,0x2
    3dcc:	df8080e7          	jalr	-520(ra) # 5bc0 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3dd0:	85ca                	mv	a1,s2
    3dd2:	00003517          	auipc	a0,0x3
    3dd6:	7ee50513          	addi	a0,a0,2030 # 75c0 <malloc+0x15ce>
    3dda:	00002097          	auipc	ra,0x2
    3dde:	160080e7          	jalr	352(ra) # 5f3a <printf>
    exit(1);
    3de2:	4505                	li	a0,1
    3de4:	00002097          	auipc	ra,0x2
    3de8:	ddc080e7          	jalr	-548(ra) # 5bc0 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3dec:	85ca                	mv	a1,s2
    3dee:	00004517          	auipc	a0,0x4
    3df2:	b5a50513          	addi	a0,a0,-1190 # 7948 <malloc+0x1956>
    3df6:	00002097          	auipc	ra,0x2
    3dfa:	144080e7          	jalr	324(ra) # 5f3a <printf>
    exit(1);
    3dfe:	4505                	li	a0,1
    3e00:	00002097          	auipc	ra,0x2
    3e04:	dc0080e7          	jalr	-576(ra) # 5bc0 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3e08:	85ca                	mv	a1,s2
    3e0a:	00004517          	auipc	a0,0x4
    3e0e:	b5e50513          	addi	a0,a0,-1186 # 7968 <malloc+0x1976>
    3e12:	00002097          	auipc	ra,0x2
    3e16:	128080e7          	jalr	296(ra) # 5f3a <printf>
    exit(1);
    3e1a:	4505                	li	a0,1
    3e1c:	00002097          	auipc	ra,0x2
    3e20:	da4080e7          	jalr	-604(ra) # 5bc0 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3e24:	85ca                	mv	a1,s2
    3e26:	00004517          	auipc	a0,0x4
    3e2a:	b7250513          	addi	a0,a0,-1166 # 7998 <malloc+0x19a6>
    3e2e:	00002097          	auipc	ra,0x2
    3e32:	10c080e7          	jalr	268(ra) # 5f3a <printf>
    exit(1);
    3e36:	4505                	li	a0,1
    3e38:	00002097          	auipc	ra,0x2
    3e3c:	d88080e7          	jalr	-632(ra) # 5bc0 <exit>
    printf("%s: unlink dd failed\n", s);
    3e40:	85ca                	mv	a1,s2
    3e42:	00004517          	auipc	a0,0x4
    3e46:	b7650513          	addi	a0,a0,-1162 # 79b8 <malloc+0x19c6>
    3e4a:	00002097          	auipc	ra,0x2
    3e4e:	0f0080e7          	jalr	240(ra) # 5f3a <printf>
    exit(1);
    3e52:	4505                	li	a0,1
    3e54:	00002097          	auipc	ra,0x2
    3e58:	d6c080e7          	jalr	-660(ra) # 5bc0 <exit>

0000000000003e5c <rmdot>:
{
    3e5c:	1101                	addi	sp,sp,-32
    3e5e:	ec06                	sd	ra,24(sp)
    3e60:	e822                	sd	s0,16(sp)
    3e62:	e426                	sd	s1,8(sp)
    3e64:	1000                	addi	s0,sp,32
    3e66:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    3e68:	00004517          	auipc	a0,0x4
    3e6c:	b6850513          	addi	a0,a0,-1176 # 79d0 <malloc+0x19de>
    3e70:	00002097          	auipc	ra,0x2
    3e74:	db8080e7          	jalr	-584(ra) # 5c28 <mkdir>
    3e78:	e549                	bnez	a0,3f02 <rmdot+0xa6>
  if(chdir("dots") != 0){
    3e7a:	00004517          	auipc	a0,0x4
    3e7e:	b5650513          	addi	a0,a0,-1194 # 79d0 <malloc+0x19de>
    3e82:	00002097          	auipc	ra,0x2
    3e86:	dae080e7          	jalr	-594(ra) # 5c30 <chdir>
    3e8a:	e951                	bnez	a0,3f1e <rmdot+0xc2>
  if(unlink(".") == 0){
    3e8c:	00003517          	auipc	a0,0x3
    3e90:	97450513          	addi	a0,a0,-1676 # 6800 <malloc+0x80e>
    3e94:	00002097          	auipc	ra,0x2
    3e98:	d7c080e7          	jalr	-644(ra) # 5c10 <unlink>
    3e9c:	cd59                	beqz	a0,3f3a <rmdot+0xde>
  if(unlink("..") == 0){
    3e9e:	00003517          	auipc	a0,0x3
    3ea2:	58a50513          	addi	a0,a0,1418 # 7428 <malloc+0x1436>
    3ea6:	00002097          	auipc	ra,0x2
    3eaa:	d6a080e7          	jalr	-662(ra) # 5c10 <unlink>
    3eae:	c545                	beqz	a0,3f56 <rmdot+0xfa>
  if(chdir("/") != 0){
    3eb0:	00003517          	auipc	a0,0x3
    3eb4:	52050513          	addi	a0,a0,1312 # 73d0 <malloc+0x13de>
    3eb8:	00002097          	auipc	ra,0x2
    3ebc:	d78080e7          	jalr	-648(ra) # 5c30 <chdir>
    3ec0:	e94d                	bnez	a0,3f72 <rmdot+0x116>
  if(unlink("dots/.") == 0){
    3ec2:	00004517          	auipc	a0,0x4
    3ec6:	b7650513          	addi	a0,a0,-1162 # 7a38 <malloc+0x1a46>
    3eca:	00002097          	auipc	ra,0x2
    3ece:	d46080e7          	jalr	-698(ra) # 5c10 <unlink>
    3ed2:	cd55                	beqz	a0,3f8e <rmdot+0x132>
  if(unlink("dots/..") == 0){
    3ed4:	00004517          	auipc	a0,0x4
    3ed8:	b8c50513          	addi	a0,a0,-1140 # 7a60 <malloc+0x1a6e>
    3edc:	00002097          	auipc	ra,0x2
    3ee0:	d34080e7          	jalr	-716(ra) # 5c10 <unlink>
    3ee4:	c179                	beqz	a0,3faa <rmdot+0x14e>
  if(unlink("dots") != 0){
    3ee6:	00004517          	auipc	a0,0x4
    3eea:	aea50513          	addi	a0,a0,-1302 # 79d0 <malloc+0x19de>
    3eee:	00002097          	auipc	ra,0x2
    3ef2:	d22080e7          	jalr	-734(ra) # 5c10 <unlink>
    3ef6:	e961                	bnez	a0,3fc6 <rmdot+0x16a>
}
    3ef8:	60e2                	ld	ra,24(sp)
    3efa:	6442                	ld	s0,16(sp)
    3efc:	64a2                	ld	s1,8(sp)
    3efe:	6105                	addi	sp,sp,32
    3f00:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3f02:	85a6                	mv	a1,s1
    3f04:	00004517          	auipc	a0,0x4
    3f08:	ad450513          	addi	a0,a0,-1324 # 79d8 <malloc+0x19e6>
    3f0c:	00002097          	auipc	ra,0x2
    3f10:	02e080e7          	jalr	46(ra) # 5f3a <printf>
    exit(1);
    3f14:	4505                	li	a0,1
    3f16:	00002097          	auipc	ra,0x2
    3f1a:	caa080e7          	jalr	-854(ra) # 5bc0 <exit>
    printf("%s: chdir dots failed\n", s);
    3f1e:	85a6                	mv	a1,s1
    3f20:	00004517          	auipc	a0,0x4
    3f24:	ad050513          	addi	a0,a0,-1328 # 79f0 <malloc+0x19fe>
    3f28:	00002097          	auipc	ra,0x2
    3f2c:	012080e7          	jalr	18(ra) # 5f3a <printf>
    exit(1);
    3f30:	4505                	li	a0,1
    3f32:	00002097          	auipc	ra,0x2
    3f36:	c8e080e7          	jalr	-882(ra) # 5bc0 <exit>
    printf("%s: rm . worked!\n", s);
    3f3a:	85a6                	mv	a1,s1
    3f3c:	00004517          	auipc	a0,0x4
    3f40:	acc50513          	addi	a0,a0,-1332 # 7a08 <malloc+0x1a16>
    3f44:	00002097          	auipc	ra,0x2
    3f48:	ff6080e7          	jalr	-10(ra) # 5f3a <printf>
    exit(1);
    3f4c:	4505                	li	a0,1
    3f4e:	00002097          	auipc	ra,0x2
    3f52:	c72080e7          	jalr	-910(ra) # 5bc0 <exit>
    printf("%s: rm .. worked!\n", s);
    3f56:	85a6                	mv	a1,s1
    3f58:	00004517          	auipc	a0,0x4
    3f5c:	ac850513          	addi	a0,a0,-1336 # 7a20 <malloc+0x1a2e>
    3f60:	00002097          	auipc	ra,0x2
    3f64:	fda080e7          	jalr	-38(ra) # 5f3a <printf>
    exit(1);
    3f68:	4505                	li	a0,1
    3f6a:	00002097          	auipc	ra,0x2
    3f6e:	c56080e7          	jalr	-938(ra) # 5bc0 <exit>
    printf("%s: chdir / failed\n", s);
    3f72:	85a6                	mv	a1,s1
    3f74:	00003517          	auipc	a0,0x3
    3f78:	46450513          	addi	a0,a0,1124 # 73d8 <malloc+0x13e6>
    3f7c:	00002097          	auipc	ra,0x2
    3f80:	fbe080e7          	jalr	-66(ra) # 5f3a <printf>
    exit(1);
    3f84:	4505                	li	a0,1
    3f86:	00002097          	auipc	ra,0x2
    3f8a:	c3a080e7          	jalr	-966(ra) # 5bc0 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3f8e:	85a6                	mv	a1,s1
    3f90:	00004517          	auipc	a0,0x4
    3f94:	ab050513          	addi	a0,a0,-1360 # 7a40 <malloc+0x1a4e>
    3f98:	00002097          	auipc	ra,0x2
    3f9c:	fa2080e7          	jalr	-94(ra) # 5f3a <printf>
    exit(1);
    3fa0:	4505                	li	a0,1
    3fa2:	00002097          	auipc	ra,0x2
    3fa6:	c1e080e7          	jalr	-994(ra) # 5bc0 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3faa:	85a6                	mv	a1,s1
    3fac:	00004517          	auipc	a0,0x4
    3fb0:	abc50513          	addi	a0,a0,-1348 # 7a68 <malloc+0x1a76>
    3fb4:	00002097          	auipc	ra,0x2
    3fb8:	f86080e7          	jalr	-122(ra) # 5f3a <printf>
    exit(1);
    3fbc:	4505                	li	a0,1
    3fbe:	00002097          	auipc	ra,0x2
    3fc2:	c02080e7          	jalr	-1022(ra) # 5bc0 <exit>
    printf("%s: unlink dots failed!\n", s);
    3fc6:	85a6                	mv	a1,s1
    3fc8:	00004517          	auipc	a0,0x4
    3fcc:	ac050513          	addi	a0,a0,-1344 # 7a88 <malloc+0x1a96>
    3fd0:	00002097          	auipc	ra,0x2
    3fd4:	f6a080e7          	jalr	-150(ra) # 5f3a <printf>
    exit(1);
    3fd8:	4505                	li	a0,1
    3fda:	00002097          	auipc	ra,0x2
    3fde:	be6080e7          	jalr	-1050(ra) # 5bc0 <exit>

0000000000003fe2 <dirfile>:
{
    3fe2:	1101                	addi	sp,sp,-32
    3fe4:	ec06                	sd	ra,24(sp)
    3fe6:	e822                	sd	s0,16(sp)
    3fe8:	e426                	sd	s1,8(sp)
    3fea:	e04a                	sd	s2,0(sp)
    3fec:	1000                	addi	s0,sp,32
    3fee:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3ff0:	20000593          	li	a1,512
    3ff4:	00004517          	auipc	a0,0x4
    3ff8:	ab450513          	addi	a0,a0,-1356 # 7aa8 <malloc+0x1ab6>
    3ffc:	00002097          	auipc	ra,0x2
    4000:	c04080e7          	jalr	-1020(ra) # 5c00 <open>
  if(fd < 0){
    4004:	0e054d63          	bltz	a0,40fe <dirfile+0x11c>
  close(fd);
    4008:	00002097          	auipc	ra,0x2
    400c:	be0080e7          	jalr	-1056(ra) # 5be8 <close>
  if(chdir("dirfile") == 0){
    4010:	00004517          	auipc	a0,0x4
    4014:	a9850513          	addi	a0,a0,-1384 # 7aa8 <malloc+0x1ab6>
    4018:	00002097          	auipc	ra,0x2
    401c:	c18080e7          	jalr	-1000(ra) # 5c30 <chdir>
    4020:	cd6d                	beqz	a0,411a <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    4022:	4581                	li	a1,0
    4024:	00004517          	auipc	a0,0x4
    4028:	acc50513          	addi	a0,a0,-1332 # 7af0 <malloc+0x1afe>
    402c:	00002097          	auipc	ra,0x2
    4030:	bd4080e7          	jalr	-1068(ra) # 5c00 <open>
  if(fd >= 0){
    4034:	10055163          	bgez	a0,4136 <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    4038:	20000593          	li	a1,512
    403c:	00004517          	auipc	a0,0x4
    4040:	ab450513          	addi	a0,a0,-1356 # 7af0 <malloc+0x1afe>
    4044:	00002097          	auipc	ra,0x2
    4048:	bbc080e7          	jalr	-1092(ra) # 5c00 <open>
  if(fd >= 0){
    404c:	10055363          	bgez	a0,4152 <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    4050:	00004517          	auipc	a0,0x4
    4054:	aa050513          	addi	a0,a0,-1376 # 7af0 <malloc+0x1afe>
    4058:	00002097          	auipc	ra,0x2
    405c:	bd0080e7          	jalr	-1072(ra) # 5c28 <mkdir>
    4060:	10050763          	beqz	a0,416e <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    4064:	00004517          	auipc	a0,0x4
    4068:	a8c50513          	addi	a0,a0,-1396 # 7af0 <malloc+0x1afe>
    406c:	00002097          	auipc	ra,0x2
    4070:	ba4080e7          	jalr	-1116(ra) # 5c10 <unlink>
    4074:	10050b63          	beqz	a0,418a <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    4078:	00004597          	auipc	a1,0x4
    407c:	a7858593          	addi	a1,a1,-1416 # 7af0 <malloc+0x1afe>
    4080:	00002517          	auipc	a0,0x2
    4084:	27050513          	addi	a0,a0,624 # 62f0 <malloc+0x2fe>
    4088:	00002097          	auipc	ra,0x2
    408c:	b98080e7          	jalr	-1128(ra) # 5c20 <link>
    4090:	10050b63          	beqz	a0,41a6 <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    4094:	00004517          	auipc	a0,0x4
    4098:	a1450513          	addi	a0,a0,-1516 # 7aa8 <malloc+0x1ab6>
    409c:	00002097          	auipc	ra,0x2
    40a0:	b74080e7          	jalr	-1164(ra) # 5c10 <unlink>
    40a4:	10051f63          	bnez	a0,41c2 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    40a8:	4589                	li	a1,2
    40aa:	00002517          	auipc	a0,0x2
    40ae:	75650513          	addi	a0,a0,1878 # 6800 <malloc+0x80e>
    40b2:	00002097          	auipc	ra,0x2
    40b6:	b4e080e7          	jalr	-1202(ra) # 5c00 <open>
  if(fd >= 0){
    40ba:	12055263          	bgez	a0,41de <dirfile+0x1fc>
  fd = open(".", 0);
    40be:	4581                	li	a1,0
    40c0:	00002517          	auipc	a0,0x2
    40c4:	74050513          	addi	a0,a0,1856 # 6800 <malloc+0x80e>
    40c8:	00002097          	auipc	ra,0x2
    40cc:	b38080e7          	jalr	-1224(ra) # 5c00 <open>
    40d0:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    40d2:	4605                	li	a2,1
    40d4:	00002597          	auipc	a1,0x2
    40d8:	0b458593          	addi	a1,a1,180 # 6188 <malloc+0x196>
    40dc:	00002097          	auipc	ra,0x2
    40e0:	b04080e7          	jalr	-1276(ra) # 5be0 <write>
    40e4:	10a04b63          	bgtz	a0,41fa <dirfile+0x218>
  close(fd);
    40e8:	8526                	mv	a0,s1
    40ea:	00002097          	auipc	ra,0x2
    40ee:	afe080e7          	jalr	-1282(ra) # 5be8 <close>
}
    40f2:	60e2                	ld	ra,24(sp)
    40f4:	6442                	ld	s0,16(sp)
    40f6:	64a2                	ld	s1,8(sp)
    40f8:	6902                	ld	s2,0(sp)
    40fa:	6105                	addi	sp,sp,32
    40fc:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    40fe:	85ca                	mv	a1,s2
    4100:	00004517          	auipc	a0,0x4
    4104:	9b050513          	addi	a0,a0,-1616 # 7ab0 <malloc+0x1abe>
    4108:	00002097          	auipc	ra,0x2
    410c:	e32080e7          	jalr	-462(ra) # 5f3a <printf>
    exit(1);
    4110:	4505                	li	a0,1
    4112:	00002097          	auipc	ra,0x2
    4116:	aae080e7          	jalr	-1362(ra) # 5bc0 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    411a:	85ca                	mv	a1,s2
    411c:	00004517          	auipc	a0,0x4
    4120:	9b450513          	addi	a0,a0,-1612 # 7ad0 <malloc+0x1ade>
    4124:	00002097          	auipc	ra,0x2
    4128:	e16080e7          	jalr	-490(ra) # 5f3a <printf>
    exit(1);
    412c:	4505                	li	a0,1
    412e:	00002097          	auipc	ra,0x2
    4132:	a92080e7          	jalr	-1390(ra) # 5bc0 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4136:	85ca                	mv	a1,s2
    4138:	00004517          	auipc	a0,0x4
    413c:	9c850513          	addi	a0,a0,-1592 # 7b00 <malloc+0x1b0e>
    4140:	00002097          	auipc	ra,0x2
    4144:	dfa080e7          	jalr	-518(ra) # 5f3a <printf>
    exit(1);
    4148:	4505                	li	a0,1
    414a:	00002097          	auipc	ra,0x2
    414e:	a76080e7          	jalr	-1418(ra) # 5bc0 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4152:	85ca                	mv	a1,s2
    4154:	00004517          	auipc	a0,0x4
    4158:	9ac50513          	addi	a0,a0,-1620 # 7b00 <malloc+0x1b0e>
    415c:	00002097          	auipc	ra,0x2
    4160:	dde080e7          	jalr	-546(ra) # 5f3a <printf>
    exit(1);
    4164:	4505                	li	a0,1
    4166:	00002097          	auipc	ra,0x2
    416a:	a5a080e7          	jalr	-1446(ra) # 5bc0 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    416e:	85ca                	mv	a1,s2
    4170:	00004517          	auipc	a0,0x4
    4174:	9b850513          	addi	a0,a0,-1608 # 7b28 <malloc+0x1b36>
    4178:	00002097          	auipc	ra,0x2
    417c:	dc2080e7          	jalr	-574(ra) # 5f3a <printf>
    exit(1);
    4180:	4505                	li	a0,1
    4182:	00002097          	auipc	ra,0x2
    4186:	a3e080e7          	jalr	-1474(ra) # 5bc0 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    418a:	85ca                	mv	a1,s2
    418c:	00004517          	auipc	a0,0x4
    4190:	9c450513          	addi	a0,a0,-1596 # 7b50 <malloc+0x1b5e>
    4194:	00002097          	auipc	ra,0x2
    4198:	da6080e7          	jalr	-602(ra) # 5f3a <printf>
    exit(1);
    419c:	4505                	li	a0,1
    419e:	00002097          	auipc	ra,0x2
    41a2:	a22080e7          	jalr	-1502(ra) # 5bc0 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    41a6:	85ca                	mv	a1,s2
    41a8:	00004517          	auipc	a0,0x4
    41ac:	9d050513          	addi	a0,a0,-1584 # 7b78 <malloc+0x1b86>
    41b0:	00002097          	auipc	ra,0x2
    41b4:	d8a080e7          	jalr	-630(ra) # 5f3a <printf>
    exit(1);
    41b8:	4505                	li	a0,1
    41ba:	00002097          	auipc	ra,0x2
    41be:	a06080e7          	jalr	-1530(ra) # 5bc0 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    41c2:	85ca                	mv	a1,s2
    41c4:	00004517          	auipc	a0,0x4
    41c8:	9dc50513          	addi	a0,a0,-1572 # 7ba0 <malloc+0x1bae>
    41cc:	00002097          	auipc	ra,0x2
    41d0:	d6e080e7          	jalr	-658(ra) # 5f3a <printf>
    exit(1);
    41d4:	4505                	li	a0,1
    41d6:	00002097          	auipc	ra,0x2
    41da:	9ea080e7          	jalr	-1558(ra) # 5bc0 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    41de:	85ca                	mv	a1,s2
    41e0:	00004517          	auipc	a0,0x4
    41e4:	9e050513          	addi	a0,a0,-1568 # 7bc0 <malloc+0x1bce>
    41e8:	00002097          	auipc	ra,0x2
    41ec:	d52080e7          	jalr	-686(ra) # 5f3a <printf>
    exit(1);
    41f0:	4505                	li	a0,1
    41f2:	00002097          	auipc	ra,0x2
    41f6:	9ce080e7          	jalr	-1586(ra) # 5bc0 <exit>
    printf("%s: write . succeeded!\n", s);
    41fa:	85ca                	mv	a1,s2
    41fc:	00004517          	auipc	a0,0x4
    4200:	9ec50513          	addi	a0,a0,-1556 # 7be8 <malloc+0x1bf6>
    4204:	00002097          	auipc	ra,0x2
    4208:	d36080e7          	jalr	-714(ra) # 5f3a <printf>
    exit(1);
    420c:	4505                	li	a0,1
    420e:	00002097          	auipc	ra,0x2
    4212:	9b2080e7          	jalr	-1614(ra) # 5bc0 <exit>

0000000000004216 <iref>:
{
    4216:	7139                	addi	sp,sp,-64
    4218:	fc06                	sd	ra,56(sp)
    421a:	f822                	sd	s0,48(sp)
    421c:	f426                	sd	s1,40(sp)
    421e:	f04a                	sd	s2,32(sp)
    4220:	ec4e                	sd	s3,24(sp)
    4222:	e852                	sd	s4,16(sp)
    4224:	e456                	sd	s5,8(sp)
    4226:	e05a                	sd	s6,0(sp)
    4228:	0080                	addi	s0,sp,64
    422a:	8b2a                	mv	s6,a0
    422c:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    4230:	00004a17          	auipc	s4,0x4
    4234:	9d0a0a13          	addi	s4,s4,-1584 # 7c00 <malloc+0x1c0e>
    mkdir("");
    4238:	00003497          	auipc	s1,0x3
    423c:	4d048493          	addi	s1,s1,1232 # 7708 <malloc+0x1716>
    link("README", "");
    4240:	00002a97          	auipc	s5,0x2
    4244:	0b0a8a93          	addi	s5,s5,176 # 62f0 <malloc+0x2fe>
    fd = open("xx", O_CREATE);
    4248:	00004997          	auipc	s3,0x4
    424c:	8b098993          	addi	s3,s3,-1872 # 7af8 <malloc+0x1b06>
    4250:	a891                	j	42a4 <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    4252:	85da                	mv	a1,s6
    4254:	00004517          	auipc	a0,0x4
    4258:	9b450513          	addi	a0,a0,-1612 # 7c08 <malloc+0x1c16>
    425c:	00002097          	auipc	ra,0x2
    4260:	cde080e7          	jalr	-802(ra) # 5f3a <printf>
      exit(1);
    4264:	4505                	li	a0,1
    4266:	00002097          	auipc	ra,0x2
    426a:	95a080e7          	jalr	-1702(ra) # 5bc0 <exit>
      printf("%s: chdir irefd failed\n", s);
    426e:	85da                	mv	a1,s6
    4270:	00004517          	auipc	a0,0x4
    4274:	9b050513          	addi	a0,a0,-1616 # 7c20 <malloc+0x1c2e>
    4278:	00002097          	auipc	ra,0x2
    427c:	cc2080e7          	jalr	-830(ra) # 5f3a <printf>
      exit(1);
    4280:	4505                	li	a0,1
    4282:	00002097          	auipc	ra,0x2
    4286:	93e080e7          	jalr	-1730(ra) # 5bc0 <exit>
      close(fd);
    428a:	00002097          	auipc	ra,0x2
    428e:	95e080e7          	jalr	-1698(ra) # 5be8 <close>
    4292:	a889                	j	42e4 <iref+0xce>
    unlink("xx");
    4294:	854e                	mv	a0,s3
    4296:	00002097          	auipc	ra,0x2
    429a:	97a080e7          	jalr	-1670(ra) # 5c10 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    429e:	397d                	addiw	s2,s2,-1
    42a0:	06090063          	beqz	s2,4300 <iref+0xea>
    if(mkdir("irefd") != 0){
    42a4:	8552                	mv	a0,s4
    42a6:	00002097          	auipc	ra,0x2
    42aa:	982080e7          	jalr	-1662(ra) # 5c28 <mkdir>
    42ae:	f155                	bnez	a0,4252 <iref+0x3c>
    if(chdir("irefd") != 0){
    42b0:	8552                	mv	a0,s4
    42b2:	00002097          	auipc	ra,0x2
    42b6:	97e080e7          	jalr	-1666(ra) # 5c30 <chdir>
    42ba:	f955                	bnez	a0,426e <iref+0x58>
    mkdir("");
    42bc:	8526                	mv	a0,s1
    42be:	00002097          	auipc	ra,0x2
    42c2:	96a080e7          	jalr	-1686(ra) # 5c28 <mkdir>
    link("README", "");
    42c6:	85a6                	mv	a1,s1
    42c8:	8556                	mv	a0,s5
    42ca:	00002097          	auipc	ra,0x2
    42ce:	956080e7          	jalr	-1706(ra) # 5c20 <link>
    fd = open("", O_CREATE);
    42d2:	20000593          	li	a1,512
    42d6:	8526                	mv	a0,s1
    42d8:	00002097          	auipc	ra,0x2
    42dc:	928080e7          	jalr	-1752(ra) # 5c00 <open>
    if(fd >= 0)
    42e0:	fa0555e3          	bgez	a0,428a <iref+0x74>
    fd = open("xx", O_CREATE);
    42e4:	20000593          	li	a1,512
    42e8:	854e                	mv	a0,s3
    42ea:	00002097          	auipc	ra,0x2
    42ee:	916080e7          	jalr	-1770(ra) # 5c00 <open>
    if(fd >= 0)
    42f2:	fa0541e3          	bltz	a0,4294 <iref+0x7e>
      close(fd);
    42f6:	00002097          	auipc	ra,0x2
    42fa:	8f2080e7          	jalr	-1806(ra) # 5be8 <close>
    42fe:	bf59                	j	4294 <iref+0x7e>
    4300:	03300493          	li	s1,51
    chdir("..");
    4304:	00003997          	auipc	s3,0x3
    4308:	12498993          	addi	s3,s3,292 # 7428 <malloc+0x1436>
    unlink("irefd");
    430c:	00004917          	auipc	s2,0x4
    4310:	8f490913          	addi	s2,s2,-1804 # 7c00 <malloc+0x1c0e>
    chdir("..");
    4314:	854e                	mv	a0,s3
    4316:	00002097          	auipc	ra,0x2
    431a:	91a080e7          	jalr	-1766(ra) # 5c30 <chdir>
    unlink("irefd");
    431e:	854a                	mv	a0,s2
    4320:	00002097          	auipc	ra,0x2
    4324:	8f0080e7          	jalr	-1808(ra) # 5c10 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4328:	34fd                	addiw	s1,s1,-1
    432a:	f4ed                	bnez	s1,4314 <iref+0xfe>
  chdir("/");
    432c:	00003517          	auipc	a0,0x3
    4330:	0a450513          	addi	a0,a0,164 # 73d0 <malloc+0x13de>
    4334:	00002097          	auipc	ra,0x2
    4338:	8fc080e7          	jalr	-1796(ra) # 5c30 <chdir>
}
    433c:	70e2                	ld	ra,56(sp)
    433e:	7442                	ld	s0,48(sp)
    4340:	74a2                	ld	s1,40(sp)
    4342:	7902                	ld	s2,32(sp)
    4344:	69e2                	ld	s3,24(sp)
    4346:	6a42                	ld	s4,16(sp)
    4348:	6aa2                	ld	s5,8(sp)
    434a:	6b02                	ld	s6,0(sp)
    434c:	6121                	addi	sp,sp,64
    434e:	8082                	ret

0000000000004350 <openiputtest>:
{
    4350:	7179                	addi	sp,sp,-48
    4352:	f406                	sd	ra,40(sp)
    4354:	f022                	sd	s0,32(sp)
    4356:	ec26                	sd	s1,24(sp)
    4358:	1800                	addi	s0,sp,48
    435a:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    435c:	00004517          	auipc	a0,0x4
    4360:	8dc50513          	addi	a0,a0,-1828 # 7c38 <malloc+0x1c46>
    4364:	00002097          	auipc	ra,0x2
    4368:	8c4080e7          	jalr	-1852(ra) # 5c28 <mkdir>
    436c:	04054263          	bltz	a0,43b0 <openiputtest+0x60>
  pid = fork();
    4370:	00002097          	auipc	ra,0x2
    4374:	848080e7          	jalr	-1976(ra) # 5bb8 <fork>
  if(pid < 0){
    4378:	04054a63          	bltz	a0,43cc <openiputtest+0x7c>
  if(pid == 0){
    437c:	e93d                	bnez	a0,43f2 <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    437e:	4589                	li	a1,2
    4380:	00004517          	auipc	a0,0x4
    4384:	8b850513          	addi	a0,a0,-1864 # 7c38 <malloc+0x1c46>
    4388:	00002097          	auipc	ra,0x2
    438c:	878080e7          	jalr	-1928(ra) # 5c00 <open>
    if(fd >= 0){
    4390:	04054c63          	bltz	a0,43e8 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    4394:	85a6                	mv	a1,s1
    4396:	00004517          	auipc	a0,0x4
    439a:	8c250513          	addi	a0,a0,-1854 # 7c58 <malloc+0x1c66>
    439e:	00002097          	auipc	ra,0x2
    43a2:	b9c080e7          	jalr	-1124(ra) # 5f3a <printf>
      exit(1);
    43a6:	4505                	li	a0,1
    43a8:	00002097          	auipc	ra,0x2
    43ac:	818080e7          	jalr	-2024(ra) # 5bc0 <exit>
    printf("%s: mkdir oidir failed\n", s);
    43b0:	85a6                	mv	a1,s1
    43b2:	00004517          	auipc	a0,0x4
    43b6:	88e50513          	addi	a0,a0,-1906 # 7c40 <malloc+0x1c4e>
    43ba:	00002097          	auipc	ra,0x2
    43be:	b80080e7          	jalr	-1152(ra) # 5f3a <printf>
    exit(1);
    43c2:	4505                	li	a0,1
    43c4:	00001097          	auipc	ra,0x1
    43c8:	7fc080e7          	jalr	2044(ra) # 5bc0 <exit>
    printf("%s: fork failed\n", s);
    43cc:	85a6                	mv	a1,s1
    43ce:	00002517          	auipc	a0,0x2
    43d2:	5d250513          	addi	a0,a0,1490 # 69a0 <malloc+0x9ae>
    43d6:	00002097          	auipc	ra,0x2
    43da:	b64080e7          	jalr	-1180(ra) # 5f3a <printf>
    exit(1);
    43de:	4505                	li	a0,1
    43e0:	00001097          	auipc	ra,0x1
    43e4:	7e0080e7          	jalr	2016(ra) # 5bc0 <exit>
    exit(0);
    43e8:	4501                	li	a0,0
    43ea:	00001097          	auipc	ra,0x1
    43ee:	7d6080e7          	jalr	2006(ra) # 5bc0 <exit>
  sleep(1);
    43f2:	4505                	li	a0,1
    43f4:	00002097          	auipc	ra,0x2
    43f8:	85c080e7          	jalr	-1956(ra) # 5c50 <sleep>
  if(unlink("oidir") != 0){
    43fc:	00004517          	auipc	a0,0x4
    4400:	83c50513          	addi	a0,a0,-1988 # 7c38 <malloc+0x1c46>
    4404:	00002097          	auipc	ra,0x2
    4408:	80c080e7          	jalr	-2036(ra) # 5c10 <unlink>
    440c:	cd19                	beqz	a0,442a <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    440e:	85a6                	mv	a1,s1
    4410:	00002517          	auipc	a0,0x2
    4414:	78050513          	addi	a0,a0,1920 # 6b90 <malloc+0xb9e>
    4418:	00002097          	auipc	ra,0x2
    441c:	b22080e7          	jalr	-1246(ra) # 5f3a <printf>
    exit(1);
    4420:	4505                	li	a0,1
    4422:	00001097          	auipc	ra,0x1
    4426:	79e080e7          	jalr	1950(ra) # 5bc0 <exit>
  wait(&xstatus);
    442a:	fdc40513          	addi	a0,s0,-36
    442e:	00001097          	auipc	ra,0x1
    4432:	79a080e7          	jalr	1946(ra) # 5bc8 <wait>
  exit(xstatus);
    4436:	fdc42503          	lw	a0,-36(s0)
    443a:	00001097          	auipc	ra,0x1
    443e:	786080e7          	jalr	1926(ra) # 5bc0 <exit>

0000000000004442 <forkforkfork>:
{
    4442:	1101                	addi	sp,sp,-32
    4444:	ec06                	sd	ra,24(sp)
    4446:	e822                	sd	s0,16(sp)
    4448:	e426                	sd	s1,8(sp)
    444a:	1000                	addi	s0,sp,32
    444c:	84aa                	mv	s1,a0
  unlink("stopforking");
    444e:	00004517          	auipc	a0,0x4
    4452:	83250513          	addi	a0,a0,-1998 # 7c80 <malloc+0x1c8e>
    4456:	00001097          	auipc	ra,0x1
    445a:	7ba080e7          	jalr	1978(ra) # 5c10 <unlink>
  int pid = fork();
    445e:	00001097          	auipc	ra,0x1
    4462:	75a080e7          	jalr	1882(ra) # 5bb8 <fork>
  if(pid < 0){
    4466:	04054563          	bltz	a0,44b0 <forkforkfork+0x6e>
  if(pid == 0){
    446a:	c12d                	beqz	a0,44cc <forkforkfork+0x8a>
  sleep(20); // two seconds
    446c:	4551                	li	a0,20
    446e:	00001097          	auipc	ra,0x1
    4472:	7e2080e7          	jalr	2018(ra) # 5c50 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    4476:	20200593          	li	a1,514
    447a:	00004517          	auipc	a0,0x4
    447e:	80650513          	addi	a0,a0,-2042 # 7c80 <malloc+0x1c8e>
    4482:	00001097          	auipc	ra,0x1
    4486:	77e080e7          	jalr	1918(ra) # 5c00 <open>
    448a:	00001097          	auipc	ra,0x1
    448e:	75e080e7          	jalr	1886(ra) # 5be8 <close>
  wait(0);
    4492:	4501                	li	a0,0
    4494:	00001097          	auipc	ra,0x1
    4498:	734080e7          	jalr	1844(ra) # 5bc8 <wait>
  sleep(10); // one second
    449c:	4529                	li	a0,10
    449e:	00001097          	auipc	ra,0x1
    44a2:	7b2080e7          	jalr	1970(ra) # 5c50 <sleep>
}
    44a6:	60e2                	ld	ra,24(sp)
    44a8:	6442                	ld	s0,16(sp)
    44aa:	64a2                	ld	s1,8(sp)
    44ac:	6105                	addi	sp,sp,32
    44ae:	8082                	ret
    printf("%s: fork failed", s);
    44b0:	85a6                	mv	a1,s1
    44b2:	00002517          	auipc	a0,0x2
    44b6:	6ae50513          	addi	a0,a0,1710 # 6b60 <malloc+0xb6e>
    44ba:	00002097          	auipc	ra,0x2
    44be:	a80080e7          	jalr	-1408(ra) # 5f3a <printf>
    exit(1);
    44c2:	4505                	li	a0,1
    44c4:	00001097          	auipc	ra,0x1
    44c8:	6fc080e7          	jalr	1788(ra) # 5bc0 <exit>
      int fd = open("stopforking", 0);
    44cc:	00003497          	auipc	s1,0x3
    44d0:	7b448493          	addi	s1,s1,1972 # 7c80 <malloc+0x1c8e>
    44d4:	4581                	li	a1,0
    44d6:	8526                	mv	a0,s1
    44d8:	00001097          	auipc	ra,0x1
    44dc:	728080e7          	jalr	1832(ra) # 5c00 <open>
      if(fd >= 0){
    44e0:	02055463          	bgez	a0,4508 <forkforkfork+0xc6>
      if(fork() < 0){
    44e4:	00001097          	auipc	ra,0x1
    44e8:	6d4080e7          	jalr	1748(ra) # 5bb8 <fork>
    44ec:	fe0554e3          	bgez	a0,44d4 <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    44f0:	20200593          	li	a1,514
    44f4:	8526                	mv	a0,s1
    44f6:	00001097          	auipc	ra,0x1
    44fa:	70a080e7          	jalr	1802(ra) # 5c00 <open>
    44fe:	00001097          	auipc	ra,0x1
    4502:	6ea080e7          	jalr	1770(ra) # 5be8 <close>
    4506:	b7f9                	j	44d4 <forkforkfork+0x92>
        exit(0);
    4508:	4501                	li	a0,0
    450a:	00001097          	auipc	ra,0x1
    450e:	6b6080e7          	jalr	1718(ra) # 5bc0 <exit>

0000000000004512 <killstatus>:
{
    4512:	7139                	addi	sp,sp,-64
    4514:	fc06                	sd	ra,56(sp)
    4516:	f822                	sd	s0,48(sp)
    4518:	f426                	sd	s1,40(sp)
    451a:	f04a                	sd	s2,32(sp)
    451c:	ec4e                	sd	s3,24(sp)
    451e:	e852                	sd	s4,16(sp)
    4520:	0080                	addi	s0,sp,64
    4522:	8a2a                	mv	s4,a0
    4524:	06400913          	li	s2,100
    if(xst != -1) {
    4528:	59fd                	li	s3,-1
    int pid1 = fork();
    452a:	00001097          	auipc	ra,0x1
    452e:	68e080e7          	jalr	1678(ra) # 5bb8 <fork>
    4532:	84aa                	mv	s1,a0
    if(pid1 < 0){
    4534:	02054f63          	bltz	a0,4572 <killstatus+0x60>
    if(pid1 == 0){
    4538:	c939                	beqz	a0,458e <killstatus+0x7c>
    sleep(1);
    453a:	4505                	li	a0,1
    453c:	00001097          	auipc	ra,0x1
    4540:	714080e7          	jalr	1812(ra) # 5c50 <sleep>
    kill(pid1);
    4544:	8526                	mv	a0,s1
    4546:	00001097          	auipc	ra,0x1
    454a:	6aa080e7          	jalr	1706(ra) # 5bf0 <kill>
    wait(&xst);
    454e:	fcc40513          	addi	a0,s0,-52
    4552:	00001097          	auipc	ra,0x1
    4556:	676080e7          	jalr	1654(ra) # 5bc8 <wait>
    if(xst != -1) {
    455a:	fcc42783          	lw	a5,-52(s0)
    455e:	03379d63          	bne	a5,s3,4598 <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    4562:	397d                	addiw	s2,s2,-1
    4564:	fc0913e3          	bnez	s2,452a <killstatus+0x18>
  exit(0);
    4568:	4501                	li	a0,0
    456a:	00001097          	auipc	ra,0x1
    456e:	656080e7          	jalr	1622(ra) # 5bc0 <exit>
      printf("%s: fork failed\n", s);
    4572:	85d2                	mv	a1,s4
    4574:	00002517          	auipc	a0,0x2
    4578:	42c50513          	addi	a0,a0,1068 # 69a0 <malloc+0x9ae>
    457c:	00002097          	auipc	ra,0x2
    4580:	9be080e7          	jalr	-1602(ra) # 5f3a <printf>
      exit(1);
    4584:	4505                	li	a0,1
    4586:	00001097          	auipc	ra,0x1
    458a:	63a080e7          	jalr	1594(ra) # 5bc0 <exit>
        getpid();
    458e:	00001097          	auipc	ra,0x1
    4592:	6b2080e7          	jalr	1714(ra) # 5c40 <getpid>
      while(1) {
    4596:	bfe5                	j	458e <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    4598:	85d2                	mv	a1,s4
    459a:	00003517          	auipc	a0,0x3
    459e:	6f650513          	addi	a0,a0,1782 # 7c90 <malloc+0x1c9e>
    45a2:	00002097          	auipc	ra,0x2
    45a6:	998080e7          	jalr	-1640(ra) # 5f3a <printf>
       exit(1);
    45aa:	4505                	li	a0,1
    45ac:	00001097          	auipc	ra,0x1
    45b0:	614080e7          	jalr	1556(ra) # 5bc0 <exit>

00000000000045b4 <preempt>:
{
    45b4:	7139                	addi	sp,sp,-64
    45b6:	fc06                	sd	ra,56(sp)
    45b8:	f822                	sd	s0,48(sp)
    45ba:	f426                	sd	s1,40(sp)
    45bc:	f04a                	sd	s2,32(sp)
    45be:	ec4e                	sd	s3,24(sp)
    45c0:	e852                	sd	s4,16(sp)
    45c2:	0080                	addi	s0,sp,64
    45c4:	892a                	mv	s2,a0
  pid1 = fork();
    45c6:	00001097          	auipc	ra,0x1
    45ca:	5f2080e7          	jalr	1522(ra) # 5bb8 <fork>
  if(pid1 < 0) {
    45ce:	00054563          	bltz	a0,45d8 <preempt+0x24>
    45d2:	84aa                	mv	s1,a0
  if(pid1 == 0)
    45d4:	e105                	bnez	a0,45f4 <preempt+0x40>
    for(;;)
    45d6:	a001                	j	45d6 <preempt+0x22>
    printf("%s: fork failed", s);
    45d8:	85ca                	mv	a1,s2
    45da:	00002517          	auipc	a0,0x2
    45de:	58650513          	addi	a0,a0,1414 # 6b60 <malloc+0xb6e>
    45e2:	00002097          	auipc	ra,0x2
    45e6:	958080e7          	jalr	-1704(ra) # 5f3a <printf>
    exit(1);
    45ea:	4505                	li	a0,1
    45ec:	00001097          	auipc	ra,0x1
    45f0:	5d4080e7          	jalr	1492(ra) # 5bc0 <exit>
  pid2 = fork();
    45f4:	00001097          	auipc	ra,0x1
    45f8:	5c4080e7          	jalr	1476(ra) # 5bb8 <fork>
    45fc:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    45fe:	00054463          	bltz	a0,4606 <preempt+0x52>
  if(pid2 == 0)
    4602:	e105                	bnez	a0,4622 <preempt+0x6e>
    for(;;)
    4604:	a001                	j	4604 <preempt+0x50>
    printf("%s: fork failed\n", s);
    4606:	85ca                	mv	a1,s2
    4608:	00002517          	auipc	a0,0x2
    460c:	39850513          	addi	a0,a0,920 # 69a0 <malloc+0x9ae>
    4610:	00002097          	auipc	ra,0x2
    4614:	92a080e7          	jalr	-1750(ra) # 5f3a <printf>
    exit(1);
    4618:	4505                	li	a0,1
    461a:	00001097          	auipc	ra,0x1
    461e:	5a6080e7          	jalr	1446(ra) # 5bc0 <exit>
  pipe(pfds);
    4622:	fc840513          	addi	a0,s0,-56
    4626:	00001097          	auipc	ra,0x1
    462a:	5aa080e7          	jalr	1450(ra) # 5bd0 <pipe>
  pid3 = fork();
    462e:	00001097          	auipc	ra,0x1
    4632:	58a080e7          	jalr	1418(ra) # 5bb8 <fork>
    4636:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    4638:	02054e63          	bltz	a0,4674 <preempt+0xc0>
  if(pid3 == 0){
    463c:	e525                	bnez	a0,46a4 <preempt+0xf0>
    close(pfds[0]);
    463e:	fc842503          	lw	a0,-56(s0)
    4642:	00001097          	auipc	ra,0x1
    4646:	5a6080e7          	jalr	1446(ra) # 5be8 <close>
    if(write(pfds[1], "x", 1) != 1)
    464a:	4605                	li	a2,1
    464c:	00002597          	auipc	a1,0x2
    4650:	b3c58593          	addi	a1,a1,-1220 # 6188 <malloc+0x196>
    4654:	fcc42503          	lw	a0,-52(s0)
    4658:	00001097          	auipc	ra,0x1
    465c:	588080e7          	jalr	1416(ra) # 5be0 <write>
    4660:	4785                	li	a5,1
    4662:	02f51763          	bne	a0,a5,4690 <preempt+0xdc>
    close(pfds[1]);
    4666:	fcc42503          	lw	a0,-52(s0)
    466a:	00001097          	auipc	ra,0x1
    466e:	57e080e7          	jalr	1406(ra) # 5be8 <close>
    for(;;)
    4672:	a001                	j	4672 <preempt+0xbe>
     printf("%s: fork failed\n", s);
    4674:	85ca                	mv	a1,s2
    4676:	00002517          	auipc	a0,0x2
    467a:	32a50513          	addi	a0,a0,810 # 69a0 <malloc+0x9ae>
    467e:	00002097          	auipc	ra,0x2
    4682:	8bc080e7          	jalr	-1860(ra) # 5f3a <printf>
     exit(1);
    4686:	4505                	li	a0,1
    4688:	00001097          	auipc	ra,0x1
    468c:	538080e7          	jalr	1336(ra) # 5bc0 <exit>
      printf("%s: preempt write error", s);
    4690:	85ca                	mv	a1,s2
    4692:	00003517          	auipc	a0,0x3
    4696:	61e50513          	addi	a0,a0,1566 # 7cb0 <malloc+0x1cbe>
    469a:	00002097          	auipc	ra,0x2
    469e:	8a0080e7          	jalr	-1888(ra) # 5f3a <printf>
    46a2:	b7d1                	j	4666 <preempt+0xb2>
  close(pfds[1]);
    46a4:	fcc42503          	lw	a0,-52(s0)
    46a8:	00001097          	auipc	ra,0x1
    46ac:	540080e7          	jalr	1344(ra) # 5be8 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    46b0:	660d                	lui	a2,0x3
    46b2:	00008597          	auipc	a1,0x8
    46b6:	5c658593          	addi	a1,a1,1478 # cc78 <buf>
    46ba:	fc842503          	lw	a0,-56(s0)
    46be:	00001097          	auipc	ra,0x1
    46c2:	51a080e7          	jalr	1306(ra) # 5bd8 <read>
    46c6:	4785                	li	a5,1
    46c8:	02f50363          	beq	a0,a5,46ee <preempt+0x13a>
    printf("%s: preempt read error", s);
    46cc:	85ca                	mv	a1,s2
    46ce:	00003517          	auipc	a0,0x3
    46d2:	5fa50513          	addi	a0,a0,1530 # 7cc8 <malloc+0x1cd6>
    46d6:	00002097          	auipc	ra,0x2
    46da:	864080e7          	jalr	-1948(ra) # 5f3a <printf>
}
    46de:	70e2                	ld	ra,56(sp)
    46e0:	7442                	ld	s0,48(sp)
    46e2:	74a2                	ld	s1,40(sp)
    46e4:	7902                	ld	s2,32(sp)
    46e6:	69e2                	ld	s3,24(sp)
    46e8:	6a42                	ld	s4,16(sp)
    46ea:	6121                	addi	sp,sp,64
    46ec:	8082                	ret
  close(pfds[0]);
    46ee:	fc842503          	lw	a0,-56(s0)
    46f2:	00001097          	auipc	ra,0x1
    46f6:	4f6080e7          	jalr	1270(ra) # 5be8 <close>
  printf("kill... ");
    46fa:	00003517          	auipc	a0,0x3
    46fe:	5e650513          	addi	a0,a0,1510 # 7ce0 <malloc+0x1cee>
    4702:	00002097          	auipc	ra,0x2
    4706:	838080e7          	jalr	-1992(ra) # 5f3a <printf>
  kill(pid1);
    470a:	8526                	mv	a0,s1
    470c:	00001097          	auipc	ra,0x1
    4710:	4e4080e7          	jalr	1252(ra) # 5bf0 <kill>
  kill(pid2);
    4714:	854e                	mv	a0,s3
    4716:	00001097          	auipc	ra,0x1
    471a:	4da080e7          	jalr	1242(ra) # 5bf0 <kill>
  kill(pid3);
    471e:	8552                	mv	a0,s4
    4720:	00001097          	auipc	ra,0x1
    4724:	4d0080e7          	jalr	1232(ra) # 5bf0 <kill>
  printf("wait... ");
    4728:	00003517          	auipc	a0,0x3
    472c:	5c850513          	addi	a0,a0,1480 # 7cf0 <malloc+0x1cfe>
    4730:	00002097          	auipc	ra,0x2
    4734:	80a080e7          	jalr	-2038(ra) # 5f3a <printf>
  wait(0);
    4738:	4501                	li	a0,0
    473a:	00001097          	auipc	ra,0x1
    473e:	48e080e7          	jalr	1166(ra) # 5bc8 <wait>
  wait(0);
    4742:	4501                	li	a0,0
    4744:	00001097          	auipc	ra,0x1
    4748:	484080e7          	jalr	1156(ra) # 5bc8 <wait>
  wait(0);
    474c:	4501                	li	a0,0
    474e:	00001097          	auipc	ra,0x1
    4752:	47a080e7          	jalr	1146(ra) # 5bc8 <wait>
    4756:	b761                	j	46de <preempt+0x12a>

0000000000004758 <reparent>:
{
    4758:	7179                	addi	sp,sp,-48
    475a:	f406                	sd	ra,40(sp)
    475c:	f022                	sd	s0,32(sp)
    475e:	ec26                	sd	s1,24(sp)
    4760:	e84a                	sd	s2,16(sp)
    4762:	e44e                	sd	s3,8(sp)
    4764:	e052                	sd	s4,0(sp)
    4766:	1800                	addi	s0,sp,48
    4768:	89aa                	mv	s3,a0
  int master_pid = getpid();
    476a:	00001097          	auipc	ra,0x1
    476e:	4d6080e7          	jalr	1238(ra) # 5c40 <getpid>
    4772:	8a2a                	mv	s4,a0
    4774:	0c800913          	li	s2,200
    int pid = fork();
    4778:	00001097          	auipc	ra,0x1
    477c:	440080e7          	jalr	1088(ra) # 5bb8 <fork>
    4780:	84aa                	mv	s1,a0
    if(pid < 0){
    4782:	02054263          	bltz	a0,47a6 <reparent+0x4e>
    if(pid){
    4786:	cd21                	beqz	a0,47de <reparent+0x86>
      if(wait(0) != pid){
    4788:	4501                	li	a0,0
    478a:	00001097          	auipc	ra,0x1
    478e:	43e080e7          	jalr	1086(ra) # 5bc8 <wait>
    4792:	02951863          	bne	a0,s1,47c2 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    4796:	397d                	addiw	s2,s2,-1
    4798:	fe0910e3          	bnez	s2,4778 <reparent+0x20>
  exit(0);
    479c:	4501                	li	a0,0
    479e:	00001097          	auipc	ra,0x1
    47a2:	422080e7          	jalr	1058(ra) # 5bc0 <exit>
      printf("%s: fork failed\n", s);
    47a6:	85ce                	mv	a1,s3
    47a8:	00002517          	auipc	a0,0x2
    47ac:	1f850513          	addi	a0,a0,504 # 69a0 <malloc+0x9ae>
    47b0:	00001097          	auipc	ra,0x1
    47b4:	78a080e7          	jalr	1930(ra) # 5f3a <printf>
      exit(1);
    47b8:	4505                	li	a0,1
    47ba:	00001097          	auipc	ra,0x1
    47be:	406080e7          	jalr	1030(ra) # 5bc0 <exit>
        printf("%s: wait wrong pid\n", s);
    47c2:	85ce                	mv	a1,s3
    47c4:	00002517          	auipc	a0,0x2
    47c8:	36450513          	addi	a0,a0,868 # 6b28 <malloc+0xb36>
    47cc:	00001097          	auipc	ra,0x1
    47d0:	76e080e7          	jalr	1902(ra) # 5f3a <printf>
        exit(1);
    47d4:	4505                	li	a0,1
    47d6:	00001097          	auipc	ra,0x1
    47da:	3ea080e7          	jalr	1002(ra) # 5bc0 <exit>
      int pid2 = fork();
    47de:	00001097          	auipc	ra,0x1
    47e2:	3da080e7          	jalr	986(ra) # 5bb8 <fork>
      if(pid2 < 0){
    47e6:	00054763          	bltz	a0,47f4 <reparent+0x9c>
      exit(0);
    47ea:	4501                	li	a0,0
    47ec:	00001097          	auipc	ra,0x1
    47f0:	3d4080e7          	jalr	980(ra) # 5bc0 <exit>
        kill(master_pid);
    47f4:	8552                	mv	a0,s4
    47f6:	00001097          	auipc	ra,0x1
    47fa:	3fa080e7          	jalr	1018(ra) # 5bf0 <kill>
        exit(1);
    47fe:	4505                	li	a0,1
    4800:	00001097          	auipc	ra,0x1
    4804:	3c0080e7          	jalr	960(ra) # 5bc0 <exit>

0000000000004808 <sbrkfail>:
{
    4808:	7119                	addi	sp,sp,-128
    480a:	fc86                	sd	ra,120(sp)
    480c:	f8a2                	sd	s0,112(sp)
    480e:	f4a6                	sd	s1,104(sp)
    4810:	f0ca                	sd	s2,96(sp)
    4812:	ecce                	sd	s3,88(sp)
    4814:	e8d2                	sd	s4,80(sp)
    4816:	e4d6                	sd	s5,72(sp)
    4818:	0100                	addi	s0,sp,128
    481a:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    481c:	fb040513          	addi	a0,s0,-80
    4820:	00001097          	auipc	ra,0x1
    4824:	3b0080e7          	jalr	944(ra) # 5bd0 <pipe>
    4828:	e901                	bnez	a0,4838 <sbrkfail+0x30>
    482a:	f8040493          	addi	s1,s0,-128
    482e:	fa840993          	addi	s3,s0,-88
    4832:	8926                	mv	s2,s1
    if(pids[i] != -1)
    4834:	5a7d                	li	s4,-1
    4836:	a085                	j	4896 <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    4838:	85d6                	mv	a1,s5
    483a:	00002517          	auipc	a0,0x2
    483e:	26e50513          	addi	a0,a0,622 # 6aa8 <malloc+0xab6>
    4842:	00001097          	auipc	ra,0x1
    4846:	6f8080e7          	jalr	1784(ra) # 5f3a <printf>
    exit(1);
    484a:	4505                	li	a0,1
    484c:	00001097          	auipc	ra,0x1
    4850:	374080e7          	jalr	884(ra) # 5bc0 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    4854:	00001097          	auipc	ra,0x1
    4858:	3f4080e7          	jalr	1012(ra) # 5c48 <sbrk>
    485c:	064007b7          	lui	a5,0x6400
    4860:	40a7853b          	subw	a0,a5,a0
    4864:	00001097          	auipc	ra,0x1
    4868:	3e4080e7          	jalr	996(ra) # 5c48 <sbrk>
      write(fds[1], "x", 1);
    486c:	4605                	li	a2,1
    486e:	00002597          	auipc	a1,0x2
    4872:	91a58593          	addi	a1,a1,-1766 # 6188 <malloc+0x196>
    4876:	fb442503          	lw	a0,-76(s0)
    487a:	00001097          	auipc	ra,0x1
    487e:	366080e7          	jalr	870(ra) # 5be0 <write>
      for(;;) sleep(1000);
    4882:	3e800513          	li	a0,1000
    4886:	00001097          	auipc	ra,0x1
    488a:	3ca080e7          	jalr	970(ra) # 5c50 <sleep>
    488e:	bfd5                	j	4882 <sbrkfail+0x7a>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4890:	0911                	addi	s2,s2,4
    4892:	03390563          	beq	s2,s3,48bc <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    4896:	00001097          	auipc	ra,0x1
    489a:	322080e7          	jalr	802(ra) # 5bb8 <fork>
    489e:	00a92023          	sw	a0,0(s2)
    48a2:	d94d                	beqz	a0,4854 <sbrkfail+0x4c>
    if(pids[i] != -1)
    48a4:	ff4506e3          	beq	a0,s4,4890 <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    48a8:	4605                	li	a2,1
    48aa:	faf40593          	addi	a1,s0,-81
    48ae:	fb042503          	lw	a0,-80(s0)
    48b2:	00001097          	auipc	ra,0x1
    48b6:	326080e7          	jalr	806(ra) # 5bd8 <read>
    48ba:	bfd9                	j	4890 <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    48bc:	6505                	lui	a0,0x1
    48be:	00001097          	auipc	ra,0x1
    48c2:	38a080e7          	jalr	906(ra) # 5c48 <sbrk>
    48c6:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    48c8:	597d                	li	s2,-1
    48ca:	a021                	j	48d2 <sbrkfail+0xca>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    48cc:	0491                	addi	s1,s1,4
    48ce:	01348f63          	beq	s1,s3,48ec <sbrkfail+0xe4>
    if(pids[i] == -1)
    48d2:	4088                	lw	a0,0(s1)
    48d4:	ff250ce3          	beq	a0,s2,48cc <sbrkfail+0xc4>
    kill(pids[i]);
    48d8:	00001097          	auipc	ra,0x1
    48dc:	318080e7          	jalr	792(ra) # 5bf0 <kill>
    wait(0);
    48e0:	4501                	li	a0,0
    48e2:	00001097          	auipc	ra,0x1
    48e6:	2e6080e7          	jalr	742(ra) # 5bc8 <wait>
    48ea:	b7cd                	j	48cc <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    48ec:	57fd                	li	a5,-1
    48ee:	04fa0163          	beq	s4,a5,4930 <sbrkfail+0x128>
  pid = fork();
    48f2:	00001097          	auipc	ra,0x1
    48f6:	2c6080e7          	jalr	710(ra) # 5bb8 <fork>
    48fa:	84aa                	mv	s1,a0
  if(pid < 0){
    48fc:	04054863          	bltz	a0,494c <sbrkfail+0x144>
  if(pid == 0){
    4900:	c525                	beqz	a0,4968 <sbrkfail+0x160>
  wait(&xstatus);
    4902:	fbc40513          	addi	a0,s0,-68
    4906:	00001097          	auipc	ra,0x1
    490a:	2c2080e7          	jalr	706(ra) # 5bc8 <wait>
  if(xstatus != -1 && xstatus != 2)
    490e:	fbc42783          	lw	a5,-68(s0)
    4912:	577d                	li	a4,-1
    4914:	00e78563          	beq	a5,a4,491e <sbrkfail+0x116>
    4918:	4709                	li	a4,2
    491a:	08e79d63          	bne	a5,a4,49b4 <sbrkfail+0x1ac>
}
    491e:	70e6                	ld	ra,120(sp)
    4920:	7446                	ld	s0,112(sp)
    4922:	74a6                	ld	s1,104(sp)
    4924:	7906                	ld	s2,96(sp)
    4926:	69e6                	ld	s3,88(sp)
    4928:	6a46                	ld	s4,80(sp)
    492a:	6aa6                	ld	s5,72(sp)
    492c:	6109                	addi	sp,sp,128
    492e:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    4930:	85d6                	mv	a1,s5
    4932:	00003517          	auipc	a0,0x3
    4936:	3ce50513          	addi	a0,a0,974 # 7d00 <malloc+0x1d0e>
    493a:	00001097          	auipc	ra,0x1
    493e:	600080e7          	jalr	1536(ra) # 5f3a <printf>
    exit(1);
    4942:	4505                	li	a0,1
    4944:	00001097          	auipc	ra,0x1
    4948:	27c080e7          	jalr	636(ra) # 5bc0 <exit>
    printf("%s: fork failed\n", s);
    494c:	85d6                	mv	a1,s5
    494e:	00002517          	auipc	a0,0x2
    4952:	05250513          	addi	a0,a0,82 # 69a0 <malloc+0x9ae>
    4956:	00001097          	auipc	ra,0x1
    495a:	5e4080e7          	jalr	1508(ra) # 5f3a <printf>
    exit(1);
    495e:	4505                	li	a0,1
    4960:	00001097          	auipc	ra,0x1
    4964:	260080e7          	jalr	608(ra) # 5bc0 <exit>
    a = sbrk(0);
    4968:	4501                	li	a0,0
    496a:	00001097          	auipc	ra,0x1
    496e:	2de080e7          	jalr	734(ra) # 5c48 <sbrk>
    4972:	892a                	mv	s2,a0
    sbrk(10*BIG);
    4974:	3e800537          	lui	a0,0x3e800
    4978:	00001097          	auipc	ra,0x1
    497c:	2d0080e7          	jalr	720(ra) # 5c48 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4980:	87ca                	mv	a5,s2
    4982:	3e800737          	lui	a4,0x3e800
    4986:	993a                	add	s2,s2,a4
    4988:	6705                	lui	a4,0x1
      n += *(a+i);
    498a:	0007c683          	lbu	a3,0(a5) # 6400000 <base+0x63f0388>
    498e:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4990:	97ba                	add	a5,a5,a4
    4992:	ff279ce3          	bne	a5,s2,498a <sbrkfail+0x182>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    4996:	8626                	mv	a2,s1
    4998:	85d6                	mv	a1,s5
    499a:	00003517          	auipc	a0,0x3
    499e:	38650513          	addi	a0,a0,902 # 7d20 <malloc+0x1d2e>
    49a2:	00001097          	auipc	ra,0x1
    49a6:	598080e7          	jalr	1432(ra) # 5f3a <printf>
    exit(1);
    49aa:	4505                	li	a0,1
    49ac:	00001097          	auipc	ra,0x1
    49b0:	214080e7          	jalr	532(ra) # 5bc0 <exit>
    exit(1);
    49b4:	4505                	li	a0,1
    49b6:	00001097          	auipc	ra,0x1
    49ba:	20a080e7          	jalr	522(ra) # 5bc0 <exit>

00000000000049be <mem>:
{
    49be:	7139                	addi	sp,sp,-64
    49c0:	fc06                	sd	ra,56(sp)
    49c2:	f822                	sd	s0,48(sp)
    49c4:	f426                	sd	s1,40(sp)
    49c6:	f04a                	sd	s2,32(sp)
    49c8:	ec4e                	sd	s3,24(sp)
    49ca:	0080                	addi	s0,sp,64
    49cc:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    49ce:	00001097          	auipc	ra,0x1
    49d2:	1ea080e7          	jalr	490(ra) # 5bb8 <fork>
    m1 = 0;
    49d6:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    49d8:	6909                	lui	s2,0x2
    49da:	71190913          	addi	s2,s2,1809 # 2711 <copyinstr3+0x107>
  if((pid = fork()) == 0){
    49de:	c115                	beqz	a0,4a02 <mem+0x44>
    wait(&xstatus);
    49e0:	fcc40513          	addi	a0,s0,-52
    49e4:	00001097          	auipc	ra,0x1
    49e8:	1e4080e7          	jalr	484(ra) # 5bc8 <wait>
    if(xstatus == -1){
    49ec:	fcc42503          	lw	a0,-52(s0)
    49f0:	57fd                	li	a5,-1
    49f2:	06f50363          	beq	a0,a5,4a58 <mem+0x9a>
    exit(xstatus);
    49f6:	00001097          	auipc	ra,0x1
    49fa:	1ca080e7          	jalr	458(ra) # 5bc0 <exit>
      *(char**)m2 = m1;
    49fe:	e104                	sd	s1,0(a0)
      m1 = m2;
    4a00:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    4a02:	854a                	mv	a0,s2
    4a04:	00001097          	auipc	ra,0x1
    4a08:	5ee080e7          	jalr	1518(ra) # 5ff2 <malloc>
    4a0c:	f96d                	bnez	a0,49fe <mem+0x40>
    while(m1){
    4a0e:	c881                	beqz	s1,4a1e <mem+0x60>
      m2 = *(char**)m1;
    4a10:	8526                	mv	a0,s1
    4a12:	6084                	ld	s1,0(s1)
      free(m1);
    4a14:	00001097          	auipc	ra,0x1
    4a18:	55c080e7          	jalr	1372(ra) # 5f70 <free>
    while(m1){
    4a1c:	f8f5                	bnez	s1,4a10 <mem+0x52>
    m1 = malloc(1024*20);
    4a1e:	6515                	lui	a0,0x5
    4a20:	00001097          	auipc	ra,0x1
    4a24:	5d2080e7          	jalr	1490(ra) # 5ff2 <malloc>
    if(m1 == 0){
    4a28:	c911                	beqz	a0,4a3c <mem+0x7e>
    free(m1);
    4a2a:	00001097          	auipc	ra,0x1
    4a2e:	546080e7          	jalr	1350(ra) # 5f70 <free>
    exit(0);
    4a32:	4501                	li	a0,0
    4a34:	00001097          	auipc	ra,0x1
    4a38:	18c080e7          	jalr	396(ra) # 5bc0 <exit>
      printf("couldn't allocate mem?!!\n", s);
    4a3c:	85ce                	mv	a1,s3
    4a3e:	00003517          	auipc	a0,0x3
    4a42:	31250513          	addi	a0,a0,786 # 7d50 <malloc+0x1d5e>
    4a46:	00001097          	auipc	ra,0x1
    4a4a:	4f4080e7          	jalr	1268(ra) # 5f3a <printf>
      exit(1);
    4a4e:	4505                	li	a0,1
    4a50:	00001097          	auipc	ra,0x1
    4a54:	170080e7          	jalr	368(ra) # 5bc0 <exit>
      exit(0);
    4a58:	4501                	li	a0,0
    4a5a:	00001097          	auipc	ra,0x1
    4a5e:	166080e7          	jalr	358(ra) # 5bc0 <exit>

0000000000004a62 <sharedfd>:
{
    4a62:	7159                	addi	sp,sp,-112
    4a64:	f486                	sd	ra,104(sp)
    4a66:	f0a2                	sd	s0,96(sp)
    4a68:	eca6                	sd	s1,88(sp)
    4a6a:	e8ca                	sd	s2,80(sp)
    4a6c:	e4ce                	sd	s3,72(sp)
    4a6e:	e0d2                	sd	s4,64(sp)
    4a70:	fc56                	sd	s5,56(sp)
    4a72:	f85a                	sd	s6,48(sp)
    4a74:	f45e                	sd	s7,40(sp)
    4a76:	1880                	addi	s0,sp,112
    4a78:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    4a7a:	00003517          	auipc	a0,0x3
    4a7e:	2f650513          	addi	a0,a0,758 # 7d70 <malloc+0x1d7e>
    4a82:	00001097          	auipc	ra,0x1
    4a86:	18e080e7          	jalr	398(ra) # 5c10 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    4a8a:	20200593          	li	a1,514
    4a8e:	00003517          	auipc	a0,0x3
    4a92:	2e250513          	addi	a0,a0,738 # 7d70 <malloc+0x1d7e>
    4a96:	00001097          	auipc	ra,0x1
    4a9a:	16a080e7          	jalr	362(ra) # 5c00 <open>
  if(fd < 0){
    4a9e:	04054a63          	bltz	a0,4af2 <sharedfd+0x90>
    4aa2:	892a                	mv	s2,a0
  pid = fork();
    4aa4:	00001097          	auipc	ra,0x1
    4aa8:	114080e7          	jalr	276(ra) # 5bb8 <fork>
    4aac:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    4aae:	06300593          	li	a1,99
    4ab2:	c119                	beqz	a0,4ab8 <sharedfd+0x56>
    4ab4:	07000593          	li	a1,112
    4ab8:	4629                	li	a2,10
    4aba:	fa040513          	addi	a0,s0,-96
    4abe:	00001097          	auipc	ra,0x1
    4ac2:	f08080e7          	jalr	-248(ra) # 59c6 <memset>
    4ac6:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4aca:	4629                	li	a2,10
    4acc:	fa040593          	addi	a1,s0,-96
    4ad0:	854a                	mv	a0,s2
    4ad2:	00001097          	auipc	ra,0x1
    4ad6:	10e080e7          	jalr	270(ra) # 5be0 <write>
    4ada:	47a9                	li	a5,10
    4adc:	02f51963          	bne	a0,a5,4b0e <sharedfd+0xac>
  for(i = 0; i < N; i++){
    4ae0:	34fd                	addiw	s1,s1,-1
    4ae2:	f4e5                	bnez	s1,4aca <sharedfd+0x68>
  if(pid == 0) {
    4ae4:	04099363          	bnez	s3,4b2a <sharedfd+0xc8>
    exit(0);
    4ae8:	4501                	li	a0,0
    4aea:	00001097          	auipc	ra,0x1
    4aee:	0d6080e7          	jalr	214(ra) # 5bc0 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    4af2:	85d2                	mv	a1,s4
    4af4:	00003517          	auipc	a0,0x3
    4af8:	28c50513          	addi	a0,a0,652 # 7d80 <malloc+0x1d8e>
    4afc:	00001097          	auipc	ra,0x1
    4b00:	43e080e7          	jalr	1086(ra) # 5f3a <printf>
    exit(1);
    4b04:	4505                	li	a0,1
    4b06:	00001097          	auipc	ra,0x1
    4b0a:	0ba080e7          	jalr	186(ra) # 5bc0 <exit>
      printf("%s: write sharedfd failed\n", s);
    4b0e:	85d2                	mv	a1,s4
    4b10:	00003517          	auipc	a0,0x3
    4b14:	29850513          	addi	a0,a0,664 # 7da8 <malloc+0x1db6>
    4b18:	00001097          	auipc	ra,0x1
    4b1c:	422080e7          	jalr	1058(ra) # 5f3a <printf>
      exit(1);
    4b20:	4505                	li	a0,1
    4b22:	00001097          	auipc	ra,0x1
    4b26:	09e080e7          	jalr	158(ra) # 5bc0 <exit>
    wait(&xstatus);
    4b2a:	f9c40513          	addi	a0,s0,-100
    4b2e:	00001097          	auipc	ra,0x1
    4b32:	09a080e7          	jalr	154(ra) # 5bc8 <wait>
    if(xstatus != 0)
    4b36:	f9c42983          	lw	s3,-100(s0)
    4b3a:	00098763          	beqz	s3,4b48 <sharedfd+0xe6>
      exit(xstatus);
    4b3e:	854e                	mv	a0,s3
    4b40:	00001097          	auipc	ra,0x1
    4b44:	080080e7          	jalr	128(ra) # 5bc0 <exit>
  close(fd);
    4b48:	854a                	mv	a0,s2
    4b4a:	00001097          	auipc	ra,0x1
    4b4e:	09e080e7          	jalr	158(ra) # 5be8 <close>
  fd = open("sharedfd", 0);
    4b52:	4581                	li	a1,0
    4b54:	00003517          	auipc	a0,0x3
    4b58:	21c50513          	addi	a0,a0,540 # 7d70 <malloc+0x1d7e>
    4b5c:	00001097          	auipc	ra,0x1
    4b60:	0a4080e7          	jalr	164(ra) # 5c00 <open>
    4b64:	8baa                	mv	s7,a0
  nc = np = 0;
    4b66:	8ace                	mv	s5,s3
  if(fd < 0){
    4b68:	02054563          	bltz	a0,4b92 <sharedfd+0x130>
    4b6c:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    4b70:	06300493          	li	s1,99
      if(buf[i] == 'p')
    4b74:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    4b78:	4629                	li	a2,10
    4b7a:	fa040593          	addi	a1,s0,-96
    4b7e:	855e                	mv	a0,s7
    4b80:	00001097          	auipc	ra,0x1
    4b84:	058080e7          	jalr	88(ra) # 5bd8 <read>
    4b88:	02a05f63          	blez	a0,4bc6 <sharedfd+0x164>
    4b8c:	fa040793          	addi	a5,s0,-96
    4b90:	a01d                	j	4bb6 <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    4b92:	85d2                	mv	a1,s4
    4b94:	00003517          	auipc	a0,0x3
    4b98:	23450513          	addi	a0,a0,564 # 7dc8 <malloc+0x1dd6>
    4b9c:	00001097          	auipc	ra,0x1
    4ba0:	39e080e7          	jalr	926(ra) # 5f3a <printf>
    exit(1);
    4ba4:	4505                	li	a0,1
    4ba6:	00001097          	auipc	ra,0x1
    4baa:	01a080e7          	jalr	26(ra) # 5bc0 <exit>
        nc++;
    4bae:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    4bb0:	0785                	addi	a5,a5,1
    4bb2:	fd2783e3          	beq	a5,s2,4b78 <sharedfd+0x116>
      if(buf[i] == 'c')
    4bb6:	0007c703          	lbu	a4,0(a5)
    4bba:	fe970ae3          	beq	a4,s1,4bae <sharedfd+0x14c>
      if(buf[i] == 'p')
    4bbe:	ff6719e3          	bne	a4,s6,4bb0 <sharedfd+0x14e>
        np++;
    4bc2:	2a85                	addiw	s5,s5,1
    4bc4:	b7f5                	j	4bb0 <sharedfd+0x14e>
  close(fd);
    4bc6:	855e                	mv	a0,s7
    4bc8:	00001097          	auipc	ra,0x1
    4bcc:	020080e7          	jalr	32(ra) # 5be8 <close>
  unlink("sharedfd");
    4bd0:	00003517          	auipc	a0,0x3
    4bd4:	1a050513          	addi	a0,a0,416 # 7d70 <malloc+0x1d7e>
    4bd8:	00001097          	auipc	ra,0x1
    4bdc:	038080e7          	jalr	56(ra) # 5c10 <unlink>
  if(nc == N*SZ && np == N*SZ){
    4be0:	6789                	lui	a5,0x2
    4be2:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0x106>
    4be6:	00f99763          	bne	s3,a5,4bf4 <sharedfd+0x192>
    4bea:	6789                	lui	a5,0x2
    4bec:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0x106>
    4bf0:	02fa8063          	beq	s5,a5,4c10 <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    4bf4:	85d2                	mv	a1,s4
    4bf6:	00003517          	auipc	a0,0x3
    4bfa:	1fa50513          	addi	a0,a0,506 # 7df0 <malloc+0x1dfe>
    4bfe:	00001097          	auipc	ra,0x1
    4c02:	33c080e7          	jalr	828(ra) # 5f3a <printf>
    exit(1);
    4c06:	4505                	li	a0,1
    4c08:	00001097          	auipc	ra,0x1
    4c0c:	fb8080e7          	jalr	-72(ra) # 5bc0 <exit>
    exit(0);
    4c10:	4501                	li	a0,0
    4c12:	00001097          	auipc	ra,0x1
    4c16:	fae080e7          	jalr	-82(ra) # 5bc0 <exit>

0000000000004c1a <fourfiles>:
{
    4c1a:	7171                	addi	sp,sp,-176
    4c1c:	f506                	sd	ra,168(sp)
    4c1e:	f122                	sd	s0,160(sp)
    4c20:	ed26                	sd	s1,152(sp)
    4c22:	e94a                	sd	s2,144(sp)
    4c24:	e54e                	sd	s3,136(sp)
    4c26:	e152                	sd	s4,128(sp)
    4c28:	fcd6                	sd	s5,120(sp)
    4c2a:	f8da                	sd	s6,112(sp)
    4c2c:	f4de                	sd	s7,104(sp)
    4c2e:	f0e2                	sd	s8,96(sp)
    4c30:	ece6                	sd	s9,88(sp)
    4c32:	e8ea                	sd	s10,80(sp)
    4c34:	e4ee                	sd	s11,72(sp)
    4c36:	1900                	addi	s0,sp,176
    4c38:	f4a43c23          	sd	a0,-168(s0)
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c3c:	00003797          	auipc	a5,0x3
    4c40:	1cc78793          	addi	a5,a5,460 # 7e08 <malloc+0x1e16>
    4c44:	f6f43823          	sd	a5,-144(s0)
    4c48:	00003797          	auipc	a5,0x3
    4c4c:	1c878793          	addi	a5,a5,456 # 7e10 <malloc+0x1e1e>
    4c50:	f6f43c23          	sd	a5,-136(s0)
    4c54:	00003797          	auipc	a5,0x3
    4c58:	1c478793          	addi	a5,a5,452 # 7e18 <malloc+0x1e26>
    4c5c:	f8f43023          	sd	a5,-128(s0)
    4c60:	00003797          	auipc	a5,0x3
    4c64:	1c078793          	addi	a5,a5,448 # 7e20 <malloc+0x1e2e>
    4c68:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    4c6c:	f7040c13          	addi	s8,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c70:	8962                	mv	s2,s8
  for(pi = 0; pi < NCHILD; pi++){
    4c72:	4481                	li	s1,0
    4c74:	4a11                	li	s4,4
    fname = names[pi];
    4c76:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4c7a:	854e                	mv	a0,s3
    4c7c:	00001097          	auipc	ra,0x1
    4c80:	f94080e7          	jalr	-108(ra) # 5c10 <unlink>
    pid = fork();
    4c84:	00001097          	auipc	ra,0x1
    4c88:	f34080e7          	jalr	-204(ra) # 5bb8 <fork>
    if(pid < 0){
    4c8c:	04054463          	bltz	a0,4cd4 <fourfiles+0xba>
    if(pid == 0){
    4c90:	c12d                	beqz	a0,4cf2 <fourfiles+0xd8>
  for(pi = 0; pi < NCHILD; pi++){
    4c92:	2485                	addiw	s1,s1,1
    4c94:	0921                	addi	s2,s2,8
    4c96:	ff4490e3          	bne	s1,s4,4c76 <fourfiles+0x5c>
    4c9a:	4491                	li	s1,4
    wait(&xstatus);
    4c9c:	f6c40513          	addi	a0,s0,-148
    4ca0:	00001097          	auipc	ra,0x1
    4ca4:	f28080e7          	jalr	-216(ra) # 5bc8 <wait>
    if(xstatus != 0)
    4ca8:	f6c42b03          	lw	s6,-148(s0)
    4cac:	0c0b1e63          	bnez	s6,4d88 <fourfiles+0x16e>
  for(pi = 0; pi < NCHILD; pi++){
    4cb0:	34fd                	addiw	s1,s1,-1
    4cb2:	f4ed                	bnez	s1,4c9c <fourfiles+0x82>
    4cb4:	03000b93          	li	s7,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4cb8:	00008a17          	auipc	s4,0x8
    4cbc:	fc0a0a13          	addi	s4,s4,-64 # cc78 <buf>
    4cc0:	00008a97          	auipc	s5,0x8
    4cc4:	fb9a8a93          	addi	s5,s5,-71 # cc79 <buf+0x1>
    if(total != N*SZ){
    4cc8:	6d85                	lui	s11,0x1
    4cca:	770d8d93          	addi	s11,s11,1904 # 1770 <exectest+0x30>
  for(i = 0; i < NCHILD; i++){
    4cce:	03400d13          	li	s10,52
    4cd2:	aa1d                	j	4e08 <fourfiles+0x1ee>
      printf("fork failed\n", s);
    4cd4:	f5843583          	ld	a1,-168(s0)
    4cd8:	00002517          	auipc	a0,0x2
    4cdc:	0d050513          	addi	a0,a0,208 # 6da8 <malloc+0xdb6>
    4ce0:	00001097          	auipc	ra,0x1
    4ce4:	25a080e7          	jalr	602(ra) # 5f3a <printf>
      exit(1);
    4ce8:	4505                	li	a0,1
    4cea:	00001097          	auipc	ra,0x1
    4cee:	ed6080e7          	jalr	-298(ra) # 5bc0 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    4cf2:	20200593          	li	a1,514
    4cf6:	854e                	mv	a0,s3
    4cf8:	00001097          	auipc	ra,0x1
    4cfc:	f08080e7          	jalr	-248(ra) # 5c00 <open>
    4d00:	892a                	mv	s2,a0
      if(fd < 0){
    4d02:	04054763          	bltz	a0,4d50 <fourfiles+0x136>
      memset(buf, '0'+pi, SZ);
    4d06:	1f400613          	li	a2,500
    4d0a:	0304859b          	addiw	a1,s1,48
    4d0e:	00008517          	auipc	a0,0x8
    4d12:	f6a50513          	addi	a0,a0,-150 # cc78 <buf>
    4d16:	00001097          	auipc	ra,0x1
    4d1a:	cb0080e7          	jalr	-848(ra) # 59c6 <memset>
    4d1e:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    4d20:	00008997          	auipc	s3,0x8
    4d24:	f5898993          	addi	s3,s3,-168 # cc78 <buf>
    4d28:	1f400613          	li	a2,500
    4d2c:	85ce                	mv	a1,s3
    4d2e:	854a                	mv	a0,s2
    4d30:	00001097          	auipc	ra,0x1
    4d34:	eb0080e7          	jalr	-336(ra) # 5be0 <write>
    4d38:	85aa                	mv	a1,a0
    4d3a:	1f400793          	li	a5,500
    4d3e:	02f51863          	bne	a0,a5,4d6e <fourfiles+0x154>
      for(i = 0; i < N; i++){
    4d42:	34fd                	addiw	s1,s1,-1
    4d44:	f0f5                	bnez	s1,4d28 <fourfiles+0x10e>
      exit(0);
    4d46:	4501                	li	a0,0
    4d48:	00001097          	auipc	ra,0x1
    4d4c:	e78080e7          	jalr	-392(ra) # 5bc0 <exit>
        printf("create failed\n", s);
    4d50:	f5843583          	ld	a1,-168(s0)
    4d54:	00003517          	auipc	a0,0x3
    4d58:	0d450513          	addi	a0,a0,212 # 7e28 <malloc+0x1e36>
    4d5c:	00001097          	auipc	ra,0x1
    4d60:	1de080e7          	jalr	478(ra) # 5f3a <printf>
        exit(1);
    4d64:	4505                	li	a0,1
    4d66:	00001097          	auipc	ra,0x1
    4d6a:	e5a080e7          	jalr	-422(ra) # 5bc0 <exit>
          printf("write failed %d\n", n);
    4d6e:	00003517          	auipc	a0,0x3
    4d72:	0ca50513          	addi	a0,a0,202 # 7e38 <malloc+0x1e46>
    4d76:	00001097          	auipc	ra,0x1
    4d7a:	1c4080e7          	jalr	452(ra) # 5f3a <printf>
          exit(1);
    4d7e:	4505                	li	a0,1
    4d80:	00001097          	auipc	ra,0x1
    4d84:	e40080e7          	jalr	-448(ra) # 5bc0 <exit>
      exit(xstatus);
    4d88:	855a                	mv	a0,s6
    4d8a:	00001097          	auipc	ra,0x1
    4d8e:	e36080e7          	jalr	-458(ra) # 5bc0 <exit>
          printf("wrong char\n", s);
    4d92:	f5843583          	ld	a1,-168(s0)
    4d96:	00003517          	auipc	a0,0x3
    4d9a:	0ba50513          	addi	a0,a0,186 # 7e50 <malloc+0x1e5e>
    4d9e:	00001097          	auipc	ra,0x1
    4da2:	19c080e7          	jalr	412(ra) # 5f3a <printf>
          exit(1);
    4da6:	4505                	li	a0,1
    4da8:	00001097          	auipc	ra,0x1
    4dac:	e18080e7          	jalr	-488(ra) # 5bc0 <exit>
      total += n;
    4db0:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4db4:	660d                	lui	a2,0x3
    4db6:	85d2                	mv	a1,s4
    4db8:	854e                	mv	a0,s3
    4dba:	00001097          	auipc	ra,0x1
    4dbe:	e1e080e7          	jalr	-482(ra) # 5bd8 <read>
    4dc2:	02a05363          	blez	a0,4de8 <fourfiles+0x1ce>
    4dc6:	00008797          	auipc	a5,0x8
    4dca:	eb278793          	addi	a5,a5,-334 # cc78 <buf>
    4dce:	fff5069b          	addiw	a3,a0,-1
    4dd2:	1682                	slli	a3,a3,0x20
    4dd4:	9281                	srli	a3,a3,0x20
    4dd6:	96d6                	add	a3,a3,s5
        if(buf[j] != '0'+i){
    4dd8:	0007c703          	lbu	a4,0(a5)
    4ddc:	fa971be3          	bne	a4,s1,4d92 <fourfiles+0x178>
      for(j = 0; j < n; j++){
    4de0:	0785                	addi	a5,a5,1
    4de2:	fed79be3          	bne	a5,a3,4dd8 <fourfiles+0x1be>
    4de6:	b7e9                	j	4db0 <fourfiles+0x196>
    close(fd);
    4de8:	854e                	mv	a0,s3
    4dea:	00001097          	auipc	ra,0x1
    4dee:	dfe080e7          	jalr	-514(ra) # 5be8 <close>
    if(total != N*SZ){
    4df2:	03b91863          	bne	s2,s11,4e22 <fourfiles+0x208>
    unlink(fname);
    4df6:	8566                	mv	a0,s9
    4df8:	00001097          	auipc	ra,0x1
    4dfc:	e18080e7          	jalr	-488(ra) # 5c10 <unlink>
  for(i = 0; i < NCHILD; i++){
    4e00:	0c21                	addi	s8,s8,8
    4e02:	2b85                	addiw	s7,s7,1
    4e04:	03ab8d63          	beq	s7,s10,4e3e <fourfiles+0x224>
    fname = names[i];
    4e08:	000c3c83          	ld	s9,0(s8)
    fd = open(fname, 0);
    4e0c:	4581                	li	a1,0
    4e0e:	8566                	mv	a0,s9
    4e10:	00001097          	auipc	ra,0x1
    4e14:	df0080e7          	jalr	-528(ra) # 5c00 <open>
    4e18:	89aa                	mv	s3,a0
    total = 0;
    4e1a:	895a                	mv	s2,s6
        if(buf[j] != '0'+i){
    4e1c:	000b849b          	sext.w	s1,s7
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4e20:	bf51                	j	4db4 <fourfiles+0x19a>
      printf("wrong length %d\n", total);
    4e22:	85ca                	mv	a1,s2
    4e24:	00003517          	auipc	a0,0x3
    4e28:	03c50513          	addi	a0,a0,60 # 7e60 <malloc+0x1e6e>
    4e2c:	00001097          	auipc	ra,0x1
    4e30:	10e080e7          	jalr	270(ra) # 5f3a <printf>
      exit(1);
    4e34:	4505                	li	a0,1
    4e36:	00001097          	auipc	ra,0x1
    4e3a:	d8a080e7          	jalr	-630(ra) # 5bc0 <exit>
}
    4e3e:	70aa                	ld	ra,168(sp)
    4e40:	740a                	ld	s0,160(sp)
    4e42:	64ea                	ld	s1,152(sp)
    4e44:	694a                	ld	s2,144(sp)
    4e46:	69aa                	ld	s3,136(sp)
    4e48:	6a0a                	ld	s4,128(sp)
    4e4a:	7ae6                	ld	s5,120(sp)
    4e4c:	7b46                	ld	s6,112(sp)
    4e4e:	7ba6                	ld	s7,104(sp)
    4e50:	7c06                	ld	s8,96(sp)
    4e52:	6ce6                	ld	s9,88(sp)
    4e54:	6d46                	ld	s10,80(sp)
    4e56:	6da6                	ld	s11,72(sp)
    4e58:	614d                	addi	sp,sp,176
    4e5a:	8082                	ret

0000000000004e5c <concreate>:
{
    4e5c:	7135                	addi	sp,sp,-160
    4e5e:	ed06                	sd	ra,152(sp)
    4e60:	e922                	sd	s0,144(sp)
    4e62:	e526                	sd	s1,136(sp)
    4e64:	e14a                	sd	s2,128(sp)
    4e66:	fcce                	sd	s3,120(sp)
    4e68:	f8d2                	sd	s4,112(sp)
    4e6a:	f4d6                	sd	s5,104(sp)
    4e6c:	f0da                	sd	s6,96(sp)
    4e6e:	ecde                	sd	s7,88(sp)
    4e70:	1100                	addi	s0,sp,160
    4e72:	89aa                	mv	s3,a0
  file[0] = 'C';
    4e74:	04300793          	li	a5,67
    4e78:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    4e7c:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    4e80:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    4e82:	4b0d                	li	s6,3
    4e84:	4a85                	li	s5,1
      link("C0", file);
    4e86:	00003b97          	auipc	s7,0x3
    4e8a:	ff2b8b93          	addi	s7,s7,-14 # 7e78 <malloc+0x1e86>
  for(i = 0; i < N; i++){
    4e8e:	02800a13          	li	s4,40
    4e92:	acc9                	j	5164 <concreate+0x308>
      link("C0", file);
    4e94:	fa840593          	addi	a1,s0,-88
    4e98:	855e                	mv	a0,s7
    4e9a:	00001097          	auipc	ra,0x1
    4e9e:	d86080e7          	jalr	-634(ra) # 5c20 <link>
    if(pid == 0) {
    4ea2:	a465                	j	514a <concreate+0x2ee>
    } else if(pid == 0 && (i % 5) == 1){
    4ea4:	4795                	li	a5,5
    4ea6:	02f9693b          	remw	s2,s2,a5
    4eaa:	4785                	li	a5,1
    4eac:	02f90b63          	beq	s2,a5,4ee2 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4eb0:	20200593          	li	a1,514
    4eb4:	fa840513          	addi	a0,s0,-88
    4eb8:	00001097          	auipc	ra,0x1
    4ebc:	d48080e7          	jalr	-696(ra) # 5c00 <open>
      if(fd < 0){
    4ec0:	26055c63          	bgez	a0,5138 <concreate+0x2dc>
        printf("concreate create %s failed\n", file);
    4ec4:	fa840593          	addi	a1,s0,-88
    4ec8:	00003517          	auipc	a0,0x3
    4ecc:	fb850513          	addi	a0,a0,-72 # 7e80 <malloc+0x1e8e>
    4ed0:	00001097          	auipc	ra,0x1
    4ed4:	06a080e7          	jalr	106(ra) # 5f3a <printf>
        exit(1);
    4ed8:	4505                	li	a0,1
    4eda:	00001097          	auipc	ra,0x1
    4ede:	ce6080e7          	jalr	-794(ra) # 5bc0 <exit>
      link("C0", file);
    4ee2:	fa840593          	addi	a1,s0,-88
    4ee6:	00003517          	auipc	a0,0x3
    4eea:	f9250513          	addi	a0,a0,-110 # 7e78 <malloc+0x1e86>
    4eee:	00001097          	auipc	ra,0x1
    4ef2:	d32080e7          	jalr	-718(ra) # 5c20 <link>
      exit(0);
    4ef6:	4501                	li	a0,0
    4ef8:	00001097          	auipc	ra,0x1
    4efc:	cc8080e7          	jalr	-824(ra) # 5bc0 <exit>
        exit(1);
    4f00:	4505                	li	a0,1
    4f02:	00001097          	auipc	ra,0x1
    4f06:	cbe080e7          	jalr	-834(ra) # 5bc0 <exit>
  memset(fa, 0, sizeof(fa));
    4f0a:	02800613          	li	a2,40
    4f0e:	4581                	li	a1,0
    4f10:	f8040513          	addi	a0,s0,-128
    4f14:	00001097          	auipc	ra,0x1
    4f18:	ab2080e7          	jalr	-1358(ra) # 59c6 <memset>
  fd = open(".", 0);
    4f1c:	4581                	li	a1,0
    4f1e:	00002517          	auipc	a0,0x2
    4f22:	8e250513          	addi	a0,a0,-1822 # 6800 <malloc+0x80e>
    4f26:	00001097          	auipc	ra,0x1
    4f2a:	cda080e7          	jalr	-806(ra) # 5c00 <open>
    4f2e:	892a                	mv	s2,a0
  n = 0;
    4f30:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f32:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4f36:	02700b13          	li	s6,39
      fa[i] = 1;
    4f3a:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4f3c:	4641                	li	a2,16
    4f3e:	f7040593          	addi	a1,s0,-144
    4f42:	854a                	mv	a0,s2
    4f44:	00001097          	auipc	ra,0x1
    4f48:	c94080e7          	jalr	-876(ra) # 5bd8 <read>
    4f4c:	08a05263          	blez	a0,4fd0 <concreate+0x174>
    if(de.inum == 0)
    4f50:	f7045783          	lhu	a5,-144(s0)
    4f54:	d7e5                	beqz	a5,4f3c <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f56:	f7244783          	lbu	a5,-142(s0)
    4f5a:	ff4791e3          	bne	a5,s4,4f3c <concreate+0xe0>
    4f5e:	f7444783          	lbu	a5,-140(s0)
    4f62:	ffe9                	bnez	a5,4f3c <concreate+0xe0>
      i = de.name[1] - '0';
    4f64:	f7344783          	lbu	a5,-141(s0)
    4f68:	fd07879b          	addiw	a5,a5,-48
    4f6c:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    4f70:	02eb6063          	bltu	s6,a4,4f90 <concreate+0x134>
      if(fa[i]){
    4f74:	fb070793          	addi	a5,a4,-80 # fb0 <linktest+0xbc>
    4f78:	97a2                	add	a5,a5,s0
    4f7a:	fd07c783          	lbu	a5,-48(a5)
    4f7e:	eb8d                	bnez	a5,4fb0 <concreate+0x154>
      fa[i] = 1;
    4f80:	fb070793          	addi	a5,a4,-80
    4f84:	00878733          	add	a4,a5,s0
    4f88:	fd770823          	sb	s7,-48(a4)
      n++;
    4f8c:	2a85                	addiw	s5,s5,1
    4f8e:	b77d                	j	4f3c <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    4f90:	f7240613          	addi	a2,s0,-142
    4f94:	85ce                	mv	a1,s3
    4f96:	00003517          	auipc	a0,0x3
    4f9a:	f0a50513          	addi	a0,a0,-246 # 7ea0 <malloc+0x1eae>
    4f9e:	00001097          	auipc	ra,0x1
    4fa2:	f9c080e7          	jalr	-100(ra) # 5f3a <printf>
        exit(1);
    4fa6:	4505                	li	a0,1
    4fa8:	00001097          	auipc	ra,0x1
    4fac:	c18080e7          	jalr	-1000(ra) # 5bc0 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4fb0:	f7240613          	addi	a2,s0,-142
    4fb4:	85ce                	mv	a1,s3
    4fb6:	00003517          	auipc	a0,0x3
    4fba:	f0a50513          	addi	a0,a0,-246 # 7ec0 <malloc+0x1ece>
    4fbe:	00001097          	auipc	ra,0x1
    4fc2:	f7c080e7          	jalr	-132(ra) # 5f3a <printf>
        exit(1);
    4fc6:	4505                	li	a0,1
    4fc8:	00001097          	auipc	ra,0x1
    4fcc:	bf8080e7          	jalr	-1032(ra) # 5bc0 <exit>
  close(fd);
    4fd0:	854a                	mv	a0,s2
    4fd2:	00001097          	auipc	ra,0x1
    4fd6:	c16080e7          	jalr	-1002(ra) # 5be8 <close>
  if(n != N){
    4fda:	02800793          	li	a5,40
    4fde:	00fa9763          	bne	s5,a5,4fec <concreate+0x190>
    if(((i % 3) == 0 && pid == 0) ||
    4fe2:	4a8d                	li	s5,3
    4fe4:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4fe6:	02800a13          	li	s4,40
    4fea:	a8c9                	j	50bc <concreate+0x260>
    printf("%s: concreate not enough files in directory listing\n", s);
    4fec:	85ce                	mv	a1,s3
    4fee:	00003517          	auipc	a0,0x3
    4ff2:	efa50513          	addi	a0,a0,-262 # 7ee8 <malloc+0x1ef6>
    4ff6:	00001097          	auipc	ra,0x1
    4ffa:	f44080e7          	jalr	-188(ra) # 5f3a <printf>
    exit(1);
    4ffe:	4505                	li	a0,1
    5000:	00001097          	auipc	ra,0x1
    5004:	bc0080e7          	jalr	-1088(ra) # 5bc0 <exit>
      printf("%s: fork failed\n", s);
    5008:	85ce                	mv	a1,s3
    500a:	00002517          	auipc	a0,0x2
    500e:	99650513          	addi	a0,a0,-1642 # 69a0 <malloc+0x9ae>
    5012:	00001097          	auipc	ra,0x1
    5016:	f28080e7          	jalr	-216(ra) # 5f3a <printf>
      exit(1);
    501a:	4505                	li	a0,1
    501c:	00001097          	auipc	ra,0x1
    5020:	ba4080e7          	jalr	-1116(ra) # 5bc0 <exit>
      close(open(file, 0));
    5024:	4581                	li	a1,0
    5026:	fa840513          	addi	a0,s0,-88
    502a:	00001097          	auipc	ra,0x1
    502e:	bd6080e7          	jalr	-1066(ra) # 5c00 <open>
    5032:	00001097          	auipc	ra,0x1
    5036:	bb6080e7          	jalr	-1098(ra) # 5be8 <close>
      close(open(file, 0));
    503a:	4581                	li	a1,0
    503c:	fa840513          	addi	a0,s0,-88
    5040:	00001097          	auipc	ra,0x1
    5044:	bc0080e7          	jalr	-1088(ra) # 5c00 <open>
    5048:	00001097          	auipc	ra,0x1
    504c:	ba0080e7          	jalr	-1120(ra) # 5be8 <close>
      close(open(file, 0));
    5050:	4581                	li	a1,0
    5052:	fa840513          	addi	a0,s0,-88
    5056:	00001097          	auipc	ra,0x1
    505a:	baa080e7          	jalr	-1110(ra) # 5c00 <open>
    505e:	00001097          	auipc	ra,0x1
    5062:	b8a080e7          	jalr	-1142(ra) # 5be8 <close>
      close(open(file, 0));
    5066:	4581                	li	a1,0
    5068:	fa840513          	addi	a0,s0,-88
    506c:	00001097          	auipc	ra,0x1
    5070:	b94080e7          	jalr	-1132(ra) # 5c00 <open>
    5074:	00001097          	auipc	ra,0x1
    5078:	b74080e7          	jalr	-1164(ra) # 5be8 <close>
      close(open(file, 0));
    507c:	4581                	li	a1,0
    507e:	fa840513          	addi	a0,s0,-88
    5082:	00001097          	auipc	ra,0x1
    5086:	b7e080e7          	jalr	-1154(ra) # 5c00 <open>
    508a:	00001097          	auipc	ra,0x1
    508e:	b5e080e7          	jalr	-1186(ra) # 5be8 <close>
      close(open(file, 0));
    5092:	4581                	li	a1,0
    5094:	fa840513          	addi	a0,s0,-88
    5098:	00001097          	auipc	ra,0x1
    509c:	b68080e7          	jalr	-1176(ra) # 5c00 <open>
    50a0:	00001097          	auipc	ra,0x1
    50a4:	b48080e7          	jalr	-1208(ra) # 5be8 <close>
    if(pid == 0)
    50a8:	08090363          	beqz	s2,512e <concreate+0x2d2>
      wait(0);
    50ac:	4501                	li	a0,0
    50ae:	00001097          	auipc	ra,0x1
    50b2:	b1a080e7          	jalr	-1254(ra) # 5bc8 <wait>
  for(i = 0; i < N; i++){
    50b6:	2485                	addiw	s1,s1,1
    50b8:	0f448563          	beq	s1,s4,51a2 <concreate+0x346>
    file[1] = '0' + i;
    50bc:	0304879b          	addiw	a5,s1,48
    50c0:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    50c4:	00001097          	auipc	ra,0x1
    50c8:	af4080e7          	jalr	-1292(ra) # 5bb8 <fork>
    50cc:	892a                	mv	s2,a0
    if(pid < 0){
    50ce:	f2054de3          	bltz	a0,5008 <concreate+0x1ac>
    if(((i % 3) == 0 && pid == 0) ||
    50d2:	0354e73b          	remw	a4,s1,s5
    50d6:	00a767b3          	or	a5,a4,a0
    50da:	2781                	sext.w	a5,a5
    50dc:	d7a1                	beqz	a5,5024 <concreate+0x1c8>
    50de:	01671363          	bne	a4,s6,50e4 <concreate+0x288>
       ((i % 3) == 1 && pid != 0)){
    50e2:	f129                	bnez	a0,5024 <concreate+0x1c8>
      unlink(file);
    50e4:	fa840513          	addi	a0,s0,-88
    50e8:	00001097          	auipc	ra,0x1
    50ec:	b28080e7          	jalr	-1240(ra) # 5c10 <unlink>
      unlink(file);
    50f0:	fa840513          	addi	a0,s0,-88
    50f4:	00001097          	auipc	ra,0x1
    50f8:	b1c080e7          	jalr	-1252(ra) # 5c10 <unlink>
      unlink(file);
    50fc:	fa840513          	addi	a0,s0,-88
    5100:	00001097          	auipc	ra,0x1
    5104:	b10080e7          	jalr	-1264(ra) # 5c10 <unlink>
      unlink(file);
    5108:	fa840513          	addi	a0,s0,-88
    510c:	00001097          	auipc	ra,0x1
    5110:	b04080e7          	jalr	-1276(ra) # 5c10 <unlink>
      unlink(file);
    5114:	fa840513          	addi	a0,s0,-88
    5118:	00001097          	auipc	ra,0x1
    511c:	af8080e7          	jalr	-1288(ra) # 5c10 <unlink>
      unlink(file);
    5120:	fa840513          	addi	a0,s0,-88
    5124:	00001097          	auipc	ra,0x1
    5128:	aec080e7          	jalr	-1300(ra) # 5c10 <unlink>
    512c:	bfb5                	j	50a8 <concreate+0x24c>
      exit(0);
    512e:	4501                	li	a0,0
    5130:	00001097          	auipc	ra,0x1
    5134:	a90080e7          	jalr	-1392(ra) # 5bc0 <exit>
      close(fd);
    5138:	00001097          	auipc	ra,0x1
    513c:	ab0080e7          	jalr	-1360(ra) # 5be8 <close>
    if(pid == 0) {
    5140:	bb5d                	j	4ef6 <concreate+0x9a>
      close(fd);
    5142:	00001097          	auipc	ra,0x1
    5146:	aa6080e7          	jalr	-1370(ra) # 5be8 <close>
      wait(&xstatus);
    514a:	f6c40513          	addi	a0,s0,-148
    514e:	00001097          	auipc	ra,0x1
    5152:	a7a080e7          	jalr	-1414(ra) # 5bc8 <wait>
      if(xstatus != 0)
    5156:	f6c42483          	lw	s1,-148(s0)
    515a:	da0493e3          	bnez	s1,4f00 <concreate+0xa4>
  for(i = 0; i < N; i++){
    515e:	2905                	addiw	s2,s2,1
    5160:	db4905e3          	beq	s2,s4,4f0a <concreate+0xae>
    file[1] = '0' + i;
    5164:	0309079b          	addiw	a5,s2,48
    5168:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    516c:	fa840513          	addi	a0,s0,-88
    5170:	00001097          	auipc	ra,0x1
    5174:	aa0080e7          	jalr	-1376(ra) # 5c10 <unlink>
    pid = fork();
    5178:	00001097          	auipc	ra,0x1
    517c:	a40080e7          	jalr	-1472(ra) # 5bb8 <fork>
    if(pid && (i % 3) == 1){
    5180:	d20502e3          	beqz	a0,4ea4 <concreate+0x48>
    5184:	036967bb          	remw	a5,s2,s6
    5188:	d15786e3          	beq	a5,s5,4e94 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    518c:	20200593          	li	a1,514
    5190:	fa840513          	addi	a0,s0,-88
    5194:	00001097          	auipc	ra,0x1
    5198:	a6c080e7          	jalr	-1428(ra) # 5c00 <open>
      if(fd < 0){
    519c:	fa0553e3          	bgez	a0,5142 <concreate+0x2e6>
    51a0:	b315                	j	4ec4 <concreate+0x68>
}
    51a2:	60ea                	ld	ra,152(sp)
    51a4:	644a                	ld	s0,144(sp)
    51a6:	64aa                	ld	s1,136(sp)
    51a8:	690a                	ld	s2,128(sp)
    51aa:	79e6                	ld	s3,120(sp)
    51ac:	7a46                	ld	s4,112(sp)
    51ae:	7aa6                	ld	s5,104(sp)
    51b0:	7b06                	ld	s6,96(sp)
    51b2:	6be6                	ld	s7,88(sp)
    51b4:	610d                	addi	sp,sp,160
    51b6:	8082                	ret

00000000000051b8 <bigfile>:
{
    51b8:	7139                	addi	sp,sp,-64
    51ba:	fc06                	sd	ra,56(sp)
    51bc:	f822                	sd	s0,48(sp)
    51be:	f426                	sd	s1,40(sp)
    51c0:	f04a                	sd	s2,32(sp)
    51c2:	ec4e                	sd	s3,24(sp)
    51c4:	e852                	sd	s4,16(sp)
    51c6:	e456                	sd	s5,8(sp)
    51c8:	0080                	addi	s0,sp,64
    51ca:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    51cc:	00003517          	auipc	a0,0x3
    51d0:	d5450513          	addi	a0,a0,-684 # 7f20 <malloc+0x1f2e>
    51d4:	00001097          	auipc	ra,0x1
    51d8:	a3c080e7          	jalr	-1476(ra) # 5c10 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    51dc:	20200593          	li	a1,514
    51e0:	00003517          	auipc	a0,0x3
    51e4:	d4050513          	addi	a0,a0,-704 # 7f20 <malloc+0x1f2e>
    51e8:	00001097          	auipc	ra,0x1
    51ec:	a18080e7          	jalr	-1512(ra) # 5c00 <open>
    51f0:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    51f2:	4481                	li	s1,0
    memset(buf, i, SZ);
    51f4:	00008917          	auipc	s2,0x8
    51f8:	a8490913          	addi	s2,s2,-1404 # cc78 <buf>
  for(i = 0; i < N; i++){
    51fc:	4a51                	li	s4,20
  if(fd < 0){
    51fe:	0a054063          	bltz	a0,529e <bigfile+0xe6>
    memset(buf, i, SZ);
    5202:	25800613          	li	a2,600
    5206:	85a6                	mv	a1,s1
    5208:	854a                	mv	a0,s2
    520a:	00000097          	auipc	ra,0x0
    520e:	7bc080e7          	jalr	1980(ra) # 59c6 <memset>
    if(write(fd, buf, SZ) != SZ){
    5212:	25800613          	li	a2,600
    5216:	85ca                	mv	a1,s2
    5218:	854e                	mv	a0,s3
    521a:	00001097          	auipc	ra,0x1
    521e:	9c6080e7          	jalr	-1594(ra) # 5be0 <write>
    5222:	25800793          	li	a5,600
    5226:	08f51a63          	bne	a0,a5,52ba <bigfile+0x102>
  for(i = 0; i < N; i++){
    522a:	2485                	addiw	s1,s1,1
    522c:	fd449be3          	bne	s1,s4,5202 <bigfile+0x4a>
  close(fd);
    5230:	854e                	mv	a0,s3
    5232:	00001097          	auipc	ra,0x1
    5236:	9b6080e7          	jalr	-1610(ra) # 5be8 <close>
  fd = open("bigfile.dat", 0);
    523a:	4581                	li	a1,0
    523c:	00003517          	auipc	a0,0x3
    5240:	ce450513          	addi	a0,a0,-796 # 7f20 <malloc+0x1f2e>
    5244:	00001097          	auipc	ra,0x1
    5248:	9bc080e7          	jalr	-1604(ra) # 5c00 <open>
    524c:	8a2a                	mv	s4,a0
  total = 0;
    524e:	4981                	li	s3,0
  for(i = 0; ; i++){
    5250:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    5252:	00008917          	auipc	s2,0x8
    5256:	a2690913          	addi	s2,s2,-1498 # cc78 <buf>
  if(fd < 0){
    525a:	06054e63          	bltz	a0,52d6 <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    525e:	12c00613          	li	a2,300
    5262:	85ca                	mv	a1,s2
    5264:	8552                	mv	a0,s4
    5266:	00001097          	auipc	ra,0x1
    526a:	972080e7          	jalr	-1678(ra) # 5bd8 <read>
    if(cc < 0){
    526e:	08054263          	bltz	a0,52f2 <bigfile+0x13a>
    if(cc == 0)
    5272:	c971                	beqz	a0,5346 <bigfile+0x18e>
    if(cc != SZ/2){
    5274:	12c00793          	li	a5,300
    5278:	08f51b63          	bne	a0,a5,530e <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    527c:	01f4d79b          	srliw	a5,s1,0x1f
    5280:	9fa5                	addw	a5,a5,s1
    5282:	4017d79b          	sraiw	a5,a5,0x1
    5286:	00094703          	lbu	a4,0(s2)
    528a:	0af71063          	bne	a4,a5,532a <bigfile+0x172>
    528e:	12b94703          	lbu	a4,299(s2)
    5292:	08f71c63          	bne	a4,a5,532a <bigfile+0x172>
    total += cc;
    5296:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    529a:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    529c:	b7c9                	j	525e <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    529e:	85d6                	mv	a1,s5
    52a0:	00003517          	auipc	a0,0x3
    52a4:	c9050513          	addi	a0,a0,-880 # 7f30 <malloc+0x1f3e>
    52a8:	00001097          	auipc	ra,0x1
    52ac:	c92080e7          	jalr	-878(ra) # 5f3a <printf>
    exit(1);
    52b0:	4505                	li	a0,1
    52b2:	00001097          	auipc	ra,0x1
    52b6:	90e080e7          	jalr	-1778(ra) # 5bc0 <exit>
      printf("%s: write bigfile failed\n", s);
    52ba:	85d6                	mv	a1,s5
    52bc:	00003517          	auipc	a0,0x3
    52c0:	c9450513          	addi	a0,a0,-876 # 7f50 <malloc+0x1f5e>
    52c4:	00001097          	auipc	ra,0x1
    52c8:	c76080e7          	jalr	-906(ra) # 5f3a <printf>
      exit(1);
    52cc:	4505                	li	a0,1
    52ce:	00001097          	auipc	ra,0x1
    52d2:	8f2080e7          	jalr	-1806(ra) # 5bc0 <exit>
    printf("%s: cannot open bigfile\n", s);
    52d6:	85d6                	mv	a1,s5
    52d8:	00003517          	auipc	a0,0x3
    52dc:	c9850513          	addi	a0,a0,-872 # 7f70 <malloc+0x1f7e>
    52e0:	00001097          	auipc	ra,0x1
    52e4:	c5a080e7          	jalr	-934(ra) # 5f3a <printf>
    exit(1);
    52e8:	4505                	li	a0,1
    52ea:	00001097          	auipc	ra,0x1
    52ee:	8d6080e7          	jalr	-1834(ra) # 5bc0 <exit>
      printf("%s: read bigfile failed\n", s);
    52f2:	85d6                	mv	a1,s5
    52f4:	00003517          	auipc	a0,0x3
    52f8:	c9c50513          	addi	a0,a0,-868 # 7f90 <malloc+0x1f9e>
    52fc:	00001097          	auipc	ra,0x1
    5300:	c3e080e7          	jalr	-962(ra) # 5f3a <printf>
      exit(1);
    5304:	4505                	li	a0,1
    5306:	00001097          	auipc	ra,0x1
    530a:	8ba080e7          	jalr	-1862(ra) # 5bc0 <exit>
      printf("%s: short read bigfile\n", s);
    530e:	85d6                	mv	a1,s5
    5310:	00003517          	auipc	a0,0x3
    5314:	ca050513          	addi	a0,a0,-864 # 7fb0 <malloc+0x1fbe>
    5318:	00001097          	auipc	ra,0x1
    531c:	c22080e7          	jalr	-990(ra) # 5f3a <printf>
      exit(1);
    5320:	4505                	li	a0,1
    5322:	00001097          	auipc	ra,0x1
    5326:	89e080e7          	jalr	-1890(ra) # 5bc0 <exit>
      printf("%s: read bigfile wrong data\n", s);
    532a:	85d6                	mv	a1,s5
    532c:	00003517          	auipc	a0,0x3
    5330:	c9c50513          	addi	a0,a0,-868 # 7fc8 <malloc+0x1fd6>
    5334:	00001097          	auipc	ra,0x1
    5338:	c06080e7          	jalr	-1018(ra) # 5f3a <printf>
      exit(1);
    533c:	4505                	li	a0,1
    533e:	00001097          	auipc	ra,0x1
    5342:	882080e7          	jalr	-1918(ra) # 5bc0 <exit>
  close(fd);
    5346:	8552                	mv	a0,s4
    5348:	00001097          	auipc	ra,0x1
    534c:	8a0080e7          	jalr	-1888(ra) # 5be8 <close>
  if(total != N*SZ){
    5350:	678d                	lui	a5,0x3
    5352:	ee078793          	addi	a5,a5,-288 # 2ee0 <sbrklast+0x8e>
    5356:	02f99363          	bne	s3,a5,537c <bigfile+0x1c4>
  unlink("bigfile.dat");
    535a:	00003517          	auipc	a0,0x3
    535e:	bc650513          	addi	a0,a0,-1082 # 7f20 <malloc+0x1f2e>
    5362:	00001097          	auipc	ra,0x1
    5366:	8ae080e7          	jalr	-1874(ra) # 5c10 <unlink>
}
    536a:	70e2                	ld	ra,56(sp)
    536c:	7442                	ld	s0,48(sp)
    536e:	74a2                	ld	s1,40(sp)
    5370:	7902                	ld	s2,32(sp)
    5372:	69e2                	ld	s3,24(sp)
    5374:	6a42                	ld	s4,16(sp)
    5376:	6aa2                	ld	s5,8(sp)
    5378:	6121                	addi	sp,sp,64
    537a:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    537c:	85d6                	mv	a1,s5
    537e:	00003517          	auipc	a0,0x3
    5382:	c6a50513          	addi	a0,a0,-918 # 7fe8 <malloc+0x1ff6>
    5386:	00001097          	auipc	ra,0x1
    538a:	bb4080e7          	jalr	-1100(ra) # 5f3a <printf>
    exit(1);
    538e:	4505                	li	a0,1
    5390:	00001097          	auipc	ra,0x1
    5394:	830080e7          	jalr	-2000(ra) # 5bc0 <exit>

0000000000005398 <fsfull>:
{
    5398:	7171                	addi	sp,sp,-176
    539a:	f506                	sd	ra,168(sp)
    539c:	f122                	sd	s0,160(sp)
    539e:	ed26                	sd	s1,152(sp)
    53a0:	e94a                	sd	s2,144(sp)
    53a2:	e54e                	sd	s3,136(sp)
    53a4:	e152                	sd	s4,128(sp)
    53a6:	fcd6                	sd	s5,120(sp)
    53a8:	f8da                	sd	s6,112(sp)
    53aa:	f4de                	sd	s7,104(sp)
    53ac:	f0e2                	sd	s8,96(sp)
    53ae:	ece6                	sd	s9,88(sp)
    53b0:	e8ea                	sd	s10,80(sp)
    53b2:	e4ee                	sd	s11,72(sp)
    53b4:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    53b6:	00003517          	auipc	a0,0x3
    53ba:	c5250513          	addi	a0,a0,-942 # 8008 <malloc+0x2016>
    53be:	00001097          	auipc	ra,0x1
    53c2:	b7c080e7          	jalr	-1156(ra) # 5f3a <printf>
  for(nfiles = 0; ; nfiles++){
    53c6:	4481                	li	s1,0
    name[0] = 'f';
    53c8:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    53cc:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    53d0:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    53d4:	4b29                	li	s6,10
    printf("writing %s\n", name);
    53d6:	00003c97          	auipc	s9,0x3
    53da:	c42c8c93          	addi	s9,s9,-958 # 8018 <malloc+0x2026>
    int total = 0;
    53de:	4d81                	li	s11,0
      int cc = write(fd, buf, BSIZE);
    53e0:	00008a17          	auipc	s4,0x8
    53e4:	898a0a13          	addi	s4,s4,-1896 # cc78 <buf>
    name[0] = 'f';
    53e8:	f5a40823          	sb	s10,-176(s0)
    name[1] = '0' + nfiles / 1000;
    53ec:	0384c7bb          	divw	a5,s1,s8
    53f0:	0307879b          	addiw	a5,a5,48
    53f4:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    53f8:	0384e7bb          	remw	a5,s1,s8
    53fc:	0377c7bb          	divw	a5,a5,s7
    5400:	0307879b          	addiw	a5,a5,48
    5404:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5408:	0374e7bb          	remw	a5,s1,s7
    540c:	0367c7bb          	divw	a5,a5,s6
    5410:	0307879b          	addiw	a5,a5,48
    5414:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    5418:	0364e7bb          	remw	a5,s1,s6
    541c:	0307879b          	addiw	a5,a5,48
    5420:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    5424:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    5428:	f5040593          	addi	a1,s0,-176
    542c:	8566                	mv	a0,s9
    542e:	00001097          	auipc	ra,0x1
    5432:	b0c080e7          	jalr	-1268(ra) # 5f3a <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    5436:	20200593          	li	a1,514
    543a:	f5040513          	addi	a0,s0,-176
    543e:	00000097          	auipc	ra,0x0
    5442:	7c2080e7          	jalr	1986(ra) # 5c00 <open>
    5446:	892a                	mv	s2,a0
    if(fd < 0){
    5448:	0a055663          	bgez	a0,54f4 <fsfull+0x15c>
      printf("open %s failed\n", name);
    544c:	f5040593          	addi	a1,s0,-176
    5450:	00003517          	auipc	a0,0x3
    5454:	bd850513          	addi	a0,a0,-1064 # 8028 <malloc+0x2036>
    5458:	00001097          	auipc	ra,0x1
    545c:	ae2080e7          	jalr	-1310(ra) # 5f3a <printf>
  while(nfiles >= 0){
    5460:	0604c363          	bltz	s1,54c6 <fsfull+0x12e>
    name[0] = 'f';
    5464:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    5468:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    546c:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    5470:	4929                	li	s2,10
  while(nfiles >= 0){
    5472:	5afd                	li	s5,-1
    name[0] = 'f';
    5474:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    5478:	0344c7bb          	divw	a5,s1,s4
    547c:	0307879b          	addiw	a5,a5,48
    5480:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5484:	0344e7bb          	remw	a5,s1,s4
    5488:	0337c7bb          	divw	a5,a5,s3
    548c:	0307879b          	addiw	a5,a5,48
    5490:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5494:	0334e7bb          	remw	a5,s1,s3
    5498:	0327c7bb          	divw	a5,a5,s2
    549c:	0307879b          	addiw	a5,a5,48
    54a0:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    54a4:	0324e7bb          	remw	a5,s1,s2
    54a8:	0307879b          	addiw	a5,a5,48
    54ac:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    54b0:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    54b4:	f5040513          	addi	a0,s0,-176
    54b8:	00000097          	auipc	ra,0x0
    54bc:	758080e7          	jalr	1880(ra) # 5c10 <unlink>
    nfiles--;
    54c0:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    54c2:	fb5499e3          	bne	s1,s5,5474 <fsfull+0xdc>
  printf("fsfull test finished\n");
    54c6:	00003517          	auipc	a0,0x3
    54ca:	b8250513          	addi	a0,a0,-1150 # 8048 <malloc+0x2056>
    54ce:	00001097          	auipc	ra,0x1
    54d2:	a6c080e7          	jalr	-1428(ra) # 5f3a <printf>
}
    54d6:	70aa                	ld	ra,168(sp)
    54d8:	740a                	ld	s0,160(sp)
    54da:	64ea                	ld	s1,152(sp)
    54dc:	694a                	ld	s2,144(sp)
    54de:	69aa                	ld	s3,136(sp)
    54e0:	6a0a                	ld	s4,128(sp)
    54e2:	7ae6                	ld	s5,120(sp)
    54e4:	7b46                	ld	s6,112(sp)
    54e6:	7ba6                	ld	s7,104(sp)
    54e8:	7c06                	ld	s8,96(sp)
    54ea:	6ce6                	ld	s9,88(sp)
    54ec:	6d46                	ld	s10,80(sp)
    54ee:	6da6                	ld	s11,72(sp)
    54f0:	614d                	addi	sp,sp,176
    54f2:	8082                	ret
    int total = 0;
    54f4:	89ee                	mv	s3,s11
      if(cc < BSIZE)
    54f6:	3ff00a93          	li	s5,1023
      int cc = write(fd, buf, BSIZE);
    54fa:	40000613          	li	a2,1024
    54fe:	85d2                	mv	a1,s4
    5500:	854a                	mv	a0,s2
    5502:	00000097          	auipc	ra,0x0
    5506:	6de080e7          	jalr	1758(ra) # 5be0 <write>
      if(cc < BSIZE)
    550a:	00aad563          	bge	s5,a0,5514 <fsfull+0x17c>
      total += cc;
    550e:	00a989bb          	addw	s3,s3,a0
    while(1){
    5512:	b7e5                	j	54fa <fsfull+0x162>
    printf("wrote %d bytes\n", total);
    5514:	85ce                	mv	a1,s3
    5516:	00003517          	auipc	a0,0x3
    551a:	b2250513          	addi	a0,a0,-1246 # 8038 <malloc+0x2046>
    551e:	00001097          	auipc	ra,0x1
    5522:	a1c080e7          	jalr	-1508(ra) # 5f3a <printf>
    close(fd);
    5526:	854a                	mv	a0,s2
    5528:	00000097          	auipc	ra,0x0
    552c:	6c0080e7          	jalr	1728(ra) # 5be8 <close>
    if(total == 0)
    5530:	f20988e3          	beqz	s3,5460 <fsfull+0xc8>
  for(nfiles = 0; ; nfiles++){
    5534:	2485                	addiw	s1,s1,1
    5536:	bd4d                	j	53e8 <fsfull+0x50>

0000000000005538 <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    5538:	7179                	addi	sp,sp,-48
    553a:	f406                	sd	ra,40(sp)
    553c:	f022                	sd	s0,32(sp)
    553e:	ec26                	sd	s1,24(sp)
    5540:	e84a                	sd	s2,16(sp)
    5542:	1800                	addi	s0,sp,48
    5544:	84aa                	mv	s1,a0
    5546:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5548:	00003517          	auipc	a0,0x3
    554c:	b1850513          	addi	a0,a0,-1256 # 8060 <malloc+0x206e>
    5550:	00001097          	auipc	ra,0x1
    5554:	9ea080e7          	jalr	-1558(ra) # 5f3a <printf>
  if((pid = fork()) < 0) {
    5558:	00000097          	auipc	ra,0x0
    555c:	660080e7          	jalr	1632(ra) # 5bb8 <fork>
    5560:	02054e63          	bltz	a0,559c <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    5564:	c929                	beqz	a0,55b6 <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    5566:	fdc40513          	addi	a0,s0,-36
    556a:	00000097          	auipc	ra,0x0
    556e:	65e080e7          	jalr	1630(ra) # 5bc8 <wait>
    if(xstatus != 0) 
    5572:	fdc42783          	lw	a5,-36(s0)
    5576:	c7b9                	beqz	a5,55c4 <run+0x8c>
      printf("FAILED\n");
    5578:	00003517          	auipc	a0,0x3
    557c:	b1050513          	addi	a0,a0,-1264 # 8088 <malloc+0x2096>
    5580:	00001097          	auipc	ra,0x1
    5584:	9ba080e7          	jalr	-1606(ra) # 5f3a <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    5588:	fdc42503          	lw	a0,-36(s0)
  }
}
    558c:	00153513          	seqz	a0,a0
    5590:	70a2                	ld	ra,40(sp)
    5592:	7402                	ld	s0,32(sp)
    5594:	64e2                	ld	s1,24(sp)
    5596:	6942                	ld	s2,16(sp)
    5598:	6145                	addi	sp,sp,48
    559a:	8082                	ret
    printf("runtest: fork error\n");
    559c:	00003517          	auipc	a0,0x3
    55a0:	ad450513          	addi	a0,a0,-1324 # 8070 <malloc+0x207e>
    55a4:	00001097          	auipc	ra,0x1
    55a8:	996080e7          	jalr	-1642(ra) # 5f3a <printf>
    exit(1);
    55ac:	4505                	li	a0,1
    55ae:	00000097          	auipc	ra,0x0
    55b2:	612080e7          	jalr	1554(ra) # 5bc0 <exit>
    f(s);
    55b6:	854a                	mv	a0,s2
    55b8:	9482                	jalr	s1
    exit(0);
    55ba:	4501                	li	a0,0
    55bc:	00000097          	auipc	ra,0x0
    55c0:	604080e7          	jalr	1540(ra) # 5bc0 <exit>
      printf("OK\n");
    55c4:	00003517          	auipc	a0,0x3
    55c8:	acc50513          	addi	a0,a0,-1332 # 8090 <malloc+0x209e>
    55cc:	00001097          	auipc	ra,0x1
    55d0:	96e080e7          	jalr	-1682(ra) # 5f3a <printf>
    55d4:	bf55                	j	5588 <run+0x50>

00000000000055d6 <runtests>:

int
runtests(struct test *tests, char *justone) {
    55d6:	1101                	addi	sp,sp,-32
    55d8:	ec06                	sd	ra,24(sp)
    55da:	e822                	sd	s0,16(sp)
    55dc:	e426                	sd	s1,8(sp)
    55de:	e04a                	sd	s2,0(sp)
    55e0:	1000                	addi	s0,sp,32
    55e2:	84aa                	mv	s1,a0
    55e4:	892e                	mv	s2,a1
  for (struct test *t = tests; t->s != 0; t++) {
    55e6:	6508                	ld	a0,8(a0)
    55e8:	ed09                	bnez	a0,5602 <runtests+0x2c>
        printf("SOME TESTS FAILED\n");
        return 1;
      }
    }
  }
  return 0;
    55ea:	4501                	li	a0,0
    55ec:	a82d                	j	5626 <runtests+0x50>
      if(!run(t->f, t->s)){
    55ee:	648c                	ld	a1,8(s1)
    55f0:	6088                	ld	a0,0(s1)
    55f2:	00000097          	auipc	ra,0x0
    55f6:	f46080e7          	jalr	-186(ra) # 5538 <run>
    55fa:	cd09                	beqz	a0,5614 <runtests+0x3e>
  for (struct test *t = tests; t->s != 0; t++) {
    55fc:	04c1                	addi	s1,s1,16
    55fe:	6488                	ld	a0,8(s1)
    5600:	c11d                	beqz	a0,5626 <runtests+0x50>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    5602:	fe0906e3          	beqz	s2,55ee <runtests+0x18>
    5606:	85ca                	mv	a1,s2
    5608:	00000097          	auipc	ra,0x0
    560c:	368080e7          	jalr	872(ra) # 5970 <strcmp>
    5610:	f575                	bnez	a0,55fc <runtests+0x26>
    5612:	bff1                	j	55ee <runtests+0x18>
        printf("SOME TESTS FAILED\n");
    5614:	00003517          	auipc	a0,0x3
    5618:	a8450513          	addi	a0,a0,-1404 # 8098 <malloc+0x20a6>
    561c:	00001097          	auipc	ra,0x1
    5620:	91e080e7          	jalr	-1762(ra) # 5f3a <printf>
        return 1;
    5624:	4505                	li	a0,1
}
    5626:	60e2                	ld	ra,24(sp)
    5628:	6442                	ld	s0,16(sp)
    562a:	64a2                	ld	s1,8(sp)
    562c:	6902                	ld	s2,0(sp)
    562e:	6105                	addi	sp,sp,32
    5630:	8082                	ret

0000000000005632 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    5632:	7139                	addi	sp,sp,-64
    5634:	fc06                	sd	ra,56(sp)
    5636:	f822                	sd	s0,48(sp)
    5638:	f426                	sd	s1,40(sp)
    563a:	f04a                	sd	s2,32(sp)
    563c:	ec4e                	sd	s3,24(sp)
    563e:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    5640:	fc840513          	addi	a0,s0,-56
    5644:	00000097          	auipc	ra,0x0
    5648:	58c080e7          	jalr	1420(ra) # 5bd0 <pipe>
    564c:	06054763          	bltz	a0,56ba <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    5650:	00000097          	auipc	ra,0x0
    5654:	568080e7          	jalr	1384(ra) # 5bb8 <fork>

  if(pid < 0){
    5658:	06054e63          	bltz	a0,56d4 <countfree+0xa2>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    565c:	ed51                	bnez	a0,56f8 <countfree+0xc6>
    close(fds[0]);
    565e:	fc842503          	lw	a0,-56(s0)
    5662:	00000097          	auipc	ra,0x0
    5666:	586080e7          	jalr	1414(ra) # 5be8 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    566a:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    566c:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    566e:	00001997          	auipc	s3,0x1
    5672:	b1a98993          	addi	s3,s3,-1254 # 6188 <malloc+0x196>
      uint64 a = (uint64) sbrk(4096);
    5676:	6505                	lui	a0,0x1
    5678:	00000097          	auipc	ra,0x0
    567c:	5d0080e7          	jalr	1488(ra) # 5c48 <sbrk>
      if(a == 0xffffffffffffffff){
    5680:	07250763          	beq	a0,s2,56ee <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    5684:	6785                	lui	a5,0x1
    5686:	97aa                	add	a5,a5,a0
    5688:	fe978fa3          	sb	s1,-1(a5) # fff <linktest+0x10b>
      if(write(fds[1], "x", 1) != 1){
    568c:	8626                	mv	a2,s1
    568e:	85ce                	mv	a1,s3
    5690:	fcc42503          	lw	a0,-52(s0)
    5694:	00000097          	auipc	ra,0x0
    5698:	54c080e7          	jalr	1356(ra) # 5be0 <write>
    569c:	fc950de3          	beq	a0,s1,5676 <countfree+0x44>
        printf("write() failed in countfree()\n");
    56a0:	00003517          	auipc	a0,0x3
    56a4:	a5050513          	addi	a0,a0,-1456 # 80f0 <malloc+0x20fe>
    56a8:	00001097          	auipc	ra,0x1
    56ac:	892080e7          	jalr	-1902(ra) # 5f3a <printf>
        exit(1);
    56b0:	4505                	li	a0,1
    56b2:	00000097          	auipc	ra,0x0
    56b6:	50e080e7          	jalr	1294(ra) # 5bc0 <exit>
    printf("pipe() failed in countfree()\n");
    56ba:	00003517          	auipc	a0,0x3
    56be:	9f650513          	addi	a0,a0,-1546 # 80b0 <malloc+0x20be>
    56c2:	00001097          	auipc	ra,0x1
    56c6:	878080e7          	jalr	-1928(ra) # 5f3a <printf>
    exit(1);
    56ca:	4505                	li	a0,1
    56cc:	00000097          	auipc	ra,0x0
    56d0:	4f4080e7          	jalr	1268(ra) # 5bc0 <exit>
    printf("fork failed in countfree()\n");
    56d4:	00003517          	auipc	a0,0x3
    56d8:	9fc50513          	addi	a0,a0,-1540 # 80d0 <malloc+0x20de>
    56dc:	00001097          	auipc	ra,0x1
    56e0:	85e080e7          	jalr	-1954(ra) # 5f3a <printf>
    exit(1);
    56e4:	4505                	li	a0,1
    56e6:	00000097          	auipc	ra,0x0
    56ea:	4da080e7          	jalr	1242(ra) # 5bc0 <exit>
      }
    }

    exit(0);
    56ee:	4501                	li	a0,0
    56f0:	00000097          	auipc	ra,0x0
    56f4:	4d0080e7          	jalr	1232(ra) # 5bc0 <exit>
  }

  close(fds[1]);
    56f8:	fcc42503          	lw	a0,-52(s0)
    56fc:	00000097          	auipc	ra,0x0
    5700:	4ec080e7          	jalr	1260(ra) # 5be8 <close>

  int n = 0;
    5704:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    5706:	4605                	li	a2,1
    5708:	fc740593          	addi	a1,s0,-57
    570c:	fc842503          	lw	a0,-56(s0)
    5710:	00000097          	auipc	ra,0x0
    5714:	4c8080e7          	jalr	1224(ra) # 5bd8 <read>
    if(cc < 0){
    5718:	00054563          	bltz	a0,5722 <countfree+0xf0>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    571c:	c105                	beqz	a0,573c <countfree+0x10a>
      break;
    n += 1;
    571e:	2485                	addiw	s1,s1,1
  while(1){
    5720:	b7dd                	j	5706 <countfree+0xd4>
      printf("read() failed in countfree()\n");
    5722:	00003517          	auipc	a0,0x3
    5726:	9ee50513          	addi	a0,a0,-1554 # 8110 <malloc+0x211e>
    572a:	00001097          	auipc	ra,0x1
    572e:	810080e7          	jalr	-2032(ra) # 5f3a <printf>
      exit(1);
    5732:	4505                	li	a0,1
    5734:	00000097          	auipc	ra,0x0
    5738:	48c080e7          	jalr	1164(ra) # 5bc0 <exit>
  }

  close(fds[0]);
    573c:	fc842503          	lw	a0,-56(s0)
    5740:	00000097          	auipc	ra,0x0
    5744:	4a8080e7          	jalr	1192(ra) # 5be8 <close>
  wait((int*)0);
    5748:	4501                	li	a0,0
    574a:	00000097          	auipc	ra,0x0
    574e:	47e080e7          	jalr	1150(ra) # 5bc8 <wait>
  
  return n;
}
    5752:	8526                	mv	a0,s1
    5754:	70e2                	ld	ra,56(sp)
    5756:	7442                	ld	s0,48(sp)
    5758:	74a2                	ld	s1,40(sp)
    575a:	7902                	ld	s2,32(sp)
    575c:	69e2                	ld	s3,24(sp)
    575e:	6121                	addi	sp,sp,64
    5760:	8082                	ret

0000000000005762 <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    5762:	711d                	addi	sp,sp,-96
    5764:	ec86                	sd	ra,88(sp)
    5766:	e8a2                	sd	s0,80(sp)
    5768:	e4a6                	sd	s1,72(sp)
    576a:	e0ca                	sd	s2,64(sp)
    576c:	fc4e                	sd	s3,56(sp)
    576e:	f852                	sd	s4,48(sp)
    5770:	f456                	sd	s5,40(sp)
    5772:	f05a                	sd	s6,32(sp)
    5774:	ec5e                	sd	s7,24(sp)
    5776:	e862                	sd	s8,16(sp)
    5778:	e466                	sd	s9,8(sp)
    577a:	e06a                	sd	s10,0(sp)
    577c:	1080                	addi	s0,sp,96
    577e:	8a2a                	mv	s4,a0
    5780:	89ae                	mv	s3,a1
    5782:	8932                	mv	s2,a2
  do {
    printf("usertests starting\n");
    5784:	00003b97          	auipc	s7,0x3
    5788:	9acb8b93          	addi	s7,s7,-1620 # 8130 <malloc+0x213e>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone)) {
    578c:	00004b17          	auipc	s6,0x4
    5790:	884b0b13          	addi	s6,s6,-1916 # 9010 <quicktests>
      if(continuous != 2) {
    5794:	4a89                	li	s5,2
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5796:	00003c97          	auipc	s9,0x3
    579a:	9d2c8c93          	addi	s9,s9,-1582 # 8168 <malloc+0x2176>
      if (runtests(slowtests, justone)) {
    579e:	00004c17          	auipc	s8,0x4
    57a2:	c42c0c13          	addi	s8,s8,-958 # 93e0 <slowtests>
        printf("usertests slow tests starting\n");
    57a6:	00003d17          	auipc	s10,0x3
    57aa:	9a2d0d13          	addi	s10,s10,-1630 # 8148 <malloc+0x2156>
    57ae:	a839                	j	57cc <drivetests+0x6a>
    57b0:	856a                	mv	a0,s10
    57b2:	00000097          	auipc	ra,0x0
    57b6:	788080e7          	jalr	1928(ra) # 5f3a <printf>
    57ba:	a081                	j	57fa <drivetests+0x98>
    if((free1 = countfree()) < free0) {
    57bc:	00000097          	auipc	ra,0x0
    57c0:	e76080e7          	jalr	-394(ra) # 5632 <countfree>
    57c4:	06954263          	blt	a0,s1,5828 <drivetests+0xc6>
      if(continuous != 2) {
        return 1;
      }
    }
  } while(continuous);
    57c8:	06098f63          	beqz	s3,5846 <drivetests+0xe4>
    printf("usertests starting\n");
    57cc:	855e                	mv	a0,s7
    57ce:	00000097          	auipc	ra,0x0
    57d2:	76c080e7          	jalr	1900(ra) # 5f3a <printf>
    int free0 = countfree();
    57d6:	00000097          	auipc	ra,0x0
    57da:	e5c080e7          	jalr	-420(ra) # 5632 <countfree>
    57de:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone)) {
    57e0:	85ca                	mv	a1,s2
    57e2:	855a                	mv	a0,s6
    57e4:	00000097          	auipc	ra,0x0
    57e8:	df2080e7          	jalr	-526(ra) # 55d6 <runtests>
    57ec:	c119                	beqz	a0,57f2 <drivetests+0x90>
      if(continuous != 2) {
    57ee:	05599863          	bne	s3,s5,583e <drivetests+0xdc>
    if(!quick) {
    57f2:	fc0a15e3          	bnez	s4,57bc <drivetests+0x5a>
      if (justone == 0)
    57f6:	fa090de3          	beqz	s2,57b0 <drivetests+0x4e>
      if (runtests(slowtests, justone)) {
    57fa:	85ca                	mv	a1,s2
    57fc:	8562                	mv	a0,s8
    57fe:	00000097          	auipc	ra,0x0
    5802:	dd8080e7          	jalr	-552(ra) # 55d6 <runtests>
    5806:	d95d                	beqz	a0,57bc <drivetests+0x5a>
        if(continuous != 2) {
    5808:	03599d63          	bne	s3,s5,5842 <drivetests+0xe0>
    if((free1 = countfree()) < free0) {
    580c:	00000097          	auipc	ra,0x0
    5810:	e26080e7          	jalr	-474(ra) # 5632 <countfree>
    5814:	fa955ae3          	bge	a0,s1,57c8 <drivetests+0x66>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5818:	8626                	mv	a2,s1
    581a:	85aa                	mv	a1,a0
    581c:	8566                	mv	a0,s9
    581e:	00000097          	auipc	ra,0x0
    5822:	71c080e7          	jalr	1820(ra) # 5f3a <printf>
      if(continuous != 2) {
    5826:	b75d                	j	57cc <drivetests+0x6a>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5828:	8626                	mv	a2,s1
    582a:	85aa                	mv	a1,a0
    582c:	8566                	mv	a0,s9
    582e:	00000097          	auipc	ra,0x0
    5832:	70c080e7          	jalr	1804(ra) # 5f3a <printf>
      if(continuous != 2) {
    5836:	f9598be3          	beq	s3,s5,57cc <drivetests+0x6a>
        return 1;
    583a:	4505                	li	a0,1
    583c:	a031                	j	5848 <drivetests+0xe6>
        return 1;
    583e:	4505                	li	a0,1
    5840:	a021                	j	5848 <drivetests+0xe6>
          return 1;
    5842:	4505                	li	a0,1
    5844:	a011                	j	5848 <drivetests+0xe6>
  return 0;
    5846:	854e                	mv	a0,s3
}
    5848:	60e6                	ld	ra,88(sp)
    584a:	6446                	ld	s0,80(sp)
    584c:	64a6                	ld	s1,72(sp)
    584e:	6906                	ld	s2,64(sp)
    5850:	79e2                	ld	s3,56(sp)
    5852:	7a42                	ld	s4,48(sp)
    5854:	7aa2                	ld	s5,40(sp)
    5856:	7b02                	ld	s6,32(sp)
    5858:	6be2                	ld	s7,24(sp)
    585a:	6c42                	ld	s8,16(sp)
    585c:	6ca2                	ld	s9,8(sp)
    585e:	6d02                	ld	s10,0(sp)
    5860:	6125                	addi	sp,sp,96
    5862:	8082                	ret

0000000000005864 <main>:

int
main(int argc, char *argv[])
{
    5864:	1101                	addi	sp,sp,-32
    5866:	ec06                	sd	ra,24(sp)
    5868:	e822                	sd	s0,16(sp)
    586a:	e426                	sd	s1,8(sp)
    586c:	e04a                	sd	s2,0(sp)
    586e:	1000                	addi	s0,sp,32
    5870:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    5872:	4789                	li	a5,2
    5874:	02f50263          	beq	a0,a5,5898 <main+0x34>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    5878:	4785                	li	a5,1
    587a:	06a7cd63          	blt	a5,a0,58f4 <main+0x90>
  char *justone = 0;
    587e:	4601                	li	a2,0
  int quick = 0;
    5880:	4501                	li	a0,0
  int continuous = 0;
    5882:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    5884:	00000097          	auipc	ra,0x0
    5888:	ede080e7          	jalr	-290(ra) # 5762 <drivetests>
    588c:	c951                	beqz	a0,5920 <main+0xbc>
    exit(1);
    588e:	4505                	li	a0,1
    5890:	00000097          	auipc	ra,0x0
    5894:	330080e7          	jalr	816(ra) # 5bc0 <exit>
    5898:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    589a:	00003597          	auipc	a1,0x3
    589e:	8fe58593          	addi	a1,a1,-1794 # 8198 <malloc+0x21a6>
    58a2:	00893503          	ld	a0,8(s2)
    58a6:	00000097          	auipc	ra,0x0
    58aa:	0ca080e7          	jalr	202(ra) # 5970 <strcmp>
    58ae:	85aa                	mv	a1,a0
    58b0:	cd39                	beqz	a0,590e <main+0xaa>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    58b2:	00003597          	auipc	a1,0x3
    58b6:	93e58593          	addi	a1,a1,-1730 # 81f0 <malloc+0x21fe>
    58ba:	00893503          	ld	a0,8(s2)
    58be:	00000097          	auipc	ra,0x0
    58c2:	0b2080e7          	jalr	178(ra) # 5970 <strcmp>
    58c6:	c931                	beqz	a0,591a <main+0xb6>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    58c8:	00003597          	auipc	a1,0x3
    58cc:	92058593          	addi	a1,a1,-1760 # 81e8 <malloc+0x21f6>
    58d0:	00893503          	ld	a0,8(s2)
    58d4:	00000097          	auipc	ra,0x0
    58d8:	09c080e7          	jalr	156(ra) # 5970 <strcmp>
    58dc:	cd05                	beqz	a0,5914 <main+0xb0>
  } else if(argc == 2 && argv[1][0] != '-'){
    58de:	00893603          	ld	a2,8(s2)
    58e2:	00064703          	lbu	a4,0(a2) # 3000 <execout+0xa6>
    58e6:	02d00793          	li	a5,45
    58ea:	00f70563          	beq	a4,a5,58f4 <main+0x90>
  int quick = 0;
    58ee:	4501                	li	a0,0
  int continuous = 0;
    58f0:	4581                	li	a1,0
    58f2:	bf49                	j	5884 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    58f4:	00003517          	auipc	a0,0x3
    58f8:	8ac50513          	addi	a0,a0,-1876 # 81a0 <malloc+0x21ae>
    58fc:	00000097          	auipc	ra,0x0
    5900:	63e080e7          	jalr	1598(ra) # 5f3a <printf>
    exit(1);
    5904:	4505                	li	a0,1
    5906:	00000097          	auipc	ra,0x0
    590a:	2ba080e7          	jalr	698(ra) # 5bc0 <exit>
  char *justone = 0;
    590e:	4601                	li	a2,0
    quick = 1;
    5910:	4505                	li	a0,1
    5912:	bf8d                	j	5884 <main+0x20>
    continuous = 2;
    5914:	85a6                	mv	a1,s1
  char *justone = 0;
    5916:	4601                	li	a2,0
    5918:	b7b5                	j	5884 <main+0x20>
    591a:	4601                	li	a2,0
    continuous = 1;
    591c:	4585                	li	a1,1
    591e:	b79d                	j	5884 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    5920:	00003517          	auipc	a0,0x3
    5924:	8b050513          	addi	a0,a0,-1872 # 81d0 <malloc+0x21de>
    5928:	00000097          	auipc	ra,0x0
    592c:	612080e7          	jalr	1554(ra) # 5f3a <printf>
  exit(0);
    5930:	4501                	li	a0,0
    5932:	00000097          	auipc	ra,0x0
    5936:	28e080e7          	jalr	654(ra) # 5bc0 <exit>

000000000000593a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    593a:	1141                	addi	sp,sp,-16
    593c:	e406                	sd	ra,8(sp)
    593e:	e022                	sd	s0,0(sp)
    5940:	0800                	addi	s0,sp,16
  extern int main();
  main();
    5942:	00000097          	auipc	ra,0x0
    5946:	f22080e7          	jalr	-222(ra) # 5864 <main>
  exit(0);
    594a:	4501                	li	a0,0
    594c:	00000097          	auipc	ra,0x0
    5950:	274080e7          	jalr	628(ra) # 5bc0 <exit>

0000000000005954 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    5954:	1141                	addi	sp,sp,-16
    5956:	e422                	sd	s0,8(sp)
    5958:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    595a:	87aa                	mv	a5,a0
    595c:	0585                	addi	a1,a1,1
    595e:	0785                	addi	a5,a5,1
    5960:	fff5c703          	lbu	a4,-1(a1)
    5964:	fee78fa3          	sb	a4,-1(a5)
    5968:	fb75                	bnez	a4,595c <strcpy+0x8>
    ;
  return os;
}
    596a:	6422                	ld	s0,8(sp)
    596c:	0141                	addi	sp,sp,16
    596e:	8082                	ret

0000000000005970 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    5970:	1141                	addi	sp,sp,-16
    5972:	e422                	sd	s0,8(sp)
    5974:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    5976:	00054783          	lbu	a5,0(a0)
    597a:	cb91                	beqz	a5,598e <strcmp+0x1e>
    597c:	0005c703          	lbu	a4,0(a1)
    5980:	00f71763          	bne	a4,a5,598e <strcmp+0x1e>
    p++, q++;
    5984:	0505                	addi	a0,a0,1
    5986:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    5988:	00054783          	lbu	a5,0(a0)
    598c:	fbe5                	bnez	a5,597c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    598e:	0005c503          	lbu	a0,0(a1)
}
    5992:	40a7853b          	subw	a0,a5,a0
    5996:	6422                	ld	s0,8(sp)
    5998:	0141                	addi	sp,sp,16
    599a:	8082                	ret

000000000000599c <strlen>:

uint
strlen(const char *s)
{
    599c:	1141                	addi	sp,sp,-16
    599e:	e422                	sd	s0,8(sp)
    59a0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    59a2:	00054783          	lbu	a5,0(a0)
    59a6:	cf91                	beqz	a5,59c2 <strlen+0x26>
    59a8:	0505                	addi	a0,a0,1
    59aa:	87aa                	mv	a5,a0
    59ac:	4685                	li	a3,1
    59ae:	9e89                	subw	a3,a3,a0
    59b0:	00f6853b          	addw	a0,a3,a5
    59b4:	0785                	addi	a5,a5,1
    59b6:	fff7c703          	lbu	a4,-1(a5)
    59ba:	fb7d                	bnez	a4,59b0 <strlen+0x14>
    ;
  return n;
}
    59bc:	6422                	ld	s0,8(sp)
    59be:	0141                	addi	sp,sp,16
    59c0:	8082                	ret
  for(n = 0; s[n]; n++)
    59c2:	4501                	li	a0,0
    59c4:	bfe5                	j	59bc <strlen+0x20>

00000000000059c6 <memset>:

void*
memset(void *dst, int c, uint n)
{
    59c6:	1141                	addi	sp,sp,-16
    59c8:	e422                	sd	s0,8(sp)
    59ca:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    59cc:	ca19                	beqz	a2,59e2 <memset+0x1c>
    59ce:	87aa                	mv	a5,a0
    59d0:	1602                	slli	a2,a2,0x20
    59d2:	9201                	srli	a2,a2,0x20
    59d4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    59d8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    59dc:	0785                	addi	a5,a5,1
    59de:	fee79de3          	bne	a5,a4,59d8 <memset+0x12>
  }
  return dst;
}
    59e2:	6422                	ld	s0,8(sp)
    59e4:	0141                	addi	sp,sp,16
    59e6:	8082                	ret

00000000000059e8 <strchr>:

char*
strchr(const char *s, char c)
{
    59e8:	1141                	addi	sp,sp,-16
    59ea:	e422                	sd	s0,8(sp)
    59ec:	0800                	addi	s0,sp,16
  for(; *s; s++)
    59ee:	00054783          	lbu	a5,0(a0)
    59f2:	cb99                	beqz	a5,5a08 <strchr+0x20>
    if(*s == c)
    59f4:	00f58763          	beq	a1,a5,5a02 <strchr+0x1a>
  for(; *s; s++)
    59f8:	0505                	addi	a0,a0,1
    59fa:	00054783          	lbu	a5,0(a0)
    59fe:	fbfd                	bnez	a5,59f4 <strchr+0xc>
      return (char*)s;
  return 0;
    5a00:	4501                	li	a0,0
}
    5a02:	6422                	ld	s0,8(sp)
    5a04:	0141                	addi	sp,sp,16
    5a06:	8082                	ret
  return 0;
    5a08:	4501                	li	a0,0
    5a0a:	bfe5                	j	5a02 <strchr+0x1a>

0000000000005a0c <gets>:

char*
gets(char *buf, int max)
{
    5a0c:	711d                	addi	sp,sp,-96
    5a0e:	ec86                	sd	ra,88(sp)
    5a10:	e8a2                	sd	s0,80(sp)
    5a12:	e4a6                	sd	s1,72(sp)
    5a14:	e0ca                	sd	s2,64(sp)
    5a16:	fc4e                	sd	s3,56(sp)
    5a18:	f852                	sd	s4,48(sp)
    5a1a:	f456                	sd	s5,40(sp)
    5a1c:	f05a                	sd	s6,32(sp)
    5a1e:	ec5e                	sd	s7,24(sp)
    5a20:	1080                	addi	s0,sp,96
    5a22:	8baa                	mv	s7,a0
    5a24:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    5a26:	892a                	mv	s2,a0
    5a28:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    5a2a:	4aa9                	li	s5,10
    5a2c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    5a2e:	89a6                	mv	s3,s1
    5a30:	2485                	addiw	s1,s1,1
    5a32:	0344d863          	bge	s1,s4,5a62 <gets+0x56>
    cc = read(0, &c, 1);
    5a36:	4605                	li	a2,1
    5a38:	faf40593          	addi	a1,s0,-81
    5a3c:	4501                	li	a0,0
    5a3e:	00000097          	auipc	ra,0x0
    5a42:	19a080e7          	jalr	410(ra) # 5bd8 <read>
    if(cc < 1)
    5a46:	00a05e63          	blez	a0,5a62 <gets+0x56>
    buf[i++] = c;
    5a4a:	faf44783          	lbu	a5,-81(s0)
    5a4e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    5a52:	01578763          	beq	a5,s5,5a60 <gets+0x54>
    5a56:	0905                	addi	s2,s2,1
    5a58:	fd679be3          	bne	a5,s6,5a2e <gets+0x22>
  for(i=0; i+1 < max; ){
    5a5c:	89a6                	mv	s3,s1
    5a5e:	a011                	j	5a62 <gets+0x56>
    5a60:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    5a62:	99de                	add	s3,s3,s7
    5a64:	00098023          	sb	zero,0(s3)
  return buf;
}
    5a68:	855e                	mv	a0,s7
    5a6a:	60e6                	ld	ra,88(sp)
    5a6c:	6446                	ld	s0,80(sp)
    5a6e:	64a6                	ld	s1,72(sp)
    5a70:	6906                	ld	s2,64(sp)
    5a72:	79e2                	ld	s3,56(sp)
    5a74:	7a42                	ld	s4,48(sp)
    5a76:	7aa2                	ld	s5,40(sp)
    5a78:	7b02                	ld	s6,32(sp)
    5a7a:	6be2                	ld	s7,24(sp)
    5a7c:	6125                	addi	sp,sp,96
    5a7e:	8082                	ret

0000000000005a80 <stat>:

int
stat(const char *n, struct stat *st)
{
    5a80:	1101                	addi	sp,sp,-32
    5a82:	ec06                	sd	ra,24(sp)
    5a84:	e822                	sd	s0,16(sp)
    5a86:	e426                	sd	s1,8(sp)
    5a88:	e04a                	sd	s2,0(sp)
    5a8a:	1000                	addi	s0,sp,32
    5a8c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5a8e:	4581                	li	a1,0
    5a90:	00000097          	auipc	ra,0x0
    5a94:	170080e7          	jalr	368(ra) # 5c00 <open>
  if(fd < 0)
    5a98:	02054563          	bltz	a0,5ac2 <stat+0x42>
    5a9c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    5a9e:	85ca                	mv	a1,s2
    5aa0:	00000097          	auipc	ra,0x0
    5aa4:	178080e7          	jalr	376(ra) # 5c18 <fstat>
    5aa8:	892a                	mv	s2,a0
  close(fd);
    5aaa:	8526                	mv	a0,s1
    5aac:	00000097          	auipc	ra,0x0
    5ab0:	13c080e7          	jalr	316(ra) # 5be8 <close>
  return r;
}
    5ab4:	854a                	mv	a0,s2
    5ab6:	60e2                	ld	ra,24(sp)
    5ab8:	6442                	ld	s0,16(sp)
    5aba:	64a2                	ld	s1,8(sp)
    5abc:	6902                	ld	s2,0(sp)
    5abe:	6105                	addi	sp,sp,32
    5ac0:	8082                	ret
    return -1;
    5ac2:	597d                	li	s2,-1
    5ac4:	bfc5                	j	5ab4 <stat+0x34>

0000000000005ac6 <atoi>:

int
atoi(const char *s)
{
    5ac6:	1141                	addi	sp,sp,-16
    5ac8:	e422                	sd	s0,8(sp)
    5aca:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    5acc:	00054683          	lbu	a3,0(a0)
    5ad0:	fd06879b          	addiw	a5,a3,-48
    5ad4:	0ff7f793          	zext.b	a5,a5
    5ad8:	4625                	li	a2,9
    5ada:	02f66863          	bltu	a2,a5,5b0a <atoi+0x44>
    5ade:	872a                	mv	a4,a0
  n = 0;
    5ae0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    5ae2:	0705                	addi	a4,a4,1
    5ae4:	0025179b          	slliw	a5,a0,0x2
    5ae8:	9fa9                	addw	a5,a5,a0
    5aea:	0017979b          	slliw	a5,a5,0x1
    5aee:	9fb5                	addw	a5,a5,a3
    5af0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5af4:	00074683          	lbu	a3,0(a4)
    5af8:	fd06879b          	addiw	a5,a3,-48
    5afc:	0ff7f793          	zext.b	a5,a5
    5b00:	fef671e3          	bgeu	a2,a5,5ae2 <atoi+0x1c>
  return n;
}
    5b04:	6422                	ld	s0,8(sp)
    5b06:	0141                	addi	sp,sp,16
    5b08:	8082                	ret
  n = 0;
    5b0a:	4501                	li	a0,0
    5b0c:	bfe5                	j	5b04 <atoi+0x3e>

0000000000005b0e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5b0e:	1141                	addi	sp,sp,-16
    5b10:	e422                	sd	s0,8(sp)
    5b12:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5b14:	02b57463          	bgeu	a0,a1,5b3c <memmove+0x2e>
    while(n-- > 0)
    5b18:	00c05f63          	blez	a2,5b36 <memmove+0x28>
    5b1c:	1602                	slli	a2,a2,0x20
    5b1e:	9201                	srli	a2,a2,0x20
    5b20:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    5b24:	872a                	mv	a4,a0
      *dst++ = *src++;
    5b26:	0585                	addi	a1,a1,1
    5b28:	0705                	addi	a4,a4,1
    5b2a:	fff5c683          	lbu	a3,-1(a1)
    5b2e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    5b32:	fee79ae3          	bne	a5,a4,5b26 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    5b36:	6422                	ld	s0,8(sp)
    5b38:	0141                	addi	sp,sp,16
    5b3a:	8082                	ret
    dst += n;
    5b3c:	00c50733          	add	a4,a0,a2
    src += n;
    5b40:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    5b42:	fec05ae3          	blez	a2,5b36 <memmove+0x28>
    5b46:	fff6079b          	addiw	a5,a2,-1
    5b4a:	1782                	slli	a5,a5,0x20
    5b4c:	9381                	srli	a5,a5,0x20
    5b4e:	fff7c793          	not	a5,a5
    5b52:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    5b54:	15fd                	addi	a1,a1,-1
    5b56:	177d                	addi	a4,a4,-1
    5b58:	0005c683          	lbu	a3,0(a1)
    5b5c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    5b60:	fee79ae3          	bne	a5,a4,5b54 <memmove+0x46>
    5b64:	bfc9                	j	5b36 <memmove+0x28>

0000000000005b66 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5b66:	1141                	addi	sp,sp,-16
    5b68:	e422                	sd	s0,8(sp)
    5b6a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    5b6c:	ca05                	beqz	a2,5b9c <memcmp+0x36>
    5b6e:	fff6069b          	addiw	a3,a2,-1
    5b72:	1682                	slli	a3,a3,0x20
    5b74:	9281                	srli	a3,a3,0x20
    5b76:	0685                	addi	a3,a3,1
    5b78:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    5b7a:	00054783          	lbu	a5,0(a0)
    5b7e:	0005c703          	lbu	a4,0(a1)
    5b82:	00e79863          	bne	a5,a4,5b92 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    5b86:	0505                	addi	a0,a0,1
    p2++;
    5b88:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    5b8a:	fed518e3          	bne	a0,a3,5b7a <memcmp+0x14>
  }
  return 0;
    5b8e:	4501                	li	a0,0
    5b90:	a019                	j	5b96 <memcmp+0x30>
      return *p1 - *p2;
    5b92:	40e7853b          	subw	a0,a5,a4
}
    5b96:	6422                	ld	s0,8(sp)
    5b98:	0141                	addi	sp,sp,16
    5b9a:	8082                	ret
  return 0;
    5b9c:	4501                	li	a0,0
    5b9e:	bfe5                	j	5b96 <memcmp+0x30>

0000000000005ba0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5ba0:	1141                	addi	sp,sp,-16
    5ba2:	e406                	sd	ra,8(sp)
    5ba4:	e022                	sd	s0,0(sp)
    5ba6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    5ba8:	00000097          	auipc	ra,0x0
    5bac:	f66080e7          	jalr	-154(ra) # 5b0e <memmove>
}
    5bb0:	60a2                	ld	ra,8(sp)
    5bb2:	6402                	ld	s0,0(sp)
    5bb4:	0141                	addi	sp,sp,16
    5bb6:	8082                	ret

0000000000005bb8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5bb8:	4885                	li	a7,1
 ecall
    5bba:	00000073          	ecall
 ret
    5bbe:	8082                	ret

0000000000005bc0 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5bc0:	4889                	li	a7,2
 ecall
    5bc2:	00000073          	ecall
 ret
    5bc6:	8082                	ret

0000000000005bc8 <wait>:
.global wait
wait:
 li a7, SYS_wait
    5bc8:	488d                	li	a7,3
 ecall
    5bca:	00000073          	ecall
 ret
    5bce:	8082                	ret

0000000000005bd0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5bd0:	4891                	li	a7,4
 ecall
    5bd2:	00000073          	ecall
 ret
    5bd6:	8082                	ret

0000000000005bd8 <read>:
.global read
read:
 li a7, SYS_read
    5bd8:	4895                	li	a7,5
 ecall
    5bda:	00000073          	ecall
 ret
    5bde:	8082                	ret

0000000000005be0 <write>:
.global write
write:
 li a7, SYS_write
    5be0:	48c1                	li	a7,16
 ecall
    5be2:	00000073          	ecall
 ret
    5be6:	8082                	ret

0000000000005be8 <close>:
.global close
close:
 li a7, SYS_close
    5be8:	48d5                	li	a7,21
 ecall
    5bea:	00000073          	ecall
 ret
    5bee:	8082                	ret

0000000000005bf0 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5bf0:	4899                	li	a7,6
 ecall
    5bf2:	00000073          	ecall
 ret
    5bf6:	8082                	ret

0000000000005bf8 <exec>:
.global exec
exec:
 li a7, SYS_exec
    5bf8:	489d                	li	a7,7
 ecall
    5bfa:	00000073          	ecall
 ret
    5bfe:	8082                	ret

0000000000005c00 <open>:
.global open
open:
 li a7, SYS_open
    5c00:	48bd                	li	a7,15
 ecall
    5c02:	00000073          	ecall
 ret
    5c06:	8082                	ret

0000000000005c08 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5c08:	48c5                	li	a7,17
 ecall
    5c0a:	00000073          	ecall
 ret
    5c0e:	8082                	ret

0000000000005c10 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5c10:	48c9                	li	a7,18
 ecall
    5c12:	00000073          	ecall
 ret
    5c16:	8082                	ret

0000000000005c18 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5c18:	48a1                	li	a7,8
 ecall
    5c1a:	00000073          	ecall
 ret
    5c1e:	8082                	ret

0000000000005c20 <link>:
.global link
link:
 li a7, SYS_link
    5c20:	48cd                	li	a7,19
 ecall
    5c22:	00000073          	ecall
 ret
    5c26:	8082                	ret

0000000000005c28 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5c28:	48d1                	li	a7,20
 ecall
    5c2a:	00000073          	ecall
 ret
    5c2e:	8082                	ret

0000000000005c30 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5c30:	48a5                	li	a7,9
 ecall
    5c32:	00000073          	ecall
 ret
    5c36:	8082                	ret

0000000000005c38 <dup>:
.global dup
dup:
 li a7, SYS_dup
    5c38:	48a9                	li	a7,10
 ecall
    5c3a:	00000073          	ecall
 ret
    5c3e:	8082                	ret

0000000000005c40 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5c40:	48ad                	li	a7,11
 ecall
    5c42:	00000073          	ecall
 ret
    5c46:	8082                	ret

0000000000005c48 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5c48:	48b1                	li	a7,12
 ecall
    5c4a:	00000073          	ecall
 ret
    5c4e:	8082                	ret

0000000000005c50 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5c50:	48b5                	li	a7,13
 ecall
    5c52:	00000073          	ecall
 ret
    5c56:	8082                	ret

0000000000005c58 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5c58:	48b9                	li	a7,14
 ecall
    5c5a:	00000073          	ecall
 ret
    5c5e:	8082                	ret

0000000000005c60 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5c60:	1101                	addi	sp,sp,-32
    5c62:	ec06                	sd	ra,24(sp)
    5c64:	e822                	sd	s0,16(sp)
    5c66:	1000                	addi	s0,sp,32
    5c68:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5c6c:	4605                	li	a2,1
    5c6e:	fef40593          	addi	a1,s0,-17
    5c72:	00000097          	auipc	ra,0x0
    5c76:	f6e080e7          	jalr	-146(ra) # 5be0 <write>
}
    5c7a:	60e2                	ld	ra,24(sp)
    5c7c:	6442                	ld	s0,16(sp)
    5c7e:	6105                	addi	sp,sp,32
    5c80:	8082                	ret

0000000000005c82 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5c82:	7139                	addi	sp,sp,-64
    5c84:	fc06                	sd	ra,56(sp)
    5c86:	f822                	sd	s0,48(sp)
    5c88:	f426                	sd	s1,40(sp)
    5c8a:	f04a                	sd	s2,32(sp)
    5c8c:	ec4e                	sd	s3,24(sp)
    5c8e:	0080                	addi	s0,sp,64
    5c90:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5c92:	c299                	beqz	a3,5c98 <printint+0x16>
    5c94:	0805c963          	bltz	a1,5d26 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5c98:	2581                	sext.w	a1,a1
  neg = 0;
    5c9a:	4881                	li	a7,0
    5c9c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    5ca0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    5ca2:	2601                	sext.w	a2,a2
    5ca4:	00003517          	auipc	a0,0x3
    5ca8:	91450513          	addi	a0,a0,-1772 # 85b8 <digits>
    5cac:	883a                	mv	a6,a4
    5cae:	2705                	addiw	a4,a4,1
    5cb0:	02c5f7bb          	remuw	a5,a1,a2
    5cb4:	1782                	slli	a5,a5,0x20
    5cb6:	9381                	srli	a5,a5,0x20
    5cb8:	97aa                	add	a5,a5,a0
    5cba:	0007c783          	lbu	a5,0(a5)
    5cbe:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    5cc2:	0005879b          	sext.w	a5,a1
    5cc6:	02c5d5bb          	divuw	a1,a1,a2
    5cca:	0685                	addi	a3,a3,1
    5ccc:	fec7f0e3          	bgeu	a5,a2,5cac <printint+0x2a>
  if(neg)
    5cd0:	00088c63          	beqz	a7,5ce8 <printint+0x66>
    buf[i++] = '-';
    5cd4:	fd070793          	addi	a5,a4,-48
    5cd8:	00878733          	add	a4,a5,s0
    5cdc:	02d00793          	li	a5,45
    5ce0:	fef70823          	sb	a5,-16(a4)
    5ce4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    5ce8:	02e05863          	blez	a4,5d18 <printint+0x96>
    5cec:	fc040793          	addi	a5,s0,-64
    5cf0:	00e78933          	add	s2,a5,a4
    5cf4:	fff78993          	addi	s3,a5,-1
    5cf8:	99ba                	add	s3,s3,a4
    5cfa:	377d                	addiw	a4,a4,-1
    5cfc:	1702                	slli	a4,a4,0x20
    5cfe:	9301                	srli	a4,a4,0x20
    5d00:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    5d04:	fff94583          	lbu	a1,-1(s2)
    5d08:	8526                	mv	a0,s1
    5d0a:	00000097          	auipc	ra,0x0
    5d0e:	f56080e7          	jalr	-170(ra) # 5c60 <putc>
  while(--i >= 0)
    5d12:	197d                	addi	s2,s2,-1
    5d14:	ff3918e3          	bne	s2,s3,5d04 <printint+0x82>
}
    5d18:	70e2                	ld	ra,56(sp)
    5d1a:	7442                	ld	s0,48(sp)
    5d1c:	74a2                	ld	s1,40(sp)
    5d1e:	7902                	ld	s2,32(sp)
    5d20:	69e2                	ld	s3,24(sp)
    5d22:	6121                	addi	sp,sp,64
    5d24:	8082                	ret
    x = -xx;
    5d26:	40b005bb          	negw	a1,a1
    neg = 1;
    5d2a:	4885                	li	a7,1
    x = -xx;
    5d2c:	bf85                	j	5c9c <printint+0x1a>

0000000000005d2e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5d2e:	7119                	addi	sp,sp,-128
    5d30:	fc86                	sd	ra,120(sp)
    5d32:	f8a2                	sd	s0,112(sp)
    5d34:	f4a6                	sd	s1,104(sp)
    5d36:	f0ca                	sd	s2,96(sp)
    5d38:	ecce                	sd	s3,88(sp)
    5d3a:	e8d2                	sd	s4,80(sp)
    5d3c:	e4d6                	sd	s5,72(sp)
    5d3e:	e0da                	sd	s6,64(sp)
    5d40:	fc5e                	sd	s7,56(sp)
    5d42:	f862                	sd	s8,48(sp)
    5d44:	f466                	sd	s9,40(sp)
    5d46:	f06a                	sd	s10,32(sp)
    5d48:	ec6e                	sd	s11,24(sp)
    5d4a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    5d4c:	0005c903          	lbu	s2,0(a1)
    5d50:	18090f63          	beqz	s2,5eee <vprintf+0x1c0>
    5d54:	8aaa                	mv	s5,a0
    5d56:	8b32                	mv	s6,a2
    5d58:	00158493          	addi	s1,a1,1
  state = 0;
    5d5c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    5d5e:	02500a13          	li	s4,37
    5d62:	4c55                	li	s8,21
    5d64:	00002c97          	auipc	s9,0x2
    5d68:	7fcc8c93          	addi	s9,s9,2044 # 8560 <malloc+0x256e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    5d6c:	02800d93          	li	s11,40
  putc(fd, 'x');
    5d70:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5d72:	00003b97          	auipc	s7,0x3
    5d76:	846b8b93          	addi	s7,s7,-1978 # 85b8 <digits>
    5d7a:	a839                	j	5d98 <vprintf+0x6a>
        putc(fd, c);
    5d7c:	85ca                	mv	a1,s2
    5d7e:	8556                	mv	a0,s5
    5d80:	00000097          	auipc	ra,0x0
    5d84:	ee0080e7          	jalr	-288(ra) # 5c60 <putc>
    5d88:	a019                	j	5d8e <vprintf+0x60>
    } else if(state == '%'){
    5d8a:	01498d63          	beq	s3,s4,5da4 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
    5d8e:	0485                	addi	s1,s1,1
    5d90:	fff4c903          	lbu	s2,-1(s1)
    5d94:	14090d63          	beqz	s2,5eee <vprintf+0x1c0>
    if(state == 0){
    5d98:	fe0999e3          	bnez	s3,5d8a <vprintf+0x5c>
      if(c == '%'){
    5d9c:	ff4910e3          	bne	s2,s4,5d7c <vprintf+0x4e>
        state = '%';
    5da0:	89d2                	mv	s3,s4
    5da2:	b7f5                	j	5d8e <vprintf+0x60>
      if(c == 'd'){
    5da4:	11490c63          	beq	s2,s4,5ebc <vprintf+0x18e>
    5da8:	f9d9079b          	addiw	a5,s2,-99
    5dac:	0ff7f793          	zext.b	a5,a5
    5db0:	10fc6e63          	bltu	s8,a5,5ecc <vprintf+0x19e>
    5db4:	f9d9079b          	addiw	a5,s2,-99
    5db8:	0ff7f713          	zext.b	a4,a5
    5dbc:	10ec6863          	bltu	s8,a4,5ecc <vprintf+0x19e>
    5dc0:	00271793          	slli	a5,a4,0x2
    5dc4:	97e6                	add	a5,a5,s9
    5dc6:	439c                	lw	a5,0(a5)
    5dc8:	97e6                	add	a5,a5,s9
    5dca:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    5dcc:	008b0913          	addi	s2,s6,8
    5dd0:	4685                	li	a3,1
    5dd2:	4629                	li	a2,10
    5dd4:	000b2583          	lw	a1,0(s6)
    5dd8:	8556                	mv	a0,s5
    5dda:	00000097          	auipc	ra,0x0
    5dde:	ea8080e7          	jalr	-344(ra) # 5c82 <printint>
    5de2:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    5de4:	4981                	li	s3,0
    5de6:	b765                	j	5d8e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5de8:	008b0913          	addi	s2,s6,8
    5dec:	4681                	li	a3,0
    5dee:	4629                	li	a2,10
    5df0:	000b2583          	lw	a1,0(s6)
    5df4:	8556                	mv	a0,s5
    5df6:	00000097          	auipc	ra,0x0
    5dfa:	e8c080e7          	jalr	-372(ra) # 5c82 <printint>
    5dfe:	8b4a                	mv	s6,s2
      state = 0;
    5e00:	4981                	li	s3,0
    5e02:	b771                	j	5d8e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    5e04:	008b0913          	addi	s2,s6,8
    5e08:	4681                	li	a3,0
    5e0a:	866a                	mv	a2,s10
    5e0c:	000b2583          	lw	a1,0(s6)
    5e10:	8556                	mv	a0,s5
    5e12:	00000097          	auipc	ra,0x0
    5e16:	e70080e7          	jalr	-400(ra) # 5c82 <printint>
    5e1a:	8b4a                	mv	s6,s2
      state = 0;
    5e1c:	4981                	li	s3,0
    5e1e:	bf85                	j	5d8e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    5e20:	008b0793          	addi	a5,s6,8
    5e24:	f8f43423          	sd	a5,-120(s0)
    5e28:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    5e2c:	03000593          	li	a1,48
    5e30:	8556                	mv	a0,s5
    5e32:	00000097          	auipc	ra,0x0
    5e36:	e2e080e7          	jalr	-466(ra) # 5c60 <putc>
  putc(fd, 'x');
    5e3a:	07800593          	li	a1,120
    5e3e:	8556                	mv	a0,s5
    5e40:	00000097          	auipc	ra,0x0
    5e44:	e20080e7          	jalr	-480(ra) # 5c60 <putc>
    5e48:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5e4a:	03c9d793          	srli	a5,s3,0x3c
    5e4e:	97de                	add	a5,a5,s7
    5e50:	0007c583          	lbu	a1,0(a5)
    5e54:	8556                	mv	a0,s5
    5e56:	00000097          	auipc	ra,0x0
    5e5a:	e0a080e7          	jalr	-502(ra) # 5c60 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5e5e:	0992                	slli	s3,s3,0x4
    5e60:	397d                	addiw	s2,s2,-1
    5e62:	fe0914e3          	bnez	s2,5e4a <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    5e66:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    5e6a:	4981                	li	s3,0
    5e6c:	b70d                	j	5d8e <vprintf+0x60>
        s = va_arg(ap, char*);
    5e6e:	008b0913          	addi	s2,s6,8
    5e72:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    5e76:	02098163          	beqz	s3,5e98 <vprintf+0x16a>
        while(*s != 0){
    5e7a:	0009c583          	lbu	a1,0(s3)
    5e7e:	c5ad                	beqz	a1,5ee8 <vprintf+0x1ba>
          putc(fd, *s);
    5e80:	8556                	mv	a0,s5
    5e82:	00000097          	auipc	ra,0x0
    5e86:	dde080e7          	jalr	-546(ra) # 5c60 <putc>
          s++;
    5e8a:	0985                	addi	s3,s3,1
        while(*s != 0){
    5e8c:	0009c583          	lbu	a1,0(s3)
    5e90:	f9e5                	bnez	a1,5e80 <vprintf+0x152>
        s = va_arg(ap, char*);
    5e92:	8b4a                	mv	s6,s2
      state = 0;
    5e94:	4981                	li	s3,0
    5e96:	bde5                	j	5d8e <vprintf+0x60>
          s = "(null)";
    5e98:	00002997          	auipc	s3,0x2
    5e9c:	6c098993          	addi	s3,s3,1728 # 8558 <malloc+0x2566>
        while(*s != 0){
    5ea0:	85ee                	mv	a1,s11
    5ea2:	bff9                	j	5e80 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    5ea4:	008b0913          	addi	s2,s6,8
    5ea8:	000b4583          	lbu	a1,0(s6)
    5eac:	8556                	mv	a0,s5
    5eae:	00000097          	auipc	ra,0x0
    5eb2:	db2080e7          	jalr	-590(ra) # 5c60 <putc>
    5eb6:	8b4a                	mv	s6,s2
      state = 0;
    5eb8:	4981                	li	s3,0
    5eba:	bdd1                	j	5d8e <vprintf+0x60>
        putc(fd, c);
    5ebc:	85d2                	mv	a1,s4
    5ebe:	8556                	mv	a0,s5
    5ec0:	00000097          	auipc	ra,0x0
    5ec4:	da0080e7          	jalr	-608(ra) # 5c60 <putc>
      state = 0;
    5ec8:	4981                	li	s3,0
    5eca:	b5d1                	j	5d8e <vprintf+0x60>
        putc(fd, '%');
    5ecc:	85d2                	mv	a1,s4
    5ece:	8556                	mv	a0,s5
    5ed0:	00000097          	auipc	ra,0x0
    5ed4:	d90080e7          	jalr	-624(ra) # 5c60 <putc>
        putc(fd, c);
    5ed8:	85ca                	mv	a1,s2
    5eda:	8556                	mv	a0,s5
    5edc:	00000097          	auipc	ra,0x0
    5ee0:	d84080e7          	jalr	-636(ra) # 5c60 <putc>
      state = 0;
    5ee4:	4981                	li	s3,0
    5ee6:	b565                	j	5d8e <vprintf+0x60>
        s = va_arg(ap, char*);
    5ee8:	8b4a                	mv	s6,s2
      state = 0;
    5eea:	4981                	li	s3,0
    5eec:	b54d                	j	5d8e <vprintf+0x60>
    }
  }
}
    5eee:	70e6                	ld	ra,120(sp)
    5ef0:	7446                	ld	s0,112(sp)
    5ef2:	74a6                	ld	s1,104(sp)
    5ef4:	7906                	ld	s2,96(sp)
    5ef6:	69e6                	ld	s3,88(sp)
    5ef8:	6a46                	ld	s4,80(sp)
    5efa:	6aa6                	ld	s5,72(sp)
    5efc:	6b06                	ld	s6,64(sp)
    5efe:	7be2                	ld	s7,56(sp)
    5f00:	7c42                	ld	s8,48(sp)
    5f02:	7ca2                	ld	s9,40(sp)
    5f04:	7d02                	ld	s10,32(sp)
    5f06:	6de2                	ld	s11,24(sp)
    5f08:	6109                	addi	sp,sp,128
    5f0a:	8082                	ret

0000000000005f0c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5f0c:	715d                	addi	sp,sp,-80
    5f0e:	ec06                	sd	ra,24(sp)
    5f10:	e822                	sd	s0,16(sp)
    5f12:	1000                	addi	s0,sp,32
    5f14:	e010                	sd	a2,0(s0)
    5f16:	e414                	sd	a3,8(s0)
    5f18:	e818                	sd	a4,16(s0)
    5f1a:	ec1c                	sd	a5,24(s0)
    5f1c:	03043023          	sd	a6,32(s0)
    5f20:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5f24:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5f28:	8622                	mv	a2,s0
    5f2a:	00000097          	auipc	ra,0x0
    5f2e:	e04080e7          	jalr	-508(ra) # 5d2e <vprintf>
}
    5f32:	60e2                	ld	ra,24(sp)
    5f34:	6442                	ld	s0,16(sp)
    5f36:	6161                	addi	sp,sp,80
    5f38:	8082                	ret

0000000000005f3a <printf>:

void
printf(const char *fmt, ...)
{
    5f3a:	711d                	addi	sp,sp,-96
    5f3c:	ec06                	sd	ra,24(sp)
    5f3e:	e822                	sd	s0,16(sp)
    5f40:	1000                	addi	s0,sp,32
    5f42:	e40c                	sd	a1,8(s0)
    5f44:	e810                	sd	a2,16(s0)
    5f46:	ec14                	sd	a3,24(s0)
    5f48:	f018                	sd	a4,32(s0)
    5f4a:	f41c                	sd	a5,40(s0)
    5f4c:	03043823          	sd	a6,48(s0)
    5f50:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5f54:	00840613          	addi	a2,s0,8
    5f58:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5f5c:	85aa                	mv	a1,a0
    5f5e:	4505                	li	a0,1
    5f60:	00000097          	auipc	ra,0x0
    5f64:	dce080e7          	jalr	-562(ra) # 5d2e <vprintf>
}
    5f68:	60e2                	ld	ra,24(sp)
    5f6a:	6442                	ld	s0,16(sp)
    5f6c:	6125                	addi	sp,sp,96
    5f6e:	8082                	ret

0000000000005f70 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5f70:	1141                	addi	sp,sp,-16
    5f72:	e422                	sd	s0,8(sp)
    5f74:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5f76:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5f7a:	00003797          	auipc	a5,0x3
    5f7e:	4d67b783          	ld	a5,1238(a5) # 9450 <freep>
    5f82:	a02d                	j	5fac <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5f84:	4618                	lw	a4,8(a2)
    5f86:	9f2d                	addw	a4,a4,a1
    5f88:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5f8c:	6398                	ld	a4,0(a5)
    5f8e:	6310                	ld	a2,0(a4)
    5f90:	a83d                	j	5fce <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5f92:	ff852703          	lw	a4,-8(a0)
    5f96:	9f31                	addw	a4,a4,a2
    5f98:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    5f9a:	ff053683          	ld	a3,-16(a0)
    5f9e:	a091                	j	5fe2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5fa0:	6398                	ld	a4,0(a5)
    5fa2:	00e7e463          	bltu	a5,a4,5faa <free+0x3a>
    5fa6:	00e6ea63          	bltu	a3,a4,5fba <free+0x4a>
{
    5faa:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5fac:	fed7fae3          	bgeu	a5,a3,5fa0 <free+0x30>
    5fb0:	6398                	ld	a4,0(a5)
    5fb2:	00e6e463          	bltu	a3,a4,5fba <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5fb6:	fee7eae3          	bltu	a5,a4,5faa <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    5fba:	ff852583          	lw	a1,-8(a0)
    5fbe:	6390                	ld	a2,0(a5)
    5fc0:	02059813          	slli	a6,a1,0x20
    5fc4:	01c85713          	srli	a4,a6,0x1c
    5fc8:	9736                	add	a4,a4,a3
    5fca:	fae60de3          	beq	a2,a4,5f84 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    5fce:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    5fd2:	4790                	lw	a2,8(a5)
    5fd4:	02061593          	slli	a1,a2,0x20
    5fd8:	01c5d713          	srli	a4,a1,0x1c
    5fdc:	973e                	add	a4,a4,a5
    5fde:	fae68ae3          	beq	a3,a4,5f92 <free+0x22>
    p->s.ptr = bp->s.ptr;
    5fe2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    5fe4:	00003717          	auipc	a4,0x3
    5fe8:	46f73623          	sd	a5,1132(a4) # 9450 <freep>
}
    5fec:	6422                	ld	s0,8(sp)
    5fee:	0141                	addi	sp,sp,16
    5ff0:	8082                	ret

0000000000005ff2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    5ff2:	7139                	addi	sp,sp,-64
    5ff4:	fc06                	sd	ra,56(sp)
    5ff6:	f822                	sd	s0,48(sp)
    5ff8:	f426                	sd	s1,40(sp)
    5ffa:	f04a                	sd	s2,32(sp)
    5ffc:	ec4e                	sd	s3,24(sp)
    5ffe:	e852                	sd	s4,16(sp)
    6000:	e456                	sd	s5,8(sp)
    6002:	e05a                	sd	s6,0(sp)
    6004:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    6006:	02051493          	slli	s1,a0,0x20
    600a:	9081                	srli	s1,s1,0x20
    600c:	04bd                	addi	s1,s1,15
    600e:	8091                	srli	s1,s1,0x4
    6010:	0014899b          	addiw	s3,s1,1
    6014:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    6016:	00003517          	auipc	a0,0x3
    601a:	43a53503          	ld	a0,1082(a0) # 9450 <freep>
    601e:	c515                	beqz	a0,604a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    6020:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    6022:	4798                	lw	a4,8(a5)
    6024:	02977f63          	bgeu	a4,s1,6062 <malloc+0x70>
    6028:	8a4e                	mv	s4,s3
    602a:	0009871b          	sext.w	a4,s3
    602e:	6685                	lui	a3,0x1
    6030:	00d77363          	bgeu	a4,a3,6036 <malloc+0x44>
    6034:	6a05                	lui	s4,0x1
    6036:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    603a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    603e:	00003917          	auipc	s2,0x3
    6042:	41290913          	addi	s2,s2,1042 # 9450 <freep>
  if(p == (char*)-1)
    6046:	5afd                	li	s5,-1
    6048:	a895                	j	60bc <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    604a:	0000a797          	auipc	a5,0xa
    604e:	c2e78793          	addi	a5,a5,-978 # fc78 <base>
    6052:	00003717          	auipc	a4,0x3
    6056:	3ef73f23          	sd	a5,1022(a4) # 9450 <freep>
    605a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    605c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    6060:	b7e1                	j	6028 <malloc+0x36>
      if(p->s.size == nunits)
    6062:	02e48c63          	beq	s1,a4,609a <malloc+0xa8>
        p->s.size -= nunits;
    6066:	4137073b          	subw	a4,a4,s3
    606a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    606c:	02071693          	slli	a3,a4,0x20
    6070:	01c6d713          	srli	a4,a3,0x1c
    6074:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    6076:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    607a:	00003717          	auipc	a4,0x3
    607e:	3ca73b23          	sd	a0,982(a4) # 9450 <freep>
      return (void*)(p + 1);
    6082:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    6086:	70e2                	ld	ra,56(sp)
    6088:	7442                	ld	s0,48(sp)
    608a:	74a2                	ld	s1,40(sp)
    608c:	7902                	ld	s2,32(sp)
    608e:	69e2                	ld	s3,24(sp)
    6090:	6a42                	ld	s4,16(sp)
    6092:	6aa2                	ld	s5,8(sp)
    6094:	6b02                	ld	s6,0(sp)
    6096:	6121                	addi	sp,sp,64
    6098:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    609a:	6398                	ld	a4,0(a5)
    609c:	e118                	sd	a4,0(a0)
    609e:	bff1                	j	607a <malloc+0x88>
  hp->s.size = nu;
    60a0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    60a4:	0541                	addi	a0,a0,16
    60a6:	00000097          	auipc	ra,0x0
    60aa:	eca080e7          	jalr	-310(ra) # 5f70 <free>
  return freep;
    60ae:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    60b2:	d971                	beqz	a0,6086 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    60b4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    60b6:	4798                	lw	a4,8(a5)
    60b8:	fa9775e3          	bgeu	a4,s1,6062 <malloc+0x70>
    if(p == freep)
    60bc:	00093703          	ld	a4,0(s2)
    60c0:	853e                	mv	a0,a5
    60c2:	fef719e3          	bne	a4,a5,60b4 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    60c6:	8552                	mv	a0,s4
    60c8:	00000097          	auipc	ra,0x0
    60cc:	b80080e7          	jalr	-1152(ra) # 5c48 <sbrk>
  if(p == (char*)-1)
    60d0:	fd5518e3          	bne	a0,s5,60a0 <malloc+0xae>
        return 0;
    60d4:	4501                	li	a0,0
    60d6:	bf45                	j	6086 <malloc+0x94>
