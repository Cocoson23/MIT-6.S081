
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	89013103          	ld	sp,-1904(sp) # 80008890 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	03d050ef          	jal	ra,80005852 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <refadd>:
// lab cow add
int refcount[PHYSTOP/PGSIZE];

void
refadd(uint64 pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
    80000028:	892a                	mv	s2,a0
    int idx = pa / PGSIZE;
    8000002a:	00c55493          	srli	s1,a0,0xc
    acquire(&kmem.lock);
    8000002e:	00009517          	auipc	a0,0x9
    80000032:	00250513          	addi	a0,a0,2 # 80009030 <kmem>
    80000036:	00006097          	auipc	ra,0x6
    8000003a:	202080e7          	jalr	514(ra) # 80006238 <acquire>
    if(pa >= PHYSTOP || refcount[idx] < 1)
    8000003e:	47c5                	li	a5,17
    80000040:	07ee                	slli	a5,a5,0x1b
    80000042:	04f97363          	bgeu	s2,a5,80000088 <refadd+0x6c>
    80000046:	2481                	sext.w	s1,s1
    80000048:	00249713          	slli	a4,s1,0x2
    8000004c:	00009797          	auipc	a5,0x9
    80000050:	00478793          	addi	a5,a5,4 # 80009050 <refcount>
    80000054:	97ba                	add	a5,a5,a4
    80000056:	439c                	lw	a5,0(a5)
    80000058:	02f05863          	blez	a5,80000088 <refadd+0x6c>
        panic("refadd:");
    refcount[idx] += 1;
    8000005c:	048a                	slli	s1,s1,0x2
    8000005e:	00009717          	auipc	a4,0x9
    80000062:	ff270713          	addi	a4,a4,-14 # 80009050 <refcount>
    80000066:	9726                	add	a4,a4,s1
    80000068:	2785                	addiw	a5,a5,1
    8000006a:	c31c                	sw	a5,0(a4)
    release(&kmem.lock);
    8000006c:	00009517          	auipc	a0,0x9
    80000070:	fc450513          	addi	a0,a0,-60 # 80009030 <kmem>
    80000074:	00006097          	auipc	ra,0x6
    80000078:	278080e7          	jalr	632(ra) # 800062ec <release>
}
    8000007c:	60e2                	ld	ra,24(sp)
    8000007e:	6442                	ld	s0,16(sp)
    80000080:	64a2                	ld	s1,8(sp)
    80000082:	6902                	ld	s2,0(sp)
    80000084:	6105                	addi	sp,sp,32
    80000086:	8082                	ret
        panic("refadd:");
    80000088:	00008517          	auipc	a0,0x8
    8000008c:	f8850513          	addi	a0,a0,-120 # 80008010 <etext+0x10>
    80000090:	00006097          	auipc	ra,0x6
    80000094:	c70080e7          	jalr	-912(ra) # 80005d00 <panic>

0000000080000098 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80000098:	1101                	addi	sp,sp,-32
    8000009a:	ec06                	sd	ra,24(sp)
    8000009c:	e822                	sd	s0,16(sp)
    8000009e:	e426                	sd	s1,8(sp)
    800000a0:	e04a                	sd	s2,0(sp)
    800000a2:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    800000a4:	03451793          	slli	a5,a0,0x34
    800000a8:	efa5                	bnez	a5,80000120 <kfree+0x88>
    800000aa:	84aa                	mv	s1,a0
    800000ac:	00246797          	auipc	a5,0x246
    800000b0:	19478793          	addi	a5,a5,404 # 80246240 <end>
    800000b4:	06f56663          	bltu	a0,a5,80000120 <kfree+0x88>
    800000b8:	47c5                	li	a5,17
    800000ba:	07ee                	slli	a5,a5,0x1b
    800000bc:	06f57263          	bgeu	a0,a5,80000120 <kfree+0x88>
    panic("kfree");

  acquire(&kmem.lock);
    800000c0:	00009517          	auipc	a0,0x9
    800000c4:	f7050513          	addi	a0,a0,-144 # 80009030 <kmem>
    800000c8:	00006097          	auipc	ra,0x6
    800000cc:	170080e7          	jalr	368(ra) # 80006238 <acquire>
  int idx = (uint64)pa / PGSIZE;
    800000d0:	00c4d793          	srli	a5,s1,0xc
    800000d4:	2781                	sext.w	a5,a5
  if(refcount[idx] < 1)
    800000d6:	00279693          	slli	a3,a5,0x2
    800000da:	00009717          	auipc	a4,0x9
    800000de:	f7670713          	addi	a4,a4,-138 # 80009050 <refcount>
    800000e2:	9736                	add	a4,a4,a3
    800000e4:	4318                	lw	a4,0(a4)
    800000e6:	04e05563          	blez	a4,80000130 <kfree+0x98>
      panic("kfree: refcount");
  // 每次kfree对应pa的ref减一
  refcount[idx] -= 1;
    800000ea:	078a                	slli	a5,a5,0x2
    800000ec:	00009917          	auipc	s2,0x9
    800000f0:	f6490913          	addi	s2,s2,-156 # 80009050 <refcount>
    800000f4:	993e                	add	s2,s2,a5
    800000f6:	377d                	addiw	a4,a4,-1
    800000f8:	00e92023          	sw	a4,0(s2)
  release(&kmem.lock);
    800000fc:	00009517          	auipc	a0,0x9
    80000100:	f3450513          	addi	a0,a0,-204 # 80009030 <kmem>
    80000104:	00006097          	auipc	ra,0x6
    80000108:	1e8080e7          	jalr	488(ra) # 800062ec <release>
  // 当且仅当refcount == 0时才释放页面
  if(refcount[idx] > 0)
    8000010c:	00092783          	lw	a5,0(s2)
    80000110:	02f05863          	blez	a5,80000140 <kfree+0xa8>

  acquire(&kmem.lock);
  r->next = kmem.freelist;
  kmem.freelist = r;
  release(&kmem.lock);
}
    80000114:	60e2                	ld	ra,24(sp)
    80000116:	6442                	ld	s0,16(sp)
    80000118:	64a2                	ld	s1,8(sp)
    8000011a:	6902                	ld	s2,0(sp)
    8000011c:	6105                	addi	sp,sp,32
    8000011e:	8082                	ret
    panic("kfree");
    80000120:	00008517          	auipc	a0,0x8
    80000124:	ef850513          	addi	a0,a0,-264 # 80008018 <etext+0x18>
    80000128:	00006097          	auipc	ra,0x6
    8000012c:	bd8080e7          	jalr	-1064(ra) # 80005d00 <panic>
      panic("kfree: refcount");
    80000130:	00008517          	auipc	a0,0x8
    80000134:	ef050513          	addi	a0,a0,-272 # 80008020 <etext+0x20>
    80000138:	00006097          	auipc	ra,0x6
    8000013c:	bc8080e7          	jalr	-1080(ra) # 80005d00 <panic>
  memset(pa, 1, PGSIZE);
    80000140:	6605                	lui	a2,0x1
    80000142:	4585                	li	a1,1
    80000144:	8526                	mv	a0,s1
    80000146:	00000097          	auipc	ra,0x0
    8000014a:	176080e7          	jalr	374(ra) # 800002bc <memset>
  acquire(&kmem.lock);
    8000014e:	00009917          	auipc	s2,0x9
    80000152:	ee290913          	addi	s2,s2,-286 # 80009030 <kmem>
    80000156:	854a                	mv	a0,s2
    80000158:	00006097          	auipc	ra,0x6
    8000015c:	0e0080e7          	jalr	224(ra) # 80006238 <acquire>
  r->next = kmem.freelist;
    80000160:	01893783          	ld	a5,24(s2)
    80000164:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000166:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000016a:	854a                	mv	a0,s2
    8000016c:	00006097          	auipc	ra,0x6
    80000170:	180080e7          	jalr	384(ra) # 800062ec <release>
    80000174:	b745                	j	80000114 <kfree+0x7c>

0000000080000176 <freerange>:
{
    80000176:	7139                	addi	sp,sp,-64
    80000178:	fc06                	sd	ra,56(sp)
    8000017a:	f822                	sd	s0,48(sp)
    8000017c:	f426                	sd	s1,40(sp)
    8000017e:	f04a                	sd	s2,32(sp)
    80000180:	ec4e                	sd	s3,24(sp)
    80000182:	e852                	sd	s4,16(sp)
    80000184:	e456                	sd	s5,8(sp)
    80000186:	e05a                	sd	s6,0(sp)
    80000188:	0080                	addi	s0,sp,64
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000018a:	6785                	lui	a5,0x1
    8000018c:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000190:	953a                	add	a0,a0,a4
    80000192:	777d                	lui	a4,0xfffff
    80000194:	00e574b3          	and	s1,a0,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE) {
    80000198:	97a6                	add	a5,a5,s1
    8000019a:	02f5ea63          	bltu	a1,a5,800001ce <freerange+0x58>
    8000019e:	892e                	mv	s2,a1
    refcount[(uint64)p / PGSIZE] = 1;  
    800001a0:	00009b17          	auipc	s6,0x9
    800001a4:	eb0b0b13          	addi	s6,s6,-336 # 80009050 <refcount>
    800001a8:	4a85                	li	s5,1
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE) {
    800001aa:	6a05                	lui	s4,0x1
    800001ac:	6989                	lui	s3,0x2
    refcount[(uint64)p / PGSIZE] = 1;  
    800001ae:	00c4d793          	srli	a5,s1,0xc
    800001b2:	078a                	slli	a5,a5,0x2
    800001b4:	97da                	add	a5,a5,s6
    800001b6:	0157a023          	sw	s5,0(a5)
    kfree(p);  
    800001ba:	8526                	mv	a0,s1
    800001bc:	00000097          	auipc	ra,0x0
    800001c0:	edc080e7          	jalr	-292(ra) # 80000098 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE) {
    800001c4:	87a6                	mv	a5,s1
    800001c6:	94d2                	add	s1,s1,s4
    800001c8:	97ce                	add	a5,a5,s3
    800001ca:	fef972e3          	bgeu	s2,a5,800001ae <freerange+0x38>
}
    800001ce:	70e2                	ld	ra,56(sp)
    800001d0:	7442                	ld	s0,48(sp)
    800001d2:	74a2                	ld	s1,40(sp)
    800001d4:	7902                	ld	s2,32(sp)
    800001d6:	69e2                	ld	s3,24(sp)
    800001d8:	6a42                	ld	s4,16(sp)
    800001da:	6aa2                	ld	s5,8(sp)
    800001dc:	6b02                	ld	s6,0(sp)
    800001de:	6121                	addi	sp,sp,64
    800001e0:	8082                	ret

00000000800001e2 <kinit>:
{
    800001e2:	1141                	addi	sp,sp,-16
    800001e4:	e406                	sd	ra,8(sp)
    800001e6:	e022                	sd	s0,0(sp)
    800001e8:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800001ea:	00008597          	auipc	a1,0x8
    800001ee:	e4658593          	addi	a1,a1,-442 # 80008030 <etext+0x30>
    800001f2:	00009517          	auipc	a0,0x9
    800001f6:	e3e50513          	addi	a0,a0,-450 # 80009030 <kmem>
    800001fa:	00006097          	auipc	ra,0x6
    800001fe:	fae080e7          	jalr	-82(ra) # 800061a8 <initlock>
  freerange(end, (void*)PHYSTOP);
    80000202:	45c5                	li	a1,17
    80000204:	05ee                	slli	a1,a1,0x1b
    80000206:	00246517          	auipc	a0,0x246
    8000020a:	03a50513          	addi	a0,a0,58 # 80246240 <end>
    8000020e:	00000097          	auipc	ra,0x0
    80000212:	f68080e7          	jalr	-152(ra) # 80000176 <freerange>
}
    80000216:	60a2                	ld	ra,8(sp)
    80000218:	6402                	ld	s0,0(sp)
    8000021a:	0141                	addi	sp,sp,16
    8000021c:	8082                	ret

000000008000021e <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000021e:	1101                	addi	sp,sp,-32
    80000220:	ec06                	sd	ra,24(sp)
    80000222:	e822                	sd	s0,16(sp)
    80000224:	e426                	sd	s1,8(sp)
    80000226:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000228:	00009497          	auipc	s1,0x9
    8000022c:	e0848493          	addi	s1,s1,-504 # 80009030 <kmem>
    80000230:	8526                	mv	a0,s1
    80000232:	00006097          	auipc	ra,0x6
    80000236:	006080e7          	jalr	6(ra) # 80006238 <acquire>
  r = kmem.freelist;
    8000023a:	6c84                	ld	s1,24(s1)
  if(r) {
    8000023c:	c4bd                	beqz	s1,800002aa <kalloc+0x8c>
    kmem.freelist = r->next;
    8000023e:	609c                	ld	a5,0(s1)
    80000240:	00009717          	auipc	a4,0x9
    80000244:	e0f73423          	sd	a5,-504(a4) # 80009048 <kmem+0x18>
    int idx = (uint64)r / PGSIZE;
    80000248:	00c4d793          	srli	a5,s1,0xc
    8000024c:	2781                	sext.w	a5,a5
    if(refcount[idx] != 0)
    8000024e:	00279693          	slli	a3,a5,0x2
    80000252:	00009717          	auipc	a4,0x9
    80000256:	dfe70713          	addi	a4,a4,-514 # 80009050 <refcount>
    8000025a:	9736                	add	a4,a4,a3
    8000025c:	4318                	lw	a4,0(a4)
    8000025e:	ef15                	bnez	a4,8000029a <kalloc+0x7c>
        panic("kalloc: refcount");
    refcount[idx] = 1;
    80000260:	078a                	slli	a5,a5,0x2
    80000262:	00009717          	auipc	a4,0x9
    80000266:	dee70713          	addi	a4,a4,-530 # 80009050 <refcount>
    8000026a:	97ba                	add	a5,a5,a4
    8000026c:	4705                	li	a4,1
    8000026e:	c398                	sw	a4,0(a5)
  }
  release(&kmem.lock);
    80000270:	00009517          	auipc	a0,0x9
    80000274:	dc050513          	addi	a0,a0,-576 # 80009030 <kmem>
    80000278:	00006097          	auipc	ra,0x6
    8000027c:	074080e7          	jalr	116(ra) # 800062ec <release>

  if(r) {
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000280:	6605                	lui	a2,0x1
    80000282:	4595                	li	a1,5
    80000284:	8526                	mv	a0,s1
    80000286:	00000097          	auipc	ra,0x0
    8000028a:	036080e7          	jalr	54(ra) # 800002bc <memset>
  }
  return (void*)r;
}
    8000028e:	8526                	mv	a0,s1
    80000290:	60e2                	ld	ra,24(sp)
    80000292:	6442                	ld	s0,16(sp)
    80000294:	64a2                	ld	s1,8(sp)
    80000296:	6105                	addi	sp,sp,32
    80000298:	8082                	ret
        panic("kalloc: refcount");
    8000029a:	00008517          	auipc	a0,0x8
    8000029e:	d9e50513          	addi	a0,a0,-610 # 80008038 <etext+0x38>
    800002a2:	00006097          	auipc	ra,0x6
    800002a6:	a5e080e7          	jalr	-1442(ra) # 80005d00 <panic>
  release(&kmem.lock);
    800002aa:	00009517          	auipc	a0,0x9
    800002ae:	d8650513          	addi	a0,a0,-634 # 80009030 <kmem>
    800002b2:	00006097          	auipc	ra,0x6
    800002b6:	03a080e7          	jalr	58(ra) # 800062ec <release>
  if(r) {
    800002ba:	bfd1                	j	8000028e <kalloc+0x70>

00000000800002bc <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    800002bc:	1141                	addi	sp,sp,-16
    800002be:	e422                	sd	s0,8(sp)
    800002c0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    800002c2:	ca19                	beqz	a2,800002d8 <memset+0x1c>
    800002c4:	87aa                	mv	a5,a0
    800002c6:	1602                	slli	a2,a2,0x20
    800002c8:	9201                	srli	a2,a2,0x20
    800002ca:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    800002ce:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    800002d2:	0785                	addi	a5,a5,1
    800002d4:	fee79de3          	bne	a5,a4,800002ce <memset+0x12>
  }
  return dst;
}
    800002d8:	6422                	ld	s0,8(sp)
    800002da:	0141                	addi	sp,sp,16
    800002dc:	8082                	ret

00000000800002de <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    800002de:	1141                	addi	sp,sp,-16
    800002e0:	e422                	sd	s0,8(sp)
    800002e2:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800002e4:	ca05                	beqz	a2,80000314 <memcmp+0x36>
    800002e6:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    800002ea:	1682                	slli	a3,a3,0x20
    800002ec:	9281                	srli	a3,a3,0x20
    800002ee:	0685                	addi	a3,a3,1
    800002f0:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800002f2:	00054783          	lbu	a5,0(a0)
    800002f6:	0005c703          	lbu	a4,0(a1)
    800002fa:	00e79863          	bne	a5,a4,8000030a <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800002fe:	0505                	addi	a0,a0,1
    80000300:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000302:	fed518e3          	bne	a0,a3,800002f2 <memcmp+0x14>
  }

  return 0;
    80000306:	4501                	li	a0,0
    80000308:	a019                	j	8000030e <memcmp+0x30>
      return *s1 - *s2;
    8000030a:	40e7853b          	subw	a0,a5,a4
}
    8000030e:	6422                	ld	s0,8(sp)
    80000310:	0141                	addi	sp,sp,16
    80000312:	8082                	ret
  return 0;
    80000314:	4501                	li	a0,0
    80000316:	bfe5                	j	8000030e <memcmp+0x30>

0000000080000318 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000318:	1141                	addi	sp,sp,-16
    8000031a:	e422                	sd	s0,8(sp)
    8000031c:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    8000031e:	c205                	beqz	a2,8000033e <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000320:	02a5e263          	bltu	a1,a0,80000344 <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    80000324:	1602                	slli	a2,a2,0x20
    80000326:	9201                	srli	a2,a2,0x20
    80000328:	00c587b3          	add	a5,a1,a2
{
    8000032c:	872a                	mv	a4,a0
      *d++ = *s++;
    8000032e:	0585                	addi	a1,a1,1
    80000330:	0705                	addi	a4,a4,1
    80000332:	fff5c683          	lbu	a3,-1(a1)
    80000336:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    8000033a:	fef59ae3          	bne	a1,a5,8000032e <memmove+0x16>

  return dst;
}
    8000033e:	6422                	ld	s0,8(sp)
    80000340:	0141                	addi	sp,sp,16
    80000342:	8082                	ret
  if(s < d && s + n > d){
    80000344:	02061693          	slli	a3,a2,0x20
    80000348:	9281                	srli	a3,a3,0x20
    8000034a:	00d58733          	add	a4,a1,a3
    8000034e:	fce57be3          	bgeu	a0,a4,80000324 <memmove+0xc>
    d += n;
    80000352:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000354:	fff6079b          	addiw	a5,a2,-1
    80000358:	1782                	slli	a5,a5,0x20
    8000035a:	9381                	srli	a5,a5,0x20
    8000035c:	fff7c793          	not	a5,a5
    80000360:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000362:	177d                	addi	a4,a4,-1
    80000364:	16fd                	addi	a3,a3,-1
    80000366:	00074603          	lbu	a2,0(a4)
    8000036a:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    8000036e:	fee79ae3          	bne	a5,a4,80000362 <memmove+0x4a>
    80000372:	b7f1                	j	8000033e <memmove+0x26>

0000000080000374 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000374:	1141                	addi	sp,sp,-16
    80000376:	e406                	sd	ra,8(sp)
    80000378:	e022                	sd	s0,0(sp)
    8000037a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8000037c:	00000097          	auipc	ra,0x0
    80000380:	f9c080e7          	jalr	-100(ra) # 80000318 <memmove>
}
    80000384:	60a2                	ld	ra,8(sp)
    80000386:	6402                	ld	s0,0(sp)
    80000388:	0141                	addi	sp,sp,16
    8000038a:	8082                	ret

000000008000038c <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000038c:	1141                	addi	sp,sp,-16
    8000038e:	e422                	sd	s0,8(sp)
    80000390:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000392:	ce11                	beqz	a2,800003ae <strncmp+0x22>
    80000394:	00054783          	lbu	a5,0(a0)
    80000398:	cf89                	beqz	a5,800003b2 <strncmp+0x26>
    8000039a:	0005c703          	lbu	a4,0(a1)
    8000039e:	00f71a63          	bne	a4,a5,800003b2 <strncmp+0x26>
    n--, p++, q++;
    800003a2:	367d                	addiw	a2,a2,-1
    800003a4:	0505                	addi	a0,a0,1
    800003a6:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    800003a8:	f675                	bnez	a2,80000394 <strncmp+0x8>
  if(n == 0)
    return 0;
    800003aa:	4501                	li	a0,0
    800003ac:	a809                	j	800003be <strncmp+0x32>
    800003ae:	4501                	li	a0,0
    800003b0:	a039                	j	800003be <strncmp+0x32>
  if(n == 0)
    800003b2:	ca09                	beqz	a2,800003c4 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    800003b4:	00054503          	lbu	a0,0(a0)
    800003b8:	0005c783          	lbu	a5,0(a1)
    800003bc:	9d1d                	subw	a0,a0,a5
}
    800003be:	6422                	ld	s0,8(sp)
    800003c0:	0141                	addi	sp,sp,16
    800003c2:	8082                	ret
    return 0;
    800003c4:	4501                	li	a0,0
    800003c6:	bfe5                	j	800003be <strncmp+0x32>

00000000800003c8 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    800003c8:	1141                	addi	sp,sp,-16
    800003ca:	e422                	sd	s0,8(sp)
    800003cc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    800003ce:	872a                	mv	a4,a0
    800003d0:	8832                	mv	a6,a2
    800003d2:	367d                	addiw	a2,a2,-1
    800003d4:	01005963          	blez	a6,800003e6 <strncpy+0x1e>
    800003d8:	0705                	addi	a4,a4,1
    800003da:	0005c783          	lbu	a5,0(a1)
    800003de:	fef70fa3          	sb	a5,-1(a4)
    800003e2:	0585                	addi	a1,a1,1
    800003e4:	f7f5                	bnez	a5,800003d0 <strncpy+0x8>
    ;
  while(n-- > 0)
    800003e6:	86ba                	mv	a3,a4
    800003e8:	00c05c63          	blez	a2,80000400 <strncpy+0x38>
    *s++ = 0;
    800003ec:	0685                	addi	a3,a3,1
    800003ee:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    800003f2:	40d707bb          	subw	a5,a4,a3
    800003f6:	37fd                	addiw	a5,a5,-1
    800003f8:	010787bb          	addw	a5,a5,a6
    800003fc:	fef048e3          	bgtz	a5,800003ec <strncpy+0x24>
  return os;
}
    80000400:	6422                	ld	s0,8(sp)
    80000402:	0141                	addi	sp,sp,16
    80000404:	8082                	ret

0000000080000406 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000406:	1141                	addi	sp,sp,-16
    80000408:	e422                	sd	s0,8(sp)
    8000040a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    8000040c:	02c05363          	blez	a2,80000432 <safestrcpy+0x2c>
    80000410:	fff6069b          	addiw	a3,a2,-1
    80000414:	1682                	slli	a3,a3,0x20
    80000416:	9281                	srli	a3,a3,0x20
    80000418:	96ae                	add	a3,a3,a1
    8000041a:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    8000041c:	00d58963          	beq	a1,a3,8000042e <safestrcpy+0x28>
    80000420:	0585                	addi	a1,a1,1
    80000422:	0785                	addi	a5,a5,1
    80000424:	fff5c703          	lbu	a4,-1(a1)
    80000428:	fee78fa3          	sb	a4,-1(a5)
    8000042c:	fb65                	bnez	a4,8000041c <safestrcpy+0x16>
    ;
  *s = 0;
    8000042e:	00078023          	sb	zero,0(a5)
  return os;
}
    80000432:	6422                	ld	s0,8(sp)
    80000434:	0141                	addi	sp,sp,16
    80000436:	8082                	ret

0000000080000438 <strlen>:

int
strlen(const char *s)
{
    80000438:	1141                	addi	sp,sp,-16
    8000043a:	e422                	sd	s0,8(sp)
    8000043c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    8000043e:	00054783          	lbu	a5,0(a0)
    80000442:	cf91                	beqz	a5,8000045e <strlen+0x26>
    80000444:	0505                	addi	a0,a0,1
    80000446:	87aa                	mv	a5,a0
    80000448:	4685                	li	a3,1
    8000044a:	9e89                	subw	a3,a3,a0
    8000044c:	00f6853b          	addw	a0,a3,a5
    80000450:	0785                	addi	a5,a5,1
    80000452:	fff7c703          	lbu	a4,-1(a5)
    80000456:	fb7d                	bnez	a4,8000044c <strlen+0x14>
    ;
  return n;
}
    80000458:	6422                	ld	s0,8(sp)
    8000045a:	0141                	addi	sp,sp,16
    8000045c:	8082                	ret
  for(n = 0; s[n]; n++)
    8000045e:	4501                	li	a0,0
    80000460:	bfe5                	j	80000458 <strlen+0x20>

0000000080000462 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000462:	1141                	addi	sp,sp,-16
    80000464:	e406                	sd	ra,8(sp)
    80000466:	e022                	sd	s0,0(sp)
    80000468:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000046a:	00001097          	auipc	ra,0x1
    8000046e:	baa080e7          	jalr	-1110(ra) # 80001014 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000472:	00009717          	auipc	a4,0x9
    80000476:	b8e70713          	addi	a4,a4,-1138 # 80009000 <started>
  if(cpuid() == 0){
    8000047a:	c139                	beqz	a0,800004c0 <main+0x5e>
    while(started == 0)
    8000047c:	431c                	lw	a5,0(a4)
    8000047e:	2781                	sext.w	a5,a5
    80000480:	dff5                	beqz	a5,8000047c <main+0x1a>
      ;
    __sync_synchronize();
    80000482:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000486:	00001097          	auipc	ra,0x1
    8000048a:	b8e080e7          	jalr	-1138(ra) # 80001014 <cpuid>
    8000048e:	85aa                	mv	a1,a0
    80000490:	00008517          	auipc	a0,0x8
    80000494:	bd850513          	addi	a0,a0,-1064 # 80008068 <etext+0x68>
    80000498:	00006097          	auipc	ra,0x6
    8000049c:	8b2080e7          	jalr	-1870(ra) # 80005d4a <printf>
    kvminithart();    // turn on paging
    800004a0:	00000097          	auipc	ra,0x0
    800004a4:	0d8080e7          	jalr	216(ra) # 80000578 <kvminithart>
    trapinithart();   // install kernel trap vector
    800004a8:	00001097          	auipc	ra,0x1
    800004ac:	7ee080e7          	jalr	2030(ra) # 80001c96 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    800004b0:	00005097          	auipc	ra,0x5
    800004b4:	d80080e7          	jalr	-640(ra) # 80005230 <plicinithart>
  }

  scheduler();        
    800004b8:	00001097          	auipc	ra,0x1
    800004bc:	09a080e7          	jalr	154(ra) # 80001552 <scheduler>
    consoleinit();
    800004c0:	00005097          	auipc	ra,0x5
    800004c4:	750080e7          	jalr	1872(ra) # 80005c10 <consoleinit>
    printfinit();
    800004c8:	00006097          	auipc	ra,0x6
    800004cc:	a62080e7          	jalr	-1438(ra) # 80005f2a <printfinit>
    printf("\n");
    800004d0:	00008517          	auipc	a0,0x8
    800004d4:	ba850513          	addi	a0,a0,-1112 # 80008078 <etext+0x78>
    800004d8:	00006097          	auipc	ra,0x6
    800004dc:	872080e7          	jalr	-1934(ra) # 80005d4a <printf>
    printf("xv6 kernel is booting\n");
    800004e0:	00008517          	auipc	a0,0x8
    800004e4:	b7050513          	addi	a0,a0,-1168 # 80008050 <etext+0x50>
    800004e8:	00006097          	auipc	ra,0x6
    800004ec:	862080e7          	jalr	-1950(ra) # 80005d4a <printf>
    printf("\n");
    800004f0:	00008517          	auipc	a0,0x8
    800004f4:	b8850513          	addi	a0,a0,-1144 # 80008078 <etext+0x78>
    800004f8:	00006097          	auipc	ra,0x6
    800004fc:	852080e7          	jalr	-1966(ra) # 80005d4a <printf>
    kinit();         // physical page allocator
    80000500:	00000097          	auipc	ra,0x0
    80000504:	ce2080e7          	jalr	-798(ra) # 800001e2 <kinit>
    kvminit();       // create kernel page table
    80000508:	00000097          	auipc	ra,0x0
    8000050c:	322080e7          	jalr	802(ra) # 8000082a <kvminit>
    kvminithart();   // turn on paging
    80000510:	00000097          	auipc	ra,0x0
    80000514:	068080e7          	jalr	104(ra) # 80000578 <kvminithart>
    procinit();      // process table
    80000518:	00001097          	auipc	ra,0x1
    8000051c:	a4c080e7          	jalr	-1460(ra) # 80000f64 <procinit>
    trapinit();      // trap vectors
    80000520:	00001097          	auipc	ra,0x1
    80000524:	74e080e7          	jalr	1870(ra) # 80001c6e <trapinit>
    trapinithart();  // install kernel trap vector
    80000528:	00001097          	auipc	ra,0x1
    8000052c:	76e080e7          	jalr	1902(ra) # 80001c96 <trapinithart>
    plicinit();      // set up interrupt controller
    80000530:	00005097          	auipc	ra,0x5
    80000534:	cea080e7          	jalr	-790(ra) # 8000521a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000538:	00005097          	auipc	ra,0x5
    8000053c:	cf8080e7          	jalr	-776(ra) # 80005230 <plicinithart>
    binit();         // buffer cache
    80000540:	00002097          	auipc	ra,0x2
    80000544:	eb6080e7          	jalr	-330(ra) # 800023f6 <binit>
    iinit();         // inode table
    80000548:	00002097          	auipc	ra,0x2
    8000054c:	544080e7          	jalr	1348(ra) # 80002a8c <iinit>
    fileinit();      // file table
    80000550:	00003097          	auipc	ra,0x3
    80000554:	4f6080e7          	jalr	1270(ra) # 80003a46 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000558:	00005097          	auipc	ra,0x5
    8000055c:	df8080e7          	jalr	-520(ra) # 80005350 <virtio_disk_init>
    userinit();      // first user process
    80000560:	00001097          	auipc	ra,0x1
    80000564:	db8080e7          	jalr	-584(ra) # 80001318 <userinit>
    __sync_synchronize();
    80000568:	0ff0000f          	fence
    started = 1;
    8000056c:	4785                	li	a5,1
    8000056e:	00009717          	auipc	a4,0x9
    80000572:	a8f72923          	sw	a5,-1390(a4) # 80009000 <started>
    80000576:	b789                	j	800004b8 <main+0x56>

0000000080000578 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000578:	1141                	addi	sp,sp,-16
    8000057a:	e422                	sd	s0,8(sp)
    8000057c:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    8000057e:	00009797          	auipc	a5,0x9
    80000582:	a8a7b783          	ld	a5,-1398(a5) # 80009008 <kernel_pagetable>
    80000586:	83b1                	srli	a5,a5,0xc
    80000588:	577d                	li	a4,-1
    8000058a:	177e                	slli	a4,a4,0x3f
    8000058c:	8fd9                	or	a5,a5,a4
// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
    8000058e:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000592:	12000073          	sfence.vma
  sfence_vma();
}
    80000596:	6422                	ld	s0,8(sp)
    80000598:	0141                	addi	sp,sp,16
    8000059a:	8082                	ret

000000008000059c <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    8000059c:	7139                	addi	sp,sp,-64
    8000059e:	fc06                	sd	ra,56(sp)
    800005a0:	f822                	sd	s0,48(sp)
    800005a2:	f426                	sd	s1,40(sp)
    800005a4:	f04a                	sd	s2,32(sp)
    800005a6:	ec4e                	sd	s3,24(sp)
    800005a8:	e852                	sd	s4,16(sp)
    800005aa:	e456                	sd	s5,8(sp)
    800005ac:	e05a                	sd	s6,0(sp)
    800005ae:	0080                	addi	s0,sp,64
    800005b0:	84aa                	mv	s1,a0
    800005b2:	89ae                	mv	s3,a1
    800005b4:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    800005b6:	57fd                	li	a5,-1
    800005b8:	83e9                	srli	a5,a5,0x1a
    800005ba:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    800005bc:	4b31                	li	s6,12
  if(va >= MAXVA)
    800005be:	04b7f263          	bgeu	a5,a1,80000602 <walk+0x66>
    panic("walk");
    800005c2:	00008517          	auipc	a0,0x8
    800005c6:	abe50513          	addi	a0,a0,-1346 # 80008080 <etext+0x80>
    800005ca:	00005097          	auipc	ra,0x5
    800005ce:	736080e7          	jalr	1846(ra) # 80005d00 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    800005d2:	060a8663          	beqz	s5,8000063e <walk+0xa2>
    800005d6:	00000097          	auipc	ra,0x0
    800005da:	c48080e7          	jalr	-952(ra) # 8000021e <kalloc>
    800005de:	84aa                	mv	s1,a0
    800005e0:	c529                	beqz	a0,8000062a <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800005e2:	6605                	lui	a2,0x1
    800005e4:	4581                	li	a1,0
    800005e6:	00000097          	auipc	ra,0x0
    800005ea:	cd6080e7          	jalr	-810(ra) # 800002bc <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800005ee:	00c4d793          	srli	a5,s1,0xc
    800005f2:	07aa                	slli	a5,a5,0xa
    800005f4:	0017e793          	ori	a5,a5,1
    800005f8:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800005fc:	3a5d                	addiw	s4,s4,-9 # ff7 <_entry-0x7ffff009>
    800005fe:	036a0063          	beq	s4,s6,8000061e <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    80000602:	0149d933          	srl	s2,s3,s4
    80000606:	1ff97913          	andi	s2,s2,511
    8000060a:	090e                	slli	s2,s2,0x3
    8000060c:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    8000060e:	00093483          	ld	s1,0(s2)
    80000612:	0014f793          	andi	a5,s1,1
    80000616:	dfd5                	beqz	a5,800005d2 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000618:	80a9                	srli	s1,s1,0xa
    8000061a:	04b2                	slli	s1,s1,0xc
    8000061c:	b7c5                	j	800005fc <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    8000061e:	00c9d513          	srli	a0,s3,0xc
    80000622:	1ff57513          	andi	a0,a0,511
    80000626:	050e                	slli	a0,a0,0x3
    80000628:	9526                	add	a0,a0,s1
}
    8000062a:	70e2                	ld	ra,56(sp)
    8000062c:	7442                	ld	s0,48(sp)
    8000062e:	74a2                	ld	s1,40(sp)
    80000630:	7902                	ld	s2,32(sp)
    80000632:	69e2                	ld	s3,24(sp)
    80000634:	6a42                	ld	s4,16(sp)
    80000636:	6aa2                	ld	s5,8(sp)
    80000638:	6b02                	ld	s6,0(sp)
    8000063a:	6121                	addi	sp,sp,64
    8000063c:	8082                	ret
        return 0;
    8000063e:	4501                	li	a0,0
    80000640:	b7ed                	j	8000062a <walk+0x8e>

0000000080000642 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000642:	57fd                	li	a5,-1
    80000644:	83e9                	srli	a5,a5,0x1a
    80000646:	00b7f463          	bgeu	a5,a1,8000064e <walkaddr+0xc>
    return 0;
    8000064a:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    8000064c:	8082                	ret
{
    8000064e:	1141                	addi	sp,sp,-16
    80000650:	e406                	sd	ra,8(sp)
    80000652:	e022                	sd	s0,0(sp)
    80000654:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000656:	4601                	li	a2,0
    80000658:	00000097          	auipc	ra,0x0
    8000065c:	f44080e7          	jalr	-188(ra) # 8000059c <walk>
  if(pte == 0)
    80000660:	c105                	beqz	a0,80000680 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80000662:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80000664:	0117f693          	andi	a3,a5,17
    80000668:	4745                	li	a4,17
    return 0;
    8000066a:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    8000066c:	00e68663          	beq	a3,a4,80000678 <walkaddr+0x36>
}
    80000670:	60a2                	ld	ra,8(sp)
    80000672:	6402                	ld	s0,0(sp)
    80000674:	0141                	addi	sp,sp,16
    80000676:	8082                	ret
  pa = PTE2PA(*pte);
    80000678:	83a9                	srli	a5,a5,0xa
    8000067a:	00c79513          	slli	a0,a5,0xc
  return pa;
    8000067e:	bfcd                	j	80000670 <walkaddr+0x2e>
    return 0;
    80000680:	4501                	li	a0,0
    80000682:	b7fd                	j	80000670 <walkaddr+0x2e>

0000000080000684 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000684:	715d                	addi	sp,sp,-80
    80000686:	e486                	sd	ra,72(sp)
    80000688:	e0a2                	sd	s0,64(sp)
    8000068a:	fc26                	sd	s1,56(sp)
    8000068c:	f84a                	sd	s2,48(sp)
    8000068e:	f44e                	sd	s3,40(sp)
    80000690:	f052                	sd	s4,32(sp)
    80000692:	ec56                	sd	s5,24(sp)
    80000694:	e85a                	sd	s6,16(sp)
    80000696:	e45e                	sd	s7,8(sp)
    80000698:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    8000069a:	c639                	beqz	a2,800006e8 <mappages+0x64>
    8000069c:	8aaa                	mv	s5,a0
    8000069e:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    800006a0:	777d                	lui	a4,0xfffff
    800006a2:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    800006a6:	fff58993          	addi	s3,a1,-1
    800006aa:	99b2                	add	s3,s3,a2
    800006ac:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    800006b0:	893e                	mv	s2,a5
    800006b2:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800006b6:	6b85                	lui	s7,0x1
    800006b8:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800006bc:	4605                	li	a2,1
    800006be:	85ca                	mv	a1,s2
    800006c0:	8556                	mv	a0,s5
    800006c2:	00000097          	auipc	ra,0x0
    800006c6:	eda080e7          	jalr	-294(ra) # 8000059c <walk>
    800006ca:	cd1d                	beqz	a0,80000708 <mappages+0x84>
    if(*pte & PTE_V)
    800006cc:	611c                	ld	a5,0(a0)
    800006ce:	8b85                	andi	a5,a5,1
    800006d0:	e785                	bnez	a5,800006f8 <mappages+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800006d2:	80b1                	srli	s1,s1,0xc
    800006d4:	04aa                	slli	s1,s1,0xa
    800006d6:	0164e4b3          	or	s1,s1,s6
    800006da:	0014e493          	ori	s1,s1,1
    800006de:	e104                	sd	s1,0(a0)
    if(a == last)
    800006e0:	05390063          	beq	s2,s3,80000720 <mappages+0x9c>
    a += PGSIZE;
    800006e4:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800006e6:	bfc9                	j	800006b8 <mappages+0x34>
    panic("mappages: size");
    800006e8:	00008517          	auipc	a0,0x8
    800006ec:	9a050513          	addi	a0,a0,-1632 # 80008088 <etext+0x88>
    800006f0:	00005097          	auipc	ra,0x5
    800006f4:	610080e7          	jalr	1552(ra) # 80005d00 <panic>
      panic("mappages: remap");
    800006f8:	00008517          	auipc	a0,0x8
    800006fc:	9a050513          	addi	a0,a0,-1632 # 80008098 <etext+0x98>
    80000700:	00005097          	auipc	ra,0x5
    80000704:	600080e7          	jalr	1536(ra) # 80005d00 <panic>
      return -1;
    80000708:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    8000070a:	60a6                	ld	ra,72(sp)
    8000070c:	6406                	ld	s0,64(sp)
    8000070e:	74e2                	ld	s1,56(sp)
    80000710:	7942                	ld	s2,48(sp)
    80000712:	79a2                	ld	s3,40(sp)
    80000714:	7a02                	ld	s4,32(sp)
    80000716:	6ae2                	ld	s5,24(sp)
    80000718:	6b42                	ld	s6,16(sp)
    8000071a:	6ba2                	ld	s7,8(sp)
    8000071c:	6161                	addi	sp,sp,80
    8000071e:	8082                	ret
  return 0;
    80000720:	4501                	li	a0,0
    80000722:	b7e5                	j	8000070a <mappages+0x86>

0000000080000724 <kvmmap>:
{
    80000724:	1141                	addi	sp,sp,-16
    80000726:	e406                	sd	ra,8(sp)
    80000728:	e022                	sd	s0,0(sp)
    8000072a:	0800                	addi	s0,sp,16
    8000072c:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000072e:	86b2                	mv	a3,a2
    80000730:	863e                	mv	a2,a5
    80000732:	00000097          	auipc	ra,0x0
    80000736:	f52080e7          	jalr	-174(ra) # 80000684 <mappages>
    8000073a:	e509                	bnez	a0,80000744 <kvmmap+0x20>
}
    8000073c:	60a2                	ld	ra,8(sp)
    8000073e:	6402                	ld	s0,0(sp)
    80000740:	0141                	addi	sp,sp,16
    80000742:	8082                	ret
    panic("kvmmap");
    80000744:	00008517          	auipc	a0,0x8
    80000748:	96450513          	addi	a0,a0,-1692 # 800080a8 <etext+0xa8>
    8000074c:	00005097          	auipc	ra,0x5
    80000750:	5b4080e7          	jalr	1460(ra) # 80005d00 <panic>

0000000080000754 <kvmmake>:
{
    80000754:	1101                	addi	sp,sp,-32
    80000756:	ec06                	sd	ra,24(sp)
    80000758:	e822                	sd	s0,16(sp)
    8000075a:	e426                	sd	s1,8(sp)
    8000075c:	e04a                	sd	s2,0(sp)
    8000075e:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000760:	00000097          	auipc	ra,0x0
    80000764:	abe080e7          	jalr	-1346(ra) # 8000021e <kalloc>
    80000768:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000076a:	6605                	lui	a2,0x1
    8000076c:	4581                	li	a1,0
    8000076e:	00000097          	auipc	ra,0x0
    80000772:	b4e080e7          	jalr	-1202(ra) # 800002bc <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000776:	4719                	li	a4,6
    80000778:	6685                	lui	a3,0x1
    8000077a:	10000637          	lui	a2,0x10000
    8000077e:	100005b7          	lui	a1,0x10000
    80000782:	8526                	mv	a0,s1
    80000784:	00000097          	auipc	ra,0x0
    80000788:	fa0080e7          	jalr	-96(ra) # 80000724 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000078c:	4719                	li	a4,6
    8000078e:	6685                	lui	a3,0x1
    80000790:	10001637          	lui	a2,0x10001
    80000794:	100015b7          	lui	a1,0x10001
    80000798:	8526                	mv	a0,s1
    8000079a:	00000097          	auipc	ra,0x0
    8000079e:	f8a080e7          	jalr	-118(ra) # 80000724 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800007a2:	4719                	li	a4,6
    800007a4:	004006b7          	lui	a3,0x400
    800007a8:	0c000637          	lui	a2,0xc000
    800007ac:	0c0005b7          	lui	a1,0xc000
    800007b0:	8526                	mv	a0,s1
    800007b2:	00000097          	auipc	ra,0x0
    800007b6:	f72080e7          	jalr	-142(ra) # 80000724 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800007ba:	00008917          	auipc	s2,0x8
    800007be:	84690913          	addi	s2,s2,-1978 # 80008000 <etext>
    800007c2:	4729                	li	a4,10
    800007c4:	80008697          	auipc	a3,0x80008
    800007c8:	83c68693          	addi	a3,a3,-1988 # 8000 <_entry-0x7fff8000>
    800007cc:	4605                	li	a2,1
    800007ce:	067e                	slli	a2,a2,0x1f
    800007d0:	85b2                	mv	a1,a2
    800007d2:	8526                	mv	a0,s1
    800007d4:	00000097          	auipc	ra,0x0
    800007d8:	f50080e7          	jalr	-176(ra) # 80000724 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800007dc:	4719                	li	a4,6
    800007de:	46c5                	li	a3,17
    800007e0:	06ee                	slli	a3,a3,0x1b
    800007e2:	412686b3          	sub	a3,a3,s2
    800007e6:	864a                	mv	a2,s2
    800007e8:	85ca                	mv	a1,s2
    800007ea:	8526                	mv	a0,s1
    800007ec:	00000097          	auipc	ra,0x0
    800007f0:	f38080e7          	jalr	-200(ra) # 80000724 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800007f4:	4729                	li	a4,10
    800007f6:	6685                	lui	a3,0x1
    800007f8:	00007617          	auipc	a2,0x7
    800007fc:	80860613          	addi	a2,a2,-2040 # 80007000 <_trampoline>
    80000800:	040005b7          	lui	a1,0x4000
    80000804:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000806:	05b2                	slli	a1,a1,0xc
    80000808:	8526                	mv	a0,s1
    8000080a:	00000097          	auipc	ra,0x0
    8000080e:	f1a080e7          	jalr	-230(ra) # 80000724 <kvmmap>
  proc_mapstacks(kpgtbl);
    80000812:	8526                	mv	a0,s1
    80000814:	00000097          	auipc	ra,0x0
    80000818:	6ba080e7          	jalr	1722(ra) # 80000ece <proc_mapstacks>
}
    8000081c:	8526                	mv	a0,s1
    8000081e:	60e2                	ld	ra,24(sp)
    80000820:	6442                	ld	s0,16(sp)
    80000822:	64a2                	ld	s1,8(sp)
    80000824:	6902                	ld	s2,0(sp)
    80000826:	6105                	addi	sp,sp,32
    80000828:	8082                	ret

000000008000082a <kvminit>:
{
    8000082a:	1141                	addi	sp,sp,-16
    8000082c:	e406                	sd	ra,8(sp)
    8000082e:	e022                	sd	s0,0(sp)
    80000830:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000832:	00000097          	auipc	ra,0x0
    80000836:	f22080e7          	jalr	-222(ra) # 80000754 <kvmmake>
    8000083a:	00008797          	auipc	a5,0x8
    8000083e:	7ca7b723          	sd	a0,1998(a5) # 80009008 <kernel_pagetable>
}
    80000842:	60a2                	ld	ra,8(sp)
    80000844:	6402                	ld	s0,0(sp)
    80000846:	0141                	addi	sp,sp,16
    80000848:	8082                	ret

000000008000084a <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000084a:	715d                	addi	sp,sp,-80
    8000084c:	e486                	sd	ra,72(sp)
    8000084e:	e0a2                	sd	s0,64(sp)
    80000850:	fc26                	sd	s1,56(sp)
    80000852:	f84a                	sd	s2,48(sp)
    80000854:	f44e                	sd	s3,40(sp)
    80000856:	f052                	sd	s4,32(sp)
    80000858:	ec56                	sd	s5,24(sp)
    8000085a:	e85a                	sd	s6,16(sp)
    8000085c:	e45e                	sd	s7,8(sp)
    8000085e:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000860:	03459793          	slli	a5,a1,0x34
    80000864:	e795                	bnez	a5,80000890 <uvmunmap+0x46>
    80000866:	8a2a                	mv	s4,a0
    80000868:	892e                	mv	s2,a1
    8000086a:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000086c:	0632                	slli	a2,a2,0xc
    8000086e:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80000872:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000874:	6b05                	lui	s6,0x1
    80000876:	0735e263          	bltu	a1,s3,800008da <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    8000087a:	60a6                	ld	ra,72(sp)
    8000087c:	6406                	ld	s0,64(sp)
    8000087e:	74e2                	ld	s1,56(sp)
    80000880:	7942                	ld	s2,48(sp)
    80000882:	79a2                	ld	s3,40(sp)
    80000884:	7a02                	ld	s4,32(sp)
    80000886:	6ae2                	ld	s5,24(sp)
    80000888:	6b42                	ld	s6,16(sp)
    8000088a:	6ba2                	ld	s7,8(sp)
    8000088c:	6161                	addi	sp,sp,80
    8000088e:	8082                	ret
    panic("uvmunmap: not aligned");
    80000890:	00008517          	auipc	a0,0x8
    80000894:	82050513          	addi	a0,a0,-2016 # 800080b0 <etext+0xb0>
    80000898:	00005097          	auipc	ra,0x5
    8000089c:	468080e7          	jalr	1128(ra) # 80005d00 <panic>
      panic("uvmunmap: walk");
    800008a0:	00008517          	auipc	a0,0x8
    800008a4:	82850513          	addi	a0,a0,-2008 # 800080c8 <etext+0xc8>
    800008a8:	00005097          	auipc	ra,0x5
    800008ac:	458080e7          	jalr	1112(ra) # 80005d00 <panic>
      panic("uvmunmap: not mapped");
    800008b0:	00008517          	auipc	a0,0x8
    800008b4:	82850513          	addi	a0,a0,-2008 # 800080d8 <etext+0xd8>
    800008b8:	00005097          	auipc	ra,0x5
    800008bc:	448080e7          	jalr	1096(ra) # 80005d00 <panic>
      panic("uvmunmap: not a leaf");
    800008c0:	00008517          	auipc	a0,0x8
    800008c4:	83050513          	addi	a0,a0,-2000 # 800080f0 <etext+0xf0>
    800008c8:	00005097          	auipc	ra,0x5
    800008cc:	438080e7          	jalr	1080(ra) # 80005d00 <panic>
    *pte = 0;
    800008d0:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800008d4:	995a                	add	s2,s2,s6
    800008d6:	fb3972e3          	bgeu	s2,s3,8000087a <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    800008da:	4601                	li	a2,0
    800008dc:	85ca                	mv	a1,s2
    800008de:	8552                	mv	a0,s4
    800008e0:	00000097          	auipc	ra,0x0
    800008e4:	cbc080e7          	jalr	-836(ra) # 8000059c <walk>
    800008e8:	84aa                	mv	s1,a0
    800008ea:	d95d                	beqz	a0,800008a0 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    800008ec:	6108                	ld	a0,0(a0)
    800008ee:	00157793          	andi	a5,a0,1
    800008f2:	dfdd                	beqz	a5,800008b0 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    800008f4:	3ff57793          	andi	a5,a0,1023
    800008f8:	fd7784e3          	beq	a5,s7,800008c0 <uvmunmap+0x76>
    if(do_free){
    800008fc:	fc0a8ae3          	beqz	s5,800008d0 <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    80000900:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80000902:	0532                	slli	a0,a0,0xc
    80000904:	fffff097          	auipc	ra,0xfffff
    80000908:	794080e7          	jalr	1940(ra) # 80000098 <kfree>
    8000090c:	b7d1                	j	800008d0 <uvmunmap+0x86>

000000008000090e <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    8000090e:	1101                	addi	sp,sp,-32
    80000910:	ec06                	sd	ra,24(sp)
    80000912:	e822                	sd	s0,16(sp)
    80000914:	e426                	sd	s1,8(sp)
    80000916:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000918:	00000097          	auipc	ra,0x0
    8000091c:	906080e7          	jalr	-1786(ra) # 8000021e <kalloc>
    80000920:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000922:	c519                	beqz	a0,80000930 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80000924:	6605                	lui	a2,0x1
    80000926:	4581                	li	a1,0
    80000928:	00000097          	auipc	ra,0x0
    8000092c:	994080e7          	jalr	-1644(ra) # 800002bc <memset>
  return pagetable;
}
    80000930:	8526                	mv	a0,s1
    80000932:	60e2                	ld	ra,24(sp)
    80000934:	6442                	ld	s0,16(sp)
    80000936:	64a2                	ld	s1,8(sp)
    80000938:	6105                	addi	sp,sp,32
    8000093a:	8082                	ret

000000008000093c <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    8000093c:	7179                	addi	sp,sp,-48
    8000093e:	f406                	sd	ra,40(sp)
    80000940:	f022                	sd	s0,32(sp)
    80000942:	ec26                	sd	s1,24(sp)
    80000944:	e84a                	sd	s2,16(sp)
    80000946:	e44e                	sd	s3,8(sp)
    80000948:	e052                	sd	s4,0(sp)
    8000094a:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    8000094c:	6785                	lui	a5,0x1
    8000094e:	04f67863          	bgeu	a2,a5,8000099e <uvminit+0x62>
    80000952:	8a2a                	mv	s4,a0
    80000954:	89ae                	mv	s3,a1
    80000956:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    80000958:	00000097          	auipc	ra,0x0
    8000095c:	8c6080e7          	jalr	-1850(ra) # 8000021e <kalloc>
    80000960:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000962:	6605                	lui	a2,0x1
    80000964:	4581                	li	a1,0
    80000966:	00000097          	auipc	ra,0x0
    8000096a:	956080e7          	jalr	-1706(ra) # 800002bc <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000096e:	4779                	li	a4,30
    80000970:	86ca                	mv	a3,s2
    80000972:	6605                	lui	a2,0x1
    80000974:	4581                	li	a1,0
    80000976:	8552                	mv	a0,s4
    80000978:	00000097          	auipc	ra,0x0
    8000097c:	d0c080e7          	jalr	-756(ra) # 80000684 <mappages>
  memmove(mem, src, sz);
    80000980:	8626                	mv	a2,s1
    80000982:	85ce                	mv	a1,s3
    80000984:	854a                	mv	a0,s2
    80000986:	00000097          	auipc	ra,0x0
    8000098a:	992080e7          	jalr	-1646(ra) # 80000318 <memmove>
}
    8000098e:	70a2                	ld	ra,40(sp)
    80000990:	7402                	ld	s0,32(sp)
    80000992:	64e2                	ld	s1,24(sp)
    80000994:	6942                	ld	s2,16(sp)
    80000996:	69a2                	ld	s3,8(sp)
    80000998:	6a02                	ld	s4,0(sp)
    8000099a:	6145                	addi	sp,sp,48
    8000099c:	8082                	ret
    panic("inituvm: more than a page");
    8000099e:	00007517          	auipc	a0,0x7
    800009a2:	76a50513          	addi	a0,a0,1898 # 80008108 <etext+0x108>
    800009a6:	00005097          	auipc	ra,0x5
    800009aa:	35a080e7          	jalr	858(ra) # 80005d00 <panic>

00000000800009ae <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800009ae:	1101                	addi	sp,sp,-32
    800009b0:	ec06                	sd	ra,24(sp)
    800009b2:	e822                	sd	s0,16(sp)
    800009b4:	e426                	sd	s1,8(sp)
    800009b6:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800009b8:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800009ba:	00b67d63          	bgeu	a2,a1,800009d4 <uvmdealloc+0x26>
    800009be:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800009c0:	6785                	lui	a5,0x1
    800009c2:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800009c4:	00f60733          	add	a4,a2,a5
    800009c8:	76fd                	lui	a3,0xfffff
    800009ca:	8f75                	and	a4,a4,a3
    800009cc:	97ae                	add	a5,a5,a1
    800009ce:	8ff5                	and	a5,a5,a3
    800009d0:	00f76863          	bltu	a4,a5,800009e0 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800009d4:	8526                	mv	a0,s1
    800009d6:	60e2                	ld	ra,24(sp)
    800009d8:	6442                	ld	s0,16(sp)
    800009da:	64a2                	ld	s1,8(sp)
    800009dc:	6105                	addi	sp,sp,32
    800009de:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800009e0:	8f99                	sub	a5,a5,a4
    800009e2:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800009e4:	4685                	li	a3,1
    800009e6:	0007861b          	sext.w	a2,a5
    800009ea:	85ba                	mv	a1,a4
    800009ec:	00000097          	auipc	ra,0x0
    800009f0:	e5e080e7          	jalr	-418(ra) # 8000084a <uvmunmap>
    800009f4:	b7c5                	j	800009d4 <uvmdealloc+0x26>

00000000800009f6 <uvmalloc>:
  if(newsz < oldsz)
    800009f6:	0ab66163          	bltu	a2,a1,80000a98 <uvmalloc+0xa2>
{
    800009fa:	7139                	addi	sp,sp,-64
    800009fc:	fc06                	sd	ra,56(sp)
    800009fe:	f822                	sd	s0,48(sp)
    80000a00:	f426                	sd	s1,40(sp)
    80000a02:	f04a                	sd	s2,32(sp)
    80000a04:	ec4e                	sd	s3,24(sp)
    80000a06:	e852                	sd	s4,16(sp)
    80000a08:	e456                	sd	s5,8(sp)
    80000a0a:	0080                	addi	s0,sp,64
    80000a0c:	8aaa                	mv	s5,a0
    80000a0e:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    80000a10:	6785                	lui	a5,0x1
    80000a12:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000a14:	95be                	add	a1,a1,a5
    80000a16:	77fd                	lui	a5,0xfffff
    80000a18:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000a1c:	08c9f063          	bgeu	s3,a2,80000a9c <uvmalloc+0xa6>
    80000a20:	894e                	mv	s2,s3
    mem = kalloc();
    80000a22:	fffff097          	auipc	ra,0xfffff
    80000a26:	7fc080e7          	jalr	2044(ra) # 8000021e <kalloc>
    80000a2a:	84aa                	mv	s1,a0
    if(mem == 0){
    80000a2c:	c51d                	beqz	a0,80000a5a <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    80000a2e:	6605                	lui	a2,0x1
    80000a30:	4581                	li	a1,0
    80000a32:	00000097          	auipc	ra,0x0
    80000a36:	88a080e7          	jalr	-1910(ra) # 800002bc <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80000a3a:	4779                	li	a4,30
    80000a3c:	86a6                	mv	a3,s1
    80000a3e:	6605                	lui	a2,0x1
    80000a40:	85ca                	mv	a1,s2
    80000a42:	8556                	mv	a0,s5
    80000a44:	00000097          	auipc	ra,0x0
    80000a48:	c40080e7          	jalr	-960(ra) # 80000684 <mappages>
    80000a4c:	e905                	bnez	a0,80000a7c <uvmalloc+0x86>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000a4e:	6785                	lui	a5,0x1
    80000a50:	993e                	add	s2,s2,a5
    80000a52:	fd4968e3          	bltu	s2,s4,80000a22 <uvmalloc+0x2c>
  return newsz;
    80000a56:	8552                	mv	a0,s4
    80000a58:	a809                	j	80000a6a <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    80000a5a:	864e                	mv	a2,s3
    80000a5c:	85ca                	mv	a1,s2
    80000a5e:	8556                	mv	a0,s5
    80000a60:	00000097          	auipc	ra,0x0
    80000a64:	f4e080e7          	jalr	-178(ra) # 800009ae <uvmdealloc>
      return 0;
    80000a68:	4501                	li	a0,0
}
    80000a6a:	70e2                	ld	ra,56(sp)
    80000a6c:	7442                	ld	s0,48(sp)
    80000a6e:	74a2                	ld	s1,40(sp)
    80000a70:	7902                	ld	s2,32(sp)
    80000a72:	69e2                	ld	s3,24(sp)
    80000a74:	6a42                	ld	s4,16(sp)
    80000a76:	6aa2                	ld	s5,8(sp)
    80000a78:	6121                	addi	sp,sp,64
    80000a7a:	8082                	ret
      kfree(mem);
    80000a7c:	8526                	mv	a0,s1
    80000a7e:	fffff097          	auipc	ra,0xfffff
    80000a82:	61a080e7          	jalr	1562(ra) # 80000098 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000a86:	864e                	mv	a2,s3
    80000a88:	85ca                	mv	a1,s2
    80000a8a:	8556                	mv	a0,s5
    80000a8c:	00000097          	auipc	ra,0x0
    80000a90:	f22080e7          	jalr	-222(ra) # 800009ae <uvmdealloc>
      return 0;
    80000a94:	4501                	li	a0,0
    80000a96:	bfd1                	j	80000a6a <uvmalloc+0x74>
    return oldsz;
    80000a98:	852e                	mv	a0,a1
}
    80000a9a:	8082                	ret
  return newsz;
    80000a9c:	8532                	mv	a0,a2
    80000a9e:	b7f1                	j	80000a6a <uvmalloc+0x74>

0000000080000aa0 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80000aa0:	7179                	addi	sp,sp,-48
    80000aa2:	f406                	sd	ra,40(sp)
    80000aa4:	f022                	sd	s0,32(sp)
    80000aa6:	ec26                	sd	s1,24(sp)
    80000aa8:	e84a                	sd	s2,16(sp)
    80000aaa:	e44e                	sd	s3,8(sp)
    80000aac:	e052                	sd	s4,0(sp)
    80000aae:	1800                	addi	s0,sp,48
    80000ab0:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000ab2:	84aa                	mv	s1,a0
    80000ab4:	6905                	lui	s2,0x1
    80000ab6:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000ab8:	4985                	li	s3,1
    80000aba:	a829                	j	80000ad4 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80000abc:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    80000abe:	00c79513          	slli	a0,a5,0xc
    80000ac2:	00000097          	auipc	ra,0x0
    80000ac6:	fde080e7          	jalr	-34(ra) # 80000aa0 <freewalk>
      pagetable[i] = 0;
    80000aca:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    80000ace:	04a1                	addi	s1,s1,8
    80000ad0:	03248163          	beq	s1,s2,80000af2 <freewalk+0x52>
    pte_t pte = pagetable[i];
    80000ad4:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000ad6:	00f7f713          	andi	a4,a5,15
    80000ada:	ff3701e3          	beq	a4,s3,80000abc <freewalk+0x1c>
    } else if(pte & PTE_V){
    80000ade:	8b85                	andi	a5,a5,1
    80000ae0:	d7fd                	beqz	a5,80000ace <freewalk+0x2e>
      panic("freewalk: leaf");
    80000ae2:	00007517          	auipc	a0,0x7
    80000ae6:	64650513          	addi	a0,a0,1606 # 80008128 <etext+0x128>
    80000aea:	00005097          	auipc	ra,0x5
    80000aee:	216080e7          	jalr	534(ra) # 80005d00 <panic>
    }
  }
  kfree((void*)pagetable);
    80000af2:	8552                	mv	a0,s4
    80000af4:	fffff097          	auipc	ra,0xfffff
    80000af8:	5a4080e7          	jalr	1444(ra) # 80000098 <kfree>
}
    80000afc:	70a2                	ld	ra,40(sp)
    80000afe:	7402                	ld	s0,32(sp)
    80000b00:	64e2                	ld	s1,24(sp)
    80000b02:	6942                	ld	s2,16(sp)
    80000b04:	69a2                	ld	s3,8(sp)
    80000b06:	6a02                	ld	s4,0(sp)
    80000b08:	6145                	addi	sp,sp,48
    80000b0a:	8082                	ret

0000000080000b0c <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000b0c:	1101                	addi	sp,sp,-32
    80000b0e:	ec06                	sd	ra,24(sp)
    80000b10:	e822                	sd	s0,16(sp)
    80000b12:	e426                	sd	s1,8(sp)
    80000b14:	1000                	addi	s0,sp,32
    80000b16:	84aa                	mv	s1,a0
  if(sz > 0)
    80000b18:	e999                	bnez	a1,80000b2e <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000b1a:	8526                	mv	a0,s1
    80000b1c:	00000097          	auipc	ra,0x0
    80000b20:	f84080e7          	jalr	-124(ra) # 80000aa0 <freewalk>
}
    80000b24:	60e2                	ld	ra,24(sp)
    80000b26:	6442                	ld	s0,16(sp)
    80000b28:	64a2                	ld	s1,8(sp)
    80000b2a:	6105                	addi	sp,sp,32
    80000b2c:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000b2e:	6785                	lui	a5,0x1
    80000b30:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000b32:	95be                	add	a1,a1,a5
    80000b34:	4685                	li	a3,1
    80000b36:	00c5d613          	srli	a2,a1,0xc
    80000b3a:	4581                	li	a1,0
    80000b3c:	00000097          	auipc	ra,0x0
    80000b40:	d0e080e7          	jalr	-754(ra) # 8000084a <uvmunmap>
    80000b44:	bfd9                	j	80000b1a <uvmfree+0xe>

0000000080000b46 <uvmcowalloc>:
// return -1 failed
int
uvmcowalloc(pagetable_t pagetable, uint64 va)
{
    //if(!uvmcowcheck(pagetable, va))
    if(va > MAXVA)
    80000b46:	4785                	li	a5,1
    80000b48:	179a                	slli	a5,a5,0x26
    80000b4a:	06b7e863          	bltu	a5,a1,80000bba <uvmcowalloc+0x74>
{
    80000b4e:	7179                	addi	sp,sp,-48
    80000b50:	f406                	sd	ra,40(sp)
    80000b52:	f022                	sd	s0,32(sp)
    80000b54:	ec26                	sd	s1,24(sp)
    80000b56:	e84a                	sd	s2,16(sp)
    80000b58:	e44e                	sd	s3,8(sp)
    80000b5a:	1800                	addi	s0,sp,48
        return -1;
    // 利用walk获取pte间接避免非法va
    pte_t* pte = walk(pagetable, va, 0);
    80000b5c:	4601                	li	a2,0
    80000b5e:	00000097          	auipc	ra,0x0
    80000b62:	a3e080e7          	jalr	-1474(ra) # 8000059c <walk>
    80000b66:	89aa                	mv	s3,a0
    if(pte == 0)
    80000b68:	c939                	beqz	a0,80000bbe <uvmcowalloc+0x78>
        return -1;
    if((*pte & PTE_U) == 0 || (*pte & PTE_V) == 0)
    80000b6a:	610c                	ld	a1,0(a0)
    80000b6c:	0115f713          	andi	a4,a1,17
    80000b70:	47c5                	li	a5,17
    80000b72:	04f71863          	bne	a4,a5,80000bc2 <uvmcowalloc+0x7c>
        return -1;

    uint64 old_pa = PTE2PA(*pte);
    80000b76:	81a9                	srli	a1,a1,0xa
    80000b78:	00c59913          	slli	s2,a1,0xc
    uint64 new_pa = (uint64)kalloc();
    80000b7c:	fffff097          	auipc	ra,0xfffff
    80000b80:	6a2080e7          	jalr	1698(ra) # 8000021e <kalloc>
    80000b84:	84aa                	mv	s1,a0
    if(new_pa == 0)
    80000b86:	c121                	beqz	a0,80000bc6 <uvmcowalloc+0x80>
        return -1;

    memmove((void*)new_pa, (void*)old_pa, PGSIZE);
    80000b88:	6605                	lui	a2,0x1
    80000b8a:	85ca                	mv	a1,s2
    80000b8c:	fffff097          	auipc	ra,0xfffff
    80000b90:	78c080e7          	jalr	1932(ra) # 80000318 <memmove>
    //*pte = (*pte & ~(PTE_C)) | PTE_W;
    *pte = PA2PTE(new_pa) | PTE_V | PTE_U | PTE_R | PTE_W | PTE_X;
    80000b94:	80b1                	srli	s1,s1,0xc
    80000b96:	04aa                	slli	s1,s1,0xa
    80000b98:	01f4e493          	ori	s1,s1,31
    80000b9c:	0099b023          	sd	s1,0(s3) # 2000 <_entry-0x7fffe000>
    kfree((void*)old_pa);
    80000ba0:	854a                	mv	a0,s2
    80000ba2:	fffff097          	auipc	ra,0xfffff
    80000ba6:	4f6080e7          	jalr	1270(ra) # 80000098 <kfree>
        if(mappages(pagetable, va, PGSIZE, (uint64)new_pa, PTE_FLAGS(new_pte)) == -1)
            panic("uvmcowalloc: mappages");
        return 0;
    }
    */
    return 0;
    80000baa:	4501                	li	a0,0
}
    80000bac:	70a2                	ld	ra,40(sp)
    80000bae:	7402                	ld	s0,32(sp)
    80000bb0:	64e2                	ld	s1,24(sp)
    80000bb2:	6942                	ld	s2,16(sp)
    80000bb4:	69a2                	ld	s3,8(sp)
    80000bb6:	6145                	addi	sp,sp,48
    80000bb8:	8082                	ret
        return -1;
    80000bba:	557d                	li	a0,-1
}
    80000bbc:	8082                	ret
        return -1;
    80000bbe:	557d                	li	a0,-1
    80000bc0:	b7f5                	j	80000bac <uvmcowalloc+0x66>
        return -1;
    80000bc2:	557d                	li	a0,-1
    80000bc4:	b7e5                	j	80000bac <uvmcowalloc+0x66>
        return -1;
    80000bc6:	557d                	li	a0,-1
    80000bc8:	b7d5                	j	80000bac <uvmcowalloc+0x66>

0000000080000bca <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  // char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000bca:	ca55                	beqz	a2,80000c7e <uvmcopy+0xb4>
{
    80000bcc:	7139                	addi	sp,sp,-64
    80000bce:	fc06                	sd	ra,56(sp)
    80000bd0:	f822                	sd	s0,48(sp)
    80000bd2:	f426                	sd	s1,40(sp)
    80000bd4:	f04a                	sd	s2,32(sp)
    80000bd6:	ec4e                	sd	s3,24(sp)
    80000bd8:	e852                	sd	s4,16(sp)
    80000bda:	e456                	sd	s5,8(sp)
    80000bdc:	e05a                	sd	s6,0(sp)
    80000bde:	0080                	addi	s0,sp,64
    80000be0:	8b2a                	mv	s6,a0
    80000be2:	8aae                	mv	s5,a1
    80000be4:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000be6:	4901                	li	s2,0
    if((pte = walk(old, i, 0)) == 0)
    80000be8:	4601                	li	a2,0
    80000bea:	85ca                	mv	a1,s2
    80000bec:	855a                	mv	a0,s6
    80000bee:	00000097          	auipc	ra,0x0
    80000bf2:	9ae080e7          	jalr	-1618(ra) # 8000059c <walk>
    80000bf6:	c121                	beqz	a0,80000c36 <uvmcopy+0x6c>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000bf8:	6118                	ld	a4,0(a0)
    80000bfa:	00177793          	andi	a5,a4,1
    80000bfe:	c7a1                	beqz	a5,80000c46 <uvmcopy+0x7c>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000c00:	00a75993          	srli	s3,a4,0xa
    80000c04:	09b2                	slli	s3,s3,0xc
    // lab cow add
    // clear PTE_W
    *pte &= ~PTE_W;
    80000c06:	ffb77493          	andi	s1,a4,-5
    80000c0a:	e104                	sd	s1,0(a0)
    flags = PTE_FLAGS(*pte);

    refadd(pa);
    80000c0c:	854e                	mv	a0,s3
    80000c0e:	fffff097          	auipc	ra,0xfffff
    80000c12:	40e080e7          	jalr	1038(ra) # 8000001c <refadd>
    // map child's pte to father's pa
    if(mappages(new, i, PGSIZE, (uint64)pa, flags) != 0)
    80000c16:	3fb4f713          	andi	a4,s1,1019
    80000c1a:	86ce                	mv	a3,s3
    80000c1c:	6605                	lui	a2,0x1
    80000c1e:	85ca                	mv	a1,s2
    80000c20:	8556                	mv	a0,s5
    80000c22:	00000097          	auipc	ra,0x0
    80000c26:	a62080e7          	jalr	-1438(ra) # 80000684 <mappages>
    80000c2a:	e515                	bnez	a0,80000c56 <uvmcopy+0x8c>
  for(i = 0; i < sz; i += PGSIZE){
    80000c2c:	6785                	lui	a5,0x1
    80000c2e:	993e                	add	s2,s2,a5
    80000c30:	fb496ce3          	bltu	s2,s4,80000be8 <uvmcopy+0x1e>
    80000c34:	a81d                	j	80000c6a <uvmcopy+0xa0>
      panic("uvmcopy: pte should exist");
    80000c36:	00007517          	auipc	a0,0x7
    80000c3a:	50250513          	addi	a0,a0,1282 # 80008138 <etext+0x138>
    80000c3e:	00005097          	auipc	ra,0x5
    80000c42:	0c2080e7          	jalr	194(ra) # 80005d00 <panic>
      panic("uvmcopy: page not present");
    80000c46:	00007517          	auipc	a0,0x7
    80000c4a:	51250513          	addi	a0,a0,1298 # 80008158 <etext+0x158>
    80000c4e:	00005097          	auipc	ra,0x5
    80000c52:	0b2080e7          	jalr	178(ra) # 80005d00 <panic>

  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000c56:	4685                	li	a3,1
    80000c58:	00c95613          	srli	a2,s2,0xc
    80000c5c:	4581                	li	a1,0
    80000c5e:	8556                	mv	a0,s5
    80000c60:	00000097          	auipc	ra,0x0
    80000c64:	bea080e7          	jalr	-1046(ra) # 8000084a <uvmunmap>
  return -1;
    80000c68:	557d                	li	a0,-1
}
    80000c6a:	70e2                	ld	ra,56(sp)
    80000c6c:	7442                	ld	s0,48(sp)
    80000c6e:	74a2                	ld	s1,40(sp)
    80000c70:	7902                	ld	s2,32(sp)
    80000c72:	69e2                	ld	s3,24(sp)
    80000c74:	6a42                	ld	s4,16(sp)
    80000c76:	6aa2                	ld	s5,8(sp)
    80000c78:	6b02                	ld	s6,0(sp)
    80000c7a:	6121                	addi	sp,sp,64
    80000c7c:	8082                	ret
  return 0;
    80000c7e:	4501                	li	a0,0
}
    80000c80:	8082                	ret

0000000080000c82 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000c82:	1141                	addi	sp,sp,-16
    80000c84:	e406                	sd	ra,8(sp)
    80000c86:	e022                	sd	s0,0(sp)
    80000c88:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000c8a:	4601                	li	a2,0
    80000c8c:	00000097          	auipc	ra,0x0
    80000c90:	910080e7          	jalr	-1776(ra) # 8000059c <walk>
  if(pte == 0)
    80000c94:	c901                	beqz	a0,80000ca4 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000c96:	611c                	ld	a5,0(a0)
    80000c98:	9bbd                	andi	a5,a5,-17
    80000c9a:	e11c                	sd	a5,0(a0)
}
    80000c9c:	60a2                	ld	ra,8(sp)
    80000c9e:	6402                	ld	s0,0(sp)
    80000ca0:	0141                	addi	sp,sp,16
    80000ca2:	8082                	ret
    panic("uvmclear");
    80000ca4:	00007517          	auipc	a0,0x7
    80000ca8:	4d450513          	addi	a0,a0,1236 # 80008178 <etext+0x178>
    80000cac:	00005097          	auipc	ra,0x5
    80000cb0:	054080e7          	jalr	84(ra) # 80005d00 <panic>

0000000080000cb4 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000cb4:	c6d5                	beqz	a3,80000d60 <copyout+0xac>
{
    80000cb6:	711d                	addi	sp,sp,-96
    80000cb8:	ec86                	sd	ra,88(sp)
    80000cba:	e8a2                	sd	s0,80(sp)
    80000cbc:	e4a6                	sd	s1,72(sp)
    80000cbe:	e0ca                	sd	s2,64(sp)
    80000cc0:	fc4e                	sd	s3,56(sp)
    80000cc2:	f852                	sd	s4,48(sp)
    80000cc4:	f456                	sd	s5,40(sp)
    80000cc6:	f05a                	sd	s6,32(sp)
    80000cc8:	ec5e                	sd	s7,24(sp)
    80000cca:	e862                	sd	s8,16(sp)
    80000ccc:	e466                	sd	s9,8(sp)
    80000cce:	1080                	addi	s0,sp,96
    80000cd0:	8b2a                	mv	s6,a0
    80000cd2:	8a2e                	mv	s4,a1
    80000cd4:	8ab2                	mv	s5,a2
    80000cd6:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000cd8:	74fd                	lui	s1,0xfffff
    80000cda:	8ced                	and	s1,s1,a1
    
    if(va0 >= MAXVA)
    80000cdc:	57fd                	li	a5,-1
    80000cde:	83e9                	srli	a5,a5,0x1a
    80000ce0:	0897e263          	bltu	a5,s1,80000d64 <copyout+0xb0>
    80000ce4:	6c05                	lui	s8,0x1
    80000ce6:	8bbe                	mv	s7,a5
    80000ce8:	a835                	j	80000d24 <copyout+0x70>
    // lab cow add
    pte_t* pte = walk(pagetable, va0, 0);
    if(pte == 0 || (*pte & PTE_V) || (*pte & PTE_U))
        return -1;
    if((*pte & PTE_W) == 0) {
        if(uvmcowalloc(pagetable, va0) < 0)
    80000cea:	85a6                	mv	a1,s1
    80000cec:	855a                	mv	a0,s6
    80000cee:	00000097          	auipc	ra,0x0
    80000cf2:	e58080e7          	jalr	-424(ra) # 80000b46 <uvmcowalloc>
    80000cf6:	04055663          	bgez	a0,80000d42 <copyout+0x8e>
            return -1;
    80000cfa:	557d                	li	a0,-1
    80000cfc:	a88d                	j	80000d6e <copyout+0xba>
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000cfe:	409a0533          	sub	a0,s4,s1
    80000d02:	0009061b          	sext.w	a2,s2
    80000d06:	85d6                	mv	a1,s5
    80000d08:	953e                	add	a0,a0,a5
    80000d0a:	fffff097          	auipc	ra,0xfffff
    80000d0e:	60e080e7          	jalr	1550(ra) # 80000318 <memmove>

    len -= n;
    80000d12:	412989b3          	sub	s3,s3,s2
    src += n;
    80000d16:	9aca                	add	s5,s5,s2
  while(len > 0){
    80000d18:	04098263          	beqz	s3,80000d5c <copyout+0xa8>
    if(va0 >= MAXVA)
    80000d1c:	059be663          	bltu	s7,s9,80000d68 <copyout+0xb4>
    va0 = PGROUNDDOWN(dstva);
    80000d20:	84e6                	mv	s1,s9
    dstva = va0 + PGSIZE;
    80000d22:	8a66                	mv	s4,s9
    pte_t* pte = walk(pagetable, va0, 0);
    80000d24:	4601                	li	a2,0
    80000d26:	85a6                	mv	a1,s1
    80000d28:	855a                	mv	a0,s6
    80000d2a:	00000097          	auipc	ra,0x0
    80000d2e:	872080e7          	jalr	-1934(ra) # 8000059c <walk>
    80000d32:	892a                	mv	s2,a0
    if(pte == 0 || (*pte & PTE_V) || (*pte & PTE_U))
    80000d34:	cd05                	beqz	a0,80000d6c <copyout+0xb8>
    80000d36:	611c                	ld	a5,0(a0)
    80000d38:	0117f713          	andi	a4,a5,17
    80000d3c:	e731                	bnez	a4,80000d88 <copyout+0xd4>
    if((*pte & PTE_W) == 0) {
    80000d3e:	8b91                	andi	a5,a5,4
    80000d40:	d7cd                	beqz	a5,80000cea <copyout+0x36>
    pa0 = PTE2PA(*pte);
    80000d42:	00093783          	ld	a5,0(s2) # 1000 <_entry-0x7ffff000>
    80000d46:	83a9                	srli	a5,a5,0xa
    80000d48:	07b2                	slli	a5,a5,0xc
    if(pa0 == 0)
    80000d4a:	c3a9                	beqz	a5,80000d8c <copyout+0xd8>
    n = PGSIZE - (dstva - va0);
    80000d4c:	01848cb3          	add	s9,s1,s8
    80000d50:	414c8933          	sub	s2,s9,s4
    80000d54:	fb29f5e3          	bgeu	s3,s2,80000cfe <copyout+0x4a>
    80000d58:	894e                	mv	s2,s3
    80000d5a:	b755                	j	80000cfe <copyout+0x4a>
  }
  return 0;
    80000d5c:	4501                	li	a0,0
    80000d5e:	a801                	j	80000d6e <copyout+0xba>
    80000d60:	4501                	li	a0,0
}
    80000d62:	8082                	ret
        return -1;
    80000d64:	557d                	li	a0,-1
    80000d66:	a021                	j	80000d6e <copyout+0xba>
    80000d68:	557d                	li	a0,-1
    80000d6a:	a011                	j	80000d6e <copyout+0xba>
        return -1;
    80000d6c:	557d                	li	a0,-1
}
    80000d6e:	60e6                	ld	ra,88(sp)
    80000d70:	6446                	ld	s0,80(sp)
    80000d72:	64a6                	ld	s1,72(sp)
    80000d74:	6906                	ld	s2,64(sp)
    80000d76:	79e2                	ld	s3,56(sp)
    80000d78:	7a42                	ld	s4,48(sp)
    80000d7a:	7aa2                	ld	s5,40(sp)
    80000d7c:	7b02                	ld	s6,32(sp)
    80000d7e:	6be2                	ld	s7,24(sp)
    80000d80:	6c42                	ld	s8,16(sp)
    80000d82:	6ca2                	ld	s9,8(sp)
    80000d84:	6125                	addi	sp,sp,96
    80000d86:	8082                	ret
        return -1;
    80000d88:	557d                	li	a0,-1
    80000d8a:	b7d5                	j	80000d6e <copyout+0xba>
      return -1;
    80000d8c:	557d                	li	a0,-1
    80000d8e:	b7c5                	j	80000d6e <copyout+0xba>

0000000080000d90 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000d90:	caa5                	beqz	a3,80000e00 <copyin+0x70>
{
    80000d92:	715d                	addi	sp,sp,-80
    80000d94:	e486                	sd	ra,72(sp)
    80000d96:	e0a2                	sd	s0,64(sp)
    80000d98:	fc26                	sd	s1,56(sp)
    80000d9a:	f84a                	sd	s2,48(sp)
    80000d9c:	f44e                	sd	s3,40(sp)
    80000d9e:	f052                	sd	s4,32(sp)
    80000da0:	ec56                	sd	s5,24(sp)
    80000da2:	e85a                	sd	s6,16(sp)
    80000da4:	e45e                	sd	s7,8(sp)
    80000da6:	e062                	sd	s8,0(sp)
    80000da8:	0880                	addi	s0,sp,80
    80000daa:	8b2a                	mv	s6,a0
    80000dac:	8a2e                	mv	s4,a1
    80000dae:	8c32                	mv	s8,a2
    80000db0:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000db2:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000db4:	6a85                	lui	s5,0x1
    80000db6:	a01d                	j	80000ddc <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000db8:	018505b3          	add	a1,a0,s8
    80000dbc:	0004861b          	sext.w	a2,s1
    80000dc0:	412585b3          	sub	a1,a1,s2
    80000dc4:	8552                	mv	a0,s4
    80000dc6:	fffff097          	auipc	ra,0xfffff
    80000dca:	552080e7          	jalr	1362(ra) # 80000318 <memmove>

    len -= n;
    80000dce:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000dd2:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000dd4:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000dd8:	02098263          	beqz	s3,80000dfc <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000ddc:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000de0:	85ca                	mv	a1,s2
    80000de2:	855a                	mv	a0,s6
    80000de4:	00000097          	auipc	ra,0x0
    80000de8:	85e080e7          	jalr	-1954(ra) # 80000642 <walkaddr>
    if(pa0 == 0)
    80000dec:	cd01                	beqz	a0,80000e04 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000dee:	418904b3          	sub	s1,s2,s8
    80000df2:	94d6                	add	s1,s1,s5
    80000df4:	fc99f2e3          	bgeu	s3,s1,80000db8 <copyin+0x28>
    80000df8:	84ce                	mv	s1,s3
    80000dfa:	bf7d                	j	80000db8 <copyin+0x28>
  }
  return 0;
    80000dfc:	4501                	li	a0,0
    80000dfe:	a021                	j	80000e06 <copyin+0x76>
    80000e00:	4501                	li	a0,0
}
    80000e02:	8082                	ret
      return -1;
    80000e04:	557d                	li	a0,-1
}
    80000e06:	60a6                	ld	ra,72(sp)
    80000e08:	6406                	ld	s0,64(sp)
    80000e0a:	74e2                	ld	s1,56(sp)
    80000e0c:	7942                	ld	s2,48(sp)
    80000e0e:	79a2                	ld	s3,40(sp)
    80000e10:	7a02                	ld	s4,32(sp)
    80000e12:	6ae2                	ld	s5,24(sp)
    80000e14:	6b42                	ld	s6,16(sp)
    80000e16:	6ba2                	ld	s7,8(sp)
    80000e18:	6c02                	ld	s8,0(sp)
    80000e1a:	6161                	addi	sp,sp,80
    80000e1c:	8082                	ret

0000000080000e1e <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000e1e:	c2dd                	beqz	a3,80000ec4 <copyinstr+0xa6>
{
    80000e20:	715d                	addi	sp,sp,-80
    80000e22:	e486                	sd	ra,72(sp)
    80000e24:	e0a2                	sd	s0,64(sp)
    80000e26:	fc26                	sd	s1,56(sp)
    80000e28:	f84a                	sd	s2,48(sp)
    80000e2a:	f44e                	sd	s3,40(sp)
    80000e2c:	f052                	sd	s4,32(sp)
    80000e2e:	ec56                	sd	s5,24(sp)
    80000e30:	e85a                	sd	s6,16(sp)
    80000e32:	e45e                	sd	s7,8(sp)
    80000e34:	0880                	addi	s0,sp,80
    80000e36:	8a2a                	mv	s4,a0
    80000e38:	8b2e                	mv	s6,a1
    80000e3a:	8bb2                	mv	s7,a2
    80000e3c:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000e3e:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000e40:	6985                	lui	s3,0x1
    80000e42:	a02d                	j	80000e6c <copyinstr+0x4e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000e44:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000e48:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000e4a:	37fd                	addiw	a5,a5,-1
    80000e4c:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000e50:	60a6                	ld	ra,72(sp)
    80000e52:	6406                	ld	s0,64(sp)
    80000e54:	74e2                	ld	s1,56(sp)
    80000e56:	7942                	ld	s2,48(sp)
    80000e58:	79a2                	ld	s3,40(sp)
    80000e5a:	7a02                	ld	s4,32(sp)
    80000e5c:	6ae2                	ld	s5,24(sp)
    80000e5e:	6b42                	ld	s6,16(sp)
    80000e60:	6ba2                	ld	s7,8(sp)
    80000e62:	6161                	addi	sp,sp,80
    80000e64:	8082                	ret
    srcva = va0 + PGSIZE;
    80000e66:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000e6a:	c8a9                	beqz	s1,80000ebc <copyinstr+0x9e>
    va0 = PGROUNDDOWN(srcva);
    80000e6c:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000e70:	85ca                	mv	a1,s2
    80000e72:	8552                	mv	a0,s4
    80000e74:	fffff097          	auipc	ra,0xfffff
    80000e78:	7ce080e7          	jalr	1998(ra) # 80000642 <walkaddr>
    if(pa0 == 0)
    80000e7c:	c131                	beqz	a0,80000ec0 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    80000e7e:	417906b3          	sub	a3,s2,s7
    80000e82:	96ce                	add	a3,a3,s3
    80000e84:	00d4f363          	bgeu	s1,a3,80000e8a <copyinstr+0x6c>
    80000e88:	86a6                	mv	a3,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000e8a:	955e                	add	a0,a0,s7
    80000e8c:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000e90:	daf9                	beqz	a3,80000e66 <copyinstr+0x48>
    80000e92:	87da                	mv	a5,s6
      if(*p == '\0'){
    80000e94:	41650633          	sub	a2,a0,s6
    80000e98:	fff48593          	addi	a1,s1,-1 # ffffffffffffefff <end+0xffffffff7fdb8dbf>
    80000e9c:	95da                	add	a1,a1,s6
    while(n > 0){
    80000e9e:	96da                	add	a3,a3,s6
      if(*p == '\0'){
    80000ea0:	00f60733          	add	a4,a2,a5
    80000ea4:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7fdb8dc0>
    80000ea8:	df51                	beqz	a4,80000e44 <copyinstr+0x26>
        *dst = *p;
    80000eaa:	00e78023          	sb	a4,0(a5)
      --max;
    80000eae:	40f584b3          	sub	s1,a1,a5
      dst++;
    80000eb2:	0785                	addi	a5,a5,1
    while(n > 0){
    80000eb4:	fed796e3          	bne	a5,a3,80000ea0 <copyinstr+0x82>
      dst++;
    80000eb8:	8b3e                	mv	s6,a5
    80000eba:	b775                	j	80000e66 <copyinstr+0x48>
    80000ebc:	4781                	li	a5,0
    80000ebe:	b771                	j	80000e4a <copyinstr+0x2c>
      return -1;
    80000ec0:	557d                	li	a0,-1
    80000ec2:	b779                	j	80000e50 <copyinstr+0x32>
  int got_null = 0;
    80000ec4:	4781                	li	a5,0
  if(got_null){
    80000ec6:	37fd                	addiw	a5,a5,-1
    80000ec8:	0007851b          	sext.w	a0,a5
}
    80000ecc:	8082                	ret

0000000080000ece <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80000ece:	7139                	addi	sp,sp,-64
    80000ed0:	fc06                	sd	ra,56(sp)
    80000ed2:	f822                	sd	s0,48(sp)
    80000ed4:	f426                	sd	s1,40(sp)
    80000ed6:	f04a                	sd	s2,32(sp)
    80000ed8:	ec4e                	sd	s3,24(sp)
    80000eda:	e852                	sd	s4,16(sp)
    80000edc:	e456                	sd	s5,8(sp)
    80000ede:	e05a                	sd	s6,0(sp)
    80000ee0:	0080                	addi	s0,sp,64
    80000ee2:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ee4:	00228497          	auipc	s1,0x228
    80000ee8:	59c48493          	addi	s1,s1,1436 # 80229480 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000eec:	8b26                	mv	s6,s1
    80000eee:	00007a97          	auipc	s5,0x7
    80000ef2:	112a8a93          	addi	s5,s5,274 # 80008000 <etext>
    80000ef6:	04000937          	lui	s2,0x4000
    80000efa:	197d                	addi	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80000efc:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000efe:	0022ea17          	auipc	s4,0x22e
    80000f02:	f82a0a13          	addi	s4,s4,-126 # 8022ee80 <tickslock>
    char *pa = kalloc();
    80000f06:	fffff097          	auipc	ra,0xfffff
    80000f0a:	318080e7          	jalr	792(ra) # 8000021e <kalloc>
    80000f0e:	862a                	mv	a2,a0
    if(pa == 0)
    80000f10:	c131                	beqz	a0,80000f54 <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80000f12:	416485b3          	sub	a1,s1,s6
    80000f16:	858d                	srai	a1,a1,0x3
    80000f18:	000ab783          	ld	a5,0(s5)
    80000f1c:	02f585b3          	mul	a1,a1,a5
    80000f20:	2585                	addiw	a1,a1,1
    80000f22:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000f26:	4719                	li	a4,6
    80000f28:	6685                	lui	a3,0x1
    80000f2a:	40b905b3          	sub	a1,s2,a1
    80000f2e:	854e                	mv	a0,s3
    80000f30:	fffff097          	auipc	ra,0xfffff
    80000f34:	7f4080e7          	jalr	2036(ra) # 80000724 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f38:	16848493          	addi	s1,s1,360
    80000f3c:	fd4495e3          	bne	s1,s4,80000f06 <proc_mapstacks+0x38>
  }
}
    80000f40:	70e2                	ld	ra,56(sp)
    80000f42:	7442                	ld	s0,48(sp)
    80000f44:	74a2                	ld	s1,40(sp)
    80000f46:	7902                	ld	s2,32(sp)
    80000f48:	69e2                	ld	s3,24(sp)
    80000f4a:	6a42                	ld	s4,16(sp)
    80000f4c:	6aa2                	ld	s5,8(sp)
    80000f4e:	6b02                	ld	s6,0(sp)
    80000f50:	6121                	addi	sp,sp,64
    80000f52:	8082                	ret
      panic("kalloc");
    80000f54:	00007517          	auipc	a0,0x7
    80000f58:	23450513          	addi	a0,a0,564 # 80008188 <etext+0x188>
    80000f5c:	00005097          	auipc	ra,0x5
    80000f60:	da4080e7          	jalr	-604(ra) # 80005d00 <panic>

0000000080000f64 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    80000f64:	7139                	addi	sp,sp,-64
    80000f66:	fc06                	sd	ra,56(sp)
    80000f68:	f822                	sd	s0,48(sp)
    80000f6a:	f426                	sd	s1,40(sp)
    80000f6c:	f04a                	sd	s2,32(sp)
    80000f6e:	ec4e                	sd	s3,24(sp)
    80000f70:	e852                	sd	s4,16(sp)
    80000f72:	e456                	sd	s5,8(sp)
    80000f74:	e05a                	sd	s6,0(sp)
    80000f76:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000f78:	00007597          	auipc	a1,0x7
    80000f7c:	21858593          	addi	a1,a1,536 # 80008190 <etext+0x190>
    80000f80:	00228517          	auipc	a0,0x228
    80000f84:	0d050513          	addi	a0,a0,208 # 80229050 <pid_lock>
    80000f88:	00005097          	auipc	ra,0x5
    80000f8c:	220080e7          	jalr	544(ra) # 800061a8 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000f90:	00007597          	auipc	a1,0x7
    80000f94:	20858593          	addi	a1,a1,520 # 80008198 <etext+0x198>
    80000f98:	00228517          	auipc	a0,0x228
    80000f9c:	0d050513          	addi	a0,a0,208 # 80229068 <wait_lock>
    80000fa0:	00005097          	auipc	ra,0x5
    80000fa4:	208080e7          	jalr	520(ra) # 800061a8 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fa8:	00228497          	auipc	s1,0x228
    80000fac:	4d848493          	addi	s1,s1,1240 # 80229480 <proc>
      initlock(&p->lock, "proc");
    80000fb0:	00007b17          	auipc	s6,0x7
    80000fb4:	1f8b0b13          	addi	s6,s6,504 # 800081a8 <etext+0x1a8>
      p->kstack = KSTACK((int) (p - proc));
    80000fb8:	8aa6                	mv	s5,s1
    80000fba:	00007a17          	auipc	s4,0x7
    80000fbe:	046a0a13          	addi	s4,s4,70 # 80008000 <etext>
    80000fc2:	04000937          	lui	s2,0x4000
    80000fc6:	197d                	addi	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80000fc8:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fca:	0022e997          	auipc	s3,0x22e
    80000fce:	eb698993          	addi	s3,s3,-330 # 8022ee80 <tickslock>
      initlock(&p->lock, "proc");
    80000fd2:	85da                	mv	a1,s6
    80000fd4:	8526                	mv	a0,s1
    80000fd6:	00005097          	auipc	ra,0x5
    80000fda:	1d2080e7          	jalr	466(ra) # 800061a8 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80000fde:	415487b3          	sub	a5,s1,s5
    80000fe2:	878d                	srai	a5,a5,0x3
    80000fe4:	000a3703          	ld	a4,0(s4)
    80000fe8:	02e787b3          	mul	a5,a5,a4
    80000fec:	2785                	addiw	a5,a5,1
    80000fee:	00d7979b          	slliw	a5,a5,0xd
    80000ff2:	40f907b3          	sub	a5,s2,a5
    80000ff6:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ff8:	16848493          	addi	s1,s1,360
    80000ffc:	fd349be3          	bne	s1,s3,80000fd2 <procinit+0x6e>
  }
}
    80001000:	70e2                	ld	ra,56(sp)
    80001002:	7442                	ld	s0,48(sp)
    80001004:	74a2                	ld	s1,40(sp)
    80001006:	7902                	ld	s2,32(sp)
    80001008:	69e2                	ld	s3,24(sp)
    8000100a:	6a42                	ld	s4,16(sp)
    8000100c:	6aa2                	ld	s5,8(sp)
    8000100e:	6b02                	ld	s6,0(sp)
    80001010:	6121                	addi	sp,sp,64
    80001012:	8082                	ret

0000000080001014 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80001014:	1141                	addi	sp,sp,-16
    80001016:	e422                	sd	s0,8(sp)
    80001018:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    8000101a:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    8000101c:	2501                	sext.w	a0,a0
    8000101e:	6422                	ld	s0,8(sp)
    80001020:	0141                	addi	sp,sp,16
    80001022:	8082                	ret

0000000080001024 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80001024:	1141                	addi	sp,sp,-16
    80001026:	e422                	sd	s0,8(sp)
    80001028:	0800                	addi	s0,sp,16
    8000102a:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    8000102c:	2781                	sext.w	a5,a5
    8000102e:	079e                	slli	a5,a5,0x7
  return c;
}
    80001030:	00228517          	auipc	a0,0x228
    80001034:	05050513          	addi	a0,a0,80 # 80229080 <cpus>
    80001038:	953e                	add	a0,a0,a5
    8000103a:	6422                	ld	s0,8(sp)
    8000103c:	0141                	addi	sp,sp,16
    8000103e:	8082                	ret

0000000080001040 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80001040:	1101                	addi	sp,sp,-32
    80001042:	ec06                	sd	ra,24(sp)
    80001044:	e822                	sd	s0,16(sp)
    80001046:	e426                	sd	s1,8(sp)
    80001048:	1000                	addi	s0,sp,32
  push_off();
    8000104a:	00005097          	auipc	ra,0x5
    8000104e:	1a2080e7          	jalr	418(ra) # 800061ec <push_off>
    80001052:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80001054:	2781                	sext.w	a5,a5
    80001056:	079e                	slli	a5,a5,0x7
    80001058:	00228717          	auipc	a4,0x228
    8000105c:	ff870713          	addi	a4,a4,-8 # 80229050 <pid_lock>
    80001060:	97ba                	add	a5,a5,a4
    80001062:	7b84                	ld	s1,48(a5)
  pop_off();
    80001064:	00005097          	auipc	ra,0x5
    80001068:	228080e7          	jalr	552(ra) # 8000628c <pop_off>
  return p;
}
    8000106c:	8526                	mv	a0,s1
    8000106e:	60e2                	ld	ra,24(sp)
    80001070:	6442                	ld	s0,16(sp)
    80001072:	64a2                	ld	s1,8(sp)
    80001074:	6105                	addi	sp,sp,32
    80001076:	8082                	ret

0000000080001078 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001078:	1141                	addi	sp,sp,-16
    8000107a:	e406                	sd	ra,8(sp)
    8000107c:	e022                	sd	s0,0(sp)
    8000107e:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80001080:	00000097          	auipc	ra,0x0
    80001084:	fc0080e7          	jalr	-64(ra) # 80001040 <myproc>
    80001088:	00005097          	auipc	ra,0x5
    8000108c:	264080e7          	jalr	612(ra) # 800062ec <release>

  if (first) {
    80001090:	00007797          	auipc	a5,0x7
    80001094:	7b07a783          	lw	a5,1968(a5) # 80008840 <first.1>
    80001098:	eb89                	bnez	a5,800010aa <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    8000109a:	00001097          	auipc	ra,0x1
    8000109e:	c14080e7          	jalr	-1004(ra) # 80001cae <usertrapret>
}
    800010a2:	60a2                	ld	ra,8(sp)
    800010a4:	6402                	ld	s0,0(sp)
    800010a6:	0141                	addi	sp,sp,16
    800010a8:	8082                	ret
    first = 0;
    800010aa:	00007797          	auipc	a5,0x7
    800010ae:	7807ab23          	sw	zero,1942(a5) # 80008840 <first.1>
    fsinit(ROOTDEV);
    800010b2:	4505                	li	a0,1
    800010b4:	00002097          	auipc	ra,0x2
    800010b8:	958080e7          	jalr	-1704(ra) # 80002a0c <fsinit>
    800010bc:	bff9                	j	8000109a <forkret+0x22>

00000000800010be <allocpid>:
allocpid() {
    800010be:	1101                	addi	sp,sp,-32
    800010c0:	ec06                	sd	ra,24(sp)
    800010c2:	e822                	sd	s0,16(sp)
    800010c4:	e426                	sd	s1,8(sp)
    800010c6:	e04a                	sd	s2,0(sp)
    800010c8:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    800010ca:	00228917          	auipc	s2,0x228
    800010ce:	f8690913          	addi	s2,s2,-122 # 80229050 <pid_lock>
    800010d2:	854a                	mv	a0,s2
    800010d4:	00005097          	auipc	ra,0x5
    800010d8:	164080e7          	jalr	356(ra) # 80006238 <acquire>
  pid = nextpid;
    800010dc:	00007797          	auipc	a5,0x7
    800010e0:	76878793          	addi	a5,a5,1896 # 80008844 <nextpid>
    800010e4:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    800010e6:	0014871b          	addiw	a4,s1,1
    800010ea:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    800010ec:	854a                	mv	a0,s2
    800010ee:	00005097          	auipc	ra,0x5
    800010f2:	1fe080e7          	jalr	510(ra) # 800062ec <release>
}
    800010f6:	8526                	mv	a0,s1
    800010f8:	60e2                	ld	ra,24(sp)
    800010fa:	6442                	ld	s0,16(sp)
    800010fc:	64a2                	ld	s1,8(sp)
    800010fe:	6902                	ld	s2,0(sp)
    80001100:	6105                	addi	sp,sp,32
    80001102:	8082                	ret

0000000080001104 <proc_pagetable>:
{
    80001104:	1101                	addi	sp,sp,-32
    80001106:	ec06                	sd	ra,24(sp)
    80001108:	e822                	sd	s0,16(sp)
    8000110a:	e426                	sd	s1,8(sp)
    8000110c:	e04a                	sd	s2,0(sp)
    8000110e:	1000                	addi	s0,sp,32
    80001110:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001112:	fffff097          	auipc	ra,0xfffff
    80001116:	7fc080e7          	jalr	2044(ra) # 8000090e <uvmcreate>
    8000111a:	84aa                	mv	s1,a0
  if(pagetable == 0)
    8000111c:	c121                	beqz	a0,8000115c <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    8000111e:	4729                	li	a4,10
    80001120:	00006697          	auipc	a3,0x6
    80001124:	ee068693          	addi	a3,a3,-288 # 80007000 <_trampoline>
    80001128:	6605                	lui	a2,0x1
    8000112a:	040005b7          	lui	a1,0x4000
    8000112e:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001130:	05b2                	slli	a1,a1,0xc
    80001132:	fffff097          	auipc	ra,0xfffff
    80001136:	552080e7          	jalr	1362(ra) # 80000684 <mappages>
    8000113a:	02054863          	bltz	a0,8000116a <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    8000113e:	4719                	li	a4,6
    80001140:	05893683          	ld	a3,88(s2)
    80001144:	6605                	lui	a2,0x1
    80001146:	020005b7          	lui	a1,0x2000
    8000114a:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    8000114c:	05b6                	slli	a1,a1,0xd
    8000114e:	8526                	mv	a0,s1
    80001150:	fffff097          	auipc	ra,0xfffff
    80001154:	534080e7          	jalr	1332(ra) # 80000684 <mappages>
    80001158:	02054163          	bltz	a0,8000117a <proc_pagetable+0x76>
}
    8000115c:	8526                	mv	a0,s1
    8000115e:	60e2                	ld	ra,24(sp)
    80001160:	6442                	ld	s0,16(sp)
    80001162:	64a2                	ld	s1,8(sp)
    80001164:	6902                	ld	s2,0(sp)
    80001166:	6105                	addi	sp,sp,32
    80001168:	8082                	ret
    uvmfree(pagetable, 0);
    8000116a:	4581                	li	a1,0
    8000116c:	8526                	mv	a0,s1
    8000116e:	00000097          	auipc	ra,0x0
    80001172:	99e080e7          	jalr	-1634(ra) # 80000b0c <uvmfree>
    return 0;
    80001176:	4481                	li	s1,0
    80001178:	b7d5                	j	8000115c <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    8000117a:	4681                	li	a3,0
    8000117c:	4605                	li	a2,1
    8000117e:	040005b7          	lui	a1,0x4000
    80001182:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001184:	05b2                	slli	a1,a1,0xc
    80001186:	8526                	mv	a0,s1
    80001188:	fffff097          	auipc	ra,0xfffff
    8000118c:	6c2080e7          	jalr	1730(ra) # 8000084a <uvmunmap>
    uvmfree(pagetable, 0);
    80001190:	4581                	li	a1,0
    80001192:	8526                	mv	a0,s1
    80001194:	00000097          	auipc	ra,0x0
    80001198:	978080e7          	jalr	-1672(ra) # 80000b0c <uvmfree>
    return 0;
    8000119c:	4481                	li	s1,0
    8000119e:	bf7d                	j	8000115c <proc_pagetable+0x58>

00000000800011a0 <proc_freepagetable>:
{
    800011a0:	1101                	addi	sp,sp,-32
    800011a2:	ec06                	sd	ra,24(sp)
    800011a4:	e822                	sd	s0,16(sp)
    800011a6:	e426                	sd	s1,8(sp)
    800011a8:	e04a                	sd	s2,0(sp)
    800011aa:	1000                	addi	s0,sp,32
    800011ac:	84aa                	mv	s1,a0
    800011ae:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    800011b0:	4681                	li	a3,0
    800011b2:	4605                	li	a2,1
    800011b4:	040005b7          	lui	a1,0x4000
    800011b8:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800011ba:	05b2                	slli	a1,a1,0xc
    800011bc:	fffff097          	auipc	ra,0xfffff
    800011c0:	68e080e7          	jalr	1678(ra) # 8000084a <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    800011c4:	4681                	li	a3,0
    800011c6:	4605                	li	a2,1
    800011c8:	020005b7          	lui	a1,0x2000
    800011cc:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    800011ce:	05b6                	slli	a1,a1,0xd
    800011d0:	8526                	mv	a0,s1
    800011d2:	fffff097          	auipc	ra,0xfffff
    800011d6:	678080e7          	jalr	1656(ra) # 8000084a <uvmunmap>
  uvmfree(pagetable, sz);
    800011da:	85ca                	mv	a1,s2
    800011dc:	8526                	mv	a0,s1
    800011de:	00000097          	auipc	ra,0x0
    800011e2:	92e080e7          	jalr	-1746(ra) # 80000b0c <uvmfree>
}
    800011e6:	60e2                	ld	ra,24(sp)
    800011e8:	6442                	ld	s0,16(sp)
    800011ea:	64a2                	ld	s1,8(sp)
    800011ec:	6902                	ld	s2,0(sp)
    800011ee:	6105                	addi	sp,sp,32
    800011f0:	8082                	ret

00000000800011f2 <freeproc>:
{
    800011f2:	1101                	addi	sp,sp,-32
    800011f4:	ec06                	sd	ra,24(sp)
    800011f6:	e822                	sd	s0,16(sp)
    800011f8:	e426                	sd	s1,8(sp)
    800011fa:	1000                	addi	s0,sp,32
    800011fc:	84aa                	mv	s1,a0
  if(p->trapframe)
    800011fe:	6d28                	ld	a0,88(a0)
    80001200:	c509                	beqz	a0,8000120a <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001202:	fffff097          	auipc	ra,0xfffff
    80001206:	e96080e7          	jalr	-362(ra) # 80000098 <kfree>
  p->trapframe = 0;
    8000120a:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    8000120e:	68a8                	ld	a0,80(s1)
    80001210:	c511                	beqz	a0,8000121c <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001212:	64ac                	ld	a1,72(s1)
    80001214:	00000097          	auipc	ra,0x0
    80001218:	f8c080e7          	jalr	-116(ra) # 800011a0 <proc_freepagetable>
  p->pagetable = 0;
    8000121c:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001220:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001224:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001228:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    8000122c:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001230:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001234:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001238:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    8000123c:	0004ac23          	sw	zero,24(s1)
}
    80001240:	60e2                	ld	ra,24(sp)
    80001242:	6442                	ld	s0,16(sp)
    80001244:	64a2                	ld	s1,8(sp)
    80001246:	6105                	addi	sp,sp,32
    80001248:	8082                	ret

000000008000124a <allocproc>:
{
    8000124a:	1101                	addi	sp,sp,-32
    8000124c:	ec06                	sd	ra,24(sp)
    8000124e:	e822                	sd	s0,16(sp)
    80001250:	e426                	sd	s1,8(sp)
    80001252:	e04a                	sd	s2,0(sp)
    80001254:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001256:	00228497          	auipc	s1,0x228
    8000125a:	22a48493          	addi	s1,s1,554 # 80229480 <proc>
    8000125e:	0022e917          	auipc	s2,0x22e
    80001262:	c2290913          	addi	s2,s2,-990 # 8022ee80 <tickslock>
    acquire(&p->lock);
    80001266:	8526                	mv	a0,s1
    80001268:	00005097          	auipc	ra,0x5
    8000126c:	fd0080e7          	jalr	-48(ra) # 80006238 <acquire>
    if(p->state == UNUSED) {
    80001270:	4c9c                	lw	a5,24(s1)
    80001272:	cf81                	beqz	a5,8000128a <allocproc+0x40>
      release(&p->lock);
    80001274:	8526                	mv	a0,s1
    80001276:	00005097          	auipc	ra,0x5
    8000127a:	076080e7          	jalr	118(ra) # 800062ec <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000127e:	16848493          	addi	s1,s1,360
    80001282:	ff2492e3          	bne	s1,s2,80001266 <allocproc+0x1c>
  return 0;
    80001286:	4481                	li	s1,0
    80001288:	a889                	j	800012da <allocproc+0x90>
  p->pid = allocpid();
    8000128a:	00000097          	auipc	ra,0x0
    8000128e:	e34080e7          	jalr	-460(ra) # 800010be <allocpid>
    80001292:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001294:	4785                	li	a5,1
    80001296:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001298:	fffff097          	auipc	ra,0xfffff
    8000129c:	f86080e7          	jalr	-122(ra) # 8000021e <kalloc>
    800012a0:	892a                	mv	s2,a0
    800012a2:	eca8                	sd	a0,88(s1)
    800012a4:	c131                	beqz	a0,800012e8 <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    800012a6:	8526                	mv	a0,s1
    800012a8:	00000097          	auipc	ra,0x0
    800012ac:	e5c080e7          	jalr	-420(ra) # 80001104 <proc_pagetable>
    800012b0:	892a                	mv	s2,a0
    800012b2:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    800012b4:	c531                	beqz	a0,80001300 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    800012b6:	07000613          	li	a2,112
    800012ba:	4581                	li	a1,0
    800012bc:	06048513          	addi	a0,s1,96
    800012c0:	fffff097          	auipc	ra,0xfffff
    800012c4:	ffc080e7          	jalr	-4(ra) # 800002bc <memset>
  p->context.ra = (uint64)forkret;
    800012c8:	00000797          	auipc	a5,0x0
    800012cc:	db078793          	addi	a5,a5,-592 # 80001078 <forkret>
    800012d0:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    800012d2:	60bc                	ld	a5,64(s1)
    800012d4:	6705                	lui	a4,0x1
    800012d6:	97ba                	add	a5,a5,a4
    800012d8:	f4bc                	sd	a5,104(s1)
}
    800012da:	8526                	mv	a0,s1
    800012dc:	60e2                	ld	ra,24(sp)
    800012de:	6442                	ld	s0,16(sp)
    800012e0:	64a2                	ld	s1,8(sp)
    800012e2:	6902                	ld	s2,0(sp)
    800012e4:	6105                	addi	sp,sp,32
    800012e6:	8082                	ret
    freeproc(p);
    800012e8:	8526                	mv	a0,s1
    800012ea:	00000097          	auipc	ra,0x0
    800012ee:	f08080e7          	jalr	-248(ra) # 800011f2 <freeproc>
    release(&p->lock);
    800012f2:	8526                	mv	a0,s1
    800012f4:	00005097          	auipc	ra,0x5
    800012f8:	ff8080e7          	jalr	-8(ra) # 800062ec <release>
    return 0;
    800012fc:	84ca                	mv	s1,s2
    800012fe:	bff1                	j	800012da <allocproc+0x90>
    freeproc(p);
    80001300:	8526                	mv	a0,s1
    80001302:	00000097          	auipc	ra,0x0
    80001306:	ef0080e7          	jalr	-272(ra) # 800011f2 <freeproc>
    release(&p->lock);
    8000130a:	8526                	mv	a0,s1
    8000130c:	00005097          	auipc	ra,0x5
    80001310:	fe0080e7          	jalr	-32(ra) # 800062ec <release>
    return 0;
    80001314:	84ca                	mv	s1,s2
    80001316:	b7d1                	j	800012da <allocproc+0x90>

0000000080001318 <userinit>:
{
    80001318:	1101                	addi	sp,sp,-32
    8000131a:	ec06                	sd	ra,24(sp)
    8000131c:	e822                	sd	s0,16(sp)
    8000131e:	e426                	sd	s1,8(sp)
    80001320:	1000                	addi	s0,sp,32
  p = allocproc();
    80001322:	00000097          	auipc	ra,0x0
    80001326:	f28080e7          	jalr	-216(ra) # 8000124a <allocproc>
    8000132a:	84aa                	mv	s1,a0
  initproc = p;
    8000132c:	00008797          	auipc	a5,0x8
    80001330:	cea7b223          	sd	a0,-796(a5) # 80009010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001334:	03400613          	li	a2,52
    80001338:	00007597          	auipc	a1,0x7
    8000133c:	51858593          	addi	a1,a1,1304 # 80008850 <initcode>
    80001340:	6928                	ld	a0,80(a0)
    80001342:	fffff097          	auipc	ra,0xfffff
    80001346:	5fa080e7          	jalr	1530(ra) # 8000093c <uvminit>
  p->sz = PGSIZE;
    8000134a:	6785                	lui	a5,0x1
    8000134c:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    8000134e:	6cb8                	ld	a4,88(s1)
    80001350:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001354:	6cb8                	ld	a4,88(s1)
    80001356:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001358:	4641                	li	a2,16
    8000135a:	00007597          	auipc	a1,0x7
    8000135e:	e5658593          	addi	a1,a1,-426 # 800081b0 <etext+0x1b0>
    80001362:	15848513          	addi	a0,s1,344
    80001366:	fffff097          	auipc	ra,0xfffff
    8000136a:	0a0080e7          	jalr	160(ra) # 80000406 <safestrcpy>
  p->cwd = namei("/");
    8000136e:	00007517          	auipc	a0,0x7
    80001372:	e5250513          	addi	a0,a0,-430 # 800081c0 <etext+0x1c0>
    80001376:	00002097          	auipc	ra,0x2
    8000137a:	0cc080e7          	jalr	204(ra) # 80003442 <namei>
    8000137e:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001382:	478d                	li	a5,3
    80001384:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001386:	8526                	mv	a0,s1
    80001388:	00005097          	auipc	ra,0x5
    8000138c:	f64080e7          	jalr	-156(ra) # 800062ec <release>
}
    80001390:	60e2                	ld	ra,24(sp)
    80001392:	6442                	ld	s0,16(sp)
    80001394:	64a2                	ld	s1,8(sp)
    80001396:	6105                	addi	sp,sp,32
    80001398:	8082                	ret

000000008000139a <growproc>:
{
    8000139a:	1101                	addi	sp,sp,-32
    8000139c:	ec06                	sd	ra,24(sp)
    8000139e:	e822                	sd	s0,16(sp)
    800013a0:	e426                	sd	s1,8(sp)
    800013a2:	e04a                	sd	s2,0(sp)
    800013a4:	1000                	addi	s0,sp,32
    800013a6:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800013a8:	00000097          	auipc	ra,0x0
    800013ac:	c98080e7          	jalr	-872(ra) # 80001040 <myproc>
    800013b0:	892a                	mv	s2,a0
  sz = p->sz;
    800013b2:	652c                	ld	a1,72(a0)
    800013b4:	0005879b          	sext.w	a5,a1
  if(n > 0){
    800013b8:	00904f63          	bgtz	s1,800013d6 <growproc+0x3c>
  } else if(n < 0){
    800013bc:	0204cd63          	bltz	s1,800013f6 <growproc+0x5c>
  p->sz = sz;
    800013c0:	1782                	slli	a5,a5,0x20
    800013c2:	9381                	srli	a5,a5,0x20
    800013c4:	04f93423          	sd	a5,72(s2)
  return 0;
    800013c8:	4501                	li	a0,0
}
    800013ca:	60e2                	ld	ra,24(sp)
    800013cc:	6442                	ld	s0,16(sp)
    800013ce:	64a2                	ld	s1,8(sp)
    800013d0:	6902                	ld	s2,0(sp)
    800013d2:	6105                	addi	sp,sp,32
    800013d4:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    800013d6:	00f4863b          	addw	a2,s1,a5
    800013da:	1602                	slli	a2,a2,0x20
    800013dc:	9201                	srli	a2,a2,0x20
    800013de:	1582                	slli	a1,a1,0x20
    800013e0:	9181                	srli	a1,a1,0x20
    800013e2:	6928                	ld	a0,80(a0)
    800013e4:	fffff097          	auipc	ra,0xfffff
    800013e8:	612080e7          	jalr	1554(ra) # 800009f6 <uvmalloc>
    800013ec:	0005079b          	sext.w	a5,a0
    800013f0:	fbe1                	bnez	a5,800013c0 <growproc+0x26>
      return -1;
    800013f2:	557d                	li	a0,-1
    800013f4:	bfd9                	j	800013ca <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800013f6:	00f4863b          	addw	a2,s1,a5
    800013fa:	1602                	slli	a2,a2,0x20
    800013fc:	9201                	srli	a2,a2,0x20
    800013fe:	1582                	slli	a1,a1,0x20
    80001400:	9181                	srli	a1,a1,0x20
    80001402:	6928                	ld	a0,80(a0)
    80001404:	fffff097          	auipc	ra,0xfffff
    80001408:	5aa080e7          	jalr	1450(ra) # 800009ae <uvmdealloc>
    8000140c:	0005079b          	sext.w	a5,a0
    80001410:	bf45                	j	800013c0 <growproc+0x26>

0000000080001412 <fork>:
{
    80001412:	7139                	addi	sp,sp,-64
    80001414:	fc06                	sd	ra,56(sp)
    80001416:	f822                	sd	s0,48(sp)
    80001418:	f426                	sd	s1,40(sp)
    8000141a:	f04a                	sd	s2,32(sp)
    8000141c:	ec4e                	sd	s3,24(sp)
    8000141e:	e852                	sd	s4,16(sp)
    80001420:	e456                	sd	s5,8(sp)
    80001422:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001424:	00000097          	auipc	ra,0x0
    80001428:	c1c080e7          	jalr	-996(ra) # 80001040 <myproc>
    8000142c:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    8000142e:	00000097          	auipc	ra,0x0
    80001432:	e1c080e7          	jalr	-484(ra) # 8000124a <allocproc>
    80001436:	10050c63          	beqz	a0,8000154e <fork+0x13c>
    8000143a:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    8000143c:	048ab603          	ld	a2,72(s5)
    80001440:	692c                	ld	a1,80(a0)
    80001442:	050ab503          	ld	a0,80(s5)
    80001446:	fffff097          	auipc	ra,0xfffff
    8000144a:	784080e7          	jalr	1924(ra) # 80000bca <uvmcopy>
    8000144e:	04054863          	bltz	a0,8000149e <fork+0x8c>
  np->sz = p->sz;
    80001452:	048ab783          	ld	a5,72(s5)
    80001456:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    8000145a:	058ab683          	ld	a3,88(s5)
    8000145e:	87b6                	mv	a5,a3
    80001460:	058a3703          	ld	a4,88(s4)
    80001464:	12068693          	addi	a3,a3,288
    80001468:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    8000146c:	6788                	ld	a0,8(a5)
    8000146e:	6b8c                	ld	a1,16(a5)
    80001470:	6f90                	ld	a2,24(a5)
    80001472:	01073023          	sd	a6,0(a4)
    80001476:	e708                	sd	a0,8(a4)
    80001478:	eb0c                	sd	a1,16(a4)
    8000147a:	ef10                	sd	a2,24(a4)
    8000147c:	02078793          	addi	a5,a5,32
    80001480:	02070713          	addi	a4,a4,32
    80001484:	fed792e3          	bne	a5,a3,80001468 <fork+0x56>
  np->trapframe->a0 = 0;
    80001488:	058a3783          	ld	a5,88(s4)
    8000148c:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001490:	0d0a8493          	addi	s1,s5,208
    80001494:	0d0a0913          	addi	s2,s4,208
    80001498:	150a8993          	addi	s3,s5,336
    8000149c:	a00d                	j	800014be <fork+0xac>
    freeproc(np);
    8000149e:	8552                	mv	a0,s4
    800014a0:	00000097          	auipc	ra,0x0
    800014a4:	d52080e7          	jalr	-686(ra) # 800011f2 <freeproc>
    release(&np->lock);
    800014a8:	8552                	mv	a0,s4
    800014aa:	00005097          	auipc	ra,0x5
    800014ae:	e42080e7          	jalr	-446(ra) # 800062ec <release>
    return -1;
    800014b2:	597d                	li	s2,-1
    800014b4:	a059                	j	8000153a <fork+0x128>
  for(i = 0; i < NOFILE; i++)
    800014b6:	04a1                	addi	s1,s1,8
    800014b8:	0921                	addi	s2,s2,8
    800014ba:	01348b63          	beq	s1,s3,800014d0 <fork+0xbe>
    if(p->ofile[i])
    800014be:	6088                	ld	a0,0(s1)
    800014c0:	d97d                	beqz	a0,800014b6 <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    800014c2:	00002097          	auipc	ra,0x2
    800014c6:	616080e7          	jalr	1558(ra) # 80003ad8 <filedup>
    800014ca:	00a93023          	sd	a0,0(s2)
    800014ce:	b7e5                	j	800014b6 <fork+0xa4>
  np->cwd = idup(p->cwd);
    800014d0:	150ab503          	ld	a0,336(s5)
    800014d4:	00001097          	auipc	ra,0x1
    800014d8:	774080e7          	jalr	1908(ra) # 80002c48 <idup>
    800014dc:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800014e0:	4641                	li	a2,16
    800014e2:	158a8593          	addi	a1,s5,344
    800014e6:	158a0513          	addi	a0,s4,344
    800014ea:	fffff097          	auipc	ra,0xfffff
    800014ee:	f1c080e7          	jalr	-228(ra) # 80000406 <safestrcpy>
  pid = np->pid;
    800014f2:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    800014f6:	8552                	mv	a0,s4
    800014f8:	00005097          	auipc	ra,0x5
    800014fc:	df4080e7          	jalr	-524(ra) # 800062ec <release>
  acquire(&wait_lock);
    80001500:	00228497          	auipc	s1,0x228
    80001504:	b6848493          	addi	s1,s1,-1176 # 80229068 <wait_lock>
    80001508:	8526                	mv	a0,s1
    8000150a:	00005097          	auipc	ra,0x5
    8000150e:	d2e080e7          	jalr	-722(ra) # 80006238 <acquire>
  np->parent = p;
    80001512:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001516:	8526                	mv	a0,s1
    80001518:	00005097          	auipc	ra,0x5
    8000151c:	dd4080e7          	jalr	-556(ra) # 800062ec <release>
  acquire(&np->lock);
    80001520:	8552                	mv	a0,s4
    80001522:	00005097          	auipc	ra,0x5
    80001526:	d16080e7          	jalr	-746(ra) # 80006238 <acquire>
  np->state = RUNNABLE;
    8000152a:	478d                	li	a5,3
    8000152c:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001530:	8552                	mv	a0,s4
    80001532:	00005097          	auipc	ra,0x5
    80001536:	dba080e7          	jalr	-582(ra) # 800062ec <release>
}
    8000153a:	854a                	mv	a0,s2
    8000153c:	70e2                	ld	ra,56(sp)
    8000153e:	7442                	ld	s0,48(sp)
    80001540:	74a2                	ld	s1,40(sp)
    80001542:	7902                	ld	s2,32(sp)
    80001544:	69e2                	ld	s3,24(sp)
    80001546:	6a42                	ld	s4,16(sp)
    80001548:	6aa2                	ld	s5,8(sp)
    8000154a:	6121                	addi	sp,sp,64
    8000154c:	8082                	ret
    return -1;
    8000154e:	597d                	li	s2,-1
    80001550:	b7ed                	j	8000153a <fork+0x128>

0000000080001552 <scheduler>:
{
    80001552:	7139                	addi	sp,sp,-64
    80001554:	fc06                	sd	ra,56(sp)
    80001556:	f822                	sd	s0,48(sp)
    80001558:	f426                	sd	s1,40(sp)
    8000155a:	f04a                	sd	s2,32(sp)
    8000155c:	ec4e                	sd	s3,24(sp)
    8000155e:	e852                	sd	s4,16(sp)
    80001560:	e456                	sd	s5,8(sp)
    80001562:	e05a                	sd	s6,0(sp)
    80001564:	0080                	addi	s0,sp,64
    80001566:	8792                	mv	a5,tp
  int id = r_tp();
    80001568:	2781                	sext.w	a5,a5
  c->proc = 0;
    8000156a:	00779a93          	slli	s5,a5,0x7
    8000156e:	00228717          	auipc	a4,0x228
    80001572:	ae270713          	addi	a4,a4,-1310 # 80229050 <pid_lock>
    80001576:	9756                	add	a4,a4,s5
    80001578:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    8000157c:	00228717          	auipc	a4,0x228
    80001580:	b0c70713          	addi	a4,a4,-1268 # 80229088 <cpus+0x8>
    80001584:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001586:	498d                	li	s3,3
        p->state = RUNNING;
    80001588:	4b11                	li	s6,4
        c->proc = p;
    8000158a:	079e                	slli	a5,a5,0x7
    8000158c:	00228a17          	auipc	s4,0x228
    80001590:	ac4a0a13          	addi	s4,s4,-1340 # 80229050 <pid_lock>
    80001594:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001596:	0022e917          	auipc	s2,0x22e
    8000159a:	8ea90913          	addi	s2,s2,-1814 # 8022ee80 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000159e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800015a2:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800015a6:	10079073          	csrw	sstatus,a5
    800015aa:	00228497          	auipc	s1,0x228
    800015ae:	ed648493          	addi	s1,s1,-298 # 80229480 <proc>
    800015b2:	a811                	j	800015c6 <scheduler+0x74>
      release(&p->lock);
    800015b4:	8526                	mv	a0,s1
    800015b6:	00005097          	auipc	ra,0x5
    800015ba:	d36080e7          	jalr	-714(ra) # 800062ec <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800015be:	16848493          	addi	s1,s1,360
    800015c2:	fd248ee3          	beq	s1,s2,8000159e <scheduler+0x4c>
      acquire(&p->lock);
    800015c6:	8526                	mv	a0,s1
    800015c8:	00005097          	auipc	ra,0x5
    800015cc:	c70080e7          	jalr	-912(ra) # 80006238 <acquire>
      if(p->state == RUNNABLE) {
    800015d0:	4c9c                	lw	a5,24(s1)
    800015d2:	ff3791e3          	bne	a5,s3,800015b4 <scheduler+0x62>
        p->state = RUNNING;
    800015d6:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    800015da:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    800015de:	06048593          	addi	a1,s1,96
    800015e2:	8556                	mv	a0,s5
    800015e4:	00000097          	auipc	ra,0x0
    800015e8:	620080e7          	jalr	1568(ra) # 80001c04 <swtch>
        c->proc = 0;
    800015ec:	020a3823          	sd	zero,48(s4)
    800015f0:	b7d1                	j	800015b4 <scheduler+0x62>

00000000800015f2 <sched>:
{
    800015f2:	7179                	addi	sp,sp,-48
    800015f4:	f406                	sd	ra,40(sp)
    800015f6:	f022                	sd	s0,32(sp)
    800015f8:	ec26                	sd	s1,24(sp)
    800015fa:	e84a                	sd	s2,16(sp)
    800015fc:	e44e                	sd	s3,8(sp)
    800015fe:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001600:	00000097          	auipc	ra,0x0
    80001604:	a40080e7          	jalr	-1472(ra) # 80001040 <myproc>
    80001608:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    8000160a:	00005097          	auipc	ra,0x5
    8000160e:	bb4080e7          	jalr	-1100(ra) # 800061be <holding>
    80001612:	c93d                	beqz	a0,80001688 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001614:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001616:	2781                	sext.w	a5,a5
    80001618:	079e                	slli	a5,a5,0x7
    8000161a:	00228717          	auipc	a4,0x228
    8000161e:	a3670713          	addi	a4,a4,-1482 # 80229050 <pid_lock>
    80001622:	97ba                	add	a5,a5,a4
    80001624:	0a87a703          	lw	a4,168(a5)
    80001628:	4785                	li	a5,1
    8000162a:	06f71763          	bne	a4,a5,80001698 <sched+0xa6>
  if(p->state == RUNNING)
    8000162e:	4c98                	lw	a4,24(s1)
    80001630:	4791                	li	a5,4
    80001632:	06f70b63          	beq	a4,a5,800016a8 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001636:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000163a:	8b89                	andi	a5,a5,2
  if(intr_get())
    8000163c:	efb5                	bnez	a5,800016b8 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000163e:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001640:	00228917          	auipc	s2,0x228
    80001644:	a1090913          	addi	s2,s2,-1520 # 80229050 <pid_lock>
    80001648:	2781                	sext.w	a5,a5
    8000164a:	079e                	slli	a5,a5,0x7
    8000164c:	97ca                	add	a5,a5,s2
    8000164e:	0ac7a983          	lw	s3,172(a5)
    80001652:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001654:	2781                	sext.w	a5,a5
    80001656:	079e                	slli	a5,a5,0x7
    80001658:	00228597          	auipc	a1,0x228
    8000165c:	a3058593          	addi	a1,a1,-1488 # 80229088 <cpus+0x8>
    80001660:	95be                	add	a1,a1,a5
    80001662:	06048513          	addi	a0,s1,96
    80001666:	00000097          	auipc	ra,0x0
    8000166a:	59e080e7          	jalr	1438(ra) # 80001c04 <swtch>
    8000166e:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001670:	2781                	sext.w	a5,a5
    80001672:	079e                	slli	a5,a5,0x7
    80001674:	993e                	add	s2,s2,a5
    80001676:	0b392623          	sw	s3,172(s2)
}
    8000167a:	70a2                	ld	ra,40(sp)
    8000167c:	7402                	ld	s0,32(sp)
    8000167e:	64e2                	ld	s1,24(sp)
    80001680:	6942                	ld	s2,16(sp)
    80001682:	69a2                	ld	s3,8(sp)
    80001684:	6145                	addi	sp,sp,48
    80001686:	8082                	ret
    panic("sched p->lock");
    80001688:	00007517          	auipc	a0,0x7
    8000168c:	b4050513          	addi	a0,a0,-1216 # 800081c8 <etext+0x1c8>
    80001690:	00004097          	auipc	ra,0x4
    80001694:	670080e7          	jalr	1648(ra) # 80005d00 <panic>
    panic("sched locks");
    80001698:	00007517          	auipc	a0,0x7
    8000169c:	b4050513          	addi	a0,a0,-1216 # 800081d8 <etext+0x1d8>
    800016a0:	00004097          	auipc	ra,0x4
    800016a4:	660080e7          	jalr	1632(ra) # 80005d00 <panic>
    panic("sched running");
    800016a8:	00007517          	auipc	a0,0x7
    800016ac:	b4050513          	addi	a0,a0,-1216 # 800081e8 <etext+0x1e8>
    800016b0:	00004097          	auipc	ra,0x4
    800016b4:	650080e7          	jalr	1616(ra) # 80005d00 <panic>
    panic("sched interruptible");
    800016b8:	00007517          	auipc	a0,0x7
    800016bc:	b4050513          	addi	a0,a0,-1216 # 800081f8 <etext+0x1f8>
    800016c0:	00004097          	auipc	ra,0x4
    800016c4:	640080e7          	jalr	1600(ra) # 80005d00 <panic>

00000000800016c8 <yield>:
{
    800016c8:	1101                	addi	sp,sp,-32
    800016ca:	ec06                	sd	ra,24(sp)
    800016cc:	e822                	sd	s0,16(sp)
    800016ce:	e426                	sd	s1,8(sp)
    800016d0:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800016d2:	00000097          	auipc	ra,0x0
    800016d6:	96e080e7          	jalr	-1682(ra) # 80001040 <myproc>
    800016da:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800016dc:	00005097          	auipc	ra,0x5
    800016e0:	b5c080e7          	jalr	-1188(ra) # 80006238 <acquire>
  p->state = RUNNABLE;
    800016e4:	478d                	li	a5,3
    800016e6:	cc9c                	sw	a5,24(s1)
  sched();
    800016e8:	00000097          	auipc	ra,0x0
    800016ec:	f0a080e7          	jalr	-246(ra) # 800015f2 <sched>
  release(&p->lock);
    800016f0:	8526                	mv	a0,s1
    800016f2:	00005097          	auipc	ra,0x5
    800016f6:	bfa080e7          	jalr	-1030(ra) # 800062ec <release>
}
    800016fa:	60e2                	ld	ra,24(sp)
    800016fc:	6442                	ld	s0,16(sp)
    800016fe:	64a2                	ld	s1,8(sp)
    80001700:	6105                	addi	sp,sp,32
    80001702:	8082                	ret

0000000080001704 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001704:	7179                	addi	sp,sp,-48
    80001706:	f406                	sd	ra,40(sp)
    80001708:	f022                	sd	s0,32(sp)
    8000170a:	ec26                	sd	s1,24(sp)
    8000170c:	e84a                	sd	s2,16(sp)
    8000170e:	e44e                	sd	s3,8(sp)
    80001710:	1800                	addi	s0,sp,48
    80001712:	89aa                	mv	s3,a0
    80001714:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001716:	00000097          	auipc	ra,0x0
    8000171a:	92a080e7          	jalr	-1750(ra) # 80001040 <myproc>
    8000171e:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001720:	00005097          	auipc	ra,0x5
    80001724:	b18080e7          	jalr	-1256(ra) # 80006238 <acquire>
  release(lk);
    80001728:	854a                	mv	a0,s2
    8000172a:	00005097          	auipc	ra,0x5
    8000172e:	bc2080e7          	jalr	-1086(ra) # 800062ec <release>

  // Go to sleep.
  p->chan = chan;
    80001732:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80001736:	4789                	li	a5,2
    80001738:	cc9c                	sw	a5,24(s1)

  sched();
    8000173a:	00000097          	auipc	ra,0x0
    8000173e:	eb8080e7          	jalr	-328(ra) # 800015f2 <sched>

  // Tidy up.
  p->chan = 0;
    80001742:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80001746:	8526                	mv	a0,s1
    80001748:	00005097          	auipc	ra,0x5
    8000174c:	ba4080e7          	jalr	-1116(ra) # 800062ec <release>
  acquire(lk);
    80001750:	854a                	mv	a0,s2
    80001752:	00005097          	auipc	ra,0x5
    80001756:	ae6080e7          	jalr	-1306(ra) # 80006238 <acquire>
}
    8000175a:	70a2                	ld	ra,40(sp)
    8000175c:	7402                	ld	s0,32(sp)
    8000175e:	64e2                	ld	s1,24(sp)
    80001760:	6942                	ld	s2,16(sp)
    80001762:	69a2                	ld	s3,8(sp)
    80001764:	6145                	addi	sp,sp,48
    80001766:	8082                	ret

0000000080001768 <wait>:
{
    80001768:	715d                	addi	sp,sp,-80
    8000176a:	e486                	sd	ra,72(sp)
    8000176c:	e0a2                	sd	s0,64(sp)
    8000176e:	fc26                	sd	s1,56(sp)
    80001770:	f84a                	sd	s2,48(sp)
    80001772:	f44e                	sd	s3,40(sp)
    80001774:	f052                	sd	s4,32(sp)
    80001776:	ec56                	sd	s5,24(sp)
    80001778:	e85a                	sd	s6,16(sp)
    8000177a:	e45e                	sd	s7,8(sp)
    8000177c:	e062                	sd	s8,0(sp)
    8000177e:	0880                	addi	s0,sp,80
    80001780:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80001782:	00000097          	auipc	ra,0x0
    80001786:	8be080e7          	jalr	-1858(ra) # 80001040 <myproc>
    8000178a:	892a                	mv	s2,a0
  acquire(&wait_lock);
    8000178c:	00228517          	auipc	a0,0x228
    80001790:	8dc50513          	addi	a0,a0,-1828 # 80229068 <wait_lock>
    80001794:	00005097          	auipc	ra,0x5
    80001798:	aa4080e7          	jalr	-1372(ra) # 80006238 <acquire>
    havekids = 0;
    8000179c:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    8000179e:	4a15                	li	s4,5
        havekids = 1;
    800017a0:	4a85                	li	s5,1
    for(np = proc; np < &proc[NPROC]; np++){
    800017a2:	0022d997          	auipc	s3,0x22d
    800017a6:	6de98993          	addi	s3,s3,1758 # 8022ee80 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800017aa:	00228c17          	auipc	s8,0x228
    800017ae:	8bec0c13          	addi	s8,s8,-1858 # 80229068 <wait_lock>
    havekids = 0;
    800017b2:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    800017b4:	00228497          	auipc	s1,0x228
    800017b8:	ccc48493          	addi	s1,s1,-820 # 80229480 <proc>
    800017bc:	a0bd                	j	8000182a <wait+0xc2>
          pid = np->pid;
    800017be:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800017c2:	000b0e63          	beqz	s6,800017de <wait+0x76>
    800017c6:	4691                	li	a3,4
    800017c8:	02c48613          	addi	a2,s1,44
    800017cc:	85da                	mv	a1,s6
    800017ce:	05093503          	ld	a0,80(s2)
    800017d2:	fffff097          	auipc	ra,0xfffff
    800017d6:	4e2080e7          	jalr	1250(ra) # 80000cb4 <copyout>
    800017da:	02054563          	bltz	a0,80001804 <wait+0x9c>
          freeproc(np);
    800017de:	8526                	mv	a0,s1
    800017e0:	00000097          	auipc	ra,0x0
    800017e4:	a12080e7          	jalr	-1518(ra) # 800011f2 <freeproc>
          release(&np->lock);
    800017e8:	8526                	mv	a0,s1
    800017ea:	00005097          	auipc	ra,0x5
    800017ee:	b02080e7          	jalr	-1278(ra) # 800062ec <release>
          release(&wait_lock);
    800017f2:	00228517          	auipc	a0,0x228
    800017f6:	87650513          	addi	a0,a0,-1930 # 80229068 <wait_lock>
    800017fa:	00005097          	auipc	ra,0x5
    800017fe:	af2080e7          	jalr	-1294(ra) # 800062ec <release>
          return pid;
    80001802:	a09d                	j	80001868 <wait+0x100>
            release(&np->lock);
    80001804:	8526                	mv	a0,s1
    80001806:	00005097          	auipc	ra,0x5
    8000180a:	ae6080e7          	jalr	-1306(ra) # 800062ec <release>
            release(&wait_lock);
    8000180e:	00228517          	auipc	a0,0x228
    80001812:	85a50513          	addi	a0,a0,-1958 # 80229068 <wait_lock>
    80001816:	00005097          	auipc	ra,0x5
    8000181a:	ad6080e7          	jalr	-1322(ra) # 800062ec <release>
            return -1;
    8000181e:	59fd                	li	s3,-1
    80001820:	a0a1                	j	80001868 <wait+0x100>
    for(np = proc; np < &proc[NPROC]; np++){
    80001822:	16848493          	addi	s1,s1,360
    80001826:	03348463          	beq	s1,s3,8000184e <wait+0xe6>
      if(np->parent == p){
    8000182a:	7c9c                	ld	a5,56(s1)
    8000182c:	ff279be3          	bne	a5,s2,80001822 <wait+0xba>
        acquire(&np->lock);
    80001830:	8526                	mv	a0,s1
    80001832:	00005097          	auipc	ra,0x5
    80001836:	a06080e7          	jalr	-1530(ra) # 80006238 <acquire>
        if(np->state == ZOMBIE){
    8000183a:	4c9c                	lw	a5,24(s1)
    8000183c:	f94781e3          	beq	a5,s4,800017be <wait+0x56>
        release(&np->lock);
    80001840:	8526                	mv	a0,s1
    80001842:	00005097          	auipc	ra,0x5
    80001846:	aaa080e7          	jalr	-1366(ra) # 800062ec <release>
        havekids = 1;
    8000184a:	8756                	mv	a4,s5
    8000184c:	bfd9                	j	80001822 <wait+0xba>
    if(!havekids || p->killed){
    8000184e:	c701                	beqz	a4,80001856 <wait+0xee>
    80001850:	02892783          	lw	a5,40(s2)
    80001854:	c79d                	beqz	a5,80001882 <wait+0x11a>
      release(&wait_lock);
    80001856:	00228517          	auipc	a0,0x228
    8000185a:	81250513          	addi	a0,a0,-2030 # 80229068 <wait_lock>
    8000185e:	00005097          	auipc	ra,0x5
    80001862:	a8e080e7          	jalr	-1394(ra) # 800062ec <release>
      return -1;
    80001866:	59fd                	li	s3,-1
}
    80001868:	854e                	mv	a0,s3
    8000186a:	60a6                	ld	ra,72(sp)
    8000186c:	6406                	ld	s0,64(sp)
    8000186e:	74e2                	ld	s1,56(sp)
    80001870:	7942                	ld	s2,48(sp)
    80001872:	79a2                	ld	s3,40(sp)
    80001874:	7a02                	ld	s4,32(sp)
    80001876:	6ae2                	ld	s5,24(sp)
    80001878:	6b42                	ld	s6,16(sp)
    8000187a:	6ba2                	ld	s7,8(sp)
    8000187c:	6c02                	ld	s8,0(sp)
    8000187e:	6161                	addi	sp,sp,80
    80001880:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001882:	85e2                	mv	a1,s8
    80001884:	854a                	mv	a0,s2
    80001886:	00000097          	auipc	ra,0x0
    8000188a:	e7e080e7          	jalr	-386(ra) # 80001704 <sleep>
    havekids = 0;
    8000188e:	b715                	j	800017b2 <wait+0x4a>

0000000080001890 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80001890:	7139                	addi	sp,sp,-64
    80001892:	fc06                	sd	ra,56(sp)
    80001894:	f822                	sd	s0,48(sp)
    80001896:	f426                	sd	s1,40(sp)
    80001898:	f04a                	sd	s2,32(sp)
    8000189a:	ec4e                	sd	s3,24(sp)
    8000189c:	e852                	sd	s4,16(sp)
    8000189e:	e456                	sd	s5,8(sp)
    800018a0:	0080                	addi	s0,sp,64
    800018a2:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800018a4:	00228497          	auipc	s1,0x228
    800018a8:	bdc48493          	addi	s1,s1,-1060 # 80229480 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800018ac:	4989                	li	s3,2
        p->state = RUNNABLE;
    800018ae:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800018b0:	0022d917          	auipc	s2,0x22d
    800018b4:	5d090913          	addi	s2,s2,1488 # 8022ee80 <tickslock>
    800018b8:	a811                	j	800018cc <wakeup+0x3c>
      }
      release(&p->lock);
    800018ba:	8526                	mv	a0,s1
    800018bc:	00005097          	auipc	ra,0x5
    800018c0:	a30080e7          	jalr	-1488(ra) # 800062ec <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800018c4:	16848493          	addi	s1,s1,360
    800018c8:	03248663          	beq	s1,s2,800018f4 <wakeup+0x64>
    if(p != myproc()){
    800018cc:	fffff097          	auipc	ra,0xfffff
    800018d0:	774080e7          	jalr	1908(ra) # 80001040 <myproc>
    800018d4:	fea488e3          	beq	s1,a0,800018c4 <wakeup+0x34>
      acquire(&p->lock);
    800018d8:	8526                	mv	a0,s1
    800018da:	00005097          	auipc	ra,0x5
    800018de:	95e080e7          	jalr	-1698(ra) # 80006238 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800018e2:	4c9c                	lw	a5,24(s1)
    800018e4:	fd379be3          	bne	a5,s3,800018ba <wakeup+0x2a>
    800018e8:	709c                	ld	a5,32(s1)
    800018ea:	fd4798e3          	bne	a5,s4,800018ba <wakeup+0x2a>
        p->state = RUNNABLE;
    800018ee:	0154ac23          	sw	s5,24(s1)
    800018f2:	b7e1                	j	800018ba <wakeup+0x2a>
    }
  }
}
    800018f4:	70e2                	ld	ra,56(sp)
    800018f6:	7442                	ld	s0,48(sp)
    800018f8:	74a2                	ld	s1,40(sp)
    800018fa:	7902                	ld	s2,32(sp)
    800018fc:	69e2                	ld	s3,24(sp)
    800018fe:	6a42                	ld	s4,16(sp)
    80001900:	6aa2                	ld	s5,8(sp)
    80001902:	6121                	addi	sp,sp,64
    80001904:	8082                	ret

0000000080001906 <reparent>:
{
    80001906:	7179                	addi	sp,sp,-48
    80001908:	f406                	sd	ra,40(sp)
    8000190a:	f022                	sd	s0,32(sp)
    8000190c:	ec26                	sd	s1,24(sp)
    8000190e:	e84a                	sd	s2,16(sp)
    80001910:	e44e                	sd	s3,8(sp)
    80001912:	e052                	sd	s4,0(sp)
    80001914:	1800                	addi	s0,sp,48
    80001916:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001918:	00228497          	auipc	s1,0x228
    8000191c:	b6848493          	addi	s1,s1,-1176 # 80229480 <proc>
      pp->parent = initproc;
    80001920:	00007a17          	auipc	s4,0x7
    80001924:	6f0a0a13          	addi	s4,s4,1776 # 80009010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001928:	0022d997          	auipc	s3,0x22d
    8000192c:	55898993          	addi	s3,s3,1368 # 8022ee80 <tickslock>
    80001930:	a029                	j	8000193a <reparent+0x34>
    80001932:	16848493          	addi	s1,s1,360
    80001936:	01348d63          	beq	s1,s3,80001950 <reparent+0x4a>
    if(pp->parent == p){
    8000193a:	7c9c                	ld	a5,56(s1)
    8000193c:	ff279be3          	bne	a5,s2,80001932 <reparent+0x2c>
      pp->parent = initproc;
    80001940:	000a3503          	ld	a0,0(s4)
    80001944:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001946:	00000097          	auipc	ra,0x0
    8000194a:	f4a080e7          	jalr	-182(ra) # 80001890 <wakeup>
    8000194e:	b7d5                	j	80001932 <reparent+0x2c>
}
    80001950:	70a2                	ld	ra,40(sp)
    80001952:	7402                	ld	s0,32(sp)
    80001954:	64e2                	ld	s1,24(sp)
    80001956:	6942                	ld	s2,16(sp)
    80001958:	69a2                	ld	s3,8(sp)
    8000195a:	6a02                	ld	s4,0(sp)
    8000195c:	6145                	addi	sp,sp,48
    8000195e:	8082                	ret

0000000080001960 <exit>:
{
    80001960:	7179                	addi	sp,sp,-48
    80001962:	f406                	sd	ra,40(sp)
    80001964:	f022                	sd	s0,32(sp)
    80001966:	ec26                	sd	s1,24(sp)
    80001968:	e84a                	sd	s2,16(sp)
    8000196a:	e44e                	sd	s3,8(sp)
    8000196c:	e052                	sd	s4,0(sp)
    8000196e:	1800                	addi	s0,sp,48
    80001970:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001972:	fffff097          	auipc	ra,0xfffff
    80001976:	6ce080e7          	jalr	1742(ra) # 80001040 <myproc>
    8000197a:	89aa                	mv	s3,a0
  if(p == initproc)
    8000197c:	00007797          	auipc	a5,0x7
    80001980:	6947b783          	ld	a5,1684(a5) # 80009010 <initproc>
    80001984:	0d050493          	addi	s1,a0,208
    80001988:	15050913          	addi	s2,a0,336
    8000198c:	02a79363          	bne	a5,a0,800019b2 <exit+0x52>
    panic("init exiting");
    80001990:	00007517          	auipc	a0,0x7
    80001994:	88050513          	addi	a0,a0,-1920 # 80008210 <etext+0x210>
    80001998:	00004097          	auipc	ra,0x4
    8000199c:	368080e7          	jalr	872(ra) # 80005d00 <panic>
      fileclose(f);
    800019a0:	00002097          	auipc	ra,0x2
    800019a4:	18a080e7          	jalr	394(ra) # 80003b2a <fileclose>
      p->ofile[fd] = 0;
    800019a8:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    800019ac:	04a1                	addi	s1,s1,8
    800019ae:	01248563          	beq	s1,s2,800019b8 <exit+0x58>
    if(p->ofile[fd]){
    800019b2:	6088                	ld	a0,0(s1)
    800019b4:	f575                	bnez	a0,800019a0 <exit+0x40>
    800019b6:	bfdd                	j	800019ac <exit+0x4c>
  begin_op();
    800019b8:	00002097          	auipc	ra,0x2
    800019bc:	caa080e7          	jalr	-854(ra) # 80003662 <begin_op>
  iput(p->cwd);
    800019c0:	1509b503          	ld	a0,336(s3)
    800019c4:	00001097          	auipc	ra,0x1
    800019c8:	47c080e7          	jalr	1148(ra) # 80002e40 <iput>
  end_op();
    800019cc:	00002097          	auipc	ra,0x2
    800019d0:	d14080e7          	jalr	-748(ra) # 800036e0 <end_op>
  p->cwd = 0;
    800019d4:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800019d8:	00227497          	auipc	s1,0x227
    800019dc:	69048493          	addi	s1,s1,1680 # 80229068 <wait_lock>
    800019e0:	8526                	mv	a0,s1
    800019e2:	00005097          	auipc	ra,0x5
    800019e6:	856080e7          	jalr	-1962(ra) # 80006238 <acquire>
  reparent(p);
    800019ea:	854e                	mv	a0,s3
    800019ec:	00000097          	auipc	ra,0x0
    800019f0:	f1a080e7          	jalr	-230(ra) # 80001906 <reparent>
  wakeup(p->parent);
    800019f4:	0389b503          	ld	a0,56(s3)
    800019f8:	00000097          	auipc	ra,0x0
    800019fc:	e98080e7          	jalr	-360(ra) # 80001890 <wakeup>
  acquire(&p->lock);
    80001a00:	854e                	mv	a0,s3
    80001a02:	00005097          	auipc	ra,0x5
    80001a06:	836080e7          	jalr	-1994(ra) # 80006238 <acquire>
  p->xstate = status;
    80001a0a:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001a0e:	4795                	li	a5,5
    80001a10:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001a14:	8526                	mv	a0,s1
    80001a16:	00005097          	auipc	ra,0x5
    80001a1a:	8d6080e7          	jalr	-1834(ra) # 800062ec <release>
  sched();
    80001a1e:	00000097          	auipc	ra,0x0
    80001a22:	bd4080e7          	jalr	-1068(ra) # 800015f2 <sched>
  panic("zombie exit");
    80001a26:	00006517          	auipc	a0,0x6
    80001a2a:	7fa50513          	addi	a0,a0,2042 # 80008220 <etext+0x220>
    80001a2e:	00004097          	auipc	ra,0x4
    80001a32:	2d2080e7          	jalr	722(ra) # 80005d00 <panic>

0000000080001a36 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001a36:	7179                	addi	sp,sp,-48
    80001a38:	f406                	sd	ra,40(sp)
    80001a3a:	f022                	sd	s0,32(sp)
    80001a3c:	ec26                	sd	s1,24(sp)
    80001a3e:	e84a                	sd	s2,16(sp)
    80001a40:	e44e                	sd	s3,8(sp)
    80001a42:	1800                	addi	s0,sp,48
    80001a44:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001a46:	00228497          	auipc	s1,0x228
    80001a4a:	a3a48493          	addi	s1,s1,-1478 # 80229480 <proc>
    80001a4e:	0022d997          	auipc	s3,0x22d
    80001a52:	43298993          	addi	s3,s3,1074 # 8022ee80 <tickslock>
    acquire(&p->lock);
    80001a56:	8526                	mv	a0,s1
    80001a58:	00004097          	auipc	ra,0x4
    80001a5c:	7e0080e7          	jalr	2016(ra) # 80006238 <acquire>
    if(p->pid == pid){
    80001a60:	589c                	lw	a5,48(s1)
    80001a62:	01278d63          	beq	a5,s2,80001a7c <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001a66:	8526                	mv	a0,s1
    80001a68:	00005097          	auipc	ra,0x5
    80001a6c:	884080e7          	jalr	-1916(ra) # 800062ec <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a70:	16848493          	addi	s1,s1,360
    80001a74:	ff3491e3          	bne	s1,s3,80001a56 <kill+0x20>
  }
  return -1;
    80001a78:	557d                	li	a0,-1
    80001a7a:	a829                	j	80001a94 <kill+0x5e>
      p->killed = 1;
    80001a7c:	4785                	li	a5,1
    80001a7e:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80001a80:	4c98                	lw	a4,24(s1)
    80001a82:	4789                	li	a5,2
    80001a84:	00f70f63          	beq	a4,a5,80001aa2 <kill+0x6c>
      release(&p->lock);
    80001a88:	8526                	mv	a0,s1
    80001a8a:	00005097          	auipc	ra,0x5
    80001a8e:	862080e7          	jalr	-1950(ra) # 800062ec <release>
      return 0;
    80001a92:	4501                	li	a0,0
}
    80001a94:	70a2                	ld	ra,40(sp)
    80001a96:	7402                	ld	s0,32(sp)
    80001a98:	64e2                	ld	s1,24(sp)
    80001a9a:	6942                	ld	s2,16(sp)
    80001a9c:	69a2                	ld	s3,8(sp)
    80001a9e:	6145                	addi	sp,sp,48
    80001aa0:	8082                	ret
        p->state = RUNNABLE;
    80001aa2:	478d                	li	a5,3
    80001aa4:	cc9c                	sw	a5,24(s1)
    80001aa6:	b7cd                	j	80001a88 <kill+0x52>

0000000080001aa8 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001aa8:	7179                	addi	sp,sp,-48
    80001aaa:	f406                	sd	ra,40(sp)
    80001aac:	f022                	sd	s0,32(sp)
    80001aae:	ec26                	sd	s1,24(sp)
    80001ab0:	e84a                	sd	s2,16(sp)
    80001ab2:	e44e                	sd	s3,8(sp)
    80001ab4:	e052                	sd	s4,0(sp)
    80001ab6:	1800                	addi	s0,sp,48
    80001ab8:	84aa                	mv	s1,a0
    80001aba:	892e                	mv	s2,a1
    80001abc:	89b2                	mv	s3,a2
    80001abe:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001ac0:	fffff097          	auipc	ra,0xfffff
    80001ac4:	580080e7          	jalr	1408(ra) # 80001040 <myproc>
  if(user_dst){
    80001ac8:	c08d                	beqz	s1,80001aea <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001aca:	86d2                	mv	a3,s4
    80001acc:	864e                	mv	a2,s3
    80001ace:	85ca                	mv	a1,s2
    80001ad0:	6928                	ld	a0,80(a0)
    80001ad2:	fffff097          	auipc	ra,0xfffff
    80001ad6:	1e2080e7          	jalr	482(ra) # 80000cb4 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001ada:	70a2                	ld	ra,40(sp)
    80001adc:	7402                	ld	s0,32(sp)
    80001ade:	64e2                	ld	s1,24(sp)
    80001ae0:	6942                	ld	s2,16(sp)
    80001ae2:	69a2                	ld	s3,8(sp)
    80001ae4:	6a02                	ld	s4,0(sp)
    80001ae6:	6145                	addi	sp,sp,48
    80001ae8:	8082                	ret
    memmove((char *)dst, src, len);
    80001aea:	000a061b          	sext.w	a2,s4
    80001aee:	85ce                	mv	a1,s3
    80001af0:	854a                	mv	a0,s2
    80001af2:	fffff097          	auipc	ra,0xfffff
    80001af6:	826080e7          	jalr	-2010(ra) # 80000318 <memmove>
    return 0;
    80001afa:	8526                	mv	a0,s1
    80001afc:	bff9                	j	80001ada <either_copyout+0x32>

0000000080001afe <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001afe:	7179                	addi	sp,sp,-48
    80001b00:	f406                	sd	ra,40(sp)
    80001b02:	f022                	sd	s0,32(sp)
    80001b04:	ec26                	sd	s1,24(sp)
    80001b06:	e84a                	sd	s2,16(sp)
    80001b08:	e44e                	sd	s3,8(sp)
    80001b0a:	e052                	sd	s4,0(sp)
    80001b0c:	1800                	addi	s0,sp,48
    80001b0e:	892a                	mv	s2,a0
    80001b10:	84ae                	mv	s1,a1
    80001b12:	89b2                	mv	s3,a2
    80001b14:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001b16:	fffff097          	auipc	ra,0xfffff
    80001b1a:	52a080e7          	jalr	1322(ra) # 80001040 <myproc>
  if(user_src){
    80001b1e:	c08d                	beqz	s1,80001b40 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001b20:	86d2                	mv	a3,s4
    80001b22:	864e                	mv	a2,s3
    80001b24:	85ca                	mv	a1,s2
    80001b26:	6928                	ld	a0,80(a0)
    80001b28:	fffff097          	auipc	ra,0xfffff
    80001b2c:	268080e7          	jalr	616(ra) # 80000d90 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001b30:	70a2                	ld	ra,40(sp)
    80001b32:	7402                	ld	s0,32(sp)
    80001b34:	64e2                	ld	s1,24(sp)
    80001b36:	6942                	ld	s2,16(sp)
    80001b38:	69a2                	ld	s3,8(sp)
    80001b3a:	6a02                	ld	s4,0(sp)
    80001b3c:	6145                	addi	sp,sp,48
    80001b3e:	8082                	ret
    memmove(dst, (char*)src, len);
    80001b40:	000a061b          	sext.w	a2,s4
    80001b44:	85ce                	mv	a1,s3
    80001b46:	854a                	mv	a0,s2
    80001b48:	ffffe097          	auipc	ra,0xffffe
    80001b4c:	7d0080e7          	jalr	2000(ra) # 80000318 <memmove>
    return 0;
    80001b50:	8526                	mv	a0,s1
    80001b52:	bff9                	j	80001b30 <either_copyin+0x32>

0000000080001b54 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001b54:	715d                	addi	sp,sp,-80
    80001b56:	e486                	sd	ra,72(sp)
    80001b58:	e0a2                	sd	s0,64(sp)
    80001b5a:	fc26                	sd	s1,56(sp)
    80001b5c:	f84a                	sd	s2,48(sp)
    80001b5e:	f44e                	sd	s3,40(sp)
    80001b60:	f052                	sd	s4,32(sp)
    80001b62:	ec56                	sd	s5,24(sp)
    80001b64:	e85a                	sd	s6,16(sp)
    80001b66:	e45e                	sd	s7,8(sp)
    80001b68:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001b6a:	00006517          	auipc	a0,0x6
    80001b6e:	50e50513          	addi	a0,a0,1294 # 80008078 <etext+0x78>
    80001b72:	00004097          	auipc	ra,0x4
    80001b76:	1d8080e7          	jalr	472(ra) # 80005d4a <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001b7a:	00228497          	auipc	s1,0x228
    80001b7e:	a5e48493          	addi	s1,s1,-1442 # 802295d8 <proc+0x158>
    80001b82:	0022d917          	auipc	s2,0x22d
    80001b86:	45690913          	addi	s2,s2,1110 # 8022efd8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001b8a:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001b8c:	00006997          	auipc	s3,0x6
    80001b90:	6a498993          	addi	s3,s3,1700 # 80008230 <etext+0x230>
    printf("%d %s %s", p->pid, state, p->name);
    80001b94:	00006a97          	auipc	s5,0x6
    80001b98:	6a4a8a93          	addi	s5,s5,1700 # 80008238 <etext+0x238>
    printf("\n");
    80001b9c:	00006a17          	auipc	s4,0x6
    80001ba0:	4dca0a13          	addi	s4,s4,1244 # 80008078 <etext+0x78>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001ba4:	00006b97          	auipc	s7,0x6
    80001ba8:	6ccb8b93          	addi	s7,s7,1740 # 80008270 <states.0>
    80001bac:	a00d                	j	80001bce <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001bae:	ed86a583          	lw	a1,-296(a3)
    80001bb2:	8556                	mv	a0,s5
    80001bb4:	00004097          	auipc	ra,0x4
    80001bb8:	196080e7          	jalr	406(ra) # 80005d4a <printf>
    printf("\n");
    80001bbc:	8552                	mv	a0,s4
    80001bbe:	00004097          	auipc	ra,0x4
    80001bc2:	18c080e7          	jalr	396(ra) # 80005d4a <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001bc6:	16848493          	addi	s1,s1,360
    80001bca:	03248263          	beq	s1,s2,80001bee <procdump+0x9a>
    if(p->state == UNUSED)
    80001bce:	86a6                	mv	a3,s1
    80001bd0:	ec04a783          	lw	a5,-320(s1)
    80001bd4:	dbed                	beqz	a5,80001bc6 <procdump+0x72>
      state = "???";
    80001bd6:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001bd8:	fcfb6be3          	bltu	s6,a5,80001bae <procdump+0x5a>
    80001bdc:	02079713          	slli	a4,a5,0x20
    80001be0:	01d75793          	srli	a5,a4,0x1d
    80001be4:	97de                	add	a5,a5,s7
    80001be6:	6390                	ld	a2,0(a5)
    80001be8:	f279                	bnez	a2,80001bae <procdump+0x5a>
      state = "???";
    80001bea:	864e                	mv	a2,s3
    80001bec:	b7c9                	j	80001bae <procdump+0x5a>
  }
}
    80001bee:	60a6                	ld	ra,72(sp)
    80001bf0:	6406                	ld	s0,64(sp)
    80001bf2:	74e2                	ld	s1,56(sp)
    80001bf4:	7942                	ld	s2,48(sp)
    80001bf6:	79a2                	ld	s3,40(sp)
    80001bf8:	7a02                	ld	s4,32(sp)
    80001bfa:	6ae2                	ld	s5,24(sp)
    80001bfc:	6b42                	ld	s6,16(sp)
    80001bfe:	6ba2                	ld	s7,8(sp)
    80001c00:	6161                	addi	sp,sp,80
    80001c02:	8082                	ret

0000000080001c04 <swtch>:
    80001c04:	00153023          	sd	ra,0(a0)
    80001c08:	00253423          	sd	sp,8(a0)
    80001c0c:	e900                	sd	s0,16(a0)
    80001c0e:	ed04                	sd	s1,24(a0)
    80001c10:	03253023          	sd	s2,32(a0)
    80001c14:	03353423          	sd	s3,40(a0)
    80001c18:	03453823          	sd	s4,48(a0)
    80001c1c:	03553c23          	sd	s5,56(a0)
    80001c20:	05653023          	sd	s6,64(a0)
    80001c24:	05753423          	sd	s7,72(a0)
    80001c28:	05853823          	sd	s8,80(a0)
    80001c2c:	05953c23          	sd	s9,88(a0)
    80001c30:	07a53023          	sd	s10,96(a0)
    80001c34:	07b53423          	sd	s11,104(a0)
    80001c38:	0005b083          	ld	ra,0(a1)
    80001c3c:	0085b103          	ld	sp,8(a1)
    80001c40:	6980                	ld	s0,16(a1)
    80001c42:	6d84                	ld	s1,24(a1)
    80001c44:	0205b903          	ld	s2,32(a1)
    80001c48:	0285b983          	ld	s3,40(a1)
    80001c4c:	0305ba03          	ld	s4,48(a1)
    80001c50:	0385ba83          	ld	s5,56(a1)
    80001c54:	0405bb03          	ld	s6,64(a1)
    80001c58:	0485bb83          	ld	s7,72(a1)
    80001c5c:	0505bc03          	ld	s8,80(a1)
    80001c60:	0585bc83          	ld	s9,88(a1)
    80001c64:	0605bd03          	ld	s10,96(a1)
    80001c68:	0685bd83          	ld	s11,104(a1)
    80001c6c:	8082                	ret

0000000080001c6e <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001c6e:	1141                	addi	sp,sp,-16
    80001c70:	e406                	sd	ra,8(sp)
    80001c72:	e022                	sd	s0,0(sp)
    80001c74:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001c76:	00006597          	auipc	a1,0x6
    80001c7a:	62a58593          	addi	a1,a1,1578 # 800082a0 <states.0+0x30>
    80001c7e:	0022d517          	auipc	a0,0x22d
    80001c82:	20250513          	addi	a0,a0,514 # 8022ee80 <tickslock>
    80001c86:	00004097          	auipc	ra,0x4
    80001c8a:	522080e7          	jalr	1314(ra) # 800061a8 <initlock>
}
    80001c8e:	60a2                	ld	ra,8(sp)
    80001c90:	6402                	ld	s0,0(sp)
    80001c92:	0141                	addi	sp,sp,16
    80001c94:	8082                	ret

0000000080001c96 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001c96:	1141                	addi	sp,sp,-16
    80001c98:	e422                	sd	s0,8(sp)
    80001c9a:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001c9c:	00003797          	auipc	a5,0x3
    80001ca0:	4c478793          	addi	a5,a5,1220 # 80005160 <kernelvec>
    80001ca4:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001ca8:	6422                	ld	s0,8(sp)
    80001caa:	0141                	addi	sp,sp,16
    80001cac:	8082                	ret

0000000080001cae <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001cae:	1141                	addi	sp,sp,-16
    80001cb0:	e406                	sd	ra,8(sp)
    80001cb2:	e022                	sd	s0,0(sp)
    80001cb4:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001cb6:	fffff097          	auipc	ra,0xfffff
    80001cba:	38a080e7          	jalr	906(ra) # 80001040 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001cbe:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001cc2:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001cc4:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001cc8:	00005697          	auipc	a3,0x5
    80001ccc:	33868693          	addi	a3,a3,824 # 80007000 <_trampoline>
    80001cd0:	00005717          	auipc	a4,0x5
    80001cd4:	33070713          	addi	a4,a4,816 # 80007000 <_trampoline>
    80001cd8:	8f15                	sub	a4,a4,a3
    80001cda:	040007b7          	lui	a5,0x4000
    80001cde:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001ce0:	07b2                	slli	a5,a5,0xc
    80001ce2:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001ce4:	10571073          	csrw	stvec,a4

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001ce8:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001cea:	18002673          	csrr	a2,satp
    80001cee:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001cf0:	6d30                	ld	a2,88(a0)
    80001cf2:	6138                	ld	a4,64(a0)
    80001cf4:	6585                	lui	a1,0x1
    80001cf6:	972e                	add	a4,a4,a1
    80001cf8:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001cfa:	6d38                	ld	a4,88(a0)
    80001cfc:	00000617          	auipc	a2,0x0
    80001d00:	13860613          	addi	a2,a2,312 # 80001e34 <usertrap>
    80001d04:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001d06:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001d08:	8612                	mv	a2,tp
    80001d0a:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d0c:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001d10:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001d14:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001d18:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001d1c:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001d1e:	6f18                	ld	a4,24(a4)
    80001d20:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001d24:	692c                	ld	a1,80(a0)
    80001d26:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001d28:	00005717          	auipc	a4,0x5
    80001d2c:	36870713          	addi	a4,a4,872 # 80007090 <userret>
    80001d30:	8f15                	sub	a4,a4,a3
    80001d32:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80001d34:	577d                	li	a4,-1
    80001d36:	177e                	slli	a4,a4,0x3f
    80001d38:	8dd9                	or	a1,a1,a4
    80001d3a:	02000537          	lui	a0,0x2000
    80001d3e:	157d                	addi	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    80001d40:	0536                	slli	a0,a0,0xd
    80001d42:	9782                	jalr	a5
}
    80001d44:	60a2                	ld	ra,8(sp)
    80001d46:	6402                	ld	s0,0(sp)
    80001d48:	0141                	addi	sp,sp,16
    80001d4a:	8082                	ret

0000000080001d4c <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001d4c:	1101                	addi	sp,sp,-32
    80001d4e:	ec06                	sd	ra,24(sp)
    80001d50:	e822                	sd	s0,16(sp)
    80001d52:	e426                	sd	s1,8(sp)
    80001d54:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001d56:	0022d497          	auipc	s1,0x22d
    80001d5a:	12a48493          	addi	s1,s1,298 # 8022ee80 <tickslock>
    80001d5e:	8526                	mv	a0,s1
    80001d60:	00004097          	auipc	ra,0x4
    80001d64:	4d8080e7          	jalr	1240(ra) # 80006238 <acquire>
  ticks++;
    80001d68:	00007517          	auipc	a0,0x7
    80001d6c:	2b050513          	addi	a0,a0,688 # 80009018 <ticks>
    80001d70:	411c                	lw	a5,0(a0)
    80001d72:	2785                	addiw	a5,a5,1
    80001d74:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001d76:	00000097          	auipc	ra,0x0
    80001d7a:	b1a080e7          	jalr	-1254(ra) # 80001890 <wakeup>
  release(&tickslock);
    80001d7e:	8526                	mv	a0,s1
    80001d80:	00004097          	auipc	ra,0x4
    80001d84:	56c080e7          	jalr	1388(ra) # 800062ec <release>
}
    80001d88:	60e2                	ld	ra,24(sp)
    80001d8a:	6442                	ld	s0,16(sp)
    80001d8c:	64a2                	ld	s1,8(sp)
    80001d8e:	6105                	addi	sp,sp,32
    80001d90:	8082                	ret

0000000080001d92 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001d92:	1101                	addi	sp,sp,-32
    80001d94:	ec06                	sd	ra,24(sp)
    80001d96:	e822                	sd	s0,16(sp)
    80001d98:	e426                	sd	s1,8(sp)
    80001d9a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d9c:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001da0:	00074d63          	bltz	a4,80001dba <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001da4:	57fd                	li	a5,-1
    80001da6:	17fe                	slli	a5,a5,0x3f
    80001da8:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001daa:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001dac:	06f70363          	beq	a4,a5,80001e12 <devintr+0x80>
  }
}
    80001db0:	60e2                	ld	ra,24(sp)
    80001db2:	6442                	ld	s0,16(sp)
    80001db4:	64a2                	ld	s1,8(sp)
    80001db6:	6105                	addi	sp,sp,32
    80001db8:	8082                	ret
     (scause & 0xff) == 9){
    80001dba:	0ff77793          	zext.b	a5,a4
  if((scause & 0x8000000000000000L) &&
    80001dbe:	46a5                	li	a3,9
    80001dc0:	fed792e3          	bne	a5,a3,80001da4 <devintr+0x12>
    int irq = plic_claim();
    80001dc4:	00003097          	auipc	ra,0x3
    80001dc8:	4a4080e7          	jalr	1188(ra) # 80005268 <plic_claim>
    80001dcc:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001dce:	47a9                	li	a5,10
    80001dd0:	02f50763          	beq	a0,a5,80001dfe <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001dd4:	4785                	li	a5,1
    80001dd6:	02f50963          	beq	a0,a5,80001e08 <devintr+0x76>
    return 1;
    80001dda:	4505                	li	a0,1
    } else if(irq){
    80001ddc:	d8f1                	beqz	s1,80001db0 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001dde:	85a6                	mv	a1,s1
    80001de0:	00006517          	auipc	a0,0x6
    80001de4:	4c850513          	addi	a0,a0,1224 # 800082a8 <states.0+0x38>
    80001de8:	00004097          	auipc	ra,0x4
    80001dec:	f62080e7          	jalr	-158(ra) # 80005d4a <printf>
      plic_complete(irq);
    80001df0:	8526                	mv	a0,s1
    80001df2:	00003097          	auipc	ra,0x3
    80001df6:	49a080e7          	jalr	1178(ra) # 8000528c <plic_complete>
    return 1;
    80001dfa:	4505                	li	a0,1
    80001dfc:	bf55                	j	80001db0 <devintr+0x1e>
      uartintr();
    80001dfe:	00004097          	auipc	ra,0x4
    80001e02:	35a080e7          	jalr	858(ra) # 80006158 <uartintr>
    80001e06:	b7ed                	j	80001df0 <devintr+0x5e>
      virtio_disk_intr();
    80001e08:	00004097          	auipc	ra,0x4
    80001e0c:	910080e7          	jalr	-1776(ra) # 80005718 <virtio_disk_intr>
    80001e10:	b7c5                	j	80001df0 <devintr+0x5e>
    if(cpuid() == 0){
    80001e12:	fffff097          	auipc	ra,0xfffff
    80001e16:	202080e7          	jalr	514(ra) # 80001014 <cpuid>
    80001e1a:	c901                	beqz	a0,80001e2a <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001e1c:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001e20:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001e22:	14479073          	csrw	sip,a5
    return 2;
    80001e26:	4509                	li	a0,2
    80001e28:	b761                	j	80001db0 <devintr+0x1e>
      clockintr();
    80001e2a:	00000097          	auipc	ra,0x0
    80001e2e:	f22080e7          	jalr	-222(ra) # 80001d4c <clockintr>
    80001e32:	b7ed                	j	80001e1c <devintr+0x8a>

0000000080001e34 <usertrap>:
{
    80001e34:	1101                	addi	sp,sp,-32
    80001e36:	ec06                	sd	ra,24(sp)
    80001e38:	e822                	sd	s0,16(sp)
    80001e3a:	e426                	sd	s1,8(sp)
    80001e3c:	e04a                	sd	s2,0(sp)
    80001e3e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e40:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001e44:	1007f793          	andi	a5,a5,256
    80001e48:	e3ad                	bnez	a5,80001eaa <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001e4a:	00003797          	auipc	a5,0x3
    80001e4e:	31678793          	addi	a5,a5,790 # 80005160 <kernelvec>
    80001e52:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001e56:	fffff097          	auipc	ra,0xfffff
    80001e5a:	1ea080e7          	jalr	490(ra) # 80001040 <myproc>
    80001e5e:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001e60:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e62:	14102773          	csrr	a4,sepc
    80001e66:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e68:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001e6c:	47a1                	li	a5,8
    80001e6e:	04f71c63          	bne	a4,a5,80001ec6 <usertrap+0x92>
    if(p->killed)
    80001e72:	551c                	lw	a5,40(a0)
    80001e74:	e3b9                	bnez	a5,80001eba <usertrap+0x86>
    p->trapframe->epc += 4;
    80001e76:	6cb8                	ld	a4,88(s1)
    80001e78:	6f1c                	ld	a5,24(a4)
    80001e7a:	0791                	addi	a5,a5,4
    80001e7c:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e7e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001e82:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e86:	10079073          	csrw	sstatus,a5
    syscall();
    80001e8a:	00000097          	auipc	ra,0x0
    80001e8e:	2fe080e7          	jalr	766(ra) # 80002188 <syscall>
  if(p->killed)
    80001e92:	549c                	lw	a5,40(s1)
    80001e94:	e7dd                	bnez	a5,80001f42 <usertrap+0x10e>
  usertrapret();
    80001e96:	00000097          	auipc	ra,0x0
    80001e9a:	e18080e7          	jalr	-488(ra) # 80001cae <usertrapret>
}
    80001e9e:	60e2                	ld	ra,24(sp)
    80001ea0:	6442                	ld	s0,16(sp)
    80001ea2:	64a2                	ld	s1,8(sp)
    80001ea4:	6902                	ld	s2,0(sp)
    80001ea6:	6105                	addi	sp,sp,32
    80001ea8:	8082                	ret
    panic("usertrap: not from user mode");
    80001eaa:	00006517          	auipc	a0,0x6
    80001eae:	41e50513          	addi	a0,a0,1054 # 800082c8 <states.0+0x58>
    80001eb2:	00004097          	auipc	ra,0x4
    80001eb6:	e4e080e7          	jalr	-434(ra) # 80005d00 <panic>
      exit(-1);
    80001eba:	557d                	li	a0,-1
    80001ebc:	00000097          	auipc	ra,0x0
    80001ec0:	aa4080e7          	jalr	-1372(ra) # 80001960 <exit>
    80001ec4:	bf4d                	j	80001e76 <usertrap+0x42>
  else if((which_dev = devintr()) != 0){
    80001ec6:	00000097          	auipc	ra,0x0
    80001eca:	ecc080e7          	jalr	-308(ra) # 80001d92 <devintr>
    80001ece:	892a                	mv	s2,a0
    80001ed0:	e535                	bnez	a0,80001f3c <usertrap+0x108>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001ed2:	14202773          	csrr	a4,scause
  else if(r_scause() == 0xf) {
    80001ed6:	47bd                	li	a5,15
    80001ed8:	04f70863          	beq	a4,a5,80001f28 <usertrap+0xf4>
    80001edc:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001ee0:	5890                	lw	a2,48(s1)
    80001ee2:	00006517          	auipc	a0,0x6
    80001ee6:	40650513          	addi	a0,a0,1030 # 800082e8 <states.0+0x78>
    80001eea:	00004097          	auipc	ra,0x4
    80001eee:	e60080e7          	jalr	-416(ra) # 80005d4a <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001ef2:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001ef6:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001efa:	00006517          	auipc	a0,0x6
    80001efe:	41e50513          	addi	a0,a0,1054 # 80008318 <states.0+0xa8>
    80001f02:	00004097          	auipc	ra,0x4
    80001f06:	e48080e7          	jalr	-440(ra) # 80005d4a <printf>
    p->killed = 1;
    80001f0a:	4785                	li	a5,1
    80001f0c:	d49c                	sw	a5,40(s1)
    exit(-1);
    80001f0e:	557d                	li	a0,-1
    80001f10:	00000097          	auipc	ra,0x0
    80001f14:	a50080e7          	jalr	-1456(ra) # 80001960 <exit>
  if(which_dev == 2)
    80001f18:	4789                	li	a5,2
    80001f1a:	f6f91ee3          	bne	s2,a5,80001e96 <usertrap+0x62>
    yield();
    80001f1e:	fffff097          	auipc	ra,0xfffff
    80001f22:	7aa080e7          	jalr	1962(ra) # 800016c8 <yield>
    80001f26:	bf85                	j	80001e96 <usertrap+0x62>
    80001f28:	143025f3          	csrr	a1,stval
      if(uvmcowalloc(p->pagetable, r_stval()) < 0)
    80001f2c:	68a8                	ld	a0,80(s1)
    80001f2e:	fffff097          	auipc	ra,0xfffff
    80001f32:	c18080e7          	jalr	-1000(ra) # 80000b46 <uvmcowalloc>
    80001f36:	f4055ee3          	bgez	a0,80001e92 <usertrap+0x5e>
    80001f3a:	bfc1                	j	80001f0a <usertrap+0xd6>
  if(p->killed)
    80001f3c:	549c                	lw	a5,40(s1)
    80001f3e:	dfe9                	beqz	a5,80001f18 <usertrap+0xe4>
    80001f40:	b7f9                	j	80001f0e <usertrap+0xda>
    80001f42:	4901                	li	s2,0
    80001f44:	b7e9                	j	80001f0e <usertrap+0xda>

0000000080001f46 <kerneltrap>:
{
    80001f46:	7179                	addi	sp,sp,-48
    80001f48:	f406                	sd	ra,40(sp)
    80001f4a:	f022                	sd	s0,32(sp)
    80001f4c:	ec26                	sd	s1,24(sp)
    80001f4e:	e84a                	sd	s2,16(sp)
    80001f50:	e44e                	sd	s3,8(sp)
    80001f52:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001f54:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f58:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001f5c:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001f60:	1004f793          	andi	a5,s1,256
    80001f64:	cb85                	beqz	a5,80001f94 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f66:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001f6a:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001f6c:	ef85                	bnez	a5,80001fa4 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001f6e:	00000097          	auipc	ra,0x0
    80001f72:	e24080e7          	jalr	-476(ra) # 80001d92 <devintr>
    80001f76:	cd1d                	beqz	a0,80001fb4 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001f78:	4789                	li	a5,2
    80001f7a:	06f50a63          	beq	a0,a5,80001fee <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001f7e:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001f82:	10049073          	csrw	sstatus,s1
}
    80001f86:	70a2                	ld	ra,40(sp)
    80001f88:	7402                	ld	s0,32(sp)
    80001f8a:	64e2                	ld	s1,24(sp)
    80001f8c:	6942                	ld	s2,16(sp)
    80001f8e:	69a2                	ld	s3,8(sp)
    80001f90:	6145                	addi	sp,sp,48
    80001f92:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001f94:	00006517          	auipc	a0,0x6
    80001f98:	3a450513          	addi	a0,a0,932 # 80008338 <states.0+0xc8>
    80001f9c:	00004097          	auipc	ra,0x4
    80001fa0:	d64080e7          	jalr	-668(ra) # 80005d00 <panic>
    panic("kerneltrap: interrupts enabled");
    80001fa4:	00006517          	auipc	a0,0x6
    80001fa8:	3bc50513          	addi	a0,a0,956 # 80008360 <states.0+0xf0>
    80001fac:	00004097          	auipc	ra,0x4
    80001fb0:	d54080e7          	jalr	-684(ra) # 80005d00 <panic>
    printf("scause %p\n", scause);
    80001fb4:	85ce                	mv	a1,s3
    80001fb6:	00006517          	auipc	a0,0x6
    80001fba:	3ca50513          	addi	a0,a0,970 # 80008380 <states.0+0x110>
    80001fbe:	00004097          	auipc	ra,0x4
    80001fc2:	d8c080e7          	jalr	-628(ra) # 80005d4a <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001fc6:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001fca:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001fce:	00006517          	auipc	a0,0x6
    80001fd2:	3c250513          	addi	a0,a0,962 # 80008390 <states.0+0x120>
    80001fd6:	00004097          	auipc	ra,0x4
    80001fda:	d74080e7          	jalr	-652(ra) # 80005d4a <printf>
    panic("kerneltrap");
    80001fde:	00006517          	auipc	a0,0x6
    80001fe2:	3ca50513          	addi	a0,a0,970 # 800083a8 <states.0+0x138>
    80001fe6:	00004097          	auipc	ra,0x4
    80001fea:	d1a080e7          	jalr	-742(ra) # 80005d00 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001fee:	fffff097          	auipc	ra,0xfffff
    80001ff2:	052080e7          	jalr	82(ra) # 80001040 <myproc>
    80001ff6:	d541                	beqz	a0,80001f7e <kerneltrap+0x38>
    80001ff8:	fffff097          	auipc	ra,0xfffff
    80001ffc:	048080e7          	jalr	72(ra) # 80001040 <myproc>
    80002000:	4d18                	lw	a4,24(a0)
    80002002:	4791                	li	a5,4
    80002004:	f6f71de3          	bne	a4,a5,80001f7e <kerneltrap+0x38>
    yield();
    80002008:	fffff097          	auipc	ra,0xfffff
    8000200c:	6c0080e7          	jalr	1728(ra) # 800016c8 <yield>
    80002010:	b7bd                	j	80001f7e <kerneltrap+0x38>

0000000080002012 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002012:	1101                	addi	sp,sp,-32
    80002014:	ec06                	sd	ra,24(sp)
    80002016:	e822                	sd	s0,16(sp)
    80002018:	e426                	sd	s1,8(sp)
    8000201a:	1000                	addi	s0,sp,32
    8000201c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    8000201e:	fffff097          	auipc	ra,0xfffff
    80002022:	022080e7          	jalr	34(ra) # 80001040 <myproc>
  switch (n) {
    80002026:	4795                	li	a5,5
    80002028:	0497e163          	bltu	a5,s1,8000206a <argraw+0x58>
    8000202c:	048a                	slli	s1,s1,0x2
    8000202e:	00006717          	auipc	a4,0x6
    80002032:	3b270713          	addi	a4,a4,946 # 800083e0 <states.0+0x170>
    80002036:	94ba                	add	s1,s1,a4
    80002038:	409c                	lw	a5,0(s1)
    8000203a:	97ba                	add	a5,a5,a4
    8000203c:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    8000203e:	6d3c                	ld	a5,88(a0)
    80002040:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002042:	60e2                	ld	ra,24(sp)
    80002044:	6442                	ld	s0,16(sp)
    80002046:	64a2                	ld	s1,8(sp)
    80002048:	6105                	addi	sp,sp,32
    8000204a:	8082                	ret
    return p->trapframe->a1;
    8000204c:	6d3c                	ld	a5,88(a0)
    8000204e:	7fa8                	ld	a0,120(a5)
    80002050:	bfcd                	j	80002042 <argraw+0x30>
    return p->trapframe->a2;
    80002052:	6d3c                	ld	a5,88(a0)
    80002054:	63c8                	ld	a0,128(a5)
    80002056:	b7f5                	j	80002042 <argraw+0x30>
    return p->trapframe->a3;
    80002058:	6d3c                	ld	a5,88(a0)
    8000205a:	67c8                	ld	a0,136(a5)
    8000205c:	b7dd                	j	80002042 <argraw+0x30>
    return p->trapframe->a4;
    8000205e:	6d3c                	ld	a5,88(a0)
    80002060:	6bc8                	ld	a0,144(a5)
    80002062:	b7c5                	j	80002042 <argraw+0x30>
    return p->trapframe->a5;
    80002064:	6d3c                	ld	a5,88(a0)
    80002066:	6fc8                	ld	a0,152(a5)
    80002068:	bfe9                	j	80002042 <argraw+0x30>
  panic("argraw");
    8000206a:	00006517          	auipc	a0,0x6
    8000206e:	34e50513          	addi	a0,a0,846 # 800083b8 <states.0+0x148>
    80002072:	00004097          	auipc	ra,0x4
    80002076:	c8e080e7          	jalr	-882(ra) # 80005d00 <panic>

000000008000207a <fetchaddr>:
{
    8000207a:	1101                	addi	sp,sp,-32
    8000207c:	ec06                	sd	ra,24(sp)
    8000207e:	e822                	sd	s0,16(sp)
    80002080:	e426                	sd	s1,8(sp)
    80002082:	e04a                	sd	s2,0(sp)
    80002084:	1000                	addi	s0,sp,32
    80002086:	84aa                	mv	s1,a0
    80002088:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000208a:	fffff097          	auipc	ra,0xfffff
    8000208e:	fb6080e7          	jalr	-74(ra) # 80001040 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80002092:	653c                	ld	a5,72(a0)
    80002094:	02f4f863          	bgeu	s1,a5,800020c4 <fetchaddr+0x4a>
    80002098:	00848713          	addi	a4,s1,8
    8000209c:	02e7e663          	bltu	a5,a4,800020c8 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    800020a0:	46a1                	li	a3,8
    800020a2:	8626                	mv	a2,s1
    800020a4:	85ca                	mv	a1,s2
    800020a6:	6928                	ld	a0,80(a0)
    800020a8:	fffff097          	auipc	ra,0xfffff
    800020ac:	ce8080e7          	jalr	-792(ra) # 80000d90 <copyin>
    800020b0:	00a03533          	snez	a0,a0
    800020b4:	40a00533          	neg	a0,a0
}
    800020b8:	60e2                	ld	ra,24(sp)
    800020ba:	6442                	ld	s0,16(sp)
    800020bc:	64a2                	ld	s1,8(sp)
    800020be:	6902                	ld	s2,0(sp)
    800020c0:	6105                	addi	sp,sp,32
    800020c2:	8082                	ret
    return -1;
    800020c4:	557d                	li	a0,-1
    800020c6:	bfcd                	j	800020b8 <fetchaddr+0x3e>
    800020c8:	557d                	li	a0,-1
    800020ca:	b7fd                	j	800020b8 <fetchaddr+0x3e>

00000000800020cc <fetchstr>:
{
    800020cc:	7179                	addi	sp,sp,-48
    800020ce:	f406                	sd	ra,40(sp)
    800020d0:	f022                	sd	s0,32(sp)
    800020d2:	ec26                	sd	s1,24(sp)
    800020d4:	e84a                	sd	s2,16(sp)
    800020d6:	e44e                	sd	s3,8(sp)
    800020d8:	1800                	addi	s0,sp,48
    800020da:	892a                	mv	s2,a0
    800020dc:	84ae                	mv	s1,a1
    800020de:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    800020e0:	fffff097          	auipc	ra,0xfffff
    800020e4:	f60080e7          	jalr	-160(ra) # 80001040 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    800020e8:	86ce                	mv	a3,s3
    800020ea:	864a                	mv	a2,s2
    800020ec:	85a6                	mv	a1,s1
    800020ee:	6928                	ld	a0,80(a0)
    800020f0:	fffff097          	auipc	ra,0xfffff
    800020f4:	d2e080e7          	jalr	-722(ra) # 80000e1e <copyinstr>
  if(err < 0)
    800020f8:	00054763          	bltz	a0,80002106 <fetchstr+0x3a>
  return strlen(buf);
    800020fc:	8526                	mv	a0,s1
    800020fe:	ffffe097          	auipc	ra,0xffffe
    80002102:	33a080e7          	jalr	826(ra) # 80000438 <strlen>
}
    80002106:	70a2                	ld	ra,40(sp)
    80002108:	7402                	ld	s0,32(sp)
    8000210a:	64e2                	ld	s1,24(sp)
    8000210c:	6942                	ld	s2,16(sp)
    8000210e:	69a2                	ld	s3,8(sp)
    80002110:	6145                	addi	sp,sp,48
    80002112:	8082                	ret

0000000080002114 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002114:	1101                	addi	sp,sp,-32
    80002116:	ec06                	sd	ra,24(sp)
    80002118:	e822                	sd	s0,16(sp)
    8000211a:	e426                	sd	s1,8(sp)
    8000211c:	1000                	addi	s0,sp,32
    8000211e:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002120:	00000097          	auipc	ra,0x0
    80002124:	ef2080e7          	jalr	-270(ra) # 80002012 <argraw>
    80002128:	c088                	sw	a0,0(s1)
  return 0;
}
    8000212a:	4501                	li	a0,0
    8000212c:	60e2                	ld	ra,24(sp)
    8000212e:	6442                	ld	s0,16(sp)
    80002130:	64a2                	ld	s1,8(sp)
    80002132:	6105                	addi	sp,sp,32
    80002134:	8082                	ret

0000000080002136 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002136:	1101                	addi	sp,sp,-32
    80002138:	ec06                	sd	ra,24(sp)
    8000213a:	e822                	sd	s0,16(sp)
    8000213c:	e426                	sd	s1,8(sp)
    8000213e:	1000                	addi	s0,sp,32
    80002140:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002142:	00000097          	auipc	ra,0x0
    80002146:	ed0080e7          	jalr	-304(ra) # 80002012 <argraw>
    8000214a:	e088                	sd	a0,0(s1)
  return 0;
}
    8000214c:	4501                	li	a0,0
    8000214e:	60e2                	ld	ra,24(sp)
    80002150:	6442                	ld	s0,16(sp)
    80002152:	64a2                	ld	s1,8(sp)
    80002154:	6105                	addi	sp,sp,32
    80002156:	8082                	ret

0000000080002158 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002158:	1101                	addi	sp,sp,-32
    8000215a:	ec06                	sd	ra,24(sp)
    8000215c:	e822                	sd	s0,16(sp)
    8000215e:	e426                	sd	s1,8(sp)
    80002160:	e04a                	sd	s2,0(sp)
    80002162:	1000                	addi	s0,sp,32
    80002164:	84ae                	mv	s1,a1
    80002166:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002168:	00000097          	auipc	ra,0x0
    8000216c:	eaa080e7          	jalr	-342(ra) # 80002012 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002170:	864a                	mv	a2,s2
    80002172:	85a6                	mv	a1,s1
    80002174:	00000097          	auipc	ra,0x0
    80002178:	f58080e7          	jalr	-168(ra) # 800020cc <fetchstr>
}
    8000217c:	60e2                	ld	ra,24(sp)
    8000217e:	6442                	ld	s0,16(sp)
    80002180:	64a2                	ld	s1,8(sp)
    80002182:	6902                	ld	s2,0(sp)
    80002184:	6105                	addi	sp,sp,32
    80002186:	8082                	ret

0000000080002188 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    80002188:	1101                	addi	sp,sp,-32
    8000218a:	ec06                	sd	ra,24(sp)
    8000218c:	e822                	sd	s0,16(sp)
    8000218e:	e426                	sd	s1,8(sp)
    80002190:	e04a                	sd	s2,0(sp)
    80002192:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002194:	fffff097          	auipc	ra,0xfffff
    80002198:	eac080e7          	jalr	-340(ra) # 80001040 <myproc>
    8000219c:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    8000219e:	05853903          	ld	s2,88(a0)
    800021a2:	0a893783          	ld	a5,168(s2)
    800021a6:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    800021aa:	37fd                	addiw	a5,a5,-1
    800021ac:	4751                	li	a4,20
    800021ae:	00f76f63          	bltu	a4,a5,800021cc <syscall+0x44>
    800021b2:	00369713          	slli	a4,a3,0x3
    800021b6:	00006797          	auipc	a5,0x6
    800021ba:	24278793          	addi	a5,a5,578 # 800083f8 <syscalls>
    800021be:	97ba                	add	a5,a5,a4
    800021c0:	639c                	ld	a5,0(a5)
    800021c2:	c789                	beqz	a5,800021cc <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    800021c4:	9782                	jalr	a5
    800021c6:	06a93823          	sd	a0,112(s2)
    800021ca:	a839                	j	800021e8 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    800021cc:	15848613          	addi	a2,s1,344
    800021d0:	588c                	lw	a1,48(s1)
    800021d2:	00006517          	auipc	a0,0x6
    800021d6:	1ee50513          	addi	a0,a0,494 # 800083c0 <states.0+0x150>
    800021da:	00004097          	auipc	ra,0x4
    800021de:	b70080e7          	jalr	-1168(ra) # 80005d4a <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    800021e2:	6cbc                	ld	a5,88(s1)
    800021e4:	577d                	li	a4,-1
    800021e6:	fbb8                	sd	a4,112(a5)
  }
}
    800021e8:	60e2                	ld	ra,24(sp)
    800021ea:	6442                	ld	s0,16(sp)
    800021ec:	64a2                	ld	s1,8(sp)
    800021ee:	6902                	ld	s2,0(sp)
    800021f0:	6105                	addi	sp,sp,32
    800021f2:	8082                	ret

00000000800021f4 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    800021f4:	1101                	addi	sp,sp,-32
    800021f6:	ec06                	sd	ra,24(sp)
    800021f8:	e822                	sd	s0,16(sp)
    800021fa:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    800021fc:	fec40593          	addi	a1,s0,-20
    80002200:	4501                	li	a0,0
    80002202:	00000097          	auipc	ra,0x0
    80002206:	f12080e7          	jalr	-238(ra) # 80002114 <argint>
    return -1;
    8000220a:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    8000220c:	00054963          	bltz	a0,8000221e <sys_exit+0x2a>
  exit(n);
    80002210:	fec42503          	lw	a0,-20(s0)
    80002214:	fffff097          	auipc	ra,0xfffff
    80002218:	74c080e7          	jalr	1868(ra) # 80001960 <exit>
  return 0;  // not reached
    8000221c:	4781                	li	a5,0
}
    8000221e:	853e                	mv	a0,a5
    80002220:	60e2                	ld	ra,24(sp)
    80002222:	6442                	ld	s0,16(sp)
    80002224:	6105                	addi	sp,sp,32
    80002226:	8082                	ret

0000000080002228 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002228:	1141                	addi	sp,sp,-16
    8000222a:	e406                	sd	ra,8(sp)
    8000222c:	e022                	sd	s0,0(sp)
    8000222e:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002230:	fffff097          	auipc	ra,0xfffff
    80002234:	e10080e7          	jalr	-496(ra) # 80001040 <myproc>
}
    80002238:	5908                	lw	a0,48(a0)
    8000223a:	60a2                	ld	ra,8(sp)
    8000223c:	6402                	ld	s0,0(sp)
    8000223e:	0141                	addi	sp,sp,16
    80002240:	8082                	ret

0000000080002242 <sys_fork>:

uint64
sys_fork(void)
{
    80002242:	1141                	addi	sp,sp,-16
    80002244:	e406                	sd	ra,8(sp)
    80002246:	e022                	sd	s0,0(sp)
    80002248:	0800                	addi	s0,sp,16
  return fork();
    8000224a:	fffff097          	auipc	ra,0xfffff
    8000224e:	1c8080e7          	jalr	456(ra) # 80001412 <fork>
}
    80002252:	60a2                	ld	ra,8(sp)
    80002254:	6402                	ld	s0,0(sp)
    80002256:	0141                	addi	sp,sp,16
    80002258:	8082                	ret

000000008000225a <sys_wait>:

uint64
sys_wait(void)
{
    8000225a:	1101                	addi	sp,sp,-32
    8000225c:	ec06                	sd	ra,24(sp)
    8000225e:	e822                	sd	s0,16(sp)
    80002260:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002262:	fe840593          	addi	a1,s0,-24
    80002266:	4501                	li	a0,0
    80002268:	00000097          	auipc	ra,0x0
    8000226c:	ece080e7          	jalr	-306(ra) # 80002136 <argaddr>
    80002270:	87aa                	mv	a5,a0
    return -1;
    80002272:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002274:	0007c863          	bltz	a5,80002284 <sys_wait+0x2a>
  return wait(p);
    80002278:	fe843503          	ld	a0,-24(s0)
    8000227c:	fffff097          	auipc	ra,0xfffff
    80002280:	4ec080e7          	jalr	1260(ra) # 80001768 <wait>
}
    80002284:	60e2                	ld	ra,24(sp)
    80002286:	6442                	ld	s0,16(sp)
    80002288:	6105                	addi	sp,sp,32
    8000228a:	8082                	ret

000000008000228c <sys_sbrk>:

uint64
sys_sbrk(void)
{
    8000228c:	7179                	addi	sp,sp,-48
    8000228e:	f406                	sd	ra,40(sp)
    80002290:	f022                	sd	s0,32(sp)
    80002292:	ec26                	sd	s1,24(sp)
    80002294:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80002296:	fdc40593          	addi	a1,s0,-36
    8000229a:	4501                	li	a0,0
    8000229c:	00000097          	auipc	ra,0x0
    800022a0:	e78080e7          	jalr	-392(ra) # 80002114 <argint>
    800022a4:	87aa                	mv	a5,a0
    return -1;
    800022a6:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    800022a8:	0207c063          	bltz	a5,800022c8 <sys_sbrk+0x3c>
  addr = myproc()->sz;
    800022ac:	fffff097          	auipc	ra,0xfffff
    800022b0:	d94080e7          	jalr	-620(ra) # 80001040 <myproc>
    800022b4:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    800022b6:	fdc42503          	lw	a0,-36(s0)
    800022ba:	fffff097          	auipc	ra,0xfffff
    800022be:	0e0080e7          	jalr	224(ra) # 8000139a <growproc>
    800022c2:	00054863          	bltz	a0,800022d2 <sys_sbrk+0x46>
    return -1;
  return addr;
    800022c6:	8526                	mv	a0,s1
}
    800022c8:	70a2                	ld	ra,40(sp)
    800022ca:	7402                	ld	s0,32(sp)
    800022cc:	64e2                	ld	s1,24(sp)
    800022ce:	6145                	addi	sp,sp,48
    800022d0:	8082                	ret
    return -1;
    800022d2:	557d                	li	a0,-1
    800022d4:	bfd5                	j	800022c8 <sys_sbrk+0x3c>

00000000800022d6 <sys_sleep>:

uint64
sys_sleep(void)
{
    800022d6:	7139                	addi	sp,sp,-64
    800022d8:	fc06                	sd	ra,56(sp)
    800022da:	f822                	sd	s0,48(sp)
    800022dc:	f426                	sd	s1,40(sp)
    800022de:	f04a                	sd	s2,32(sp)
    800022e0:	ec4e                	sd	s3,24(sp)
    800022e2:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    800022e4:	fcc40593          	addi	a1,s0,-52
    800022e8:	4501                	li	a0,0
    800022ea:	00000097          	auipc	ra,0x0
    800022ee:	e2a080e7          	jalr	-470(ra) # 80002114 <argint>
    return -1;
    800022f2:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800022f4:	06054563          	bltz	a0,8000235e <sys_sleep+0x88>
  acquire(&tickslock);
    800022f8:	0022d517          	auipc	a0,0x22d
    800022fc:	b8850513          	addi	a0,a0,-1144 # 8022ee80 <tickslock>
    80002300:	00004097          	auipc	ra,0x4
    80002304:	f38080e7          	jalr	-200(ra) # 80006238 <acquire>
  ticks0 = ticks;
    80002308:	00007917          	auipc	s2,0x7
    8000230c:	d1092903          	lw	s2,-752(s2) # 80009018 <ticks>
  while(ticks - ticks0 < n){
    80002310:	fcc42783          	lw	a5,-52(s0)
    80002314:	cf85                	beqz	a5,8000234c <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002316:	0022d997          	auipc	s3,0x22d
    8000231a:	b6a98993          	addi	s3,s3,-1174 # 8022ee80 <tickslock>
    8000231e:	00007497          	auipc	s1,0x7
    80002322:	cfa48493          	addi	s1,s1,-774 # 80009018 <ticks>
    if(myproc()->killed){
    80002326:	fffff097          	auipc	ra,0xfffff
    8000232a:	d1a080e7          	jalr	-742(ra) # 80001040 <myproc>
    8000232e:	551c                	lw	a5,40(a0)
    80002330:	ef9d                	bnez	a5,8000236e <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002332:	85ce                	mv	a1,s3
    80002334:	8526                	mv	a0,s1
    80002336:	fffff097          	auipc	ra,0xfffff
    8000233a:	3ce080e7          	jalr	974(ra) # 80001704 <sleep>
  while(ticks - ticks0 < n){
    8000233e:	409c                	lw	a5,0(s1)
    80002340:	412787bb          	subw	a5,a5,s2
    80002344:	fcc42703          	lw	a4,-52(s0)
    80002348:	fce7efe3          	bltu	a5,a4,80002326 <sys_sleep+0x50>
  }
  release(&tickslock);
    8000234c:	0022d517          	auipc	a0,0x22d
    80002350:	b3450513          	addi	a0,a0,-1228 # 8022ee80 <tickslock>
    80002354:	00004097          	auipc	ra,0x4
    80002358:	f98080e7          	jalr	-104(ra) # 800062ec <release>
  return 0;
    8000235c:	4781                	li	a5,0
}
    8000235e:	853e                	mv	a0,a5
    80002360:	70e2                	ld	ra,56(sp)
    80002362:	7442                	ld	s0,48(sp)
    80002364:	74a2                	ld	s1,40(sp)
    80002366:	7902                	ld	s2,32(sp)
    80002368:	69e2                	ld	s3,24(sp)
    8000236a:	6121                	addi	sp,sp,64
    8000236c:	8082                	ret
      release(&tickslock);
    8000236e:	0022d517          	auipc	a0,0x22d
    80002372:	b1250513          	addi	a0,a0,-1262 # 8022ee80 <tickslock>
    80002376:	00004097          	auipc	ra,0x4
    8000237a:	f76080e7          	jalr	-138(ra) # 800062ec <release>
      return -1;
    8000237e:	57fd                	li	a5,-1
    80002380:	bff9                	j	8000235e <sys_sleep+0x88>

0000000080002382 <sys_kill>:

uint64
sys_kill(void)
{
    80002382:	1101                	addi	sp,sp,-32
    80002384:	ec06                	sd	ra,24(sp)
    80002386:	e822                	sd	s0,16(sp)
    80002388:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    8000238a:	fec40593          	addi	a1,s0,-20
    8000238e:	4501                	li	a0,0
    80002390:	00000097          	auipc	ra,0x0
    80002394:	d84080e7          	jalr	-636(ra) # 80002114 <argint>
    80002398:	87aa                	mv	a5,a0
    return -1;
    8000239a:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    8000239c:	0007c863          	bltz	a5,800023ac <sys_kill+0x2a>
  return kill(pid);
    800023a0:	fec42503          	lw	a0,-20(s0)
    800023a4:	fffff097          	auipc	ra,0xfffff
    800023a8:	692080e7          	jalr	1682(ra) # 80001a36 <kill>
}
    800023ac:	60e2                	ld	ra,24(sp)
    800023ae:	6442                	ld	s0,16(sp)
    800023b0:	6105                	addi	sp,sp,32
    800023b2:	8082                	ret

00000000800023b4 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800023b4:	1101                	addi	sp,sp,-32
    800023b6:	ec06                	sd	ra,24(sp)
    800023b8:	e822                	sd	s0,16(sp)
    800023ba:	e426                	sd	s1,8(sp)
    800023bc:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800023be:	0022d517          	auipc	a0,0x22d
    800023c2:	ac250513          	addi	a0,a0,-1342 # 8022ee80 <tickslock>
    800023c6:	00004097          	auipc	ra,0x4
    800023ca:	e72080e7          	jalr	-398(ra) # 80006238 <acquire>
  xticks = ticks;
    800023ce:	00007497          	auipc	s1,0x7
    800023d2:	c4a4a483          	lw	s1,-950(s1) # 80009018 <ticks>
  release(&tickslock);
    800023d6:	0022d517          	auipc	a0,0x22d
    800023da:	aaa50513          	addi	a0,a0,-1366 # 8022ee80 <tickslock>
    800023de:	00004097          	auipc	ra,0x4
    800023e2:	f0e080e7          	jalr	-242(ra) # 800062ec <release>
  return xticks;
}
    800023e6:	02049513          	slli	a0,s1,0x20
    800023ea:	9101                	srli	a0,a0,0x20
    800023ec:	60e2                	ld	ra,24(sp)
    800023ee:	6442                	ld	s0,16(sp)
    800023f0:	64a2                	ld	s1,8(sp)
    800023f2:	6105                	addi	sp,sp,32
    800023f4:	8082                	ret

00000000800023f6 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    800023f6:	7179                	addi	sp,sp,-48
    800023f8:	f406                	sd	ra,40(sp)
    800023fa:	f022                	sd	s0,32(sp)
    800023fc:	ec26                	sd	s1,24(sp)
    800023fe:	e84a                	sd	s2,16(sp)
    80002400:	e44e                	sd	s3,8(sp)
    80002402:	e052                	sd	s4,0(sp)
    80002404:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002406:	00006597          	auipc	a1,0x6
    8000240a:	0a258593          	addi	a1,a1,162 # 800084a8 <syscalls+0xb0>
    8000240e:	0022d517          	auipc	a0,0x22d
    80002412:	a8a50513          	addi	a0,a0,-1398 # 8022ee98 <bcache>
    80002416:	00004097          	auipc	ra,0x4
    8000241a:	d92080e7          	jalr	-622(ra) # 800061a8 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    8000241e:	00235797          	auipc	a5,0x235
    80002422:	a7a78793          	addi	a5,a5,-1414 # 80236e98 <bcache+0x8000>
    80002426:	00235717          	auipc	a4,0x235
    8000242a:	cda70713          	addi	a4,a4,-806 # 80237100 <bcache+0x8268>
    8000242e:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002432:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002436:	0022d497          	auipc	s1,0x22d
    8000243a:	a7a48493          	addi	s1,s1,-1414 # 8022eeb0 <bcache+0x18>
    b->next = bcache.head.next;
    8000243e:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002440:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002442:	00006a17          	auipc	s4,0x6
    80002446:	06ea0a13          	addi	s4,s4,110 # 800084b0 <syscalls+0xb8>
    b->next = bcache.head.next;
    8000244a:	2b893783          	ld	a5,696(s2)
    8000244e:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002450:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002454:	85d2                	mv	a1,s4
    80002456:	01048513          	addi	a0,s1,16
    8000245a:	00001097          	auipc	ra,0x1
    8000245e:	4c2080e7          	jalr	1218(ra) # 8000391c <initsleeplock>
    bcache.head.next->prev = b;
    80002462:	2b893783          	ld	a5,696(s2)
    80002466:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002468:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000246c:	45848493          	addi	s1,s1,1112
    80002470:	fd349de3          	bne	s1,s3,8000244a <binit+0x54>
  }
}
    80002474:	70a2                	ld	ra,40(sp)
    80002476:	7402                	ld	s0,32(sp)
    80002478:	64e2                	ld	s1,24(sp)
    8000247a:	6942                	ld	s2,16(sp)
    8000247c:	69a2                	ld	s3,8(sp)
    8000247e:	6a02                	ld	s4,0(sp)
    80002480:	6145                	addi	sp,sp,48
    80002482:	8082                	ret

0000000080002484 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002484:	7179                	addi	sp,sp,-48
    80002486:	f406                	sd	ra,40(sp)
    80002488:	f022                	sd	s0,32(sp)
    8000248a:	ec26                	sd	s1,24(sp)
    8000248c:	e84a                	sd	s2,16(sp)
    8000248e:	e44e                	sd	s3,8(sp)
    80002490:	1800                	addi	s0,sp,48
    80002492:	892a                	mv	s2,a0
    80002494:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002496:	0022d517          	auipc	a0,0x22d
    8000249a:	a0250513          	addi	a0,a0,-1534 # 8022ee98 <bcache>
    8000249e:	00004097          	auipc	ra,0x4
    800024a2:	d9a080e7          	jalr	-614(ra) # 80006238 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800024a6:	00235497          	auipc	s1,0x235
    800024aa:	caa4b483          	ld	s1,-854(s1) # 80237150 <bcache+0x82b8>
    800024ae:	00235797          	auipc	a5,0x235
    800024b2:	c5278793          	addi	a5,a5,-942 # 80237100 <bcache+0x8268>
    800024b6:	02f48f63          	beq	s1,a5,800024f4 <bread+0x70>
    800024ba:	873e                	mv	a4,a5
    800024bc:	a021                	j	800024c4 <bread+0x40>
    800024be:	68a4                	ld	s1,80(s1)
    800024c0:	02e48a63          	beq	s1,a4,800024f4 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    800024c4:	449c                	lw	a5,8(s1)
    800024c6:	ff279ce3          	bne	a5,s2,800024be <bread+0x3a>
    800024ca:	44dc                	lw	a5,12(s1)
    800024cc:	ff3799e3          	bne	a5,s3,800024be <bread+0x3a>
      b->refcnt++;
    800024d0:	40bc                	lw	a5,64(s1)
    800024d2:	2785                	addiw	a5,a5,1
    800024d4:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800024d6:	0022d517          	auipc	a0,0x22d
    800024da:	9c250513          	addi	a0,a0,-1598 # 8022ee98 <bcache>
    800024de:	00004097          	auipc	ra,0x4
    800024e2:	e0e080e7          	jalr	-498(ra) # 800062ec <release>
      acquiresleep(&b->lock);
    800024e6:	01048513          	addi	a0,s1,16
    800024ea:	00001097          	auipc	ra,0x1
    800024ee:	46c080e7          	jalr	1132(ra) # 80003956 <acquiresleep>
      return b;
    800024f2:	a8b9                	j	80002550 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800024f4:	00235497          	auipc	s1,0x235
    800024f8:	c544b483          	ld	s1,-940(s1) # 80237148 <bcache+0x82b0>
    800024fc:	00235797          	auipc	a5,0x235
    80002500:	c0478793          	addi	a5,a5,-1020 # 80237100 <bcache+0x8268>
    80002504:	00f48863          	beq	s1,a5,80002514 <bread+0x90>
    80002508:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8000250a:	40bc                	lw	a5,64(s1)
    8000250c:	cf81                	beqz	a5,80002524 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000250e:	64a4                	ld	s1,72(s1)
    80002510:	fee49de3          	bne	s1,a4,8000250a <bread+0x86>
  panic("bget: no buffers");
    80002514:	00006517          	auipc	a0,0x6
    80002518:	fa450513          	addi	a0,a0,-92 # 800084b8 <syscalls+0xc0>
    8000251c:	00003097          	auipc	ra,0x3
    80002520:	7e4080e7          	jalr	2020(ra) # 80005d00 <panic>
      b->dev = dev;
    80002524:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002528:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    8000252c:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002530:	4785                	li	a5,1
    80002532:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002534:	0022d517          	auipc	a0,0x22d
    80002538:	96450513          	addi	a0,a0,-1692 # 8022ee98 <bcache>
    8000253c:	00004097          	auipc	ra,0x4
    80002540:	db0080e7          	jalr	-592(ra) # 800062ec <release>
      acquiresleep(&b->lock);
    80002544:	01048513          	addi	a0,s1,16
    80002548:	00001097          	auipc	ra,0x1
    8000254c:	40e080e7          	jalr	1038(ra) # 80003956 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002550:	409c                	lw	a5,0(s1)
    80002552:	cb89                	beqz	a5,80002564 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002554:	8526                	mv	a0,s1
    80002556:	70a2                	ld	ra,40(sp)
    80002558:	7402                	ld	s0,32(sp)
    8000255a:	64e2                	ld	s1,24(sp)
    8000255c:	6942                	ld	s2,16(sp)
    8000255e:	69a2                	ld	s3,8(sp)
    80002560:	6145                	addi	sp,sp,48
    80002562:	8082                	ret
    virtio_disk_rw(b, 0);
    80002564:	4581                	li	a1,0
    80002566:	8526                	mv	a0,s1
    80002568:	00003097          	auipc	ra,0x3
    8000256c:	f2a080e7          	jalr	-214(ra) # 80005492 <virtio_disk_rw>
    b->valid = 1;
    80002570:	4785                	li	a5,1
    80002572:	c09c                	sw	a5,0(s1)
  return b;
    80002574:	b7c5                	j	80002554 <bread+0xd0>

0000000080002576 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002576:	1101                	addi	sp,sp,-32
    80002578:	ec06                	sd	ra,24(sp)
    8000257a:	e822                	sd	s0,16(sp)
    8000257c:	e426                	sd	s1,8(sp)
    8000257e:	1000                	addi	s0,sp,32
    80002580:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002582:	0541                	addi	a0,a0,16
    80002584:	00001097          	auipc	ra,0x1
    80002588:	46c080e7          	jalr	1132(ra) # 800039f0 <holdingsleep>
    8000258c:	cd01                	beqz	a0,800025a4 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    8000258e:	4585                	li	a1,1
    80002590:	8526                	mv	a0,s1
    80002592:	00003097          	auipc	ra,0x3
    80002596:	f00080e7          	jalr	-256(ra) # 80005492 <virtio_disk_rw>
}
    8000259a:	60e2                	ld	ra,24(sp)
    8000259c:	6442                	ld	s0,16(sp)
    8000259e:	64a2                	ld	s1,8(sp)
    800025a0:	6105                	addi	sp,sp,32
    800025a2:	8082                	ret
    panic("bwrite");
    800025a4:	00006517          	auipc	a0,0x6
    800025a8:	f2c50513          	addi	a0,a0,-212 # 800084d0 <syscalls+0xd8>
    800025ac:	00003097          	auipc	ra,0x3
    800025b0:	754080e7          	jalr	1876(ra) # 80005d00 <panic>

00000000800025b4 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800025b4:	1101                	addi	sp,sp,-32
    800025b6:	ec06                	sd	ra,24(sp)
    800025b8:	e822                	sd	s0,16(sp)
    800025ba:	e426                	sd	s1,8(sp)
    800025bc:	e04a                	sd	s2,0(sp)
    800025be:	1000                	addi	s0,sp,32
    800025c0:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800025c2:	01050913          	addi	s2,a0,16
    800025c6:	854a                	mv	a0,s2
    800025c8:	00001097          	auipc	ra,0x1
    800025cc:	428080e7          	jalr	1064(ra) # 800039f0 <holdingsleep>
    800025d0:	c92d                	beqz	a0,80002642 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    800025d2:	854a                	mv	a0,s2
    800025d4:	00001097          	auipc	ra,0x1
    800025d8:	3d8080e7          	jalr	984(ra) # 800039ac <releasesleep>

  acquire(&bcache.lock);
    800025dc:	0022d517          	auipc	a0,0x22d
    800025e0:	8bc50513          	addi	a0,a0,-1860 # 8022ee98 <bcache>
    800025e4:	00004097          	auipc	ra,0x4
    800025e8:	c54080e7          	jalr	-940(ra) # 80006238 <acquire>
  b->refcnt--;
    800025ec:	40bc                	lw	a5,64(s1)
    800025ee:	37fd                	addiw	a5,a5,-1
    800025f0:	0007871b          	sext.w	a4,a5
    800025f4:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800025f6:	eb05                	bnez	a4,80002626 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800025f8:	68bc                	ld	a5,80(s1)
    800025fa:	64b8                	ld	a4,72(s1)
    800025fc:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    800025fe:	64bc                	ld	a5,72(s1)
    80002600:	68b8                	ld	a4,80(s1)
    80002602:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002604:	00235797          	auipc	a5,0x235
    80002608:	89478793          	addi	a5,a5,-1900 # 80236e98 <bcache+0x8000>
    8000260c:	2b87b703          	ld	a4,696(a5)
    80002610:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002612:	00235717          	auipc	a4,0x235
    80002616:	aee70713          	addi	a4,a4,-1298 # 80237100 <bcache+0x8268>
    8000261a:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    8000261c:	2b87b703          	ld	a4,696(a5)
    80002620:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002622:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    80002626:	0022d517          	auipc	a0,0x22d
    8000262a:	87250513          	addi	a0,a0,-1934 # 8022ee98 <bcache>
    8000262e:	00004097          	auipc	ra,0x4
    80002632:	cbe080e7          	jalr	-834(ra) # 800062ec <release>
}
    80002636:	60e2                	ld	ra,24(sp)
    80002638:	6442                	ld	s0,16(sp)
    8000263a:	64a2                	ld	s1,8(sp)
    8000263c:	6902                	ld	s2,0(sp)
    8000263e:	6105                	addi	sp,sp,32
    80002640:	8082                	ret
    panic("brelse");
    80002642:	00006517          	auipc	a0,0x6
    80002646:	e9650513          	addi	a0,a0,-362 # 800084d8 <syscalls+0xe0>
    8000264a:	00003097          	auipc	ra,0x3
    8000264e:	6b6080e7          	jalr	1718(ra) # 80005d00 <panic>

0000000080002652 <bpin>:

void
bpin(struct buf *b) {
    80002652:	1101                	addi	sp,sp,-32
    80002654:	ec06                	sd	ra,24(sp)
    80002656:	e822                	sd	s0,16(sp)
    80002658:	e426                	sd	s1,8(sp)
    8000265a:	1000                	addi	s0,sp,32
    8000265c:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000265e:	0022d517          	auipc	a0,0x22d
    80002662:	83a50513          	addi	a0,a0,-1990 # 8022ee98 <bcache>
    80002666:	00004097          	auipc	ra,0x4
    8000266a:	bd2080e7          	jalr	-1070(ra) # 80006238 <acquire>
  b->refcnt++;
    8000266e:	40bc                	lw	a5,64(s1)
    80002670:	2785                	addiw	a5,a5,1
    80002672:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002674:	0022d517          	auipc	a0,0x22d
    80002678:	82450513          	addi	a0,a0,-2012 # 8022ee98 <bcache>
    8000267c:	00004097          	auipc	ra,0x4
    80002680:	c70080e7          	jalr	-912(ra) # 800062ec <release>
}
    80002684:	60e2                	ld	ra,24(sp)
    80002686:	6442                	ld	s0,16(sp)
    80002688:	64a2                	ld	s1,8(sp)
    8000268a:	6105                	addi	sp,sp,32
    8000268c:	8082                	ret

000000008000268e <bunpin>:

void
bunpin(struct buf *b) {
    8000268e:	1101                	addi	sp,sp,-32
    80002690:	ec06                	sd	ra,24(sp)
    80002692:	e822                	sd	s0,16(sp)
    80002694:	e426                	sd	s1,8(sp)
    80002696:	1000                	addi	s0,sp,32
    80002698:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000269a:	0022c517          	auipc	a0,0x22c
    8000269e:	7fe50513          	addi	a0,a0,2046 # 8022ee98 <bcache>
    800026a2:	00004097          	auipc	ra,0x4
    800026a6:	b96080e7          	jalr	-1130(ra) # 80006238 <acquire>
  b->refcnt--;
    800026aa:	40bc                	lw	a5,64(s1)
    800026ac:	37fd                	addiw	a5,a5,-1
    800026ae:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800026b0:	0022c517          	auipc	a0,0x22c
    800026b4:	7e850513          	addi	a0,a0,2024 # 8022ee98 <bcache>
    800026b8:	00004097          	auipc	ra,0x4
    800026bc:	c34080e7          	jalr	-972(ra) # 800062ec <release>
}
    800026c0:	60e2                	ld	ra,24(sp)
    800026c2:	6442                	ld	s0,16(sp)
    800026c4:	64a2                	ld	s1,8(sp)
    800026c6:	6105                	addi	sp,sp,32
    800026c8:	8082                	ret

00000000800026ca <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800026ca:	1101                	addi	sp,sp,-32
    800026cc:	ec06                	sd	ra,24(sp)
    800026ce:	e822                	sd	s0,16(sp)
    800026d0:	e426                	sd	s1,8(sp)
    800026d2:	e04a                	sd	s2,0(sp)
    800026d4:	1000                	addi	s0,sp,32
    800026d6:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800026d8:	00d5d59b          	srliw	a1,a1,0xd
    800026dc:	00235797          	auipc	a5,0x235
    800026e0:	e987a783          	lw	a5,-360(a5) # 80237574 <sb+0x1c>
    800026e4:	9dbd                	addw	a1,a1,a5
    800026e6:	00000097          	auipc	ra,0x0
    800026ea:	d9e080e7          	jalr	-610(ra) # 80002484 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800026ee:	0074f713          	andi	a4,s1,7
    800026f2:	4785                	li	a5,1
    800026f4:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800026f8:	14ce                	slli	s1,s1,0x33
    800026fa:	90d9                	srli	s1,s1,0x36
    800026fc:	00950733          	add	a4,a0,s1
    80002700:	05874703          	lbu	a4,88(a4)
    80002704:	00e7f6b3          	and	a3,a5,a4
    80002708:	c69d                	beqz	a3,80002736 <bfree+0x6c>
    8000270a:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    8000270c:	94aa                	add	s1,s1,a0
    8000270e:	fff7c793          	not	a5,a5
    80002712:	8f7d                	and	a4,a4,a5
    80002714:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    80002718:	00001097          	auipc	ra,0x1
    8000271c:	120080e7          	jalr	288(ra) # 80003838 <log_write>
  brelse(bp);
    80002720:	854a                	mv	a0,s2
    80002722:	00000097          	auipc	ra,0x0
    80002726:	e92080e7          	jalr	-366(ra) # 800025b4 <brelse>
}
    8000272a:	60e2                	ld	ra,24(sp)
    8000272c:	6442                	ld	s0,16(sp)
    8000272e:	64a2                	ld	s1,8(sp)
    80002730:	6902                	ld	s2,0(sp)
    80002732:	6105                	addi	sp,sp,32
    80002734:	8082                	ret
    panic("freeing free block");
    80002736:	00006517          	auipc	a0,0x6
    8000273a:	daa50513          	addi	a0,a0,-598 # 800084e0 <syscalls+0xe8>
    8000273e:	00003097          	auipc	ra,0x3
    80002742:	5c2080e7          	jalr	1474(ra) # 80005d00 <panic>

0000000080002746 <balloc>:
{
    80002746:	711d                	addi	sp,sp,-96
    80002748:	ec86                	sd	ra,88(sp)
    8000274a:	e8a2                	sd	s0,80(sp)
    8000274c:	e4a6                	sd	s1,72(sp)
    8000274e:	e0ca                	sd	s2,64(sp)
    80002750:	fc4e                	sd	s3,56(sp)
    80002752:	f852                	sd	s4,48(sp)
    80002754:	f456                	sd	s5,40(sp)
    80002756:	f05a                	sd	s6,32(sp)
    80002758:	ec5e                	sd	s7,24(sp)
    8000275a:	e862                	sd	s8,16(sp)
    8000275c:	e466                	sd	s9,8(sp)
    8000275e:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002760:	00235797          	auipc	a5,0x235
    80002764:	dfc7a783          	lw	a5,-516(a5) # 8023755c <sb+0x4>
    80002768:	cbc1                	beqz	a5,800027f8 <balloc+0xb2>
    8000276a:	8baa                	mv	s7,a0
    8000276c:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    8000276e:	00235b17          	auipc	s6,0x235
    80002772:	deab0b13          	addi	s6,s6,-534 # 80237558 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002776:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80002778:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000277a:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    8000277c:	6c89                	lui	s9,0x2
    8000277e:	a831                	j	8000279a <balloc+0x54>
    brelse(bp);
    80002780:	854a                	mv	a0,s2
    80002782:	00000097          	auipc	ra,0x0
    80002786:	e32080e7          	jalr	-462(ra) # 800025b4 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000278a:	015c87bb          	addw	a5,s9,s5
    8000278e:	00078a9b          	sext.w	s5,a5
    80002792:	004b2703          	lw	a4,4(s6)
    80002796:	06eaf163          	bgeu	s5,a4,800027f8 <balloc+0xb2>
    bp = bread(dev, BBLOCK(b, sb));
    8000279a:	41fad79b          	sraiw	a5,s5,0x1f
    8000279e:	0137d79b          	srliw	a5,a5,0x13
    800027a2:	015787bb          	addw	a5,a5,s5
    800027a6:	40d7d79b          	sraiw	a5,a5,0xd
    800027aa:	01cb2583          	lw	a1,28(s6)
    800027ae:	9dbd                	addw	a1,a1,a5
    800027b0:	855e                	mv	a0,s7
    800027b2:	00000097          	auipc	ra,0x0
    800027b6:	cd2080e7          	jalr	-814(ra) # 80002484 <bread>
    800027ba:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800027bc:	004b2503          	lw	a0,4(s6)
    800027c0:	000a849b          	sext.w	s1,s5
    800027c4:	8762                	mv	a4,s8
    800027c6:	faa4fde3          	bgeu	s1,a0,80002780 <balloc+0x3a>
      m = 1 << (bi % 8);
    800027ca:	00777693          	andi	a3,a4,7
    800027ce:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800027d2:	41f7579b          	sraiw	a5,a4,0x1f
    800027d6:	01d7d79b          	srliw	a5,a5,0x1d
    800027da:	9fb9                	addw	a5,a5,a4
    800027dc:	4037d79b          	sraiw	a5,a5,0x3
    800027e0:	00f90633          	add	a2,s2,a5
    800027e4:	05864603          	lbu	a2,88(a2)
    800027e8:	00c6f5b3          	and	a1,a3,a2
    800027ec:	cd91                	beqz	a1,80002808 <balloc+0xc2>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800027ee:	2705                	addiw	a4,a4,1
    800027f0:	2485                	addiw	s1,s1,1
    800027f2:	fd471ae3          	bne	a4,s4,800027c6 <balloc+0x80>
    800027f6:	b769                	j	80002780 <balloc+0x3a>
  panic("balloc: out of blocks");
    800027f8:	00006517          	auipc	a0,0x6
    800027fc:	d0050513          	addi	a0,a0,-768 # 800084f8 <syscalls+0x100>
    80002800:	00003097          	auipc	ra,0x3
    80002804:	500080e7          	jalr	1280(ra) # 80005d00 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002808:	97ca                	add	a5,a5,s2
    8000280a:	8e55                	or	a2,a2,a3
    8000280c:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    80002810:	854a                	mv	a0,s2
    80002812:	00001097          	auipc	ra,0x1
    80002816:	026080e7          	jalr	38(ra) # 80003838 <log_write>
        brelse(bp);
    8000281a:	854a                	mv	a0,s2
    8000281c:	00000097          	auipc	ra,0x0
    80002820:	d98080e7          	jalr	-616(ra) # 800025b4 <brelse>
  bp = bread(dev, bno);
    80002824:	85a6                	mv	a1,s1
    80002826:	855e                	mv	a0,s7
    80002828:	00000097          	auipc	ra,0x0
    8000282c:	c5c080e7          	jalr	-932(ra) # 80002484 <bread>
    80002830:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80002832:	40000613          	li	a2,1024
    80002836:	4581                	li	a1,0
    80002838:	05850513          	addi	a0,a0,88
    8000283c:	ffffe097          	auipc	ra,0xffffe
    80002840:	a80080e7          	jalr	-1408(ra) # 800002bc <memset>
  log_write(bp);
    80002844:	854a                	mv	a0,s2
    80002846:	00001097          	auipc	ra,0x1
    8000284a:	ff2080e7          	jalr	-14(ra) # 80003838 <log_write>
  brelse(bp);
    8000284e:	854a                	mv	a0,s2
    80002850:	00000097          	auipc	ra,0x0
    80002854:	d64080e7          	jalr	-668(ra) # 800025b4 <brelse>
}
    80002858:	8526                	mv	a0,s1
    8000285a:	60e6                	ld	ra,88(sp)
    8000285c:	6446                	ld	s0,80(sp)
    8000285e:	64a6                	ld	s1,72(sp)
    80002860:	6906                	ld	s2,64(sp)
    80002862:	79e2                	ld	s3,56(sp)
    80002864:	7a42                	ld	s4,48(sp)
    80002866:	7aa2                	ld	s5,40(sp)
    80002868:	7b02                	ld	s6,32(sp)
    8000286a:	6be2                	ld	s7,24(sp)
    8000286c:	6c42                	ld	s8,16(sp)
    8000286e:	6ca2                	ld	s9,8(sp)
    80002870:	6125                	addi	sp,sp,96
    80002872:	8082                	ret

0000000080002874 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80002874:	7179                	addi	sp,sp,-48
    80002876:	f406                	sd	ra,40(sp)
    80002878:	f022                	sd	s0,32(sp)
    8000287a:	ec26                	sd	s1,24(sp)
    8000287c:	e84a                	sd	s2,16(sp)
    8000287e:	e44e                	sd	s3,8(sp)
    80002880:	e052                	sd	s4,0(sp)
    80002882:	1800                	addi	s0,sp,48
    80002884:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002886:	47ad                	li	a5,11
    80002888:	04b7fe63          	bgeu	a5,a1,800028e4 <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    8000288c:	ff45849b          	addiw	s1,a1,-12
    80002890:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    80002894:	0ff00793          	li	a5,255
    80002898:	0ae7e463          	bltu	a5,a4,80002940 <bmap+0xcc>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    8000289c:	08052583          	lw	a1,128(a0)
    800028a0:	c5b5                	beqz	a1,8000290c <bmap+0x98>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    800028a2:	00092503          	lw	a0,0(s2)
    800028a6:	00000097          	auipc	ra,0x0
    800028aa:	bde080e7          	jalr	-1058(ra) # 80002484 <bread>
    800028ae:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    800028b0:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    800028b4:	02049713          	slli	a4,s1,0x20
    800028b8:	01e75593          	srli	a1,a4,0x1e
    800028bc:	00b784b3          	add	s1,a5,a1
    800028c0:	0004a983          	lw	s3,0(s1)
    800028c4:	04098e63          	beqz	s3,80002920 <bmap+0xac>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    800028c8:	8552                	mv	a0,s4
    800028ca:	00000097          	auipc	ra,0x0
    800028ce:	cea080e7          	jalr	-790(ra) # 800025b4 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    800028d2:	854e                	mv	a0,s3
    800028d4:	70a2                	ld	ra,40(sp)
    800028d6:	7402                	ld	s0,32(sp)
    800028d8:	64e2                	ld	s1,24(sp)
    800028da:	6942                	ld	s2,16(sp)
    800028dc:	69a2                	ld	s3,8(sp)
    800028de:	6a02                	ld	s4,0(sp)
    800028e0:	6145                	addi	sp,sp,48
    800028e2:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    800028e4:	02059793          	slli	a5,a1,0x20
    800028e8:	01e7d593          	srli	a1,a5,0x1e
    800028ec:	00b504b3          	add	s1,a0,a1
    800028f0:	0504a983          	lw	s3,80(s1)
    800028f4:	fc099fe3          	bnez	s3,800028d2 <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    800028f8:	4108                	lw	a0,0(a0)
    800028fa:	00000097          	auipc	ra,0x0
    800028fe:	e4c080e7          	jalr	-436(ra) # 80002746 <balloc>
    80002902:	0005099b          	sext.w	s3,a0
    80002906:	0534a823          	sw	s3,80(s1)
    8000290a:	b7e1                	j	800028d2 <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    8000290c:	4108                	lw	a0,0(a0)
    8000290e:	00000097          	auipc	ra,0x0
    80002912:	e38080e7          	jalr	-456(ra) # 80002746 <balloc>
    80002916:	0005059b          	sext.w	a1,a0
    8000291a:	08b92023          	sw	a1,128(s2)
    8000291e:	b751                	j	800028a2 <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    80002920:	00092503          	lw	a0,0(s2)
    80002924:	00000097          	auipc	ra,0x0
    80002928:	e22080e7          	jalr	-478(ra) # 80002746 <balloc>
    8000292c:	0005099b          	sext.w	s3,a0
    80002930:	0134a023          	sw	s3,0(s1)
      log_write(bp);
    80002934:	8552                	mv	a0,s4
    80002936:	00001097          	auipc	ra,0x1
    8000293a:	f02080e7          	jalr	-254(ra) # 80003838 <log_write>
    8000293e:	b769                	j	800028c8 <bmap+0x54>
  panic("bmap: out of range");
    80002940:	00006517          	auipc	a0,0x6
    80002944:	bd050513          	addi	a0,a0,-1072 # 80008510 <syscalls+0x118>
    80002948:	00003097          	auipc	ra,0x3
    8000294c:	3b8080e7          	jalr	952(ra) # 80005d00 <panic>

0000000080002950 <iget>:
{
    80002950:	7179                	addi	sp,sp,-48
    80002952:	f406                	sd	ra,40(sp)
    80002954:	f022                	sd	s0,32(sp)
    80002956:	ec26                	sd	s1,24(sp)
    80002958:	e84a                	sd	s2,16(sp)
    8000295a:	e44e                	sd	s3,8(sp)
    8000295c:	e052                	sd	s4,0(sp)
    8000295e:	1800                	addi	s0,sp,48
    80002960:	89aa                	mv	s3,a0
    80002962:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002964:	00235517          	auipc	a0,0x235
    80002968:	c1450513          	addi	a0,a0,-1004 # 80237578 <itable>
    8000296c:	00004097          	auipc	ra,0x4
    80002970:	8cc080e7          	jalr	-1844(ra) # 80006238 <acquire>
  empty = 0;
    80002974:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002976:	00235497          	auipc	s1,0x235
    8000297a:	c1a48493          	addi	s1,s1,-998 # 80237590 <itable+0x18>
    8000297e:	00236697          	auipc	a3,0x236
    80002982:	6a268693          	addi	a3,a3,1698 # 80239020 <log>
    80002986:	a039                	j	80002994 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002988:	02090b63          	beqz	s2,800029be <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000298c:	08848493          	addi	s1,s1,136
    80002990:	02d48a63          	beq	s1,a3,800029c4 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002994:	449c                	lw	a5,8(s1)
    80002996:	fef059e3          	blez	a5,80002988 <iget+0x38>
    8000299a:	4098                	lw	a4,0(s1)
    8000299c:	ff3716e3          	bne	a4,s3,80002988 <iget+0x38>
    800029a0:	40d8                	lw	a4,4(s1)
    800029a2:	ff4713e3          	bne	a4,s4,80002988 <iget+0x38>
      ip->ref++;
    800029a6:	2785                	addiw	a5,a5,1
    800029a8:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800029aa:	00235517          	auipc	a0,0x235
    800029ae:	bce50513          	addi	a0,a0,-1074 # 80237578 <itable>
    800029b2:	00004097          	auipc	ra,0x4
    800029b6:	93a080e7          	jalr	-1734(ra) # 800062ec <release>
      return ip;
    800029ba:	8926                	mv	s2,s1
    800029bc:	a03d                	j	800029ea <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800029be:	f7f9                	bnez	a5,8000298c <iget+0x3c>
    800029c0:	8926                	mv	s2,s1
    800029c2:	b7e9                	j	8000298c <iget+0x3c>
  if(empty == 0)
    800029c4:	02090c63          	beqz	s2,800029fc <iget+0xac>
  ip->dev = dev;
    800029c8:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800029cc:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800029d0:	4785                	li	a5,1
    800029d2:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    800029d6:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    800029da:	00235517          	auipc	a0,0x235
    800029de:	b9e50513          	addi	a0,a0,-1122 # 80237578 <itable>
    800029e2:	00004097          	auipc	ra,0x4
    800029e6:	90a080e7          	jalr	-1782(ra) # 800062ec <release>
}
    800029ea:	854a                	mv	a0,s2
    800029ec:	70a2                	ld	ra,40(sp)
    800029ee:	7402                	ld	s0,32(sp)
    800029f0:	64e2                	ld	s1,24(sp)
    800029f2:	6942                	ld	s2,16(sp)
    800029f4:	69a2                	ld	s3,8(sp)
    800029f6:	6a02                	ld	s4,0(sp)
    800029f8:	6145                	addi	sp,sp,48
    800029fa:	8082                	ret
    panic("iget: no inodes");
    800029fc:	00006517          	auipc	a0,0x6
    80002a00:	b2c50513          	addi	a0,a0,-1236 # 80008528 <syscalls+0x130>
    80002a04:	00003097          	auipc	ra,0x3
    80002a08:	2fc080e7          	jalr	764(ra) # 80005d00 <panic>

0000000080002a0c <fsinit>:
fsinit(int dev) {
    80002a0c:	7179                	addi	sp,sp,-48
    80002a0e:	f406                	sd	ra,40(sp)
    80002a10:	f022                	sd	s0,32(sp)
    80002a12:	ec26                	sd	s1,24(sp)
    80002a14:	e84a                	sd	s2,16(sp)
    80002a16:	e44e                	sd	s3,8(sp)
    80002a18:	1800                	addi	s0,sp,48
    80002a1a:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002a1c:	4585                	li	a1,1
    80002a1e:	00000097          	auipc	ra,0x0
    80002a22:	a66080e7          	jalr	-1434(ra) # 80002484 <bread>
    80002a26:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002a28:	00235997          	auipc	s3,0x235
    80002a2c:	b3098993          	addi	s3,s3,-1232 # 80237558 <sb>
    80002a30:	02000613          	li	a2,32
    80002a34:	05850593          	addi	a1,a0,88
    80002a38:	854e                	mv	a0,s3
    80002a3a:	ffffe097          	auipc	ra,0xffffe
    80002a3e:	8de080e7          	jalr	-1826(ra) # 80000318 <memmove>
  brelse(bp);
    80002a42:	8526                	mv	a0,s1
    80002a44:	00000097          	auipc	ra,0x0
    80002a48:	b70080e7          	jalr	-1168(ra) # 800025b4 <brelse>
  if(sb.magic != FSMAGIC)
    80002a4c:	0009a703          	lw	a4,0(s3)
    80002a50:	102037b7          	lui	a5,0x10203
    80002a54:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002a58:	02f71263          	bne	a4,a5,80002a7c <fsinit+0x70>
  initlog(dev, &sb);
    80002a5c:	00235597          	auipc	a1,0x235
    80002a60:	afc58593          	addi	a1,a1,-1284 # 80237558 <sb>
    80002a64:	854a                	mv	a0,s2
    80002a66:	00001097          	auipc	ra,0x1
    80002a6a:	b56080e7          	jalr	-1194(ra) # 800035bc <initlog>
}
    80002a6e:	70a2                	ld	ra,40(sp)
    80002a70:	7402                	ld	s0,32(sp)
    80002a72:	64e2                	ld	s1,24(sp)
    80002a74:	6942                	ld	s2,16(sp)
    80002a76:	69a2                	ld	s3,8(sp)
    80002a78:	6145                	addi	sp,sp,48
    80002a7a:	8082                	ret
    panic("invalid file system");
    80002a7c:	00006517          	auipc	a0,0x6
    80002a80:	abc50513          	addi	a0,a0,-1348 # 80008538 <syscalls+0x140>
    80002a84:	00003097          	auipc	ra,0x3
    80002a88:	27c080e7          	jalr	636(ra) # 80005d00 <panic>

0000000080002a8c <iinit>:
{
    80002a8c:	7179                	addi	sp,sp,-48
    80002a8e:	f406                	sd	ra,40(sp)
    80002a90:	f022                	sd	s0,32(sp)
    80002a92:	ec26                	sd	s1,24(sp)
    80002a94:	e84a                	sd	s2,16(sp)
    80002a96:	e44e                	sd	s3,8(sp)
    80002a98:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002a9a:	00006597          	auipc	a1,0x6
    80002a9e:	ab658593          	addi	a1,a1,-1354 # 80008550 <syscalls+0x158>
    80002aa2:	00235517          	auipc	a0,0x235
    80002aa6:	ad650513          	addi	a0,a0,-1322 # 80237578 <itable>
    80002aaa:	00003097          	auipc	ra,0x3
    80002aae:	6fe080e7          	jalr	1790(ra) # 800061a8 <initlock>
  for(i = 0; i < NINODE; i++) {
    80002ab2:	00235497          	auipc	s1,0x235
    80002ab6:	aee48493          	addi	s1,s1,-1298 # 802375a0 <itable+0x28>
    80002aba:	00236997          	auipc	s3,0x236
    80002abe:	57698993          	addi	s3,s3,1398 # 80239030 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002ac2:	00006917          	auipc	s2,0x6
    80002ac6:	a9690913          	addi	s2,s2,-1386 # 80008558 <syscalls+0x160>
    80002aca:	85ca                	mv	a1,s2
    80002acc:	8526                	mv	a0,s1
    80002ace:	00001097          	auipc	ra,0x1
    80002ad2:	e4e080e7          	jalr	-434(ra) # 8000391c <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002ad6:	08848493          	addi	s1,s1,136
    80002ada:	ff3498e3          	bne	s1,s3,80002aca <iinit+0x3e>
}
    80002ade:	70a2                	ld	ra,40(sp)
    80002ae0:	7402                	ld	s0,32(sp)
    80002ae2:	64e2                	ld	s1,24(sp)
    80002ae4:	6942                	ld	s2,16(sp)
    80002ae6:	69a2                	ld	s3,8(sp)
    80002ae8:	6145                	addi	sp,sp,48
    80002aea:	8082                	ret

0000000080002aec <ialloc>:
{
    80002aec:	715d                	addi	sp,sp,-80
    80002aee:	e486                	sd	ra,72(sp)
    80002af0:	e0a2                	sd	s0,64(sp)
    80002af2:	fc26                	sd	s1,56(sp)
    80002af4:	f84a                	sd	s2,48(sp)
    80002af6:	f44e                	sd	s3,40(sp)
    80002af8:	f052                	sd	s4,32(sp)
    80002afa:	ec56                	sd	s5,24(sp)
    80002afc:	e85a                	sd	s6,16(sp)
    80002afe:	e45e                	sd	s7,8(sp)
    80002b00:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80002b02:	00235717          	auipc	a4,0x235
    80002b06:	a6272703          	lw	a4,-1438(a4) # 80237564 <sb+0xc>
    80002b0a:	4785                	li	a5,1
    80002b0c:	04e7fa63          	bgeu	a5,a4,80002b60 <ialloc+0x74>
    80002b10:	8aaa                	mv	s5,a0
    80002b12:	8bae                	mv	s7,a1
    80002b14:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002b16:	00235a17          	auipc	s4,0x235
    80002b1a:	a42a0a13          	addi	s4,s4,-1470 # 80237558 <sb>
    80002b1e:	00048b1b          	sext.w	s6,s1
    80002b22:	0044d593          	srli	a1,s1,0x4
    80002b26:	018a2783          	lw	a5,24(s4)
    80002b2a:	9dbd                	addw	a1,a1,a5
    80002b2c:	8556                	mv	a0,s5
    80002b2e:	00000097          	auipc	ra,0x0
    80002b32:	956080e7          	jalr	-1706(ra) # 80002484 <bread>
    80002b36:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002b38:	05850993          	addi	s3,a0,88
    80002b3c:	00f4f793          	andi	a5,s1,15
    80002b40:	079a                	slli	a5,a5,0x6
    80002b42:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002b44:	00099783          	lh	a5,0(s3)
    80002b48:	c785                	beqz	a5,80002b70 <ialloc+0x84>
    brelse(bp);
    80002b4a:	00000097          	auipc	ra,0x0
    80002b4e:	a6a080e7          	jalr	-1430(ra) # 800025b4 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002b52:	0485                	addi	s1,s1,1
    80002b54:	00ca2703          	lw	a4,12(s4)
    80002b58:	0004879b          	sext.w	a5,s1
    80002b5c:	fce7e1e3          	bltu	a5,a4,80002b1e <ialloc+0x32>
  panic("ialloc: no inodes");
    80002b60:	00006517          	auipc	a0,0x6
    80002b64:	a0050513          	addi	a0,a0,-1536 # 80008560 <syscalls+0x168>
    80002b68:	00003097          	auipc	ra,0x3
    80002b6c:	198080e7          	jalr	408(ra) # 80005d00 <panic>
      memset(dip, 0, sizeof(*dip));
    80002b70:	04000613          	li	a2,64
    80002b74:	4581                	li	a1,0
    80002b76:	854e                	mv	a0,s3
    80002b78:	ffffd097          	auipc	ra,0xffffd
    80002b7c:	744080e7          	jalr	1860(ra) # 800002bc <memset>
      dip->type = type;
    80002b80:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002b84:	854a                	mv	a0,s2
    80002b86:	00001097          	auipc	ra,0x1
    80002b8a:	cb2080e7          	jalr	-846(ra) # 80003838 <log_write>
      brelse(bp);
    80002b8e:	854a                	mv	a0,s2
    80002b90:	00000097          	auipc	ra,0x0
    80002b94:	a24080e7          	jalr	-1500(ra) # 800025b4 <brelse>
      return iget(dev, inum);
    80002b98:	85da                	mv	a1,s6
    80002b9a:	8556                	mv	a0,s5
    80002b9c:	00000097          	auipc	ra,0x0
    80002ba0:	db4080e7          	jalr	-588(ra) # 80002950 <iget>
}
    80002ba4:	60a6                	ld	ra,72(sp)
    80002ba6:	6406                	ld	s0,64(sp)
    80002ba8:	74e2                	ld	s1,56(sp)
    80002baa:	7942                	ld	s2,48(sp)
    80002bac:	79a2                	ld	s3,40(sp)
    80002bae:	7a02                	ld	s4,32(sp)
    80002bb0:	6ae2                	ld	s5,24(sp)
    80002bb2:	6b42                	ld	s6,16(sp)
    80002bb4:	6ba2                	ld	s7,8(sp)
    80002bb6:	6161                	addi	sp,sp,80
    80002bb8:	8082                	ret

0000000080002bba <iupdate>:
{
    80002bba:	1101                	addi	sp,sp,-32
    80002bbc:	ec06                	sd	ra,24(sp)
    80002bbe:	e822                	sd	s0,16(sp)
    80002bc0:	e426                	sd	s1,8(sp)
    80002bc2:	e04a                	sd	s2,0(sp)
    80002bc4:	1000                	addi	s0,sp,32
    80002bc6:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002bc8:	415c                	lw	a5,4(a0)
    80002bca:	0047d79b          	srliw	a5,a5,0x4
    80002bce:	00235597          	auipc	a1,0x235
    80002bd2:	9a25a583          	lw	a1,-1630(a1) # 80237570 <sb+0x18>
    80002bd6:	9dbd                	addw	a1,a1,a5
    80002bd8:	4108                	lw	a0,0(a0)
    80002bda:	00000097          	auipc	ra,0x0
    80002bde:	8aa080e7          	jalr	-1878(ra) # 80002484 <bread>
    80002be2:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002be4:	05850793          	addi	a5,a0,88
    80002be8:	40d8                	lw	a4,4(s1)
    80002bea:	8b3d                	andi	a4,a4,15
    80002bec:	071a                	slli	a4,a4,0x6
    80002bee:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002bf0:	04449703          	lh	a4,68(s1)
    80002bf4:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002bf8:	04649703          	lh	a4,70(s1)
    80002bfc:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002c00:	04849703          	lh	a4,72(s1)
    80002c04:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002c08:	04a49703          	lh	a4,74(s1)
    80002c0c:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002c10:	44f8                	lw	a4,76(s1)
    80002c12:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002c14:	03400613          	li	a2,52
    80002c18:	05048593          	addi	a1,s1,80
    80002c1c:	00c78513          	addi	a0,a5,12
    80002c20:	ffffd097          	auipc	ra,0xffffd
    80002c24:	6f8080e7          	jalr	1784(ra) # 80000318 <memmove>
  log_write(bp);
    80002c28:	854a                	mv	a0,s2
    80002c2a:	00001097          	auipc	ra,0x1
    80002c2e:	c0e080e7          	jalr	-1010(ra) # 80003838 <log_write>
  brelse(bp);
    80002c32:	854a                	mv	a0,s2
    80002c34:	00000097          	auipc	ra,0x0
    80002c38:	980080e7          	jalr	-1664(ra) # 800025b4 <brelse>
}
    80002c3c:	60e2                	ld	ra,24(sp)
    80002c3e:	6442                	ld	s0,16(sp)
    80002c40:	64a2                	ld	s1,8(sp)
    80002c42:	6902                	ld	s2,0(sp)
    80002c44:	6105                	addi	sp,sp,32
    80002c46:	8082                	ret

0000000080002c48 <idup>:
{
    80002c48:	1101                	addi	sp,sp,-32
    80002c4a:	ec06                	sd	ra,24(sp)
    80002c4c:	e822                	sd	s0,16(sp)
    80002c4e:	e426                	sd	s1,8(sp)
    80002c50:	1000                	addi	s0,sp,32
    80002c52:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002c54:	00235517          	auipc	a0,0x235
    80002c58:	92450513          	addi	a0,a0,-1756 # 80237578 <itable>
    80002c5c:	00003097          	auipc	ra,0x3
    80002c60:	5dc080e7          	jalr	1500(ra) # 80006238 <acquire>
  ip->ref++;
    80002c64:	449c                	lw	a5,8(s1)
    80002c66:	2785                	addiw	a5,a5,1
    80002c68:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002c6a:	00235517          	auipc	a0,0x235
    80002c6e:	90e50513          	addi	a0,a0,-1778 # 80237578 <itable>
    80002c72:	00003097          	auipc	ra,0x3
    80002c76:	67a080e7          	jalr	1658(ra) # 800062ec <release>
}
    80002c7a:	8526                	mv	a0,s1
    80002c7c:	60e2                	ld	ra,24(sp)
    80002c7e:	6442                	ld	s0,16(sp)
    80002c80:	64a2                	ld	s1,8(sp)
    80002c82:	6105                	addi	sp,sp,32
    80002c84:	8082                	ret

0000000080002c86 <ilock>:
{
    80002c86:	1101                	addi	sp,sp,-32
    80002c88:	ec06                	sd	ra,24(sp)
    80002c8a:	e822                	sd	s0,16(sp)
    80002c8c:	e426                	sd	s1,8(sp)
    80002c8e:	e04a                	sd	s2,0(sp)
    80002c90:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002c92:	c115                	beqz	a0,80002cb6 <ilock+0x30>
    80002c94:	84aa                	mv	s1,a0
    80002c96:	451c                	lw	a5,8(a0)
    80002c98:	00f05f63          	blez	a5,80002cb6 <ilock+0x30>
  acquiresleep(&ip->lock);
    80002c9c:	0541                	addi	a0,a0,16
    80002c9e:	00001097          	auipc	ra,0x1
    80002ca2:	cb8080e7          	jalr	-840(ra) # 80003956 <acquiresleep>
  if(ip->valid == 0){
    80002ca6:	40bc                	lw	a5,64(s1)
    80002ca8:	cf99                	beqz	a5,80002cc6 <ilock+0x40>
}
    80002caa:	60e2                	ld	ra,24(sp)
    80002cac:	6442                	ld	s0,16(sp)
    80002cae:	64a2                	ld	s1,8(sp)
    80002cb0:	6902                	ld	s2,0(sp)
    80002cb2:	6105                	addi	sp,sp,32
    80002cb4:	8082                	ret
    panic("ilock");
    80002cb6:	00006517          	auipc	a0,0x6
    80002cba:	8c250513          	addi	a0,a0,-1854 # 80008578 <syscalls+0x180>
    80002cbe:	00003097          	auipc	ra,0x3
    80002cc2:	042080e7          	jalr	66(ra) # 80005d00 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002cc6:	40dc                	lw	a5,4(s1)
    80002cc8:	0047d79b          	srliw	a5,a5,0x4
    80002ccc:	00235597          	auipc	a1,0x235
    80002cd0:	8a45a583          	lw	a1,-1884(a1) # 80237570 <sb+0x18>
    80002cd4:	9dbd                	addw	a1,a1,a5
    80002cd6:	4088                	lw	a0,0(s1)
    80002cd8:	fffff097          	auipc	ra,0xfffff
    80002cdc:	7ac080e7          	jalr	1964(ra) # 80002484 <bread>
    80002ce0:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002ce2:	05850593          	addi	a1,a0,88
    80002ce6:	40dc                	lw	a5,4(s1)
    80002ce8:	8bbd                	andi	a5,a5,15
    80002cea:	079a                	slli	a5,a5,0x6
    80002cec:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002cee:	00059783          	lh	a5,0(a1)
    80002cf2:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002cf6:	00259783          	lh	a5,2(a1)
    80002cfa:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002cfe:	00459783          	lh	a5,4(a1)
    80002d02:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002d06:	00659783          	lh	a5,6(a1)
    80002d0a:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002d0e:	459c                	lw	a5,8(a1)
    80002d10:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002d12:	03400613          	li	a2,52
    80002d16:	05b1                	addi	a1,a1,12
    80002d18:	05048513          	addi	a0,s1,80
    80002d1c:	ffffd097          	auipc	ra,0xffffd
    80002d20:	5fc080e7          	jalr	1532(ra) # 80000318 <memmove>
    brelse(bp);
    80002d24:	854a                	mv	a0,s2
    80002d26:	00000097          	auipc	ra,0x0
    80002d2a:	88e080e7          	jalr	-1906(ra) # 800025b4 <brelse>
    ip->valid = 1;
    80002d2e:	4785                	li	a5,1
    80002d30:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002d32:	04449783          	lh	a5,68(s1)
    80002d36:	fbb5                	bnez	a5,80002caa <ilock+0x24>
      panic("ilock: no type");
    80002d38:	00006517          	auipc	a0,0x6
    80002d3c:	84850513          	addi	a0,a0,-1976 # 80008580 <syscalls+0x188>
    80002d40:	00003097          	auipc	ra,0x3
    80002d44:	fc0080e7          	jalr	-64(ra) # 80005d00 <panic>

0000000080002d48 <iunlock>:
{
    80002d48:	1101                	addi	sp,sp,-32
    80002d4a:	ec06                	sd	ra,24(sp)
    80002d4c:	e822                	sd	s0,16(sp)
    80002d4e:	e426                	sd	s1,8(sp)
    80002d50:	e04a                	sd	s2,0(sp)
    80002d52:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002d54:	c905                	beqz	a0,80002d84 <iunlock+0x3c>
    80002d56:	84aa                	mv	s1,a0
    80002d58:	01050913          	addi	s2,a0,16
    80002d5c:	854a                	mv	a0,s2
    80002d5e:	00001097          	auipc	ra,0x1
    80002d62:	c92080e7          	jalr	-878(ra) # 800039f0 <holdingsleep>
    80002d66:	cd19                	beqz	a0,80002d84 <iunlock+0x3c>
    80002d68:	449c                	lw	a5,8(s1)
    80002d6a:	00f05d63          	blez	a5,80002d84 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002d6e:	854a                	mv	a0,s2
    80002d70:	00001097          	auipc	ra,0x1
    80002d74:	c3c080e7          	jalr	-964(ra) # 800039ac <releasesleep>
}
    80002d78:	60e2                	ld	ra,24(sp)
    80002d7a:	6442                	ld	s0,16(sp)
    80002d7c:	64a2                	ld	s1,8(sp)
    80002d7e:	6902                	ld	s2,0(sp)
    80002d80:	6105                	addi	sp,sp,32
    80002d82:	8082                	ret
    panic("iunlock");
    80002d84:	00006517          	auipc	a0,0x6
    80002d88:	80c50513          	addi	a0,a0,-2036 # 80008590 <syscalls+0x198>
    80002d8c:	00003097          	auipc	ra,0x3
    80002d90:	f74080e7          	jalr	-140(ra) # 80005d00 <panic>

0000000080002d94 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002d94:	7179                	addi	sp,sp,-48
    80002d96:	f406                	sd	ra,40(sp)
    80002d98:	f022                	sd	s0,32(sp)
    80002d9a:	ec26                	sd	s1,24(sp)
    80002d9c:	e84a                	sd	s2,16(sp)
    80002d9e:	e44e                	sd	s3,8(sp)
    80002da0:	e052                	sd	s4,0(sp)
    80002da2:	1800                	addi	s0,sp,48
    80002da4:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002da6:	05050493          	addi	s1,a0,80
    80002daa:	08050913          	addi	s2,a0,128
    80002dae:	a021                	j	80002db6 <itrunc+0x22>
    80002db0:	0491                	addi	s1,s1,4
    80002db2:	01248d63          	beq	s1,s2,80002dcc <itrunc+0x38>
    if(ip->addrs[i]){
    80002db6:	408c                	lw	a1,0(s1)
    80002db8:	dde5                	beqz	a1,80002db0 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80002dba:	0009a503          	lw	a0,0(s3)
    80002dbe:	00000097          	auipc	ra,0x0
    80002dc2:	90c080e7          	jalr	-1780(ra) # 800026ca <bfree>
      ip->addrs[i] = 0;
    80002dc6:	0004a023          	sw	zero,0(s1)
    80002dca:	b7dd                	j	80002db0 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002dcc:	0809a583          	lw	a1,128(s3)
    80002dd0:	e185                	bnez	a1,80002df0 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002dd2:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002dd6:	854e                	mv	a0,s3
    80002dd8:	00000097          	auipc	ra,0x0
    80002ddc:	de2080e7          	jalr	-542(ra) # 80002bba <iupdate>
}
    80002de0:	70a2                	ld	ra,40(sp)
    80002de2:	7402                	ld	s0,32(sp)
    80002de4:	64e2                	ld	s1,24(sp)
    80002de6:	6942                	ld	s2,16(sp)
    80002de8:	69a2                	ld	s3,8(sp)
    80002dea:	6a02                	ld	s4,0(sp)
    80002dec:	6145                	addi	sp,sp,48
    80002dee:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002df0:	0009a503          	lw	a0,0(s3)
    80002df4:	fffff097          	auipc	ra,0xfffff
    80002df8:	690080e7          	jalr	1680(ra) # 80002484 <bread>
    80002dfc:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002dfe:	05850493          	addi	s1,a0,88
    80002e02:	45850913          	addi	s2,a0,1112
    80002e06:	a021                	j	80002e0e <itrunc+0x7a>
    80002e08:	0491                	addi	s1,s1,4
    80002e0a:	01248b63          	beq	s1,s2,80002e20 <itrunc+0x8c>
      if(a[j])
    80002e0e:	408c                	lw	a1,0(s1)
    80002e10:	dde5                	beqz	a1,80002e08 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    80002e12:	0009a503          	lw	a0,0(s3)
    80002e16:	00000097          	auipc	ra,0x0
    80002e1a:	8b4080e7          	jalr	-1868(ra) # 800026ca <bfree>
    80002e1e:	b7ed                	j	80002e08 <itrunc+0x74>
    brelse(bp);
    80002e20:	8552                	mv	a0,s4
    80002e22:	fffff097          	auipc	ra,0xfffff
    80002e26:	792080e7          	jalr	1938(ra) # 800025b4 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002e2a:	0809a583          	lw	a1,128(s3)
    80002e2e:	0009a503          	lw	a0,0(s3)
    80002e32:	00000097          	auipc	ra,0x0
    80002e36:	898080e7          	jalr	-1896(ra) # 800026ca <bfree>
    ip->addrs[NDIRECT] = 0;
    80002e3a:	0809a023          	sw	zero,128(s3)
    80002e3e:	bf51                	j	80002dd2 <itrunc+0x3e>

0000000080002e40 <iput>:
{
    80002e40:	1101                	addi	sp,sp,-32
    80002e42:	ec06                	sd	ra,24(sp)
    80002e44:	e822                	sd	s0,16(sp)
    80002e46:	e426                	sd	s1,8(sp)
    80002e48:	e04a                	sd	s2,0(sp)
    80002e4a:	1000                	addi	s0,sp,32
    80002e4c:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002e4e:	00234517          	auipc	a0,0x234
    80002e52:	72a50513          	addi	a0,a0,1834 # 80237578 <itable>
    80002e56:	00003097          	auipc	ra,0x3
    80002e5a:	3e2080e7          	jalr	994(ra) # 80006238 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002e5e:	4498                	lw	a4,8(s1)
    80002e60:	4785                	li	a5,1
    80002e62:	02f70363          	beq	a4,a5,80002e88 <iput+0x48>
  ip->ref--;
    80002e66:	449c                	lw	a5,8(s1)
    80002e68:	37fd                	addiw	a5,a5,-1
    80002e6a:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002e6c:	00234517          	auipc	a0,0x234
    80002e70:	70c50513          	addi	a0,a0,1804 # 80237578 <itable>
    80002e74:	00003097          	auipc	ra,0x3
    80002e78:	478080e7          	jalr	1144(ra) # 800062ec <release>
}
    80002e7c:	60e2                	ld	ra,24(sp)
    80002e7e:	6442                	ld	s0,16(sp)
    80002e80:	64a2                	ld	s1,8(sp)
    80002e82:	6902                	ld	s2,0(sp)
    80002e84:	6105                	addi	sp,sp,32
    80002e86:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002e88:	40bc                	lw	a5,64(s1)
    80002e8a:	dff1                	beqz	a5,80002e66 <iput+0x26>
    80002e8c:	04a49783          	lh	a5,74(s1)
    80002e90:	fbf9                	bnez	a5,80002e66 <iput+0x26>
    acquiresleep(&ip->lock);
    80002e92:	01048913          	addi	s2,s1,16
    80002e96:	854a                	mv	a0,s2
    80002e98:	00001097          	auipc	ra,0x1
    80002e9c:	abe080e7          	jalr	-1346(ra) # 80003956 <acquiresleep>
    release(&itable.lock);
    80002ea0:	00234517          	auipc	a0,0x234
    80002ea4:	6d850513          	addi	a0,a0,1752 # 80237578 <itable>
    80002ea8:	00003097          	auipc	ra,0x3
    80002eac:	444080e7          	jalr	1092(ra) # 800062ec <release>
    itrunc(ip);
    80002eb0:	8526                	mv	a0,s1
    80002eb2:	00000097          	auipc	ra,0x0
    80002eb6:	ee2080e7          	jalr	-286(ra) # 80002d94 <itrunc>
    ip->type = 0;
    80002eba:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002ebe:	8526                	mv	a0,s1
    80002ec0:	00000097          	auipc	ra,0x0
    80002ec4:	cfa080e7          	jalr	-774(ra) # 80002bba <iupdate>
    ip->valid = 0;
    80002ec8:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002ecc:	854a                	mv	a0,s2
    80002ece:	00001097          	auipc	ra,0x1
    80002ed2:	ade080e7          	jalr	-1314(ra) # 800039ac <releasesleep>
    acquire(&itable.lock);
    80002ed6:	00234517          	auipc	a0,0x234
    80002eda:	6a250513          	addi	a0,a0,1698 # 80237578 <itable>
    80002ede:	00003097          	auipc	ra,0x3
    80002ee2:	35a080e7          	jalr	858(ra) # 80006238 <acquire>
    80002ee6:	b741                	j	80002e66 <iput+0x26>

0000000080002ee8 <iunlockput>:
{
    80002ee8:	1101                	addi	sp,sp,-32
    80002eea:	ec06                	sd	ra,24(sp)
    80002eec:	e822                	sd	s0,16(sp)
    80002eee:	e426                	sd	s1,8(sp)
    80002ef0:	1000                	addi	s0,sp,32
    80002ef2:	84aa                	mv	s1,a0
  iunlock(ip);
    80002ef4:	00000097          	auipc	ra,0x0
    80002ef8:	e54080e7          	jalr	-428(ra) # 80002d48 <iunlock>
  iput(ip);
    80002efc:	8526                	mv	a0,s1
    80002efe:	00000097          	auipc	ra,0x0
    80002f02:	f42080e7          	jalr	-190(ra) # 80002e40 <iput>
}
    80002f06:	60e2                	ld	ra,24(sp)
    80002f08:	6442                	ld	s0,16(sp)
    80002f0a:	64a2                	ld	s1,8(sp)
    80002f0c:	6105                	addi	sp,sp,32
    80002f0e:	8082                	ret

0000000080002f10 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002f10:	1141                	addi	sp,sp,-16
    80002f12:	e422                	sd	s0,8(sp)
    80002f14:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002f16:	411c                	lw	a5,0(a0)
    80002f18:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002f1a:	415c                	lw	a5,4(a0)
    80002f1c:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002f1e:	04451783          	lh	a5,68(a0)
    80002f22:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002f26:	04a51783          	lh	a5,74(a0)
    80002f2a:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002f2e:	04c56783          	lwu	a5,76(a0)
    80002f32:	e99c                	sd	a5,16(a1)
}
    80002f34:	6422                	ld	s0,8(sp)
    80002f36:	0141                	addi	sp,sp,16
    80002f38:	8082                	ret

0000000080002f3a <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002f3a:	457c                	lw	a5,76(a0)
    80002f3c:	0ed7e963          	bltu	a5,a3,8000302e <readi+0xf4>
{
    80002f40:	7159                	addi	sp,sp,-112
    80002f42:	f486                	sd	ra,104(sp)
    80002f44:	f0a2                	sd	s0,96(sp)
    80002f46:	eca6                	sd	s1,88(sp)
    80002f48:	e8ca                	sd	s2,80(sp)
    80002f4a:	e4ce                	sd	s3,72(sp)
    80002f4c:	e0d2                	sd	s4,64(sp)
    80002f4e:	fc56                	sd	s5,56(sp)
    80002f50:	f85a                	sd	s6,48(sp)
    80002f52:	f45e                	sd	s7,40(sp)
    80002f54:	f062                	sd	s8,32(sp)
    80002f56:	ec66                	sd	s9,24(sp)
    80002f58:	e86a                	sd	s10,16(sp)
    80002f5a:	e46e                	sd	s11,8(sp)
    80002f5c:	1880                	addi	s0,sp,112
    80002f5e:	8baa                	mv	s7,a0
    80002f60:	8c2e                	mv	s8,a1
    80002f62:	8ab2                	mv	s5,a2
    80002f64:	84b6                	mv	s1,a3
    80002f66:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002f68:	9f35                	addw	a4,a4,a3
    return 0;
    80002f6a:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002f6c:	0ad76063          	bltu	a4,a3,8000300c <readi+0xd2>
  if(off + n > ip->size)
    80002f70:	00e7f463          	bgeu	a5,a4,80002f78 <readi+0x3e>
    n = ip->size - off;
    80002f74:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002f78:	0a0b0963          	beqz	s6,8000302a <readi+0xf0>
    80002f7c:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80002f7e:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002f82:	5cfd                	li	s9,-1
    80002f84:	a82d                	j	80002fbe <readi+0x84>
    80002f86:	020a1d93          	slli	s11,s4,0x20
    80002f8a:	020ddd93          	srli	s11,s11,0x20
    80002f8e:	05890613          	addi	a2,s2,88
    80002f92:	86ee                	mv	a3,s11
    80002f94:	963a                	add	a2,a2,a4
    80002f96:	85d6                	mv	a1,s5
    80002f98:	8562                	mv	a0,s8
    80002f9a:	fffff097          	auipc	ra,0xfffff
    80002f9e:	b0e080e7          	jalr	-1266(ra) # 80001aa8 <either_copyout>
    80002fa2:	05950d63          	beq	a0,s9,80002ffc <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002fa6:	854a                	mv	a0,s2
    80002fa8:	fffff097          	auipc	ra,0xfffff
    80002fac:	60c080e7          	jalr	1548(ra) # 800025b4 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002fb0:	013a09bb          	addw	s3,s4,s3
    80002fb4:	009a04bb          	addw	s1,s4,s1
    80002fb8:	9aee                	add	s5,s5,s11
    80002fba:	0569f763          	bgeu	s3,s6,80003008 <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80002fbe:	000ba903          	lw	s2,0(s7)
    80002fc2:	00a4d59b          	srliw	a1,s1,0xa
    80002fc6:	855e                	mv	a0,s7
    80002fc8:	00000097          	auipc	ra,0x0
    80002fcc:	8ac080e7          	jalr	-1876(ra) # 80002874 <bmap>
    80002fd0:	0005059b          	sext.w	a1,a0
    80002fd4:	854a                	mv	a0,s2
    80002fd6:	fffff097          	auipc	ra,0xfffff
    80002fda:	4ae080e7          	jalr	1198(ra) # 80002484 <bread>
    80002fde:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002fe0:	3ff4f713          	andi	a4,s1,1023
    80002fe4:	40ed07bb          	subw	a5,s10,a4
    80002fe8:	413b06bb          	subw	a3,s6,s3
    80002fec:	8a3e                	mv	s4,a5
    80002fee:	2781                	sext.w	a5,a5
    80002ff0:	0006861b          	sext.w	a2,a3
    80002ff4:	f8f679e3          	bgeu	a2,a5,80002f86 <readi+0x4c>
    80002ff8:	8a36                	mv	s4,a3
    80002ffa:	b771                	j	80002f86 <readi+0x4c>
      brelse(bp);
    80002ffc:	854a                	mv	a0,s2
    80002ffe:	fffff097          	auipc	ra,0xfffff
    80003002:	5b6080e7          	jalr	1462(ra) # 800025b4 <brelse>
      tot = -1;
    80003006:	59fd                	li	s3,-1
  }
  return tot;
    80003008:	0009851b          	sext.w	a0,s3
}
    8000300c:	70a6                	ld	ra,104(sp)
    8000300e:	7406                	ld	s0,96(sp)
    80003010:	64e6                	ld	s1,88(sp)
    80003012:	6946                	ld	s2,80(sp)
    80003014:	69a6                	ld	s3,72(sp)
    80003016:	6a06                	ld	s4,64(sp)
    80003018:	7ae2                	ld	s5,56(sp)
    8000301a:	7b42                	ld	s6,48(sp)
    8000301c:	7ba2                	ld	s7,40(sp)
    8000301e:	7c02                	ld	s8,32(sp)
    80003020:	6ce2                	ld	s9,24(sp)
    80003022:	6d42                	ld	s10,16(sp)
    80003024:	6da2                	ld	s11,8(sp)
    80003026:	6165                	addi	sp,sp,112
    80003028:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000302a:	89da                	mv	s3,s6
    8000302c:	bff1                	j	80003008 <readi+0xce>
    return 0;
    8000302e:	4501                	li	a0,0
}
    80003030:	8082                	ret

0000000080003032 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003032:	457c                	lw	a5,76(a0)
    80003034:	10d7e863          	bltu	a5,a3,80003144 <writei+0x112>
{
    80003038:	7159                	addi	sp,sp,-112
    8000303a:	f486                	sd	ra,104(sp)
    8000303c:	f0a2                	sd	s0,96(sp)
    8000303e:	eca6                	sd	s1,88(sp)
    80003040:	e8ca                	sd	s2,80(sp)
    80003042:	e4ce                	sd	s3,72(sp)
    80003044:	e0d2                	sd	s4,64(sp)
    80003046:	fc56                	sd	s5,56(sp)
    80003048:	f85a                	sd	s6,48(sp)
    8000304a:	f45e                	sd	s7,40(sp)
    8000304c:	f062                	sd	s8,32(sp)
    8000304e:	ec66                	sd	s9,24(sp)
    80003050:	e86a                	sd	s10,16(sp)
    80003052:	e46e                	sd	s11,8(sp)
    80003054:	1880                	addi	s0,sp,112
    80003056:	8b2a                	mv	s6,a0
    80003058:	8c2e                	mv	s8,a1
    8000305a:	8ab2                	mv	s5,a2
    8000305c:	8936                	mv	s2,a3
    8000305e:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    80003060:	00e687bb          	addw	a5,a3,a4
    80003064:	0ed7e263          	bltu	a5,a3,80003148 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003068:	00043737          	lui	a4,0x43
    8000306c:	0ef76063          	bltu	a4,a5,8000314c <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003070:	0c0b8863          	beqz	s7,80003140 <writei+0x10e>
    80003074:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003076:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    8000307a:	5cfd                	li	s9,-1
    8000307c:	a091                	j	800030c0 <writei+0x8e>
    8000307e:	02099d93          	slli	s11,s3,0x20
    80003082:	020ddd93          	srli	s11,s11,0x20
    80003086:	05848513          	addi	a0,s1,88
    8000308a:	86ee                	mv	a3,s11
    8000308c:	8656                	mv	a2,s5
    8000308e:	85e2                	mv	a1,s8
    80003090:	953a                	add	a0,a0,a4
    80003092:	fffff097          	auipc	ra,0xfffff
    80003096:	a6c080e7          	jalr	-1428(ra) # 80001afe <either_copyin>
    8000309a:	07950263          	beq	a0,s9,800030fe <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    8000309e:	8526                	mv	a0,s1
    800030a0:	00000097          	auipc	ra,0x0
    800030a4:	798080e7          	jalr	1944(ra) # 80003838 <log_write>
    brelse(bp);
    800030a8:	8526                	mv	a0,s1
    800030aa:	fffff097          	auipc	ra,0xfffff
    800030ae:	50a080e7          	jalr	1290(ra) # 800025b4 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800030b2:	01498a3b          	addw	s4,s3,s4
    800030b6:	0129893b          	addw	s2,s3,s2
    800030ba:	9aee                	add	s5,s5,s11
    800030bc:	057a7663          	bgeu	s4,s7,80003108 <writei+0xd6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    800030c0:	000b2483          	lw	s1,0(s6)
    800030c4:	00a9559b          	srliw	a1,s2,0xa
    800030c8:	855a                	mv	a0,s6
    800030ca:	fffff097          	auipc	ra,0xfffff
    800030ce:	7aa080e7          	jalr	1962(ra) # 80002874 <bmap>
    800030d2:	0005059b          	sext.w	a1,a0
    800030d6:	8526                	mv	a0,s1
    800030d8:	fffff097          	auipc	ra,0xfffff
    800030dc:	3ac080e7          	jalr	940(ra) # 80002484 <bread>
    800030e0:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800030e2:	3ff97713          	andi	a4,s2,1023
    800030e6:	40ed07bb          	subw	a5,s10,a4
    800030ea:	414b86bb          	subw	a3,s7,s4
    800030ee:	89be                	mv	s3,a5
    800030f0:	2781                	sext.w	a5,a5
    800030f2:	0006861b          	sext.w	a2,a3
    800030f6:	f8f674e3          	bgeu	a2,a5,8000307e <writei+0x4c>
    800030fa:	89b6                	mv	s3,a3
    800030fc:	b749                	j	8000307e <writei+0x4c>
      brelse(bp);
    800030fe:	8526                	mv	a0,s1
    80003100:	fffff097          	auipc	ra,0xfffff
    80003104:	4b4080e7          	jalr	1204(ra) # 800025b4 <brelse>
  }

  if(off > ip->size)
    80003108:	04cb2783          	lw	a5,76(s6)
    8000310c:	0127f463          	bgeu	a5,s2,80003114 <writei+0xe2>
    ip->size = off;
    80003110:	052b2623          	sw	s2,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003114:	855a                	mv	a0,s6
    80003116:	00000097          	auipc	ra,0x0
    8000311a:	aa4080e7          	jalr	-1372(ra) # 80002bba <iupdate>

  return tot;
    8000311e:	000a051b          	sext.w	a0,s4
}
    80003122:	70a6                	ld	ra,104(sp)
    80003124:	7406                	ld	s0,96(sp)
    80003126:	64e6                	ld	s1,88(sp)
    80003128:	6946                	ld	s2,80(sp)
    8000312a:	69a6                	ld	s3,72(sp)
    8000312c:	6a06                	ld	s4,64(sp)
    8000312e:	7ae2                	ld	s5,56(sp)
    80003130:	7b42                	ld	s6,48(sp)
    80003132:	7ba2                	ld	s7,40(sp)
    80003134:	7c02                	ld	s8,32(sp)
    80003136:	6ce2                	ld	s9,24(sp)
    80003138:	6d42                	ld	s10,16(sp)
    8000313a:	6da2                	ld	s11,8(sp)
    8000313c:	6165                	addi	sp,sp,112
    8000313e:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003140:	8a5e                	mv	s4,s7
    80003142:	bfc9                	j	80003114 <writei+0xe2>
    return -1;
    80003144:	557d                	li	a0,-1
}
    80003146:	8082                	ret
    return -1;
    80003148:	557d                	li	a0,-1
    8000314a:	bfe1                	j	80003122 <writei+0xf0>
    return -1;
    8000314c:	557d                	li	a0,-1
    8000314e:	bfd1                	j	80003122 <writei+0xf0>

0000000080003150 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003150:	1141                	addi	sp,sp,-16
    80003152:	e406                	sd	ra,8(sp)
    80003154:	e022                	sd	s0,0(sp)
    80003156:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003158:	4639                	li	a2,14
    8000315a:	ffffd097          	auipc	ra,0xffffd
    8000315e:	232080e7          	jalr	562(ra) # 8000038c <strncmp>
}
    80003162:	60a2                	ld	ra,8(sp)
    80003164:	6402                	ld	s0,0(sp)
    80003166:	0141                	addi	sp,sp,16
    80003168:	8082                	ret

000000008000316a <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000316a:	7139                	addi	sp,sp,-64
    8000316c:	fc06                	sd	ra,56(sp)
    8000316e:	f822                	sd	s0,48(sp)
    80003170:	f426                	sd	s1,40(sp)
    80003172:	f04a                	sd	s2,32(sp)
    80003174:	ec4e                	sd	s3,24(sp)
    80003176:	e852                	sd	s4,16(sp)
    80003178:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    8000317a:	04451703          	lh	a4,68(a0)
    8000317e:	4785                	li	a5,1
    80003180:	00f71a63          	bne	a4,a5,80003194 <dirlookup+0x2a>
    80003184:	892a                	mv	s2,a0
    80003186:	89ae                	mv	s3,a1
    80003188:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    8000318a:	457c                	lw	a5,76(a0)
    8000318c:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    8000318e:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003190:	e79d                	bnez	a5,800031be <dirlookup+0x54>
    80003192:	a8a5                	j	8000320a <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003194:	00005517          	auipc	a0,0x5
    80003198:	40450513          	addi	a0,a0,1028 # 80008598 <syscalls+0x1a0>
    8000319c:	00003097          	auipc	ra,0x3
    800031a0:	b64080e7          	jalr	-1180(ra) # 80005d00 <panic>
      panic("dirlookup read");
    800031a4:	00005517          	auipc	a0,0x5
    800031a8:	40c50513          	addi	a0,a0,1036 # 800085b0 <syscalls+0x1b8>
    800031ac:	00003097          	auipc	ra,0x3
    800031b0:	b54080e7          	jalr	-1196(ra) # 80005d00 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800031b4:	24c1                	addiw	s1,s1,16
    800031b6:	04c92783          	lw	a5,76(s2)
    800031ba:	04f4f763          	bgeu	s1,a5,80003208 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800031be:	4741                	li	a4,16
    800031c0:	86a6                	mv	a3,s1
    800031c2:	fc040613          	addi	a2,s0,-64
    800031c6:	4581                	li	a1,0
    800031c8:	854a                	mv	a0,s2
    800031ca:	00000097          	auipc	ra,0x0
    800031ce:	d70080e7          	jalr	-656(ra) # 80002f3a <readi>
    800031d2:	47c1                	li	a5,16
    800031d4:	fcf518e3          	bne	a0,a5,800031a4 <dirlookup+0x3a>
    if(de.inum == 0)
    800031d8:	fc045783          	lhu	a5,-64(s0)
    800031dc:	dfe1                	beqz	a5,800031b4 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    800031de:	fc240593          	addi	a1,s0,-62
    800031e2:	854e                	mv	a0,s3
    800031e4:	00000097          	auipc	ra,0x0
    800031e8:	f6c080e7          	jalr	-148(ra) # 80003150 <namecmp>
    800031ec:	f561                	bnez	a0,800031b4 <dirlookup+0x4a>
      if(poff)
    800031ee:	000a0463          	beqz	s4,800031f6 <dirlookup+0x8c>
        *poff = off;
    800031f2:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    800031f6:	fc045583          	lhu	a1,-64(s0)
    800031fa:	00092503          	lw	a0,0(s2)
    800031fe:	fffff097          	auipc	ra,0xfffff
    80003202:	752080e7          	jalr	1874(ra) # 80002950 <iget>
    80003206:	a011                	j	8000320a <dirlookup+0xa0>
  return 0;
    80003208:	4501                	li	a0,0
}
    8000320a:	70e2                	ld	ra,56(sp)
    8000320c:	7442                	ld	s0,48(sp)
    8000320e:	74a2                	ld	s1,40(sp)
    80003210:	7902                	ld	s2,32(sp)
    80003212:	69e2                	ld	s3,24(sp)
    80003214:	6a42                	ld	s4,16(sp)
    80003216:	6121                	addi	sp,sp,64
    80003218:	8082                	ret

000000008000321a <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    8000321a:	711d                	addi	sp,sp,-96
    8000321c:	ec86                	sd	ra,88(sp)
    8000321e:	e8a2                	sd	s0,80(sp)
    80003220:	e4a6                	sd	s1,72(sp)
    80003222:	e0ca                	sd	s2,64(sp)
    80003224:	fc4e                	sd	s3,56(sp)
    80003226:	f852                	sd	s4,48(sp)
    80003228:	f456                	sd	s5,40(sp)
    8000322a:	f05a                	sd	s6,32(sp)
    8000322c:	ec5e                	sd	s7,24(sp)
    8000322e:	e862                	sd	s8,16(sp)
    80003230:	e466                	sd	s9,8(sp)
    80003232:	e06a                	sd	s10,0(sp)
    80003234:	1080                	addi	s0,sp,96
    80003236:	84aa                	mv	s1,a0
    80003238:	8b2e                	mv	s6,a1
    8000323a:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    8000323c:	00054703          	lbu	a4,0(a0)
    80003240:	02f00793          	li	a5,47
    80003244:	02f70363          	beq	a4,a5,8000326a <namex+0x50>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003248:	ffffe097          	auipc	ra,0xffffe
    8000324c:	df8080e7          	jalr	-520(ra) # 80001040 <myproc>
    80003250:	15053503          	ld	a0,336(a0)
    80003254:	00000097          	auipc	ra,0x0
    80003258:	9f4080e7          	jalr	-1548(ra) # 80002c48 <idup>
    8000325c:	8a2a                	mv	s4,a0
  while(*path == '/')
    8000325e:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    80003262:	4cb5                	li	s9,13
  len = path - s;
    80003264:	4b81                	li	s7,0

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003266:	4c05                	li	s8,1
    80003268:	a87d                	j	80003326 <namex+0x10c>
    ip = iget(ROOTDEV, ROOTINO);
    8000326a:	4585                	li	a1,1
    8000326c:	4505                	li	a0,1
    8000326e:	fffff097          	auipc	ra,0xfffff
    80003272:	6e2080e7          	jalr	1762(ra) # 80002950 <iget>
    80003276:	8a2a                	mv	s4,a0
    80003278:	b7dd                	j	8000325e <namex+0x44>
      iunlockput(ip);
    8000327a:	8552                	mv	a0,s4
    8000327c:	00000097          	auipc	ra,0x0
    80003280:	c6c080e7          	jalr	-916(ra) # 80002ee8 <iunlockput>
      return 0;
    80003284:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003286:	8552                	mv	a0,s4
    80003288:	60e6                	ld	ra,88(sp)
    8000328a:	6446                	ld	s0,80(sp)
    8000328c:	64a6                	ld	s1,72(sp)
    8000328e:	6906                	ld	s2,64(sp)
    80003290:	79e2                	ld	s3,56(sp)
    80003292:	7a42                	ld	s4,48(sp)
    80003294:	7aa2                	ld	s5,40(sp)
    80003296:	7b02                	ld	s6,32(sp)
    80003298:	6be2                	ld	s7,24(sp)
    8000329a:	6c42                	ld	s8,16(sp)
    8000329c:	6ca2                	ld	s9,8(sp)
    8000329e:	6d02                	ld	s10,0(sp)
    800032a0:	6125                	addi	sp,sp,96
    800032a2:	8082                	ret
      iunlock(ip);
    800032a4:	8552                	mv	a0,s4
    800032a6:	00000097          	auipc	ra,0x0
    800032aa:	aa2080e7          	jalr	-1374(ra) # 80002d48 <iunlock>
      return ip;
    800032ae:	bfe1                	j	80003286 <namex+0x6c>
      iunlockput(ip);
    800032b0:	8552                	mv	a0,s4
    800032b2:	00000097          	auipc	ra,0x0
    800032b6:	c36080e7          	jalr	-970(ra) # 80002ee8 <iunlockput>
      return 0;
    800032ba:	8a4e                	mv	s4,s3
    800032bc:	b7e9                	j	80003286 <namex+0x6c>
  len = path - s;
    800032be:	40998633          	sub	a2,s3,s1
    800032c2:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    800032c6:	09acd863          	bge	s9,s10,80003356 <namex+0x13c>
    memmove(name, s, DIRSIZ);
    800032ca:	4639                	li	a2,14
    800032cc:	85a6                	mv	a1,s1
    800032ce:	8556                	mv	a0,s5
    800032d0:	ffffd097          	auipc	ra,0xffffd
    800032d4:	048080e7          	jalr	72(ra) # 80000318 <memmove>
    800032d8:	84ce                	mv	s1,s3
  while(*path == '/')
    800032da:	0004c783          	lbu	a5,0(s1)
    800032de:	01279763          	bne	a5,s2,800032ec <namex+0xd2>
    path++;
    800032e2:	0485                	addi	s1,s1,1
  while(*path == '/')
    800032e4:	0004c783          	lbu	a5,0(s1)
    800032e8:	ff278de3          	beq	a5,s2,800032e2 <namex+0xc8>
    ilock(ip);
    800032ec:	8552                	mv	a0,s4
    800032ee:	00000097          	auipc	ra,0x0
    800032f2:	998080e7          	jalr	-1640(ra) # 80002c86 <ilock>
    if(ip->type != T_DIR){
    800032f6:	044a1783          	lh	a5,68(s4)
    800032fa:	f98790e3          	bne	a5,s8,8000327a <namex+0x60>
    if(nameiparent && *path == '\0'){
    800032fe:	000b0563          	beqz	s6,80003308 <namex+0xee>
    80003302:	0004c783          	lbu	a5,0(s1)
    80003306:	dfd9                	beqz	a5,800032a4 <namex+0x8a>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003308:	865e                	mv	a2,s7
    8000330a:	85d6                	mv	a1,s5
    8000330c:	8552                	mv	a0,s4
    8000330e:	00000097          	auipc	ra,0x0
    80003312:	e5c080e7          	jalr	-420(ra) # 8000316a <dirlookup>
    80003316:	89aa                	mv	s3,a0
    80003318:	dd41                	beqz	a0,800032b0 <namex+0x96>
    iunlockput(ip);
    8000331a:	8552                	mv	a0,s4
    8000331c:	00000097          	auipc	ra,0x0
    80003320:	bcc080e7          	jalr	-1076(ra) # 80002ee8 <iunlockput>
    ip = next;
    80003324:	8a4e                	mv	s4,s3
  while(*path == '/')
    80003326:	0004c783          	lbu	a5,0(s1)
    8000332a:	01279763          	bne	a5,s2,80003338 <namex+0x11e>
    path++;
    8000332e:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003330:	0004c783          	lbu	a5,0(s1)
    80003334:	ff278de3          	beq	a5,s2,8000332e <namex+0x114>
  if(*path == 0)
    80003338:	cb9d                	beqz	a5,8000336e <namex+0x154>
  while(*path != '/' && *path != 0)
    8000333a:	0004c783          	lbu	a5,0(s1)
    8000333e:	89a6                	mv	s3,s1
  len = path - s;
    80003340:	8d5e                	mv	s10,s7
    80003342:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    80003344:	01278963          	beq	a5,s2,80003356 <namex+0x13c>
    80003348:	dbbd                	beqz	a5,800032be <namex+0xa4>
    path++;
    8000334a:	0985                	addi	s3,s3,1
  while(*path != '/' && *path != 0)
    8000334c:	0009c783          	lbu	a5,0(s3)
    80003350:	ff279ce3          	bne	a5,s2,80003348 <namex+0x12e>
    80003354:	b7ad                	j	800032be <namex+0xa4>
    memmove(name, s, len);
    80003356:	2601                	sext.w	a2,a2
    80003358:	85a6                	mv	a1,s1
    8000335a:	8556                	mv	a0,s5
    8000335c:	ffffd097          	auipc	ra,0xffffd
    80003360:	fbc080e7          	jalr	-68(ra) # 80000318 <memmove>
    name[len] = 0;
    80003364:	9d56                	add	s10,s10,s5
    80003366:	000d0023          	sb	zero,0(s10)
    8000336a:	84ce                	mv	s1,s3
    8000336c:	b7bd                	j	800032da <namex+0xc0>
  if(nameiparent){
    8000336e:	f00b0ce3          	beqz	s6,80003286 <namex+0x6c>
    iput(ip);
    80003372:	8552                	mv	a0,s4
    80003374:	00000097          	auipc	ra,0x0
    80003378:	acc080e7          	jalr	-1332(ra) # 80002e40 <iput>
    return 0;
    8000337c:	4a01                	li	s4,0
    8000337e:	b721                	j	80003286 <namex+0x6c>

0000000080003380 <dirlink>:
{
    80003380:	7139                	addi	sp,sp,-64
    80003382:	fc06                	sd	ra,56(sp)
    80003384:	f822                	sd	s0,48(sp)
    80003386:	f426                	sd	s1,40(sp)
    80003388:	f04a                	sd	s2,32(sp)
    8000338a:	ec4e                	sd	s3,24(sp)
    8000338c:	e852                	sd	s4,16(sp)
    8000338e:	0080                	addi	s0,sp,64
    80003390:	892a                	mv	s2,a0
    80003392:	8a2e                	mv	s4,a1
    80003394:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003396:	4601                	li	a2,0
    80003398:	00000097          	auipc	ra,0x0
    8000339c:	dd2080e7          	jalr	-558(ra) # 8000316a <dirlookup>
    800033a0:	e93d                	bnez	a0,80003416 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800033a2:	04c92483          	lw	s1,76(s2)
    800033a6:	c49d                	beqz	s1,800033d4 <dirlink+0x54>
    800033a8:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800033aa:	4741                	li	a4,16
    800033ac:	86a6                	mv	a3,s1
    800033ae:	fc040613          	addi	a2,s0,-64
    800033b2:	4581                	li	a1,0
    800033b4:	854a                	mv	a0,s2
    800033b6:	00000097          	auipc	ra,0x0
    800033ba:	b84080e7          	jalr	-1148(ra) # 80002f3a <readi>
    800033be:	47c1                	li	a5,16
    800033c0:	06f51163          	bne	a0,a5,80003422 <dirlink+0xa2>
    if(de.inum == 0)
    800033c4:	fc045783          	lhu	a5,-64(s0)
    800033c8:	c791                	beqz	a5,800033d4 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800033ca:	24c1                	addiw	s1,s1,16
    800033cc:	04c92783          	lw	a5,76(s2)
    800033d0:	fcf4ede3          	bltu	s1,a5,800033aa <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    800033d4:	4639                	li	a2,14
    800033d6:	85d2                	mv	a1,s4
    800033d8:	fc240513          	addi	a0,s0,-62
    800033dc:	ffffd097          	auipc	ra,0xffffd
    800033e0:	fec080e7          	jalr	-20(ra) # 800003c8 <strncpy>
  de.inum = inum;
    800033e4:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800033e8:	4741                	li	a4,16
    800033ea:	86a6                	mv	a3,s1
    800033ec:	fc040613          	addi	a2,s0,-64
    800033f0:	4581                	li	a1,0
    800033f2:	854a                	mv	a0,s2
    800033f4:	00000097          	auipc	ra,0x0
    800033f8:	c3e080e7          	jalr	-962(ra) # 80003032 <writei>
    800033fc:	872a                	mv	a4,a0
    800033fe:	47c1                	li	a5,16
  return 0;
    80003400:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003402:	02f71863          	bne	a4,a5,80003432 <dirlink+0xb2>
}
    80003406:	70e2                	ld	ra,56(sp)
    80003408:	7442                	ld	s0,48(sp)
    8000340a:	74a2                	ld	s1,40(sp)
    8000340c:	7902                	ld	s2,32(sp)
    8000340e:	69e2                	ld	s3,24(sp)
    80003410:	6a42                	ld	s4,16(sp)
    80003412:	6121                	addi	sp,sp,64
    80003414:	8082                	ret
    iput(ip);
    80003416:	00000097          	auipc	ra,0x0
    8000341a:	a2a080e7          	jalr	-1494(ra) # 80002e40 <iput>
    return -1;
    8000341e:	557d                	li	a0,-1
    80003420:	b7dd                	j	80003406 <dirlink+0x86>
      panic("dirlink read");
    80003422:	00005517          	auipc	a0,0x5
    80003426:	19e50513          	addi	a0,a0,414 # 800085c0 <syscalls+0x1c8>
    8000342a:	00003097          	auipc	ra,0x3
    8000342e:	8d6080e7          	jalr	-1834(ra) # 80005d00 <panic>
    panic("dirlink");
    80003432:	00005517          	auipc	a0,0x5
    80003436:	29e50513          	addi	a0,a0,670 # 800086d0 <syscalls+0x2d8>
    8000343a:	00003097          	auipc	ra,0x3
    8000343e:	8c6080e7          	jalr	-1850(ra) # 80005d00 <panic>

0000000080003442 <namei>:

struct inode*
namei(char *path)
{
    80003442:	1101                	addi	sp,sp,-32
    80003444:	ec06                	sd	ra,24(sp)
    80003446:	e822                	sd	s0,16(sp)
    80003448:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    8000344a:	fe040613          	addi	a2,s0,-32
    8000344e:	4581                	li	a1,0
    80003450:	00000097          	auipc	ra,0x0
    80003454:	dca080e7          	jalr	-566(ra) # 8000321a <namex>
}
    80003458:	60e2                	ld	ra,24(sp)
    8000345a:	6442                	ld	s0,16(sp)
    8000345c:	6105                	addi	sp,sp,32
    8000345e:	8082                	ret

0000000080003460 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003460:	1141                	addi	sp,sp,-16
    80003462:	e406                	sd	ra,8(sp)
    80003464:	e022                	sd	s0,0(sp)
    80003466:	0800                	addi	s0,sp,16
    80003468:	862e                	mv	a2,a1
  return namex(path, 1, name);
    8000346a:	4585                	li	a1,1
    8000346c:	00000097          	auipc	ra,0x0
    80003470:	dae080e7          	jalr	-594(ra) # 8000321a <namex>
}
    80003474:	60a2                	ld	ra,8(sp)
    80003476:	6402                	ld	s0,0(sp)
    80003478:	0141                	addi	sp,sp,16
    8000347a:	8082                	ret

000000008000347c <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000347c:	1101                	addi	sp,sp,-32
    8000347e:	ec06                	sd	ra,24(sp)
    80003480:	e822                	sd	s0,16(sp)
    80003482:	e426                	sd	s1,8(sp)
    80003484:	e04a                	sd	s2,0(sp)
    80003486:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003488:	00236917          	auipc	s2,0x236
    8000348c:	b9890913          	addi	s2,s2,-1128 # 80239020 <log>
    80003490:	01892583          	lw	a1,24(s2)
    80003494:	02892503          	lw	a0,40(s2)
    80003498:	fffff097          	auipc	ra,0xfffff
    8000349c:	fec080e7          	jalr	-20(ra) # 80002484 <bread>
    800034a0:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800034a2:	02c92683          	lw	a3,44(s2)
    800034a6:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    800034a8:	02d05863          	blez	a3,800034d8 <write_head+0x5c>
    800034ac:	00236797          	auipc	a5,0x236
    800034b0:	ba478793          	addi	a5,a5,-1116 # 80239050 <log+0x30>
    800034b4:	05c50713          	addi	a4,a0,92
    800034b8:	36fd                	addiw	a3,a3,-1
    800034ba:	02069613          	slli	a2,a3,0x20
    800034be:	01e65693          	srli	a3,a2,0x1e
    800034c2:	00236617          	auipc	a2,0x236
    800034c6:	b9260613          	addi	a2,a2,-1134 # 80239054 <log+0x34>
    800034ca:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    800034cc:	4390                	lw	a2,0(a5)
    800034ce:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800034d0:	0791                	addi	a5,a5,4
    800034d2:	0711                	addi	a4,a4,4 # 43004 <_entry-0x7ffbcffc>
    800034d4:	fed79ce3          	bne	a5,a3,800034cc <write_head+0x50>
  }
  bwrite(buf);
    800034d8:	8526                	mv	a0,s1
    800034da:	fffff097          	auipc	ra,0xfffff
    800034de:	09c080e7          	jalr	156(ra) # 80002576 <bwrite>
  brelse(buf);
    800034e2:	8526                	mv	a0,s1
    800034e4:	fffff097          	auipc	ra,0xfffff
    800034e8:	0d0080e7          	jalr	208(ra) # 800025b4 <brelse>
}
    800034ec:	60e2                	ld	ra,24(sp)
    800034ee:	6442                	ld	s0,16(sp)
    800034f0:	64a2                	ld	s1,8(sp)
    800034f2:	6902                	ld	s2,0(sp)
    800034f4:	6105                	addi	sp,sp,32
    800034f6:	8082                	ret

00000000800034f8 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800034f8:	00236797          	auipc	a5,0x236
    800034fc:	b547a783          	lw	a5,-1196(a5) # 8023904c <log+0x2c>
    80003500:	0af05d63          	blez	a5,800035ba <install_trans+0xc2>
{
    80003504:	7139                	addi	sp,sp,-64
    80003506:	fc06                	sd	ra,56(sp)
    80003508:	f822                	sd	s0,48(sp)
    8000350a:	f426                	sd	s1,40(sp)
    8000350c:	f04a                	sd	s2,32(sp)
    8000350e:	ec4e                	sd	s3,24(sp)
    80003510:	e852                	sd	s4,16(sp)
    80003512:	e456                	sd	s5,8(sp)
    80003514:	e05a                	sd	s6,0(sp)
    80003516:	0080                	addi	s0,sp,64
    80003518:	8b2a                	mv	s6,a0
    8000351a:	00236a97          	auipc	s5,0x236
    8000351e:	b36a8a93          	addi	s5,s5,-1226 # 80239050 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003522:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003524:	00236997          	auipc	s3,0x236
    80003528:	afc98993          	addi	s3,s3,-1284 # 80239020 <log>
    8000352c:	a00d                	j	8000354e <install_trans+0x56>
    brelse(lbuf);
    8000352e:	854a                	mv	a0,s2
    80003530:	fffff097          	auipc	ra,0xfffff
    80003534:	084080e7          	jalr	132(ra) # 800025b4 <brelse>
    brelse(dbuf);
    80003538:	8526                	mv	a0,s1
    8000353a:	fffff097          	auipc	ra,0xfffff
    8000353e:	07a080e7          	jalr	122(ra) # 800025b4 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003542:	2a05                	addiw	s4,s4,1
    80003544:	0a91                	addi	s5,s5,4
    80003546:	02c9a783          	lw	a5,44(s3)
    8000354a:	04fa5e63          	bge	s4,a5,800035a6 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000354e:	0189a583          	lw	a1,24(s3)
    80003552:	014585bb          	addw	a1,a1,s4
    80003556:	2585                	addiw	a1,a1,1
    80003558:	0289a503          	lw	a0,40(s3)
    8000355c:	fffff097          	auipc	ra,0xfffff
    80003560:	f28080e7          	jalr	-216(ra) # 80002484 <bread>
    80003564:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80003566:	000aa583          	lw	a1,0(s5)
    8000356a:	0289a503          	lw	a0,40(s3)
    8000356e:	fffff097          	auipc	ra,0xfffff
    80003572:	f16080e7          	jalr	-234(ra) # 80002484 <bread>
    80003576:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003578:	40000613          	li	a2,1024
    8000357c:	05890593          	addi	a1,s2,88
    80003580:	05850513          	addi	a0,a0,88
    80003584:	ffffd097          	auipc	ra,0xffffd
    80003588:	d94080e7          	jalr	-620(ra) # 80000318 <memmove>
    bwrite(dbuf);  // write dst to disk
    8000358c:	8526                	mv	a0,s1
    8000358e:	fffff097          	auipc	ra,0xfffff
    80003592:	fe8080e7          	jalr	-24(ra) # 80002576 <bwrite>
    if(recovering == 0)
    80003596:	f80b1ce3          	bnez	s6,8000352e <install_trans+0x36>
      bunpin(dbuf);
    8000359a:	8526                	mv	a0,s1
    8000359c:	fffff097          	auipc	ra,0xfffff
    800035a0:	0f2080e7          	jalr	242(ra) # 8000268e <bunpin>
    800035a4:	b769                	j	8000352e <install_trans+0x36>
}
    800035a6:	70e2                	ld	ra,56(sp)
    800035a8:	7442                	ld	s0,48(sp)
    800035aa:	74a2                	ld	s1,40(sp)
    800035ac:	7902                	ld	s2,32(sp)
    800035ae:	69e2                	ld	s3,24(sp)
    800035b0:	6a42                	ld	s4,16(sp)
    800035b2:	6aa2                	ld	s5,8(sp)
    800035b4:	6b02                	ld	s6,0(sp)
    800035b6:	6121                	addi	sp,sp,64
    800035b8:	8082                	ret
    800035ba:	8082                	ret

00000000800035bc <initlog>:
{
    800035bc:	7179                	addi	sp,sp,-48
    800035be:	f406                	sd	ra,40(sp)
    800035c0:	f022                	sd	s0,32(sp)
    800035c2:	ec26                	sd	s1,24(sp)
    800035c4:	e84a                	sd	s2,16(sp)
    800035c6:	e44e                	sd	s3,8(sp)
    800035c8:	1800                	addi	s0,sp,48
    800035ca:	892a                	mv	s2,a0
    800035cc:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    800035ce:	00236497          	auipc	s1,0x236
    800035d2:	a5248493          	addi	s1,s1,-1454 # 80239020 <log>
    800035d6:	00005597          	auipc	a1,0x5
    800035da:	ffa58593          	addi	a1,a1,-6 # 800085d0 <syscalls+0x1d8>
    800035de:	8526                	mv	a0,s1
    800035e0:	00003097          	auipc	ra,0x3
    800035e4:	bc8080e7          	jalr	-1080(ra) # 800061a8 <initlock>
  log.start = sb->logstart;
    800035e8:	0149a583          	lw	a1,20(s3)
    800035ec:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    800035ee:	0109a783          	lw	a5,16(s3)
    800035f2:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    800035f4:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    800035f8:	854a                	mv	a0,s2
    800035fa:	fffff097          	auipc	ra,0xfffff
    800035fe:	e8a080e7          	jalr	-374(ra) # 80002484 <bread>
  log.lh.n = lh->n;
    80003602:	4d34                	lw	a3,88(a0)
    80003604:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80003606:	02d05663          	blez	a3,80003632 <initlog+0x76>
    8000360a:	05c50793          	addi	a5,a0,92
    8000360e:	00236717          	auipc	a4,0x236
    80003612:	a4270713          	addi	a4,a4,-1470 # 80239050 <log+0x30>
    80003616:	36fd                	addiw	a3,a3,-1
    80003618:	02069613          	slli	a2,a3,0x20
    8000361c:	01e65693          	srli	a3,a2,0x1e
    80003620:	06050613          	addi	a2,a0,96
    80003624:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    80003626:	4390                	lw	a2,0(a5)
    80003628:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000362a:	0791                	addi	a5,a5,4
    8000362c:	0711                	addi	a4,a4,4
    8000362e:	fed79ce3          	bne	a5,a3,80003626 <initlog+0x6a>
  brelse(buf);
    80003632:	fffff097          	auipc	ra,0xfffff
    80003636:	f82080e7          	jalr	-126(ra) # 800025b4 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    8000363a:	4505                	li	a0,1
    8000363c:	00000097          	auipc	ra,0x0
    80003640:	ebc080e7          	jalr	-324(ra) # 800034f8 <install_trans>
  log.lh.n = 0;
    80003644:	00236797          	auipc	a5,0x236
    80003648:	a007a423          	sw	zero,-1528(a5) # 8023904c <log+0x2c>
  write_head(); // clear the log
    8000364c:	00000097          	auipc	ra,0x0
    80003650:	e30080e7          	jalr	-464(ra) # 8000347c <write_head>
}
    80003654:	70a2                	ld	ra,40(sp)
    80003656:	7402                	ld	s0,32(sp)
    80003658:	64e2                	ld	s1,24(sp)
    8000365a:	6942                	ld	s2,16(sp)
    8000365c:	69a2                	ld	s3,8(sp)
    8000365e:	6145                	addi	sp,sp,48
    80003660:	8082                	ret

0000000080003662 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003662:	1101                	addi	sp,sp,-32
    80003664:	ec06                	sd	ra,24(sp)
    80003666:	e822                	sd	s0,16(sp)
    80003668:	e426                	sd	s1,8(sp)
    8000366a:	e04a                	sd	s2,0(sp)
    8000366c:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    8000366e:	00236517          	auipc	a0,0x236
    80003672:	9b250513          	addi	a0,a0,-1614 # 80239020 <log>
    80003676:	00003097          	auipc	ra,0x3
    8000367a:	bc2080e7          	jalr	-1086(ra) # 80006238 <acquire>
  while(1){
    if(log.committing){
    8000367e:	00236497          	auipc	s1,0x236
    80003682:	9a248493          	addi	s1,s1,-1630 # 80239020 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003686:	4979                	li	s2,30
    80003688:	a039                	j	80003696 <begin_op+0x34>
      sleep(&log, &log.lock);
    8000368a:	85a6                	mv	a1,s1
    8000368c:	8526                	mv	a0,s1
    8000368e:	ffffe097          	auipc	ra,0xffffe
    80003692:	076080e7          	jalr	118(ra) # 80001704 <sleep>
    if(log.committing){
    80003696:	50dc                	lw	a5,36(s1)
    80003698:	fbed                	bnez	a5,8000368a <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000369a:	5098                	lw	a4,32(s1)
    8000369c:	2705                	addiw	a4,a4,1
    8000369e:	0007069b          	sext.w	a3,a4
    800036a2:	0027179b          	slliw	a5,a4,0x2
    800036a6:	9fb9                	addw	a5,a5,a4
    800036a8:	0017979b          	slliw	a5,a5,0x1
    800036ac:	54d8                	lw	a4,44(s1)
    800036ae:	9fb9                	addw	a5,a5,a4
    800036b0:	00f95963          	bge	s2,a5,800036c2 <begin_op+0x60>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800036b4:	85a6                	mv	a1,s1
    800036b6:	8526                	mv	a0,s1
    800036b8:	ffffe097          	auipc	ra,0xffffe
    800036bc:	04c080e7          	jalr	76(ra) # 80001704 <sleep>
    800036c0:	bfd9                	j	80003696 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800036c2:	00236517          	auipc	a0,0x236
    800036c6:	95e50513          	addi	a0,a0,-1698 # 80239020 <log>
    800036ca:	d114                	sw	a3,32(a0)
      release(&log.lock);
    800036cc:	00003097          	auipc	ra,0x3
    800036d0:	c20080e7          	jalr	-992(ra) # 800062ec <release>
      break;
    }
  }
}
    800036d4:	60e2                	ld	ra,24(sp)
    800036d6:	6442                	ld	s0,16(sp)
    800036d8:	64a2                	ld	s1,8(sp)
    800036da:	6902                	ld	s2,0(sp)
    800036dc:	6105                	addi	sp,sp,32
    800036de:	8082                	ret

00000000800036e0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800036e0:	7139                	addi	sp,sp,-64
    800036e2:	fc06                	sd	ra,56(sp)
    800036e4:	f822                	sd	s0,48(sp)
    800036e6:	f426                	sd	s1,40(sp)
    800036e8:	f04a                	sd	s2,32(sp)
    800036ea:	ec4e                	sd	s3,24(sp)
    800036ec:	e852                	sd	s4,16(sp)
    800036ee:	e456                	sd	s5,8(sp)
    800036f0:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800036f2:	00236497          	auipc	s1,0x236
    800036f6:	92e48493          	addi	s1,s1,-1746 # 80239020 <log>
    800036fa:	8526                	mv	a0,s1
    800036fc:	00003097          	auipc	ra,0x3
    80003700:	b3c080e7          	jalr	-1220(ra) # 80006238 <acquire>
  log.outstanding -= 1;
    80003704:	509c                	lw	a5,32(s1)
    80003706:	37fd                	addiw	a5,a5,-1
    80003708:	0007891b          	sext.w	s2,a5
    8000370c:	d09c                	sw	a5,32(s1)
  if(log.committing)
    8000370e:	50dc                	lw	a5,36(s1)
    80003710:	e7b9                	bnez	a5,8000375e <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    80003712:	04091e63          	bnez	s2,8000376e <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    80003716:	00236497          	auipc	s1,0x236
    8000371a:	90a48493          	addi	s1,s1,-1782 # 80239020 <log>
    8000371e:	4785                	li	a5,1
    80003720:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003722:	8526                	mv	a0,s1
    80003724:	00003097          	auipc	ra,0x3
    80003728:	bc8080e7          	jalr	-1080(ra) # 800062ec <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    8000372c:	54dc                	lw	a5,44(s1)
    8000372e:	06f04763          	bgtz	a5,8000379c <end_op+0xbc>
    acquire(&log.lock);
    80003732:	00236497          	auipc	s1,0x236
    80003736:	8ee48493          	addi	s1,s1,-1810 # 80239020 <log>
    8000373a:	8526                	mv	a0,s1
    8000373c:	00003097          	auipc	ra,0x3
    80003740:	afc080e7          	jalr	-1284(ra) # 80006238 <acquire>
    log.committing = 0;
    80003744:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80003748:	8526                	mv	a0,s1
    8000374a:	ffffe097          	auipc	ra,0xffffe
    8000374e:	146080e7          	jalr	326(ra) # 80001890 <wakeup>
    release(&log.lock);
    80003752:	8526                	mv	a0,s1
    80003754:	00003097          	auipc	ra,0x3
    80003758:	b98080e7          	jalr	-1128(ra) # 800062ec <release>
}
    8000375c:	a03d                	j	8000378a <end_op+0xaa>
    panic("log.committing");
    8000375e:	00005517          	auipc	a0,0x5
    80003762:	e7a50513          	addi	a0,a0,-390 # 800085d8 <syscalls+0x1e0>
    80003766:	00002097          	auipc	ra,0x2
    8000376a:	59a080e7          	jalr	1434(ra) # 80005d00 <panic>
    wakeup(&log);
    8000376e:	00236497          	auipc	s1,0x236
    80003772:	8b248493          	addi	s1,s1,-1870 # 80239020 <log>
    80003776:	8526                	mv	a0,s1
    80003778:	ffffe097          	auipc	ra,0xffffe
    8000377c:	118080e7          	jalr	280(ra) # 80001890 <wakeup>
  release(&log.lock);
    80003780:	8526                	mv	a0,s1
    80003782:	00003097          	auipc	ra,0x3
    80003786:	b6a080e7          	jalr	-1174(ra) # 800062ec <release>
}
    8000378a:	70e2                	ld	ra,56(sp)
    8000378c:	7442                	ld	s0,48(sp)
    8000378e:	74a2                	ld	s1,40(sp)
    80003790:	7902                	ld	s2,32(sp)
    80003792:	69e2                	ld	s3,24(sp)
    80003794:	6a42                	ld	s4,16(sp)
    80003796:	6aa2                	ld	s5,8(sp)
    80003798:	6121                	addi	sp,sp,64
    8000379a:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    8000379c:	00236a97          	auipc	s5,0x236
    800037a0:	8b4a8a93          	addi	s5,s5,-1868 # 80239050 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800037a4:	00236a17          	auipc	s4,0x236
    800037a8:	87ca0a13          	addi	s4,s4,-1924 # 80239020 <log>
    800037ac:	018a2583          	lw	a1,24(s4)
    800037b0:	012585bb          	addw	a1,a1,s2
    800037b4:	2585                	addiw	a1,a1,1
    800037b6:	028a2503          	lw	a0,40(s4)
    800037ba:	fffff097          	auipc	ra,0xfffff
    800037be:	cca080e7          	jalr	-822(ra) # 80002484 <bread>
    800037c2:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800037c4:	000aa583          	lw	a1,0(s5)
    800037c8:	028a2503          	lw	a0,40(s4)
    800037cc:	fffff097          	auipc	ra,0xfffff
    800037d0:	cb8080e7          	jalr	-840(ra) # 80002484 <bread>
    800037d4:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800037d6:	40000613          	li	a2,1024
    800037da:	05850593          	addi	a1,a0,88
    800037de:	05848513          	addi	a0,s1,88
    800037e2:	ffffd097          	auipc	ra,0xffffd
    800037e6:	b36080e7          	jalr	-1226(ra) # 80000318 <memmove>
    bwrite(to);  // write the log
    800037ea:	8526                	mv	a0,s1
    800037ec:	fffff097          	auipc	ra,0xfffff
    800037f0:	d8a080e7          	jalr	-630(ra) # 80002576 <bwrite>
    brelse(from);
    800037f4:	854e                	mv	a0,s3
    800037f6:	fffff097          	auipc	ra,0xfffff
    800037fa:	dbe080e7          	jalr	-578(ra) # 800025b4 <brelse>
    brelse(to);
    800037fe:	8526                	mv	a0,s1
    80003800:	fffff097          	auipc	ra,0xfffff
    80003804:	db4080e7          	jalr	-588(ra) # 800025b4 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003808:	2905                	addiw	s2,s2,1
    8000380a:	0a91                	addi	s5,s5,4
    8000380c:	02ca2783          	lw	a5,44(s4)
    80003810:	f8f94ee3          	blt	s2,a5,800037ac <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003814:	00000097          	auipc	ra,0x0
    80003818:	c68080e7          	jalr	-920(ra) # 8000347c <write_head>
    install_trans(0); // Now install writes to home locations
    8000381c:	4501                	li	a0,0
    8000381e:	00000097          	auipc	ra,0x0
    80003822:	cda080e7          	jalr	-806(ra) # 800034f8 <install_trans>
    log.lh.n = 0;
    80003826:	00236797          	auipc	a5,0x236
    8000382a:	8207a323          	sw	zero,-2010(a5) # 8023904c <log+0x2c>
    write_head();    // Erase the transaction from the log
    8000382e:	00000097          	auipc	ra,0x0
    80003832:	c4e080e7          	jalr	-946(ra) # 8000347c <write_head>
    80003836:	bdf5                	j	80003732 <end_op+0x52>

0000000080003838 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80003838:	1101                	addi	sp,sp,-32
    8000383a:	ec06                	sd	ra,24(sp)
    8000383c:	e822                	sd	s0,16(sp)
    8000383e:	e426                	sd	s1,8(sp)
    80003840:	e04a                	sd	s2,0(sp)
    80003842:	1000                	addi	s0,sp,32
    80003844:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80003846:	00235917          	auipc	s2,0x235
    8000384a:	7da90913          	addi	s2,s2,2010 # 80239020 <log>
    8000384e:	854a                	mv	a0,s2
    80003850:	00003097          	auipc	ra,0x3
    80003854:	9e8080e7          	jalr	-1560(ra) # 80006238 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003858:	02c92603          	lw	a2,44(s2)
    8000385c:	47f5                	li	a5,29
    8000385e:	06c7c563          	blt	a5,a2,800038c8 <log_write+0x90>
    80003862:	00235797          	auipc	a5,0x235
    80003866:	7da7a783          	lw	a5,2010(a5) # 8023903c <log+0x1c>
    8000386a:	37fd                	addiw	a5,a5,-1
    8000386c:	04f65e63          	bge	a2,a5,800038c8 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003870:	00235797          	auipc	a5,0x235
    80003874:	7d07a783          	lw	a5,2000(a5) # 80239040 <log+0x20>
    80003878:	06f05063          	blez	a5,800038d8 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    8000387c:	4781                	li	a5,0
    8000387e:	06c05563          	blez	a2,800038e8 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003882:	44cc                	lw	a1,12(s1)
    80003884:	00235717          	auipc	a4,0x235
    80003888:	7cc70713          	addi	a4,a4,1996 # 80239050 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    8000388c:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000388e:	4314                	lw	a3,0(a4)
    80003890:	04b68c63          	beq	a3,a1,800038e8 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80003894:	2785                	addiw	a5,a5,1
    80003896:	0711                	addi	a4,a4,4
    80003898:	fef61be3          	bne	a2,a5,8000388e <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000389c:	0621                	addi	a2,a2,8
    8000389e:	060a                	slli	a2,a2,0x2
    800038a0:	00235797          	auipc	a5,0x235
    800038a4:	78078793          	addi	a5,a5,1920 # 80239020 <log>
    800038a8:	97b2                	add	a5,a5,a2
    800038aa:	44d8                	lw	a4,12(s1)
    800038ac:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800038ae:	8526                	mv	a0,s1
    800038b0:	fffff097          	auipc	ra,0xfffff
    800038b4:	da2080e7          	jalr	-606(ra) # 80002652 <bpin>
    log.lh.n++;
    800038b8:	00235717          	auipc	a4,0x235
    800038bc:	76870713          	addi	a4,a4,1896 # 80239020 <log>
    800038c0:	575c                	lw	a5,44(a4)
    800038c2:	2785                	addiw	a5,a5,1
    800038c4:	d75c                	sw	a5,44(a4)
    800038c6:	a82d                	j	80003900 <log_write+0xc8>
    panic("too big a transaction");
    800038c8:	00005517          	auipc	a0,0x5
    800038cc:	d2050513          	addi	a0,a0,-736 # 800085e8 <syscalls+0x1f0>
    800038d0:	00002097          	auipc	ra,0x2
    800038d4:	430080e7          	jalr	1072(ra) # 80005d00 <panic>
    panic("log_write outside of trans");
    800038d8:	00005517          	auipc	a0,0x5
    800038dc:	d2850513          	addi	a0,a0,-728 # 80008600 <syscalls+0x208>
    800038e0:	00002097          	auipc	ra,0x2
    800038e4:	420080e7          	jalr	1056(ra) # 80005d00 <panic>
  log.lh.block[i] = b->blockno;
    800038e8:	00878693          	addi	a3,a5,8
    800038ec:	068a                	slli	a3,a3,0x2
    800038ee:	00235717          	auipc	a4,0x235
    800038f2:	73270713          	addi	a4,a4,1842 # 80239020 <log>
    800038f6:	9736                	add	a4,a4,a3
    800038f8:	44d4                	lw	a3,12(s1)
    800038fa:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800038fc:	faf609e3          	beq	a2,a5,800038ae <log_write+0x76>
  }
  release(&log.lock);
    80003900:	00235517          	auipc	a0,0x235
    80003904:	72050513          	addi	a0,a0,1824 # 80239020 <log>
    80003908:	00003097          	auipc	ra,0x3
    8000390c:	9e4080e7          	jalr	-1564(ra) # 800062ec <release>
}
    80003910:	60e2                	ld	ra,24(sp)
    80003912:	6442                	ld	s0,16(sp)
    80003914:	64a2                	ld	s1,8(sp)
    80003916:	6902                	ld	s2,0(sp)
    80003918:	6105                	addi	sp,sp,32
    8000391a:	8082                	ret

000000008000391c <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    8000391c:	1101                	addi	sp,sp,-32
    8000391e:	ec06                	sd	ra,24(sp)
    80003920:	e822                	sd	s0,16(sp)
    80003922:	e426                	sd	s1,8(sp)
    80003924:	e04a                	sd	s2,0(sp)
    80003926:	1000                	addi	s0,sp,32
    80003928:	84aa                	mv	s1,a0
    8000392a:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    8000392c:	00005597          	auipc	a1,0x5
    80003930:	cf458593          	addi	a1,a1,-780 # 80008620 <syscalls+0x228>
    80003934:	0521                	addi	a0,a0,8
    80003936:	00003097          	auipc	ra,0x3
    8000393a:	872080e7          	jalr	-1934(ra) # 800061a8 <initlock>
  lk->name = name;
    8000393e:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003942:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003946:	0204a423          	sw	zero,40(s1)
}
    8000394a:	60e2                	ld	ra,24(sp)
    8000394c:	6442                	ld	s0,16(sp)
    8000394e:	64a2                	ld	s1,8(sp)
    80003950:	6902                	ld	s2,0(sp)
    80003952:	6105                	addi	sp,sp,32
    80003954:	8082                	ret

0000000080003956 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003956:	1101                	addi	sp,sp,-32
    80003958:	ec06                	sd	ra,24(sp)
    8000395a:	e822                	sd	s0,16(sp)
    8000395c:	e426                	sd	s1,8(sp)
    8000395e:	e04a                	sd	s2,0(sp)
    80003960:	1000                	addi	s0,sp,32
    80003962:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003964:	00850913          	addi	s2,a0,8
    80003968:	854a                	mv	a0,s2
    8000396a:	00003097          	auipc	ra,0x3
    8000396e:	8ce080e7          	jalr	-1842(ra) # 80006238 <acquire>
  while (lk->locked) {
    80003972:	409c                	lw	a5,0(s1)
    80003974:	cb89                	beqz	a5,80003986 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003976:	85ca                	mv	a1,s2
    80003978:	8526                	mv	a0,s1
    8000397a:	ffffe097          	auipc	ra,0xffffe
    8000397e:	d8a080e7          	jalr	-630(ra) # 80001704 <sleep>
  while (lk->locked) {
    80003982:	409c                	lw	a5,0(s1)
    80003984:	fbed                	bnez	a5,80003976 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003986:	4785                	li	a5,1
    80003988:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    8000398a:	ffffd097          	auipc	ra,0xffffd
    8000398e:	6b6080e7          	jalr	1718(ra) # 80001040 <myproc>
    80003992:	591c                	lw	a5,48(a0)
    80003994:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003996:	854a                	mv	a0,s2
    80003998:	00003097          	auipc	ra,0x3
    8000399c:	954080e7          	jalr	-1708(ra) # 800062ec <release>
}
    800039a0:	60e2                	ld	ra,24(sp)
    800039a2:	6442                	ld	s0,16(sp)
    800039a4:	64a2                	ld	s1,8(sp)
    800039a6:	6902                	ld	s2,0(sp)
    800039a8:	6105                	addi	sp,sp,32
    800039aa:	8082                	ret

00000000800039ac <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800039ac:	1101                	addi	sp,sp,-32
    800039ae:	ec06                	sd	ra,24(sp)
    800039b0:	e822                	sd	s0,16(sp)
    800039b2:	e426                	sd	s1,8(sp)
    800039b4:	e04a                	sd	s2,0(sp)
    800039b6:	1000                	addi	s0,sp,32
    800039b8:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800039ba:	00850913          	addi	s2,a0,8
    800039be:	854a                	mv	a0,s2
    800039c0:	00003097          	auipc	ra,0x3
    800039c4:	878080e7          	jalr	-1928(ra) # 80006238 <acquire>
  lk->locked = 0;
    800039c8:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800039cc:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    800039d0:	8526                	mv	a0,s1
    800039d2:	ffffe097          	auipc	ra,0xffffe
    800039d6:	ebe080e7          	jalr	-322(ra) # 80001890 <wakeup>
  release(&lk->lk);
    800039da:	854a                	mv	a0,s2
    800039dc:	00003097          	auipc	ra,0x3
    800039e0:	910080e7          	jalr	-1776(ra) # 800062ec <release>
}
    800039e4:	60e2                	ld	ra,24(sp)
    800039e6:	6442                	ld	s0,16(sp)
    800039e8:	64a2                	ld	s1,8(sp)
    800039ea:	6902                	ld	s2,0(sp)
    800039ec:	6105                	addi	sp,sp,32
    800039ee:	8082                	ret

00000000800039f0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800039f0:	7179                	addi	sp,sp,-48
    800039f2:	f406                	sd	ra,40(sp)
    800039f4:	f022                	sd	s0,32(sp)
    800039f6:	ec26                	sd	s1,24(sp)
    800039f8:	e84a                	sd	s2,16(sp)
    800039fa:	e44e                	sd	s3,8(sp)
    800039fc:	1800                	addi	s0,sp,48
    800039fe:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003a00:	00850913          	addi	s2,a0,8
    80003a04:	854a                	mv	a0,s2
    80003a06:	00003097          	auipc	ra,0x3
    80003a0a:	832080e7          	jalr	-1998(ra) # 80006238 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003a0e:	409c                	lw	a5,0(s1)
    80003a10:	ef99                	bnez	a5,80003a2e <holdingsleep+0x3e>
    80003a12:	4481                	li	s1,0
  release(&lk->lk);
    80003a14:	854a                	mv	a0,s2
    80003a16:	00003097          	auipc	ra,0x3
    80003a1a:	8d6080e7          	jalr	-1834(ra) # 800062ec <release>
  return r;
}
    80003a1e:	8526                	mv	a0,s1
    80003a20:	70a2                	ld	ra,40(sp)
    80003a22:	7402                	ld	s0,32(sp)
    80003a24:	64e2                	ld	s1,24(sp)
    80003a26:	6942                	ld	s2,16(sp)
    80003a28:	69a2                	ld	s3,8(sp)
    80003a2a:	6145                	addi	sp,sp,48
    80003a2c:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003a2e:	0284a983          	lw	s3,40(s1)
    80003a32:	ffffd097          	auipc	ra,0xffffd
    80003a36:	60e080e7          	jalr	1550(ra) # 80001040 <myproc>
    80003a3a:	5904                	lw	s1,48(a0)
    80003a3c:	413484b3          	sub	s1,s1,s3
    80003a40:	0014b493          	seqz	s1,s1
    80003a44:	bfc1                	j	80003a14 <holdingsleep+0x24>

0000000080003a46 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003a46:	1141                	addi	sp,sp,-16
    80003a48:	e406                	sd	ra,8(sp)
    80003a4a:	e022                	sd	s0,0(sp)
    80003a4c:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003a4e:	00005597          	auipc	a1,0x5
    80003a52:	be258593          	addi	a1,a1,-1054 # 80008630 <syscalls+0x238>
    80003a56:	00235517          	auipc	a0,0x235
    80003a5a:	71250513          	addi	a0,a0,1810 # 80239168 <ftable>
    80003a5e:	00002097          	auipc	ra,0x2
    80003a62:	74a080e7          	jalr	1866(ra) # 800061a8 <initlock>
}
    80003a66:	60a2                	ld	ra,8(sp)
    80003a68:	6402                	ld	s0,0(sp)
    80003a6a:	0141                	addi	sp,sp,16
    80003a6c:	8082                	ret

0000000080003a6e <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003a6e:	1101                	addi	sp,sp,-32
    80003a70:	ec06                	sd	ra,24(sp)
    80003a72:	e822                	sd	s0,16(sp)
    80003a74:	e426                	sd	s1,8(sp)
    80003a76:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003a78:	00235517          	auipc	a0,0x235
    80003a7c:	6f050513          	addi	a0,a0,1776 # 80239168 <ftable>
    80003a80:	00002097          	auipc	ra,0x2
    80003a84:	7b8080e7          	jalr	1976(ra) # 80006238 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003a88:	00235497          	auipc	s1,0x235
    80003a8c:	6f848493          	addi	s1,s1,1784 # 80239180 <ftable+0x18>
    80003a90:	00236717          	auipc	a4,0x236
    80003a94:	69070713          	addi	a4,a4,1680 # 8023a120 <ftable+0xfb8>
    if(f->ref == 0){
    80003a98:	40dc                	lw	a5,4(s1)
    80003a9a:	cf99                	beqz	a5,80003ab8 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003a9c:	02848493          	addi	s1,s1,40
    80003aa0:	fee49ce3          	bne	s1,a4,80003a98 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003aa4:	00235517          	auipc	a0,0x235
    80003aa8:	6c450513          	addi	a0,a0,1732 # 80239168 <ftable>
    80003aac:	00003097          	auipc	ra,0x3
    80003ab0:	840080e7          	jalr	-1984(ra) # 800062ec <release>
  return 0;
    80003ab4:	4481                	li	s1,0
    80003ab6:	a819                	j	80003acc <filealloc+0x5e>
      f->ref = 1;
    80003ab8:	4785                	li	a5,1
    80003aba:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003abc:	00235517          	auipc	a0,0x235
    80003ac0:	6ac50513          	addi	a0,a0,1708 # 80239168 <ftable>
    80003ac4:	00003097          	auipc	ra,0x3
    80003ac8:	828080e7          	jalr	-2008(ra) # 800062ec <release>
}
    80003acc:	8526                	mv	a0,s1
    80003ace:	60e2                	ld	ra,24(sp)
    80003ad0:	6442                	ld	s0,16(sp)
    80003ad2:	64a2                	ld	s1,8(sp)
    80003ad4:	6105                	addi	sp,sp,32
    80003ad6:	8082                	ret

0000000080003ad8 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003ad8:	1101                	addi	sp,sp,-32
    80003ada:	ec06                	sd	ra,24(sp)
    80003adc:	e822                	sd	s0,16(sp)
    80003ade:	e426                	sd	s1,8(sp)
    80003ae0:	1000                	addi	s0,sp,32
    80003ae2:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003ae4:	00235517          	auipc	a0,0x235
    80003ae8:	68450513          	addi	a0,a0,1668 # 80239168 <ftable>
    80003aec:	00002097          	auipc	ra,0x2
    80003af0:	74c080e7          	jalr	1868(ra) # 80006238 <acquire>
  if(f->ref < 1)
    80003af4:	40dc                	lw	a5,4(s1)
    80003af6:	02f05263          	blez	a5,80003b1a <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003afa:	2785                	addiw	a5,a5,1
    80003afc:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003afe:	00235517          	auipc	a0,0x235
    80003b02:	66a50513          	addi	a0,a0,1642 # 80239168 <ftable>
    80003b06:	00002097          	auipc	ra,0x2
    80003b0a:	7e6080e7          	jalr	2022(ra) # 800062ec <release>
  return f;
}
    80003b0e:	8526                	mv	a0,s1
    80003b10:	60e2                	ld	ra,24(sp)
    80003b12:	6442                	ld	s0,16(sp)
    80003b14:	64a2                	ld	s1,8(sp)
    80003b16:	6105                	addi	sp,sp,32
    80003b18:	8082                	ret
    panic("filedup");
    80003b1a:	00005517          	auipc	a0,0x5
    80003b1e:	b1e50513          	addi	a0,a0,-1250 # 80008638 <syscalls+0x240>
    80003b22:	00002097          	auipc	ra,0x2
    80003b26:	1de080e7          	jalr	478(ra) # 80005d00 <panic>

0000000080003b2a <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003b2a:	7139                	addi	sp,sp,-64
    80003b2c:	fc06                	sd	ra,56(sp)
    80003b2e:	f822                	sd	s0,48(sp)
    80003b30:	f426                	sd	s1,40(sp)
    80003b32:	f04a                	sd	s2,32(sp)
    80003b34:	ec4e                	sd	s3,24(sp)
    80003b36:	e852                	sd	s4,16(sp)
    80003b38:	e456                	sd	s5,8(sp)
    80003b3a:	0080                	addi	s0,sp,64
    80003b3c:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003b3e:	00235517          	auipc	a0,0x235
    80003b42:	62a50513          	addi	a0,a0,1578 # 80239168 <ftable>
    80003b46:	00002097          	auipc	ra,0x2
    80003b4a:	6f2080e7          	jalr	1778(ra) # 80006238 <acquire>
  if(f->ref < 1)
    80003b4e:	40dc                	lw	a5,4(s1)
    80003b50:	06f05163          	blez	a5,80003bb2 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003b54:	37fd                	addiw	a5,a5,-1
    80003b56:	0007871b          	sext.w	a4,a5
    80003b5a:	c0dc                	sw	a5,4(s1)
    80003b5c:	06e04363          	bgtz	a4,80003bc2 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003b60:	0004a903          	lw	s2,0(s1)
    80003b64:	0094ca83          	lbu	s5,9(s1)
    80003b68:	0104ba03          	ld	s4,16(s1)
    80003b6c:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003b70:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003b74:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003b78:	00235517          	auipc	a0,0x235
    80003b7c:	5f050513          	addi	a0,a0,1520 # 80239168 <ftable>
    80003b80:	00002097          	auipc	ra,0x2
    80003b84:	76c080e7          	jalr	1900(ra) # 800062ec <release>

  if(ff.type == FD_PIPE){
    80003b88:	4785                	li	a5,1
    80003b8a:	04f90d63          	beq	s2,a5,80003be4 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003b8e:	3979                	addiw	s2,s2,-2
    80003b90:	4785                	li	a5,1
    80003b92:	0527e063          	bltu	a5,s2,80003bd2 <fileclose+0xa8>
    begin_op();
    80003b96:	00000097          	auipc	ra,0x0
    80003b9a:	acc080e7          	jalr	-1332(ra) # 80003662 <begin_op>
    iput(ff.ip);
    80003b9e:	854e                	mv	a0,s3
    80003ba0:	fffff097          	auipc	ra,0xfffff
    80003ba4:	2a0080e7          	jalr	672(ra) # 80002e40 <iput>
    end_op();
    80003ba8:	00000097          	auipc	ra,0x0
    80003bac:	b38080e7          	jalr	-1224(ra) # 800036e0 <end_op>
    80003bb0:	a00d                	j	80003bd2 <fileclose+0xa8>
    panic("fileclose");
    80003bb2:	00005517          	auipc	a0,0x5
    80003bb6:	a8e50513          	addi	a0,a0,-1394 # 80008640 <syscalls+0x248>
    80003bba:	00002097          	auipc	ra,0x2
    80003bbe:	146080e7          	jalr	326(ra) # 80005d00 <panic>
    release(&ftable.lock);
    80003bc2:	00235517          	auipc	a0,0x235
    80003bc6:	5a650513          	addi	a0,a0,1446 # 80239168 <ftable>
    80003bca:	00002097          	auipc	ra,0x2
    80003bce:	722080e7          	jalr	1826(ra) # 800062ec <release>
  }
}
    80003bd2:	70e2                	ld	ra,56(sp)
    80003bd4:	7442                	ld	s0,48(sp)
    80003bd6:	74a2                	ld	s1,40(sp)
    80003bd8:	7902                	ld	s2,32(sp)
    80003bda:	69e2                	ld	s3,24(sp)
    80003bdc:	6a42                	ld	s4,16(sp)
    80003bde:	6aa2                	ld	s5,8(sp)
    80003be0:	6121                	addi	sp,sp,64
    80003be2:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003be4:	85d6                	mv	a1,s5
    80003be6:	8552                	mv	a0,s4
    80003be8:	00000097          	auipc	ra,0x0
    80003bec:	34c080e7          	jalr	844(ra) # 80003f34 <pipeclose>
    80003bf0:	b7cd                	j	80003bd2 <fileclose+0xa8>

0000000080003bf2 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003bf2:	715d                	addi	sp,sp,-80
    80003bf4:	e486                	sd	ra,72(sp)
    80003bf6:	e0a2                	sd	s0,64(sp)
    80003bf8:	fc26                	sd	s1,56(sp)
    80003bfa:	f84a                	sd	s2,48(sp)
    80003bfc:	f44e                	sd	s3,40(sp)
    80003bfe:	0880                	addi	s0,sp,80
    80003c00:	84aa                	mv	s1,a0
    80003c02:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003c04:	ffffd097          	auipc	ra,0xffffd
    80003c08:	43c080e7          	jalr	1084(ra) # 80001040 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003c0c:	409c                	lw	a5,0(s1)
    80003c0e:	37f9                	addiw	a5,a5,-2
    80003c10:	4705                	li	a4,1
    80003c12:	04f76763          	bltu	a4,a5,80003c60 <filestat+0x6e>
    80003c16:	892a                	mv	s2,a0
    ilock(f->ip);
    80003c18:	6c88                	ld	a0,24(s1)
    80003c1a:	fffff097          	auipc	ra,0xfffff
    80003c1e:	06c080e7          	jalr	108(ra) # 80002c86 <ilock>
    stati(f->ip, &st);
    80003c22:	fb840593          	addi	a1,s0,-72
    80003c26:	6c88                	ld	a0,24(s1)
    80003c28:	fffff097          	auipc	ra,0xfffff
    80003c2c:	2e8080e7          	jalr	744(ra) # 80002f10 <stati>
    iunlock(f->ip);
    80003c30:	6c88                	ld	a0,24(s1)
    80003c32:	fffff097          	auipc	ra,0xfffff
    80003c36:	116080e7          	jalr	278(ra) # 80002d48 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003c3a:	46e1                	li	a3,24
    80003c3c:	fb840613          	addi	a2,s0,-72
    80003c40:	85ce                	mv	a1,s3
    80003c42:	05093503          	ld	a0,80(s2)
    80003c46:	ffffd097          	auipc	ra,0xffffd
    80003c4a:	06e080e7          	jalr	110(ra) # 80000cb4 <copyout>
    80003c4e:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003c52:	60a6                	ld	ra,72(sp)
    80003c54:	6406                	ld	s0,64(sp)
    80003c56:	74e2                	ld	s1,56(sp)
    80003c58:	7942                	ld	s2,48(sp)
    80003c5a:	79a2                	ld	s3,40(sp)
    80003c5c:	6161                	addi	sp,sp,80
    80003c5e:	8082                	ret
  return -1;
    80003c60:	557d                	li	a0,-1
    80003c62:	bfc5                	j	80003c52 <filestat+0x60>

0000000080003c64 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003c64:	7179                	addi	sp,sp,-48
    80003c66:	f406                	sd	ra,40(sp)
    80003c68:	f022                	sd	s0,32(sp)
    80003c6a:	ec26                	sd	s1,24(sp)
    80003c6c:	e84a                	sd	s2,16(sp)
    80003c6e:	e44e                	sd	s3,8(sp)
    80003c70:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003c72:	00854783          	lbu	a5,8(a0)
    80003c76:	c3d5                	beqz	a5,80003d1a <fileread+0xb6>
    80003c78:	84aa                	mv	s1,a0
    80003c7a:	89ae                	mv	s3,a1
    80003c7c:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003c7e:	411c                	lw	a5,0(a0)
    80003c80:	4705                	li	a4,1
    80003c82:	04e78963          	beq	a5,a4,80003cd4 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003c86:	470d                	li	a4,3
    80003c88:	04e78d63          	beq	a5,a4,80003ce2 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003c8c:	4709                	li	a4,2
    80003c8e:	06e79e63          	bne	a5,a4,80003d0a <fileread+0xa6>
    ilock(f->ip);
    80003c92:	6d08                	ld	a0,24(a0)
    80003c94:	fffff097          	auipc	ra,0xfffff
    80003c98:	ff2080e7          	jalr	-14(ra) # 80002c86 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003c9c:	874a                	mv	a4,s2
    80003c9e:	5094                	lw	a3,32(s1)
    80003ca0:	864e                	mv	a2,s3
    80003ca2:	4585                	li	a1,1
    80003ca4:	6c88                	ld	a0,24(s1)
    80003ca6:	fffff097          	auipc	ra,0xfffff
    80003caa:	294080e7          	jalr	660(ra) # 80002f3a <readi>
    80003cae:	892a                	mv	s2,a0
    80003cb0:	00a05563          	blez	a0,80003cba <fileread+0x56>
      f->off += r;
    80003cb4:	509c                	lw	a5,32(s1)
    80003cb6:	9fa9                	addw	a5,a5,a0
    80003cb8:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003cba:	6c88                	ld	a0,24(s1)
    80003cbc:	fffff097          	auipc	ra,0xfffff
    80003cc0:	08c080e7          	jalr	140(ra) # 80002d48 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003cc4:	854a                	mv	a0,s2
    80003cc6:	70a2                	ld	ra,40(sp)
    80003cc8:	7402                	ld	s0,32(sp)
    80003cca:	64e2                	ld	s1,24(sp)
    80003ccc:	6942                	ld	s2,16(sp)
    80003cce:	69a2                	ld	s3,8(sp)
    80003cd0:	6145                	addi	sp,sp,48
    80003cd2:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003cd4:	6908                	ld	a0,16(a0)
    80003cd6:	00000097          	auipc	ra,0x0
    80003cda:	3c0080e7          	jalr	960(ra) # 80004096 <piperead>
    80003cde:	892a                	mv	s2,a0
    80003ce0:	b7d5                	j	80003cc4 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003ce2:	02451783          	lh	a5,36(a0)
    80003ce6:	03079693          	slli	a3,a5,0x30
    80003cea:	92c1                	srli	a3,a3,0x30
    80003cec:	4725                	li	a4,9
    80003cee:	02d76863          	bltu	a4,a3,80003d1e <fileread+0xba>
    80003cf2:	0792                	slli	a5,a5,0x4
    80003cf4:	00235717          	auipc	a4,0x235
    80003cf8:	3d470713          	addi	a4,a4,980 # 802390c8 <devsw>
    80003cfc:	97ba                	add	a5,a5,a4
    80003cfe:	639c                	ld	a5,0(a5)
    80003d00:	c38d                	beqz	a5,80003d22 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003d02:	4505                	li	a0,1
    80003d04:	9782                	jalr	a5
    80003d06:	892a                	mv	s2,a0
    80003d08:	bf75                	j	80003cc4 <fileread+0x60>
    panic("fileread");
    80003d0a:	00005517          	auipc	a0,0x5
    80003d0e:	94650513          	addi	a0,a0,-1722 # 80008650 <syscalls+0x258>
    80003d12:	00002097          	auipc	ra,0x2
    80003d16:	fee080e7          	jalr	-18(ra) # 80005d00 <panic>
    return -1;
    80003d1a:	597d                	li	s2,-1
    80003d1c:	b765                	j	80003cc4 <fileread+0x60>
      return -1;
    80003d1e:	597d                	li	s2,-1
    80003d20:	b755                	j	80003cc4 <fileread+0x60>
    80003d22:	597d                	li	s2,-1
    80003d24:	b745                	j	80003cc4 <fileread+0x60>

0000000080003d26 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80003d26:	715d                	addi	sp,sp,-80
    80003d28:	e486                	sd	ra,72(sp)
    80003d2a:	e0a2                	sd	s0,64(sp)
    80003d2c:	fc26                	sd	s1,56(sp)
    80003d2e:	f84a                	sd	s2,48(sp)
    80003d30:	f44e                	sd	s3,40(sp)
    80003d32:	f052                	sd	s4,32(sp)
    80003d34:	ec56                	sd	s5,24(sp)
    80003d36:	e85a                	sd	s6,16(sp)
    80003d38:	e45e                	sd	s7,8(sp)
    80003d3a:	e062                	sd	s8,0(sp)
    80003d3c:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80003d3e:	00954783          	lbu	a5,9(a0)
    80003d42:	10078663          	beqz	a5,80003e4e <filewrite+0x128>
    80003d46:	892a                	mv	s2,a0
    80003d48:	8b2e                	mv	s6,a1
    80003d4a:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80003d4c:	411c                	lw	a5,0(a0)
    80003d4e:	4705                	li	a4,1
    80003d50:	02e78263          	beq	a5,a4,80003d74 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003d54:	470d                	li	a4,3
    80003d56:	02e78663          	beq	a5,a4,80003d82 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003d5a:	4709                	li	a4,2
    80003d5c:	0ee79163          	bne	a5,a4,80003e3e <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003d60:	0ac05d63          	blez	a2,80003e1a <filewrite+0xf4>
    int i = 0;
    80003d64:	4981                	li	s3,0
    80003d66:	6b85                	lui	s7,0x1
    80003d68:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003d6c:	6c05                	lui	s8,0x1
    80003d6e:	c00c0c1b          	addiw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    80003d72:	a861                	j	80003e0a <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80003d74:	6908                	ld	a0,16(a0)
    80003d76:	00000097          	auipc	ra,0x0
    80003d7a:	22e080e7          	jalr	558(ra) # 80003fa4 <pipewrite>
    80003d7e:	8a2a                	mv	s4,a0
    80003d80:	a045                	j	80003e20 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003d82:	02451783          	lh	a5,36(a0)
    80003d86:	03079693          	slli	a3,a5,0x30
    80003d8a:	92c1                	srli	a3,a3,0x30
    80003d8c:	4725                	li	a4,9
    80003d8e:	0cd76263          	bltu	a4,a3,80003e52 <filewrite+0x12c>
    80003d92:	0792                	slli	a5,a5,0x4
    80003d94:	00235717          	auipc	a4,0x235
    80003d98:	33470713          	addi	a4,a4,820 # 802390c8 <devsw>
    80003d9c:	97ba                	add	a5,a5,a4
    80003d9e:	679c                	ld	a5,8(a5)
    80003da0:	cbdd                	beqz	a5,80003e56 <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80003da2:	4505                	li	a0,1
    80003da4:	9782                	jalr	a5
    80003da6:	8a2a                	mv	s4,a0
    80003da8:	a8a5                	j	80003e20 <filewrite+0xfa>
    80003daa:	00048a9b          	sext.w	s5,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80003dae:	00000097          	auipc	ra,0x0
    80003db2:	8b4080e7          	jalr	-1868(ra) # 80003662 <begin_op>
      ilock(f->ip);
    80003db6:	01893503          	ld	a0,24(s2)
    80003dba:	fffff097          	auipc	ra,0xfffff
    80003dbe:	ecc080e7          	jalr	-308(ra) # 80002c86 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003dc2:	8756                	mv	a4,s5
    80003dc4:	02092683          	lw	a3,32(s2)
    80003dc8:	01698633          	add	a2,s3,s6
    80003dcc:	4585                	li	a1,1
    80003dce:	01893503          	ld	a0,24(s2)
    80003dd2:	fffff097          	auipc	ra,0xfffff
    80003dd6:	260080e7          	jalr	608(ra) # 80003032 <writei>
    80003dda:	84aa                	mv	s1,a0
    80003ddc:	00a05763          	blez	a0,80003dea <filewrite+0xc4>
        f->off += r;
    80003de0:	02092783          	lw	a5,32(s2)
    80003de4:	9fa9                	addw	a5,a5,a0
    80003de6:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003dea:	01893503          	ld	a0,24(s2)
    80003dee:	fffff097          	auipc	ra,0xfffff
    80003df2:	f5a080e7          	jalr	-166(ra) # 80002d48 <iunlock>
      end_op();
    80003df6:	00000097          	auipc	ra,0x0
    80003dfa:	8ea080e7          	jalr	-1814(ra) # 800036e0 <end_op>

      if(r != n1){
    80003dfe:	009a9f63          	bne	s5,s1,80003e1c <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80003e02:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003e06:	0149db63          	bge	s3,s4,80003e1c <filewrite+0xf6>
      int n1 = n - i;
    80003e0a:	413a04bb          	subw	s1,s4,s3
    80003e0e:	0004879b          	sext.w	a5,s1
    80003e12:	f8fbdce3          	bge	s7,a5,80003daa <filewrite+0x84>
    80003e16:	84e2                	mv	s1,s8
    80003e18:	bf49                	j	80003daa <filewrite+0x84>
    int i = 0;
    80003e1a:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80003e1c:	013a1f63          	bne	s4,s3,80003e3a <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003e20:	8552                	mv	a0,s4
    80003e22:	60a6                	ld	ra,72(sp)
    80003e24:	6406                	ld	s0,64(sp)
    80003e26:	74e2                	ld	s1,56(sp)
    80003e28:	7942                	ld	s2,48(sp)
    80003e2a:	79a2                	ld	s3,40(sp)
    80003e2c:	7a02                	ld	s4,32(sp)
    80003e2e:	6ae2                	ld	s5,24(sp)
    80003e30:	6b42                	ld	s6,16(sp)
    80003e32:	6ba2                	ld	s7,8(sp)
    80003e34:	6c02                	ld	s8,0(sp)
    80003e36:	6161                	addi	sp,sp,80
    80003e38:	8082                	ret
    ret = (i == n ? n : -1);
    80003e3a:	5a7d                	li	s4,-1
    80003e3c:	b7d5                	j	80003e20 <filewrite+0xfa>
    panic("filewrite");
    80003e3e:	00005517          	auipc	a0,0x5
    80003e42:	82250513          	addi	a0,a0,-2014 # 80008660 <syscalls+0x268>
    80003e46:	00002097          	auipc	ra,0x2
    80003e4a:	eba080e7          	jalr	-326(ra) # 80005d00 <panic>
    return -1;
    80003e4e:	5a7d                	li	s4,-1
    80003e50:	bfc1                	j	80003e20 <filewrite+0xfa>
      return -1;
    80003e52:	5a7d                	li	s4,-1
    80003e54:	b7f1                	j	80003e20 <filewrite+0xfa>
    80003e56:	5a7d                	li	s4,-1
    80003e58:	b7e1                	j	80003e20 <filewrite+0xfa>

0000000080003e5a <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003e5a:	7179                	addi	sp,sp,-48
    80003e5c:	f406                	sd	ra,40(sp)
    80003e5e:	f022                	sd	s0,32(sp)
    80003e60:	ec26                	sd	s1,24(sp)
    80003e62:	e84a                	sd	s2,16(sp)
    80003e64:	e44e                	sd	s3,8(sp)
    80003e66:	e052                	sd	s4,0(sp)
    80003e68:	1800                	addi	s0,sp,48
    80003e6a:	84aa                	mv	s1,a0
    80003e6c:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003e6e:	0005b023          	sd	zero,0(a1)
    80003e72:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003e76:	00000097          	auipc	ra,0x0
    80003e7a:	bf8080e7          	jalr	-1032(ra) # 80003a6e <filealloc>
    80003e7e:	e088                	sd	a0,0(s1)
    80003e80:	c551                	beqz	a0,80003f0c <pipealloc+0xb2>
    80003e82:	00000097          	auipc	ra,0x0
    80003e86:	bec080e7          	jalr	-1044(ra) # 80003a6e <filealloc>
    80003e8a:	00aa3023          	sd	a0,0(s4)
    80003e8e:	c92d                	beqz	a0,80003f00 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003e90:	ffffc097          	auipc	ra,0xffffc
    80003e94:	38e080e7          	jalr	910(ra) # 8000021e <kalloc>
    80003e98:	892a                	mv	s2,a0
    80003e9a:	c125                	beqz	a0,80003efa <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003e9c:	4985                	li	s3,1
    80003e9e:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003ea2:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003ea6:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003eaa:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003eae:	00004597          	auipc	a1,0x4
    80003eb2:	7c258593          	addi	a1,a1,1986 # 80008670 <syscalls+0x278>
    80003eb6:	00002097          	auipc	ra,0x2
    80003eba:	2f2080e7          	jalr	754(ra) # 800061a8 <initlock>
  (*f0)->type = FD_PIPE;
    80003ebe:	609c                	ld	a5,0(s1)
    80003ec0:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003ec4:	609c                	ld	a5,0(s1)
    80003ec6:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003eca:	609c                	ld	a5,0(s1)
    80003ecc:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003ed0:	609c                	ld	a5,0(s1)
    80003ed2:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003ed6:	000a3783          	ld	a5,0(s4)
    80003eda:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003ede:	000a3783          	ld	a5,0(s4)
    80003ee2:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003ee6:	000a3783          	ld	a5,0(s4)
    80003eea:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003eee:	000a3783          	ld	a5,0(s4)
    80003ef2:	0127b823          	sd	s2,16(a5)
  return 0;
    80003ef6:	4501                	li	a0,0
    80003ef8:	a025                	j	80003f20 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003efa:	6088                	ld	a0,0(s1)
    80003efc:	e501                	bnez	a0,80003f04 <pipealloc+0xaa>
    80003efe:	a039                	j	80003f0c <pipealloc+0xb2>
    80003f00:	6088                	ld	a0,0(s1)
    80003f02:	c51d                	beqz	a0,80003f30 <pipealloc+0xd6>
    fileclose(*f0);
    80003f04:	00000097          	auipc	ra,0x0
    80003f08:	c26080e7          	jalr	-986(ra) # 80003b2a <fileclose>
  if(*f1)
    80003f0c:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003f10:	557d                	li	a0,-1
  if(*f1)
    80003f12:	c799                	beqz	a5,80003f20 <pipealloc+0xc6>
    fileclose(*f1);
    80003f14:	853e                	mv	a0,a5
    80003f16:	00000097          	auipc	ra,0x0
    80003f1a:	c14080e7          	jalr	-1004(ra) # 80003b2a <fileclose>
  return -1;
    80003f1e:	557d                	li	a0,-1
}
    80003f20:	70a2                	ld	ra,40(sp)
    80003f22:	7402                	ld	s0,32(sp)
    80003f24:	64e2                	ld	s1,24(sp)
    80003f26:	6942                	ld	s2,16(sp)
    80003f28:	69a2                	ld	s3,8(sp)
    80003f2a:	6a02                	ld	s4,0(sp)
    80003f2c:	6145                	addi	sp,sp,48
    80003f2e:	8082                	ret
  return -1;
    80003f30:	557d                	li	a0,-1
    80003f32:	b7fd                	j	80003f20 <pipealloc+0xc6>

0000000080003f34 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003f34:	1101                	addi	sp,sp,-32
    80003f36:	ec06                	sd	ra,24(sp)
    80003f38:	e822                	sd	s0,16(sp)
    80003f3a:	e426                	sd	s1,8(sp)
    80003f3c:	e04a                	sd	s2,0(sp)
    80003f3e:	1000                	addi	s0,sp,32
    80003f40:	84aa                	mv	s1,a0
    80003f42:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003f44:	00002097          	auipc	ra,0x2
    80003f48:	2f4080e7          	jalr	756(ra) # 80006238 <acquire>
  if(writable){
    80003f4c:	02090d63          	beqz	s2,80003f86 <pipeclose+0x52>
    pi->writeopen = 0;
    80003f50:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003f54:	21848513          	addi	a0,s1,536
    80003f58:	ffffe097          	auipc	ra,0xffffe
    80003f5c:	938080e7          	jalr	-1736(ra) # 80001890 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003f60:	2204b783          	ld	a5,544(s1)
    80003f64:	eb95                	bnez	a5,80003f98 <pipeclose+0x64>
    release(&pi->lock);
    80003f66:	8526                	mv	a0,s1
    80003f68:	00002097          	auipc	ra,0x2
    80003f6c:	384080e7          	jalr	900(ra) # 800062ec <release>
    kfree((char*)pi);
    80003f70:	8526                	mv	a0,s1
    80003f72:	ffffc097          	auipc	ra,0xffffc
    80003f76:	126080e7          	jalr	294(ra) # 80000098 <kfree>
  } else
    release(&pi->lock);
}
    80003f7a:	60e2                	ld	ra,24(sp)
    80003f7c:	6442                	ld	s0,16(sp)
    80003f7e:	64a2                	ld	s1,8(sp)
    80003f80:	6902                	ld	s2,0(sp)
    80003f82:	6105                	addi	sp,sp,32
    80003f84:	8082                	ret
    pi->readopen = 0;
    80003f86:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003f8a:	21c48513          	addi	a0,s1,540
    80003f8e:	ffffe097          	auipc	ra,0xffffe
    80003f92:	902080e7          	jalr	-1790(ra) # 80001890 <wakeup>
    80003f96:	b7e9                	j	80003f60 <pipeclose+0x2c>
    release(&pi->lock);
    80003f98:	8526                	mv	a0,s1
    80003f9a:	00002097          	auipc	ra,0x2
    80003f9e:	352080e7          	jalr	850(ra) # 800062ec <release>
}
    80003fa2:	bfe1                	j	80003f7a <pipeclose+0x46>

0000000080003fa4 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003fa4:	711d                	addi	sp,sp,-96
    80003fa6:	ec86                	sd	ra,88(sp)
    80003fa8:	e8a2                	sd	s0,80(sp)
    80003faa:	e4a6                	sd	s1,72(sp)
    80003fac:	e0ca                	sd	s2,64(sp)
    80003fae:	fc4e                	sd	s3,56(sp)
    80003fb0:	f852                	sd	s4,48(sp)
    80003fb2:	f456                	sd	s5,40(sp)
    80003fb4:	f05a                	sd	s6,32(sp)
    80003fb6:	ec5e                	sd	s7,24(sp)
    80003fb8:	e862                	sd	s8,16(sp)
    80003fba:	1080                	addi	s0,sp,96
    80003fbc:	84aa                	mv	s1,a0
    80003fbe:	8aae                	mv	s5,a1
    80003fc0:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003fc2:	ffffd097          	auipc	ra,0xffffd
    80003fc6:	07e080e7          	jalr	126(ra) # 80001040 <myproc>
    80003fca:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003fcc:	8526                	mv	a0,s1
    80003fce:	00002097          	auipc	ra,0x2
    80003fd2:	26a080e7          	jalr	618(ra) # 80006238 <acquire>
  while(i < n){
    80003fd6:	0b405363          	blez	s4,8000407c <pipewrite+0xd8>
  int i = 0;
    80003fda:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003fdc:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003fde:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003fe2:	21c48b93          	addi	s7,s1,540
    80003fe6:	a089                	j	80004028 <pipewrite+0x84>
      release(&pi->lock);
    80003fe8:	8526                	mv	a0,s1
    80003fea:	00002097          	auipc	ra,0x2
    80003fee:	302080e7          	jalr	770(ra) # 800062ec <release>
      return -1;
    80003ff2:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003ff4:	854a                	mv	a0,s2
    80003ff6:	60e6                	ld	ra,88(sp)
    80003ff8:	6446                	ld	s0,80(sp)
    80003ffa:	64a6                	ld	s1,72(sp)
    80003ffc:	6906                	ld	s2,64(sp)
    80003ffe:	79e2                	ld	s3,56(sp)
    80004000:	7a42                	ld	s4,48(sp)
    80004002:	7aa2                	ld	s5,40(sp)
    80004004:	7b02                	ld	s6,32(sp)
    80004006:	6be2                	ld	s7,24(sp)
    80004008:	6c42                	ld	s8,16(sp)
    8000400a:	6125                	addi	sp,sp,96
    8000400c:	8082                	ret
      wakeup(&pi->nread);
    8000400e:	8562                	mv	a0,s8
    80004010:	ffffe097          	auipc	ra,0xffffe
    80004014:	880080e7          	jalr	-1920(ra) # 80001890 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004018:	85a6                	mv	a1,s1
    8000401a:	855e                	mv	a0,s7
    8000401c:	ffffd097          	auipc	ra,0xffffd
    80004020:	6e8080e7          	jalr	1768(ra) # 80001704 <sleep>
  while(i < n){
    80004024:	05495d63          	bge	s2,s4,8000407e <pipewrite+0xda>
    if(pi->readopen == 0 || pr->killed){
    80004028:	2204a783          	lw	a5,544(s1)
    8000402c:	dfd5                	beqz	a5,80003fe8 <pipewrite+0x44>
    8000402e:	0289a783          	lw	a5,40(s3)
    80004032:	fbdd                	bnez	a5,80003fe8 <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004034:	2184a783          	lw	a5,536(s1)
    80004038:	21c4a703          	lw	a4,540(s1)
    8000403c:	2007879b          	addiw	a5,a5,512
    80004040:	fcf707e3          	beq	a4,a5,8000400e <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004044:	4685                	li	a3,1
    80004046:	01590633          	add	a2,s2,s5
    8000404a:	faf40593          	addi	a1,s0,-81
    8000404e:	0509b503          	ld	a0,80(s3)
    80004052:	ffffd097          	auipc	ra,0xffffd
    80004056:	d3e080e7          	jalr	-706(ra) # 80000d90 <copyin>
    8000405a:	03650263          	beq	a0,s6,8000407e <pipewrite+0xda>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    8000405e:	21c4a783          	lw	a5,540(s1)
    80004062:	0017871b          	addiw	a4,a5,1
    80004066:	20e4ae23          	sw	a4,540(s1)
    8000406a:	1ff7f793          	andi	a5,a5,511
    8000406e:	97a6                	add	a5,a5,s1
    80004070:	faf44703          	lbu	a4,-81(s0)
    80004074:	00e78c23          	sb	a4,24(a5)
      i++;
    80004078:	2905                	addiw	s2,s2,1
    8000407a:	b76d                	j	80004024 <pipewrite+0x80>
  int i = 0;
    8000407c:	4901                	li	s2,0
  wakeup(&pi->nread);
    8000407e:	21848513          	addi	a0,s1,536
    80004082:	ffffe097          	auipc	ra,0xffffe
    80004086:	80e080e7          	jalr	-2034(ra) # 80001890 <wakeup>
  release(&pi->lock);
    8000408a:	8526                	mv	a0,s1
    8000408c:	00002097          	auipc	ra,0x2
    80004090:	260080e7          	jalr	608(ra) # 800062ec <release>
  return i;
    80004094:	b785                	j	80003ff4 <pipewrite+0x50>

0000000080004096 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004096:	715d                	addi	sp,sp,-80
    80004098:	e486                	sd	ra,72(sp)
    8000409a:	e0a2                	sd	s0,64(sp)
    8000409c:	fc26                	sd	s1,56(sp)
    8000409e:	f84a                	sd	s2,48(sp)
    800040a0:	f44e                	sd	s3,40(sp)
    800040a2:	f052                	sd	s4,32(sp)
    800040a4:	ec56                	sd	s5,24(sp)
    800040a6:	e85a                	sd	s6,16(sp)
    800040a8:	0880                	addi	s0,sp,80
    800040aa:	84aa                	mv	s1,a0
    800040ac:	892e                	mv	s2,a1
    800040ae:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800040b0:	ffffd097          	auipc	ra,0xffffd
    800040b4:	f90080e7          	jalr	-112(ra) # 80001040 <myproc>
    800040b8:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    800040ba:	8526                	mv	a0,s1
    800040bc:	00002097          	auipc	ra,0x2
    800040c0:	17c080e7          	jalr	380(ra) # 80006238 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800040c4:	2184a703          	lw	a4,536(s1)
    800040c8:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800040cc:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800040d0:	02f71463          	bne	a4,a5,800040f8 <piperead+0x62>
    800040d4:	2244a783          	lw	a5,548(s1)
    800040d8:	c385                	beqz	a5,800040f8 <piperead+0x62>
    if(pr->killed){
    800040da:	028a2783          	lw	a5,40(s4)
    800040de:	ebc9                	bnez	a5,80004170 <piperead+0xda>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800040e0:	85a6                	mv	a1,s1
    800040e2:	854e                	mv	a0,s3
    800040e4:	ffffd097          	auipc	ra,0xffffd
    800040e8:	620080e7          	jalr	1568(ra) # 80001704 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800040ec:	2184a703          	lw	a4,536(s1)
    800040f0:	21c4a783          	lw	a5,540(s1)
    800040f4:	fef700e3          	beq	a4,a5,800040d4 <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800040f8:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800040fa:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800040fc:	05505463          	blez	s5,80004144 <piperead+0xae>
    if(pi->nread == pi->nwrite)
    80004100:	2184a783          	lw	a5,536(s1)
    80004104:	21c4a703          	lw	a4,540(s1)
    80004108:	02f70e63          	beq	a4,a5,80004144 <piperead+0xae>
    ch = pi->data[pi->nread++ % PIPESIZE];
    8000410c:	0017871b          	addiw	a4,a5,1
    80004110:	20e4ac23          	sw	a4,536(s1)
    80004114:	1ff7f793          	andi	a5,a5,511
    80004118:	97a6                	add	a5,a5,s1
    8000411a:	0187c783          	lbu	a5,24(a5)
    8000411e:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004122:	4685                	li	a3,1
    80004124:	fbf40613          	addi	a2,s0,-65
    80004128:	85ca                	mv	a1,s2
    8000412a:	050a3503          	ld	a0,80(s4)
    8000412e:	ffffd097          	auipc	ra,0xffffd
    80004132:	b86080e7          	jalr	-1146(ra) # 80000cb4 <copyout>
    80004136:	01650763          	beq	a0,s6,80004144 <piperead+0xae>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000413a:	2985                	addiw	s3,s3,1
    8000413c:	0905                	addi	s2,s2,1
    8000413e:	fd3a91e3          	bne	s5,s3,80004100 <piperead+0x6a>
    80004142:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004144:	21c48513          	addi	a0,s1,540
    80004148:	ffffd097          	auipc	ra,0xffffd
    8000414c:	748080e7          	jalr	1864(ra) # 80001890 <wakeup>
  release(&pi->lock);
    80004150:	8526                	mv	a0,s1
    80004152:	00002097          	auipc	ra,0x2
    80004156:	19a080e7          	jalr	410(ra) # 800062ec <release>
  return i;
}
    8000415a:	854e                	mv	a0,s3
    8000415c:	60a6                	ld	ra,72(sp)
    8000415e:	6406                	ld	s0,64(sp)
    80004160:	74e2                	ld	s1,56(sp)
    80004162:	7942                	ld	s2,48(sp)
    80004164:	79a2                	ld	s3,40(sp)
    80004166:	7a02                	ld	s4,32(sp)
    80004168:	6ae2                	ld	s5,24(sp)
    8000416a:	6b42                	ld	s6,16(sp)
    8000416c:	6161                	addi	sp,sp,80
    8000416e:	8082                	ret
      release(&pi->lock);
    80004170:	8526                	mv	a0,s1
    80004172:	00002097          	auipc	ra,0x2
    80004176:	17a080e7          	jalr	378(ra) # 800062ec <release>
      return -1;
    8000417a:	59fd                	li	s3,-1
    8000417c:	bff9                	j	8000415a <piperead+0xc4>

000000008000417e <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    8000417e:	de010113          	addi	sp,sp,-544
    80004182:	20113c23          	sd	ra,536(sp)
    80004186:	20813823          	sd	s0,528(sp)
    8000418a:	20913423          	sd	s1,520(sp)
    8000418e:	21213023          	sd	s2,512(sp)
    80004192:	ffce                	sd	s3,504(sp)
    80004194:	fbd2                	sd	s4,496(sp)
    80004196:	f7d6                	sd	s5,488(sp)
    80004198:	f3da                	sd	s6,480(sp)
    8000419a:	efde                	sd	s7,472(sp)
    8000419c:	ebe2                	sd	s8,464(sp)
    8000419e:	e7e6                	sd	s9,456(sp)
    800041a0:	e3ea                	sd	s10,448(sp)
    800041a2:	ff6e                	sd	s11,440(sp)
    800041a4:	1400                	addi	s0,sp,544
    800041a6:	892a                	mv	s2,a0
    800041a8:	dea43423          	sd	a0,-536(s0)
    800041ac:	deb43823          	sd	a1,-528(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800041b0:	ffffd097          	auipc	ra,0xffffd
    800041b4:	e90080e7          	jalr	-368(ra) # 80001040 <myproc>
    800041b8:	84aa                	mv	s1,a0

  begin_op();
    800041ba:	fffff097          	auipc	ra,0xfffff
    800041be:	4a8080e7          	jalr	1192(ra) # 80003662 <begin_op>

  if((ip = namei(path)) == 0){
    800041c2:	854a                	mv	a0,s2
    800041c4:	fffff097          	auipc	ra,0xfffff
    800041c8:	27e080e7          	jalr	638(ra) # 80003442 <namei>
    800041cc:	c93d                	beqz	a0,80004242 <exec+0xc4>
    800041ce:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    800041d0:	fffff097          	auipc	ra,0xfffff
    800041d4:	ab6080e7          	jalr	-1354(ra) # 80002c86 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800041d8:	04000713          	li	a4,64
    800041dc:	4681                	li	a3,0
    800041de:	e5040613          	addi	a2,s0,-432
    800041e2:	4581                	li	a1,0
    800041e4:	8556                	mv	a0,s5
    800041e6:	fffff097          	auipc	ra,0xfffff
    800041ea:	d54080e7          	jalr	-684(ra) # 80002f3a <readi>
    800041ee:	04000793          	li	a5,64
    800041f2:	00f51a63          	bne	a0,a5,80004206 <exec+0x88>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    800041f6:	e5042703          	lw	a4,-432(s0)
    800041fa:	464c47b7          	lui	a5,0x464c4
    800041fe:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004202:	04f70663          	beq	a4,a5,8000424e <exec+0xd0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004206:	8556                	mv	a0,s5
    80004208:	fffff097          	auipc	ra,0xfffff
    8000420c:	ce0080e7          	jalr	-800(ra) # 80002ee8 <iunlockput>
    end_op();
    80004210:	fffff097          	auipc	ra,0xfffff
    80004214:	4d0080e7          	jalr	1232(ra) # 800036e0 <end_op>
  }
  return -1;
    80004218:	557d                	li	a0,-1
}
    8000421a:	21813083          	ld	ra,536(sp)
    8000421e:	21013403          	ld	s0,528(sp)
    80004222:	20813483          	ld	s1,520(sp)
    80004226:	20013903          	ld	s2,512(sp)
    8000422a:	79fe                	ld	s3,504(sp)
    8000422c:	7a5e                	ld	s4,496(sp)
    8000422e:	7abe                	ld	s5,488(sp)
    80004230:	7b1e                	ld	s6,480(sp)
    80004232:	6bfe                	ld	s7,472(sp)
    80004234:	6c5e                	ld	s8,464(sp)
    80004236:	6cbe                	ld	s9,456(sp)
    80004238:	6d1e                	ld	s10,448(sp)
    8000423a:	7dfa                	ld	s11,440(sp)
    8000423c:	22010113          	addi	sp,sp,544
    80004240:	8082                	ret
    end_op();
    80004242:	fffff097          	auipc	ra,0xfffff
    80004246:	49e080e7          	jalr	1182(ra) # 800036e0 <end_op>
    return -1;
    8000424a:	557d                	li	a0,-1
    8000424c:	b7f9                	j	8000421a <exec+0x9c>
  if((pagetable = proc_pagetable(p)) == 0)
    8000424e:	8526                	mv	a0,s1
    80004250:	ffffd097          	auipc	ra,0xffffd
    80004254:	eb4080e7          	jalr	-332(ra) # 80001104 <proc_pagetable>
    80004258:	8b2a                	mv	s6,a0
    8000425a:	d555                	beqz	a0,80004206 <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000425c:	e7042783          	lw	a5,-400(s0)
    80004260:	e8845703          	lhu	a4,-376(s0)
    80004264:	c735                	beqz	a4,800042d0 <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004266:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004268:	e0043423          	sd	zero,-504(s0)
    if((ph.vaddr % PGSIZE) != 0)
    8000426c:	6a05                	lui	s4,0x1
    8000426e:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80004272:	dee43023          	sd	a4,-544(s0)
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    80004276:	6d85                	lui	s11,0x1
    80004278:	7d7d                	lui	s10,0xfffff
    8000427a:	ac1d                	j	800044b0 <exec+0x332>
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    8000427c:	00004517          	auipc	a0,0x4
    80004280:	3fc50513          	addi	a0,a0,1020 # 80008678 <syscalls+0x280>
    80004284:	00002097          	auipc	ra,0x2
    80004288:	a7c080e7          	jalr	-1412(ra) # 80005d00 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    8000428c:	874a                	mv	a4,s2
    8000428e:	009c86bb          	addw	a3,s9,s1
    80004292:	4581                	li	a1,0
    80004294:	8556                	mv	a0,s5
    80004296:	fffff097          	auipc	ra,0xfffff
    8000429a:	ca4080e7          	jalr	-860(ra) # 80002f3a <readi>
    8000429e:	2501                	sext.w	a0,a0
    800042a0:	1aa91863          	bne	s2,a0,80004450 <exec+0x2d2>
  for(i = 0; i < sz; i += PGSIZE){
    800042a4:	009d84bb          	addw	s1,s11,s1
    800042a8:	013d09bb          	addw	s3,s10,s3
    800042ac:	1f74f263          	bgeu	s1,s7,80004490 <exec+0x312>
    pa = walkaddr(pagetable, va + i);
    800042b0:	02049593          	slli	a1,s1,0x20
    800042b4:	9181                	srli	a1,a1,0x20
    800042b6:	95e2                	add	a1,a1,s8
    800042b8:	855a                	mv	a0,s6
    800042ba:	ffffc097          	auipc	ra,0xffffc
    800042be:	388080e7          	jalr	904(ra) # 80000642 <walkaddr>
    800042c2:	862a                	mv	a2,a0
    if(pa == 0)
    800042c4:	dd45                	beqz	a0,8000427c <exec+0xfe>
      n = PGSIZE;
    800042c6:	8952                	mv	s2,s4
    if(sz - i < PGSIZE)
    800042c8:	fd49f2e3          	bgeu	s3,s4,8000428c <exec+0x10e>
      n = sz - i;
    800042cc:	894e                	mv	s2,s3
    800042ce:	bf7d                	j	8000428c <exec+0x10e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800042d0:	4481                	li	s1,0
  iunlockput(ip);
    800042d2:	8556                	mv	a0,s5
    800042d4:	fffff097          	auipc	ra,0xfffff
    800042d8:	c14080e7          	jalr	-1004(ra) # 80002ee8 <iunlockput>
  end_op();
    800042dc:	fffff097          	auipc	ra,0xfffff
    800042e0:	404080e7          	jalr	1028(ra) # 800036e0 <end_op>
  p = myproc();
    800042e4:	ffffd097          	auipc	ra,0xffffd
    800042e8:	d5c080e7          	jalr	-676(ra) # 80001040 <myproc>
    800042ec:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    800042ee:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    800042f2:	6785                	lui	a5,0x1
    800042f4:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800042f6:	97a6                	add	a5,a5,s1
    800042f8:	777d                	lui	a4,0xfffff
    800042fa:	8ff9                	and	a5,a5,a4
    800042fc:	def43c23          	sd	a5,-520(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004300:	6609                	lui	a2,0x2
    80004302:	963e                	add	a2,a2,a5
    80004304:	85be                	mv	a1,a5
    80004306:	855a                	mv	a0,s6
    80004308:	ffffc097          	auipc	ra,0xffffc
    8000430c:	6ee080e7          	jalr	1774(ra) # 800009f6 <uvmalloc>
    80004310:	8c2a                	mv	s8,a0
  ip = 0;
    80004312:	4a81                	li	s5,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004314:	12050e63          	beqz	a0,80004450 <exec+0x2d2>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004318:	75f9                	lui	a1,0xffffe
    8000431a:	95aa                	add	a1,a1,a0
    8000431c:	855a                	mv	a0,s6
    8000431e:	ffffd097          	auipc	ra,0xffffd
    80004322:	964080e7          	jalr	-1692(ra) # 80000c82 <uvmclear>
  stackbase = sp - PGSIZE;
    80004326:	7afd                	lui	s5,0xfffff
    80004328:	9ae2                	add	s5,s5,s8
  for(argc = 0; argv[argc]; argc++) {
    8000432a:	df043783          	ld	a5,-528(s0)
    8000432e:	6388                	ld	a0,0(a5)
    80004330:	c925                	beqz	a0,800043a0 <exec+0x222>
    80004332:	e9040993          	addi	s3,s0,-368
    80004336:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    8000433a:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    8000433c:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    8000433e:	ffffc097          	auipc	ra,0xffffc
    80004342:	0fa080e7          	jalr	250(ra) # 80000438 <strlen>
    80004346:	0015079b          	addiw	a5,a0,1
    8000434a:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    8000434e:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80004352:	13596363          	bltu	s2,s5,80004478 <exec+0x2fa>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004356:	df043d83          	ld	s11,-528(s0)
    8000435a:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    8000435e:	8552                	mv	a0,s4
    80004360:	ffffc097          	auipc	ra,0xffffc
    80004364:	0d8080e7          	jalr	216(ra) # 80000438 <strlen>
    80004368:	0015069b          	addiw	a3,a0,1
    8000436c:	8652                	mv	a2,s4
    8000436e:	85ca                	mv	a1,s2
    80004370:	855a                	mv	a0,s6
    80004372:	ffffd097          	auipc	ra,0xffffd
    80004376:	942080e7          	jalr	-1726(ra) # 80000cb4 <copyout>
    8000437a:	10054363          	bltz	a0,80004480 <exec+0x302>
    ustack[argc] = sp;
    8000437e:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80004382:	0485                	addi	s1,s1,1
    80004384:	008d8793          	addi	a5,s11,8
    80004388:	def43823          	sd	a5,-528(s0)
    8000438c:	008db503          	ld	a0,8(s11)
    80004390:	c911                	beqz	a0,800043a4 <exec+0x226>
    if(argc >= MAXARG)
    80004392:	09a1                	addi	s3,s3,8
    80004394:	fb3c95e3          	bne	s9,s3,8000433e <exec+0x1c0>
  sz = sz1;
    80004398:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000439c:	4a81                	li	s5,0
    8000439e:	a84d                	j	80004450 <exec+0x2d2>
  sp = sz;
    800043a0:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    800043a2:	4481                	li	s1,0
  ustack[argc] = 0;
    800043a4:	00349793          	slli	a5,s1,0x3
    800043a8:	f9078793          	addi	a5,a5,-112
    800043ac:	97a2                	add	a5,a5,s0
    800043ae:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    800043b2:	00148693          	addi	a3,s1,1
    800043b6:	068e                	slli	a3,a3,0x3
    800043b8:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    800043bc:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    800043c0:	01597663          	bgeu	s2,s5,800043cc <exec+0x24e>
  sz = sz1;
    800043c4:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    800043c8:	4a81                	li	s5,0
    800043ca:	a059                	j	80004450 <exec+0x2d2>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800043cc:	e9040613          	addi	a2,s0,-368
    800043d0:	85ca                	mv	a1,s2
    800043d2:	855a                	mv	a0,s6
    800043d4:	ffffd097          	auipc	ra,0xffffd
    800043d8:	8e0080e7          	jalr	-1824(ra) # 80000cb4 <copyout>
    800043dc:	0a054663          	bltz	a0,80004488 <exec+0x30a>
  p->trapframe->a1 = sp;
    800043e0:	058bb783          	ld	a5,88(s7)
    800043e4:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    800043e8:	de843783          	ld	a5,-536(s0)
    800043ec:	0007c703          	lbu	a4,0(a5)
    800043f0:	cf11                	beqz	a4,8000440c <exec+0x28e>
    800043f2:	0785                	addi	a5,a5,1
    if(*s == '/')
    800043f4:	02f00693          	li	a3,47
    800043f8:	a039                	j	80004406 <exec+0x288>
      last = s+1;
    800043fa:	def43423          	sd	a5,-536(s0)
  for(last=s=path; *s; s++)
    800043fe:	0785                	addi	a5,a5,1
    80004400:	fff7c703          	lbu	a4,-1(a5)
    80004404:	c701                	beqz	a4,8000440c <exec+0x28e>
    if(*s == '/')
    80004406:	fed71ce3          	bne	a4,a3,800043fe <exec+0x280>
    8000440a:	bfc5                	j	800043fa <exec+0x27c>
  safestrcpy(p->name, last, sizeof(p->name));
    8000440c:	4641                	li	a2,16
    8000440e:	de843583          	ld	a1,-536(s0)
    80004412:	158b8513          	addi	a0,s7,344
    80004416:	ffffc097          	auipc	ra,0xffffc
    8000441a:	ff0080e7          	jalr	-16(ra) # 80000406 <safestrcpy>
  oldpagetable = p->pagetable;
    8000441e:	050bb503          	ld	a0,80(s7)
  p->pagetable = pagetable;
    80004422:	056bb823          	sd	s6,80(s7)
  p->sz = sz;
    80004426:	058bb423          	sd	s8,72(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    8000442a:	058bb783          	ld	a5,88(s7)
    8000442e:	e6843703          	ld	a4,-408(s0)
    80004432:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004434:	058bb783          	ld	a5,88(s7)
    80004438:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    8000443c:	85ea                	mv	a1,s10
    8000443e:	ffffd097          	auipc	ra,0xffffd
    80004442:	d62080e7          	jalr	-670(ra) # 800011a0 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004446:	0004851b          	sext.w	a0,s1
    8000444a:	bbc1                	j	8000421a <exec+0x9c>
    8000444c:	de943c23          	sd	s1,-520(s0)
    proc_freepagetable(pagetable, sz);
    80004450:	df843583          	ld	a1,-520(s0)
    80004454:	855a                	mv	a0,s6
    80004456:	ffffd097          	auipc	ra,0xffffd
    8000445a:	d4a080e7          	jalr	-694(ra) # 800011a0 <proc_freepagetable>
  if(ip){
    8000445e:	da0a94e3          	bnez	s5,80004206 <exec+0x88>
  return -1;
    80004462:	557d                	li	a0,-1
    80004464:	bb5d                	j	8000421a <exec+0x9c>
    80004466:	de943c23          	sd	s1,-520(s0)
    8000446a:	b7dd                	j	80004450 <exec+0x2d2>
    8000446c:	de943c23          	sd	s1,-520(s0)
    80004470:	b7c5                	j	80004450 <exec+0x2d2>
    80004472:	de943c23          	sd	s1,-520(s0)
    80004476:	bfe9                	j	80004450 <exec+0x2d2>
  sz = sz1;
    80004478:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000447c:	4a81                	li	s5,0
    8000447e:	bfc9                	j	80004450 <exec+0x2d2>
  sz = sz1;
    80004480:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004484:	4a81                	li	s5,0
    80004486:	b7e9                	j	80004450 <exec+0x2d2>
  sz = sz1;
    80004488:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000448c:	4a81                	li	s5,0
    8000448e:	b7c9                	j	80004450 <exec+0x2d2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004490:	df843483          	ld	s1,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004494:	e0843783          	ld	a5,-504(s0)
    80004498:	0017869b          	addiw	a3,a5,1
    8000449c:	e0d43423          	sd	a3,-504(s0)
    800044a0:	e0043783          	ld	a5,-512(s0)
    800044a4:	0387879b          	addiw	a5,a5,56
    800044a8:	e8845703          	lhu	a4,-376(s0)
    800044ac:	e2e6d3e3          	bge	a3,a4,800042d2 <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800044b0:	2781                	sext.w	a5,a5
    800044b2:	e0f43023          	sd	a5,-512(s0)
    800044b6:	03800713          	li	a4,56
    800044ba:	86be                	mv	a3,a5
    800044bc:	e1840613          	addi	a2,s0,-488
    800044c0:	4581                	li	a1,0
    800044c2:	8556                	mv	a0,s5
    800044c4:	fffff097          	auipc	ra,0xfffff
    800044c8:	a76080e7          	jalr	-1418(ra) # 80002f3a <readi>
    800044cc:	03800793          	li	a5,56
    800044d0:	f6f51ee3          	bne	a0,a5,8000444c <exec+0x2ce>
    if(ph.type != ELF_PROG_LOAD)
    800044d4:	e1842783          	lw	a5,-488(s0)
    800044d8:	4705                	li	a4,1
    800044da:	fae79de3          	bne	a5,a4,80004494 <exec+0x316>
    if(ph.memsz < ph.filesz)
    800044de:	e4043603          	ld	a2,-448(s0)
    800044e2:	e3843783          	ld	a5,-456(s0)
    800044e6:	f8f660e3          	bltu	a2,a5,80004466 <exec+0x2e8>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800044ea:	e2843783          	ld	a5,-472(s0)
    800044ee:	963e                	add	a2,a2,a5
    800044f0:	f6f66ee3          	bltu	a2,a5,8000446c <exec+0x2ee>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800044f4:	85a6                	mv	a1,s1
    800044f6:	855a                	mv	a0,s6
    800044f8:	ffffc097          	auipc	ra,0xffffc
    800044fc:	4fe080e7          	jalr	1278(ra) # 800009f6 <uvmalloc>
    80004500:	dea43c23          	sd	a0,-520(s0)
    80004504:	d53d                	beqz	a0,80004472 <exec+0x2f4>
    if((ph.vaddr % PGSIZE) != 0)
    80004506:	e2843c03          	ld	s8,-472(s0)
    8000450a:	de043783          	ld	a5,-544(s0)
    8000450e:	00fc77b3          	and	a5,s8,a5
    80004512:	ff9d                	bnez	a5,80004450 <exec+0x2d2>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004514:	e2042c83          	lw	s9,-480(s0)
    80004518:	e3842b83          	lw	s7,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    8000451c:	f60b8ae3          	beqz	s7,80004490 <exec+0x312>
    80004520:	89de                	mv	s3,s7
    80004522:	4481                	li	s1,0
    80004524:	b371                	j	800042b0 <exec+0x132>

0000000080004526 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004526:	7179                	addi	sp,sp,-48
    80004528:	f406                	sd	ra,40(sp)
    8000452a:	f022                	sd	s0,32(sp)
    8000452c:	ec26                	sd	s1,24(sp)
    8000452e:	e84a                	sd	s2,16(sp)
    80004530:	1800                	addi	s0,sp,48
    80004532:	892e                	mv	s2,a1
    80004534:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80004536:	fdc40593          	addi	a1,s0,-36
    8000453a:	ffffe097          	auipc	ra,0xffffe
    8000453e:	bda080e7          	jalr	-1062(ra) # 80002114 <argint>
    80004542:	04054063          	bltz	a0,80004582 <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80004546:	fdc42703          	lw	a4,-36(s0)
    8000454a:	47bd                	li	a5,15
    8000454c:	02e7ed63          	bltu	a5,a4,80004586 <argfd+0x60>
    80004550:	ffffd097          	auipc	ra,0xffffd
    80004554:	af0080e7          	jalr	-1296(ra) # 80001040 <myproc>
    80004558:	fdc42703          	lw	a4,-36(s0)
    8000455c:	01a70793          	addi	a5,a4,26 # fffffffffffff01a <end+0xffffffff7fdb8dda>
    80004560:	078e                	slli	a5,a5,0x3
    80004562:	953e                	add	a0,a0,a5
    80004564:	611c                	ld	a5,0(a0)
    80004566:	c395                	beqz	a5,8000458a <argfd+0x64>
    return -1;
  if(pfd)
    80004568:	00090463          	beqz	s2,80004570 <argfd+0x4a>
    *pfd = fd;
    8000456c:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004570:	4501                	li	a0,0
  if(pf)
    80004572:	c091                	beqz	s1,80004576 <argfd+0x50>
    *pf = f;
    80004574:	e09c                	sd	a5,0(s1)
}
    80004576:	70a2                	ld	ra,40(sp)
    80004578:	7402                	ld	s0,32(sp)
    8000457a:	64e2                	ld	s1,24(sp)
    8000457c:	6942                	ld	s2,16(sp)
    8000457e:	6145                	addi	sp,sp,48
    80004580:	8082                	ret
    return -1;
    80004582:	557d                	li	a0,-1
    80004584:	bfcd                	j	80004576 <argfd+0x50>
    return -1;
    80004586:	557d                	li	a0,-1
    80004588:	b7fd                	j	80004576 <argfd+0x50>
    8000458a:	557d                	li	a0,-1
    8000458c:	b7ed                	j	80004576 <argfd+0x50>

000000008000458e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    8000458e:	1101                	addi	sp,sp,-32
    80004590:	ec06                	sd	ra,24(sp)
    80004592:	e822                	sd	s0,16(sp)
    80004594:	e426                	sd	s1,8(sp)
    80004596:	1000                	addi	s0,sp,32
    80004598:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    8000459a:	ffffd097          	auipc	ra,0xffffd
    8000459e:	aa6080e7          	jalr	-1370(ra) # 80001040 <myproc>
    800045a2:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800045a4:	0d050793          	addi	a5,a0,208
    800045a8:	4501                	li	a0,0
    800045aa:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800045ac:	6398                	ld	a4,0(a5)
    800045ae:	cb19                	beqz	a4,800045c4 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    800045b0:	2505                	addiw	a0,a0,1
    800045b2:	07a1                	addi	a5,a5,8
    800045b4:	fed51ce3          	bne	a0,a3,800045ac <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    800045b8:	557d                	li	a0,-1
}
    800045ba:	60e2                	ld	ra,24(sp)
    800045bc:	6442                	ld	s0,16(sp)
    800045be:	64a2                	ld	s1,8(sp)
    800045c0:	6105                	addi	sp,sp,32
    800045c2:	8082                	ret
      p->ofile[fd] = f;
    800045c4:	01a50793          	addi	a5,a0,26
    800045c8:	078e                	slli	a5,a5,0x3
    800045ca:	963e                	add	a2,a2,a5
    800045cc:	e204                	sd	s1,0(a2)
      return fd;
    800045ce:	b7f5                	j	800045ba <fdalloc+0x2c>

00000000800045d0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800045d0:	715d                	addi	sp,sp,-80
    800045d2:	e486                	sd	ra,72(sp)
    800045d4:	e0a2                	sd	s0,64(sp)
    800045d6:	fc26                	sd	s1,56(sp)
    800045d8:	f84a                	sd	s2,48(sp)
    800045da:	f44e                	sd	s3,40(sp)
    800045dc:	f052                	sd	s4,32(sp)
    800045de:	ec56                	sd	s5,24(sp)
    800045e0:	0880                	addi	s0,sp,80
    800045e2:	89ae                	mv	s3,a1
    800045e4:	8ab2                	mv	s5,a2
    800045e6:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800045e8:	fb040593          	addi	a1,s0,-80
    800045ec:	fffff097          	auipc	ra,0xfffff
    800045f0:	e74080e7          	jalr	-396(ra) # 80003460 <nameiparent>
    800045f4:	892a                	mv	s2,a0
    800045f6:	12050e63          	beqz	a0,80004732 <create+0x162>
    return 0;

  ilock(dp);
    800045fa:	ffffe097          	auipc	ra,0xffffe
    800045fe:	68c080e7          	jalr	1676(ra) # 80002c86 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80004602:	4601                	li	a2,0
    80004604:	fb040593          	addi	a1,s0,-80
    80004608:	854a                	mv	a0,s2
    8000460a:	fffff097          	auipc	ra,0xfffff
    8000460e:	b60080e7          	jalr	-1184(ra) # 8000316a <dirlookup>
    80004612:	84aa                	mv	s1,a0
    80004614:	c921                	beqz	a0,80004664 <create+0x94>
    iunlockput(dp);
    80004616:	854a                	mv	a0,s2
    80004618:	fffff097          	auipc	ra,0xfffff
    8000461c:	8d0080e7          	jalr	-1840(ra) # 80002ee8 <iunlockput>
    ilock(ip);
    80004620:	8526                	mv	a0,s1
    80004622:	ffffe097          	auipc	ra,0xffffe
    80004626:	664080e7          	jalr	1636(ra) # 80002c86 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    8000462a:	2981                	sext.w	s3,s3
    8000462c:	4789                	li	a5,2
    8000462e:	02f99463          	bne	s3,a5,80004656 <create+0x86>
    80004632:	0444d783          	lhu	a5,68(s1)
    80004636:	37f9                	addiw	a5,a5,-2
    80004638:	17c2                	slli	a5,a5,0x30
    8000463a:	93c1                	srli	a5,a5,0x30
    8000463c:	4705                	li	a4,1
    8000463e:	00f76c63          	bltu	a4,a5,80004656 <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    80004642:	8526                	mv	a0,s1
    80004644:	60a6                	ld	ra,72(sp)
    80004646:	6406                	ld	s0,64(sp)
    80004648:	74e2                	ld	s1,56(sp)
    8000464a:	7942                	ld	s2,48(sp)
    8000464c:	79a2                	ld	s3,40(sp)
    8000464e:	7a02                	ld	s4,32(sp)
    80004650:	6ae2                	ld	s5,24(sp)
    80004652:	6161                	addi	sp,sp,80
    80004654:	8082                	ret
    iunlockput(ip);
    80004656:	8526                	mv	a0,s1
    80004658:	fffff097          	auipc	ra,0xfffff
    8000465c:	890080e7          	jalr	-1904(ra) # 80002ee8 <iunlockput>
    return 0;
    80004660:	4481                	li	s1,0
    80004662:	b7c5                	j	80004642 <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    80004664:	85ce                	mv	a1,s3
    80004666:	00092503          	lw	a0,0(s2)
    8000466a:	ffffe097          	auipc	ra,0xffffe
    8000466e:	482080e7          	jalr	1154(ra) # 80002aec <ialloc>
    80004672:	84aa                	mv	s1,a0
    80004674:	c521                	beqz	a0,800046bc <create+0xec>
  ilock(ip);
    80004676:	ffffe097          	auipc	ra,0xffffe
    8000467a:	610080e7          	jalr	1552(ra) # 80002c86 <ilock>
  ip->major = major;
    8000467e:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    80004682:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    80004686:	4a05                	li	s4,1
    80004688:	05449523          	sh	s4,74(s1)
  iupdate(ip);
    8000468c:	8526                	mv	a0,s1
    8000468e:	ffffe097          	auipc	ra,0xffffe
    80004692:	52c080e7          	jalr	1324(ra) # 80002bba <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80004696:	2981                	sext.w	s3,s3
    80004698:	03498a63          	beq	s3,s4,800046cc <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    8000469c:	40d0                	lw	a2,4(s1)
    8000469e:	fb040593          	addi	a1,s0,-80
    800046a2:	854a                	mv	a0,s2
    800046a4:	fffff097          	auipc	ra,0xfffff
    800046a8:	cdc080e7          	jalr	-804(ra) # 80003380 <dirlink>
    800046ac:	06054b63          	bltz	a0,80004722 <create+0x152>
  iunlockput(dp);
    800046b0:	854a                	mv	a0,s2
    800046b2:	fffff097          	auipc	ra,0xfffff
    800046b6:	836080e7          	jalr	-1994(ra) # 80002ee8 <iunlockput>
  return ip;
    800046ba:	b761                	j	80004642 <create+0x72>
    panic("create: ialloc");
    800046bc:	00004517          	auipc	a0,0x4
    800046c0:	fdc50513          	addi	a0,a0,-36 # 80008698 <syscalls+0x2a0>
    800046c4:	00001097          	auipc	ra,0x1
    800046c8:	63c080e7          	jalr	1596(ra) # 80005d00 <panic>
    dp->nlink++;  // for ".."
    800046cc:	04a95783          	lhu	a5,74(s2)
    800046d0:	2785                	addiw	a5,a5,1
    800046d2:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    800046d6:	854a                	mv	a0,s2
    800046d8:	ffffe097          	auipc	ra,0xffffe
    800046dc:	4e2080e7          	jalr	1250(ra) # 80002bba <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800046e0:	40d0                	lw	a2,4(s1)
    800046e2:	00004597          	auipc	a1,0x4
    800046e6:	fc658593          	addi	a1,a1,-58 # 800086a8 <syscalls+0x2b0>
    800046ea:	8526                	mv	a0,s1
    800046ec:	fffff097          	auipc	ra,0xfffff
    800046f0:	c94080e7          	jalr	-876(ra) # 80003380 <dirlink>
    800046f4:	00054f63          	bltz	a0,80004712 <create+0x142>
    800046f8:	00492603          	lw	a2,4(s2)
    800046fc:	00004597          	auipc	a1,0x4
    80004700:	fb458593          	addi	a1,a1,-76 # 800086b0 <syscalls+0x2b8>
    80004704:	8526                	mv	a0,s1
    80004706:	fffff097          	auipc	ra,0xfffff
    8000470a:	c7a080e7          	jalr	-902(ra) # 80003380 <dirlink>
    8000470e:	f80557e3          	bgez	a0,8000469c <create+0xcc>
      panic("create dots");
    80004712:	00004517          	auipc	a0,0x4
    80004716:	fa650513          	addi	a0,a0,-90 # 800086b8 <syscalls+0x2c0>
    8000471a:	00001097          	auipc	ra,0x1
    8000471e:	5e6080e7          	jalr	1510(ra) # 80005d00 <panic>
    panic("create: dirlink");
    80004722:	00004517          	auipc	a0,0x4
    80004726:	fa650513          	addi	a0,a0,-90 # 800086c8 <syscalls+0x2d0>
    8000472a:	00001097          	auipc	ra,0x1
    8000472e:	5d6080e7          	jalr	1494(ra) # 80005d00 <panic>
    return 0;
    80004732:	84aa                	mv	s1,a0
    80004734:	b739                	j	80004642 <create+0x72>

0000000080004736 <sys_dup>:
{
    80004736:	7179                	addi	sp,sp,-48
    80004738:	f406                	sd	ra,40(sp)
    8000473a:	f022                	sd	s0,32(sp)
    8000473c:	ec26                	sd	s1,24(sp)
    8000473e:	e84a                	sd	s2,16(sp)
    80004740:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004742:	fd840613          	addi	a2,s0,-40
    80004746:	4581                	li	a1,0
    80004748:	4501                	li	a0,0
    8000474a:	00000097          	auipc	ra,0x0
    8000474e:	ddc080e7          	jalr	-548(ra) # 80004526 <argfd>
    return -1;
    80004752:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80004754:	02054363          	bltz	a0,8000477a <sys_dup+0x44>
  if((fd=fdalloc(f)) < 0)
    80004758:	fd843903          	ld	s2,-40(s0)
    8000475c:	854a                	mv	a0,s2
    8000475e:	00000097          	auipc	ra,0x0
    80004762:	e30080e7          	jalr	-464(ra) # 8000458e <fdalloc>
    80004766:	84aa                	mv	s1,a0
    return -1;
    80004768:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    8000476a:	00054863          	bltz	a0,8000477a <sys_dup+0x44>
  filedup(f);
    8000476e:	854a                	mv	a0,s2
    80004770:	fffff097          	auipc	ra,0xfffff
    80004774:	368080e7          	jalr	872(ra) # 80003ad8 <filedup>
  return fd;
    80004778:	87a6                	mv	a5,s1
}
    8000477a:	853e                	mv	a0,a5
    8000477c:	70a2                	ld	ra,40(sp)
    8000477e:	7402                	ld	s0,32(sp)
    80004780:	64e2                	ld	s1,24(sp)
    80004782:	6942                	ld	s2,16(sp)
    80004784:	6145                	addi	sp,sp,48
    80004786:	8082                	ret

0000000080004788 <sys_read>:
{
    80004788:	7179                	addi	sp,sp,-48
    8000478a:	f406                	sd	ra,40(sp)
    8000478c:	f022                	sd	s0,32(sp)
    8000478e:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004790:	fe840613          	addi	a2,s0,-24
    80004794:	4581                	li	a1,0
    80004796:	4501                	li	a0,0
    80004798:	00000097          	auipc	ra,0x0
    8000479c:	d8e080e7          	jalr	-626(ra) # 80004526 <argfd>
    return -1;
    800047a0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800047a2:	04054163          	bltz	a0,800047e4 <sys_read+0x5c>
    800047a6:	fe440593          	addi	a1,s0,-28
    800047aa:	4509                	li	a0,2
    800047ac:	ffffe097          	auipc	ra,0xffffe
    800047b0:	968080e7          	jalr	-1688(ra) # 80002114 <argint>
    return -1;
    800047b4:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800047b6:	02054763          	bltz	a0,800047e4 <sys_read+0x5c>
    800047ba:	fd840593          	addi	a1,s0,-40
    800047be:	4505                	li	a0,1
    800047c0:	ffffe097          	auipc	ra,0xffffe
    800047c4:	976080e7          	jalr	-1674(ra) # 80002136 <argaddr>
    return -1;
    800047c8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800047ca:	00054d63          	bltz	a0,800047e4 <sys_read+0x5c>
  return fileread(f, p, n);
    800047ce:	fe442603          	lw	a2,-28(s0)
    800047d2:	fd843583          	ld	a1,-40(s0)
    800047d6:	fe843503          	ld	a0,-24(s0)
    800047da:	fffff097          	auipc	ra,0xfffff
    800047de:	48a080e7          	jalr	1162(ra) # 80003c64 <fileread>
    800047e2:	87aa                	mv	a5,a0
}
    800047e4:	853e                	mv	a0,a5
    800047e6:	70a2                	ld	ra,40(sp)
    800047e8:	7402                	ld	s0,32(sp)
    800047ea:	6145                	addi	sp,sp,48
    800047ec:	8082                	ret

00000000800047ee <sys_write>:
{
    800047ee:	7179                	addi	sp,sp,-48
    800047f0:	f406                	sd	ra,40(sp)
    800047f2:	f022                	sd	s0,32(sp)
    800047f4:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800047f6:	fe840613          	addi	a2,s0,-24
    800047fa:	4581                	li	a1,0
    800047fc:	4501                	li	a0,0
    800047fe:	00000097          	auipc	ra,0x0
    80004802:	d28080e7          	jalr	-728(ra) # 80004526 <argfd>
    return -1;
    80004806:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004808:	04054163          	bltz	a0,8000484a <sys_write+0x5c>
    8000480c:	fe440593          	addi	a1,s0,-28
    80004810:	4509                	li	a0,2
    80004812:	ffffe097          	auipc	ra,0xffffe
    80004816:	902080e7          	jalr	-1790(ra) # 80002114 <argint>
    return -1;
    8000481a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000481c:	02054763          	bltz	a0,8000484a <sys_write+0x5c>
    80004820:	fd840593          	addi	a1,s0,-40
    80004824:	4505                	li	a0,1
    80004826:	ffffe097          	auipc	ra,0xffffe
    8000482a:	910080e7          	jalr	-1776(ra) # 80002136 <argaddr>
    return -1;
    8000482e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004830:	00054d63          	bltz	a0,8000484a <sys_write+0x5c>
  return filewrite(f, p, n);
    80004834:	fe442603          	lw	a2,-28(s0)
    80004838:	fd843583          	ld	a1,-40(s0)
    8000483c:	fe843503          	ld	a0,-24(s0)
    80004840:	fffff097          	auipc	ra,0xfffff
    80004844:	4e6080e7          	jalr	1254(ra) # 80003d26 <filewrite>
    80004848:	87aa                	mv	a5,a0
}
    8000484a:	853e                	mv	a0,a5
    8000484c:	70a2                	ld	ra,40(sp)
    8000484e:	7402                	ld	s0,32(sp)
    80004850:	6145                	addi	sp,sp,48
    80004852:	8082                	ret

0000000080004854 <sys_close>:
{
    80004854:	1101                	addi	sp,sp,-32
    80004856:	ec06                	sd	ra,24(sp)
    80004858:	e822                	sd	s0,16(sp)
    8000485a:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    8000485c:	fe040613          	addi	a2,s0,-32
    80004860:	fec40593          	addi	a1,s0,-20
    80004864:	4501                	li	a0,0
    80004866:	00000097          	auipc	ra,0x0
    8000486a:	cc0080e7          	jalr	-832(ra) # 80004526 <argfd>
    return -1;
    8000486e:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004870:	02054463          	bltz	a0,80004898 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80004874:	ffffc097          	auipc	ra,0xffffc
    80004878:	7cc080e7          	jalr	1996(ra) # 80001040 <myproc>
    8000487c:	fec42783          	lw	a5,-20(s0)
    80004880:	07e9                	addi	a5,a5,26
    80004882:	078e                	slli	a5,a5,0x3
    80004884:	953e                	add	a0,a0,a5
    80004886:	00053023          	sd	zero,0(a0)
  fileclose(f);
    8000488a:	fe043503          	ld	a0,-32(s0)
    8000488e:	fffff097          	auipc	ra,0xfffff
    80004892:	29c080e7          	jalr	668(ra) # 80003b2a <fileclose>
  return 0;
    80004896:	4781                	li	a5,0
}
    80004898:	853e                	mv	a0,a5
    8000489a:	60e2                	ld	ra,24(sp)
    8000489c:	6442                	ld	s0,16(sp)
    8000489e:	6105                	addi	sp,sp,32
    800048a0:	8082                	ret

00000000800048a2 <sys_fstat>:
{
    800048a2:	1101                	addi	sp,sp,-32
    800048a4:	ec06                	sd	ra,24(sp)
    800048a6:	e822                	sd	s0,16(sp)
    800048a8:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800048aa:	fe840613          	addi	a2,s0,-24
    800048ae:	4581                	li	a1,0
    800048b0:	4501                	li	a0,0
    800048b2:	00000097          	auipc	ra,0x0
    800048b6:	c74080e7          	jalr	-908(ra) # 80004526 <argfd>
    return -1;
    800048ba:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800048bc:	02054563          	bltz	a0,800048e6 <sys_fstat+0x44>
    800048c0:	fe040593          	addi	a1,s0,-32
    800048c4:	4505                	li	a0,1
    800048c6:	ffffe097          	auipc	ra,0xffffe
    800048ca:	870080e7          	jalr	-1936(ra) # 80002136 <argaddr>
    return -1;
    800048ce:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800048d0:	00054b63          	bltz	a0,800048e6 <sys_fstat+0x44>
  return filestat(f, st);
    800048d4:	fe043583          	ld	a1,-32(s0)
    800048d8:	fe843503          	ld	a0,-24(s0)
    800048dc:	fffff097          	auipc	ra,0xfffff
    800048e0:	316080e7          	jalr	790(ra) # 80003bf2 <filestat>
    800048e4:	87aa                	mv	a5,a0
}
    800048e6:	853e                	mv	a0,a5
    800048e8:	60e2                	ld	ra,24(sp)
    800048ea:	6442                	ld	s0,16(sp)
    800048ec:	6105                	addi	sp,sp,32
    800048ee:	8082                	ret

00000000800048f0 <sys_link>:
{
    800048f0:	7169                	addi	sp,sp,-304
    800048f2:	f606                	sd	ra,296(sp)
    800048f4:	f222                	sd	s0,288(sp)
    800048f6:	ee26                	sd	s1,280(sp)
    800048f8:	ea4a                	sd	s2,272(sp)
    800048fa:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800048fc:	08000613          	li	a2,128
    80004900:	ed040593          	addi	a1,s0,-304
    80004904:	4501                	li	a0,0
    80004906:	ffffe097          	auipc	ra,0xffffe
    8000490a:	852080e7          	jalr	-1966(ra) # 80002158 <argstr>
    return -1;
    8000490e:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004910:	10054e63          	bltz	a0,80004a2c <sys_link+0x13c>
    80004914:	08000613          	li	a2,128
    80004918:	f5040593          	addi	a1,s0,-176
    8000491c:	4505                	li	a0,1
    8000491e:	ffffe097          	auipc	ra,0xffffe
    80004922:	83a080e7          	jalr	-1990(ra) # 80002158 <argstr>
    return -1;
    80004926:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004928:	10054263          	bltz	a0,80004a2c <sys_link+0x13c>
  begin_op();
    8000492c:	fffff097          	auipc	ra,0xfffff
    80004930:	d36080e7          	jalr	-714(ra) # 80003662 <begin_op>
  if((ip = namei(old)) == 0){
    80004934:	ed040513          	addi	a0,s0,-304
    80004938:	fffff097          	auipc	ra,0xfffff
    8000493c:	b0a080e7          	jalr	-1270(ra) # 80003442 <namei>
    80004940:	84aa                	mv	s1,a0
    80004942:	c551                	beqz	a0,800049ce <sys_link+0xde>
  ilock(ip);
    80004944:	ffffe097          	auipc	ra,0xffffe
    80004948:	342080e7          	jalr	834(ra) # 80002c86 <ilock>
  if(ip->type == T_DIR){
    8000494c:	04449703          	lh	a4,68(s1)
    80004950:	4785                	li	a5,1
    80004952:	08f70463          	beq	a4,a5,800049da <sys_link+0xea>
  ip->nlink++;
    80004956:	04a4d783          	lhu	a5,74(s1)
    8000495a:	2785                	addiw	a5,a5,1
    8000495c:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004960:	8526                	mv	a0,s1
    80004962:	ffffe097          	auipc	ra,0xffffe
    80004966:	258080e7          	jalr	600(ra) # 80002bba <iupdate>
  iunlock(ip);
    8000496a:	8526                	mv	a0,s1
    8000496c:	ffffe097          	auipc	ra,0xffffe
    80004970:	3dc080e7          	jalr	988(ra) # 80002d48 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004974:	fd040593          	addi	a1,s0,-48
    80004978:	f5040513          	addi	a0,s0,-176
    8000497c:	fffff097          	auipc	ra,0xfffff
    80004980:	ae4080e7          	jalr	-1308(ra) # 80003460 <nameiparent>
    80004984:	892a                	mv	s2,a0
    80004986:	c935                	beqz	a0,800049fa <sys_link+0x10a>
  ilock(dp);
    80004988:	ffffe097          	auipc	ra,0xffffe
    8000498c:	2fe080e7          	jalr	766(ra) # 80002c86 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004990:	00092703          	lw	a4,0(s2)
    80004994:	409c                	lw	a5,0(s1)
    80004996:	04f71d63          	bne	a4,a5,800049f0 <sys_link+0x100>
    8000499a:	40d0                	lw	a2,4(s1)
    8000499c:	fd040593          	addi	a1,s0,-48
    800049a0:	854a                	mv	a0,s2
    800049a2:	fffff097          	auipc	ra,0xfffff
    800049a6:	9de080e7          	jalr	-1570(ra) # 80003380 <dirlink>
    800049aa:	04054363          	bltz	a0,800049f0 <sys_link+0x100>
  iunlockput(dp);
    800049ae:	854a                	mv	a0,s2
    800049b0:	ffffe097          	auipc	ra,0xffffe
    800049b4:	538080e7          	jalr	1336(ra) # 80002ee8 <iunlockput>
  iput(ip);
    800049b8:	8526                	mv	a0,s1
    800049ba:	ffffe097          	auipc	ra,0xffffe
    800049be:	486080e7          	jalr	1158(ra) # 80002e40 <iput>
  end_op();
    800049c2:	fffff097          	auipc	ra,0xfffff
    800049c6:	d1e080e7          	jalr	-738(ra) # 800036e0 <end_op>
  return 0;
    800049ca:	4781                	li	a5,0
    800049cc:	a085                	j	80004a2c <sys_link+0x13c>
    end_op();
    800049ce:	fffff097          	auipc	ra,0xfffff
    800049d2:	d12080e7          	jalr	-750(ra) # 800036e0 <end_op>
    return -1;
    800049d6:	57fd                	li	a5,-1
    800049d8:	a891                	j	80004a2c <sys_link+0x13c>
    iunlockput(ip);
    800049da:	8526                	mv	a0,s1
    800049dc:	ffffe097          	auipc	ra,0xffffe
    800049e0:	50c080e7          	jalr	1292(ra) # 80002ee8 <iunlockput>
    end_op();
    800049e4:	fffff097          	auipc	ra,0xfffff
    800049e8:	cfc080e7          	jalr	-772(ra) # 800036e0 <end_op>
    return -1;
    800049ec:	57fd                	li	a5,-1
    800049ee:	a83d                	j	80004a2c <sys_link+0x13c>
    iunlockput(dp);
    800049f0:	854a                	mv	a0,s2
    800049f2:	ffffe097          	auipc	ra,0xffffe
    800049f6:	4f6080e7          	jalr	1270(ra) # 80002ee8 <iunlockput>
  ilock(ip);
    800049fa:	8526                	mv	a0,s1
    800049fc:	ffffe097          	auipc	ra,0xffffe
    80004a00:	28a080e7          	jalr	650(ra) # 80002c86 <ilock>
  ip->nlink--;
    80004a04:	04a4d783          	lhu	a5,74(s1)
    80004a08:	37fd                	addiw	a5,a5,-1
    80004a0a:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004a0e:	8526                	mv	a0,s1
    80004a10:	ffffe097          	auipc	ra,0xffffe
    80004a14:	1aa080e7          	jalr	426(ra) # 80002bba <iupdate>
  iunlockput(ip);
    80004a18:	8526                	mv	a0,s1
    80004a1a:	ffffe097          	auipc	ra,0xffffe
    80004a1e:	4ce080e7          	jalr	1230(ra) # 80002ee8 <iunlockput>
  end_op();
    80004a22:	fffff097          	auipc	ra,0xfffff
    80004a26:	cbe080e7          	jalr	-834(ra) # 800036e0 <end_op>
  return -1;
    80004a2a:	57fd                	li	a5,-1
}
    80004a2c:	853e                	mv	a0,a5
    80004a2e:	70b2                	ld	ra,296(sp)
    80004a30:	7412                	ld	s0,288(sp)
    80004a32:	64f2                	ld	s1,280(sp)
    80004a34:	6952                	ld	s2,272(sp)
    80004a36:	6155                	addi	sp,sp,304
    80004a38:	8082                	ret

0000000080004a3a <sys_unlink>:
{
    80004a3a:	7151                	addi	sp,sp,-240
    80004a3c:	f586                	sd	ra,232(sp)
    80004a3e:	f1a2                	sd	s0,224(sp)
    80004a40:	eda6                	sd	s1,216(sp)
    80004a42:	e9ca                	sd	s2,208(sp)
    80004a44:	e5ce                	sd	s3,200(sp)
    80004a46:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004a48:	08000613          	li	a2,128
    80004a4c:	f3040593          	addi	a1,s0,-208
    80004a50:	4501                	li	a0,0
    80004a52:	ffffd097          	auipc	ra,0xffffd
    80004a56:	706080e7          	jalr	1798(ra) # 80002158 <argstr>
    80004a5a:	18054163          	bltz	a0,80004bdc <sys_unlink+0x1a2>
  begin_op();
    80004a5e:	fffff097          	auipc	ra,0xfffff
    80004a62:	c04080e7          	jalr	-1020(ra) # 80003662 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004a66:	fb040593          	addi	a1,s0,-80
    80004a6a:	f3040513          	addi	a0,s0,-208
    80004a6e:	fffff097          	auipc	ra,0xfffff
    80004a72:	9f2080e7          	jalr	-1550(ra) # 80003460 <nameiparent>
    80004a76:	84aa                	mv	s1,a0
    80004a78:	c979                	beqz	a0,80004b4e <sys_unlink+0x114>
  ilock(dp);
    80004a7a:	ffffe097          	auipc	ra,0xffffe
    80004a7e:	20c080e7          	jalr	524(ra) # 80002c86 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004a82:	00004597          	auipc	a1,0x4
    80004a86:	c2658593          	addi	a1,a1,-986 # 800086a8 <syscalls+0x2b0>
    80004a8a:	fb040513          	addi	a0,s0,-80
    80004a8e:	ffffe097          	auipc	ra,0xffffe
    80004a92:	6c2080e7          	jalr	1730(ra) # 80003150 <namecmp>
    80004a96:	14050a63          	beqz	a0,80004bea <sys_unlink+0x1b0>
    80004a9a:	00004597          	auipc	a1,0x4
    80004a9e:	c1658593          	addi	a1,a1,-1002 # 800086b0 <syscalls+0x2b8>
    80004aa2:	fb040513          	addi	a0,s0,-80
    80004aa6:	ffffe097          	auipc	ra,0xffffe
    80004aaa:	6aa080e7          	jalr	1706(ra) # 80003150 <namecmp>
    80004aae:	12050e63          	beqz	a0,80004bea <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004ab2:	f2c40613          	addi	a2,s0,-212
    80004ab6:	fb040593          	addi	a1,s0,-80
    80004aba:	8526                	mv	a0,s1
    80004abc:	ffffe097          	auipc	ra,0xffffe
    80004ac0:	6ae080e7          	jalr	1710(ra) # 8000316a <dirlookup>
    80004ac4:	892a                	mv	s2,a0
    80004ac6:	12050263          	beqz	a0,80004bea <sys_unlink+0x1b0>
  ilock(ip);
    80004aca:	ffffe097          	auipc	ra,0xffffe
    80004ace:	1bc080e7          	jalr	444(ra) # 80002c86 <ilock>
  if(ip->nlink < 1)
    80004ad2:	04a91783          	lh	a5,74(s2)
    80004ad6:	08f05263          	blez	a5,80004b5a <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004ada:	04491703          	lh	a4,68(s2)
    80004ade:	4785                	li	a5,1
    80004ae0:	08f70563          	beq	a4,a5,80004b6a <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004ae4:	4641                	li	a2,16
    80004ae6:	4581                	li	a1,0
    80004ae8:	fc040513          	addi	a0,s0,-64
    80004aec:	ffffb097          	auipc	ra,0xffffb
    80004af0:	7d0080e7          	jalr	2000(ra) # 800002bc <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004af4:	4741                	li	a4,16
    80004af6:	f2c42683          	lw	a3,-212(s0)
    80004afa:	fc040613          	addi	a2,s0,-64
    80004afe:	4581                	li	a1,0
    80004b00:	8526                	mv	a0,s1
    80004b02:	ffffe097          	auipc	ra,0xffffe
    80004b06:	530080e7          	jalr	1328(ra) # 80003032 <writei>
    80004b0a:	47c1                	li	a5,16
    80004b0c:	0af51563          	bne	a0,a5,80004bb6 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80004b10:	04491703          	lh	a4,68(s2)
    80004b14:	4785                	li	a5,1
    80004b16:	0af70863          	beq	a4,a5,80004bc6 <sys_unlink+0x18c>
  iunlockput(dp);
    80004b1a:	8526                	mv	a0,s1
    80004b1c:	ffffe097          	auipc	ra,0xffffe
    80004b20:	3cc080e7          	jalr	972(ra) # 80002ee8 <iunlockput>
  ip->nlink--;
    80004b24:	04a95783          	lhu	a5,74(s2)
    80004b28:	37fd                	addiw	a5,a5,-1
    80004b2a:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004b2e:	854a                	mv	a0,s2
    80004b30:	ffffe097          	auipc	ra,0xffffe
    80004b34:	08a080e7          	jalr	138(ra) # 80002bba <iupdate>
  iunlockput(ip);
    80004b38:	854a                	mv	a0,s2
    80004b3a:	ffffe097          	auipc	ra,0xffffe
    80004b3e:	3ae080e7          	jalr	942(ra) # 80002ee8 <iunlockput>
  end_op();
    80004b42:	fffff097          	auipc	ra,0xfffff
    80004b46:	b9e080e7          	jalr	-1122(ra) # 800036e0 <end_op>
  return 0;
    80004b4a:	4501                	li	a0,0
    80004b4c:	a84d                	j	80004bfe <sys_unlink+0x1c4>
    end_op();
    80004b4e:	fffff097          	auipc	ra,0xfffff
    80004b52:	b92080e7          	jalr	-1134(ra) # 800036e0 <end_op>
    return -1;
    80004b56:	557d                	li	a0,-1
    80004b58:	a05d                	j	80004bfe <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004b5a:	00004517          	auipc	a0,0x4
    80004b5e:	b7e50513          	addi	a0,a0,-1154 # 800086d8 <syscalls+0x2e0>
    80004b62:	00001097          	auipc	ra,0x1
    80004b66:	19e080e7          	jalr	414(ra) # 80005d00 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004b6a:	04c92703          	lw	a4,76(s2)
    80004b6e:	02000793          	li	a5,32
    80004b72:	f6e7f9e3          	bgeu	a5,a4,80004ae4 <sys_unlink+0xaa>
    80004b76:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004b7a:	4741                	li	a4,16
    80004b7c:	86ce                	mv	a3,s3
    80004b7e:	f1840613          	addi	a2,s0,-232
    80004b82:	4581                	li	a1,0
    80004b84:	854a                	mv	a0,s2
    80004b86:	ffffe097          	auipc	ra,0xffffe
    80004b8a:	3b4080e7          	jalr	948(ra) # 80002f3a <readi>
    80004b8e:	47c1                	li	a5,16
    80004b90:	00f51b63          	bne	a0,a5,80004ba6 <sys_unlink+0x16c>
    if(de.inum != 0)
    80004b94:	f1845783          	lhu	a5,-232(s0)
    80004b98:	e7a1                	bnez	a5,80004be0 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004b9a:	29c1                	addiw	s3,s3,16
    80004b9c:	04c92783          	lw	a5,76(s2)
    80004ba0:	fcf9ede3          	bltu	s3,a5,80004b7a <sys_unlink+0x140>
    80004ba4:	b781                	j	80004ae4 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004ba6:	00004517          	auipc	a0,0x4
    80004baa:	b4a50513          	addi	a0,a0,-1206 # 800086f0 <syscalls+0x2f8>
    80004bae:	00001097          	auipc	ra,0x1
    80004bb2:	152080e7          	jalr	338(ra) # 80005d00 <panic>
    panic("unlink: writei");
    80004bb6:	00004517          	auipc	a0,0x4
    80004bba:	b5250513          	addi	a0,a0,-1198 # 80008708 <syscalls+0x310>
    80004bbe:	00001097          	auipc	ra,0x1
    80004bc2:	142080e7          	jalr	322(ra) # 80005d00 <panic>
    dp->nlink--;
    80004bc6:	04a4d783          	lhu	a5,74(s1)
    80004bca:	37fd                	addiw	a5,a5,-1
    80004bcc:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004bd0:	8526                	mv	a0,s1
    80004bd2:	ffffe097          	auipc	ra,0xffffe
    80004bd6:	fe8080e7          	jalr	-24(ra) # 80002bba <iupdate>
    80004bda:	b781                	j	80004b1a <sys_unlink+0xe0>
    return -1;
    80004bdc:	557d                	li	a0,-1
    80004bde:	a005                	j	80004bfe <sys_unlink+0x1c4>
    iunlockput(ip);
    80004be0:	854a                	mv	a0,s2
    80004be2:	ffffe097          	auipc	ra,0xffffe
    80004be6:	306080e7          	jalr	774(ra) # 80002ee8 <iunlockput>
  iunlockput(dp);
    80004bea:	8526                	mv	a0,s1
    80004bec:	ffffe097          	auipc	ra,0xffffe
    80004bf0:	2fc080e7          	jalr	764(ra) # 80002ee8 <iunlockput>
  end_op();
    80004bf4:	fffff097          	auipc	ra,0xfffff
    80004bf8:	aec080e7          	jalr	-1300(ra) # 800036e0 <end_op>
  return -1;
    80004bfc:	557d                	li	a0,-1
}
    80004bfe:	70ae                	ld	ra,232(sp)
    80004c00:	740e                	ld	s0,224(sp)
    80004c02:	64ee                	ld	s1,216(sp)
    80004c04:	694e                	ld	s2,208(sp)
    80004c06:	69ae                	ld	s3,200(sp)
    80004c08:	616d                	addi	sp,sp,240
    80004c0a:	8082                	ret

0000000080004c0c <sys_open>:

uint64
sys_open(void)
{
    80004c0c:	7131                	addi	sp,sp,-192
    80004c0e:	fd06                	sd	ra,184(sp)
    80004c10:	f922                	sd	s0,176(sp)
    80004c12:	f526                	sd	s1,168(sp)
    80004c14:	f14a                	sd	s2,160(sp)
    80004c16:	ed4e                	sd	s3,152(sp)
    80004c18:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004c1a:	08000613          	li	a2,128
    80004c1e:	f5040593          	addi	a1,s0,-176
    80004c22:	4501                	li	a0,0
    80004c24:	ffffd097          	auipc	ra,0xffffd
    80004c28:	534080e7          	jalr	1332(ra) # 80002158 <argstr>
    return -1;
    80004c2c:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004c2e:	0c054163          	bltz	a0,80004cf0 <sys_open+0xe4>
    80004c32:	f4c40593          	addi	a1,s0,-180
    80004c36:	4505                	li	a0,1
    80004c38:	ffffd097          	auipc	ra,0xffffd
    80004c3c:	4dc080e7          	jalr	1244(ra) # 80002114 <argint>
    80004c40:	0a054863          	bltz	a0,80004cf0 <sys_open+0xe4>

  begin_op();
    80004c44:	fffff097          	auipc	ra,0xfffff
    80004c48:	a1e080e7          	jalr	-1506(ra) # 80003662 <begin_op>

  if(omode & O_CREATE){
    80004c4c:	f4c42783          	lw	a5,-180(s0)
    80004c50:	2007f793          	andi	a5,a5,512
    80004c54:	cbdd                	beqz	a5,80004d0a <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80004c56:	4681                	li	a3,0
    80004c58:	4601                	li	a2,0
    80004c5a:	4589                	li	a1,2
    80004c5c:	f5040513          	addi	a0,s0,-176
    80004c60:	00000097          	auipc	ra,0x0
    80004c64:	970080e7          	jalr	-1680(ra) # 800045d0 <create>
    80004c68:	892a                	mv	s2,a0
    if(ip == 0){
    80004c6a:	c959                	beqz	a0,80004d00 <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004c6c:	04491703          	lh	a4,68(s2)
    80004c70:	478d                	li	a5,3
    80004c72:	00f71763          	bne	a4,a5,80004c80 <sys_open+0x74>
    80004c76:	04695703          	lhu	a4,70(s2)
    80004c7a:	47a5                	li	a5,9
    80004c7c:	0ce7ec63          	bltu	a5,a4,80004d54 <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004c80:	fffff097          	auipc	ra,0xfffff
    80004c84:	dee080e7          	jalr	-530(ra) # 80003a6e <filealloc>
    80004c88:	89aa                	mv	s3,a0
    80004c8a:	10050263          	beqz	a0,80004d8e <sys_open+0x182>
    80004c8e:	00000097          	auipc	ra,0x0
    80004c92:	900080e7          	jalr	-1792(ra) # 8000458e <fdalloc>
    80004c96:	84aa                	mv	s1,a0
    80004c98:	0e054663          	bltz	a0,80004d84 <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004c9c:	04491703          	lh	a4,68(s2)
    80004ca0:	478d                	li	a5,3
    80004ca2:	0cf70463          	beq	a4,a5,80004d6a <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004ca6:	4789                	li	a5,2
    80004ca8:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004cac:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004cb0:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004cb4:	f4c42783          	lw	a5,-180(s0)
    80004cb8:	0017c713          	xori	a4,a5,1
    80004cbc:	8b05                	andi	a4,a4,1
    80004cbe:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004cc2:	0037f713          	andi	a4,a5,3
    80004cc6:	00e03733          	snez	a4,a4
    80004cca:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004cce:	4007f793          	andi	a5,a5,1024
    80004cd2:	c791                	beqz	a5,80004cde <sys_open+0xd2>
    80004cd4:	04491703          	lh	a4,68(s2)
    80004cd8:	4789                	li	a5,2
    80004cda:	08f70f63          	beq	a4,a5,80004d78 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80004cde:	854a                	mv	a0,s2
    80004ce0:	ffffe097          	auipc	ra,0xffffe
    80004ce4:	068080e7          	jalr	104(ra) # 80002d48 <iunlock>
  end_op();
    80004ce8:	fffff097          	auipc	ra,0xfffff
    80004cec:	9f8080e7          	jalr	-1544(ra) # 800036e0 <end_op>

  return fd;
}
    80004cf0:	8526                	mv	a0,s1
    80004cf2:	70ea                	ld	ra,184(sp)
    80004cf4:	744a                	ld	s0,176(sp)
    80004cf6:	74aa                	ld	s1,168(sp)
    80004cf8:	790a                	ld	s2,160(sp)
    80004cfa:	69ea                	ld	s3,152(sp)
    80004cfc:	6129                	addi	sp,sp,192
    80004cfe:	8082                	ret
      end_op();
    80004d00:	fffff097          	auipc	ra,0xfffff
    80004d04:	9e0080e7          	jalr	-1568(ra) # 800036e0 <end_op>
      return -1;
    80004d08:	b7e5                	j	80004cf0 <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80004d0a:	f5040513          	addi	a0,s0,-176
    80004d0e:	ffffe097          	auipc	ra,0xffffe
    80004d12:	734080e7          	jalr	1844(ra) # 80003442 <namei>
    80004d16:	892a                	mv	s2,a0
    80004d18:	c905                	beqz	a0,80004d48 <sys_open+0x13c>
    ilock(ip);
    80004d1a:	ffffe097          	auipc	ra,0xffffe
    80004d1e:	f6c080e7          	jalr	-148(ra) # 80002c86 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004d22:	04491703          	lh	a4,68(s2)
    80004d26:	4785                	li	a5,1
    80004d28:	f4f712e3          	bne	a4,a5,80004c6c <sys_open+0x60>
    80004d2c:	f4c42783          	lw	a5,-180(s0)
    80004d30:	dba1                	beqz	a5,80004c80 <sys_open+0x74>
      iunlockput(ip);
    80004d32:	854a                	mv	a0,s2
    80004d34:	ffffe097          	auipc	ra,0xffffe
    80004d38:	1b4080e7          	jalr	436(ra) # 80002ee8 <iunlockput>
      end_op();
    80004d3c:	fffff097          	auipc	ra,0xfffff
    80004d40:	9a4080e7          	jalr	-1628(ra) # 800036e0 <end_op>
      return -1;
    80004d44:	54fd                	li	s1,-1
    80004d46:	b76d                	j	80004cf0 <sys_open+0xe4>
      end_op();
    80004d48:	fffff097          	auipc	ra,0xfffff
    80004d4c:	998080e7          	jalr	-1640(ra) # 800036e0 <end_op>
      return -1;
    80004d50:	54fd                	li	s1,-1
    80004d52:	bf79                	j	80004cf0 <sys_open+0xe4>
    iunlockput(ip);
    80004d54:	854a                	mv	a0,s2
    80004d56:	ffffe097          	auipc	ra,0xffffe
    80004d5a:	192080e7          	jalr	402(ra) # 80002ee8 <iunlockput>
    end_op();
    80004d5e:	fffff097          	auipc	ra,0xfffff
    80004d62:	982080e7          	jalr	-1662(ra) # 800036e0 <end_op>
    return -1;
    80004d66:	54fd                	li	s1,-1
    80004d68:	b761                	j	80004cf0 <sys_open+0xe4>
    f->type = FD_DEVICE;
    80004d6a:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004d6e:	04691783          	lh	a5,70(s2)
    80004d72:	02f99223          	sh	a5,36(s3)
    80004d76:	bf2d                	j	80004cb0 <sys_open+0xa4>
    itrunc(ip);
    80004d78:	854a                	mv	a0,s2
    80004d7a:	ffffe097          	auipc	ra,0xffffe
    80004d7e:	01a080e7          	jalr	26(ra) # 80002d94 <itrunc>
    80004d82:	bfb1                	j	80004cde <sys_open+0xd2>
      fileclose(f);
    80004d84:	854e                	mv	a0,s3
    80004d86:	fffff097          	auipc	ra,0xfffff
    80004d8a:	da4080e7          	jalr	-604(ra) # 80003b2a <fileclose>
    iunlockput(ip);
    80004d8e:	854a                	mv	a0,s2
    80004d90:	ffffe097          	auipc	ra,0xffffe
    80004d94:	158080e7          	jalr	344(ra) # 80002ee8 <iunlockput>
    end_op();
    80004d98:	fffff097          	auipc	ra,0xfffff
    80004d9c:	948080e7          	jalr	-1720(ra) # 800036e0 <end_op>
    return -1;
    80004da0:	54fd                	li	s1,-1
    80004da2:	b7b9                	j	80004cf0 <sys_open+0xe4>

0000000080004da4 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004da4:	7175                	addi	sp,sp,-144
    80004da6:	e506                	sd	ra,136(sp)
    80004da8:	e122                	sd	s0,128(sp)
    80004daa:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004dac:	fffff097          	auipc	ra,0xfffff
    80004db0:	8b6080e7          	jalr	-1866(ra) # 80003662 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004db4:	08000613          	li	a2,128
    80004db8:	f7040593          	addi	a1,s0,-144
    80004dbc:	4501                	li	a0,0
    80004dbe:	ffffd097          	auipc	ra,0xffffd
    80004dc2:	39a080e7          	jalr	922(ra) # 80002158 <argstr>
    80004dc6:	02054963          	bltz	a0,80004df8 <sys_mkdir+0x54>
    80004dca:	4681                	li	a3,0
    80004dcc:	4601                	li	a2,0
    80004dce:	4585                	li	a1,1
    80004dd0:	f7040513          	addi	a0,s0,-144
    80004dd4:	fffff097          	auipc	ra,0xfffff
    80004dd8:	7fc080e7          	jalr	2044(ra) # 800045d0 <create>
    80004ddc:	cd11                	beqz	a0,80004df8 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004dde:	ffffe097          	auipc	ra,0xffffe
    80004de2:	10a080e7          	jalr	266(ra) # 80002ee8 <iunlockput>
  end_op();
    80004de6:	fffff097          	auipc	ra,0xfffff
    80004dea:	8fa080e7          	jalr	-1798(ra) # 800036e0 <end_op>
  return 0;
    80004dee:	4501                	li	a0,0
}
    80004df0:	60aa                	ld	ra,136(sp)
    80004df2:	640a                	ld	s0,128(sp)
    80004df4:	6149                	addi	sp,sp,144
    80004df6:	8082                	ret
    end_op();
    80004df8:	fffff097          	auipc	ra,0xfffff
    80004dfc:	8e8080e7          	jalr	-1816(ra) # 800036e0 <end_op>
    return -1;
    80004e00:	557d                	li	a0,-1
    80004e02:	b7fd                	j	80004df0 <sys_mkdir+0x4c>

0000000080004e04 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004e04:	7135                	addi	sp,sp,-160
    80004e06:	ed06                	sd	ra,152(sp)
    80004e08:	e922                	sd	s0,144(sp)
    80004e0a:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004e0c:	fffff097          	auipc	ra,0xfffff
    80004e10:	856080e7          	jalr	-1962(ra) # 80003662 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004e14:	08000613          	li	a2,128
    80004e18:	f7040593          	addi	a1,s0,-144
    80004e1c:	4501                	li	a0,0
    80004e1e:	ffffd097          	auipc	ra,0xffffd
    80004e22:	33a080e7          	jalr	826(ra) # 80002158 <argstr>
    80004e26:	04054a63          	bltz	a0,80004e7a <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80004e2a:	f6c40593          	addi	a1,s0,-148
    80004e2e:	4505                	li	a0,1
    80004e30:	ffffd097          	auipc	ra,0xffffd
    80004e34:	2e4080e7          	jalr	740(ra) # 80002114 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004e38:	04054163          	bltz	a0,80004e7a <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80004e3c:	f6840593          	addi	a1,s0,-152
    80004e40:	4509                	li	a0,2
    80004e42:	ffffd097          	auipc	ra,0xffffd
    80004e46:	2d2080e7          	jalr	722(ra) # 80002114 <argint>
     argint(1, &major) < 0 ||
    80004e4a:	02054863          	bltz	a0,80004e7a <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004e4e:	f6841683          	lh	a3,-152(s0)
    80004e52:	f6c41603          	lh	a2,-148(s0)
    80004e56:	458d                	li	a1,3
    80004e58:	f7040513          	addi	a0,s0,-144
    80004e5c:	fffff097          	auipc	ra,0xfffff
    80004e60:	774080e7          	jalr	1908(ra) # 800045d0 <create>
     argint(2, &minor) < 0 ||
    80004e64:	c919                	beqz	a0,80004e7a <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004e66:	ffffe097          	auipc	ra,0xffffe
    80004e6a:	082080e7          	jalr	130(ra) # 80002ee8 <iunlockput>
  end_op();
    80004e6e:	fffff097          	auipc	ra,0xfffff
    80004e72:	872080e7          	jalr	-1934(ra) # 800036e0 <end_op>
  return 0;
    80004e76:	4501                	li	a0,0
    80004e78:	a031                	j	80004e84 <sys_mknod+0x80>
    end_op();
    80004e7a:	fffff097          	auipc	ra,0xfffff
    80004e7e:	866080e7          	jalr	-1946(ra) # 800036e0 <end_op>
    return -1;
    80004e82:	557d                	li	a0,-1
}
    80004e84:	60ea                	ld	ra,152(sp)
    80004e86:	644a                	ld	s0,144(sp)
    80004e88:	610d                	addi	sp,sp,160
    80004e8a:	8082                	ret

0000000080004e8c <sys_chdir>:

uint64
sys_chdir(void)
{
    80004e8c:	7135                	addi	sp,sp,-160
    80004e8e:	ed06                	sd	ra,152(sp)
    80004e90:	e922                	sd	s0,144(sp)
    80004e92:	e526                	sd	s1,136(sp)
    80004e94:	e14a                	sd	s2,128(sp)
    80004e96:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004e98:	ffffc097          	auipc	ra,0xffffc
    80004e9c:	1a8080e7          	jalr	424(ra) # 80001040 <myproc>
    80004ea0:	892a                	mv	s2,a0
  
  begin_op();
    80004ea2:	ffffe097          	auipc	ra,0xffffe
    80004ea6:	7c0080e7          	jalr	1984(ra) # 80003662 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004eaa:	08000613          	li	a2,128
    80004eae:	f6040593          	addi	a1,s0,-160
    80004eb2:	4501                	li	a0,0
    80004eb4:	ffffd097          	auipc	ra,0xffffd
    80004eb8:	2a4080e7          	jalr	676(ra) # 80002158 <argstr>
    80004ebc:	04054b63          	bltz	a0,80004f12 <sys_chdir+0x86>
    80004ec0:	f6040513          	addi	a0,s0,-160
    80004ec4:	ffffe097          	auipc	ra,0xffffe
    80004ec8:	57e080e7          	jalr	1406(ra) # 80003442 <namei>
    80004ecc:	84aa                	mv	s1,a0
    80004ece:	c131                	beqz	a0,80004f12 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004ed0:	ffffe097          	auipc	ra,0xffffe
    80004ed4:	db6080e7          	jalr	-586(ra) # 80002c86 <ilock>
  if(ip->type != T_DIR){
    80004ed8:	04449703          	lh	a4,68(s1)
    80004edc:	4785                	li	a5,1
    80004ede:	04f71063          	bne	a4,a5,80004f1e <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004ee2:	8526                	mv	a0,s1
    80004ee4:	ffffe097          	auipc	ra,0xffffe
    80004ee8:	e64080e7          	jalr	-412(ra) # 80002d48 <iunlock>
  iput(p->cwd);
    80004eec:	15093503          	ld	a0,336(s2)
    80004ef0:	ffffe097          	auipc	ra,0xffffe
    80004ef4:	f50080e7          	jalr	-176(ra) # 80002e40 <iput>
  end_op();
    80004ef8:	ffffe097          	auipc	ra,0xffffe
    80004efc:	7e8080e7          	jalr	2024(ra) # 800036e0 <end_op>
  p->cwd = ip;
    80004f00:	14993823          	sd	s1,336(s2)
  return 0;
    80004f04:	4501                	li	a0,0
}
    80004f06:	60ea                	ld	ra,152(sp)
    80004f08:	644a                	ld	s0,144(sp)
    80004f0a:	64aa                	ld	s1,136(sp)
    80004f0c:	690a                	ld	s2,128(sp)
    80004f0e:	610d                	addi	sp,sp,160
    80004f10:	8082                	ret
    end_op();
    80004f12:	ffffe097          	auipc	ra,0xffffe
    80004f16:	7ce080e7          	jalr	1998(ra) # 800036e0 <end_op>
    return -1;
    80004f1a:	557d                	li	a0,-1
    80004f1c:	b7ed                	j	80004f06 <sys_chdir+0x7a>
    iunlockput(ip);
    80004f1e:	8526                	mv	a0,s1
    80004f20:	ffffe097          	auipc	ra,0xffffe
    80004f24:	fc8080e7          	jalr	-56(ra) # 80002ee8 <iunlockput>
    end_op();
    80004f28:	ffffe097          	auipc	ra,0xffffe
    80004f2c:	7b8080e7          	jalr	1976(ra) # 800036e0 <end_op>
    return -1;
    80004f30:	557d                	li	a0,-1
    80004f32:	bfd1                	j	80004f06 <sys_chdir+0x7a>

0000000080004f34 <sys_exec>:

uint64
sys_exec(void)
{
    80004f34:	7145                	addi	sp,sp,-464
    80004f36:	e786                	sd	ra,456(sp)
    80004f38:	e3a2                	sd	s0,448(sp)
    80004f3a:	ff26                	sd	s1,440(sp)
    80004f3c:	fb4a                	sd	s2,432(sp)
    80004f3e:	f74e                	sd	s3,424(sp)
    80004f40:	f352                	sd	s4,416(sp)
    80004f42:	ef56                	sd	s5,408(sp)
    80004f44:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004f46:	08000613          	li	a2,128
    80004f4a:	f4040593          	addi	a1,s0,-192
    80004f4e:	4501                	li	a0,0
    80004f50:	ffffd097          	auipc	ra,0xffffd
    80004f54:	208080e7          	jalr	520(ra) # 80002158 <argstr>
    return -1;
    80004f58:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004f5a:	0c054b63          	bltz	a0,80005030 <sys_exec+0xfc>
    80004f5e:	e3840593          	addi	a1,s0,-456
    80004f62:	4505                	li	a0,1
    80004f64:	ffffd097          	auipc	ra,0xffffd
    80004f68:	1d2080e7          	jalr	466(ra) # 80002136 <argaddr>
    80004f6c:	0c054263          	bltz	a0,80005030 <sys_exec+0xfc>
  }
  memset(argv, 0, sizeof(argv));
    80004f70:	10000613          	li	a2,256
    80004f74:	4581                	li	a1,0
    80004f76:	e4040513          	addi	a0,s0,-448
    80004f7a:	ffffb097          	auipc	ra,0xffffb
    80004f7e:	342080e7          	jalr	834(ra) # 800002bc <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004f82:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80004f86:	89a6                	mv	s3,s1
    80004f88:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80004f8a:	02000a13          	li	s4,32
    80004f8e:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004f92:	00391513          	slli	a0,s2,0x3
    80004f96:	e3040593          	addi	a1,s0,-464
    80004f9a:	e3843783          	ld	a5,-456(s0)
    80004f9e:	953e                	add	a0,a0,a5
    80004fa0:	ffffd097          	auipc	ra,0xffffd
    80004fa4:	0da080e7          	jalr	218(ra) # 8000207a <fetchaddr>
    80004fa8:	02054a63          	bltz	a0,80004fdc <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    80004fac:	e3043783          	ld	a5,-464(s0)
    80004fb0:	c3b9                	beqz	a5,80004ff6 <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80004fb2:	ffffb097          	auipc	ra,0xffffb
    80004fb6:	26c080e7          	jalr	620(ra) # 8000021e <kalloc>
    80004fba:	85aa                	mv	a1,a0
    80004fbc:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80004fc0:	cd11                	beqz	a0,80004fdc <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004fc2:	6605                	lui	a2,0x1
    80004fc4:	e3043503          	ld	a0,-464(s0)
    80004fc8:	ffffd097          	auipc	ra,0xffffd
    80004fcc:	104080e7          	jalr	260(ra) # 800020cc <fetchstr>
    80004fd0:	00054663          	bltz	a0,80004fdc <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    80004fd4:	0905                	addi	s2,s2,1
    80004fd6:	09a1                	addi	s3,s3,8
    80004fd8:	fb491be3          	bne	s2,s4,80004f8e <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004fdc:	f4040913          	addi	s2,s0,-192
    80004fe0:	6088                	ld	a0,0(s1)
    80004fe2:	c531                	beqz	a0,8000502e <sys_exec+0xfa>
    kfree(argv[i]);
    80004fe4:	ffffb097          	auipc	ra,0xffffb
    80004fe8:	0b4080e7          	jalr	180(ra) # 80000098 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004fec:	04a1                	addi	s1,s1,8
    80004fee:	ff2499e3          	bne	s1,s2,80004fe0 <sys_exec+0xac>
  return -1;
    80004ff2:	597d                	li	s2,-1
    80004ff4:	a835                	j	80005030 <sys_exec+0xfc>
      argv[i] = 0;
    80004ff6:	0a8e                	slli	s5,s5,0x3
    80004ff8:	fc0a8793          	addi	a5,s5,-64 # ffffffffffffefc0 <end+0xffffffff7fdb8d80>
    80004ffc:	00878ab3          	add	s5,a5,s0
    80005000:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80005004:	e4040593          	addi	a1,s0,-448
    80005008:	f4040513          	addi	a0,s0,-192
    8000500c:	fffff097          	auipc	ra,0xfffff
    80005010:	172080e7          	jalr	370(ra) # 8000417e <exec>
    80005014:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005016:	f4040993          	addi	s3,s0,-192
    8000501a:	6088                	ld	a0,0(s1)
    8000501c:	c911                	beqz	a0,80005030 <sys_exec+0xfc>
    kfree(argv[i]);
    8000501e:	ffffb097          	auipc	ra,0xffffb
    80005022:	07a080e7          	jalr	122(ra) # 80000098 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005026:	04a1                	addi	s1,s1,8
    80005028:	ff3499e3          	bne	s1,s3,8000501a <sys_exec+0xe6>
    8000502c:	a011                	j	80005030 <sys_exec+0xfc>
  return -1;
    8000502e:	597d                	li	s2,-1
}
    80005030:	854a                	mv	a0,s2
    80005032:	60be                	ld	ra,456(sp)
    80005034:	641e                	ld	s0,448(sp)
    80005036:	74fa                	ld	s1,440(sp)
    80005038:	795a                	ld	s2,432(sp)
    8000503a:	79ba                	ld	s3,424(sp)
    8000503c:	7a1a                	ld	s4,416(sp)
    8000503e:	6afa                	ld	s5,408(sp)
    80005040:	6179                	addi	sp,sp,464
    80005042:	8082                	ret

0000000080005044 <sys_pipe>:

uint64
sys_pipe(void)
{
    80005044:	7139                	addi	sp,sp,-64
    80005046:	fc06                	sd	ra,56(sp)
    80005048:	f822                	sd	s0,48(sp)
    8000504a:	f426                	sd	s1,40(sp)
    8000504c:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    8000504e:	ffffc097          	auipc	ra,0xffffc
    80005052:	ff2080e7          	jalr	-14(ra) # 80001040 <myproc>
    80005056:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80005058:	fd840593          	addi	a1,s0,-40
    8000505c:	4501                	li	a0,0
    8000505e:	ffffd097          	auipc	ra,0xffffd
    80005062:	0d8080e7          	jalr	216(ra) # 80002136 <argaddr>
    return -1;
    80005066:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80005068:	0e054063          	bltz	a0,80005148 <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    8000506c:	fc840593          	addi	a1,s0,-56
    80005070:	fd040513          	addi	a0,s0,-48
    80005074:	fffff097          	auipc	ra,0xfffff
    80005078:	de6080e7          	jalr	-538(ra) # 80003e5a <pipealloc>
    return -1;
    8000507c:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    8000507e:	0c054563          	bltz	a0,80005148 <sys_pipe+0x104>
  fd0 = -1;
    80005082:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005086:	fd043503          	ld	a0,-48(s0)
    8000508a:	fffff097          	auipc	ra,0xfffff
    8000508e:	504080e7          	jalr	1284(ra) # 8000458e <fdalloc>
    80005092:	fca42223          	sw	a0,-60(s0)
    80005096:	08054c63          	bltz	a0,8000512e <sys_pipe+0xea>
    8000509a:	fc843503          	ld	a0,-56(s0)
    8000509e:	fffff097          	auipc	ra,0xfffff
    800050a2:	4f0080e7          	jalr	1264(ra) # 8000458e <fdalloc>
    800050a6:	fca42023          	sw	a0,-64(s0)
    800050aa:	06054963          	bltz	a0,8000511c <sys_pipe+0xd8>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800050ae:	4691                	li	a3,4
    800050b0:	fc440613          	addi	a2,s0,-60
    800050b4:	fd843583          	ld	a1,-40(s0)
    800050b8:	68a8                	ld	a0,80(s1)
    800050ba:	ffffc097          	auipc	ra,0xffffc
    800050be:	bfa080e7          	jalr	-1030(ra) # 80000cb4 <copyout>
    800050c2:	02054063          	bltz	a0,800050e2 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    800050c6:	4691                	li	a3,4
    800050c8:	fc040613          	addi	a2,s0,-64
    800050cc:	fd843583          	ld	a1,-40(s0)
    800050d0:	0591                	addi	a1,a1,4
    800050d2:	68a8                	ld	a0,80(s1)
    800050d4:	ffffc097          	auipc	ra,0xffffc
    800050d8:	be0080e7          	jalr	-1056(ra) # 80000cb4 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    800050dc:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800050de:	06055563          	bgez	a0,80005148 <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    800050e2:	fc442783          	lw	a5,-60(s0)
    800050e6:	07e9                	addi	a5,a5,26
    800050e8:	078e                	slli	a5,a5,0x3
    800050ea:	97a6                	add	a5,a5,s1
    800050ec:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800050f0:	fc042783          	lw	a5,-64(s0)
    800050f4:	07e9                	addi	a5,a5,26
    800050f6:	078e                	slli	a5,a5,0x3
    800050f8:	00f48533          	add	a0,s1,a5
    800050fc:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005100:	fd043503          	ld	a0,-48(s0)
    80005104:	fffff097          	auipc	ra,0xfffff
    80005108:	a26080e7          	jalr	-1498(ra) # 80003b2a <fileclose>
    fileclose(wf);
    8000510c:	fc843503          	ld	a0,-56(s0)
    80005110:	fffff097          	auipc	ra,0xfffff
    80005114:	a1a080e7          	jalr	-1510(ra) # 80003b2a <fileclose>
    return -1;
    80005118:	57fd                	li	a5,-1
    8000511a:	a03d                	j	80005148 <sys_pipe+0x104>
    if(fd0 >= 0)
    8000511c:	fc442783          	lw	a5,-60(s0)
    80005120:	0007c763          	bltz	a5,8000512e <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80005124:	07e9                	addi	a5,a5,26
    80005126:	078e                	slli	a5,a5,0x3
    80005128:	97a6                	add	a5,a5,s1
    8000512a:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    8000512e:	fd043503          	ld	a0,-48(s0)
    80005132:	fffff097          	auipc	ra,0xfffff
    80005136:	9f8080e7          	jalr	-1544(ra) # 80003b2a <fileclose>
    fileclose(wf);
    8000513a:	fc843503          	ld	a0,-56(s0)
    8000513e:	fffff097          	auipc	ra,0xfffff
    80005142:	9ec080e7          	jalr	-1556(ra) # 80003b2a <fileclose>
    return -1;
    80005146:	57fd                	li	a5,-1
}
    80005148:	853e                	mv	a0,a5
    8000514a:	70e2                	ld	ra,56(sp)
    8000514c:	7442                	ld	s0,48(sp)
    8000514e:	74a2                	ld	s1,40(sp)
    80005150:	6121                	addi	sp,sp,64
    80005152:	8082                	ret
	...

0000000080005160 <kernelvec>:
    80005160:	7111                	addi	sp,sp,-256
    80005162:	e006                	sd	ra,0(sp)
    80005164:	e40a                	sd	sp,8(sp)
    80005166:	e80e                	sd	gp,16(sp)
    80005168:	ec12                	sd	tp,24(sp)
    8000516a:	f016                	sd	t0,32(sp)
    8000516c:	f41a                	sd	t1,40(sp)
    8000516e:	f81e                	sd	t2,48(sp)
    80005170:	fc22                	sd	s0,56(sp)
    80005172:	e0a6                	sd	s1,64(sp)
    80005174:	e4aa                	sd	a0,72(sp)
    80005176:	e8ae                	sd	a1,80(sp)
    80005178:	ecb2                	sd	a2,88(sp)
    8000517a:	f0b6                	sd	a3,96(sp)
    8000517c:	f4ba                	sd	a4,104(sp)
    8000517e:	f8be                	sd	a5,112(sp)
    80005180:	fcc2                	sd	a6,120(sp)
    80005182:	e146                	sd	a7,128(sp)
    80005184:	e54a                	sd	s2,136(sp)
    80005186:	e94e                	sd	s3,144(sp)
    80005188:	ed52                	sd	s4,152(sp)
    8000518a:	f156                	sd	s5,160(sp)
    8000518c:	f55a                	sd	s6,168(sp)
    8000518e:	f95e                	sd	s7,176(sp)
    80005190:	fd62                	sd	s8,184(sp)
    80005192:	e1e6                	sd	s9,192(sp)
    80005194:	e5ea                	sd	s10,200(sp)
    80005196:	e9ee                	sd	s11,208(sp)
    80005198:	edf2                	sd	t3,216(sp)
    8000519a:	f1f6                	sd	t4,224(sp)
    8000519c:	f5fa                	sd	t5,232(sp)
    8000519e:	f9fe                	sd	t6,240(sp)
    800051a0:	da7fc0ef          	jal	ra,80001f46 <kerneltrap>
    800051a4:	6082                	ld	ra,0(sp)
    800051a6:	6122                	ld	sp,8(sp)
    800051a8:	61c2                	ld	gp,16(sp)
    800051aa:	7282                	ld	t0,32(sp)
    800051ac:	7322                	ld	t1,40(sp)
    800051ae:	73c2                	ld	t2,48(sp)
    800051b0:	7462                	ld	s0,56(sp)
    800051b2:	6486                	ld	s1,64(sp)
    800051b4:	6526                	ld	a0,72(sp)
    800051b6:	65c6                	ld	a1,80(sp)
    800051b8:	6666                	ld	a2,88(sp)
    800051ba:	7686                	ld	a3,96(sp)
    800051bc:	7726                	ld	a4,104(sp)
    800051be:	77c6                	ld	a5,112(sp)
    800051c0:	7866                	ld	a6,120(sp)
    800051c2:	688a                	ld	a7,128(sp)
    800051c4:	692a                	ld	s2,136(sp)
    800051c6:	69ca                	ld	s3,144(sp)
    800051c8:	6a6a                	ld	s4,152(sp)
    800051ca:	7a8a                	ld	s5,160(sp)
    800051cc:	7b2a                	ld	s6,168(sp)
    800051ce:	7bca                	ld	s7,176(sp)
    800051d0:	7c6a                	ld	s8,184(sp)
    800051d2:	6c8e                	ld	s9,192(sp)
    800051d4:	6d2e                	ld	s10,200(sp)
    800051d6:	6dce                	ld	s11,208(sp)
    800051d8:	6e6e                	ld	t3,216(sp)
    800051da:	7e8e                	ld	t4,224(sp)
    800051dc:	7f2e                	ld	t5,232(sp)
    800051de:	7fce                	ld	t6,240(sp)
    800051e0:	6111                	addi	sp,sp,256
    800051e2:	10200073          	sret
    800051e6:	00000013          	nop
    800051ea:	00000013          	nop
    800051ee:	0001                	nop

00000000800051f0 <timervec>:
    800051f0:	34051573          	csrrw	a0,mscratch,a0
    800051f4:	e10c                	sd	a1,0(a0)
    800051f6:	e510                	sd	a2,8(a0)
    800051f8:	e914                	sd	a3,16(a0)
    800051fa:	6d0c                	ld	a1,24(a0)
    800051fc:	7110                	ld	a2,32(a0)
    800051fe:	6194                	ld	a3,0(a1)
    80005200:	96b2                	add	a3,a3,a2
    80005202:	e194                	sd	a3,0(a1)
    80005204:	4589                	li	a1,2
    80005206:	14459073          	csrw	sip,a1
    8000520a:	6914                	ld	a3,16(a0)
    8000520c:	6510                	ld	a2,8(a0)
    8000520e:	610c                	ld	a1,0(a0)
    80005210:	34051573          	csrrw	a0,mscratch,a0
    80005214:	30200073          	mret
	...

000000008000521a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000521a:	1141                	addi	sp,sp,-16
    8000521c:	e422                	sd	s0,8(sp)
    8000521e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005220:	0c0007b7          	lui	a5,0xc000
    80005224:	4705                	li	a4,1
    80005226:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005228:	c3d8                	sw	a4,4(a5)
}
    8000522a:	6422                	ld	s0,8(sp)
    8000522c:	0141                	addi	sp,sp,16
    8000522e:	8082                	ret

0000000080005230 <plicinithart>:

void
plicinithart(void)
{
    80005230:	1141                	addi	sp,sp,-16
    80005232:	e406                	sd	ra,8(sp)
    80005234:	e022                	sd	s0,0(sp)
    80005236:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005238:	ffffc097          	auipc	ra,0xffffc
    8000523c:	ddc080e7          	jalr	-548(ra) # 80001014 <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005240:	0085171b          	slliw	a4,a0,0x8
    80005244:	0c0027b7          	lui	a5,0xc002
    80005248:	97ba                	add	a5,a5,a4
    8000524a:	40200713          	li	a4,1026
    8000524e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005252:	00d5151b          	slliw	a0,a0,0xd
    80005256:	0c2017b7          	lui	a5,0xc201
    8000525a:	97aa                	add	a5,a5,a0
    8000525c:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005260:	60a2                	ld	ra,8(sp)
    80005262:	6402                	ld	s0,0(sp)
    80005264:	0141                	addi	sp,sp,16
    80005266:	8082                	ret

0000000080005268 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005268:	1141                	addi	sp,sp,-16
    8000526a:	e406                	sd	ra,8(sp)
    8000526c:	e022                	sd	s0,0(sp)
    8000526e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005270:	ffffc097          	auipc	ra,0xffffc
    80005274:	da4080e7          	jalr	-604(ra) # 80001014 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005278:	00d5151b          	slliw	a0,a0,0xd
    8000527c:	0c2017b7          	lui	a5,0xc201
    80005280:	97aa                	add	a5,a5,a0
  return irq;
}
    80005282:	43c8                	lw	a0,4(a5)
    80005284:	60a2                	ld	ra,8(sp)
    80005286:	6402                	ld	s0,0(sp)
    80005288:	0141                	addi	sp,sp,16
    8000528a:	8082                	ret

000000008000528c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000528c:	1101                	addi	sp,sp,-32
    8000528e:	ec06                	sd	ra,24(sp)
    80005290:	e822                	sd	s0,16(sp)
    80005292:	e426                	sd	s1,8(sp)
    80005294:	1000                	addi	s0,sp,32
    80005296:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005298:	ffffc097          	auipc	ra,0xffffc
    8000529c:	d7c080e7          	jalr	-644(ra) # 80001014 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800052a0:	00d5151b          	slliw	a0,a0,0xd
    800052a4:	0c2017b7          	lui	a5,0xc201
    800052a8:	97aa                	add	a5,a5,a0
    800052aa:	c3c4                	sw	s1,4(a5)
}
    800052ac:	60e2                	ld	ra,24(sp)
    800052ae:	6442                	ld	s0,16(sp)
    800052b0:	64a2                	ld	s1,8(sp)
    800052b2:	6105                	addi	sp,sp,32
    800052b4:	8082                	ret

00000000800052b6 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800052b6:	1141                	addi	sp,sp,-16
    800052b8:	e406                	sd	ra,8(sp)
    800052ba:	e022                	sd	s0,0(sp)
    800052bc:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800052be:	479d                	li	a5,7
    800052c0:	06a7c863          	blt	a5,a0,80005330 <free_desc+0x7a>
    panic("free_desc 1");
  if(disk.free[i])
    800052c4:	00236717          	auipc	a4,0x236
    800052c8:	d3c70713          	addi	a4,a4,-708 # 8023b000 <disk>
    800052cc:	972a                	add	a4,a4,a0
    800052ce:	6789                	lui	a5,0x2
    800052d0:	97ba                	add	a5,a5,a4
    800052d2:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    800052d6:	e7ad                	bnez	a5,80005340 <free_desc+0x8a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    800052d8:	00451793          	slli	a5,a0,0x4
    800052dc:	00238717          	auipc	a4,0x238
    800052e0:	d2470713          	addi	a4,a4,-732 # 8023d000 <disk+0x2000>
    800052e4:	6314                	ld	a3,0(a4)
    800052e6:	96be                	add	a3,a3,a5
    800052e8:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    800052ec:	6314                	ld	a3,0(a4)
    800052ee:	96be                	add	a3,a3,a5
    800052f0:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    800052f4:	6314                	ld	a3,0(a4)
    800052f6:	96be                	add	a3,a3,a5
    800052f8:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    800052fc:	6318                	ld	a4,0(a4)
    800052fe:	97ba                	add	a5,a5,a4
    80005300:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005304:	00236717          	auipc	a4,0x236
    80005308:	cfc70713          	addi	a4,a4,-772 # 8023b000 <disk>
    8000530c:	972a                	add	a4,a4,a0
    8000530e:	6789                	lui	a5,0x2
    80005310:	97ba                	add	a5,a5,a4
    80005312:	4705                	li	a4,1
    80005314:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    80005318:	00238517          	auipc	a0,0x238
    8000531c:	d0050513          	addi	a0,a0,-768 # 8023d018 <disk+0x2018>
    80005320:	ffffc097          	auipc	ra,0xffffc
    80005324:	570080e7          	jalr	1392(ra) # 80001890 <wakeup>
}
    80005328:	60a2                	ld	ra,8(sp)
    8000532a:	6402                	ld	s0,0(sp)
    8000532c:	0141                	addi	sp,sp,16
    8000532e:	8082                	ret
    panic("free_desc 1");
    80005330:	00003517          	auipc	a0,0x3
    80005334:	3e850513          	addi	a0,a0,1000 # 80008718 <syscalls+0x320>
    80005338:	00001097          	auipc	ra,0x1
    8000533c:	9c8080e7          	jalr	-1592(ra) # 80005d00 <panic>
    panic("free_desc 2");
    80005340:	00003517          	auipc	a0,0x3
    80005344:	3e850513          	addi	a0,a0,1000 # 80008728 <syscalls+0x330>
    80005348:	00001097          	auipc	ra,0x1
    8000534c:	9b8080e7          	jalr	-1608(ra) # 80005d00 <panic>

0000000080005350 <virtio_disk_init>:
{
    80005350:	1101                	addi	sp,sp,-32
    80005352:	ec06                	sd	ra,24(sp)
    80005354:	e822                	sd	s0,16(sp)
    80005356:	e426                	sd	s1,8(sp)
    80005358:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    8000535a:	00003597          	auipc	a1,0x3
    8000535e:	3de58593          	addi	a1,a1,990 # 80008738 <syscalls+0x340>
    80005362:	00238517          	auipc	a0,0x238
    80005366:	dc650513          	addi	a0,a0,-570 # 8023d128 <disk+0x2128>
    8000536a:	00001097          	auipc	ra,0x1
    8000536e:	e3e080e7          	jalr	-450(ra) # 800061a8 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005372:	100017b7          	lui	a5,0x10001
    80005376:	4398                	lw	a4,0(a5)
    80005378:	2701                	sext.w	a4,a4
    8000537a:	747277b7          	lui	a5,0x74727
    8000537e:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005382:	0ef71063          	bne	a4,a5,80005462 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005386:	100017b7          	lui	a5,0x10001
    8000538a:	43dc                	lw	a5,4(a5)
    8000538c:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000538e:	4705                	li	a4,1
    80005390:	0ce79963          	bne	a5,a4,80005462 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005394:	100017b7          	lui	a5,0x10001
    80005398:	479c                	lw	a5,8(a5)
    8000539a:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000539c:	4709                	li	a4,2
    8000539e:	0ce79263          	bne	a5,a4,80005462 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800053a2:	100017b7          	lui	a5,0x10001
    800053a6:	47d8                	lw	a4,12(a5)
    800053a8:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800053aa:	554d47b7          	lui	a5,0x554d4
    800053ae:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800053b2:	0af71863          	bne	a4,a5,80005462 <virtio_disk_init+0x112>
  *R(VIRTIO_MMIO_STATUS) = status;
    800053b6:	100017b7          	lui	a5,0x10001
    800053ba:	4705                	li	a4,1
    800053bc:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800053be:	470d                	li	a4,3
    800053c0:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800053c2:	4b98                	lw	a4,16(a5)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800053c4:	c7ffe6b7          	lui	a3,0xc7ffe
    800053c8:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47db851f>
    800053cc:	8f75                	and	a4,a4,a3
    800053ce:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800053d0:	472d                	li	a4,11
    800053d2:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800053d4:	473d                	li	a4,15
    800053d6:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    800053d8:	6705                	lui	a4,0x1
    800053da:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800053dc:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800053e0:	5bdc                	lw	a5,52(a5)
    800053e2:	2781                	sext.w	a5,a5
  if(max == 0)
    800053e4:	c7d9                	beqz	a5,80005472 <virtio_disk_init+0x122>
  if(max < NUM)
    800053e6:	471d                	li	a4,7
    800053e8:	08f77d63          	bgeu	a4,a5,80005482 <virtio_disk_init+0x132>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800053ec:	100014b7          	lui	s1,0x10001
    800053f0:	47a1                	li	a5,8
    800053f2:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    800053f4:	6609                	lui	a2,0x2
    800053f6:	4581                	li	a1,0
    800053f8:	00236517          	auipc	a0,0x236
    800053fc:	c0850513          	addi	a0,a0,-1016 # 8023b000 <disk>
    80005400:	ffffb097          	auipc	ra,0xffffb
    80005404:	ebc080e7          	jalr	-324(ra) # 800002bc <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    80005408:	00236717          	auipc	a4,0x236
    8000540c:	bf870713          	addi	a4,a4,-1032 # 8023b000 <disk>
    80005410:	00c75793          	srli	a5,a4,0xc
    80005414:	2781                	sext.w	a5,a5
    80005416:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    80005418:	00238797          	auipc	a5,0x238
    8000541c:	be878793          	addi	a5,a5,-1048 # 8023d000 <disk+0x2000>
    80005420:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80005422:	00236717          	auipc	a4,0x236
    80005426:	c5e70713          	addi	a4,a4,-930 # 8023b080 <disk+0x80>
    8000542a:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    8000542c:	00237717          	auipc	a4,0x237
    80005430:	bd470713          	addi	a4,a4,-1068 # 8023c000 <disk+0x1000>
    80005434:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    80005436:	4705                	li	a4,1
    80005438:	00e78c23          	sb	a4,24(a5)
    8000543c:	00e78ca3          	sb	a4,25(a5)
    80005440:	00e78d23          	sb	a4,26(a5)
    80005444:	00e78da3          	sb	a4,27(a5)
    80005448:	00e78e23          	sb	a4,28(a5)
    8000544c:	00e78ea3          	sb	a4,29(a5)
    80005450:	00e78f23          	sb	a4,30(a5)
    80005454:	00e78fa3          	sb	a4,31(a5)
}
    80005458:	60e2                	ld	ra,24(sp)
    8000545a:	6442                	ld	s0,16(sp)
    8000545c:	64a2                	ld	s1,8(sp)
    8000545e:	6105                	addi	sp,sp,32
    80005460:	8082                	ret
    panic("could not find virtio disk");
    80005462:	00003517          	auipc	a0,0x3
    80005466:	2e650513          	addi	a0,a0,742 # 80008748 <syscalls+0x350>
    8000546a:	00001097          	auipc	ra,0x1
    8000546e:	896080e7          	jalr	-1898(ra) # 80005d00 <panic>
    panic("virtio disk has no queue 0");
    80005472:	00003517          	auipc	a0,0x3
    80005476:	2f650513          	addi	a0,a0,758 # 80008768 <syscalls+0x370>
    8000547a:	00001097          	auipc	ra,0x1
    8000547e:	886080e7          	jalr	-1914(ra) # 80005d00 <panic>
    panic("virtio disk max queue too short");
    80005482:	00003517          	auipc	a0,0x3
    80005486:	30650513          	addi	a0,a0,774 # 80008788 <syscalls+0x390>
    8000548a:	00001097          	auipc	ra,0x1
    8000548e:	876080e7          	jalr	-1930(ra) # 80005d00 <panic>

0000000080005492 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005492:	7119                	addi	sp,sp,-128
    80005494:	fc86                	sd	ra,120(sp)
    80005496:	f8a2                	sd	s0,112(sp)
    80005498:	f4a6                	sd	s1,104(sp)
    8000549a:	f0ca                	sd	s2,96(sp)
    8000549c:	ecce                	sd	s3,88(sp)
    8000549e:	e8d2                	sd	s4,80(sp)
    800054a0:	e4d6                	sd	s5,72(sp)
    800054a2:	e0da                	sd	s6,64(sp)
    800054a4:	fc5e                	sd	s7,56(sp)
    800054a6:	f862                	sd	s8,48(sp)
    800054a8:	f466                	sd	s9,40(sp)
    800054aa:	f06a                	sd	s10,32(sp)
    800054ac:	ec6e                	sd	s11,24(sp)
    800054ae:	0100                	addi	s0,sp,128
    800054b0:	8aaa                	mv	s5,a0
    800054b2:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    800054b4:	00c52c83          	lw	s9,12(a0)
    800054b8:	001c9c9b          	slliw	s9,s9,0x1
    800054bc:	1c82                	slli	s9,s9,0x20
    800054be:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    800054c2:	00238517          	auipc	a0,0x238
    800054c6:	c6650513          	addi	a0,a0,-922 # 8023d128 <disk+0x2128>
    800054ca:	00001097          	auipc	ra,0x1
    800054ce:	d6e080e7          	jalr	-658(ra) # 80006238 <acquire>
  for(int i = 0; i < 3; i++){
    800054d2:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    800054d4:	44a1                	li	s1,8
      disk.free[i] = 0;
    800054d6:	00236c17          	auipc	s8,0x236
    800054da:	b2ac0c13          	addi	s8,s8,-1238 # 8023b000 <disk>
    800054de:	6b89                	lui	s7,0x2
  for(int i = 0; i < 3; i++){
    800054e0:	4b0d                	li	s6,3
    800054e2:	a0ad                	j	8000554c <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    800054e4:	00fc0733          	add	a4,s8,a5
    800054e8:	975e                	add	a4,a4,s7
    800054ea:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    800054ee:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    800054f0:	0207c563          	bltz	a5,8000551a <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    800054f4:	2905                	addiw	s2,s2,1
    800054f6:	0611                	addi	a2,a2,4 # 2004 <_entry-0x7fffdffc>
    800054f8:	19690c63          	beq	s2,s6,80005690 <virtio_disk_rw+0x1fe>
    idx[i] = alloc_desc();
    800054fc:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    800054fe:	00238717          	auipc	a4,0x238
    80005502:	b1a70713          	addi	a4,a4,-1254 # 8023d018 <disk+0x2018>
    80005506:	87ce                	mv	a5,s3
    if(disk.free[i]){
    80005508:	00074683          	lbu	a3,0(a4)
    8000550c:	fee1                	bnez	a3,800054e4 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    8000550e:	2785                	addiw	a5,a5,1
    80005510:	0705                	addi	a4,a4,1
    80005512:	fe979be3          	bne	a5,s1,80005508 <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    80005516:	57fd                	li	a5,-1
    80005518:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    8000551a:	01205d63          	blez	s2,80005534 <virtio_disk_rw+0xa2>
    8000551e:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    80005520:	000a2503          	lw	a0,0(s4)
    80005524:	00000097          	auipc	ra,0x0
    80005528:	d92080e7          	jalr	-622(ra) # 800052b6 <free_desc>
      for(int j = 0; j < i; j++)
    8000552c:	2d85                	addiw	s11,s11,1
    8000552e:	0a11                	addi	s4,s4,4
    80005530:	ff2d98e3          	bne	s11,s2,80005520 <virtio_disk_rw+0x8e>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005534:	00238597          	auipc	a1,0x238
    80005538:	bf458593          	addi	a1,a1,-1036 # 8023d128 <disk+0x2128>
    8000553c:	00238517          	auipc	a0,0x238
    80005540:	adc50513          	addi	a0,a0,-1316 # 8023d018 <disk+0x2018>
    80005544:	ffffc097          	auipc	ra,0xffffc
    80005548:	1c0080e7          	jalr	448(ra) # 80001704 <sleep>
  for(int i = 0; i < 3; i++){
    8000554c:	f8040a13          	addi	s4,s0,-128
{
    80005550:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    80005552:	894e                	mv	s2,s3
    80005554:	b765                	j	800054fc <virtio_disk_rw+0x6a>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80005556:	00238697          	auipc	a3,0x238
    8000555a:	aaa6b683          	ld	a3,-1366(a3) # 8023d000 <disk+0x2000>
    8000555e:	96ba                	add	a3,a3,a4
    80005560:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005564:	00236817          	auipc	a6,0x236
    80005568:	a9c80813          	addi	a6,a6,-1380 # 8023b000 <disk>
    8000556c:	00238697          	auipc	a3,0x238
    80005570:	a9468693          	addi	a3,a3,-1388 # 8023d000 <disk+0x2000>
    80005574:	6290                	ld	a2,0(a3)
    80005576:	963a                	add	a2,a2,a4
    80005578:	00c65583          	lhu	a1,12(a2)
    8000557c:	0015e593          	ori	a1,a1,1
    80005580:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[1]].next = idx[2];
    80005584:	f8842603          	lw	a2,-120(s0)
    80005588:	628c                	ld	a1,0(a3)
    8000558a:	972e                	add	a4,a4,a1
    8000558c:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005590:	20050593          	addi	a1,a0,512
    80005594:	0592                	slli	a1,a1,0x4
    80005596:	95c2                	add	a1,a1,a6
    80005598:	577d                	li	a4,-1
    8000559a:	02e58823          	sb	a4,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    8000559e:	00461713          	slli	a4,a2,0x4
    800055a2:	6290                	ld	a2,0(a3)
    800055a4:	963a                	add	a2,a2,a4
    800055a6:	03078793          	addi	a5,a5,48
    800055aa:	97c2                	add	a5,a5,a6
    800055ac:	e21c                	sd	a5,0(a2)
  disk.desc[idx[2]].len = 1;
    800055ae:	629c                	ld	a5,0(a3)
    800055b0:	97ba                	add	a5,a5,a4
    800055b2:	4605                	li	a2,1
    800055b4:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800055b6:	629c                	ld	a5,0(a3)
    800055b8:	97ba                	add	a5,a5,a4
    800055ba:	4809                	li	a6,2
    800055bc:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    800055c0:	629c                	ld	a5,0(a3)
    800055c2:	97ba                	add	a5,a5,a4
    800055c4:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800055c8:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    800055cc:	0355b423          	sd	s5,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800055d0:	6698                	ld	a4,8(a3)
    800055d2:	00275783          	lhu	a5,2(a4)
    800055d6:	8b9d                	andi	a5,a5,7
    800055d8:	0786                	slli	a5,a5,0x1
    800055da:	973e                	add	a4,a4,a5
    800055dc:	00a71223          	sh	a0,4(a4)

  __sync_synchronize();
    800055e0:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    800055e4:	6698                	ld	a4,8(a3)
    800055e6:	00275783          	lhu	a5,2(a4)
    800055ea:	2785                	addiw	a5,a5,1
    800055ec:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    800055f0:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800055f4:	100017b7          	lui	a5,0x10001
    800055f8:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800055fc:	004aa783          	lw	a5,4(s5)
    80005600:	02c79163          	bne	a5,a2,80005622 <virtio_disk_rw+0x190>
    sleep(b, &disk.vdisk_lock);
    80005604:	00238917          	auipc	s2,0x238
    80005608:	b2490913          	addi	s2,s2,-1244 # 8023d128 <disk+0x2128>
  while(b->disk == 1) {
    8000560c:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    8000560e:	85ca                	mv	a1,s2
    80005610:	8556                	mv	a0,s5
    80005612:	ffffc097          	auipc	ra,0xffffc
    80005616:	0f2080e7          	jalr	242(ra) # 80001704 <sleep>
  while(b->disk == 1) {
    8000561a:	004aa783          	lw	a5,4(s5)
    8000561e:	fe9788e3          	beq	a5,s1,8000560e <virtio_disk_rw+0x17c>
  }

  disk.info[idx[0]].b = 0;
    80005622:	f8042903          	lw	s2,-128(s0)
    80005626:	20090713          	addi	a4,s2,512
    8000562a:	0712                	slli	a4,a4,0x4
    8000562c:	00236797          	auipc	a5,0x236
    80005630:	9d478793          	addi	a5,a5,-1580 # 8023b000 <disk>
    80005634:	97ba                	add	a5,a5,a4
    80005636:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    8000563a:	00238997          	auipc	s3,0x238
    8000563e:	9c698993          	addi	s3,s3,-1594 # 8023d000 <disk+0x2000>
    80005642:	00491713          	slli	a4,s2,0x4
    80005646:	0009b783          	ld	a5,0(s3)
    8000564a:	97ba                	add	a5,a5,a4
    8000564c:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005650:	854a                	mv	a0,s2
    80005652:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005656:	00000097          	auipc	ra,0x0
    8000565a:	c60080e7          	jalr	-928(ra) # 800052b6 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    8000565e:	8885                	andi	s1,s1,1
    80005660:	f0ed                	bnez	s1,80005642 <virtio_disk_rw+0x1b0>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005662:	00238517          	auipc	a0,0x238
    80005666:	ac650513          	addi	a0,a0,-1338 # 8023d128 <disk+0x2128>
    8000566a:	00001097          	auipc	ra,0x1
    8000566e:	c82080e7          	jalr	-894(ra) # 800062ec <release>
}
    80005672:	70e6                	ld	ra,120(sp)
    80005674:	7446                	ld	s0,112(sp)
    80005676:	74a6                	ld	s1,104(sp)
    80005678:	7906                	ld	s2,96(sp)
    8000567a:	69e6                	ld	s3,88(sp)
    8000567c:	6a46                	ld	s4,80(sp)
    8000567e:	6aa6                	ld	s5,72(sp)
    80005680:	6b06                	ld	s6,64(sp)
    80005682:	7be2                	ld	s7,56(sp)
    80005684:	7c42                	ld	s8,48(sp)
    80005686:	7ca2                	ld	s9,40(sp)
    80005688:	7d02                	ld	s10,32(sp)
    8000568a:	6de2                	ld	s11,24(sp)
    8000568c:	6109                	addi	sp,sp,128
    8000568e:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005690:	f8042503          	lw	a0,-128(s0)
    80005694:	20050793          	addi	a5,a0,512
    80005698:	0792                	slli	a5,a5,0x4
  if(write)
    8000569a:	00236817          	auipc	a6,0x236
    8000569e:	96680813          	addi	a6,a6,-1690 # 8023b000 <disk>
    800056a2:	00f80733          	add	a4,a6,a5
    800056a6:	01a036b3          	snez	a3,s10
    800056aa:	0ad72423          	sw	a3,168(a4)
  buf0->reserved = 0;
    800056ae:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    800056b2:	0b973823          	sd	s9,176(a4)
  disk.desc[idx[0]].addr = (uint64) buf0;
    800056b6:	7679                	lui	a2,0xffffe
    800056b8:	963e                	add	a2,a2,a5
    800056ba:	00238697          	auipc	a3,0x238
    800056be:	94668693          	addi	a3,a3,-1722 # 8023d000 <disk+0x2000>
    800056c2:	6298                	ld	a4,0(a3)
    800056c4:	9732                	add	a4,a4,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800056c6:	0a878593          	addi	a1,a5,168
    800056ca:	95c2                	add	a1,a1,a6
  disk.desc[idx[0]].addr = (uint64) buf0;
    800056cc:	e30c                	sd	a1,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800056ce:	6298                	ld	a4,0(a3)
    800056d0:	9732                	add	a4,a4,a2
    800056d2:	45c1                	li	a1,16
    800056d4:	c70c                	sw	a1,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800056d6:	6298                	ld	a4,0(a3)
    800056d8:	9732                	add	a4,a4,a2
    800056da:	4585                	li	a1,1
    800056dc:	00b71623          	sh	a1,12(a4)
  disk.desc[idx[0]].next = idx[1];
    800056e0:	f8442703          	lw	a4,-124(s0)
    800056e4:	628c                	ld	a1,0(a3)
    800056e6:	962e                	add	a2,a2,a1
    800056e8:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7fdb7dce>
  disk.desc[idx[1]].addr = (uint64) b->data;
    800056ec:	0712                	slli	a4,a4,0x4
    800056ee:	6290                	ld	a2,0(a3)
    800056f0:	963a                	add	a2,a2,a4
    800056f2:	058a8593          	addi	a1,s5,88
    800056f6:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    800056f8:	6294                	ld	a3,0(a3)
    800056fa:	96ba                	add	a3,a3,a4
    800056fc:	40000613          	li	a2,1024
    80005700:	c690                	sw	a2,8(a3)
  if(write)
    80005702:	e40d1ae3          	bnez	s10,80005556 <virtio_disk_rw+0xc4>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80005706:	00238697          	auipc	a3,0x238
    8000570a:	8fa6b683          	ld	a3,-1798(a3) # 8023d000 <disk+0x2000>
    8000570e:	96ba                	add	a3,a3,a4
    80005710:	4609                	li	a2,2
    80005712:	00c69623          	sh	a2,12(a3)
    80005716:	b5b9                	j	80005564 <virtio_disk_rw+0xd2>

0000000080005718 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005718:	1101                	addi	sp,sp,-32
    8000571a:	ec06                	sd	ra,24(sp)
    8000571c:	e822                	sd	s0,16(sp)
    8000571e:	e426                	sd	s1,8(sp)
    80005720:	e04a                	sd	s2,0(sp)
    80005722:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005724:	00238517          	auipc	a0,0x238
    80005728:	a0450513          	addi	a0,a0,-1532 # 8023d128 <disk+0x2128>
    8000572c:	00001097          	auipc	ra,0x1
    80005730:	b0c080e7          	jalr	-1268(ra) # 80006238 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005734:	10001737          	lui	a4,0x10001
    80005738:	533c                	lw	a5,96(a4)
    8000573a:	8b8d                	andi	a5,a5,3
    8000573c:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    8000573e:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005742:	00238797          	auipc	a5,0x238
    80005746:	8be78793          	addi	a5,a5,-1858 # 8023d000 <disk+0x2000>
    8000574a:	6b94                	ld	a3,16(a5)
    8000574c:	0207d703          	lhu	a4,32(a5)
    80005750:	0026d783          	lhu	a5,2(a3)
    80005754:	06f70163          	beq	a4,a5,800057b6 <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005758:	00236917          	auipc	s2,0x236
    8000575c:	8a890913          	addi	s2,s2,-1880 # 8023b000 <disk>
    80005760:	00238497          	auipc	s1,0x238
    80005764:	8a048493          	addi	s1,s1,-1888 # 8023d000 <disk+0x2000>
    __sync_synchronize();
    80005768:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000576c:	6898                	ld	a4,16(s1)
    8000576e:	0204d783          	lhu	a5,32(s1)
    80005772:	8b9d                	andi	a5,a5,7
    80005774:	078e                	slli	a5,a5,0x3
    80005776:	97ba                	add	a5,a5,a4
    80005778:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    8000577a:	20078713          	addi	a4,a5,512
    8000577e:	0712                	slli	a4,a4,0x4
    80005780:	974a                	add	a4,a4,s2
    80005782:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    80005786:	e731                	bnez	a4,800057d2 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005788:	20078793          	addi	a5,a5,512
    8000578c:	0792                	slli	a5,a5,0x4
    8000578e:	97ca                	add	a5,a5,s2
    80005790:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80005792:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005796:	ffffc097          	auipc	ra,0xffffc
    8000579a:	0fa080e7          	jalr	250(ra) # 80001890 <wakeup>

    disk.used_idx += 1;
    8000579e:	0204d783          	lhu	a5,32(s1)
    800057a2:	2785                	addiw	a5,a5,1
    800057a4:	17c2                	slli	a5,a5,0x30
    800057a6:	93c1                	srli	a5,a5,0x30
    800057a8:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    800057ac:	6898                	ld	a4,16(s1)
    800057ae:	00275703          	lhu	a4,2(a4)
    800057b2:	faf71be3          	bne	a4,a5,80005768 <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    800057b6:	00238517          	auipc	a0,0x238
    800057ba:	97250513          	addi	a0,a0,-1678 # 8023d128 <disk+0x2128>
    800057be:	00001097          	auipc	ra,0x1
    800057c2:	b2e080e7          	jalr	-1234(ra) # 800062ec <release>
}
    800057c6:	60e2                	ld	ra,24(sp)
    800057c8:	6442                	ld	s0,16(sp)
    800057ca:	64a2                	ld	s1,8(sp)
    800057cc:	6902                	ld	s2,0(sp)
    800057ce:	6105                	addi	sp,sp,32
    800057d0:	8082                	ret
      panic("virtio_disk_intr status");
    800057d2:	00003517          	auipc	a0,0x3
    800057d6:	fd650513          	addi	a0,a0,-42 # 800087a8 <syscalls+0x3b0>
    800057da:	00000097          	auipc	ra,0x0
    800057de:	526080e7          	jalr	1318(ra) # 80005d00 <panic>

00000000800057e2 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    800057e2:	1141                	addi	sp,sp,-16
    800057e4:	e422                	sd	s0,8(sp)
    800057e6:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800057e8:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    800057ec:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800057f0:	0037979b          	slliw	a5,a5,0x3
    800057f4:	02004737          	lui	a4,0x2004
    800057f8:	97ba                	add	a5,a5,a4
    800057fa:	0200c737          	lui	a4,0x200c
    800057fe:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005802:	000f4637          	lui	a2,0xf4
    80005806:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000580a:	9732                	add	a4,a4,a2
    8000580c:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    8000580e:	00259693          	slli	a3,a1,0x2
    80005812:	96ae                	add	a3,a3,a1
    80005814:	068e                	slli	a3,a3,0x3
    80005816:	00238717          	auipc	a4,0x238
    8000581a:	7ea70713          	addi	a4,a4,2026 # 8023e000 <timer_scratch>
    8000581e:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005820:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005822:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005824:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80005828:	00000797          	auipc	a5,0x0
    8000582c:	9c878793          	addi	a5,a5,-1592 # 800051f0 <timervec>
    80005830:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005834:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005838:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    8000583c:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005840:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005844:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005848:	30479073          	csrw	mie,a5
}
    8000584c:	6422                	ld	s0,8(sp)
    8000584e:	0141                	addi	sp,sp,16
    80005850:	8082                	ret

0000000080005852 <start>:
{
    80005852:	1141                	addi	sp,sp,-16
    80005854:	e406                	sd	ra,8(sp)
    80005856:	e022                	sd	s0,0(sp)
    80005858:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000585a:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    8000585e:	7779                	lui	a4,0xffffe
    80005860:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fdb85bf>
    80005864:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005866:	6705                	lui	a4,0x1
    80005868:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    8000586c:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    8000586e:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005872:	ffffb797          	auipc	a5,0xffffb
    80005876:	bf078793          	addi	a5,a5,-1040 # 80000462 <main>
    8000587a:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    8000587e:	4781                	li	a5,0
    80005880:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005884:	67c1                	lui	a5,0x10
    80005886:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005888:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    8000588c:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005890:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005894:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005898:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    8000589c:	57fd                	li	a5,-1
    8000589e:	83a9                	srli	a5,a5,0xa
    800058a0:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800058a4:	47bd                	li	a5,15
    800058a6:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800058aa:	00000097          	auipc	ra,0x0
    800058ae:	f38080e7          	jalr	-200(ra) # 800057e2 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800058b2:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800058b6:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    800058b8:	823e                	mv	tp,a5
  asm volatile("mret");
    800058ba:	30200073          	mret
}
    800058be:	60a2                	ld	ra,8(sp)
    800058c0:	6402                	ld	s0,0(sp)
    800058c2:	0141                	addi	sp,sp,16
    800058c4:	8082                	ret

00000000800058c6 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    800058c6:	715d                	addi	sp,sp,-80
    800058c8:	e486                	sd	ra,72(sp)
    800058ca:	e0a2                	sd	s0,64(sp)
    800058cc:	fc26                	sd	s1,56(sp)
    800058ce:	f84a                	sd	s2,48(sp)
    800058d0:	f44e                	sd	s3,40(sp)
    800058d2:	f052                	sd	s4,32(sp)
    800058d4:	ec56                	sd	s5,24(sp)
    800058d6:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    800058d8:	04c05763          	blez	a2,80005926 <consolewrite+0x60>
    800058dc:	8a2a                	mv	s4,a0
    800058de:	84ae                	mv	s1,a1
    800058e0:	89b2                	mv	s3,a2
    800058e2:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800058e4:	5afd                	li	s5,-1
    800058e6:	4685                	li	a3,1
    800058e8:	8626                	mv	a2,s1
    800058ea:	85d2                	mv	a1,s4
    800058ec:	fbf40513          	addi	a0,s0,-65
    800058f0:	ffffc097          	auipc	ra,0xffffc
    800058f4:	20e080e7          	jalr	526(ra) # 80001afe <either_copyin>
    800058f8:	01550d63          	beq	a0,s5,80005912 <consolewrite+0x4c>
      break;
    uartputc(c);
    800058fc:	fbf44503          	lbu	a0,-65(s0)
    80005900:	00000097          	auipc	ra,0x0
    80005904:	77e080e7          	jalr	1918(ra) # 8000607e <uartputc>
  for(i = 0; i < n; i++){
    80005908:	2905                	addiw	s2,s2,1
    8000590a:	0485                	addi	s1,s1,1
    8000590c:	fd299de3          	bne	s3,s2,800058e6 <consolewrite+0x20>
    80005910:	894e                	mv	s2,s3
  }

  return i;
}
    80005912:	854a                	mv	a0,s2
    80005914:	60a6                	ld	ra,72(sp)
    80005916:	6406                	ld	s0,64(sp)
    80005918:	74e2                	ld	s1,56(sp)
    8000591a:	7942                	ld	s2,48(sp)
    8000591c:	79a2                	ld	s3,40(sp)
    8000591e:	7a02                	ld	s4,32(sp)
    80005920:	6ae2                	ld	s5,24(sp)
    80005922:	6161                	addi	sp,sp,80
    80005924:	8082                	ret
  for(i = 0; i < n; i++){
    80005926:	4901                	li	s2,0
    80005928:	b7ed                	j	80005912 <consolewrite+0x4c>

000000008000592a <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    8000592a:	7159                	addi	sp,sp,-112
    8000592c:	f486                	sd	ra,104(sp)
    8000592e:	f0a2                	sd	s0,96(sp)
    80005930:	eca6                	sd	s1,88(sp)
    80005932:	e8ca                	sd	s2,80(sp)
    80005934:	e4ce                	sd	s3,72(sp)
    80005936:	e0d2                	sd	s4,64(sp)
    80005938:	fc56                	sd	s5,56(sp)
    8000593a:	f85a                	sd	s6,48(sp)
    8000593c:	f45e                	sd	s7,40(sp)
    8000593e:	f062                	sd	s8,32(sp)
    80005940:	ec66                	sd	s9,24(sp)
    80005942:	e86a                	sd	s10,16(sp)
    80005944:	1880                	addi	s0,sp,112
    80005946:	8aaa                	mv	s5,a0
    80005948:	8a2e                	mv	s4,a1
    8000594a:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    8000594c:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80005950:	00240517          	auipc	a0,0x240
    80005954:	7f050513          	addi	a0,a0,2032 # 80246140 <cons>
    80005958:	00001097          	auipc	ra,0x1
    8000595c:	8e0080e7          	jalr	-1824(ra) # 80006238 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005960:	00240497          	auipc	s1,0x240
    80005964:	7e048493          	addi	s1,s1,2016 # 80246140 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005968:	00241917          	auipc	s2,0x241
    8000596c:	87090913          	addi	s2,s2,-1936 # 802461d8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    80005970:	4b91                	li	s7,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005972:	5c7d                	li	s8,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80005974:	4ca9                	li	s9,10
  while(n > 0){
    80005976:	07305863          	blez	s3,800059e6 <consoleread+0xbc>
    while(cons.r == cons.w){
    8000597a:	0984a783          	lw	a5,152(s1)
    8000597e:	09c4a703          	lw	a4,156(s1)
    80005982:	02f71463          	bne	a4,a5,800059aa <consoleread+0x80>
      if(myproc()->killed){
    80005986:	ffffb097          	auipc	ra,0xffffb
    8000598a:	6ba080e7          	jalr	1722(ra) # 80001040 <myproc>
    8000598e:	551c                	lw	a5,40(a0)
    80005990:	e7b5                	bnez	a5,800059fc <consoleread+0xd2>
      sleep(&cons.r, &cons.lock);
    80005992:	85a6                	mv	a1,s1
    80005994:	854a                	mv	a0,s2
    80005996:	ffffc097          	auipc	ra,0xffffc
    8000599a:	d6e080e7          	jalr	-658(ra) # 80001704 <sleep>
    while(cons.r == cons.w){
    8000599e:	0984a783          	lw	a5,152(s1)
    800059a2:	09c4a703          	lw	a4,156(s1)
    800059a6:	fef700e3          	beq	a4,a5,80005986 <consoleread+0x5c>
    c = cons.buf[cons.r++ % INPUT_BUF];
    800059aa:	0017871b          	addiw	a4,a5,1
    800059ae:	08e4ac23          	sw	a4,152(s1)
    800059b2:	07f7f713          	andi	a4,a5,127
    800059b6:	9726                	add	a4,a4,s1
    800059b8:	01874703          	lbu	a4,24(a4)
    800059bc:	00070d1b          	sext.w	s10,a4
    if(c == C('D')){  // end-of-file
    800059c0:	077d0563          	beq	s10,s7,80005a2a <consoleread+0x100>
    cbuf = c;
    800059c4:	f8e40fa3          	sb	a4,-97(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800059c8:	4685                	li	a3,1
    800059ca:	f9f40613          	addi	a2,s0,-97
    800059ce:	85d2                	mv	a1,s4
    800059d0:	8556                	mv	a0,s5
    800059d2:	ffffc097          	auipc	ra,0xffffc
    800059d6:	0d6080e7          	jalr	214(ra) # 80001aa8 <either_copyout>
    800059da:	01850663          	beq	a0,s8,800059e6 <consoleread+0xbc>
    dst++;
    800059de:	0a05                	addi	s4,s4,1
    --n;
    800059e0:	39fd                	addiw	s3,s3,-1
    if(c == '\n'){
    800059e2:	f99d1ae3          	bne	s10,s9,80005976 <consoleread+0x4c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    800059e6:	00240517          	auipc	a0,0x240
    800059ea:	75a50513          	addi	a0,a0,1882 # 80246140 <cons>
    800059ee:	00001097          	auipc	ra,0x1
    800059f2:	8fe080e7          	jalr	-1794(ra) # 800062ec <release>

  return target - n;
    800059f6:	413b053b          	subw	a0,s6,s3
    800059fa:	a811                	j	80005a0e <consoleread+0xe4>
        release(&cons.lock);
    800059fc:	00240517          	auipc	a0,0x240
    80005a00:	74450513          	addi	a0,a0,1860 # 80246140 <cons>
    80005a04:	00001097          	auipc	ra,0x1
    80005a08:	8e8080e7          	jalr	-1816(ra) # 800062ec <release>
        return -1;
    80005a0c:	557d                	li	a0,-1
}
    80005a0e:	70a6                	ld	ra,104(sp)
    80005a10:	7406                	ld	s0,96(sp)
    80005a12:	64e6                	ld	s1,88(sp)
    80005a14:	6946                	ld	s2,80(sp)
    80005a16:	69a6                	ld	s3,72(sp)
    80005a18:	6a06                	ld	s4,64(sp)
    80005a1a:	7ae2                	ld	s5,56(sp)
    80005a1c:	7b42                	ld	s6,48(sp)
    80005a1e:	7ba2                	ld	s7,40(sp)
    80005a20:	7c02                	ld	s8,32(sp)
    80005a22:	6ce2                	ld	s9,24(sp)
    80005a24:	6d42                	ld	s10,16(sp)
    80005a26:	6165                	addi	sp,sp,112
    80005a28:	8082                	ret
      if(n < target){
    80005a2a:	0009871b          	sext.w	a4,s3
    80005a2e:	fb677ce3          	bgeu	a4,s6,800059e6 <consoleread+0xbc>
        cons.r--;
    80005a32:	00240717          	auipc	a4,0x240
    80005a36:	7af72323          	sw	a5,1958(a4) # 802461d8 <cons+0x98>
    80005a3a:	b775                	j	800059e6 <consoleread+0xbc>

0000000080005a3c <consputc>:
{
    80005a3c:	1141                	addi	sp,sp,-16
    80005a3e:	e406                	sd	ra,8(sp)
    80005a40:	e022                	sd	s0,0(sp)
    80005a42:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005a44:	10000793          	li	a5,256
    80005a48:	00f50a63          	beq	a0,a5,80005a5c <consputc+0x20>
    uartputc_sync(c);
    80005a4c:	00000097          	auipc	ra,0x0
    80005a50:	560080e7          	jalr	1376(ra) # 80005fac <uartputc_sync>
}
    80005a54:	60a2                	ld	ra,8(sp)
    80005a56:	6402                	ld	s0,0(sp)
    80005a58:	0141                	addi	sp,sp,16
    80005a5a:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005a5c:	4521                	li	a0,8
    80005a5e:	00000097          	auipc	ra,0x0
    80005a62:	54e080e7          	jalr	1358(ra) # 80005fac <uartputc_sync>
    80005a66:	02000513          	li	a0,32
    80005a6a:	00000097          	auipc	ra,0x0
    80005a6e:	542080e7          	jalr	1346(ra) # 80005fac <uartputc_sync>
    80005a72:	4521                	li	a0,8
    80005a74:	00000097          	auipc	ra,0x0
    80005a78:	538080e7          	jalr	1336(ra) # 80005fac <uartputc_sync>
    80005a7c:	bfe1                	j	80005a54 <consputc+0x18>

0000000080005a7e <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005a7e:	1101                	addi	sp,sp,-32
    80005a80:	ec06                	sd	ra,24(sp)
    80005a82:	e822                	sd	s0,16(sp)
    80005a84:	e426                	sd	s1,8(sp)
    80005a86:	e04a                	sd	s2,0(sp)
    80005a88:	1000                	addi	s0,sp,32
    80005a8a:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005a8c:	00240517          	auipc	a0,0x240
    80005a90:	6b450513          	addi	a0,a0,1716 # 80246140 <cons>
    80005a94:	00000097          	auipc	ra,0x0
    80005a98:	7a4080e7          	jalr	1956(ra) # 80006238 <acquire>

  switch(c){
    80005a9c:	47d5                	li	a5,21
    80005a9e:	0af48663          	beq	s1,a5,80005b4a <consoleintr+0xcc>
    80005aa2:	0297ca63          	blt	a5,s1,80005ad6 <consoleintr+0x58>
    80005aa6:	47a1                	li	a5,8
    80005aa8:	0ef48763          	beq	s1,a5,80005b96 <consoleintr+0x118>
    80005aac:	47c1                	li	a5,16
    80005aae:	10f49a63          	bne	s1,a5,80005bc2 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80005ab2:	ffffc097          	auipc	ra,0xffffc
    80005ab6:	0a2080e7          	jalr	162(ra) # 80001b54 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005aba:	00240517          	auipc	a0,0x240
    80005abe:	68650513          	addi	a0,a0,1670 # 80246140 <cons>
    80005ac2:	00001097          	auipc	ra,0x1
    80005ac6:	82a080e7          	jalr	-2006(ra) # 800062ec <release>
}
    80005aca:	60e2                	ld	ra,24(sp)
    80005acc:	6442                	ld	s0,16(sp)
    80005ace:	64a2                	ld	s1,8(sp)
    80005ad0:	6902                	ld	s2,0(sp)
    80005ad2:	6105                	addi	sp,sp,32
    80005ad4:	8082                	ret
  switch(c){
    80005ad6:	07f00793          	li	a5,127
    80005ada:	0af48e63          	beq	s1,a5,80005b96 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005ade:	00240717          	auipc	a4,0x240
    80005ae2:	66270713          	addi	a4,a4,1634 # 80246140 <cons>
    80005ae6:	0a072783          	lw	a5,160(a4)
    80005aea:	09872703          	lw	a4,152(a4)
    80005aee:	9f99                	subw	a5,a5,a4
    80005af0:	07f00713          	li	a4,127
    80005af4:	fcf763e3          	bltu	a4,a5,80005aba <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80005af8:	47b5                	li	a5,13
    80005afa:	0cf48763          	beq	s1,a5,80005bc8 <consoleintr+0x14a>
      consputc(c);
    80005afe:	8526                	mv	a0,s1
    80005b00:	00000097          	auipc	ra,0x0
    80005b04:	f3c080e7          	jalr	-196(ra) # 80005a3c <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005b08:	00240797          	auipc	a5,0x240
    80005b0c:	63878793          	addi	a5,a5,1592 # 80246140 <cons>
    80005b10:	0a07a703          	lw	a4,160(a5)
    80005b14:	0017069b          	addiw	a3,a4,1
    80005b18:	0006861b          	sext.w	a2,a3
    80005b1c:	0ad7a023          	sw	a3,160(a5)
    80005b20:	07f77713          	andi	a4,a4,127
    80005b24:	97ba                	add	a5,a5,a4
    80005b26:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80005b2a:	47a9                	li	a5,10
    80005b2c:	0cf48563          	beq	s1,a5,80005bf6 <consoleintr+0x178>
    80005b30:	4791                	li	a5,4
    80005b32:	0cf48263          	beq	s1,a5,80005bf6 <consoleintr+0x178>
    80005b36:	00240797          	auipc	a5,0x240
    80005b3a:	6a27a783          	lw	a5,1698(a5) # 802461d8 <cons+0x98>
    80005b3e:	0807879b          	addiw	a5,a5,128
    80005b42:	f6f61ce3          	bne	a2,a5,80005aba <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005b46:	863e                	mv	a2,a5
    80005b48:	a07d                	j	80005bf6 <consoleintr+0x178>
    while(cons.e != cons.w &&
    80005b4a:	00240717          	auipc	a4,0x240
    80005b4e:	5f670713          	addi	a4,a4,1526 # 80246140 <cons>
    80005b52:	0a072783          	lw	a5,160(a4)
    80005b56:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005b5a:	00240497          	auipc	s1,0x240
    80005b5e:	5e648493          	addi	s1,s1,1510 # 80246140 <cons>
    while(cons.e != cons.w &&
    80005b62:	4929                	li	s2,10
    80005b64:	f4f70be3          	beq	a4,a5,80005aba <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005b68:	37fd                	addiw	a5,a5,-1
    80005b6a:	07f7f713          	andi	a4,a5,127
    80005b6e:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005b70:	01874703          	lbu	a4,24(a4)
    80005b74:	f52703e3          	beq	a4,s2,80005aba <consoleintr+0x3c>
      cons.e--;
    80005b78:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005b7c:	10000513          	li	a0,256
    80005b80:	00000097          	auipc	ra,0x0
    80005b84:	ebc080e7          	jalr	-324(ra) # 80005a3c <consputc>
    while(cons.e != cons.w &&
    80005b88:	0a04a783          	lw	a5,160(s1)
    80005b8c:	09c4a703          	lw	a4,156(s1)
    80005b90:	fcf71ce3          	bne	a4,a5,80005b68 <consoleintr+0xea>
    80005b94:	b71d                	j	80005aba <consoleintr+0x3c>
    if(cons.e != cons.w){
    80005b96:	00240717          	auipc	a4,0x240
    80005b9a:	5aa70713          	addi	a4,a4,1450 # 80246140 <cons>
    80005b9e:	0a072783          	lw	a5,160(a4)
    80005ba2:	09c72703          	lw	a4,156(a4)
    80005ba6:	f0f70ae3          	beq	a4,a5,80005aba <consoleintr+0x3c>
      cons.e--;
    80005baa:	37fd                	addiw	a5,a5,-1
    80005bac:	00240717          	auipc	a4,0x240
    80005bb0:	62f72a23          	sw	a5,1588(a4) # 802461e0 <cons+0xa0>
      consputc(BACKSPACE);
    80005bb4:	10000513          	li	a0,256
    80005bb8:	00000097          	auipc	ra,0x0
    80005bbc:	e84080e7          	jalr	-380(ra) # 80005a3c <consputc>
    80005bc0:	bded                	j	80005aba <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005bc2:	ee048ce3          	beqz	s1,80005aba <consoleintr+0x3c>
    80005bc6:	bf21                	j	80005ade <consoleintr+0x60>
      consputc(c);
    80005bc8:	4529                	li	a0,10
    80005bca:	00000097          	auipc	ra,0x0
    80005bce:	e72080e7          	jalr	-398(ra) # 80005a3c <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005bd2:	00240797          	auipc	a5,0x240
    80005bd6:	56e78793          	addi	a5,a5,1390 # 80246140 <cons>
    80005bda:	0a07a703          	lw	a4,160(a5)
    80005bde:	0017069b          	addiw	a3,a4,1
    80005be2:	0006861b          	sext.w	a2,a3
    80005be6:	0ad7a023          	sw	a3,160(a5)
    80005bea:	07f77713          	andi	a4,a4,127
    80005bee:	97ba                	add	a5,a5,a4
    80005bf0:	4729                	li	a4,10
    80005bf2:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005bf6:	00240797          	auipc	a5,0x240
    80005bfa:	5ec7a323          	sw	a2,1510(a5) # 802461dc <cons+0x9c>
        wakeup(&cons.r);
    80005bfe:	00240517          	auipc	a0,0x240
    80005c02:	5da50513          	addi	a0,a0,1498 # 802461d8 <cons+0x98>
    80005c06:	ffffc097          	auipc	ra,0xffffc
    80005c0a:	c8a080e7          	jalr	-886(ra) # 80001890 <wakeup>
    80005c0e:	b575                	j	80005aba <consoleintr+0x3c>

0000000080005c10 <consoleinit>:

void
consoleinit(void)
{
    80005c10:	1141                	addi	sp,sp,-16
    80005c12:	e406                	sd	ra,8(sp)
    80005c14:	e022                	sd	s0,0(sp)
    80005c16:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005c18:	00003597          	auipc	a1,0x3
    80005c1c:	ba858593          	addi	a1,a1,-1112 # 800087c0 <syscalls+0x3c8>
    80005c20:	00240517          	auipc	a0,0x240
    80005c24:	52050513          	addi	a0,a0,1312 # 80246140 <cons>
    80005c28:	00000097          	auipc	ra,0x0
    80005c2c:	580080e7          	jalr	1408(ra) # 800061a8 <initlock>

  uartinit();
    80005c30:	00000097          	auipc	ra,0x0
    80005c34:	32c080e7          	jalr	812(ra) # 80005f5c <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005c38:	00233797          	auipc	a5,0x233
    80005c3c:	49078793          	addi	a5,a5,1168 # 802390c8 <devsw>
    80005c40:	00000717          	auipc	a4,0x0
    80005c44:	cea70713          	addi	a4,a4,-790 # 8000592a <consoleread>
    80005c48:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005c4a:	00000717          	auipc	a4,0x0
    80005c4e:	c7c70713          	addi	a4,a4,-900 # 800058c6 <consolewrite>
    80005c52:	ef98                	sd	a4,24(a5)
}
    80005c54:	60a2                	ld	ra,8(sp)
    80005c56:	6402                	ld	s0,0(sp)
    80005c58:	0141                	addi	sp,sp,16
    80005c5a:	8082                	ret

0000000080005c5c <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005c5c:	7179                	addi	sp,sp,-48
    80005c5e:	f406                	sd	ra,40(sp)
    80005c60:	f022                	sd	s0,32(sp)
    80005c62:	ec26                	sd	s1,24(sp)
    80005c64:	e84a                	sd	s2,16(sp)
    80005c66:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005c68:	c219                	beqz	a2,80005c6e <printint+0x12>
    80005c6a:	08054763          	bltz	a0,80005cf8 <printint+0x9c>
    x = -xx;
  else
    x = xx;
    80005c6e:	2501                	sext.w	a0,a0
    80005c70:	4881                	li	a7,0
    80005c72:	fd040693          	addi	a3,s0,-48

  i = 0;
    80005c76:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005c78:	2581                	sext.w	a1,a1
    80005c7a:	00003617          	auipc	a2,0x3
    80005c7e:	b7660613          	addi	a2,a2,-1162 # 800087f0 <digits>
    80005c82:	883a                	mv	a6,a4
    80005c84:	2705                	addiw	a4,a4,1
    80005c86:	02b577bb          	remuw	a5,a0,a1
    80005c8a:	1782                	slli	a5,a5,0x20
    80005c8c:	9381                	srli	a5,a5,0x20
    80005c8e:	97b2                	add	a5,a5,a2
    80005c90:	0007c783          	lbu	a5,0(a5)
    80005c94:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005c98:	0005079b          	sext.w	a5,a0
    80005c9c:	02b5553b          	divuw	a0,a0,a1
    80005ca0:	0685                	addi	a3,a3,1
    80005ca2:	feb7f0e3          	bgeu	a5,a1,80005c82 <printint+0x26>

  if(sign)
    80005ca6:	00088c63          	beqz	a7,80005cbe <printint+0x62>
    buf[i++] = '-';
    80005caa:	fe070793          	addi	a5,a4,-32
    80005cae:	00878733          	add	a4,a5,s0
    80005cb2:	02d00793          	li	a5,45
    80005cb6:	fef70823          	sb	a5,-16(a4)
    80005cba:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80005cbe:	02e05763          	blez	a4,80005cec <printint+0x90>
    80005cc2:	fd040793          	addi	a5,s0,-48
    80005cc6:	00e784b3          	add	s1,a5,a4
    80005cca:	fff78913          	addi	s2,a5,-1
    80005cce:	993a                	add	s2,s2,a4
    80005cd0:	377d                	addiw	a4,a4,-1
    80005cd2:	1702                	slli	a4,a4,0x20
    80005cd4:	9301                	srli	a4,a4,0x20
    80005cd6:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005cda:	fff4c503          	lbu	a0,-1(s1)
    80005cde:	00000097          	auipc	ra,0x0
    80005ce2:	d5e080e7          	jalr	-674(ra) # 80005a3c <consputc>
  while(--i >= 0)
    80005ce6:	14fd                	addi	s1,s1,-1
    80005ce8:	ff2499e3          	bne	s1,s2,80005cda <printint+0x7e>
}
    80005cec:	70a2                	ld	ra,40(sp)
    80005cee:	7402                	ld	s0,32(sp)
    80005cf0:	64e2                	ld	s1,24(sp)
    80005cf2:	6942                	ld	s2,16(sp)
    80005cf4:	6145                	addi	sp,sp,48
    80005cf6:	8082                	ret
    x = -xx;
    80005cf8:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005cfc:	4885                	li	a7,1
    x = -xx;
    80005cfe:	bf95                	j	80005c72 <printint+0x16>

0000000080005d00 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005d00:	1101                	addi	sp,sp,-32
    80005d02:	ec06                	sd	ra,24(sp)
    80005d04:	e822                	sd	s0,16(sp)
    80005d06:	e426                	sd	s1,8(sp)
    80005d08:	1000                	addi	s0,sp,32
    80005d0a:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005d0c:	00240797          	auipc	a5,0x240
    80005d10:	4e07aa23          	sw	zero,1268(a5) # 80246200 <pr+0x18>
  printf("panic: ");
    80005d14:	00003517          	auipc	a0,0x3
    80005d18:	ab450513          	addi	a0,a0,-1356 # 800087c8 <syscalls+0x3d0>
    80005d1c:	00000097          	auipc	ra,0x0
    80005d20:	02e080e7          	jalr	46(ra) # 80005d4a <printf>
  printf(s);
    80005d24:	8526                	mv	a0,s1
    80005d26:	00000097          	auipc	ra,0x0
    80005d2a:	024080e7          	jalr	36(ra) # 80005d4a <printf>
  printf("\n");
    80005d2e:	00002517          	auipc	a0,0x2
    80005d32:	34a50513          	addi	a0,a0,842 # 80008078 <etext+0x78>
    80005d36:	00000097          	auipc	ra,0x0
    80005d3a:	014080e7          	jalr	20(ra) # 80005d4a <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005d3e:	4785                	li	a5,1
    80005d40:	00003717          	auipc	a4,0x3
    80005d44:	2cf72e23          	sw	a5,732(a4) # 8000901c <panicked>
  for(;;)
    80005d48:	a001                	j	80005d48 <panic+0x48>

0000000080005d4a <printf>:
{
    80005d4a:	7131                	addi	sp,sp,-192
    80005d4c:	fc86                	sd	ra,120(sp)
    80005d4e:	f8a2                	sd	s0,112(sp)
    80005d50:	f4a6                	sd	s1,104(sp)
    80005d52:	f0ca                	sd	s2,96(sp)
    80005d54:	ecce                	sd	s3,88(sp)
    80005d56:	e8d2                	sd	s4,80(sp)
    80005d58:	e4d6                	sd	s5,72(sp)
    80005d5a:	e0da                	sd	s6,64(sp)
    80005d5c:	fc5e                	sd	s7,56(sp)
    80005d5e:	f862                	sd	s8,48(sp)
    80005d60:	f466                	sd	s9,40(sp)
    80005d62:	f06a                	sd	s10,32(sp)
    80005d64:	ec6e                	sd	s11,24(sp)
    80005d66:	0100                	addi	s0,sp,128
    80005d68:	8a2a                	mv	s4,a0
    80005d6a:	e40c                	sd	a1,8(s0)
    80005d6c:	e810                	sd	a2,16(s0)
    80005d6e:	ec14                	sd	a3,24(s0)
    80005d70:	f018                	sd	a4,32(s0)
    80005d72:	f41c                	sd	a5,40(s0)
    80005d74:	03043823          	sd	a6,48(s0)
    80005d78:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005d7c:	00240d97          	auipc	s11,0x240
    80005d80:	484dad83          	lw	s11,1156(s11) # 80246200 <pr+0x18>
  if(locking)
    80005d84:	020d9b63          	bnez	s11,80005dba <printf+0x70>
  if (fmt == 0)
    80005d88:	040a0263          	beqz	s4,80005dcc <printf+0x82>
  va_start(ap, fmt);
    80005d8c:	00840793          	addi	a5,s0,8
    80005d90:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005d94:	000a4503          	lbu	a0,0(s4)
    80005d98:	14050f63          	beqz	a0,80005ef6 <printf+0x1ac>
    80005d9c:	4981                	li	s3,0
    if(c != '%'){
    80005d9e:	02500a93          	li	s5,37
    switch(c){
    80005da2:	07000b93          	li	s7,112
  consputc('x');
    80005da6:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005da8:	00003b17          	auipc	s6,0x3
    80005dac:	a48b0b13          	addi	s6,s6,-1464 # 800087f0 <digits>
    switch(c){
    80005db0:	07300c93          	li	s9,115
    80005db4:	06400c13          	li	s8,100
    80005db8:	a82d                	j	80005df2 <printf+0xa8>
    acquire(&pr.lock);
    80005dba:	00240517          	auipc	a0,0x240
    80005dbe:	42e50513          	addi	a0,a0,1070 # 802461e8 <pr>
    80005dc2:	00000097          	auipc	ra,0x0
    80005dc6:	476080e7          	jalr	1142(ra) # 80006238 <acquire>
    80005dca:	bf7d                	j	80005d88 <printf+0x3e>
    panic("null fmt");
    80005dcc:	00003517          	auipc	a0,0x3
    80005dd0:	a0c50513          	addi	a0,a0,-1524 # 800087d8 <syscalls+0x3e0>
    80005dd4:	00000097          	auipc	ra,0x0
    80005dd8:	f2c080e7          	jalr	-212(ra) # 80005d00 <panic>
      consputc(c);
    80005ddc:	00000097          	auipc	ra,0x0
    80005de0:	c60080e7          	jalr	-928(ra) # 80005a3c <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005de4:	2985                	addiw	s3,s3,1
    80005de6:	013a07b3          	add	a5,s4,s3
    80005dea:	0007c503          	lbu	a0,0(a5)
    80005dee:	10050463          	beqz	a0,80005ef6 <printf+0x1ac>
    if(c != '%'){
    80005df2:	ff5515e3          	bne	a0,s5,80005ddc <printf+0x92>
    c = fmt[++i] & 0xff;
    80005df6:	2985                	addiw	s3,s3,1
    80005df8:	013a07b3          	add	a5,s4,s3
    80005dfc:	0007c783          	lbu	a5,0(a5)
    80005e00:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80005e04:	cbed                	beqz	a5,80005ef6 <printf+0x1ac>
    switch(c){
    80005e06:	05778a63          	beq	a5,s7,80005e5a <printf+0x110>
    80005e0a:	02fbf663          	bgeu	s7,a5,80005e36 <printf+0xec>
    80005e0e:	09978863          	beq	a5,s9,80005e9e <printf+0x154>
    80005e12:	07800713          	li	a4,120
    80005e16:	0ce79563          	bne	a5,a4,80005ee0 <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80005e1a:	f8843783          	ld	a5,-120(s0)
    80005e1e:	00878713          	addi	a4,a5,8
    80005e22:	f8e43423          	sd	a4,-120(s0)
    80005e26:	4605                	li	a2,1
    80005e28:	85ea                	mv	a1,s10
    80005e2a:	4388                	lw	a0,0(a5)
    80005e2c:	00000097          	auipc	ra,0x0
    80005e30:	e30080e7          	jalr	-464(ra) # 80005c5c <printint>
      break;
    80005e34:	bf45                	j	80005de4 <printf+0x9a>
    switch(c){
    80005e36:	09578f63          	beq	a5,s5,80005ed4 <printf+0x18a>
    80005e3a:	0b879363          	bne	a5,s8,80005ee0 <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    80005e3e:	f8843783          	ld	a5,-120(s0)
    80005e42:	00878713          	addi	a4,a5,8
    80005e46:	f8e43423          	sd	a4,-120(s0)
    80005e4a:	4605                	li	a2,1
    80005e4c:	45a9                	li	a1,10
    80005e4e:	4388                	lw	a0,0(a5)
    80005e50:	00000097          	auipc	ra,0x0
    80005e54:	e0c080e7          	jalr	-500(ra) # 80005c5c <printint>
      break;
    80005e58:	b771                	j	80005de4 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80005e5a:	f8843783          	ld	a5,-120(s0)
    80005e5e:	00878713          	addi	a4,a5,8
    80005e62:	f8e43423          	sd	a4,-120(s0)
    80005e66:	0007b903          	ld	s2,0(a5)
  consputc('0');
    80005e6a:	03000513          	li	a0,48
    80005e6e:	00000097          	auipc	ra,0x0
    80005e72:	bce080e7          	jalr	-1074(ra) # 80005a3c <consputc>
  consputc('x');
    80005e76:	07800513          	li	a0,120
    80005e7a:	00000097          	auipc	ra,0x0
    80005e7e:	bc2080e7          	jalr	-1086(ra) # 80005a3c <consputc>
    80005e82:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005e84:	03c95793          	srli	a5,s2,0x3c
    80005e88:	97da                	add	a5,a5,s6
    80005e8a:	0007c503          	lbu	a0,0(a5)
    80005e8e:	00000097          	auipc	ra,0x0
    80005e92:	bae080e7          	jalr	-1106(ra) # 80005a3c <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005e96:	0912                	slli	s2,s2,0x4
    80005e98:	34fd                	addiw	s1,s1,-1
    80005e9a:	f4ed                	bnez	s1,80005e84 <printf+0x13a>
    80005e9c:	b7a1                	j	80005de4 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80005e9e:	f8843783          	ld	a5,-120(s0)
    80005ea2:	00878713          	addi	a4,a5,8
    80005ea6:	f8e43423          	sd	a4,-120(s0)
    80005eaa:	6384                	ld	s1,0(a5)
    80005eac:	cc89                	beqz	s1,80005ec6 <printf+0x17c>
      for(; *s; s++)
    80005eae:	0004c503          	lbu	a0,0(s1)
    80005eb2:	d90d                	beqz	a0,80005de4 <printf+0x9a>
        consputc(*s);
    80005eb4:	00000097          	auipc	ra,0x0
    80005eb8:	b88080e7          	jalr	-1144(ra) # 80005a3c <consputc>
      for(; *s; s++)
    80005ebc:	0485                	addi	s1,s1,1
    80005ebe:	0004c503          	lbu	a0,0(s1)
    80005ec2:	f96d                	bnez	a0,80005eb4 <printf+0x16a>
    80005ec4:	b705                	j	80005de4 <printf+0x9a>
        s = "(null)";
    80005ec6:	00003497          	auipc	s1,0x3
    80005eca:	90a48493          	addi	s1,s1,-1782 # 800087d0 <syscalls+0x3d8>
      for(; *s; s++)
    80005ece:	02800513          	li	a0,40
    80005ed2:	b7cd                	j	80005eb4 <printf+0x16a>
      consputc('%');
    80005ed4:	8556                	mv	a0,s5
    80005ed6:	00000097          	auipc	ra,0x0
    80005eda:	b66080e7          	jalr	-1178(ra) # 80005a3c <consputc>
      break;
    80005ede:	b719                	j	80005de4 <printf+0x9a>
      consputc('%');
    80005ee0:	8556                	mv	a0,s5
    80005ee2:	00000097          	auipc	ra,0x0
    80005ee6:	b5a080e7          	jalr	-1190(ra) # 80005a3c <consputc>
      consputc(c);
    80005eea:	8526                	mv	a0,s1
    80005eec:	00000097          	auipc	ra,0x0
    80005ef0:	b50080e7          	jalr	-1200(ra) # 80005a3c <consputc>
      break;
    80005ef4:	bdc5                	j	80005de4 <printf+0x9a>
  if(locking)
    80005ef6:	020d9163          	bnez	s11,80005f18 <printf+0x1ce>
}
    80005efa:	70e6                	ld	ra,120(sp)
    80005efc:	7446                	ld	s0,112(sp)
    80005efe:	74a6                	ld	s1,104(sp)
    80005f00:	7906                	ld	s2,96(sp)
    80005f02:	69e6                	ld	s3,88(sp)
    80005f04:	6a46                	ld	s4,80(sp)
    80005f06:	6aa6                	ld	s5,72(sp)
    80005f08:	6b06                	ld	s6,64(sp)
    80005f0a:	7be2                	ld	s7,56(sp)
    80005f0c:	7c42                	ld	s8,48(sp)
    80005f0e:	7ca2                	ld	s9,40(sp)
    80005f10:	7d02                	ld	s10,32(sp)
    80005f12:	6de2                	ld	s11,24(sp)
    80005f14:	6129                	addi	sp,sp,192
    80005f16:	8082                	ret
    release(&pr.lock);
    80005f18:	00240517          	auipc	a0,0x240
    80005f1c:	2d050513          	addi	a0,a0,720 # 802461e8 <pr>
    80005f20:	00000097          	auipc	ra,0x0
    80005f24:	3cc080e7          	jalr	972(ra) # 800062ec <release>
}
    80005f28:	bfc9                	j	80005efa <printf+0x1b0>

0000000080005f2a <printfinit>:
    ;
}

void
printfinit(void)
{
    80005f2a:	1101                	addi	sp,sp,-32
    80005f2c:	ec06                	sd	ra,24(sp)
    80005f2e:	e822                	sd	s0,16(sp)
    80005f30:	e426                	sd	s1,8(sp)
    80005f32:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80005f34:	00240497          	auipc	s1,0x240
    80005f38:	2b448493          	addi	s1,s1,692 # 802461e8 <pr>
    80005f3c:	00003597          	auipc	a1,0x3
    80005f40:	8ac58593          	addi	a1,a1,-1876 # 800087e8 <syscalls+0x3f0>
    80005f44:	8526                	mv	a0,s1
    80005f46:	00000097          	auipc	ra,0x0
    80005f4a:	262080e7          	jalr	610(ra) # 800061a8 <initlock>
  pr.locking = 1;
    80005f4e:	4785                	li	a5,1
    80005f50:	cc9c                	sw	a5,24(s1)
}
    80005f52:	60e2                	ld	ra,24(sp)
    80005f54:	6442                	ld	s0,16(sp)
    80005f56:	64a2                	ld	s1,8(sp)
    80005f58:	6105                	addi	sp,sp,32
    80005f5a:	8082                	ret

0000000080005f5c <uartinit>:

void uartstart();

void
uartinit(void)
{
    80005f5c:	1141                	addi	sp,sp,-16
    80005f5e:	e406                	sd	ra,8(sp)
    80005f60:	e022                	sd	s0,0(sp)
    80005f62:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80005f64:	100007b7          	lui	a5,0x10000
    80005f68:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80005f6c:	f8000713          	li	a4,-128
    80005f70:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80005f74:	470d                	li	a4,3
    80005f76:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80005f7a:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80005f7e:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80005f82:	469d                	li	a3,7
    80005f84:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80005f88:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    80005f8c:	00003597          	auipc	a1,0x3
    80005f90:	87c58593          	addi	a1,a1,-1924 # 80008808 <digits+0x18>
    80005f94:	00240517          	auipc	a0,0x240
    80005f98:	27450513          	addi	a0,a0,628 # 80246208 <uart_tx_lock>
    80005f9c:	00000097          	auipc	ra,0x0
    80005fa0:	20c080e7          	jalr	524(ra) # 800061a8 <initlock>
}
    80005fa4:	60a2                	ld	ra,8(sp)
    80005fa6:	6402                	ld	s0,0(sp)
    80005fa8:	0141                	addi	sp,sp,16
    80005faa:	8082                	ret

0000000080005fac <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80005fac:	1101                	addi	sp,sp,-32
    80005fae:	ec06                	sd	ra,24(sp)
    80005fb0:	e822                	sd	s0,16(sp)
    80005fb2:	e426                	sd	s1,8(sp)
    80005fb4:	1000                	addi	s0,sp,32
    80005fb6:	84aa                	mv	s1,a0
  push_off();
    80005fb8:	00000097          	auipc	ra,0x0
    80005fbc:	234080e7          	jalr	564(ra) # 800061ec <push_off>

  if(panicked){
    80005fc0:	00003797          	auipc	a5,0x3
    80005fc4:	05c7a783          	lw	a5,92(a5) # 8000901c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005fc8:	10000737          	lui	a4,0x10000
  if(panicked){
    80005fcc:	c391                	beqz	a5,80005fd0 <uartputc_sync+0x24>
    for(;;)
    80005fce:	a001                	j	80005fce <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005fd0:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80005fd4:	0207f793          	andi	a5,a5,32
    80005fd8:	dfe5                	beqz	a5,80005fd0 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80005fda:	0ff4f513          	zext.b	a0,s1
    80005fde:	100007b7          	lui	a5,0x10000
    80005fe2:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80005fe6:	00000097          	auipc	ra,0x0
    80005fea:	2a6080e7          	jalr	678(ra) # 8000628c <pop_off>
}
    80005fee:	60e2                	ld	ra,24(sp)
    80005ff0:	6442                	ld	s0,16(sp)
    80005ff2:	64a2                	ld	s1,8(sp)
    80005ff4:	6105                	addi	sp,sp,32
    80005ff6:	8082                	ret

0000000080005ff8 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80005ff8:	00003797          	auipc	a5,0x3
    80005ffc:	0287b783          	ld	a5,40(a5) # 80009020 <uart_tx_r>
    80006000:	00003717          	auipc	a4,0x3
    80006004:	02873703          	ld	a4,40(a4) # 80009028 <uart_tx_w>
    80006008:	06f70a63          	beq	a4,a5,8000607c <uartstart+0x84>
{
    8000600c:	7139                	addi	sp,sp,-64
    8000600e:	fc06                	sd	ra,56(sp)
    80006010:	f822                	sd	s0,48(sp)
    80006012:	f426                	sd	s1,40(sp)
    80006014:	f04a                	sd	s2,32(sp)
    80006016:	ec4e                	sd	s3,24(sp)
    80006018:	e852                	sd	s4,16(sp)
    8000601a:	e456                	sd	s5,8(sp)
    8000601c:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000601e:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006022:	00240a17          	auipc	s4,0x240
    80006026:	1e6a0a13          	addi	s4,s4,486 # 80246208 <uart_tx_lock>
    uart_tx_r += 1;
    8000602a:	00003497          	auipc	s1,0x3
    8000602e:	ff648493          	addi	s1,s1,-10 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80006032:	00003997          	auipc	s3,0x3
    80006036:	ff698993          	addi	s3,s3,-10 # 80009028 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000603a:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    8000603e:	02077713          	andi	a4,a4,32
    80006042:	c705                	beqz	a4,8000606a <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006044:	01f7f713          	andi	a4,a5,31
    80006048:	9752                	add	a4,a4,s4
    8000604a:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    8000604e:	0785                	addi	a5,a5,1
    80006050:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80006052:	8526                	mv	a0,s1
    80006054:	ffffc097          	auipc	ra,0xffffc
    80006058:	83c080e7          	jalr	-1988(ra) # 80001890 <wakeup>
    
    WriteReg(THR, c);
    8000605c:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80006060:	609c                	ld	a5,0(s1)
    80006062:	0009b703          	ld	a4,0(s3)
    80006066:	fcf71ae3          	bne	a4,a5,8000603a <uartstart+0x42>
  }
}
    8000606a:	70e2                	ld	ra,56(sp)
    8000606c:	7442                	ld	s0,48(sp)
    8000606e:	74a2                	ld	s1,40(sp)
    80006070:	7902                	ld	s2,32(sp)
    80006072:	69e2                	ld	s3,24(sp)
    80006074:	6a42                	ld	s4,16(sp)
    80006076:	6aa2                	ld	s5,8(sp)
    80006078:	6121                	addi	sp,sp,64
    8000607a:	8082                	ret
    8000607c:	8082                	ret

000000008000607e <uartputc>:
{
    8000607e:	7179                	addi	sp,sp,-48
    80006080:	f406                	sd	ra,40(sp)
    80006082:	f022                	sd	s0,32(sp)
    80006084:	ec26                	sd	s1,24(sp)
    80006086:	e84a                	sd	s2,16(sp)
    80006088:	e44e                	sd	s3,8(sp)
    8000608a:	e052                	sd	s4,0(sp)
    8000608c:	1800                	addi	s0,sp,48
    8000608e:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80006090:	00240517          	auipc	a0,0x240
    80006094:	17850513          	addi	a0,a0,376 # 80246208 <uart_tx_lock>
    80006098:	00000097          	auipc	ra,0x0
    8000609c:	1a0080e7          	jalr	416(ra) # 80006238 <acquire>
  if(panicked){
    800060a0:	00003797          	auipc	a5,0x3
    800060a4:	f7c7a783          	lw	a5,-132(a5) # 8000901c <panicked>
    800060a8:	c391                	beqz	a5,800060ac <uartputc+0x2e>
    for(;;)
    800060aa:	a001                	j	800060aa <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800060ac:	00003717          	auipc	a4,0x3
    800060b0:	f7c73703          	ld	a4,-132(a4) # 80009028 <uart_tx_w>
    800060b4:	00003797          	auipc	a5,0x3
    800060b8:	f6c7b783          	ld	a5,-148(a5) # 80009020 <uart_tx_r>
    800060bc:	02078793          	addi	a5,a5,32
    800060c0:	02e79b63          	bne	a5,a4,800060f6 <uartputc+0x78>
      sleep(&uart_tx_r, &uart_tx_lock);
    800060c4:	00240997          	auipc	s3,0x240
    800060c8:	14498993          	addi	s3,s3,324 # 80246208 <uart_tx_lock>
    800060cc:	00003497          	auipc	s1,0x3
    800060d0:	f5448493          	addi	s1,s1,-172 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800060d4:	00003917          	auipc	s2,0x3
    800060d8:	f5490913          	addi	s2,s2,-172 # 80009028 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    800060dc:	85ce                	mv	a1,s3
    800060de:	8526                	mv	a0,s1
    800060e0:	ffffb097          	auipc	ra,0xffffb
    800060e4:	624080e7          	jalr	1572(ra) # 80001704 <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800060e8:	00093703          	ld	a4,0(s2)
    800060ec:	609c                	ld	a5,0(s1)
    800060ee:	02078793          	addi	a5,a5,32
    800060f2:	fee785e3          	beq	a5,a4,800060dc <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    800060f6:	00240497          	auipc	s1,0x240
    800060fa:	11248493          	addi	s1,s1,274 # 80246208 <uart_tx_lock>
    800060fe:	01f77793          	andi	a5,a4,31
    80006102:	97a6                	add	a5,a5,s1
    80006104:	01478c23          	sb	s4,24(a5)
      uart_tx_w += 1;
    80006108:	0705                	addi	a4,a4,1
    8000610a:	00003797          	auipc	a5,0x3
    8000610e:	f0e7bf23          	sd	a4,-226(a5) # 80009028 <uart_tx_w>
      uartstart();
    80006112:	00000097          	auipc	ra,0x0
    80006116:	ee6080e7          	jalr	-282(ra) # 80005ff8 <uartstart>
      release(&uart_tx_lock);
    8000611a:	8526                	mv	a0,s1
    8000611c:	00000097          	auipc	ra,0x0
    80006120:	1d0080e7          	jalr	464(ra) # 800062ec <release>
}
    80006124:	70a2                	ld	ra,40(sp)
    80006126:	7402                	ld	s0,32(sp)
    80006128:	64e2                	ld	s1,24(sp)
    8000612a:	6942                	ld	s2,16(sp)
    8000612c:	69a2                	ld	s3,8(sp)
    8000612e:	6a02                	ld	s4,0(sp)
    80006130:	6145                	addi	sp,sp,48
    80006132:	8082                	ret

0000000080006134 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006134:	1141                	addi	sp,sp,-16
    80006136:	e422                	sd	s0,8(sp)
    80006138:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    8000613a:	100007b7          	lui	a5,0x10000
    8000613e:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006142:	8b85                	andi	a5,a5,1
    80006144:	cb81                	beqz	a5,80006154 <uartgetc+0x20>
    // input data is ready.
    return ReadReg(RHR);
    80006146:	100007b7          	lui	a5,0x10000
    8000614a:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    8000614e:	6422                	ld	s0,8(sp)
    80006150:	0141                	addi	sp,sp,16
    80006152:	8082                	ret
    return -1;
    80006154:	557d                	li	a0,-1
    80006156:	bfe5                	j	8000614e <uartgetc+0x1a>

0000000080006158 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80006158:	1101                	addi	sp,sp,-32
    8000615a:	ec06                	sd	ra,24(sp)
    8000615c:	e822                	sd	s0,16(sp)
    8000615e:	e426                	sd	s1,8(sp)
    80006160:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80006162:	54fd                	li	s1,-1
    80006164:	a029                	j	8000616e <uartintr+0x16>
      break;
    consoleintr(c);
    80006166:	00000097          	auipc	ra,0x0
    8000616a:	918080e7          	jalr	-1768(ra) # 80005a7e <consoleintr>
    int c = uartgetc();
    8000616e:	00000097          	auipc	ra,0x0
    80006172:	fc6080e7          	jalr	-58(ra) # 80006134 <uartgetc>
    if(c == -1)
    80006176:	fe9518e3          	bne	a0,s1,80006166 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    8000617a:	00240497          	auipc	s1,0x240
    8000617e:	08e48493          	addi	s1,s1,142 # 80246208 <uart_tx_lock>
    80006182:	8526                	mv	a0,s1
    80006184:	00000097          	auipc	ra,0x0
    80006188:	0b4080e7          	jalr	180(ra) # 80006238 <acquire>
  uartstart();
    8000618c:	00000097          	auipc	ra,0x0
    80006190:	e6c080e7          	jalr	-404(ra) # 80005ff8 <uartstart>
  release(&uart_tx_lock);
    80006194:	8526                	mv	a0,s1
    80006196:	00000097          	auipc	ra,0x0
    8000619a:	156080e7          	jalr	342(ra) # 800062ec <release>
}
    8000619e:	60e2                	ld	ra,24(sp)
    800061a0:	6442                	ld	s0,16(sp)
    800061a2:	64a2                	ld	s1,8(sp)
    800061a4:	6105                	addi	sp,sp,32
    800061a6:	8082                	ret

00000000800061a8 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    800061a8:	1141                	addi	sp,sp,-16
    800061aa:	e422                	sd	s0,8(sp)
    800061ac:	0800                	addi	s0,sp,16
  lk->name = name;
    800061ae:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    800061b0:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800061b4:	00053823          	sd	zero,16(a0)
}
    800061b8:	6422                	ld	s0,8(sp)
    800061ba:	0141                	addi	sp,sp,16
    800061bc:	8082                	ret

00000000800061be <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800061be:	411c                	lw	a5,0(a0)
    800061c0:	e399                	bnez	a5,800061c6 <holding+0x8>
    800061c2:	4501                	li	a0,0
  return r;
}
    800061c4:	8082                	ret
{
    800061c6:	1101                	addi	sp,sp,-32
    800061c8:	ec06                	sd	ra,24(sp)
    800061ca:	e822                	sd	s0,16(sp)
    800061cc:	e426                	sd	s1,8(sp)
    800061ce:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800061d0:	6904                	ld	s1,16(a0)
    800061d2:	ffffb097          	auipc	ra,0xffffb
    800061d6:	e52080e7          	jalr	-430(ra) # 80001024 <mycpu>
    800061da:	40a48533          	sub	a0,s1,a0
    800061de:	00153513          	seqz	a0,a0
}
    800061e2:	60e2                	ld	ra,24(sp)
    800061e4:	6442                	ld	s0,16(sp)
    800061e6:	64a2                	ld	s1,8(sp)
    800061e8:	6105                	addi	sp,sp,32
    800061ea:	8082                	ret

00000000800061ec <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800061ec:	1101                	addi	sp,sp,-32
    800061ee:	ec06                	sd	ra,24(sp)
    800061f0:	e822                	sd	s0,16(sp)
    800061f2:	e426                	sd	s1,8(sp)
    800061f4:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800061f6:	100024f3          	csrr	s1,sstatus
    800061fa:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800061fe:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006200:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80006204:	ffffb097          	auipc	ra,0xffffb
    80006208:	e20080e7          	jalr	-480(ra) # 80001024 <mycpu>
    8000620c:	5d3c                	lw	a5,120(a0)
    8000620e:	cf89                	beqz	a5,80006228 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80006210:	ffffb097          	auipc	ra,0xffffb
    80006214:	e14080e7          	jalr	-492(ra) # 80001024 <mycpu>
    80006218:	5d3c                	lw	a5,120(a0)
    8000621a:	2785                	addiw	a5,a5,1
    8000621c:	dd3c                	sw	a5,120(a0)
}
    8000621e:	60e2                	ld	ra,24(sp)
    80006220:	6442                	ld	s0,16(sp)
    80006222:	64a2                	ld	s1,8(sp)
    80006224:	6105                	addi	sp,sp,32
    80006226:	8082                	ret
    mycpu()->intena = old;
    80006228:	ffffb097          	auipc	ra,0xffffb
    8000622c:	dfc080e7          	jalr	-516(ra) # 80001024 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006230:	8085                	srli	s1,s1,0x1
    80006232:	8885                	andi	s1,s1,1
    80006234:	dd64                	sw	s1,124(a0)
    80006236:	bfe9                	j	80006210 <push_off+0x24>

0000000080006238 <acquire>:
{
    80006238:	1101                	addi	sp,sp,-32
    8000623a:	ec06                	sd	ra,24(sp)
    8000623c:	e822                	sd	s0,16(sp)
    8000623e:	e426                	sd	s1,8(sp)
    80006240:	1000                	addi	s0,sp,32
    80006242:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80006244:	00000097          	auipc	ra,0x0
    80006248:	fa8080e7          	jalr	-88(ra) # 800061ec <push_off>
  if(holding(lk))
    8000624c:	8526                	mv	a0,s1
    8000624e:	00000097          	auipc	ra,0x0
    80006252:	f70080e7          	jalr	-144(ra) # 800061be <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006256:	4705                	li	a4,1
  if(holding(lk))
    80006258:	e115                	bnez	a0,8000627c <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000625a:	87ba                	mv	a5,a4
    8000625c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006260:	2781                	sext.w	a5,a5
    80006262:	ffe5                	bnez	a5,8000625a <acquire+0x22>
  __sync_synchronize();
    80006264:	0ff0000f          	fence
  lk->cpu = mycpu();
    80006268:	ffffb097          	auipc	ra,0xffffb
    8000626c:	dbc080e7          	jalr	-580(ra) # 80001024 <mycpu>
    80006270:	e888                	sd	a0,16(s1)
}
    80006272:	60e2                	ld	ra,24(sp)
    80006274:	6442                	ld	s0,16(sp)
    80006276:	64a2                	ld	s1,8(sp)
    80006278:	6105                	addi	sp,sp,32
    8000627a:	8082                	ret
    panic("acquire");
    8000627c:	00002517          	auipc	a0,0x2
    80006280:	59450513          	addi	a0,a0,1428 # 80008810 <digits+0x20>
    80006284:	00000097          	auipc	ra,0x0
    80006288:	a7c080e7          	jalr	-1412(ra) # 80005d00 <panic>

000000008000628c <pop_off>:

void
pop_off(void)
{
    8000628c:	1141                	addi	sp,sp,-16
    8000628e:	e406                	sd	ra,8(sp)
    80006290:	e022                	sd	s0,0(sp)
    80006292:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80006294:	ffffb097          	auipc	ra,0xffffb
    80006298:	d90080e7          	jalr	-624(ra) # 80001024 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000629c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800062a0:	8b89                	andi	a5,a5,2
  if(intr_get())
    800062a2:	e78d                	bnez	a5,800062cc <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    800062a4:	5d3c                	lw	a5,120(a0)
    800062a6:	02f05b63          	blez	a5,800062dc <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    800062aa:	37fd                	addiw	a5,a5,-1
    800062ac:	0007871b          	sext.w	a4,a5
    800062b0:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    800062b2:	eb09                	bnez	a4,800062c4 <pop_off+0x38>
    800062b4:	5d7c                	lw	a5,124(a0)
    800062b6:	c799                	beqz	a5,800062c4 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800062b8:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800062bc:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800062c0:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800062c4:	60a2                	ld	ra,8(sp)
    800062c6:	6402                	ld	s0,0(sp)
    800062c8:	0141                	addi	sp,sp,16
    800062ca:	8082                	ret
    panic("pop_off - interruptible");
    800062cc:	00002517          	auipc	a0,0x2
    800062d0:	54c50513          	addi	a0,a0,1356 # 80008818 <digits+0x28>
    800062d4:	00000097          	auipc	ra,0x0
    800062d8:	a2c080e7          	jalr	-1492(ra) # 80005d00 <panic>
    panic("pop_off");
    800062dc:	00002517          	auipc	a0,0x2
    800062e0:	55450513          	addi	a0,a0,1364 # 80008830 <digits+0x40>
    800062e4:	00000097          	auipc	ra,0x0
    800062e8:	a1c080e7          	jalr	-1508(ra) # 80005d00 <panic>

00000000800062ec <release>:
{
    800062ec:	1101                	addi	sp,sp,-32
    800062ee:	ec06                	sd	ra,24(sp)
    800062f0:	e822                	sd	s0,16(sp)
    800062f2:	e426                	sd	s1,8(sp)
    800062f4:	1000                	addi	s0,sp,32
    800062f6:	84aa                	mv	s1,a0
  if(!holding(lk))
    800062f8:	00000097          	auipc	ra,0x0
    800062fc:	ec6080e7          	jalr	-314(ra) # 800061be <holding>
    80006300:	c115                	beqz	a0,80006324 <release+0x38>
  lk->cpu = 0;
    80006302:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80006306:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    8000630a:	0f50000f          	fence	iorw,ow
    8000630e:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80006312:	00000097          	auipc	ra,0x0
    80006316:	f7a080e7          	jalr	-134(ra) # 8000628c <pop_off>
}
    8000631a:	60e2                	ld	ra,24(sp)
    8000631c:	6442                	ld	s0,16(sp)
    8000631e:	64a2                	ld	s1,8(sp)
    80006320:	6105                	addi	sp,sp,32
    80006322:	8082                	ret
    panic("release");
    80006324:	00002517          	auipc	a0,0x2
    80006328:	51450513          	addi	a0,a0,1300 # 80008838 <digits+0x48>
    8000632c:	00000097          	auipc	ra,0x0
    80006330:	9d4080e7          	jalr	-1580(ra) # 80005d00 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
