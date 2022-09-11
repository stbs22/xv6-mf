
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 54 11 80       	mov    $0x801154d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 24 2c 10 80       	mov    $0x80102c24,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	53                   	push   %ebx
80100038:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003b:	68 c0 68 10 80       	push   $0x801068c0
80100040:	68 20 a5 10 80       	push   $0x8010a520
80100045:	e8 3e 3e 00 00       	call   80103e88 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004a:	c7 05 6c ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec6c
80100051:	ec 10 80 
  bcache.head.next = &bcache.head;
80100054:	c7 05 70 ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec70
8010005b:	ec 10 80 
8010005e:	83 c4 10             	add    $0x10,%esp
80100061:	b8 1c ec 10 80       	mov    $0x8010ec1c,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100066:	bb 54 a5 10 80       	mov    $0x8010a554,%ebx
8010006b:	eb 05                	jmp    80100072 <binit+0x3e>
8010006d:	8d 76 00             	lea    0x0(%esi),%esi
80100070:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100072:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
80100075:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
8010007c:	83 ec 08             	sub    $0x8,%esp
8010007f:	68 c7 68 10 80       	push   $0x801068c7
80100084:	8d 43 0c             	lea    0xc(%ebx),%eax
80100087:	50                   	push   %eax
80100088:	e8 eb 3c 00 00       	call   80103d78 <initsleeplock>
    bcache.head.next->prev = b;
8010008d:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
80100092:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100095:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009b:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a1:	89 d8                	mov    %ebx,%eax
801000a3:	83 c4 10             	add    $0x10,%esp
801000a6:	81 fb c0 e9 10 80    	cmp    $0x8010e9c0,%ebx
801000ac:	75 c2                	jne    80100070 <binit+0x3c>
  }
}
801000ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000b1:	c9                   	leave  
801000b2:	c3                   	ret    
801000b3:	90                   	nop

801000b4 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000b4:	55                   	push   %ebp
801000b5:	89 e5                	mov    %esp,%ebp
801000b7:	57                   	push   %edi
801000b8:	56                   	push   %esi
801000b9:	53                   	push   %ebx
801000ba:	83 ec 18             	sub    $0x18,%esp
801000bd:	8b 75 08             	mov    0x8(%ebp),%esi
801000c0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000c3:	68 20 a5 10 80       	push   $0x8010a520
801000c8:	e8 73 3f 00 00       	call   80104040 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000cd:	8b 1d 70 ec 10 80    	mov    0x8010ec70,%ebx
801000d3:	83 c4 10             	add    $0x10,%esp
801000d6:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
801000dc:	75 0d                	jne    801000eb <bread+0x37>
801000de:	eb 1c                	jmp    801000fc <bread+0x48>
801000e0:	8b 5b 54             	mov    0x54(%ebx),%ebx
801000e3:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
801000e9:	74 11                	je     801000fc <bread+0x48>
    if(b->dev == dev && b->blockno == blockno){
801000eb:	3b 73 04             	cmp    0x4(%ebx),%esi
801000ee:	75 f0                	jne    801000e0 <bread+0x2c>
801000f0:	3b 7b 08             	cmp    0x8(%ebx),%edi
801000f3:	75 eb                	jne    801000e0 <bread+0x2c>
      b->refcnt++;
801000f5:	ff 43 4c             	incl   0x4c(%ebx)
      release(&bcache.lock);
801000f8:	eb 3c                	jmp    80100136 <bread+0x82>
801000fa:	66 90                	xchg   %ax,%ax
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801000fc:	8b 1d 6c ec 10 80    	mov    0x8010ec6c,%ebx
80100102:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
80100108:	75 0d                	jne    80100117 <bread+0x63>
8010010a:	eb 6a                	jmp    80100176 <bread+0xc2>
8010010c:	8b 5b 50             	mov    0x50(%ebx),%ebx
8010010f:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
80100115:	74 5f                	je     80100176 <bread+0xc2>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
80100117:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010011a:	85 c0                	test   %eax,%eax
8010011c:	75 ee                	jne    8010010c <bread+0x58>
8010011e:	f6 03 04             	testb  $0x4,(%ebx)
80100121:	75 e9                	jne    8010010c <bread+0x58>
      b->dev = dev;
80100123:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
80100126:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
80100129:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
8010012f:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100136:	83 ec 0c             	sub    $0xc,%esp
80100139:	68 20 a5 10 80       	push   $0x8010a520
8010013e:	e8 9d 3e 00 00       	call   80103fe0 <release>
      acquiresleep(&b->lock);
80100143:	8d 43 0c             	lea    0xc(%ebx),%eax
80100146:	89 04 24             	mov    %eax,(%esp)
80100149:	e8 5e 3c 00 00       	call   80103dac <acquiresleep>
      return b;
8010014e:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100151:	f6 03 02             	testb  $0x2,(%ebx)
80100154:	74 0a                	je     80100160 <bread+0xac>
    iderw(b);
  }
  return b;
}
80100156:	89 d8                	mov    %ebx,%eax
80100158:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010015b:	5b                   	pop    %ebx
8010015c:	5e                   	pop    %esi
8010015d:	5f                   	pop    %edi
8010015e:	5d                   	pop    %ebp
8010015f:	c3                   	ret    
    iderw(b);
80100160:	83 ec 0c             	sub    $0xc,%esp
80100163:	53                   	push   %ebx
80100164:	e8 a7 1e 00 00       	call   80102010 <iderw>
80100169:	83 c4 10             	add    $0x10,%esp
}
8010016c:	89 d8                	mov    %ebx,%eax
8010016e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100171:	5b                   	pop    %ebx
80100172:	5e                   	pop    %esi
80100173:	5f                   	pop    %edi
80100174:	5d                   	pop    %ebp
80100175:	c3                   	ret    
  panic("bget: no buffers");
80100176:	83 ec 0c             	sub    $0xc,%esp
80100179:	68 ce 68 10 80       	push   $0x801068ce
8010017e:	e8 b5 01 00 00       	call   80100338 <panic>
80100183:	90                   	nop

80100184 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100184:	55                   	push   %ebp
80100185:	89 e5                	mov    %esp,%ebp
80100187:	53                   	push   %ebx
80100188:	83 ec 10             	sub    $0x10,%esp
8010018b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
8010018e:	8d 43 0c             	lea    0xc(%ebx),%eax
80100191:	50                   	push   %eax
80100192:	e8 a5 3c 00 00       	call   80103e3c <holdingsleep>
80100197:	83 c4 10             	add    $0x10,%esp
8010019a:	85 c0                	test   %eax,%eax
8010019c:	74 0f                	je     801001ad <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
8010019e:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001a1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001a7:	c9                   	leave  
  iderw(b);
801001a8:	e9 63 1e 00 00       	jmp    80102010 <iderw>
    panic("bwrite");
801001ad:	83 ec 0c             	sub    $0xc,%esp
801001b0:	68 df 68 10 80       	push   $0x801068df
801001b5:	e8 7e 01 00 00       	call   80100338 <panic>
801001ba:	66 90                	xchg   %ax,%ax

801001bc <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001bc:	55                   	push   %ebp
801001bd:	89 e5                	mov    %esp,%ebp
801001bf:	56                   	push   %esi
801001c0:	53                   	push   %ebx
801001c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001c4:	8d 73 0c             	lea    0xc(%ebx),%esi
801001c7:	83 ec 0c             	sub    $0xc,%esp
801001ca:	56                   	push   %esi
801001cb:	e8 6c 3c 00 00       	call   80103e3c <holdingsleep>
801001d0:	83 c4 10             	add    $0x10,%esp
801001d3:	85 c0                	test   %eax,%eax
801001d5:	74 64                	je     8010023b <brelse+0x7f>
    panic("brelse");

  releasesleep(&b->lock);
801001d7:	83 ec 0c             	sub    $0xc,%esp
801001da:	56                   	push   %esi
801001db:	e8 20 3c 00 00       	call   80103e00 <releasesleep>

  acquire(&bcache.lock);
801001e0:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801001e7:	e8 54 3e 00 00       	call   80104040 <acquire>
  b->refcnt--;
801001ec:	8b 43 4c             	mov    0x4c(%ebx),%eax
801001ef:	48                   	dec    %eax
801001f0:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
801001f3:	83 c4 10             	add    $0x10,%esp
801001f6:	85 c0                	test   %eax,%eax
801001f8:	75 2f                	jne    80100229 <brelse+0x6d>
    // no one is waiting for it.
    b->next->prev = b->prev;
801001fa:	8b 43 54             	mov    0x54(%ebx),%eax
801001fd:	8b 53 50             	mov    0x50(%ebx),%edx
80100200:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100203:	8b 43 50             	mov    0x50(%ebx),%eax
80100206:	8b 53 54             	mov    0x54(%ebx),%edx
80100209:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010020c:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
80100211:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
80100214:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    bcache.head.next->prev = b;
8010021b:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
80100220:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100223:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  }
  
  release(&bcache.lock);
80100229:	c7 45 08 20 a5 10 80 	movl   $0x8010a520,0x8(%ebp)
}
80100230:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100233:	5b                   	pop    %ebx
80100234:	5e                   	pop    %esi
80100235:	5d                   	pop    %ebp
  release(&bcache.lock);
80100236:	e9 a5 3d 00 00       	jmp    80103fe0 <release>
    panic("brelse");
8010023b:	83 ec 0c             	sub    $0xc,%esp
8010023e:	68 e6 68 10 80       	push   $0x801068e6
80100243:	e8 f0 00 00 00       	call   80100338 <panic>

80100248 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100248:	55                   	push   %ebp
80100249:	89 e5                	mov    %esp,%ebp
8010024b:	57                   	push   %edi
8010024c:	56                   	push   %esi
8010024d:	53                   	push   %ebx
8010024e:	83 ec 18             	sub    $0x18,%esp
80100251:	8b 7d 08             	mov    0x8(%ebp),%edi
80100254:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint target;
  int c;

  iunlock(ip);
80100257:	57                   	push   %edi
80100258:	e8 2b 14 00 00       	call   80101688 <iunlock>
  target = n;
8010025d:	89 de                	mov    %ebx,%esi
  acquire(&cons.lock);
8010025f:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
80100266:	e8 d5 3d 00 00       	call   80104040 <acquire>
  while(n > 0){
8010026b:	83 c4 10             	add    $0x10,%esp
8010026e:	85 db                	test   %ebx,%ebx
80100270:	0f 8e 93 00 00 00    	jle    80100309 <consoleread+0xc1>
    while(input.r == input.w){
80100276:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
8010027b:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100281:	74 27                	je     801002aa <consoleread+0x62>
80100283:	eb 57                	jmp    801002dc <consoleread+0x94>
80100285:	8d 76 00             	lea    0x0(%esi),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100288:	83 ec 08             	sub    $0x8,%esp
8010028b:	68 20 ef 10 80       	push   $0x8010ef20
80100290:	68 00 ef 10 80       	push   $0x8010ef00
80100295:	e8 62 38 00 00       	call   80103afc <sleep>
    while(input.r == input.w){
8010029a:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
8010029f:	83 c4 10             	add    $0x10,%esp
801002a2:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801002a8:	75 32                	jne    801002dc <consoleread+0x94>
      if(myproc()->killed){
801002aa:	e8 fd 31 00 00       	call   801034ac <myproc>
801002af:	8b 40 24             	mov    0x24(%eax),%eax
801002b2:	85 c0                	test   %eax,%eax
801002b4:	74 d2                	je     80100288 <consoleread+0x40>
        release(&cons.lock);
801002b6:	83 ec 0c             	sub    $0xc,%esp
801002b9:	68 20 ef 10 80       	push   $0x8010ef20
801002be:	e8 1d 3d 00 00       	call   80103fe0 <release>
        ilock(ip);
801002c3:	89 3c 24             	mov    %edi,(%esp)
801002c6:	e8 f5 12 00 00       	call   801015c0 <ilock>
        return -1;
801002cb:	83 c4 10             	add    $0x10,%esp
801002ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002d6:	5b                   	pop    %ebx
801002d7:	5e                   	pop    %esi
801002d8:	5f                   	pop    %edi
801002d9:	5d                   	pop    %ebp
801002da:	c3                   	ret    
801002db:	90                   	nop
    c = input.buf[input.r++ % INPUT_BUF];
801002dc:	8d 50 01             	lea    0x1(%eax),%edx
801002df:	89 15 00 ef 10 80    	mov    %edx,0x8010ef00
801002e5:	89 c2                	mov    %eax,%edx
801002e7:	83 e2 7f             	and    $0x7f,%edx
801002ea:	0f be 8a 80 ee 10 80 	movsbl -0x7fef1180(%edx),%ecx
    if(c == C('D')){  // EOF
801002f1:	80 f9 04             	cmp    $0x4,%cl
801002f4:	74 37                	je     8010032d <consoleread+0xe5>
    *dst++ = c;
801002f6:	ff 45 0c             	incl   0xc(%ebp)
801002f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801002fc:	88 48 ff             	mov    %cl,-0x1(%eax)
    --n;
801002ff:	4b                   	dec    %ebx
    if(c == '\n')
80100300:	83 f9 0a             	cmp    $0xa,%ecx
80100303:	0f 85 65 ff ff ff    	jne    8010026e <consoleread+0x26>
  release(&cons.lock);
80100309:	83 ec 0c             	sub    $0xc,%esp
8010030c:	68 20 ef 10 80       	push   $0x8010ef20
80100311:	e8 ca 3c 00 00       	call   80103fe0 <release>
  ilock(ip);
80100316:	89 3c 24             	mov    %edi,(%esp)
80100319:	e8 a2 12 00 00       	call   801015c0 <ilock>
  return target - n;
8010031e:	89 f0                	mov    %esi,%eax
80100320:	29 d8                	sub    %ebx,%eax
80100322:	83 c4 10             	add    $0x10,%esp
}
80100325:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100328:	5b                   	pop    %ebx
80100329:	5e                   	pop    %esi
8010032a:	5f                   	pop    %edi
8010032b:	5d                   	pop    %ebp
8010032c:	c3                   	ret    
      if(n < target){
8010032d:	39 f3                	cmp    %esi,%ebx
8010032f:	73 d8                	jae    80100309 <consoleread+0xc1>
        input.r--;
80100331:	a3 00 ef 10 80       	mov    %eax,0x8010ef00
80100336:	eb d1                	jmp    80100309 <consoleread+0xc1>

80100338 <panic>:
{
80100338:	55                   	push   %ebp
80100339:	89 e5                	mov    %esp,%ebp
8010033b:	56                   	push   %esi
8010033c:	53                   	push   %ebx
8010033d:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100340:	fa                   	cli    
  cons.locking = 0;
80100341:	c7 05 54 ef 10 80 00 	movl   $0x0,0x8010ef54
80100348:	00 00 00 
  cprintf("lapicid %d: panic: ", lapicid());
8010034b:	e8 34 22 00 00       	call   80102584 <lapicid>
80100350:	83 ec 08             	sub    $0x8,%esp
80100353:	50                   	push   %eax
80100354:	68 ed 68 10 80       	push   $0x801068ed
80100359:	e8 be 02 00 00       	call   8010061c <cprintf>
  cprintf(s);
8010035e:	58                   	pop    %eax
8010035f:	ff 75 08             	push   0x8(%ebp)
80100362:	e8 b5 02 00 00       	call   8010061c <cprintf>
  cprintf("\n");
80100367:	c7 04 24 1b 72 10 80 	movl   $0x8010721b,(%esp)
8010036e:	e8 a9 02 00 00       	call   8010061c <cprintf>
  getcallerpcs(&s, pcs);
80100373:	5a                   	pop    %edx
80100374:	59                   	pop    %ecx
80100375:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100378:	53                   	push   %ebx
80100379:	8d 45 08             	lea    0x8(%ebp),%eax
8010037c:	50                   	push   %eax
8010037d:	e8 22 3b 00 00       	call   80103ea4 <getcallerpcs>
  for(i=0; i<10; i++)
80100382:	8d 75 f8             	lea    -0x8(%ebp),%esi
80100385:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100388:	83 ec 08             	sub    $0x8,%esp
8010038b:	ff 33                	push   (%ebx)
8010038d:	68 01 69 10 80       	push   $0x80106901
80100392:	e8 85 02 00 00       	call   8010061c <cprintf>
  for(i=0; i<10; i++)
80100397:	83 c3 04             	add    $0x4,%ebx
8010039a:	83 c4 10             	add    $0x10,%esp
8010039d:	39 f3                	cmp    %esi,%ebx
8010039f:	75 e7                	jne    80100388 <panic+0x50>
  panicked = 1; // freeze other CPU
801003a1:	c7 05 58 ef 10 80 01 	movl   $0x1,0x8010ef58
801003a8:	00 00 00 
  for(;;)
801003ab:	eb fe                	jmp    801003ab <panic+0x73>
801003ad:	8d 76 00             	lea    0x0(%esi),%esi

801003b0 <consputc.part.0>:
consputc(int c)
801003b0:	55                   	push   %ebp
801003b1:	89 e5                	mov    %esp,%ebp
801003b3:	57                   	push   %edi
801003b4:	56                   	push   %esi
801003b5:	53                   	push   %ebx
801003b6:	83 ec 1c             	sub    $0x1c,%esp
801003b9:	89 c6                	mov    %eax,%esi
  if(c == BACKSPACE){
801003bb:	3d 00 01 00 00       	cmp    $0x100,%eax
801003c0:	0f 84 ce 00 00 00    	je     80100494 <consputc.part.0+0xe4>
    uartputc(c);
801003c6:	83 ec 0c             	sub    $0xc,%esp
801003c9:	50                   	push   %eax
801003ca:	e8 05 51 00 00       	call   801054d4 <uartputc>
801003cf:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003d2:	bf d4 03 00 00       	mov    $0x3d4,%edi
801003d7:	b0 0e                	mov    $0xe,%al
801003d9:	89 fa                	mov    %edi,%edx
801003db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003dc:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801003e1:	89 ca                	mov    %ecx,%edx
801003e3:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
801003e4:	0f b6 d8             	movzbl %al,%ebx
801003e7:	c1 e3 08             	shl    $0x8,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003ea:	b0 0f                	mov    $0xf,%al
801003ec:	89 fa                	mov    %edi,%edx
801003ee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003ef:	89 ca                	mov    %ecx,%edx
801003f1:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
801003f2:	0f b6 c8             	movzbl %al,%ecx
801003f5:	09 d9                	or     %ebx,%ecx
  if(c == '\n')
801003f7:	83 fe 0a             	cmp    $0xa,%esi
801003fa:	0f 84 84 00 00 00    	je     80100484 <consputc.part.0+0xd4>
  else if(c == BACKSPACE){
80100400:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100406:	74 6c                	je     80100474 <consputc.part.0+0xc4>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100408:	8d 59 01             	lea    0x1(%ecx),%ebx
8010040b:	89 f0                	mov    %esi,%eax
8010040d:	0f b6 f0             	movzbl %al,%esi
80100410:	81 ce 00 07 00 00    	or     $0x700,%esi
80100416:	66 89 b4 09 00 80 0b 	mov    %si,-0x7ff48000(%ecx,%ecx,1)
8010041d:	80 
  if(pos < 0 || pos > 25*80)
8010041e:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100424:	0f 8f ee 00 00 00    	jg     80100518 <consputc.part.0+0x168>
  if((pos/80) >= 24){  // Scroll up.
8010042a:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100430:	0f 8f 8a 00 00 00    	jg     801004c0 <consputc.part.0+0x110>
  outb(CRTPORT+1, pos>>8);
80100436:	0f b6 c7             	movzbl %bh,%eax
80100439:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  outb(CRTPORT+1, pos);
8010043c:	89 de                	mov    %ebx,%esi
  crt[pos] = ' ' | 0x0700;
8010043e:	01 db                	add    %ebx,%ebx
80100440:	8d bb 00 80 0b 80    	lea    -0x7ff48000(%ebx),%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100446:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010044b:	b0 0e                	mov    $0xe,%al
8010044d:	89 da                	mov    %ebx,%edx
8010044f:	ee                   	out    %al,(%dx)
80100450:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100455:	8a 45 e4             	mov    -0x1c(%ebp),%al
80100458:	89 ca                	mov    %ecx,%edx
8010045a:	ee                   	out    %al,(%dx)
8010045b:	b0 0f                	mov    $0xf,%al
8010045d:	89 da                	mov    %ebx,%edx
8010045f:	ee                   	out    %al,(%dx)
80100460:	89 f0                	mov    %esi,%eax
80100462:	89 ca                	mov    %ecx,%edx
80100464:	ee                   	out    %al,(%dx)
80100465:	66 c7 07 20 07       	movw   $0x720,(%edi)
}
8010046a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010046d:	5b                   	pop    %ebx
8010046e:	5e                   	pop    %esi
8010046f:	5f                   	pop    %edi
80100470:	5d                   	pop    %ebp
80100471:	c3                   	ret    
80100472:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
80100474:	85 c9                	test   %ecx,%ecx
80100476:	0f 84 8c 00 00 00    	je     80100508 <consputc.part.0+0x158>
8010047c:	8d 59 ff             	lea    -0x1(%ecx),%ebx
8010047f:	eb 9d                	jmp    8010041e <consputc.part.0+0x6e>
80100481:	8d 76 00             	lea    0x0(%esi),%esi
    pos += 80 - pos%80;
80100484:	bb 50 00 00 00       	mov    $0x50,%ebx
80100489:	89 c8                	mov    %ecx,%eax
8010048b:	99                   	cltd   
8010048c:	f7 fb                	idiv   %ebx
8010048e:	29 d3                	sub    %edx,%ebx
80100490:	01 cb                	add    %ecx,%ebx
80100492:	eb 8a                	jmp    8010041e <consputc.part.0+0x6e>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100494:	83 ec 0c             	sub    $0xc,%esp
80100497:	6a 08                	push   $0x8
80100499:	e8 36 50 00 00       	call   801054d4 <uartputc>
8010049e:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004a5:	e8 2a 50 00 00       	call   801054d4 <uartputc>
801004aa:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004b1:	e8 1e 50 00 00       	call   801054d4 <uartputc>
801004b6:	83 c4 10             	add    $0x10,%esp
801004b9:	e9 14 ff ff ff       	jmp    801003d2 <consputc.part.0+0x22>
801004be:	66 90                	xchg   %ax,%ax
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004c0:	50                   	push   %eax
801004c1:	68 60 0e 00 00       	push   $0xe60
801004c6:	68 a0 80 0b 80       	push   $0x800b80a0
801004cb:	68 00 80 0b 80       	push   $0x800b8000
801004d0:	e8 97 3c 00 00       	call   8010416c <memmove>
    pos -= 80;
801004d5:	8d 73 b0             	lea    -0x50(%ebx),%esi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004d8:	8d 84 1b 60 ff ff ff 	lea    -0xa0(%ebx,%ebx,1),%eax
801004df:	8d b8 00 80 0b 80    	lea    -0x7ff48000(%eax),%edi
801004e5:	83 c4 0c             	add    $0xc,%esp
801004e8:	b8 80 07 00 00       	mov    $0x780,%eax
801004ed:	29 f0                	sub    %esi,%eax
801004ef:	01 c0                	add    %eax,%eax
801004f1:	50                   	push   %eax
801004f2:	6a 00                	push   $0x0
801004f4:	57                   	push   %edi
801004f5:	e8 ee 3b 00 00       	call   801040e8 <memset>
  outb(CRTPORT+1, pos);
801004fa:	83 c4 10             	add    $0x10,%esp
801004fd:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
80100501:	e9 40 ff ff ff       	jmp    80100446 <consputc.part.0+0x96>
80100506:	66 90                	xchg   %ax,%ax
80100508:	bf 00 80 0b 80       	mov    $0x800b8000,%edi
8010050d:	31 f6                	xor    %esi,%esi
8010050f:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
80100513:	e9 2e ff ff ff       	jmp    80100446 <consputc.part.0+0x96>
    panic("pos under/overflow");
80100518:	83 ec 0c             	sub    $0xc,%esp
8010051b:	68 05 69 10 80       	push   $0x80106905
80100520:	e8 13 fe ff ff       	call   80100338 <panic>
80100525:	8d 76 00             	lea    0x0(%esi),%esi

80100528 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100528:	55                   	push   %ebp
80100529:	89 e5                	mov    %esp,%ebp
8010052b:	57                   	push   %edi
8010052c:	56                   	push   %esi
8010052d:	53                   	push   %ebx
8010052e:	83 ec 18             	sub    $0x18,%esp
80100531:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;

  iunlock(ip);
80100534:	ff 75 08             	push   0x8(%ebp)
80100537:	e8 4c 11 00 00       	call   80101688 <iunlock>
  acquire(&cons.lock);
8010053c:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
80100543:	e8 f8 3a 00 00       	call   80104040 <acquire>
  for(i = 0; i < n; i++)
80100548:	83 c4 10             	add    $0x10,%esp
8010054b:	85 db                	test   %ebx,%ebx
8010054d:	7e 23                	jle    80100572 <consolewrite+0x4a>
8010054f:	8b 75 0c             	mov    0xc(%ebp),%esi
80100552:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
    consputc(buf[i] & 0xff);
80100555:	0f b6 06             	movzbl (%esi),%eax
  if(panicked){
80100558:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
8010055e:	85 d2                	test   %edx,%edx
80100560:	74 06                	je     80100568 <consolewrite+0x40>
  asm volatile("cli");
80100562:	fa                   	cli    
    for(;;)
80100563:	eb fe                	jmp    80100563 <consolewrite+0x3b>
80100565:	8d 76 00             	lea    0x0(%esi),%esi
80100568:	e8 43 fe ff ff       	call   801003b0 <consputc.part.0>
  for(i = 0; i < n; i++)
8010056d:	46                   	inc    %esi
8010056e:	39 f7                	cmp    %esi,%edi
80100570:	75 e3                	jne    80100555 <consolewrite+0x2d>
  release(&cons.lock);
80100572:	83 ec 0c             	sub    $0xc,%esp
80100575:	68 20 ef 10 80       	push   $0x8010ef20
8010057a:	e8 61 3a 00 00       	call   80103fe0 <release>
  ilock(ip);
8010057f:	58                   	pop    %eax
80100580:	ff 75 08             	push   0x8(%ebp)
80100583:	e8 38 10 00 00       	call   801015c0 <ilock>

  return n;
}
80100588:	89 d8                	mov    %ebx,%eax
8010058a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010058d:	5b                   	pop    %ebx
8010058e:	5e                   	pop    %esi
8010058f:	5f                   	pop    %edi
80100590:	5d                   	pop    %ebp
80100591:	c3                   	ret    
80100592:	66 90                	xchg   %ax,%ax

80100594 <printint>:
{
80100594:	55                   	push   %ebp
80100595:	89 e5                	mov    %esp,%ebp
80100597:	57                   	push   %edi
80100598:	56                   	push   %esi
80100599:	53                   	push   %ebx
8010059a:	83 ec 2c             	sub    $0x2c,%esp
8010059d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801005a0:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
801005a3:	85 c9                	test   %ecx,%ecx
801005a5:	74 04                	je     801005ab <printint+0x17>
801005a7:	85 c0                	test   %eax,%eax
801005a9:	78 63                	js     8010060e <printint+0x7a>
    x = xx;
801005ab:	89 c1                	mov    %eax,%ecx
801005ad:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  i = 0;
801005b4:	31 f6                	xor    %esi,%esi
801005b6:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
801005b8:	89 c8                	mov    %ecx,%eax
801005ba:	31 d2                	xor    %edx,%edx
801005bc:	f7 75 d4             	divl   -0x2c(%ebp)
801005bf:	89 f3                	mov    %esi,%ebx
801005c1:	8d 76 01             	lea    0x1(%esi),%esi
801005c4:	8a 92 30 69 10 80    	mov    -0x7fef96d0(%edx),%dl
801005ca:	88 54 1d d8          	mov    %dl,-0x28(%ebp,%ebx,1)
  }while((x /= base) != 0);
801005ce:	89 cf                	mov    %ecx,%edi
801005d0:	89 c1                	mov    %eax,%ecx
801005d2:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
801005d5:	73 e1                	jae    801005b8 <printint+0x24>
  if(sign)
801005d7:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801005da:	85 c9                	test   %ecx,%ecx
801005dc:	74 09                	je     801005e7 <printint+0x53>
    buf[i++] = '-';
801005de:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
801005e3:	89 f3                	mov    %esi,%ebx
    buf[i++] = '-';
801005e5:	b2 2d                	mov    $0x2d,%dl
  while(--i >= 0)
801005e7:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
801005eb:	0f be c2             	movsbl %dl,%eax
  if(panicked){
801005ee:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
801005f4:	85 d2                	test   %edx,%edx
801005f6:	74 04                	je     801005fc <printint+0x68>
801005f8:	fa                   	cli    
    for(;;)
801005f9:	eb fe                	jmp    801005f9 <printint+0x65>
801005fb:	90                   	nop
801005fc:	e8 af fd ff ff       	call   801003b0 <consputc.part.0>
  while(--i >= 0)
80100601:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100604:	39 c3                	cmp    %eax,%ebx
80100606:	74 0c                	je     80100614 <printint+0x80>
    consputc(buf[i]);
80100608:	0f be 03             	movsbl (%ebx),%eax
8010060b:	4b                   	dec    %ebx
8010060c:	eb e0                	jmp    801005ee <printint+0x5a>
    x = -xx;
8010060e:	f7 d8                	neg    %eax
80100610:	89 c1                	mov    %eax,%ecx
80100612:	eb a0                	jmp    801005b4 <printint+0x20>
}
80100614:	83 c4 2c             	add    $0x2c,%esp
80100617:	5b                   	pop    %ebx
80100618:	5e                   	pop    %esi
80100619:	5f                   	pop    %edi
8010061a:	5d                   	pop    %ebp
8010061b:	c3                   	ret    

8010061c <cprintf>:
{
8010061c:	55                   	push   %ebp
8010061d:	89 e5                	mov    %esp,%ebp
8010061f:	57                   	push   %edi
80100620:	56                   	push   %esi
80100621:	53                   	push   %ebx
80100622:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100625:	a1 54 ef 10 80       	mov    0x8010ef54,%eax
8010062a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
8010062d:	85 c0                	test   %eax,%eax
8010062f:	0f 85 17 01 00 00    	jne    8010074c <cprintf+0x130>
  if (fmt == 0)
80100635:	8b 75 08             	mov    0x8(%ebp),%esi
80100638:	85 f6                	test   %esi,%esi
8010063a:	0f 84 94 01 00 00    	je     801007d4 <cprintf+0x1b8>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100640:	0f b6 06             	movzbl (%esi),%eax
80100643:	85 c0                	test   %eax,%eax
80100645:	74 57                	je     8010069e <cprintf+0x82>
  argp = (uint*)(void*)(&fmt + 1);
80100647:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010064a:	31 db                	xor    %ebx,%ebx
    if(c != '%'){
8010064c:	83 f8 25             	cmp    $0x25,%eax
8010064f:	0f 85 bf 00 00 00    	jne    80100714 <cprintf+0xf8>
    c = fmt[++i] & 0xff;
80100655:	43                   	inc    %ebx
80100656:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
8010065a:	85 d2                	test   %edx,%edx
8010065c:	74 40                	je     8010069e <cprintf+0x82>
    switch(c){
8010065e:	83 fa 70             	cmp    $0x70,%edx
80100661:	0f 84 86 00 00 00    	je     801006ed <cprintf+0xd1>
80100667:	7f 4b                	jg     801006b4 <cprintf+0x98>
80100669:	83 fa 25             	cmp    $0x25,%edx
8010066c:	0f 84 b2 00 00 00    	je     80100724 <cprintf+0x108>
80100672:	83 fa 64             	cmp    $0x64,%edx
80100675:	0f 85 e6 00 00 00    	jne    80100761 <cprintf+0x145>
      printint(*argp++, 10, 1);
8010067b:	8d 47 04             	lea    0x4(%edi),%eax
8010067e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100681:	b9 01 00 00 00       	mov    $0x1,%ecx
80100686:	ba 0a 00 00 00       	mov    $0xa,%edx
8010068b:	8b 07                	mov    (%edi),%eax
8010068d:	e8 02 ff ff ff       	call   80100594 <printint>
80100692:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100695:	43                   	inc    %ebx
80100696:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
8010069a:	85 c0                	test   %eax,%eax
8010069c:	75 ae                	jne    8010064c <cprintf+0x30>
  if(locking)
8010069e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006a1:	85 c0                	test   %eax,%eax
801006a3:	0f 85 0e 01 00 00    	jne    801007b7 <cprintf+0x19b>
}
801006a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006ac:	5b                   	pop    %ebx
801006ad:	5e                   	pop    %esi
801006ae:	5f                   	pop    %edi
801006af:	5d                   	pop    %ebp
801006b0:	c3                   	ret    
801006b1:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801006b4:	83 fa 73             	cmp    $0x73,%edx
801006b7:	75 2f                	jne    801006e8 <cprintf+0xcc>
      if((s = (char*)*argp++) == 0)
801006b9:	8d 47 04             	lea    0x4(%edi),%eax
801006bc:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006bf:	8b 3f                	mov    (%edi),%edi
801006c1:	85 ff                	test   %edi,%edi
801006c3:	0f 84 d3 00 00 00    	je     8010079c <cprintf+0x180>
      for(; *s; s++)
801006c9:	0f be 07             	movsbl (%edi),%eax
801006cc:	84 c0                	test   %al,%al
801006ce:	0f 84 f8 00 00 00    	je     801007cc <cprintf+0x1b0>
  if(panicked){
801006d4:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
801006da:	85 d2                	test   %edx,%edx
801006dc:	0f 84 a6 00 00 00    	je     80100788 <cprintf+0x16c>
801006e2:	fa                   	cli    
    for(;;)
801006e3:	eb fe                	jmp    801006e3 <cprintf+0xc7>
801006e5:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801006e8:	83 fa 78             	cmp    $0x78,%edx
801006eb:	75 74                	jne    80100761 <cprintf+0x145>
      printint(*argp++, 16, 0);
801006ed:	8d 47 04             	lea    0x4(%edi),%eax
801006f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006f3:	31 c9                	xor    %ecx,%ecx
801006f5:	ba 10 00 00 00       	mov    $0x10,%edx
801006fa:	8b 07                	mov    (%edi),%eax
801006fc:	e8 93 fe ff ff       	call   80100594 <printint>
80100701:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100704:	43                   	inc    %ebx
80100705:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100709:	85 c0                	test   %eax,%eax
8010070b:	0f 85 3b ff ff ff    	jne    8010064c <cprintf+0x30>
80100711:	eb 8b                	jmp    8010069e <cprintf+0x82>
80100713:	90                   	nop
  if(panicked){
80100714:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
8010071a:	85 c9                	test   %ecx,%ecx
8010071c:	74 14                	je     80100732 <cprintf+0x116>
8010071e:	fa                   	cli    
    for(;;)
8010071f:	eb fe                	jmp    8010071f <cprintf+0x103>
80100721:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100724:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	75 66                	jne    80100793 <cprintf+0x177>
8010072d:	b8 25 00 00 00       	mov    $0x25,%eax
80100732:	e8 79 fc ff ff       	call   801003b0 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100737:	43                   	inc    %ebx
80100738:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
8010073c:	85 c0                	test   %eax,%eax
8010073e:	0f 85 08 ff ff ff    	jne    8010064c <cprintf+0x30>
80100744:	e9 55 ff ff ff       	jmp    8010069e <cprintf+0x82>
80100749:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&cons.lock);
8010074c:	83 ec 0c             	sub    $0xc,%esp
8010074f:	68 20 ef 10 80       	push   $0x8010ef20
80100754:	e8 e7 38 00 00       	call   80104040 <acquire>
80100759:	83 c4 10             	add    $0x10,%esp
8010075c:	e9 d4 fe ff ff       	jmp    80100635 <cprintf+0x19>
  if(panicked){
80100761:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
80100767:	85 c9                	test   %ecx,%ecx
80100769:	75 2d                	jne    80100798 <cprintf+0x17c>
8010076b:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010076e:	b8 25 00 00 00       	mov    $0x25,%eax
80100773:	e8 38 fc ff ff       	call   801003b0 <consputc.part.0>
80100778:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
8010077e:	85 d2                	test   %edx,%edx
80100780:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100783:	74 26                	je     801007ab <cprintf+0x18f>
80100785:	fa                   	cli    
    for(;;)
80100786:	eb fe                	jmp    80100786 <cprintf+0x16a>
80100788:	e8 23 fc ff ff       	call   801003b0 <consputc.part.0>
      for(; *s; s++)
8010078d:	47                   	inc    %edi
8010078e:	e9 36 ff ff ff       	jmp    801006c9 <cprintf+0xad>
80100793:	fa                   	cli    
    for(;;)
80100794:	eb fe                	jmp    80100794 <cprintf+0x178>
80100796:	66 90                	xchg   %ax,%ax
80100798:	fa                   	cli    
80100799:	eb fe                	jmp    80100799 <cprintf+0x17d>
8010079b:	90                   	nop
        s = "(null)";
8010079c:	bf 18 69 10 80       	mov    $0x80106918,%edi
      for(; *s; s++)
801007a1:	b8 28 00 00 00       	mov    $0x28,%eax
801007a6:	e9 29 ff ff ff       	jmp    801006d4 <cprintf+0xb8>
801007ab:	89 d0                	mov    %edx,%eax
801007ad:	e8 fe fb ff ff       	call   801003b0 <consputc.part.0>
801007b2:	e9 de fe ff ff       	jmp    80100695 <cprintf+0x79>
    release(&cons.lock);
801007b7:	83 ec 0c             	sub    $0xc,%esp
801007ba:	68 20 ef 10 80       	push   $0x8010ef20
801007bf:	e8 1c 38 00 00       	call   80103fe0 <release>
801007c4:	83 c4 10             	add    $0x10,%esp
}
801007c7:	e9 dd fe ff ff       	jmp    801006a9 <cprintf+0x8d>
      if((s = (char*)*argp++) == 0)
801007cc:	8b 7d e0             	mov    -0x20(%ebp),%edi
801007cf:	e9 c1 fe ff ff       	jmp    80100695 <cprintf+0x79>
    panic("null fmt");
801007d4:	83 ec 0c             	sub    $0xc,%esp
801007d7:	68 1f 69 10 80       	push   $0x8010691f
801007dc:	e8 57 fb ff ff       	call   80100338 <panic>
801007e1:	8d 76 00             	lea    0x0(%esi),%esi

801007e4 <consoleintr>:
{
801007e4:	55                   	push   %ebp
801007e5:	89 e5                	mov    %esp,%ebp
801007e7:	57                   	push   %edi
801007e8:	56                   	push   %esi
801007e9:	53                   	push   %ebx
801007ea:	83 ec 28             	sub    $0x28,%esp
801007ed:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
801007f0:	68 20 ef 10 80       	push   $0x8010ef20
801007f5:	e8 46 38 00 00       	call   80104040 <acquire>
  while((c = getc()) >= 0){
801007fa:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0;
801007fd:	31 f6                	xor    %esi,%esi
  while((c = getc()) >= 0){
801007ff:	eb 1a                	jmp    8010081b <consoleintr+0x37>
80100801:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100804:	83 f8 08             	cmp    $0x8,%eax
80100807:	0f 84 eb 00 00 00    	je     801008f8 <consoleintr+0x114>
8010080d:	83 f8 10             	cmp    $0x10,%eax
80100810:	0f 85 3e 01 00 00    	jne    80100954 <consoleintr+0x170>
80100816:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
8010081b:	ff d7                	call   *%edi
8010081d:	85 c0                	test   %eax,%eax
8010081f:	0f 88 13 01 00 00    	js     80100938 <consoleintr+0x154>
    switch(c){
80100825:	83 f8 15             	cmp    $0x15,%eax
80100828:	0f 84 92 00 00 00    	je     801008c0 <consoleintr+0xdc>
8010082e:	7e d4                	jle    80100804 <consoleintr+0x20>
80100830:	83 f8 7f             	cmp    $0x7f,%eax
80100833:	0f 84 bf 00 00 00    	je     801008f8 <consoleintr+0x114>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100839:	8b 1d 08 ef 10 80    	mov    0x8010ef08,%ebx
8010083f:	89 da                	mov    %ebx,%edx
80100841:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
80100847:	83 fa 7f             	cmp    $0x7f,%edx
8010084a:	77 cf                	ja     8010081b <consoleintr+0x37>
  if(panicked){
8010084c:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100852:	8d 4b 01             	lea    0x1(%ebx),%ecx
80100855:	83 e3 7f             	and    $0x7f,%ebx
80100858:	89 0d 08 ef 10 80    	mov    %ecx,0x8010ef08
        c = (c == '\r') ? '\n' : c;
8010085e:	83 f8 0d             	cmp    $0xd,%eax
80100861:	0f 84 18 01 00 00    	je     8010097f <consoleintr+0x19b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100867:	88 83 80 ee 10 80    	mov    %al,-0x7fef1180(%ebx)
  if(panicked){
8010086d:	85 d2                	test   %edx,%edx
8010086f:	0f 85 15 01 00 00    	jne    8010098a <consoleintr+0x1a6>
80100875:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100878:	e8 33 fb ff ff       	call   801003b0 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010087d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100880:	8b 0d 08 ef 10 80    	mov    0x8010ef08,%ecx
80100886:	83 f8 0a             	cmp    $0xa,%eax
80100889:	74 18                	je     801008a3 <consoleintr+0xbf>
8010088b:	83 f8 04             	cmp    $0x4,%eax
8010088e:	74 13                	je     801008a3 <consoleintr+0xbf>
80100890:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
80100895:	8d 90 80 00 00 00    	lea    0x80(%eax),%edx
8010089b:	39 ca                	cmp    %ecx,%edx
8010089d:	0f 85 78 ff ff ff    	jne    8010081b <consoleintr+0x37>
          input.w = input.e;
801008a3:	89 0d 04 ef 10 80    	mov    %ecx,0x8010ef04
          wakeup(&input.r);
801008a9:	83 ec 0c             	sub    $0xc,%esp
801008ac:	68 00 ef 10 80       	push   $0x8010ef00
801008b1:	e8 02 33 00 00       	call   80103bb8 <wakeup>
801008b6:	83 c4 10             	add    $0x10,%esp
801008b9:	e9 5d ff ff ff       	jmp    8010081b <consoleintr+0x37>
801008be:	66 90                	xchg   %ax,%ax
      while(input.e != input.w &&
801008c0:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
801008c5:	39 05 04 ef 10 80    	cmp    %eax,0x8010ef04
801008cb:	0f 84 4a ff ff ff    	je     8010081b <consoleintr+0x37>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008d1:	48                   	dec    %eax
801008d2:	89 c2                	mov    %eax,%edx
801008d4:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801008d7:	80 ba 80 ee 10 80 0a 	cmpb   $0xa,-0x7fef1180(%edx)
801008de:	0f 84 37 ff ff ff    	je     8010081b <consoleintr+0x37>
        input.e--;
801008e4:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
801008e9:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
801008ef:	85 d2                	test   %edx,%edx
801008f1:	74 29                	je     8010091c <consoleintr+0x138>
801008f3:	fa                   	cli    
    for(;;)
801008f4:	eb fe                	jmp    801008f4 <consoleintr+0x110>
801008f6:	66 90                	xchg   %ax,%ax
      if(input.e != input.w){
801008f8:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
801008fd:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100903:	0f 84 12 ff ff ff    	je     8010081b <consoleintr+0x37>
        input.e--;
80100909:	48                   	dec    %eax
8010090a:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
8010090f:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
80100914:	85 c0                	test   %eax,%eax
80100916:	74 4c                	je     80100964 <consoleintr+0x180>
80100918:	fa                   	cli    
    for(;;)
80100919:	eb fe                	jmp    80100919 <consoleintr+0x135>
8010091b:	90                   	nop
8010091c:	b8 00 01 00 00       	mov    $0x100,%eax
80100921:	e8 8a fa ff ff       	call   801003b0 <consputc.part.0>
      while(input.e != input.w &&
80100926:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
8010092b:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100931:	75 9e                	jne    801008d1 <consoleintr+0xed>
80100933:	e9 e3 fe ff ff       	jmp    8010081b <consoleintr+0x37>
  release(&cons.lock);
80100938:	83 ec 0c             	sub    $0xc,%esp
8010093b:	68 20 ef 10 80       	push   $0x8010ef20
80100940:	e8 9b 36 00 00       	call   80103fe0 <release>
  if(doprocdump) {
80100945:	83 c4 10             	add    $0x10,%esp
80100948:	85 f6                	test   %esi,%esi
8010094a:	75 27                	jne    80100973 <consoleintr+0x18f>
}
8010094c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010094f:	5b                   	pop    %ebx
80100950:	5e                   	pop    %esi
80100951:	5f                   	pop    %edi
80100952:	5d                   	pop    %ebp
80100953:	c3                   	ret    
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100954:	85 c0                	test   %eax,%eax
80100956:	0f 84 bf fe ff ff    	je     8010081b <consoleintr+0x37>
8010095c:	e9 d8 fe ff ff       	jmp    80100839 <consoleintr+0x55>
80100961:	8d 76 00             	lea    0x0(%esi),%esi
80100964:	b8 00 01 00 00       	mov    $0x100,%eax
80100969:	e8 42 fa ff ff       	call   801003b0 <consputc.part.0>
8010096e:	e9 a8 fe ff ff       	jmp    8010081b <consoleintr+0x37>
}
80100973:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100976:	5b                   	pop    %ebx
80100977:	5e                   	pop    %esi
80100978:	5f                   	pop    %edi
80100979:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
8010097a:	e9 09 33 00 00       	jmp    80103c88 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
8010097f:	c6 83 80 ee 10 80 0a 	movb   $0xa,-0x7fef1180(%ebx)
  if(panicked){
80100986:	85 d2                	test   %edx,%edx
80100988:	74 06                	je     80100990 <consoleintr+0x1ac>
8010098a:	fa                   	cli    
    for(;;)
8010098b:	eb fe                	jmp    8010098b <consoleintr+0x1a7>
8010098d:	8d 76 00             	lea    0x0(%esi),%esi
80100990:	b8 0a 00 00 00       	mov    $0xa,%eax
80100995:	e8 16 fa ff ff       	call   801003b0 <consputc.part.0>
          input.w = input.e;
8010099a:	8b 0d 08 ef 10 80    	mov    0x8010ef08,%ecx
801009a0:	e9 fe fe ff ff       	jmp    801008a3 <consoleintr+0xbf>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi

801009a8 <consoleinit>:

void
consoleinit(void)
{
801009a8:	55                   	push   %ebp
801009a9:	89 e5                	mov    %esp,%ebp
801009ab:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009ae:	68 28 69 10 80       	push   $0x80106928
801009b3:	68 20 ef 10 80       	push   $0x8010ef20
801009b8:	e8 cb 34 00 00       	call   80103e88 <initlock>

  devsw[CONSOLE].write = consolewrite;
801009bd:	c7 05 0c f9 10 80 28 	movl   $0x80100528,0x8010f90c
801009c4:	05 10 80 
  devsw[CONSOLE].read = consoleread;
801009c7:	c7 05 08 f9 10 80 48 	movl   $0x80100248,0x8010f908
801009ce:	02 10 80 
  cons.locking = 1;
801009d1:	c7 05 54 ef 10 80 01 	movl   $0x1,0x8010ef54
801009d8:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801009db:	58                   	pop    %eax
801009dc:	5a                   	pop    %edx
801009dd:	6a 00                	push   $0x0
801009df:	6a 01                	push   $0x1
801009e1:	e8 ae 17 00 00       	call   80102194 <ioapicenable>
}
801009e6:	83 c4 10             	add    $0x10,%esp
801009e9:	c9                   	leave  
801009ea:	c3                   	ret    
801009eb:	90                   	nop

801009ec <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009ec:	55                   	push   %ebp
801009ed:	89 e5                	mov    %esp,%ebp
801009ef:	57                   	push   %edi
801009f0:	56                   	push   %esi
801009f1:	53                   	push   %ebx
801009f2:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009f8:	e8 af 2a 00 00       	call   801034ac <myproc>
801009fd:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100a03:	e8 60 1f 00 00       	call   80102968 <begin_op>

  if((ip = namei(path)) == 0){
80100a08:	83 ec 0c             	sub    $0xc,%esp
80100a0b:	ff 75 08             	push   0x8(%ebp)
80100a0e:	e8 21 14 00 00       	call   80101e34 <namei>
80100a13:	83 c4 10             	add    $0x10,%esp
80100a16:	85 c0                	test   %eax,%eax
80100a18:	0f 84 da 02 00 00    	je     80100cf8 <exec+0x30c>
80100a1e:	89 c3                	mov    %eax,%ebx
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a20:	83 ec 0c             	sub    $0xc,%esp
80100a23:	50                   	push   %eax
80100a24:	e8 97 0b 00 00       	call   801015c0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a29:	6a 34                	push   $0x34
80100a2b:	6a 00                	push   $0x0
80100a2d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a33:	50                   	push   %eax
80100a34:	53                   	push   %ebx
80100a35:	e8 52 0e 00 00       	call   8010188c <readi>
80100a3a:	83 c4 20             	add    $0x20,%esp
80100a3d:	83 f8 34             	cmp    $0x34,%eax
80100a40:	74 1e                	je     80100a60 <exec+0x74>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	53                   	push   %ebx
80100a46:	e8 c5 0d 00 00       	call   80101810 <iunlockput>
    end_op();
80100a4b:	e8 80 1f 00 00       	call   801029d0 <end_op>
80100a50:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a5b:	5b                   	pop    %ebx
80100a5c:	5e                   	pop    %esi
80100a5d:	5f                   	pop    %edi
80100a5e:	5d                   	pop    %ebp
80100a5f:	c3                   	ret    
  if(elf.magic != ELF_MAGIC)
80100a60:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a67:	45 4c 46 
80100a6a:	75 d6                	jne    80100a42 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a6c:	e8 4f 5b 00 00       	call   801065c0 <setupkvm>
80100a71:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a77:	85 c0                	test   %eax,%eax
80100a79:	74 c7                	je     80100a42 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a7b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a81:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a88:	00 
80100a89:	0f 84 88 02 00 00    	je     80100d17 <exec+0x32b>
  sz = 0;
80100a8f:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a91:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
80100a98:	00 00 00 
80100a9b:	e9 84 00 00 00       	jmp    80100b24 <exec+0x138>
    if(ph.type != ELF_PROG_LOAD)
80100aa0:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100aa7:	75 61                	jne    80100b0a <exec+0x11e>
    if(ph.memsz < ph.filesz)
80100aa9:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100aaf:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ab5:	0f 82 85 00 00 00    	jb     80100b40 <exec+0x154>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100abb:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ac1:	72 7d                	jb     80100b40 <exec+0x154>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ac3:	51                   	push   %ecx
80100ac4:	50                   	push   %eax
80100ac5:	57                   	push   %edi
80100ac6:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100acc:	e8 3b 59 00 00       	call   8010640c <allocuvm>
80100ad1:	89 c7                	mov    %eax,%edi
80100ad3:	83 c4 10             	add    $0x10,%esp
80100ad6:	85 c0                	test   %eax,%eax
80100ad8:	74 66                	je     80100b40 <exec+0x154>
    if(ph.vaddr % PGSIZE != 0)
80100ada:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ae0:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ae5:	75 59                	jne    80100b40 <exec+0x154>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100ae7:	83 ec 0c             	sub    $0xc,%esp
80100aea:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100af0:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100af6:	53                   	push   %ebx
80100af7:	50                   	push   %eax
80100af8:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100afe:	e8 2d 58 00 00       	call   80106330 <loaduvm>
80100b03:	83 c4 20             	add    $0x20,%esp
80100b06:	85 c0                	test   %eax,%eax
80100b08:	78 36                	js     80100b40 <exec+0x154>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b0a:	ff 85 f4 fe ff ff    	incl   -0x10c(%ebp)
80100b10:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100b16:	83 c6 20             	add    $0x20,%esi
80100b19:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b20:	39 c8                	cmp    %ecx,%eax
80100b22:	7e 34                	jle    80100b58 <exec+0x16c>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b24:	6a 20                	push   $0x20
80100b26:	56                   	push   %esi
80100b27:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b2d:	50                   	push   %eax
80100b2e:	53                   	push   %ebx
80100b2f:	e8 58 0d 00 00       	call   8010188c <readi>
80100b34:	83 c4 10             	add    $0x10,%esp
80100b37:	83 f8 20             	cmp    $0x20,%eax
80100b3a:	0f 84 60 ff ff ff    	je     80100aa0 <exec+0xb4>
    freevm(pgdir);
80100b40:	83 ec 0c             	sub    $0xc,%esp
80100b43:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b49:	e8 02 5a 00 00       	call   80106550 <freevm>
  if(ip){
80100b4e:	83 c4 10             	add    $0x10,%esp
80100b51:	e9 ec fe ff ff       	jmp    80100a42 <exec+0x56>
80100b56:	66 90                	xchg   %ax,%ax
  sz = PGROUNDUP(sz);
80100b58:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b5e:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b64:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b6a:	83 ec 0c             	sub    $0xc,%esp
80100b6d:	53                   	push   %ebx
80100b6e:	e8 9d 0c 00 00       	call   80101810 <iunlockput>
  end_op();
80100b73:	e8 58 1e 00 00       	call   801029d0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b78:	83 c4 0c             	add    $0xc,%esp
80100b7b:	56                   	push   %esi
80100b7c:	57                   	push   %edi
80100b7d:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100b83:	56                   	push   %esi
80100b84:	e8 83 58 00 00       	call   8010640c <allocuvm>
80100b89:	89 c7                	mov    %eax,%edi
80100b8b:	83 c4 10             	add    $0x10,%esp
80100b8e:	85 c0                	test   %eax,%eax
80100b90:	0f 84 8a 00 00 00    	je     80100c20 <exec+0x234>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100b96:	83 ec 08             	sub    $0x8,%esp
80100b99:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100b9f:	50                   	push   %eax
80100ba0:	56                   	push   %esi
80100ba1:	e8 aa 5a 00 00       	call   80106650 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100ba6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ba9:	8b 00                	mov    (%eax),%eax
80100bab:	83 c4 10             	add    $0x10,%esp
80100bae:	89 fb                	mov    %edi,%ebx
80100bb0:	31 f6                	xor    %esi,%esi
80100bb2:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bb8:	85 c0                	test   %eax,%eax
80100bba:	0f 84 81 00 00 00    	je     80100c41 <exec+0x255>
80100bc0:	89 bd f4 fe ff ff    	mov    %edi,-0x10c(%ebp)
80100bc6:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100bcc:	eb 1f                	jmp    80100bed <exec+0x201>
80100bce:	66 90                	xchg   %ax,%ax
    ustack[3+argc] = sp;
80100bd0:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bd6:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
  for(argc = 0; argv[argc]; argc++) {
80100bdd:	46                   	inc    %esi
80100bde:	8b 45 0c             	mov    0xc(%ebp),%eax
80100be1:	8b 04 b0             	mov    (%eax,%esi,4),%eax
80100be4:	85 c0                	test   %eax,%eax
80100be6:	74 53                	je     80100c3b <exec+0x24f>
    if(argc >= MAXARG)
80100be8:	83 fe 20             	cmp    $0x20,%esi
80100beb:	74 33                	je     80100c20 <exec+0x234>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bed:	83 ec 0c             	sub    $0xc,%esp
80100bf0:	50                   	push   %eax
80100bf1:	e8 7a 36 00 00       	call   80104270 <strlen>
80100bf6:	29 c3                	sub    %eax,%ebx
80100bf8:	4b                   	dec    %ebx
80100bf9:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100bfc:	5a                   	pop    %edx
80100bfd:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c00:	ff 34 b0             	push   (%eax,%esi,4)
80100c03:	e8 68 36 00 00       	call   80104270 <strlen>
80100c08:	40                   	inc    %eax
80100c09:	50                   	push   %eax
80100c0a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0d:	ff 34 b0             	push   (%eax,%esi,4)
80100c10:	53                   	push   %ebx
80100c11:	57                   	push   %edi
80100c12:	e8 dd 5b 00 00       	call   801067f4 <copyout>
80100c17:	83 c4 20             	add    $0x20,%esp
80100c1a:	85 c0                	test   %eax,%eax
80100c1c:	79 b2                	jns    80100bd0 <exec+0x1e4>
80100c1e:	66 90                	xchg   %ax,%ax
    freevm(pgdir);
80100c20:	83 ec 0c             	sub    $0xc,%esp
80100c23:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100c29:	e8 22 59 00 00       	call   80106550 <freevm>
80100c2e:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c36:	e9 1d fe ff ff       	jmp    80100a58 <exec+0x6c>
80100c3b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
  ustack[3+argc] = 0;
80100c41:	c7 84 b5 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%esi,4)
80100c48:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100c4c:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c53:	ff ff ff 
  ustack[1] = argc;
80100c56:	89 b5 5c ff ff ff    	mov    %esi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c5c:	8d 04 b5 04 00 00 00 	lea    0x4(,%esi,4),%eax
80100c63:	89 d9                	mov    %ebx,%ecx
80100c65:	29 c1                	sub    %eax,%ecx
80100c67:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  sp -= (3+argc+1) * 4;
80100c6d:	83 c0 0c             	add    $0xc,%eax
80100c70:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c72:	50                   	push   %eax
80100c73:	52                   	push   %edx
80100c74:	53                   	push   %ebx
80100c75:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100c7b:	e8 74 5b 00 00       	call   801067f4 <copyout>
80100c80:	83 c4 10             	add    $0x10,%esp
80100c83:	85 c0                	test   %eax,%eax
80100c85:	78 99                	js     80100c20 <exec+0x234>
  for(last=s=path; *s; s++)
80100c87:	8b 45 08             	mov    0x8(%ebp),%eax
80100c8a:	8a 00                	mov    (%eax),%al
80100c8c:	8b 55 08             	mov    0x8(%ebp),%edx
80100c8f:	84 c0                	test   %al,%al
80100c91:	74 12                	je     80100ca5 <exec+0x2b9>
80100c93:	89 d1                	mov    %edx,%ecx
80100c95:	8d 76 00             	lea    0x0(%esi),%esi
      last = s+1;
80100c98:	41                   	inc    %ecx
    if(*s == '/')
80100c99:	3c 2f                	cmp    $0x2f,%al
80100c9b:	75 02                	jne    80100c9f <exec+0x2b3>
      last = s+1;
80100c9d:	89 ca                	mov    %ecx,%edx
  for(last=s=path; *s; s++)
80100c9f:	8a 01                	mov    (%ecx),%al
80100ca1:	84 c0                	test   %al,%al
80100ca3:	75 f3                	jne    80100c98 <exec+0x2ac>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100ca5:	50                   	push   %eax
80100ca6:	6a 10                	push   $0x10
80100ca8:	52                   	push   %edx
80100ca9:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100caf:	89 f0                	mov    %esi,%eax
80100cb1:	83 c0 6c             	add    $0x6c,%eax
80100cb4:	50                   	push   %eax
80100cb5:	e8 82 35 00 00       	call   8010423c <safestrcpy>
  oldpgdir = curproc->pgdir;
80100cba:	89 f0                	mov    %esi,%eax
80100cbc:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->pgdir = pgdir;
80100cbf:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100cc5:	89 50 04             	mov    %edx,0x4(%eax)
  curproc->sz = sz;
80100cc8:	89 38                	mov    %edi,(%eax)
  curproc->tf->eip = elf.entry;  // main
80100cca:	89 c7                	mov    %eax,%edi
80100ccc:	8b 40 18             	mov    0x18(%eax),%eax
80100ccf:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100cd5:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100cd8:	8b 47 18             	mov    0x18(%edi),%eax
80100cdb:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100cde:	89 3c 24             	mov    %edi,(%esp)
80100ce1:	e8 da 54 00 00       	call   801061c0 <switchuvm>
  freevm(oldpgdir);
80100ce6:	89 34 24             	mov    %esi,(%esp)
80100ce9:	e8 62 58 00 00       	call   80106550 <freevm>
  return 0;
80100cee:	83 c4 10             	add    $0x10,%esp
80100cf1:	31 c0                	xor    %eax,%eax
80100cf3:	e9 60 fd ff ff       	jmp    80100a58 <exec+0x6c>
    end_op();
80100cf8:	e8 d3 1c 00 00       	call   801029d0 <end_op>
    cprintf("exec: fail\n");
80100cfd:	83 ec 0c             	sub    $0xc,%esp
80100d00:	68 41 69 10 80       	push   $0x80106941
80100d05:	e8 12 f9 ff ff       	call   8010061c <cprintf>
    return -1;
80100d0a:	83 c4 10             	add    $0x10,%esp
80100d0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d12:	e9 41 fd ff ff       	jmp    80100a58 <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d17:	be 00 20 00 00       	mov    $0x2000,%esi
80100d1c:	31 ff                	xor    %edi,%edi
80100d1e:	e9 47 fe ff ff       	jmp    80100b6a <exec+0x17e>
80100d23:	90                   	nop

80100d24 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d24:	55                   	push   %ebp
80100d25:	89 e5                	mov    %esp,%ebp
80100d27:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d2a:	68 4d 69 10 80       	push   $0x8010694d
80100d2f:	68 60 ef 10 80       	push   $0x8010ef60
80100d34:	e8 4f 31 00 00       	call   80103e88 <initlock>
}
80100d39:	83 c4 10             	add    $0x10,%esp
80100d3c:	c9                   	leave  
80100d3d:	c3                   	ret    
80100d3e:	66 90                	xchg   %ax,%ax

80100d40 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d40:	55                   	push   %ebp
80100d41:	89 e5                	mov    %esp,%ebp
80100d43:	83 ec 24             	sub    $0x24,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d46:	68 60 ef 10 80       	push   $0x8010ef60
80100d4b:	e8 f0 32 00 00       	call   80104040 <acquire>
80100d50:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d53:	b8 94 ef 10 80       	mov    $0x8010ef94,%eax
80100d58:	eb 0c                	jmp    80100d66 <filealloc+0x26>
80100d5a:	66 90                	xchg   %ax,%ax
80100d5c:	83 c0 18             	add    $0x18,%eax
80100d5f:	3d f4 f8 10 80       	cmp    $0x8010f8f4,%eax
80100d64:	74 26                	je     80100d8c <filealloc+0x4c>
    if(f->ref == 0){
80100d66:	8b 50 04             	mov    0x4(%eax),%edx
80100d69:	85 d2                	test   %edx,%edx
80100d6b:	75 ef                	jne    80100d5c <filealloc+0x1c>
      f->ref = 1;
80100d6d:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
80100d74:	89 45 f4             	mov    %eax,-0xc(%ebp)
      release(&ftable.lock);
80100d77:	83 ec 0c             	sub    $0xc,%esp
80100d7a:	68 60 ef 10 80       	push   $0x8010ef60
80100d7f:	e8 5c 32 00 00       	call   80103fe0 <release>
      return f;
80100d84:	83 c4 10             	add    $0x10,%esp
80100d87:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
  }
  release(&ftable.lock);
  return 0;
}
80100d8a:	c9                   	leave  
80100d8b:	c3                   	ret    
  release(&ftable.lock);
80100d8c:	83 ec 0c             	sub    $0xc,%esp
80100d8f:	68 60 ef 10 80       	push   $0x8010ef60
80100d94:	e8 47 32 00 00       	call   80103fe0 <release>
  return 0;
80100d99:	83 c4 10             	add    $0x10,%esp
80100d9c:	31 c0                	xor    %eax,%eax
}
80100d9e:	c9                   	leave  
80100d9f:	c3                   	ret    

80100da0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100da0:	55                   	push   %ebp
80100da1:	89 e5                	mov    %esp,%ebp
80100da3:	53                   	push   %ebx
80100da4:	83 ec 10             	sub    $0x10,%esp
80100da7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100daa:	68 60 ef 10 80       	push   $0x8010ef60
80100daf:	e8 8c 32 00 00       	call   80104040 <acquire>
  if(f->ref < 1)
80100db4:	8b 43 04             	mov    0x4(%ebx),%eax
80100db7:	83 c4 10             	add    $0x10,%esp
80100dba:	85 c0                	test   %eax,%eax
80100dbc:	7e 18                	jle    80100dd6 <filedup+0x36>
    panic("filedup");
  f->ref++;
80100dbe:	40                   	inc    %eax
80100dbf:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100dc2:	83 ec 0c             	sub    $0xc,%esp
80100dc5:	68 60 ef 10 80       	push   $0x8010ef60
80100dca:	e8 11 32 00 00       	call   80103fe0 <release>
  return f;
}
80100dcf:	89 d8                	mov    %ebx,%eax
80100dd1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dd4:	c9                   	leave  
80100dd5:	c3                   	ret    
    panic("filedup");
80100dd6:	83 ec 0c             	sub    $0xc,%esp
80100dd9:	68 54 69 10 80       	push   $0x80106954
80100dde:	e8 55 f5 ff ff       	call   80100338 <panic>
80100de3:	90                   	nop

80100de4 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100de4:	55                   	push   %ebp
80100de5:	89 e5                	mov    %esp,%ebp
80100de7:	57                   	push   %edi
80100de8:	56                   	push   %esi
80100de9:	53                   	push   %ebx
80100dea:	83 ec 28             	sub    $0x28,%esp
80100ded:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100df0:	68 60 ef 10 80       	push   $0x8010ef60
80100df5:	e8 46 32 00 00       	call   80104040 <acquire>
  if(f->ref < 1)
80100dfa:	8b 57 04             	mov    0x4(%edi),%edx
80100dfd:	83 c4 10             	add    $0x10,%esp
80100e00:	85 d2                	test   %edx,%edx
80100e02:	0f 8e 8d 00 00 00    	jle    80100e95 <fileclose+0xb1>
    panic("fileclose");
  if(--f->ref > 0){
80100e08:	4a                   	dec    %edx
80100e09:	89 57 04             	mov    %edx,0x4(%edi)
80100e0c:	75 3a                	jne    80100e48 <fileclose+0x64>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e0e:	8b 1f                	mov    (%edi),%ebx
80100e10:	8a 47 09             	mov    0x9(%edi),%al
80100e13:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e16:	8b 77 0c             	mov    0xc(%edi),%esi
80100e19:	8b 47 10             	mov    0x10(%edi),%eax
80100e1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
80100e1f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  release(&ftable.lock);
80100e25:	83 ec 0c             	sub    $0xc,%esp
80100e28:	68 60 ef 10 80       	push   $0x8010ef60
80100e2d:	e8 ae 31 00 00       	call   80103fe0 <release>

  if(ff.type == FD_PIPE)
80100e32:	83 c4 10             	add    $0x10,%esp
80100e35:	83 fb 01             	cmp    $0x1,%ebx
80100e38:	74 42                	je     80100e7c <fileclose+0x98>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100e3a:	83 fb 02             	cmp    $0x2,%ebx
80100e3d:	74 1d                	je     80100e5c <fileclose+0x78>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e3f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e42:	5b                   	pop    %ebx
80100e43:	5e                   	pop    %esi
80100e44:	5f                   	pop    %edi
80100e45:	5d                   	pop    %ebp
80100e46:	c3                   	ret    
80100e47:	90                   	nop
    release(&ftable.lock);
80100e48:	c7 45 08 60 ef 10 80 	movl   $0x8010ef60,0x8(%ebp)
}
80100e4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e52:	5b                   	pop    %ebx
80100e53:	5e                   	pop    %esi
80100e54:	5f                   	pop    %edi
80100e55:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e56:	e9 85 31 00 00       	jmp    80103fe0 <release>
80100e5b:	90                   	nop
    begin_op();
80100e5c:	e8 07 1b 00 00       	call   80102968 <begin_op>
    iput(ff.ip);
80100e61:	83 ec 0c             	sub    $0xc,%esp
80100e64:	ff 75 e0             	push   -0x20(%ebp)
80100e67:	e8 60 08 00 00       	call   801016cc <iput>
    end_op();
80100e6c:	83 c4 10             	add    $0x10,%esp
}
80100e6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e72:	5b                   	pop    %ebx
80100e73:	5e                   	pop    %esi
80100e74:	5f                   	pop    %edi
80100e75:	5d                   	pop    %ebp
    end_op();
80100e76:	e9 55 1b 00 00       	jmp    801029d0 <end_op>
80100e7b:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80100e7c:	83 ec 08             	sub    $0x8,%esp
80100e7f:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
80100e83:	50                   	push   %eax
80100e84:	56                   	push   %esi
80100e85:	e8 fa 21 00 00       	call   80103084 <pipeclose>
80100e8a:	83 c4 10             	add    $0x10,%esp
}
80100e8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e90:	5b                   	pop    %ebx
80100e91:	5e                   	pop    %esi
80100e92:	5f                   	pop    %edi
80100e93:	5d                   	pop    %ebp
80100e94:	c3                   	ret    
    panic("fileclose");
80100e95:	83 ec 0c             	sub    $0xc,%esp
80100e98:	68 5c 69 10 80       	push   $0x8010695c
80100e9d:	e8 96 f4 ff ff       	call   80100338 <panic>
80100ea2:	66 90                	xchg   %ax,%ax

80100ea4 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ea4:	55                   	push   %ebp
80100ea5:	89 e5                	mov    %esp,%ebp
80100ea7:	53                   	push   %ebx
80100ea8:	53                   	push   %ebx
80100ea9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100eac:	83 3b 02             	cmpl   $0x2,(%ebx)
80100eaf:	75 2b                	jne    80100edc <filestat+0x38>
    ilock(f->ip);
80100eb1:	83 ec 0c             	sub    $0xc,%esp
80100eb4:	ff 73 10             	push   0x10(%ebx)
80100eb7:	e8 04 07 00 00       	call   801015c0 <ilock>
    stati(f->ip, st);
80100ebc:	58                   	pop    %eax
80100ebd:	5a                   	pop    %edx
80100ebe:	ff 75 0c             	push   0xc(%ebp)
80100ec1:	ff 73 10             	push   0x10(%ebx)
80100ec4:	e8 97 09 00 00       	call   80101860 <stati>
    iunlock(f->ip);
80100ec9:	59                   	pop    %ecx
80100eca:	ff 73 10             	push   0x10(%ebx)
80100ecd:	e8 b6 07 00 00       	call   80101688 <iunlock>
    return 0;
80100ed2:	83 c4 10             	add    $0x10,%esp
80100ed5:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100ed7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100eda:	c9                   	leave  
80100edb:	c3                   	ret    
  return -1;
80100edc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100ee1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ee4:	c9                   	leave  
80100ee5:	c3                   	ret    
80100ee6:	66 90                	xchg   %ax,%ax

80100ee8 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100ee8:	55                   	push   %ebp
80100ee9:	89 e5                	mov    %esp,%ebp
80100eeb:	57                   	push   %edi
80100eec:	56                   	push   %esi
80100eed:	53                   	push   %ebx
80100eee:	83 ec 1c             	sub    $0x1c,%esp
80100ef1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100ef4:	8b 75 0c             	mov    0xc(%ebp),%esi
80100ef7:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100efa:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100efe:	74 60                	je     80100f60 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f00:	8b 03                	mov    (%ebx),%eax
80100f02:	83 f8 01             	cmp    $0x1,%eax
80100f05:	74 45                	je     80100f4c <fileread+0x64>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f07:	83 f8 02             	cmp    $0x2,%eax
80100f0a:	75 5b                	jne    80100f67 <fileread+0x7f>
    ilock(f->ip);
80100f0c:	83 ec 0c             	sub    $0xc,%esp
80100f0f:	ff 73 10             	push   0x10(%ebx)
80100f12:	e8 a9 06 00 00       	call   801015c0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f17:	57                   	push   %edi
80100f18:	ff 73 14             	push   0x14(%ebx)
80100f1b:	56                   	push   %esi
80100f1c:	ff 73 10             	push   0x10(%ebx)
80100f1f:	e8 68 09 00 00       	call   8010188c <readi>
80100f24:	83 c4 20             	add    $0x20,%esp
80100f27:	85 c0                	test   %eax,%eax
80100f29:	7e 03                	jle    80100f2e <fileread+0x46>
      f->off += r;
80100f2b:	01 43 14             	add    %eax,0x14(%ebx)
80100f2e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    iunlock(f->ip);
80100f31:	83 ec 0c             	sub    $0xc,%esp
80100f34:	ff 73 10             	push   0x10(%ebx)
80100f37:	e8 4c 07 00 00       	call   80101688 <iunlock>
    return r;
80100f3c:	83 c4 10             	add    $0x10,%esp
80100f3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
80100f42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f45:	5b                   	pop    %ebx
80100f46:	5e                   	pop    %esi
80100f47:	5f                   	pop    %edi
80100f48:	5d                   	pop    %ebp
80100f49:	c3                   	ret    
80100f4a:	66 90                	xchg   %ax,%ax
    return piperead(f->pipe, addr, n);
80100f4c:	8b 43 0c             	mov    0xc(%ebx),%eax
80100f4f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100f52:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f55:	5b                   	pop    %ebx
80100f56:	5e                   	pop    %esi
80100f57:	5f                   	pop    %edi
80100f58:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100f59:	e9 ae 22 00 00       	jmp    8010320c <piperead>
80100f5e:	66 90                	xchg   %ax,%ax
    return -1;
80100f60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f65:	eb db                	jmp    80100f42 <fileread+0x5a>
  panic("fileread");
80100f67:	83 ec 0c             	sub    $0xc,%esp
80100f6a:	68 66 69 10 80       	push   $0x80106966
80100f6f:	e8 c4 f3 ff ff       	call   80100338 <panic>

80100f74 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100f74:	55                   	push   %ebp
80100f75:	89 e5                	mov    %esp,%ebp
80100f77:	57                   	push   %edi
80100f78:	56                   	push   %esi
80100f79:	53                   	push   %ebx
80100f7a:	83 ec 1c             	sub    $0x1c,%esp
80100f7d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f80:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f83:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100f86:	8b 45 10             	mov    0x10(%ebp),%eax
80100f89:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100f8c:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
80100f90:	0f 84 ae 00 00 00    	je     80101044 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80100f96:	8b 03                	mov    (%ebx),%eax
80100f98:	83 f8 01             	cmp    $0x1,%eax
80100f9b:	0f 84 c2 00 00 00    	je     80101063 <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fa1:	83 f8 02             	cmp    $0x2,%eax
80100fa4:	0f 85 cb 00 00 00    	jne    80101075 <filewrite+0x101>
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
80100faa:	31 ff                	xor    %edi,%edi
    while(i < n){
80100fac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100faf:	85 c0                	test   %eax,%eax
80100fb1:	7f 2c                	jg     80100fdf <filewrite+0x6b>
80100fb3:	e9 9c 00 00 00       	jmp    80101054 <filewrite+0xe0>
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80100fb8:	01 43 14             	add    %eax,0x14(%ebx)
80100fbb:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80100fbe:	83 ec 0c             	sub    $0xc,%esp
80100fc1:	ff 73 10             	push   0x10(%ebx)
80100fc4:	e8 bf 06 00 00       	call   80101688 <iunlock>
      end_op();
80100fc9:	e8 02 1a 00 00       	call   801029d0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80100fce:	83 c4 10             	add    $0x10,%esp
80100fd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100fd4:	39 c6                	cmp    %eax,%esi
80100fd6:	75 5f                	jne    80101037 <filewrite+0xc3>
        panic("short filewrite");
      i += r;
80100fd8:	01 f7                	add    %esi,%edi
    while(i < n){
80100fda:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80100fdd:	7e 75                	jle    80101054 <filewrite+0xe0>
      int n1 = n - i;
80100fdf:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80100fe2:	29 fe                	sub    %edi,%esi
80100fe4:	81 fe 00 06 00 00    	cmp    $0x600,%esi
80100fea:	7e 05                	jle    80100ff1 <filewrite+0x7d>
80100fec:	be 00 06 00 00       	mov    $0x600,%esi
      begin_op();
80100ff1:	e8 72 19 00 00       	call   80102968 <begin_op>
      ilock(f->ip);
80100ff6:	83 ec 0c             	sub    $0xc,%esp
80100ff9:	ff 73 10             	push   0x10(%ebx)
80100ffc:	e8 bf 05 00 00       	call   801015c0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101001:	56                   	push   %esi
80101002:	ff 73 14             	push   0x14(%ebx)
80101005:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101008:	01 f8                	add    %edi,%eax
8010100a:	50                   	push   %eax
8010100b:	ff 73 10             	push   0x10(%ebx)
8010100e:	e8 71 09 00 00       	call   80101984 <writei>
80101013:	83 c4 20             	add    $0x20,%esp
80101016:	85 c0                	test   %eax,%eax
80101018:	7f 9e                	jg     80100fb8 <filewrite+0x44>
8010101a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      iunlock(f->ip);
8010101d:	83 ec 0c             	sub    $0xc,%esp
80101020:	ff 73 10             	push   0x10(%ebx)
80101023:	e8 60 06 00 00       	call   80101688 <iunlock>
      end_op();
80101028:	e8 a3 19 00 00       	call   801029d0 <end_op>
      if(r < 0)
8010102d:	83 c4 10             	add    $0x10,%esp
80101030:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101033:	85 c0                	test   %eax,%eax
80101035:	75 0d                	jne    80101044 <filewrite+0xd0>
        panic("short filewrite");
80101037:	83 ec 0c             	sub    $0xc,%esp
8010103a:	68 6f 69 10 80       	push   $0x8010696f
8010103f:	e8 f4 f2 ff ff       	call   80100338 <panic>
    }
    return i == n ? n : -1;
80101044:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101049:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010104c:	5b                   	pop    %ebx
8010104d:	5e                   	pop    %esi
8010104e:	5f                   	pop    %edi
8010104f:	5d                   	pop    %ebp
80101050:	c3                   	ret    
80101051:	8d 76 00             	lea    0x0(%esi),%esi
    return i == n ? n : -1;
80101054:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101057:	75 eb                	jne    80101044 <filewrite+0xd0>
80101059:	89 f8                	mov    %edi,%eax
}
8010105b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010105e:	5b                   	pop    %ebx
8010105f:	5e                   	pop    %esi
80101060:	5f                   	pop    %edi
80101061:	5d                   	pop    %ebp
80101062:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80101063:	8b 43 0c             	mov    0xc(%ebx),%eax
80101066:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101069:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010106c:	5b                   	pop    %ebx
8010106d:	5e                   	pop    %esi
8010106e:	5f                   	pop    %edi
8010106f:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101070:	e9 a7 20 00 00       	jmp    8010311c <pipewrite>
  panic("filewrite");
80101075:	83 ec 0c             	sub    $0xc,%esp
80101078:	68 75 69 10 80       	push   $0x80106975
8010107d:	e8 b6 f2 ff ff       	call   80100338 <panic>
80101082:	66 90                	xchg   %ax,%ax

80101084 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101084:	55                   	push   %ebp
80101085:	89 e5                	mov    %esp,%ebp
80101087:	56                   	push   %esi
80101088:	53                   	push   %ebx
80101089:	89 c1                	mov    %eax,%ecx
8010108b:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
8010108d:	83 ec 08             	sub    $0x8,%esp
80101090:	89 d0                	mov    %edx,%eax
80101092:	c1 e8 0c             	shr    $0xc,%eax
80101095:	03 05 cc 15 11 80    	add    0x801115cc,%eax
8010109b:	50                   	push   %eax
8010109c:	51                   	push   %ecx
8010109d:	e8 12 f0 ff ff       	call   801000b4 <bread>
801010a2:	89 c6                	mov    %eax,%esi
  bi = b % BPB;
  m = 1 << (bi % 8);
801010a4:	89 d9                	mov    %ebx,%ecx
801010a6:	83 e1 07             	and    $0x7,%ecx
801010a9:	b8 01 00 00 00       	mov    $0x1,%eax
801010ae:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801010b0:	c1 fb 03             	sar    $0x3,%ebx
801010b3:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801010b9:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801010be:	83 c4 10             	add    $0x10,%esp
801010c1:	85 c1                	test   %eax,%ecx
801010c3:	74 23                	je     801010e8 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801010c5:	f7 d0                	not    %eax
801010c7:	21 c8                	and    %ecx,%eax
801010c9:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801010cd:	83 ec 0c             	sub    $0xc,%esp
801010d0:	56                   	push   %esi
801010d1:	e8 4e 1a 00 00       	call   80102b24 <log_write>
  brelse(bp);
801010d6:	89 34 24             	mov    %esi,(%esp)
801010d9:	e8 de f0 ff ff       	call   801001bc <brelse>
}
801010de:	83 c4 10             	add    $0x10,%esp
801010e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801010e4:	5b                   	pop    %ebx
801010e5:	5e                   	pop    %esi
801010e6:	5d                   	pop    %ebp
801010e7:	c3                   	ret    
    panic("freeing free block");
801010e8:	83 ec 0c             	sub    $0xc,%esp
801010eb:	68 7f 69 10 80       	push   $0x8010697f
801010f0:	e8 43 f2 ff ff       	call   80100338 <panic>
801010f5:	8d 76 00             	lea    0x0(%esi),%esi

801010f8 <balloc>:
{
801010f8:	55                   	push   %ebp
801010f9:	89 e5                	mov    %esp,%ebp
801010fb:	57                   	push   %edi
801010fc:	56                   	push   %esi
801010fd:	53                   	push   %ebx
801010fe:	83 ec 1c             	sub    $0x1c,%esp
80101101:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101104:	8b 0d b4 15 11 80    	mov    0x801115b4,%ecx
8010110a:	85 c9                	test   %ecx,%ecx
8010110c:	74 7e                	je     8010118c <balloc+0x94>
8010110e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101115:	83 ec 08             	sub    $0x8,%esp
80101118:	8b 75 dc             	mov    -0x24(%ebp),%esi
8010111b:	89 f0                	mov    %esi,%eax
8010111d:	c1 f8 0c             	sar    $0xc,%eax
80101120:	03 05 cc 15 11 80    	add    0x801115cc,%eax
80101126:	50                   	push   %eax
80101127:	ff 75 d8             	push   -0x28(%ebp)
8010112a:	e8 85 ef ff ff       	call   801000b4 <bread>
8010112f:	89 c3                	mov    %eax,%ebx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101131:	a1 b4 15 11 80       	mov    0x801115b4,%eax
80101136:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101139:	83 c4 10             	add    $0x10,%esp
8010113c:	31 c0                	xor    %eax,%eax
8010113e:	eb 29                	jmp    80101169 <balloc+0x71>
      m = 1 << (bi % 8);
80101140:	89 c1                	mov    %eax,%ecx
80101142:	83 e1 07             	and    $0x7,%ecx
80101145:	bf 01 00 00 00       	mov    $0x1,%edi
8010114a:	d3 e7                	shl    %cl,%edi
8010114c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010114f:	89 c1                	mov    %eax,%ecx
80101151:	c1 f9 03             	sar    $0x3,%ecx
80101154:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101159:	89 fa                	mov    %edi,%edx
8010115b:	85 7d e4             	test   %edi,-0x1c(%ebp)
8010115e:	74 3c                	je     8010119c <balloc+0xa4>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101160:	40                   	inc    %eax
80101161:	46                   	inc    %esi
80101162:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101167:	74 05                	je     8010116e <balloc+0x76>
80101169:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010116c:	77 d2                	ja     80101140 <balloc+0x48>
    brelse(bp);
8010116e:	83 ec 0c             	sub    $0xc,%esp
80101171:	53                   	push   %ebx
80101172:	e8 45 f0 ff ff       	call   801001bc <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101177:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
8010117e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101181:	83 c4 10             	add    $0x10,%esp
80101184:	39 05 b4 15 11 80    	cmp    %eax,0x801115b4
8010118a:	77 89                	ja     80101115 <balloc+0x1d>
  panic("balloc: out of blocks");
8010118c:	83 ec 0c             	sub    $0xc,%esp
8010118f:	68 92 69 10 80       	push   $0x80106992
80101194:	e8 9f f1 ff ff       	call   80100338 <panic>
80101199:	8d 76 00             	lea    0x0(%esi),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
8010119c:	0b 55 e4             	or     -0x1c(%ebp),%edx
8010119f:	88 54 0b 5c          	mov    %dl,0x5c(%ebx,%ecx,1)
        log_write(bp);
801011a3:	83 ec 0c             	sub    $0xc,%esp
801011a6:	53                   	push   %ebx
801011a7:	e8 78 19 00 00       	call   80102b24 <log_write>
        brelse(bp);
801011ac:	89 1c 24             	mov    %ebx,(%esp)
801011af:	e8 08 f0 ff ff       	call   801001bc <brelse>
  bp = bread(dev, bno);
801011b4:	58                   	pop    %eax
801011b5:	5a                   	pop    %edx
801011b6:	56                   	push   %esi
801011b7:	ff 75 d8             	push   -0x28(%ebp)
801011ba:	e8 f5 ee ff ff       	call   801000b4 <bread>
801011bf:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011c1:	83 c4 0c             	add    $0xc,%esp
801011c4:	68 00 02 00 00       	push   $0x200
801011c9:	6a 00                	push   $0x0
801011cb:	8d 40 5c             	lea    0x5c(%eax),%eax
801011ce:	50                   	push   %eax
801011cf:	e8 14 2f 00 00       	call   801040e8 <memset>
  log_write(bp);
801011d4:	89 1c 24             	mov    %ebx,(%esp)
801011d7:	e8 48 19 00 00       	call   80102b24 <log_write>
  brelse(bp);
801011dc:	89 1c 24             	mov    %ebx,(%esp)
801011df:	e8 d8 ef ff ff       	call   801001bc <brelse>
}
801011e4:	89 f0                	mov    %esi,%eax
801011e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011e9:	5b                   	pop    %ebx
801011ea:	5e                   	pop    %esi
801011eb:	5f                   	pop    %edi
801011ec:	5d                   	pop    %ebp
801011ed:	c3                   	ret    
801011ee:	66 90                	xchg   %ax,%ax

801011f0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801011f0:	55                   	push   %ebp
801011f1:	89 e5                	mov    %esp,%ebp
801011f3:	57                   	push   %edi
801011f4:	56                   	push   %esi
801011f5:	53                   	push   %ebx
801011f6:	83 ec 28             	sub    $0x28,%esp
801011f9:	89 c7                	mov    %eax,%edi
801011fb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
801011fe:	68 60 f9 10 80       	push   $0x8010f960
80101203:	e8 38 2e 00 00       	call   80104040 <acquire>
80101208:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
8010120b:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010120d:	bb 94 f9 10 80       	mov    $0x8010f994,%ebx
80101212:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101215:	eb 13                	jmp    8010122a <iget+0x3a>
80101217:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101218:	39 3b                	cmp    %edi,(%ebx)
8010121a:	74 64                	je     80101280 <iget+0x90>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010121c:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101222:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
80101228:	73 22                	jae    8010124c <iget+0x5c>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010122a:	8b 43 08             	mov    0x8(%ebx),%eax
8010122d:	85 c0                	test   %eax,%eax
8010122f:	7f e7                	jg     80101218 <iget+0x28>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101231:	85 f6                	test   %esi,%esi
80101233:	75 e7                	jne    8010121c <iget+0x2c>
80101235:	85 c0                	test   %eax,%eax
80101237:	75 6c                	jne    801012a5 <iget+0xb5>
80101239:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010123b:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101241:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
80101247:	72 e1                	jb     8010122a <iget+0x3a>
80101249:	8d 76 00             	lea    0x0(%esi),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
8010124c:	85 f6                	test   %esi,%esi
8010124e:	74 73                	je     801012c3 <iget+0xd3>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101250:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101252:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101255:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010125c:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101263:	83 ec 0c             	sub    $0xc,%esp
80101266:	68 60 f9 10 80       	push   $0x8010f960
8010126b:	e8 70 2d 00 00       	call   80103fe0 <release>

  return ip;
80101270:	83 c4 10             	add    $0x10,%esp
}
80101273:	89 f0                	mov    %esi,%eax
80101275:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101278:	5b                   	pop    %ebx
80101279:	5e                   	pop    %esi
8010127a:	5f                   	pop    %edi
8010127b:	5d                   	pop    %ebp
8010127c:	c3                   	ret    
8010127d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101280:	39 53 04             	cmp    %edx,0x4(%ebx)
80101283:	75 97                	jne    8010121c <iget+0x2c>
      ip->ref++;
80101285:	40                   	inc    %eax
80101286:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101289:	83 ec 0c             	sub    $0xc,%esp
8010128c:	68 60 f9 10 80       	push   $0x8010f960
80101291:	e8 4a 2d 00 00       	call   80103fe0 <release>
      return ip;
80101296:	83 c4 10             	add    $0x10,%esp
80101299:	89 de                	mov    %ebx,%esi
}
8010129b:	89 f0                	mov    %esi,%eax
8010129d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012a0:	5b                   	pop    %ebx
801012a1:	5e                   	pop    %esi
801012a2:	5f                   	pop    %edi
801012a3:	5d                   	pop    %ebp
801012a4:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012a5:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012ab:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
801012b1:	73 10                	jae    801012c3 <iget+0xd3>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012b3:	8b 43 08             	mov    0x8(%ebx),%eax
801012b6:	85 c0                	test   %eax,%eax
801012b8:	0f 8f 5a ff ff ff    	jg     80101218 <iget+0x28>
801012be:	e9 72 ff ff ff       	jmp    80101235 <iget+0x45>
    panic("iget: no inodes");
801012c3:	83 ec 0c             	sub    $0xc,%esp
801012c6:	68 a8 69 10 80       	push   $0x801069a8
801012cb:	e8 68 f0 ff ff       	call   80100338 <panic>

801012d0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012d0:	55                   	push   %ebp
801012d1:	89 e5                	mov    %esp,%ebp
801012d3:	57                   	push   %edi
801012d4:	56                   	push   %esi
801012d5:	53                   	push   %ebx
801012d6:	83 ec 1c             	sub    $0x1c,%esp
801012d9:	89 c6                	mov    %eax,%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012db:	83 fa 0b             	cmp    $0xb,%edx
801012de:	76 7c                	jbe    8010135c <bmap+0x8c>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801012e0:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801012e3:	83 fb 7f             	cmp    $0x7f,%ebx
801012e6:	0f 87 8e 00 00 00    	ja     8010137a <bmap+0xaa>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801012ec:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801012f2:	85 c0                	test   %eax,%eax
801012f4:	74 56                	je     8010134c <bmap+0x7c>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801012f6:	83 ec 08             	sub    $0x8,%esp
801012f9:	50                   	push   %eax
801012fa:	ff 36                	push   (%esi)
801012fc:	e8 b3 ed ff ff       	call   801000b4 <bread>
80101301:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101303:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
80101307:	8b 03                	mov    (%ebx),%eax
80101309:	83 c4 10             	add    $0x10,%esp
8010130c:	85 c0                	test   %eax,%eax
8010130e:	74 1c                	je     8010132c <bmap+0x5c>
80101310:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101313:	83 ec 0c             	sub    $0xc,%esp
80101316:	57                   	push   %edi
80101317:	e8 a0 ee ff ff       	call   801001bc <brelse>
8010131c:	83 c4 10             	add    $0x10,%esp
8010131f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101322:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101325:	5b                   	pop    %ebx
80101326:	5e                   	pop    %esi
80101327:	5f                   	pop    %edi
80101328:	5d                   	pop    %ebp
80101329:	c3                   	ret    
8010132a:	66 90                	xchg   %ax,%ax
      a[bn] = addr = balloc(ip->dev);
8010132c:	8b 06                	mov    (%esi),%eax
8010132e:	e8 c5 fd ff ff       	call   801010f8 <balloc>
80101333:	89 03                	mov    %eax,(%ebx)
80101335:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      log_write(bp);
80101338:	83 ec 0c             	sub    $0xc,%esp
8010133b:	57                   	push   %edi
8010133c:	e8 e3 17 00 00       	call   80102b24 <log_write>
80101341:	83 c4 10             	add    $0x10,%esp
80101344:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101347:	eb c7                	jmp    80101310 <bmap+0x40>
80101349:	8d 76 00             	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
8010134c:	8b 06                	mov    (%esi),%eax
8010134e:	e8 a5 fd ff ff       	call   801010f8 <balloc>
80101353:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101359:	eb 9b                	jmp    801012f6 <bmap+0x26>
8010135b:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
8010135c:	8d 5a 14             	lea    0x14(%edx),%ebx
8010135f:	8b 44 98 0c          	mov    0xc(%eax,%ebx,4),%eax
80101363:	85 c0                	test   %eax,%eax
80101365:	75 bb                	jne    80101322 <bmap+0x52>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101367:	8b 06                	mov    (%esi),%eax
80101369:	e8 8a fd ff ff       	call   801010f8 <balloc>
8010136e:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
}
80101372:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101375:	5b                   	pop    %ebx
80101376:	5e                   	pop    %esi
80101377:	5f                   	pop    %edi
80101378:	5d                   	pop    %ebp
80101379:	c3                   	ret    
  panic("bmap: out of range");
8010137a:	83 ec 0c             	sub    $0xc,%esp
8010137d:	68 b8 69 10 80       	push   $0x801069b8
80101382:	e8 b1 ef ff ff       	call   80100338 <panic>
80101387:	90                   	nop

80101388 <readsb>:
{
80101388:	55                   	push   %ebp
80101389:	89 e5                	mov    %esp,%ebp
8010138b:	56                   	push   %esi
8010138c:	53                   	push   %ebx
8010138d:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101390:	83 ec 08             	sub    $0x8,%esp
80101393:	6a 01                	push   $0x1
80101395:	ff 75 08             	push   0x8(%ebp)
80101398:	e8 17 ed ff ff       	call   801000b4 <bread>
8010139d:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010139f:	83 c4 0c             	add    $0xc,%esp
801013a2:	6a 1c                	push   $0x1c
801013a4:	8d 40 5c             	lea    0x5c(%eax),%eax
801013a7:	50                   	push   %eax
801013a8:	56                   	push   %esi
801013a9:	e8 be 2d 00 00       	call   8010416c <memmove>
  brelse(bp);
801013ae:	83 c4 10             	add    $0x10,%esp
801013b1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801013b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013b7:	5b                   	pop    %ebx
801013b8:	5e                   	pop    %esi
801013b9:	5d                   	pop    %ebp
  brelse(bp);
801013ba:	e9 fd ed ff ff       	jmp    801001bc <brelse>
801013bf:	90                   	nop

801013c0 <iinit>:
{
801013c0:	55                   	push   %ebp
801013c1:	89 e5                	mov    %esp,%ebp
801013c3:	53                   	push   %ebx
801013c4:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801013c7:	68 cb 69 10 80       	push   $0x801069cb
801013cc:	68 60 f9 10 80       	push   $0x8010f960
801013d1:	e8 b2 2a 00 00       	call   80103e88 <initlock>
  for(i = 0; i < NINODE; i++) {
801013d6:	bb a0 f9 10 80       	mov    $0x8010f9a0,%ebx
801013db:	83 c4 10             	add    $0x10,%esp
801013de:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801013e0:	83 ec 08             	sub    $0x8,%esp
801013e3:	68 d2 69 10 80       	push   $0x801069d2
801013e8:	53                   	push   %ebx
801013e9:	e8 8a 29 00 00       	call   80103d78 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801013ee:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013f4:	83 c4 10             	add    $0x10,%esp
801013f7:	81 fb c0 15 11 80    	cmp    $0x801115c0,%ebx
801013fd:	75 e1                	jne    801013e0 <iinit+0x20>
  bp = bread(dev, 1);
801013ff:	83 ec 08             	sub    $0x8,%esp
80101402:	6a 01                	push   $0x1
80101404:	ff 75 08             	push   0x8(%ebp)
80101407:	e8 a8 ec ff ff       	call   801000b4 <bread>
8010140c:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010140e:	83 c4 0c             	add    $0xc,%esp
80101411:	6a 1c                	push   $0x1c
80101413:	8d 40 5c             	lea    0x5c(%eax),%eax
80101416:	50                   	push   %eax
80101417:	68 b4 15 11 80       	push   $0x801115b4
8010141c:	e8 4b 2d 00 00       	call   8010416c <memmove>
  brelse(bp);
80101421:	89 1c 24             	mov    %ebx,(%esp)
80101424:	e8 93 ed ff ff       	call   801001bc <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101429:	ff 35 cc 15 11 80    	push   0x801115cc
8010142f:	ff 35 c8 15 11 80    	push   0x801115c8
80101435:	ff 35 c4 15 11 80    	push   0x801115c4
8010143b:	ff 35 c0 15 11 80    	push   0x801115c0
80101441:	ff 35 bc 15 11 80    	push   0x801115bc
80101447:	ff 35 b8 15 11 80    	push   0x801115b8
8010144d:	ff 35 b4 15 11 80    	push   0x801115b4
80101453:	68 38 6a 10 80       	push   $0x80106a38
80101458:	e8 bf f1 ff ff       	call   8010061c <cprintf>
}
8010145d:	83 c4 30             	add    $0x30,%esp
80101460:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101463:	c9                   	leave  
80101464:	c3                   	ret    
80101465:	8d 76 00             	lea    0x0(%esi),%esi

80101468 <ialloc>:
{
80101468:	55                   	push   %ebp
80101469:	89 e5                	mov    %esp,%ebp
8010146b:	57                   	push   %edi
8010146c:	56                   	push   %esi
8010146d:	53                   	push   %ebx
8010146e:	83 ec 1c             	sub    $0x1c,%esp
80101471:	8b 75 08             	mov    0x8(%ebp),%esi
80101474:	8b 45 0c             	mov    0xc(%ebp),%eax
80101477:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
8010147a:	83 3d bc 15 11 80 01 	cmpl   $0x1,0x801115bc
80101481:	0f 86 84 00 00 00    	jbe    8010150b <ialloc+0xa3>
80101487:	bf 01 00 00 00       	mov    $0x1,%edi
8010148c:	eb 17                	jmp    801014a5 <ialloc+0x3d>
8010148e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101490:	83 ec 0c             	sub    $0xc,%esp
80101493:	53                   	push   %ebx
80101494:	e8 23 ed ff ff       	call   801001bc <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101499:	47                   	inc    %edi
8010149a:	83 c4 10             	add    $0x10,%esp
8010149d:	3b 3d bc 15 11 80    	cmp    0x801115bc,%edi
801014a3:	73 66                	jae    8010150b <ialloc+0xa3>
    bp = bread(dev, IBLOCK(inum, sb));
801014a5:	83 ec 08             	sub    $0x8,%esp
801014a8:	89 f8                	mov    %edi,%eax
801014aa:	c1 e8 03             	shr    $0x3,%eax
801014ad:	03 05 c8 15 11 80    	add    0x801115c8,%eax
801014b3:	50                   	push   %eax
801014b4:	56                   	push   %esi
801014b5:	e8 fa eb ff ff       	call   801000b4 <bread>
801014ba:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801014bc:	89 f8                	mov    %edi,%eax
801014be:	83 e0 07             	and    $0x7,%eax
801014c1:	c1 e0 06             	shl    $0x6,%eax
801014c4:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801014c8:	83 c4 10             	add    $0x10,%esp
801014cb:	66 83 39 00          	cmpw   $0x0,(%ecx)
801014cf:	75 bf                	jne    80101490 <ialloc+0x28>
      memset(dip, 0, sizeof(*dip));
801014d1:	50                   	push   %eax
801014d2:	6a 40                	push   $0x40
801014d4:	6a 00                	push   $0x0
801014d6:	51                   	push   %ecx
801014d7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801014da:	e8 09 2c 00 00       	call   801040e8 <memset>
      dip->type = type;
801014df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801014e2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801014e5:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801014e8:	89 1c 24             	mov    %ebx,(%esp)
801014eb:	e8 34 16 00 00       	call   80102b24 <log_write>
      brelse(bp);
801014f0:	89 1c 24             	mov    %ebx,(%esp)
801014f3:	e8 c4 ec ff ff       	call   801001bc <brelse>
      return iget(dev, inum);
801014f8:	83 c4 10             	add    $0x10,%esp
801014fb:	89 fa                	mov    %edi,%edx
801014fd:	89 f0                	mov    %esi,%eax
}
801014ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101502:	5b                   	pop    %ebx
80101503:	5e                   	pop    %esi
80101504:	5f                   	pop    %edi
80101505:	5d                   	pop    %ebp
      return iget(dev, inum);
80101506:	e9 e5 fc ff ff       	jmp    801011f0 <iget>
  panic("ialloc: no inodes");
8010150b:	83 ec 0c             	sub    $0xc,%esp
8010150e:	68 d8 69 10 80       	push   $0x801069d8
80101513:	e8 20 ee ff ff       	call   80100338 <panic>

80101518 <iupdate>:
{
80101518:	55                   	push   %ebp
80101519:	89 e5                	mov    %esp,%ebp
8010151b:	56                   	push   %esi
8010151c:	53                   	push   %ebx
8010151d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101520:	83 ec 08             	sub    $0x8,%esp
80101523:	8b 43 04             	mov    0x4(%ebx),%eax
80101526:	c1 e8 03             	shr    $0x3,%eax
80101529:	03 05 c8 15 11 80    	add    0x801115c8,%eax
8010152f:	50                   	push   %eax
80101530:	ff 33                	push   (%ebx)
80101532:	e8 7d eb ff ff       	call   801000b4 <bread>
80101537:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101539:	8b 43 04             	mov    0x4(%ebx),%eax
8010153c:	83 e0 07             	and    $0x7,%eax
8010153f:	c1 e0 06             	shl    $0x6,%eax
80101542:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101546:	8b 53 50             	mov    0x50(%ebx),%edx
80101549:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010154c:	66 8b 53 52          	mov    0x52(%ebx),%dx
80101550:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101554:	8b 53 54             	mov    0x54(%ebx),%edx
80101557:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
8010155b:	66 8b 53 56          	mov    0x56(%ebx),%dx
8010155f:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101563:	8b 53 58             	mov    0x58(%ebx),%edx
80101566:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101569:	83 c4 0c             	add    $0xc,%esp
8010156c:	6a 34                	push   $0x34
8010156e:	83 c3 5c             	add    $0x5c,%ebx
80101571:	53                   	push   %ebx
80101572:	83 c0 0c             	add    $0xc,%eax
80101575:	50                   	push   %eax
80101576:	e8 f1 2b 00 00       	call   8010416c <memmove>
  log_write(bp);
8010157b:	89 34 24             	mov    %esi,(%esp)
8010157e:	e8 a1 15 00 00       	call   80102b24 <log_write>
  brelse(bp);
80101583:	83 c4 10             	add    $0x10,%esp
80101586:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101589:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010158c:	5b                   	pop    %ebx
8010158d:	5e                   	pop    %esi
8010158e:	5d                   	pop    %ebp
  brelse(bp);
8010158f:	e9 28 ec ff ff       	jmp    801001bc <brelse>

80101594 <idup>:
{
80101594:	55                   	push   %ebp
80101595:	89 e5                	mov    %esp,%ebp
80101597:	53                   	push   %ebx
80101598:	83 ec 10             	sub    $0x10,%esp
8010159b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010159e:	68 60 f9 10 80       	push   $0x8010f960
801015a3:	e8 98 2a 00 00       	call   80104040 <acquire>
  ip->ref++;
801015a8:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801015ab:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
801015b2:	e8 29 2a 00 00       	call   80103fe0 <release>
}
801015b7:	89 d8                	mov    %ebx,%eax
801015b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015bc:	c9                   	leave  
801015bd:	c3                   	ret    
801015be:	66 90                	xchg   %ax,%ax

801015c0 <ilock>:
{
801015c0:	55                   	push   %ebp
801015c1:	89 e5                	mov    %esp,%ebp
801015c3:	56                   	push   %esi
801015c4:	53                   	push   %ebx
801015c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801015c8:	85 db                	test   %ebx,%ebx
801015ca:	0f 84 a9 00 00 00    	je     80101679 <ilock+0xb9>
801015d0:	8b 53 08             	mov    0x8(%ebx),%edx
801015d3:	85 d2                	test   %edx,%edx
801015d5:	0f 8e 9e 00 00 00    	jle    80101679 <ilock+0xb9>
  acquiresleep(&ip->lock);
801015db:	83 ec 0c             	sub    $0xc,%esp
801015de:	8d 43 0c             	lea    0xc(%ebx),%eax
801015e1:	50                   	push   %eax
801015e2:	e8 c5 27 00 00       	call   80103dac <acquiresleep>
  if(ip->valid == 0){
801015e7:	83 c4 10             	add    $0x10,%esp
801015ea:	8b 43 4c             	mov    0x4c(%ebx),%eax
801015ed:	85 c0                	test   %eax,%eax
801015ef:	74 07                	je     801015f8 <ilock+0x38>
}
801015f1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015f4:	5b                   	pop    %ebx
801015f5:	5e                   	pop    %esi
801015f6:	5d                   	pop    %ebp
801015f7:	c3                   	ret    
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015f8:	83 ec 08             	sub    $0x8,%esp
801015fb:	8b 43 04             	mov    0x4(%ebx),%eax
801015fe:	c1 e8 03             	shr    $0x3,%eax
80101601:	03 05 c8 15 11 80    	add    0x801115c8,%eax
80101607:	50                   	push   %eax
80101608:	ff 33                	push   (%ebx)
8010160a:	e8 a5 ea ff ff       	call   801000b4 <bread>
8010160f:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101611:	8b 43 04             	mov    0x4(%ebx),%eax
80101614:	83 e0 07             	and    $0x7,%eax
80101617:	c1 e0 06             	shl    $0x6,%eax
8010161a:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
8010161e:	8b 10                	mov    (%eax),%edx
80101620:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101624:	66 8b 50 02          	mov    0x2(%eax),%dx
80101628:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010162c:	8b 50 04             	mov    0x4(%eax),%edx
8010162f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101633:	66 8b 50 06          	mov    0x6(%eax),%dx
80101637:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010163b:	8b 50 08             	mov    0x8(%eax),%edx
8010163e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101641:	83 c4 0c             	add    $0xc,%esp
80101644:	6a 34                	push   $0x34
80101646:	83 c0 0c             	add    $0xc,%eax
80101649:	50                   	push   %eax
8010164a:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010164d:	50                   	push   %eax
8010164e:	e8 19 2b 00 00       	call   8010416c <memmove>
    brelse(bp);
80101653:	89 34 24             	mov    %esi,(%esp)
80101656:	e8 61 eb ff ff       	call   801001bc <brelse>
    ip->valid = 1;
8010165b:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101662:	83 c4 10             	add    $0x10,%esp
80101665:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
8010166a:	75 85                	jne    801015f1 <ilock+0x31>
      panic("ilock: no type");
8010166c:	83 ec 0c             	sub    $0xc,%esp
8010166f:	68 f0 69 10 80       	push   $0x801069f0
80101674:	e8 bf ec ff ff       	call   80100338 <panic>
    panic("ilock");
80101679:	83 ec 0c             	sub    $0xc,%esp
8010167c:	68 ea 69 10 80       	push   $0x801069ea
80101681:	e8 b2 ec ff ff       	call   80100338 <panic>
80101686:	66 90                	xchg   %ax,%ax

80101688 <iunlock>:
{
80101688:	55                   	push   %ebp
80101689:	89 e5                	mov    %esp,%ebp
8010168b:	56                   	push   %esi
8010168c:	53                   	push   %ebx
8010168d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101690:	85 db                	test   %ebx,%ebx
80101692:	74 28                	je     801016bc <iunlock+0x34>
80101694:	8d 73 0c             	lea    0xc(%ebx),%esi
80101697:	83 ec 0c             	sub    $0xc,%esp
8010169a:	56                   	push   %esi
8010169b:	e8 9c 27 00 00       	call   80103e3c <holdingsleep>
801016a0:	83 c4 10             	add    $0x10,%esp
801016a3:	85 c0                	test   %eax,%eax
801016a5:	74 15                	je     801016bc <iunlock+0x34>
801016a7:	8b 43 08             	mov    0x8(%ebx),%eax
801016aa:	85 c0                	test   %eax,%eax
801016ac:	7e 0e                	jle    801016bc <iunlock+0x34>
  releasesleep(&ip->lock);
801016ae:	89 75 08             	mov    %esi,0x8(%ebp)
}
801016b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016b4:	5b                   	pop    %ebx
801016b5:	5e                   	pop    %esi
801016b6:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801016b7:	e9 44 27 00 00       	jmp    80103e00 <releasesleep>
    panic("iunlock");
801016bc:	83 ec 0c             	sub    $0xc,%esp
801016bf:	68 ff 69 10 80       	push   $0x801069ff
801016c4:	e8 6f ec ff ff       	call   80100338 <panic>
801016c9:	8d 76 00             	lea    0x0(%esi),%esi

801016cc <iput>:
{
801016cc:	55                   	push   %ebp
801016cd:	89 e5                	mov    %esp,%ebp
801016cf:	57                   	push   %edi
801016d0:	56                   	push   %esi
801016d1:	53                   	push   %ebx
801016d2:	83 ec 28             	sub    $0x28,%esp
801016d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801016d8:	8d 73 0c             	lea    0xc(%ebx),%esi
801016db:	56                   	push   %esi
801016dc:	e8 cb 26 00 00       	call   80103dac <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801016e1:	83 c4 10             	add    $0x10,%esp
801016e4:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016e7:	85 c0                	test   %eax,%eax
801016e9:	74 07                	je     801016f2 <iput+0x26>
801016eb:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801016f0:	74 2e                	je     80101720 <iput+0x54>
  releasesleep(&ip->lock);
801016f2:	83 ec 0c             	sub    $0xc,%esp
801016f5:	56                   	push   %esi
801016f6:	e8 05 27 00 00       	call   80103e00 <releasesleep>
  acquire(&icache.lock);
801016fb:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101702:	e8 39 29 00 00       	call   80104040 <acquire>
  ip->ref--;
80101707:	ff 4b 08             	decl   0x8(%ebx)
  release(&icache.lock);
8010170a:	83 c4 10             	add    $0x10,%esp
8010170d:	c7 45 08 60 f9 10 80 	movl   $0x8010f960,0x8(%ebp)
}
80101714:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101717:	5b                   	pop    %ebx
80101718:	5e                   	pop    %esi
80101719:	5f                   	pop    %edi
8010171a:	5d                   	pop    %ebp
  release(&icache.lock);
8010171b:	e9 c0 28 00 00       	jmp    80103fe0 <release>
    acquire(&icache.lock);
80101720:	83 ec 0c             	sub    $0xc,%esp
80101723:	68 60 f9 10 80       	push   $0x8010f960
80101728:	e8 13 29 00 00       	call   80104040 <acquire>
    int r = ip->ref;
8010172d:	8b 7b 08             	mov    0x8(%ebx),%edi
    release(&icache.lock);
80101730:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101737:	e8 a4 28 00 00       	call   80103fe0 <release>
    if(r == 1){
8010173c:	83 c4 10             	add    $0x10,%esp
8010173f:	4f                   	dec    %edi
80101740:	75 b0                	jne    801016f2 <iput+0x26>
80101742:	8d 7b 5c             	lea    0x5c(%ebx),%edi
80101745:	8d 83 8c 00 00 00    	lea    0x8c(%ebx),%eax
8010174b:	89 75 e4             	mov    %esi,-0x1c(%ebp)
8010174e:	89 fe                	mov    %edi,%esi
80101750:	89 c7                	mov    %eax,%edi
80101752:	eb 07                	jmp    8010175b <iput+0x8f>
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101754:	83 c6 04             	add    $0x4,%esi
80101757:	39 fe                	cmp    %edi,%esi
80101759:	74 15                	je     80101770 <iput+0xa4>
    if(ip->addrs[i]){
8010175b:	8b 16                	mov    (%esi),%edx
8010175d:	85 d2                	test   %edx,%edx
8010175f:	74 f3                	je     80101754 <iput+0x88>
      bfree(ip->dev, ip->addrs[i]);
80101761:	8b 03                	mov    (%ebx),%eax
80101763:	e8 1c f9 ff ff       	call   80101084 <bfree>
      ip->addrs[i] = 0;
80101768:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010176e:	eb e4                	jmp    80101754 <iput+0x88>
    }
  }

  if(ip->addrs[NDIRECT]){
80101770:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101773:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101779:	85 c0                	test   %eax,%eax
8010177b:	75 2d                	jne    801017aa <iput+0xde>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
8010177d:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101784:	83 ec 0c             	sub    $0xc,%esp
80101787:	53                   	push   %ebx
80101788:	e8 8b fd ff ff       	call   80101518 <iupdate>
      ip->type = 0;
8010178d:	66 c7 43 50 00 00    	movw   $0x0,0x50(%ebx)
      iupdate(ip);
80101793:	89 1c 24             	mov    %ebx,(%esp)
80101796:	e8 7d fd ff ff       	call   80101518 <iupdate>
      ip->valid = 0;
8010179b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801017a2:	83 c4 10             	add    $0x10,%esp
801017a5:	e9 48 ff ff ff       	jmp    801016f2 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801017aa:	83 ec 08             	sub    $0x8,%esp
801017ad:	50                   	push   %eax
801017ae:	ff 33                	push   (%ebx)
801017b0:	e8 ff e8 ff ff       	call   801000b4 <bread>
801017b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801017b8:	8d 78 5c             	lea    0x5c(%eax),%edi
801017bb:	05 5c 02 00 00       	add    $0x25c,%eax
801017c0:	83 c4 10             	add    $0x10,%esp
801017c3:	89 75 e0             	mov    %esi,-0x20(%ebp)
801017c6:	89 fe                	mov    %edi,%esi
801017c8:	89 c7                	mov    %eax,%edi
801017ca:	eb 07                	jmp    801017d3 <iput+0x107>
801017cc:	83 c6 04             	add    $0x4,%esi
801017cf:	39 f7                	cmp    %esi,%edi
801017d1:	74 0f                	je     801017e2 <iput+0x116>
      if(a[j])
801017d3:	8b 16                	mov    (%esi),%edx
801017d5:	85 d2                	test   %edx,%edx
801017d7:	74 f3                	je     801017cc <iput+0x100>
        bfree(ip->dev, a[j]);
801017d9:	8b 03                	mov    (%ebx),%eax
801017db:	e8 a4 f8 ff ff       	call   80101084 <bfree>
801017e0:	eb ea                	jmp    801017cc <iput+0x100>
    brelse(bp);
801017e2:	8b 75 e0             	mov    -0x20(%ebp),%esi
801017e5:	83 ec 0c             	sub    $0xc,%esp
801017e8:	ff 75 e4             	push   -0x1c(%ebp)
801017eb:	e8 cc e9 ff ff       	call   801001bc <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801017f0:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801017f6:	8b 03                	mov    (%ebx),%eax
801017f8:	e8 87 f8 ff ff       	call   80101084 <bfree>
    ip->addrs[NDIRECT] = 0;
801017fd:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101804:	00 00 00 
80101807:	83 c4 10             	add    $0x10,%esp
8010180a:	e9 6e ff ff ff       	jmp    8010177d <iput+0xb1>
8010180f:	90                   	nop

80101810 <iunlockput>:
{
80101810:	55                   	push   %ebp
80101811:	89 e5                	mov    %esp,%ebp
80101813:	56                   	push   %esi
80101814:	53                   	push   %ebx
80101815:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101818:	85 db                	test   %ebx,%ebx
8010181a:	74 34                	je     80101850 <iunlockput+0x40>
8010181c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010181f:	83 ec 0c             	sub    $0xc,%esp
80101822:	56                   	push   %esi
80101823:	e8 14 26 00 00       	call   80103e3c <holdingsleep>
80101828:	83 c4 10             	add    $0x10,%esp
8010182b:	85 c0                	test   %eax,%eax
8010182d:	74 21                	je     80101850 <iunlockput+0x40>
8010182f:	8b 43 08             	mov    0x8(%ebx),%eax
80101832:	85 c0                	test   %eax,%eax
80101834:	7e 1a                	jle    80101850 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101836:	83 ec 0c             	sub    $0xc,%esp
80101839:	56                   	push   %esi
8010183a:	e8 c1 25 00 00       	call   80103e00 <releasesleep>
  iput(ip);
8010183f:	83 c4 10             	add    $0x10,%esp
80101842:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101845:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101848:	5b                   	pop    %ebx
80101849:	5e                   	pop    %esi
8010184a:	5d                   	pop    %ebp
  iput(ip);
8010184b:	e9 7c fe ff ff       	jmp    801016cc <iput>
    panic("iunlock");
80101850:	83 ec 0c             	sub    $0xc,%esp
80101853:	68 ff 69 10 80       	push   $0x801069ff
80101858:	e8 db ea ff ff       	call   80100338 <panic>
8010185d:	8d 76 00             	lea    0x0(%esi),%esi

80101860 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	8b 55 08             	mov    0x8(%ebp),%edx
80101866:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101869:	8b 0a                	mov    (%edx),%ecx
8010186b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010186e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101871:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101874:	8b 4a 50             	mov    0x50(%edx),%ecx
80101877:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010187a:	66 8b 4a 56          	mov    0x56(%edx),%cx
8010187e:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101882:	8b 52 58             	mov    0x58(%edx),%edx
80101885:	89 50 10             	mov    %edx,0x10(%eax)
}
80101888:	5d                   	pop    %ebp
80101889:	c3                   	ret    
8010188a:	66 90                	xchg   %ax,%ax

8010188c <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
8010188c:	55                   	push   %ebp
8010188d:	89 e5                	mov    %esp,%ebp
8010188f:	57                   	push   %edi
80101890:	56                   	push   %esi
80101891:	53                   	push   %ebx
80101892:	83 ec 1c             	sub    $0x1c,%esp
80101895:	8b 7d 08             	mov    0x8(%ebp),%edi
80101898:	8b 45 0c             	mov    0xc(%ebp),%eax
8010189b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010189e:	8b 45 10             	mov    0x10(%ebp),%eax
801018a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
801018a4:	8b 45 14             	mov    0x14(%ebp),%eax
801018a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801018aa:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
801018af:	0f 84 a3 00 00 00    	je     80101958 <readi+0xcc>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801018b5:	8b 47 58             	mov    0x58(%edi),%eax
801018b8:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801018bb:	39 c3                	cmp    %eax,%ebx
801018bd:	0f 87 b9 00 00 00    	ja     8010197c <readi+0xf0>
801018c3:	89 da                	mov    %ebx,%edx
801018c5:	31 c9                	xor    %ecx,%ecx
801018c7:	03 55 e4             	add    -0x1c(%ebp),%edx
801018ca:	0f 92 c1             	setb   %cl
801018cd:	89 ce                	mov    %ecx,%esi
801018cf:	0f 82 a7 00 00 00    	jb     8010197c <readi+0xf0>
    return -1;
  if(off + n > ip->size)
801018d5:	39 d0                	cmp    %edx,%eax
801018d7:	72 77                	jb     80101950 <readi+0xc4>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801018d9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801018dc:	85 db                	test   %ebx,%ebx
801018de:	74 65                	je     80101945 <readi+0xb9>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801018e0:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801018e3:	89 da                	mov    %ebx,%edx
801018e5:	c1 ea 09             	shr    $0x9,%edx
801018e8:	89 f8                	mov    %edi,%eax
801018ea:	e8 e1 f9 ff ff       	call   801012d0 <bmap>
801018ef:	83 ec 08             	sub    $0x8,%esp
801018f2:	50                   	push   %eax
801018f3:	ff 37                	push   (%edi)
801018f5:	e8 ba e7 ff ff       	call   801000b4 <bread>
801018fa:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801018fc:	89 d8                	mov    %ebx,%eax
801018fe:	25 ff 01 00 00       	and    $0x1ff,%eax
80101903:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101906:	29 f1                	sub    %esi,%ecx
80101908:	bb 00 02 00 00       	mov    $0x200,%ebx
8010190d:	29 c3                	sub    %eax,%ebx
8010190f:	83 c4 10             	add    $0x10,%esp
80101912:	39 cb                	cmp    %ecx,%ebx
80101914:	76 02                	jbe    80101918 <readi+0x8c>
80101916:	89 cb                	mov    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101918:	51                   	push   %ecx
80101919:	53                   	push   %ebx
8010191a:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
8010191e:	89 55 d8             	mov    %edx,-0x28(%ebp)
80101921:	50                   	push   %eax
80101922:	ff 75 dc             	push   -0x24(%ebp)
80101925:	e8 42 28 00 00       	call   8010416c <memmove>
    brelse(bp);
8010192a:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010192d:	89 14 24             	mov    %edx,(%esp)
80101930:	e8 87 e8 ff ff       	call   801001bc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101935:	01 de                	add    %ebx,%esi
80101937:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010193a:	01 5d dc             	add    %ebx,-0x24(%ebp)
8010193d:	83 c4 10             	add    $0x10,%esp
80101940:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101943:	77 9b                	ja     801018e0 <readi+0x54>
  }
  return n;
80101945:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101948:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010194b:	5b                   	pop    %ebx
8010194c:	5e                   	pop    %esi
8010194d:	5f                   	pop    %edi
8010194e:	5d                   	pop    %ebp
8010194f:	c3                   	ret    
    n = ip->size - off;
80101950:	29 d8                	sub    %ebx,%eax
80101952:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101955:	eb 82                	jmp    801018d9 <readi+0x4d>
80101957:	90                   	nop
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101958:	0f bf 47 52          	movswl 0x52(%edi),%eax
8010195c:	66 83 f8 09          	cmp    $0x9,%ax
80101960:	77 1a                	ja     8010197c <readi+0xf0>
80101962:	8b 04 c5 00 f9 10 80 	mov    -0x7fef0700(,%eax,8),%eax
80101969:	85 c0                	test   %eax,%eax
8010196b:	74 0f                	je     8010197c <readi+0xf0>
    return devsw[ip->major].read(ip, dst, n);
8010196d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101970:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101973:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101976:	5b                   	pop    %ebx
80101977:	5e                   	pop    %esi
80101978:	5f                   	pop    %edi
80101979:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010197a:	ff e0                	jmp    *%eax
      return -1;
8010197c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101981:	eb c5                	jmp    80101948 <readi+0xbc>
80101983:	90                   	nop

80101984 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101984:	55                   	push   %ebp
80101985:	89 e5                	mov    %esp,%ebp
80101987:	57                   	push   %edi
80101988:	56                   	push   %esi
80101989:	53                   	push   %ebx
8010198a:	83 ec 1c             	sub    $0x1c,%esp
8010198d:	8b 45 08             	mov    0x8(%ebp),%eax
80101990:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101993:	8b 75 0c             	mov    0xc(%ebp),%esi
80101996:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101999:	8b 75 10             	mov    0x10(%ebp),%esi
8010199c:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010199f:	8b 75 14             	mov    0x14(%ebp),%esi
801019a2:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019a5:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
801019aa:	0f 84 b0 00 00 00    	je     80101a60 <writei+0xdc>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801019b0:	8b 75 d8             	mov    -0x28(%ebp),%esi
801019b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801019b6:	3b 46 58             	cmp    0x58(%esi),%eax
801019b9:	0f 87 dc 00 00 00    	ja     80101a9b <writei+0x117>
801019bf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801019c2:	31 c9                	xor    %ecx,%ecx
801019c4:	01 d0                	add    %edx,%eax
801019c6:	0f 92 c1             	setb   %cl
801019c9:	89 ce                	mov    %ecx,%esi
801019cb:	0f 82 ca 00 00 00    	jb     80101a9b <writei+0x117>
    return -1;
  if(off + n > MAXFILE*BSIZE)
801019d1:	3d 00 18 01 00       	cmp    $0x11800,%eax
801019d6:	0f 87 bf 00 00 00    	ja     80101a9b <writei+0x117>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801019dc:	85 d2                	test   %edx,%edx
801019de:	74 75                	je     80101a55 <writei+0xd1>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019e0:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801019e3:	89 da                	mov    %ebx,%edx
801019e5:	c1 ea 09             	shr    $0x9,%edx
801019e8:	8b 7d d8             	mov    -0x28(%ebp),%edi
801019eb:	89 f8                	mov    %edi,%eax
801019ed:	e8 de f8 ff ff       	call   801012d0 <bmap>
801019f2:	83 ec 08             	sub    $0x8,%esp
801019f5:	50                   	push   %eax
801019f6:	ff 37                	push   (%edi)
801019f8:	e8 b7 e6 ff ff       	call   801000b4 <bread>
801019fd:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
801019ff:	89 d8                	mov    %ebx,%eax
80101a01:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a06:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101a09:	29 f1                	sub    %esi,%ecx
80101a0b:	bb 00 02 00 00       	mov    $0x200,%ebx
80101a10:	29 c3                	sub    %eax,%ebx
80101a12:	83 c4 10             	add    $0x10,%esp
80101a15:	39 cb                	cmp    %ecx,%ebx
80101a17:	76 02                	jbe    80101a1b <writei+0x97>
80101a19:	89 cb                	mov    %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101a1b:	52                   	push   %edx
80101a1c:	53                   	push   %ebx
80101a1d:	ff 75 dc             	push   -0x24(%ebp)
80101a20:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
80101a24:	50                   	push   %eax
80101a25:	e8 42 27 00 00       	call   8010416c <memmove>
    log_write(bp);
80101a2a:	89 3c 24             	mov    %edi,(%esp)
80101a2d:	e8 f2 10 00 00       	call   80102b24 <log_write>
    brelse(bp);
80101a32:	89 3c 24             	mov    %edi,(%esp)
80101a35:	e8 82 e7 ff ff       	call   801001bc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a3a:	01 de                	add    %ebx,%esi
80101a3c:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a3f:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101a42:	83 c4 10             	add    $0x10,%esp
80101a45:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101a48:	77 96                	ja     801019e0 <writei+0x5c>
  }

  if(n > 0 && off > ip->size){
80101a4a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a4d:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101a50:	3b 70 58             	cmp    0x58(%eax),%esi
80101a53:	77 2f                	ja     80101a84 <writei+0x100>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101a55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a5b:	5b                   	pop    %ebx
80101a5c:	5e                   	pop    %esi
80101a5d:	5f                   	pop    %edi
80101a5e:	5d                   	pop    %ebp
80101a5f:	c3                   	ret    
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101a60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a64:	66 83 f8 09          	cmp    $0x9,%ax
80101a68:	77 31                	ja     80101a9b <writei+0x117>
80101a6a:	8b 04 c5 04 f9 10 80 	mov    -0x7fef06fc(,%eax,8),%eax
80101a71:	85 c0                	test   %eax,%eax
80101a73:	74 26                	je     80101a9b <writei+0x117>
    return devsw[ip->major].write(ip, src, n);
80101a75:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101a78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a7b:	5b                   	pop    %ebx
80101a7c:	5e                   	pop    %esi
80101a7d:	5f                   	pop    %edi
80101a7e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101a7f:	ff e0                	jmp    *%eax
80101a81:	8d 76 00             	lea    0x0(%esi),%esi
    ip->size = off;
80101a84:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a87:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101a8a:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101a8d:	83 ec 0c             	sub    $0xc,%esp
80101a90:	50                   	push   %eax
80101a91:	e8 82 fa ff ff       	call   80101518 <iupdate>
80101a96:	83 c4 10             	add    $0x10,%esp
80101a99:	eb ba                	jmp    80101a55 <writei+0xd1>
      return -1;
80101a9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101aa0:	eb b6                	jmp    80101a58 <writei+0xd4>
80101aa2:	66 90                	xchg   %ax,%ax

80101aa4 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101aa4:	55                   	push   %ebp
80101aa5:	89 e5                	mov    %esp,%ebp
80101aa7:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101aaa:	6a 0e                	push   $0xe
80101aac:	ff 75 0c             	push   0xc(%ebp)
80101aaf:	ff 75 08             	push   0x8(%ebp)
80101ab2:	e8 05 27 00 00       	call   801041bc <strncmp>
}
80101ab7:	c9                   	leave  
80101ab8:	c3                   	ret    
80101ab9:	8d 76 00             	lea    0x0(%esi),%esi

80101abc <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101abc:	55                   	push   %ebp
80101abd:	89 e5                	mov    %esp,%ebp
80101abf:	57                   	push   %edi
80101ac0:	56                   	push   %esi
80101ac1:	53                   	push   %ebx
80101ac2:	83 ec 1c             	sub    $0x1c,%esp
80101ac5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101ac8:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101acd:	75 7d                	jne    80101b4c <dirlookup+0x90>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101acf:	8b 4b 58             	mov    0x58(%ebx),%ecx
80101ad2:	85 c9                	test   %ecx,%ecx
80101ad4:	74 3d                	je     80101b13 <dirlookup+0x57>
80101ad6:	31 ff                	xor    %edi,%edi
80101ad8:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101adb:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101adc:	6a 10                	push   $0x10
80101ade:	57                   	push   %edi
80101adf:	56                   	push   %esi
80101ae0:	53                   	push   %ebx
80101ae1:	e8 a6 fd ff ff       	call   8010188c <readi>
80101ae6:	83 c4 10             	add    $0x10,%esp
80101ae9:	83 f8 10             	cmp    $0x10,%eax
80101aec:	75 51                	jne    80101b3f <dirlookup+0x83>
      panic("dirlookup read");
    if(de.inum == 0)
80101aee:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101af3:	74 16                	je     80101b0b <dirlookup+0x4f>
  return strncmp(s, t, DIRSIZ);
80101af5:	52                   	push   %edx
80101af6:	6a 0e                	push   $0xe
80101af8:	8d 45 da             	lea    -0x26(%ebp),%eax
80101afb:	50                   	push   %eax
80101afc:	ff 75 0c             	push   0xc(%ebp)
80101aff:	e8 b8 26 00 00       	call   801041bc <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101b04:	83 c4 10             	add    $0x10,%esp
80101b07:	85 c0                	test   %eax,%eax
80101b09:	74 15                	je     80101b20 <dirlookup+0x64>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101b0b:	83 c7 10             	add    $0x10,%edi
80101b0e:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101b11:	72 c9                	jb     80101adc <dirlookup+0x20>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101b13:	31 c0                	xor    %eax,%eax
}
80101b15:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b18:	5b                   	pop    %ebx
80101b19:	5e                   	pop    %esi
80101b1a:	5f                   	pop    %edi
80101b1b:	5d                   	pop    %ebp
80101b1c:	c3                   	ret    
80101b1d:	8d 76 00             	lea    0x0(%esi),%esi
      if(poff)
80101b20:	8b 45 10             	mov    0x10(%ebp),%eax
80101b23:	85 c0                	test   %eax,%eax
80101b25:	74 05                	je     80101b2c <dirlookup+0x70>
        *poff = off;
80101b27:	8b 45 10             	mov    0x10(%ebp),%eax
80101b2a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101b2c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101b30:	8b 03                	mov    (%ebx),%eax
80101b32:	e8 b9 f6 ff ff       	call   801011f0 <iget>
}
80101b37:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b3a:	5b                   	pop    %ebx
80101b3b:	5e                   	pop    %esi
80101b3c:	5f                   	pop    %edi
80101b3d:	5d                   	pop    %ebp
80101b3e:	c3                   	ret    
      panic("dirlookup read");
80101b3f:	83 ec 0c             	sub    $0xc,%esp
80101b42:	68 19 6a 10 80       	push   $0x80106a19
80101b47:	e8 ec e7 ff ff       	call   80100338 <panic>
    panic("dirlookup not DIR");
80101b4c:	83 ec 0c             	sub    $0xc,%esp
80101b4f:	68 07 6a 10 80       	push   $0x80106a07
80101b54:	e8 df e7 ff ff       	call   80100338 <panic>
80101b59:	8d 76 00             	lea    0x0(%esi),%esi

80101b5c <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101b5c:	55                   	push   %ebp
80101b5d:	89 e5                	mov    %esp,%ebp
80101b5f:	57                   	push   %edi
80101b60:	56                   	push   %esi
80101b61:	53                   	push   %ebx
80101b62:	83 ec 1c             	sub    $0x1c,%esp
80101b65:	89 c3                	mov    %eax,%ebx
80101b67:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101b6a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101b6d:	80 38 2f             	cmpb   $0x2f,(%eax)
80101b70:	0f 84 42 01 00 00    	je     80101cb8 <namex+0x15c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101b76:	e8 31 19 00 00       	call   801034ac <myproc>
80101b7b:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101b7e:	83 ec 0c             	sub    $0xc,%esp
80101b81:	68 60 f9 10 80       	push   $0x8010f960
80101b86:	e8 b5 24 00 00       	call   80104040 <acquire>
  ip->ref++;
80101b8b:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101b8e:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101b95:	e8 46 24 00 00       	call   80103fe0 <release>
80101b9a:	83 c4 10             	add    $0x10,%esp
80101b9d:	eb 02                	jmp    80101ba1 <namex+0x45>
80101b9f:	90                   	nop
    path++;
80101ba0:	43                   	inc    %ebx
  while(*path == '/')
80101ba1:	8a 03                	mov    (%ebx),%al
80101ba3:	3c 2f                	cmp    $0x2f,%al
80101ba5:	74 f9                	je     80101ba0 <namex+0x44>
  if(*path == 0)
80101ba7:	84 c0                	test   %al,%al
80101ba9:	0f 84 ed 00 00 00    	je     80101c9c <namex+0x140>
  while(*path != '/' && *path != 0)
80101baf:	8a 03                	mov    (%ebx),%al
80101bb1:	89 df                	mov    %ebx,%edi
80101bb3:	3c 2f                	cmp    $0x2f,%al
80101bb5:	75 0c                	jne    80101bc3 <namex+0x67>
80101bb7:	e9 f5 00 00 00       	jmp    80101cb1 <namex+0x155>
    path++;
80101bbc:	47                   	inc    %edi
  while(*path != '/' && *path != 0)
80101bbd:	8a 07                	mov    (%edi),%al
80101bbf:	3c 2f                	cmp    $0x2f,%al
80101bc1:	74 04                	je     80101bc7 <namex+0x6b>
80101bc3:	84 c0                	test   %al,%al
80101bc5:	75 f5                	jne    80101bbc <namex+0x60>
  len = path - s;
80101bc7:	89 f8                	mov    %edi,%eax
80101bc9:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101bcb:	83 f8 0d             	cmp    $0xd,%eax
80101bce:	0f 8e a4 00 00 00    	jle    80101c78 <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101bd4:	51                   	push   %ecx
80101bd5:	6a 0e                	push   $0xe
80101bd7:	53                   	push   %ebx
80101bd8:	ff 75 e4             	push   -0x1c(%ebp)
80101bdb:	e8 8c 25 00 00       	call   8010416c <memmove>
80101be0:	83 c4 10             	add    $0x10,%esp
80101be3:	89 fb                	mov    %edi,%ebx
  while(*path == '/')
80101be5:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101be8:	75 08                	jne    80101bf2 <namex+0x96>
80101bea:	66 90                	xchg   %ax,%ax
    path++;
80101bec:	43                   	inc    %ebx
  while(*path == '/')
80101bed:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101bf0:	74 fa                	je     80101bec <namex+0x90>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101bf2:	83 ec 0c             	sub    $0xc,%esp
80101bf5:	56                   	push   %esi
80101bf6:	e8 c5 f9 ff ff       	call   801015c0 <ilock>
    if(ip->type != T_DIR){
80101bfb:	83 c4 10             	add    $0x10,%esp
80101bfe:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101c03:	0f 85 c5 00 00 00    	jne    80101cce <namex+0x172>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101c09:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101c0c:	85 c0                	test   %eax,%eax
80101c0e:	74 09                	je     80101c19 <namex+0xbd>
80101c10:	80 3b 00             	cmpb   $0x0,(%ebx)
80101c13:	0f 84 1a 01 00 00    	je     80101d33 <namex+0x1d7>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101c19:	50                   	push   %eax
80101c1a:	6a 00                	push   $0x0
80101c1c:	ff 75 e4             	push   -0x1c(%ebp)
80101c1f:	56                   	push   %esi
80101c20:	e8 97 fe ff ff       	call   80101abc <dirlookup>
80101c25:	89 c7                	mov    %eax,%edi
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101c27:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101c2a:	83 c4 10             	add    $0x10,%esp
80101c2d:	85 c0                	test   %eax,%eax
80101c2f:	0f 84 db 00 00 00    	je     80101d10 <namex+0x1b4>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101c35:	83 ec 0c             	sub    $0xc,%esp
80101c38:	52                   	push   %edx
80101c39:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101c3c:	e8 fb 21 00 00       	call   80103e3c <holdingsleep>
80101c41:	83 c4 10             	add    $0x10,%esp
80101c44:	85 c0                	test   %eax,%eax
80101c46:	0f 84 2a 01 00 00    	je     80101d76 <namex+0x21a>
80101c4c:	8b 46 08             	mov    0x8(%esi),%eax
80101c4f:	85 c0                	test   %eax,%eax
80101c51:	0f 8e 1f 01 00 00    	jle    80101d76 <namex+0x21a>
  releasesleep(&ip->lock);
80101c57:	83 ec 0c             	sub    $0xc,%esp
80101c5a:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101c5d:	52                   	push   %edx
80101c5e:	e8 9d 21 00 00       	call   80103e00 <releasesleep>
  iput(ip);
80101c63:	89 34 24             	mov    %esi,(%esp)
80101c66:	e8 61 fa ff ff       	call   801016cc <iput>
80101c6b:	83 c4 10             	add    $0x10,%esp
80101c6e:	89 fe                	mov    %edi,%esi
  while(*path == '/')
80101c70:	e9 2c ff ff ff       	jmp    80101ba1 <namex+0x45>
80101c75:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101c78:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101c7b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
80101c7e:	89 55 e0             	mov    %edx,-0x20(%ebp)
    memmove(name, s, len);
80101c81:	52                   	push   %edx
80101c82:	50                   	push   %eax
80101c83:	53                   	push   %ebx
80101c84:	ff 75 e4             	push   -0x1c(%ebp)
80101c87:	e8 e0 24 00 00       	call   8010416c <memmove>
    name[len] = 0;
80101c8c:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101c8f:	c6 02 00             	movb   $0x0,(%edx)
80101c92:	83 c4 10             	add    $0x10,%esp
80101c95:	89 fb                	mov    %edi,%ebx
80101c97:	e9 49 ff ff ff       	jmp    80101be5 <namex+0x89>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101c9c:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101c9f:	85 db                	test   %ebx,%ebx
80101ca1:	0f 85 bc 00 00 00    	jne    80101d63 <namex+0x207>
    iput(ip);
    return 0;
  }
  return ip;
}
80101ca7:	89 f0                	mov    %esi,%eax
80101ca9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cac:	5b                   	pop    %ebx
80101cad:	5e                   	pop    %esi
80101cae:	5f                   	pop    %edi
80101caf:	5d                   	pop    %ebp
80101cb0:	c3                   	ret    
  while(*path != '/' && *path != 0)
80101cb1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101cb4:	31 c0                	xor    %eax,%eax
80101cb6:	eb c6                	jmp    80101c7e <namex+0x122>
    ip = iget(ROOTDEV, ROOTINO);
80101cb8:	ba 01 00 00 00       	mov    $0x1,%edx
80101cbd:	b8 01 00 00 00       	mov    $0x1,%eax
80101cc2:	e8 29 f5 ff ff       	call   801011f0 <iget>
80101cc7:	89 c6                	mov    %eax,%esi
80101cc9:	e9 d3 fe ff ff       	jmp    80101ba1 <namex+0x45>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101cce:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101cd1:	83 ec 0c             	sub    $0xc,%esp
80101cd4:	53                   	push   %ebx
80101cd5:	e8 62 21 00 00       	call   80103e3c <holdingsleep>
80101cda:	83 c4 10             	add    $0x10,%esp
80101cdd:	85 c0                	test   %eax,%eax
80101cdf:	0f 84 91 00 00 00    	je     80101d76 <namex+0x21a>
80101ce5:	8b 56 08             	mov    0x8(%esi),%edx
80101ce8:	85 d2                	test   %edx,%edx
80101cea:	0f 8e 86 00 00 00    	jle    80101d76 <namex+0x21a>
  releasesleep(&ip->lock);
80101cf0:	83 ec 0c             	sub    $0xc,%esp
80101cf3:	53                   	push   %ebx
80101cf4:	e8 07 21 00 00       	call   80103e00 <releasesleep>
  iput(ip);
80101cf9:	89 34 24             	mov    %esi,(%esp)
80101cfc:	e8 cb f9 ff ff       	call   801016cc <iput>
      return 0;
80101d01:	83 c4 10             	add    $0x10,%esp
80101d04:	31 f6                	xor    %esi,%esi
}
80101d06:	89 f0                	mov    %esi,%eax
80101d08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d0b:	5b                   	pop    %ebx
80101d0c:	5e                   	pop    %esi
80101d0d:	5f                   	pop    %edi
80101d0e:	5d                   	pop    %ebp
80101d0f:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101d10:	83 ec 0c             	sub    $0xc,%esp
80101d13:	52                   	push   %edx
80101d14:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d17:	e8 20 21 00 00       	call   80103e3c <holdingsleep>
80101d1c:	83 c4 10             	add    $0x10,%esp
80101d1f:	85 c0                	test   %eax,%eax
80101d21:	74 53                	je     80101d76 <namex+0x21a>
80101d23:	8b 46 08             	mov    0x8(%esi),%eax
80101d26:	85 c0                	test   %eax,%eax
80101d28:	7e 4c                	jle    80101d76 <namex+0x21a>
  releasesleep(&ip->lock);
80101d2a:	83 ec 0c             	sub    $0xc,%esp
80101d2d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d30:	52                   	push   %edx
80101d31:	eb c1                	jmp    80101cf4 <namex+0x198>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101d33:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101d36:	83 ec 0c             	sub    $0xc,%esp
80101d39:	53                   	push   %ebx
80101d3a:	e8 fd 20 00 00       	call   80103e3c <holdingsleep>
80101d3f:	83 c4 10             	add    $0x10,%esp
80101d42:	85 c0                	test   %eax,%eax
80101d44:	74 30                	je     80101d76 <namex+0x21a>
80101d46:	8b 46 08             	mov    0x8(%esi),%eax
80101d49:	85 c0                	test   %eax,%eax
80101d4b:	7e 29                	jle    80101d76 <namex+0x21a>
  releasesleep(&ip->lock);
80101d4d:	83 ec 0c             	sub    $0xc,%esp
80101d50:	53                   	push   %ebx
80101d51:	e8 aa 20 00 00       	call   80103e00 <releasesleep>
}
80101d56:	83 c4 10             	add    $0x10,%esp
}
80101d59:	89 f0                	mov    %esi,%eax
80101d5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d5e:	5b                   	pop    %ebx
80101d5f:	5e                   	pop    %esi
80101d60:	5f                   	pop    %edi
80101d61:	5d                   	pop    %ebp
80101d62:	c3                   	ret    
    iput(ip);
80101d63:	83 ec 0c             	sub    $0xc,%esp
80101d66:	56                   	push   %esi
80101d67:	e8 60 f9 ff ff       	call   801016cc <iput>
    return 0;
80101d6c:	83 c4 10             	add    $0x10,%esp
80101d6f:	31 f6                	xor    %esi,%esi
80101d71:	e9 31 ff ff ff       	jmp    80101ca7 <namex+0x14b>
    panic("iunlock");
80101d76:	83 ec 0c             	sub    $0xc,%esp
80101d79:	68 ff 69 10 80       	push   $0x801069ff
80101d7e:	e8 b5 e5 ff ff       	call   80100338 <panic>
80101d83:	90                   	nop

80101d84 <dirlink>:
{
80101d84:	55                   	push   %ebp
80101d85:	89 e5                	mov    %esp,%ebp
80101d87:	57                   	push   %edi
80101d88:	56                   	push   %esi
80101d89:	53                   	push   %ebx
80101d8a:	83 ec 20             	sub    $0x20,%esp
80101d8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101d90:	6a 00                	push   $0x0
80101d92:	ff 75 0c             	push   0xc(%ebp)
80101d95:	53                   	push   %ebx
80101d96:	e8 21 fd ff ff       	call   80101abc <dirlookup>
80101d9b:	83 c4 10             	add    $0x10,%esp
80101d9e:	85 c0                	test   %eax,%eax
80101da0:	75 65                	jne    80101e07 <dirlink+0x83>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101da2:	8b 7b 58             	mov    0x58(%ebx),%edi
80101da5:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101da8:	85 ff                	test   %edi,%edi
80101daa:	74 29                	je     80101dd5 <dirlink+0x51>
80101dac:	31 ff                	xor    %edi,%edi
80101dae:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101db1:	eb 09                	jmp    80101dbc <dirlink+0x38>
80101db3:	90                   	nop
80101db4:	83 c7 10             	add    $0x10,%edi
80101db7:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101dba:	73 19                	jae    80101dd5 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101dbc:	6a 10                	push   $0x10
80101dbe:	57                   	push   %edi
80101dbf:	56                   	push   %esi
80101dc0:	53                   	push   %ebx
80101dc1:	e8 c6 fa ff ff       	call   8010188c <readi>
80101dc6:	83 c4 10             	add    $0x10,%esp
80101dc9:	83 f8 10             	cmp    $0x10,%eax
80101dcc:	75 4c                	jne    80101e1a <dirlink+0x96>
    if(de.inum == 0)
80101dce:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101dd3:	75 df                	jne    80101db4 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101dd5:	50                   	push   %eax
80101dd6:	6a 0e                	push   $0xe
80101dd8:	ff 75 0c             	push   0xc(%ebp)
80101ddb:	8d 45 da             	lea    -0x26(%ebp),%eax
80101dde:	50                   	push   %eax
80101ddf:	e8 14 24 00 00       	call   801041f8 <strncpy>
  de.inum = inum;
80101de4:	8b 45 10             	mov    0x10(%ebp),%eax
80101de7:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101deb:	6a 10                	push   $0x10
80101ded:	57                   	push   %edi
80101dee:	56                   	push   %esi
80101def:	53                   	push   %ebx
80101df0:	e8 8f fb ff ff       	call   80101984 <writei>
80101df5:	83 c4 20             	add    $0x20,%esp
80101df8:	83 f8 10             	cmp    $0x10,%eax
80101dfb:	75 2a                	jne    80101e27 <dirlink+0xa3>
  return 0;
80101dfd:	31 c0                	xor    %eax,%eax
}
80101dff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e02:	5b                   	pop    %ebx
80101e03:	5e                   	pop    %esi
80101e04:	5f                   	pop    %edi
80101e05:	5d                   	pop    %ebp
80101e06:	c3                   	ret    
    iput(ip);
80101e07:	83 ec 0c             	sub    $0xc,%esp
80101e0a:	50                   	push   %eax
80101e0b:	e8 bc f8 ff ff       	call   801016cc <iput>
    return -1;
80101e10:	83 c4 10             	add    $0x10,%esp
80101e13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e18:	eb e5                	jmp    80101dff <dirlink+0x7b>
      panic("dirlink read");
80101e1a:	83 ec 0c             	sub    $0xc,%esp
80101e1d:	68 28 6a 10 80       	push   $0x80106a28
80101e22:	e8 11 e5 ff ff       	call   80100338 <panic>
    panic("dirlink");
80101e27:	83 ec 0c             	sub    $0xc,%esp
80101e2a:	68 02 70 10 80       	push   $0x80107002
80101e2f:	e8 04 e5 ff ff       	call   80100338 <panic>

80101e34 <namei>:

struct inode*
namei(char *path)
{
80101e34:	55                   	push   %ebp
80101e35:	89 e5                	mov    %esp,%ebp
80101e37:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101e3a:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101e3d:	31 d2                	xor    %edx,%edx
80101e3f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e42:	e8 15 fd ff ff       	call   80101b5c <namex>
}
80101e47:	c9                   	leave  
80101e48:	c3                   	ret    
80101e49:	8d 76 00             	lea    0x0(%esi),%esi

80101e4c <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101e4c:	55                   	push   %ebp
80101e4d:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101e4f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101e52:	ba 01 00 00 00       	mov    $0x1,%edx
80101e57:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101e5a:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101e5b:	e9 fc fc ff ff       	jmp    80101b5c <namex>

80101e60 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101e60:	55                   	push   %ebp
80101e61:	89 e5                	mov    %esp,%ebp
80101e63:	57                   	push   %edi
80101e64:	56                   	push   %esi
80101e65:	53                   	push   %ebx
80101e66:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101e69:	85 c0                	test   %eax,%eax
80101e6b:	0f 84 99 00 00 00    	je     80101f0a <idestart+0xaa>
80101e71:	89 c3                	mov    %eax,%ebx
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101e73:	8b 70 08             	mov    0x8(%eax),%esi
80101e76:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80101e7c:	77 7f                	ja     80101efd <idestart+0x9d>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101e7e:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101e83:	90                   	nop
80101e84:	89 ca                	mov    %ecx,%edx
80101e86:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101e87:	83 e0 c0             	and    $0xffffffc0,%eax
80101e8a:	3c 40                	cmp    $0x40,%al
80101e8c:	75 f6                	jne    80101e84 <idestart+0x24>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101e8e:	31 ff                	xor    %edi,%edi
80101e90:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101e95:	89 f8                	mov    %edi,%eax
80101e97:	ee                   	out    %al,(%dx)
80101e98:	b0 01                	mov    $0x1,%al
80101e9a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101e9f:	ee                   	out    %al,(%dx)
80101ea0:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101ea5:	89 f0                	mov    %esi,%eax
80101ea7:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101ea8:	89 f0                	mov    %esi,%eax
80101eaa:	c1 f8 08             	sar    $0x8,%eax
80101ead:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101eb2:	ee                   	out    %al,(%dx)
80101eb3:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101eb8:	89 f8                	mov    %edi,%eax
80101eba:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101ebb:	8a 43 04             	mov    0x4(%ebx),%al
80101ebe:	c1 e0 04             	shl    $0x4,%eax
80101ec1:	83 e0 10             	and    $0x10,%eax
80101ec4:	83 c8 e0             	or     $0xffffffe0,%eax
80101ec7:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101ecc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101ecd:	f6 03 04             	testb  $0x4,(%ebx)
80101ed0:	75 0e                	jne    80101ee0 <idestart+0x80>
80101ed2:	b0 20                	mov    $0x20,%al
80101ed4:	89 ca                	mov    %ecx,%edx
80101ed6:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101ed7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eda:	5b                   	pop    %ebx
80101edb:	5e                   	pop    %esi
80101edc:	5f                   	pop    %edi
80101edd:	5d                   	pop    %ebp
80101ede:	c3                   	ret    
80101edf:	90                   	nop
80101ee0:	b0 30                	mov    $0x30,%al
80101ee2:	89 ca                	mov    %ecx,%edx
80101ee4:	ee                   	out    %al,(%dx)
    outsl(0x1f0, b->data, BSIZE/4);
80101ee5:	8d 73 5c             	lea    0x5c(%ebx),%esi
  asm volatile("cld; rep outsl" :
80101ee8:	b9 80 00 00 00       	mov    $0x80,%ecx
80101eed:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101ef2:	fc                   	cld    
80101ef3:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101ef5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ef8:	5b                   	pop    %ebx
80101ef9:	5e                   	pop    %esi
80101efa:	5f                   	pop    %edi
80101efb:	5d                   	pop    %ebp
80101efc:	c3                   	ret    
    panic("incorrect blockno");
80101efd:	83 ec 0c             	sub    $0xc,%esp
80101f00:	68 94 6a 10 80       	push   $0x80106a94
80101f05:	e8 2e e4 ff ff       	call   80100338 <panic>
    panic("idestart");
80101f0a:	83 ec 0c             	sub    $0xc,%esp
80101f0d:	68 8b 6a 10 80       	push   $0x80106a8b
80101f12:	e8 21 e4 ff ff       	call   80100338 <panic>
80101f17:	90                   	nop

80101f18 <ideinit>:
{
80101f18:	55                   	push   %ebp
80101f19:	89 e5                	mov    %esp,%ebp
80101f1b:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80101f1e:	68 a6 6a 10 80       	push   $0x80106aa6
80101f23:	68 00 16 11 80       	push   $0x80111600
80101f28:	e8 5b 1f 00 00       	call   80103e88 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101f2d:	58                   	pop    %eax
80101f2e:	5a                   	pop    %edx
80101f2f:	a1 84 17 11 80       	mov    0x80111784,%eax
80101f34:	48                   	dec    %eax
80101f35:	50                   	push   %eax
80101f36:	6a 0e                	push   $0xe
80101f38:	e8 57 02 00 00       	call   80102194 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f3d:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f40:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f45:	8d 76 00             	lea    0x0(%esi),%esi
80101f48:	ec                   	in     (%dx),%al
80101f49:	83 e0 c0             	and    $0xffffffc0,%eax
80101f4c:	3c 40                	cmp    $0x40,%al
80101f4e:	75 f8                	jne    80101f48 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f50:	b0 f0                	mov    $0xf0,%al
80101f52:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f57:	ee                   	out    %al,(%dx)
80101f58:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f5d:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f62:	eb 03                	jmp    80101f67 <ideinit+0x4f>
  for(i=0; i<1000; i++){
80101f64:	49                   	dec    %ecx
80101f65:	74 0f                	je     80101f76 <ideinit+0x5e>
80101f67:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80101f68:	84 c0                	test   %al,%al
80101f6a:	74 f8                	je     80101f64 <ideinit+0x4c>
      havedisk1 = 1;
80101f6c:	c7 05 e0 15 11 80 01 	movl   $0x1,0x801115e0
80101f73:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f76:	b0 e0                	mov    $0xe0,%al
80101f78:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f7d:	ee                   	out    %al,(%dx)
}
80101f7e:	c9                   	leave  
80101f7f:	c3                   	ret    

80101f80 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80101f80:	55                   	push   %ebp
80101f81:	89 e5                	mov    %esp,%ebp
80101f83:	57                   	push   %edi
80101f84:	56                   	push   %esi
80101f85:	53                   	push   %ebx
80101f86:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80101f89:	68 00 16 11 80       	push   $0x80111600
80101f8e:	e8 ad 20 00 00       	call   80104040 <acquire>

  if((b = idequeue) == 0){
80101f93:	8b 1d e4 15 11 80    	mov    0x801115e4,%ebx
80101f99:	83 c4 10             	add    $0x10,%esp
80101f9c:	85 db                	test   %ebx,%ebx
80101f9e:	74 5b                	je     80101ffb <ideintr+0x7b>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80101fa0:	8b 43 58             	mov    0x58(%ebx),%eax
80101fa3:	a3 e4 15 11 80       	mov    %eax,0x801115e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80101fa8:	8b 33                	mov    (%ebx),%esi
80101faa:	f7 c6 04 00 00 00    	test   $0x4,%esi
80101fb0:	75 27                	jne    80101fd9 <ideintr+0x59>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fb2:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fb7:	90                   	nop
80101fb8:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101fb9:	88 c1                	mov    %al,%cl
80101fbb:	83 e1 c0             	and    $0xffffffc0,%ecx
80101fbe:	80 f9 40             	cmp    $0x40,%cl
80101fc1:	75 f5                	jne    80101fb8 <ideintr+0x38>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80101fc3:	a8 21                	test   $0x21,%al
80101fc5:	75 12                	jne    80101fd9 <ideintr+0x59>
    insl(0x1f0, b->data, BSIZE/4);
80101fc7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80101fca:	b9 80 00 00 00       	mov    $0x80,%ecx
80101fcf:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fd4:	fc                   	cld    
80101fd5:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80101fd7:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80101fd9:	83 e6 fb             	and    $0xfffffffb,%esi
80101fdc:	83 ce 02             	or     $0x2,%esi
80101fdf:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80101fe1:	83 ec 0c             	sub    $0xc,%esp
80101fe4:	53                   	push   %ebx
80101fe5:	e8 ce 1b 00 00       	call   80103bb8 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80101fea:	a1 e4 15 11 80       	mov    0x801115e4,%eax
80101fef:	83 c4 10             	add    $0x10,%esp
80101ff2:	85 c0                	test   %eax,%eax
80101ff4:	74 05                	je     80101ffb <ideintr+0x7b>
    idestart(idequeue);
80101ff6:	e8 65 fe ff ff       	call   80101e60 <idestart>
    release(&idelock);
80101ffb:	83 ec 0c             	sub    $0xc,%esp
80101ffe:	68 00 16 11 80       	push   $0x80111600
80102003:	e8 d8 1f 00 00       	call   80103fe0 <release>

  release(&idelock);
}
80102008:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010200b:	5b                   	pop    %ebx
8010200c:	5e                   	pop    %esi
8010200d:	5f                   	pop    %edi
8010200e:	5d                   	pop    %ebp
8010200f:	c3                   	ret    

80102010 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	53                   	push   %ebx
80102014:	83 ec 10             	sub    $0x10,%esp
80102017:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010201a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010201d:	50                   	push   %eax
8010201e:	e8 19 1e 00 00       	call   80103e3c <holdingsleep>
80102023:	83 c4 10             	add    $0x10,%esp
80102026:	85 c0                	test   %eax,%eax
80102028:	0f 84 b7 00 00 00    	je     801020e5 <iderw+0xd5>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010202e:	8b 03                	mov    (%ebx),%eax
80102030:	83 e0 06             	and    $0x6,%eax
80102033:	83 f8 02             	cmp    $0x2,%eax
80102036:	0f 84 9c 00 00 00    	je     801020d8 <iderw+0xc8>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010203c:	8b 53 04             	mov    0x4(%ebx),%edx
8010203f:	85 d2                	test   %edx,%edx
80102041:	74 09                	je     8010204c <iderw+0x3c>
80102043:	a1 e0 15 11 80       	mov    0x801115e0,%eax
80102048:	85 c0                	test   %eax,%eax
8010204a:	74 7f                	je     801020cb <iderw+0xbb>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010204c:	83 ec 0c             	sub    $0xc,%esp
8010204f:	68 00 16 11 80       	push   $0x80111600
80102054:	e8 e7 1f 00 00       	call   80104040 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80102059:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102060:	a1 e4 15 11 80       	mov    0x801115e4,%eax
80102065:	83 c4 10             	add    $0x10,%esp
80102068:	85 c0                	test   %eax,%eax
8010206a:	74 58                	je     801020c4 <iderw+0xb4>
8010206c:	89 c2                	mov    %eax,%edx
8010206e:	8b 40 58             	mov    0x58(%eax),%eax
80102071:	85 c0                	test   %eax,%eax
80102073:	75 f7                	jne    8010206c <iderw+0x5c>
80102075:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102078:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010207a:	39 1d e4 15 11 80    	cmp    %ebx,0x801115e4
80102080:	74 36                	je     801020b8 <iderw+0xa8>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102082:	8b 03                	mov    (%ebx),%eax
80102084:	83 e0 06             	and    $0x6,%eax
80102087:	83 f8 02             	cmp    $0x2,%eax
8010208a:	74 1b                	je     801020a7 <iderw+0x97>
    sleep(b, &idelock);
8010208c:	83 ec 08             	sub    $0x8,%esp
8010208f:	68 00 16 11 80       	push   $0x80111600
80102094:	53                   	push   %ebx
80102095:	e8 62 1a 00 00       	call   80103afc <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010209a:	8b 03                	mov    (%ebx),%eax
8010209c:	83 e0 06             	and    $0x6,%eax
8010209f:	83 c4 10             	add    $0x10,%esp
801020a2:	83 f8 02             	cmp    $0x2,%eax
801020a5:	75 e5                	jne    8010208c <iderw+0x7c>
  }


  release(&idelock);
801020a7:	c7 45 08 00 16 11 80 	movl   $0x80111600,0x8(%ebp)
}
801020ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801020b1:	c9                   	leave  
  release(&idelock);
801020b2:	e9 29 1f 00 00       	jmp    80103fe0 <release>
801020b7:	90                   	nop
    idestart(b);
801020b8:	89 d8                	mov    %ebx,%eax
801020ba:	e8 a1 fd ff ff       	call   80101e60 <idestart>
801020bf:	eb c1                	jmp    80102082 <iderw+0x72>
801020c1:	8d 76 00             	lea    0x0(%esi),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801020c4:	ba e4 15 11 80       	mov    $0x801115e4,%edx
801020c9:	eb ad                	jmp    80102078 <iderw+0x68>
    panic("iderw: ide disk 1 not present");
801020cb:	83 ec 0c             	sub    $0xc,%esp
801020ce:	68 d5 6a 10 80       	push   $0x80106ad5
801020d3:	e8 60 e2 ff ff       	call   80100338 <panic>
    panic("iderw: nothing to do");
801020d8:	83 ec 0c             	sub    $0xc,%esp
801020db:	68 c0 6a 10 80       	push   $0x80106ac0
801020e0:	e8 53 e2 ff ff       	call   80100338 <panic>
    panic("iderw: buf not locked");
801020e5:	83 ec 0c             	sub    $0xc,%esp
801020e8:	68 aa 6a 10 80       	push   $0x80106aaa
801020ed:	e8 46 e2 ff ff       	call   80100338 <panic>
801020f2:	66 90                	xchg   %ax,%ax

801020f4 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801020f4:	55                   	push   %ebp
801020f5:	89 e5                	mov    %esp,%ebp
801020f7:	56                   	push   %esi
801020f8:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801020f9:	c7 05 34 16 11 80 00 	movl   $0xfec00000,0x80111634
80102100:	00 c0 fe 
  ioapic->reg = reg;
80102103:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010210a:	00 00 00 
  return ioapic->data;
8010210d:	8b 15 34 16 11 80    	mov    0x80111634,%edx
80102113:	8b 72 10             	mov    0x10(%edx),%esi
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102116:	c1 ee 10             	shr    $0x10,%esi
80102119:	89 f0                	mov    %esi,%eax
8010211b:	0f b6 f0             	movzbl %al,%esi
  ioapic->reg = reg;
8010211e:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102124:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
8010212a:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010212d:	0f b6 15 80 17 11 80 	movzbl 0x80111780,%edx
  id = ioapicread(REG_ID) >> 24;
80102134:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102137:	39 c2                	cmp    %eax,%edx
80102139:	74 16                	je     80102151 <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
8010213b:	83 ec 0c             	sub    $0xc,%esp
8010213e:	68 f4 6a 10 80       	push   $0x80106af4
80102143:	e8 d4 e4 ff ff       	call   8010061c <cprintf>
  ioapic->reg = reg;
80102148:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
8010214e:	83 c4 10             	add    $0x10,%esp
80102151:	83 c6 21             	add    $0x21,%esi
{
80102154:	ba 10 00 00 00       	mov    $0x10,%edx
80102159:	b8 20 00 00 00       	mov    $0x20,%eax
8010215e:	66 90                	xchg   %ax,%ax

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102160:	89 c3                	mov    %eax,%ebx
80102162:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->reg = reg;
80102168:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
8010216a:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80102170:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102173:	8d 5a 01             	lea    0x1(%edx),%ebx
80102176:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102178:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
8010217e:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
80102185:	40                   	inc    %eax
80102186:	83 c2 02             	add    $0x2,%edx
80102189:	39 f0                	cmp    %esi,%eax
8010218b:	75 d3                	jne    80102160 <ioapicinit+0x6c>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010218d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102190:	5b                   	pop    %ebx
80102191:	5e                   	pop    %esi
80102192:	5d                   	pop    %ebp
80102193:	c3                   	ret    

80102194 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102194:	55                   	push   %ebp
80102195:	89 e5                	mov    %esp,%ebp
80102197:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010219a:	8d 50 20             	lea    0x20(%eax),%edx
8010219d:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801021a1:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
801021a7:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801021a9:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
801021af:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801021b2:	8b 55 0c             	mov    0xc(%ebp),%edx
801021b5:	c1 e2 18             	shl    $0x18,%edx
801021b8:	40                   	inc    %eax
  ioapic->reg = reg;
801021b9:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801021bb:	a1 34 16 11 80       	mov    0x80111634,%eax
801021c0:	89 50 10             	mov    %edx,0x10(%eax)
}
801021c3:	5d                   	pop    %ebp
801021c4:	c3                   	ret    
801021c5:	66 90                	xchg   %ax,%ax
801021c7:	90                   	nop

801021c8 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801021c8:	55                   	push   %ebp
801021c9:	89 e5                	mov    %esp,%ebp
801021cb:	53                   	push   %ebx
801021cc:	53                   	push   %ebx
801021cd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801021d0:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801021d6:	75 70                	jne    80102248 <kfree+0x80>
801021d8:	81 fb d0 54 11 80    	cmp    $0x801154d0,%ebx
801021de:	72 68                	jb     80102248 <kfree+0x80>
801021e0:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801021e6:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801021eb:	77 5b                	ja     80102248 <kfree+0x80>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801021ed:	52                   	push   %edx
801021ee:	68 00 10 00 00       	push   $0x1000
801021f3:	6a 01                	push   $0x1
801021f5:	53                   	push   %ebx
801021f6:	e8 ed 1e 00 00       	call   801040e8 <memset>

  if(kmem.use_lock)
801021fb:	83 c4 10             	add    $0x10,%esp
801021fe:	8b 0d 74 16 11 80    	mov    0x80111674,%ecx
80102204:	85 c9                	test   %ecx,%ecx
80102206:	75 1c                	jne    80102224 <kfree+0x5c>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102208:	a1 78 16 11 80       	mov    0x80111678,%eax
8010220d:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
8010220f:	89 1d 78 16 11 80    	mov    %ebx,0x80111678
  if(kmem.use_lock)
80102215:	a1 74 16 11 80       	mov    0x80111674,%eax
8010221a:	85 c0                	test   %eax,%eax
8010221c:	75 1a                	jne    80102238 <kfree+0x70>
    release(&kmem.lock);
}
8010221e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102221:	c9                   	leave  
80102222:	c3                   	ret    
80102223:	90                   	nop
    acquire(&kmem.lock);
80102224:	83 ec 0c             	sub    $0xc,%esp
80102227:	68 40 16 11 80       	push   $0x80111640
8010222c:	e8 0f 1e 00 00       	call   80104040 <acquire>
80102231:	83 c4 10             	add    $0x10,%esp
80102234:	eb d2                	jmp    80102208 <kfree+0x40>
80102236:	66 90                	xchg   %ax,%ax
    release(&kmem.lock);
80102238:	c7 45 08 40 16 11 80 	movl   $0x80111640,0x8(%ebp)
}
8010223f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102242:	c9                   	leave  
    release(&kmem.lock);
80102243:	e9 98 1d 00 00       	jmp    80103fe0 <release>
    panic("kfree");
80102248:	83 ec 0c             	sub    $0xc,%esp
8010224b:	68 26 6b 10 80       	push   $0x80106b26
80102250:	e8 e3 e0 ff ff       	call   80100338 <panic>
80102255:	8d 76 00             	lea    0x0(%esi),%esi

80102258 <freerange>:
{
80102258:	55                   	push   %ebp
80102259:	89 e5                	mov    %esp,%ebp
8010225b:	56                   	push   %esi
8010225c:	53                   	push   %ebx
8010225d:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
80102260:	8b 45 08             	mov    0x8(%ebp),%eax
80102263:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102269:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010226f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102275:	39 de                	cmp    %ebx,%esi
80102277:	72 1f                	jb     80102298 <freerange+0x40>
80102279:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
8010227c:	83 ec 0c             	sub    $0xc,%esp
8010227f:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102285:	50                   	push   %eax
80102286:	e8 3d ff ff ff       	call   801021c8 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010228b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102291:	83 c4 10             	add    $0x10,%esp
80102294:	39 f3                	cmp    %esi,%ebx
80102296:	76 e4                	jbe    8010227c <freerange+0x24>
}
80102298:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010229b:	5b                   	pop    %ebx
8010229c:	5e                   	pop    %esi
8010229d:	5d                   	pop    %ebp
8010229e:	c3                   	ret    
8010229f:	90                   	nop

801022a0 <kinit2>:
{
801022a0:	55                   	push   %ebp
801022a1:	89 e5                	mov    %esp,%ebp
801022a3:	56                   	push   %esi
801022a4:	53                   	push   %ebx
801022a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801022a8:	8b 45 08             	mov    0x8(%ebp),%eax
801022ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801022b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801022b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801022bd:	39 de                	cmp    %ebx,%esi
801022bf:	72 1f                	jb     801022e0 <kinit2+0x40>
801022c1:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
801022c4:	83 ec 0c             	sub    $0xc,%esp
801022c7:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801022cd:	50                   	push   %eax
801022ce:	e8 f5 fe ff ff       	call   801021c8 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801022d3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801022d9:	83 c4 10             	add    $0x10,%esp
801022dc:	39 de                	cmp    %ebx,%esi
801022de:	73 e4                	jae    801022c4 <kinit2+0x24>
  kmem.use_lock = 1;
801022e0:	c7 05 74 16 11 80 01 	movl   $0x1,0x80111674
801022e7:	00 00 00 
}
801022ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022ed:	5b                   	pop    %ebx
801022ee:	5e                   	pop    %esi
801022ef:	5d                   	pop    %ebp
801022f0:	c3                   	ret    
801022f1:	8d 76 00             	lea    0x0(%esi),%esi

801022f4 <kinit1>:
{
801022f4:	55                   	push   %ebp
801022f5:	89 e5                	mov    %esp,%ebp
801022f7:	56                   	push   %esi
801022f8:	53                   	push   %ebx
801022f9:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801022fc:	83 ec 08             	sub    $0x8,%esp
801022ff:	68 2c 6b 10 80       	push   $0x80106b2c
80102304:	68 40 16 11 80       	push   $0x80111640
80102309:	e8 7a 1b 00 00       	call   80103e88 <initlock>
  kmem.use_lock = 0;
8010230e:	c7 05 74 16 11 80 00 	movl   $0x0,0x80111674
80102315:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102318:	8b 45 08             	mov    0x8(%ebp),%eax
8010231b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102321:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102327:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010232d:	83 c4 10             	add    $0x10,%esp
80102330:	39 de                	cmp    %ebx,%esi
80102332:	72 1c                	jb     80102350 <kinit1+0x5c>
    kfree(p);
80102334:	83 ec 0c             	sub    $0xc,%esp
80102337:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010233d:	50                   	push   %eax
8010233e:	e8 85 fe ff ff       	call   801021c8 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102343:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102349:	83 c4 10             	add    $0x10,%esp
8010234c:	39 de                	cmp    %ebx,%esi
8010234e:	73 e4                	jae    80102334 <kinit1+0x40>
}
80102350:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102353:	5b                   	pop    %ebx
80102354:	5e                   	pop    %esi
80102355:	5d                   	pop    %ebp
80102356:	c3                   	ret    
80102357:	90                   	nop

80102358 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102358:	a1 74 16 11 80       	mov    0x80111674,%eax
8010235d:	85 c0                	test   %eax,%eax
8010235f:	75 17                	jne    80102378 <kalloc+0x20>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102361:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(r)
80102366:	85 c0                	test   %eax,%eax
80102368:	74 0a                	je     80102374 <kalloc+0x1c>
    kmem.freelist = r->next;
8010236a:	8b 10                	mov    (%eax),%edx
8010236c:	89 15 78 16 11 80    	mov    %edx,0x80111678
  if(kmem.use_lock)
80102372:	c3                   	ret    
80102373:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102374:	c3                   	ret    
80102375:	8d 76 00             	lea    0x0(%esi),%esi
{
80102378:	55                   	push   %ebp
80102379:	89 e5                	mov    %esp,%ebp
8010237b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010237e:	68 40 16 11 80       	push   $0x80111640
80102383:	e8 b8 1c 00 00       	call   80104040 <acquire>
  r = kmem.freelist;
80102388:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(r)
8010238d:	83 c4 10             	add    $0x10,%esp
  if(kmem.use_lock)
80102390:	8b 15 74 16 11 80    	mov    0x80111674,%edx
  if(r)
80102396:	85 c0                	test   %eax,%eax
80102398:	74 08                	je     801023a2 <kalloc+0x4a>
    kmem.freelist = r->next;
8010239a:	8b 08                	mov    (%eax),%ecx
8010239c:	89 0d 78 16 11 80    	mov    %ecx,0x80111678
  if(kmem.use_lock)
801023a2:	85 d2                	test   %edx,%edx
801023a4:	74 16                	je     801023bc <kalloc+0x64>
801023a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    release(&kmem.lock);
801023a9:	83 ec 0c             	sub    $0xc,%esp
801023ac:	68 40 16 11 80       	push   $0x80111640
801023b1:	e8 2a 1c 00 00       	call   80103fe0 <release>
801023b6:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
801023b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801023bc:	c9                   	leave  
801023bd:	c3                   	ret    
801023be:	66 90                	xchg   %ax,%ax

801023c0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023c0:	ba 64 00 00 00       	mov    $0x64,%edx
801023c5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801023c6:	a8 01                	test   $0x1,%al
801023c8:	0f 84 b2 00 00 00    	je     80102480 <kbdgetc+0xc0>
{
801023ce:	55                   	push   %ebp
801023cf:	89 e5                	mov    %esp,%ebp
801023d1:	53                   	push   %ebx
801023d2:	ba 60 00 00 00       	mov    $0x60,%edx
801023d7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801023d8:	0f b6 d8             	movzbl %al,%ebx

  if(data == 0xE0){
    shift |= E0ESC;
801023db:	8b 0d 7c 16 11 80    	mov    0x8011167c,%ecx
  if(data == 0xE0){
801023e1:	3c e0                	cmp    $0xe0,%al
801023e3:	74 5b                	je     80102440 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801023e5:	89 ca                	mov    %ecx,%edx
801023e7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
801023ea:	84 c0                	test   %al,%al
801023ec:	78 62                	js     80102450 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801023ee:	85 d2                	test   %edx,%edx
801023f0:	74 09                	je     801023fb <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801023f2:	83 c8 80             	or     $0xffffff80,%eax
801023f5:	0f b6 d8             	movzbl %al,%ebx
    shift &= ~E0ESC;
801023f8:	83 e1 bf             	and    $0xffffffbf,%ecx
  }

  shift |= shiftcode[data];
801023fb:	0f b6 93 60 6c 10 80 	movzbl -0x7fef93a0(%ebx),%edx
80102402:	09 ca                	or     %ecx,%edx
  shift ^= togglecode[data];
80102404:	0f b6 83 60 6b 10 80 	movzbl -0x7fef94a0(%ebx),%eax
8010240b:	31 c2                	xor    %eax,%edx
8010240d:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
  c = charcode[shift & (CTL | SHIFT)][data];
80102413:	89 d0                	mov    %edx,%eax
80102415:	83 e0 03             	and    $0x3,%eax
80102418:	8b 04 85 40 6b 10 80 	mov    -0x7fef94c0(,%eax,4),%eax
8010241f:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
  if(shift & CAPSLOCK){
80102423:	83 e2 08             	and    $0x8,%edx
80102426:	74 13                	je     8010243b <kbdgetc+0x7b>
    if('a' <= c && c <= 'z')
80102428:	8d 50 9f             	lea    -0x61(%eax),%edx
8010242b:	83 fa 19             	cmp    $0x19,%edx
8010242e:	76 48                	jbe    80102478 <kbdgetc+0xb8>
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102430:	8d 50 bf             	lea    -0x41(%eax),%edx
80102433:	83 fa 19             	cmp    $0x19,%edx
80102436:	77 03                	ja     8010243b <kbdgetc+0x7b>
      c += 'a' - 'A';
80102438:	83 c0 20             	add    $0x20,%eax
  }
  return c;
}
8010243b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010243e:	c9                   	leave  
8010243f:	c3                   	ret    
    shift |= E0ESC;
80102440:	83 c9 40             	or     $0x40,%ecx
80102443:	89 0d 7c 16 11 80    	mov    %ecx,0x8011167c
    return 0;
80102449:	31 c0                	xor    %eax,%eax
}
8010244b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010244e:	c9                   	leave  
8010244f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102450:	85 d2                	test   %edx,%edx
80102452:	75 05                	jne    80102459 <kbdgetc+0x99>
80102454:	89 c3                	mov    %eax,%ebx
80102456:	83 e3 7f             	and    $0x7f,%ebx
    shift &= ~(shiftcode[data] | E0ESC);
80102459:	8a 83 60 6c 10 80    	mov    -0x7fef93a0(%ebx),%al
8010245f:	83 c8 40             	or     $0x40,%eax
80102462:	0f b6 c0             	movzbl %al,%eax
80102465:	f7 d0                	not    %eax
80102467:	21 c8                	and    %ecx,%eax
80102469:	a3 7c 16 11 80       	mov    %eax,0x8011167c
    return 0;
8010246e:	31 c0                	xor    %eax,%eax
}
80102470:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102473:	c9                   	leave  
80102474:	c3                   	ret    
80102475:	8d 76 00             	lea    0x0(%esi),%esi
      c += 'A' - 'a';
80102478:	83 e8 20             	sub    $0x20,%eax
}
8010247b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010247e:	c9                   	leave  
8010247f:	c3                   	ret    
    return -1;
80102480:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102485:	c3                   	ret    
80102486:	66 90                	xchg   %ax,%ax

80102488 <kbdintr>:

void
kbdintr(void)
{
80102488:	55                   	push   %ebp
80102489:	89 e5                	mov    %esp,%ebp
8010248b:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
8010248e:	68 c0 23 10 80       	push   $0x801023c0
80102493:	e8 4c e3 ff ff       	call   801007e4 <consoleintr>
}
80102498:	83 c4 10             	add    $0x10,%esp
8010249b:	c9                   	leave  
8010249c:	c3                   	ret    
8010249d:	66 90                	xchg   %ax,%ax
8010249f:	90                   	nop

801024a0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801024a0:	a1 80 16 11 80       	mov    0x80111680,%eax
801024a5:	85 c0                	test   %eax,%eax
801024a7:	0f 84 c3 00 00 00    	je     80102570 <lapicinit+0xd0>
  lapic[index] = value;
801024ad:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801024b4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801024b7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801024ba:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801024c1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801024c4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801024c7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801024ce:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801024d1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801024d4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801024db:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801024de:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801024e1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801024e8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801024eb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801024ee:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801024f5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801024f8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801024fb:	8b 50 30             	mov    0x30(%eax),%edx
801024fe:	c1 ea 10             	shr    $0x10,%edx
80102501:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102507:	75 6b                	jne    80102574 <lapicinit+0xd4>
  lapic[index] = value;
80102509:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102510:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102513:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102516:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010251d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102520:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102523:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010252a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010252d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102530:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102537:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010253a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010253d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102544:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102547:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010254a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102551:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102554:	8b 50 20             	mov    0x20(%eax),%edx
80102557:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102558:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010255e:	80 e6 10             	and    $0x10,%dh
80102561:	75 f5                	jne    80102558 <lapicinit+0xb8>
  lapic[index] = value;
80102563:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010256a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010256d:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102570:	c3                   	ret    
80102571:	8d 76 00             	lea    0x0(%esi),%esi
  lapic[index] = value;
80102574:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010257b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010257e:	8b 50 20             	mov    0x20(%eax),%edx
}
80102581:	eb 86                	jmp    80102509 <lapicinit+0x69>
80102583:	90                   	nop

80102584 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102584:	a1 80 16 11 80       	mov    0x80111680,%eax
80102589:	85 c0                	test   %eax,%eax
8010258b:	74 07                	je     80102594 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
8010258d:	8b 40 20             	mov    0x20(%eax),%eax
80102590:	c1 e8 18             	shr    $0x18,%eax
80102593:	c3                   	ret    
    return 0;
80102594:	31 c0                	xor    %eax,%eax
}
80102596:	c3                   	ret    
80102597:	90                   	nop

80102598 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102598:	a1 80 16 11 80       	mov    0x80111680,%eax
8010259d:	85 c0                	test   %eax,%eax
8010259f:	74 0d                	je     801025ae <lapiceoi+0x16>
  lapic[index] = value;
801025a1:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801025a8:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025ab:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801025ae:	c3                   	ret    
801025af:	90                   	nop

801025b0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
801025b0:	c3                   	ret    
801025b1:	8d 76 00             	lea    0x0(%esi),%esi

801025b4 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801025b4:	55                   	push   %ebp
801025b5:	89 e5                	mov    %esp,%ebp
801025b7:	53                   	push   %ebx
801025b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801025bb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025be:	b0 0f                	mov    $0xf,%al
801025c0:	ba 70 00 00 00       	mov    $0x70,%edx
801025c5:	ee                   	out    %al,(%dx)
801025c6:	b0 0a                	mov    $0xa,%al
801025c8:	ba 71 00 00 00       	mov    $0x71,%edx
801025cd:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801025ce:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
801025d5:	00 00 
  wrv[1] = addr >> 4;
801025d7:	89 c8                	mov    %ecx,%eax
801025d9:	c1 e8 04             	shr    $0x4,%eax
801025dc:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801025e2:	a1 80 16 11 80       	mov    0x80111680,%eax

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801025e7:	c1 e3 18             	shl    $0x18,%ebx
801025ea:	89 da                	mov    %ebx,%edx
  lapic[index] = value;
801025ec:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801025f2:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801025f5:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801025fc:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025ff:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102602:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102609:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010260c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010260f:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102615:	8b 58 20             	mov    0x20(%eax),%ebx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102618:	c1 e9 0c             	shr    $0xc,%ecx
8010261b:	80 cd 06             	or     $0x6,%ch
  lapic[index] = value;
8010261e:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102624:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102627:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010262d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102630:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102636:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102639:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010263c:	c9                   	leave  
8010263d:	c3                   	ret    
8010263e:	66 90                	xchg   %ax,%ax

80102640 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102640:	55                   	push   %ebp
80102641:	89 e5                	mov    %esp,%ebp
80102643:	57                   	push   %edi
80102644:	56                   	push   %esi
80102645:	53                   	push   %ebx
80102646:	83 ec 4c             	sub    $0x4c,%esp
80102649:	b0 0b                	mov    $0xb,%al
8010264b:	ba 70 00 00 00       	mov    $0x70,%edx
80102650:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102651:	ba 71 00 00 00       	mov    $0x71,%edx
80102656:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102657:	83 e0 04             	and    $0x4,%eax
8010265a:	88 45 b2             	mov    %al,-0x4e(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010265d:	be 70 00 00 00       	mov    $0x70,%esi
80102662:	66 90                	xchg   %ax,%ax
80102664:	31 c0                	xor    %eax,%eax
80102666:	89 f2                	mov    %esi,%edx
80102668:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102669:	bb 71 00 00 00       	mov    $0x71,%ebx
8010266e:	89 da                	mov    %ebx,%edx
80102670:	ec                   	in     (%dx),%al
80102671:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102674:	bf 02 00 00 00       	mov    $0x2,%edi
80102679:	89 f8                	mov    %edi,%eax
8010267b:	89 f2                	mov    %esi,%edx
8010267d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010267e:	89 da                	mov    %ebx,%edx
80102680:	ec                   	in     (%dx),%al
80102681:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102684:	b0 04                	mov    $0x4,%al
80102686:	89 f2                	mov    %esi,%edx
80102688:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102689:	89 da                	mov    %ebx,%edx
8010268b:	ec                   	in     (%dx),%al
8010268c:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010268f:	b0 07                	mov    $0x7,%al
80102691:	89 f2                	mov    %esi,%edx
80102693:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102694:	89 da                	mov    %ebx,%edx
80102696:	ec                   	in     (%dx),%al
80102697:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010269a:	b0 08                	mov    $0x8,%al
8010269c:	89 f2                	mov    %esi,%edx
8010269e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010269f:	89 da                	mov    %ebx,%edx
801026a1:	ec                   	in     (%dx),%al
801026a2:	88 45 b3             	mov    %al,-0x4d(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026a5:	b0 09                	mov    $0x9,%al
801026a7:	89 f2                	mov    %esi,%edx
801026a9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026aa:	89 da                	mov    %ebx,%edx
801026ac:	ec                   	in     (%dx),%al
801026ad:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026b0:	b0 0a                	mov    $0xa,%al
801026b2:	89 f2                	mov    %esi,%edx
801026b4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026b5:	89 da                	mov    %ebx,%edx
801026b7:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801026b8:	84 c0                	test   %al,%al
801026ba:	78 a8                	js     80102664 <cmostime+0x24>
  return inb(CMOS_RETURN);
801026bc:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801026c0:	89 45 b8             	mov    %eax,-0x48(%ebp)
801026c3:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801026c7:	89 45 bc             	mov    %eax,-0x44(%ebp)
801026ca:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801026ce:	89 45 c0             	mov    %eax,-0x40(%ebp)
801026d1:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801026d5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801026d8:	0f b6 45 b3          	movzbl -0x4d(%ebp),%eax
801026dc:	89 45 c8             	mov    %eax,-0x38(%ebp)
801026df:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026e2:	31 c0                	xor    %eax,%eax
801026e4:	89 f2                	mov    %esi,%edx
801026e6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026e7:	89 da                	mov    %ebx,%edx
801026e9:	ec                   	in     (%dx),%al
801026ea:	0f b6 c0             	movzbl %al,%eax
801026ed:	89 45 d0             	mov    %eax,-0x30(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026f0:	89 f8                	mov    %edi,%eax
801026f2:	89 f2                	mov    %esi,%edx
801026f4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026f5:	89 da                	mov    %ebx,%edx
801026f7:	ec                   	in     (%dx),%al
801026f8:	0f b6 c0             	movzbl %al,%eax
801026fb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026fe:	b0 04                	mov    $0x4,%al
80102700:	89 f2                	mov    %esi,%edx
80102702:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102703:	89 da                	mov    %ebx,%edx
80102705:	ec                   	in     (%dx),%al
80102706:	0f b6 c0             	movzbl %al,%eax
80102709:	89 45 d8             	mov    %eax,-0x28(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010270c:	b0 07                	mov    $0x7,%al
8010270e:	89 f2                	mov    %esi,%edx
80102710:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102711:	89 da                	mov    %ebx,%edx
80102713:	ec                   	in     (%dx),%al
80102714:	0f b6 c0             	movzbl %al,%eax
80102717:	89 45 dc             	mov    %eax,-0x24(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010271a:	b0 08                	mov    $0x8,%al
8010271c:	89 f2                	mov    %esi,%edx
8010271e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010271f:	89 da                	mov    %ebx,%edx
80102721:	ec                   	in     (%dx),%al
80102722:	0f b6 c0             	movzbl %al,%eax
80102725:	89 45 e0             	mov    %eax,-0x20(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102728:	b0 09                	mov    $0x9,%al
8010272a:	89 f2                	mov    %esi,%edx
8010272c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010272d:	89 da                	mov    %ebx,%edx
8010272f:	ec                   	in     (%dx),%al
80102730:	0f b6 c0             	movzbl %al,%eax
80102733:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102736:	50                   	push   %eax
80102737:	6a 18                	push   $0x18
80102739:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010273c:	50                   	push   %eax
8010273d:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102740:	50                   	push   %eax
80102741:	e8 ee 19 00 00       	call   80104134 <memcmp>
80102746:	83 c4 10             	add    $0x10,%esp
80102749:	85 c0                	test   %eax,%eax
8010274b:	0f 85 13 ff ff ff    	jne    80102664 <cmostime+0x24>
      break;
  }

  // convert
  if(bcd) {
80102751:	80 7d b2 00          	cmpb   $0x0,-0x4e(%ebp)
80102755:	75 7e                	jne    801027d5 <cmostime+0x195>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102757:	8b 55 b8             	mov    -0x48(%ebp),%edx
8010275a:	89 d0                	mov    %edx,%eax
8010275c:	c1 e8 04             	shr    $0x4,%eax
8010275f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80102762:	01 c0                	add    %eax,%eax
80102764:	83 e2 0f             	and    $0xf,%edx
80102767:	01 d0                	add    %edx,%eax
80102769:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
8010276c:	8b 55 bc             	mov    -0x44(%ebp),%edx
8010276f:	89 d0                	mov    %edx,%eax
80102771:	c1 e8 04             	shr    $0x4,%eax
80102774:	8d 04 80             	lea    (%eax,%eax,4),%eax
80102777:	01 c0                	add    %eax,%eax
80102779:	83 e2 0f             	and    $0xf,%edx
8010277c:	01 d0                	add    %edx,%eax
8010277e:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102781:	8b 55 c0             	mov    -0x40(%ebp),%edx
80102784:	89 d0                	mov    %edx,%eax
80102786:	c1 e8 04             	shr    $0x4,%eax
80102789:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010278c:	01 c0                	add    %eax,%eax
8010278e:	83 e2 0f             	and    $0xf,%edx
80102791:	01 d0                	add    %edx,%eax
80102793:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102796:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80102799:	89 d0                	mov    %edx,%eax
8010279b:	c1 e8 04             	shr    $0x4,%eax
8010279e:	8d 04 80             	lea    (%eax,%eax,4),%eax
801027a1:	01 c0                	add    %eax,%eax
801027a3:	83 e2 0f             	and    $0xf,%edx
801027a6:	01 d0                	add    %edx,%eax
801027a8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801027ab:	8b 55 c8             	mov    -0x38(%ebp),%edx
801027ae:	89 d0                	mov    %edx,%eax
801027b0:	c1 e8 04             	shr    $0x4,%eax
801027b3:	8d 04 80             	lea    (%eax,%eax,4),%eax
801027b6:	01 c0                	add    %eax,%eax
801027b8:	83 e2 0f             	and    $0xf,%edx
801027bb:	01 d0                	add    %edx,%eax
801027bd:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801027c0:	8b 55 cc             	mov    -0x34(%ebp),%edx
801027c3:	89 d0                	mov    %edx,%eax
801027c5:	c1 e8 04             	shr    $0x4,%eax
801027c8:	8d 04 80             	lea    (%eax,%eax,4),%eax
801027cb:	01 c0                	add    %eax,%eax
801027cd:	83 e2 0f             	and    $0xf,%edx
801027d0:	01 d0                	add    %edx,%eax
801027d2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801027d5:	b9 06 00 00 00       	mov    $0x6,%ecx
801027da:	8b 7d 08             	mov    0x8(%ebp),%edi
801027dd:	8d 75 b8             	lea    -0x48(%ebp),%esi
801027e0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  r->year += 2000;
801027e2:	8b 45 08             	mov    0x8(%ebp),%eax
801027e5:	81 40 14 d0 07 00 00 	addl   $0x7d0,0x14(%eax)
}
801027ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801027ef:	5b                   	pop    %ebx
801027f0:	5e                   	pop    %esi
801027f1:	5f                   	pop    %edi
801027f2:	5d                   	pop    %ebp
801027f3:	c3                   	ret    

801027f4 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801027f4:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
801027fa:	85 c9                	test   %ecx,%ecx
801027fc:	7e 7e                	jle    8010287c <install_trans+0x88>
{
801027fe:	55                   	push   %ebp
801027ff:	89 e5                	mov    %esp,%ebp
80102801:	57                   	push   %edi
80102802:	56                   	push   %esi
80102803:	53                   	push   %ebx
80102804:	83 ec 0c             	sub    $0xc,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
80102807:	31 ff                	xor    %edi,%edi
80102809:	8d 76 00             	lea    0x0(%esi),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
8010280c:	83 ec 08             	sub    $0x8,%esp
8010280f:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80102814:	01 f8                	add    %edi,%eax
80102816:	40                   	inc    %eax
80102817:	50                   	push   %eax
80102818:	ff 35 e4 16 11 80    	push   0x801116e4
8010281e:	e8 91 d8 ff ff       	call   801000b4 <bread>
80102823:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102825:	58                   	pop    %eax
80102826:	5a                   	pop    %edx
80102827:	ff 34 bd ec 16 11 80 	push   -0x7feee914(,%edi,4)
8010282e:	ff 35 e4 16 11 80    	push   0x801116e4
80102834:	e8 7b d8 ff ff       	call   801000b4 <bread>
80102839:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
8010283b:	83 c4 0c             	add    $0xc,%esp
8010283e:	68 00 02 00 00       	push   $0x200
80102843:	8d 46 5c             	lea    0x5c(%esi),%eax
80102846:	50                   	push   %eax
80102847:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010284a:	50                   	push   %eax
8010284b:	e8 1c 19 00 00       	call   8010416c <memmove>
    bwrite(dbuf);  // write dst to disk
80102850:	89 1c 24             	mov    %ebx,(%esp)
80102853:	e8 2c d9 ff ff       	call   80100184 <bwrite>
    brelse(lbuf);
80102858:	89 34 24             	mov    %esi,(%esp)
8010285b:	e8 5c d9 ff ff       	call   801001bc <brelse>
    brelse(dbuf);
80102860:	89 1c 24             	mov    %ebx,(%esp)
80102863:	e8 54 d9 ff ff       	call   801001bc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102868:	47                   	inc    %edi
80102869:	83 c4 10             	add    $0x10,%esp
8010286c:	39 3d e8 16 11 80    	cmp    %edi,0x801116e8
80102872:	7f 98                	jg     8010280c <install_trans+0x18>
  }
}
80102874:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102877:	5b                   	pop    %ebx
80102878:	5e                   	pop    %esi
80102879:	5f                   	pop    %edi
8010287a:	5d                   	pop    %ebp
8010287b:	c3                   	ret    
8010287c:	c3                   	ret    
8010287d:	8d 76 00             	lea    0x0(%esi),%esi

80102880 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102880:	55                   	push   %ebp
80102881:	89 e5                	mov    %esp,%ebp
80102883:	53                   	push   %ebx
80102884:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102887:	ff 35 d4 16 11 80    	push   0x801116d4
8010288d:	ff 35 e4 16 11 80    	push   0x801116e4
80102893:	e8 1c d8 ff ff       	call   801000b4 <bread>
80102898:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
8010289a:	a1 e8 16 11 80       	mov    0x801116e8,%eax
8010289f:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
801028a2:	83 c4 10             	add    $0x10,%esp
801028a5:	85 c0                	test   %eax,%eax
801028a7:	7e 13                	jle    801028bc <write_head+0x3c>
801028a9:	31 d2                	xor    %edx,%edx
801028ab:	90                   	nop
    hb->block[i] = log.lh.block[i];
801028ac:	8b 0c 95 ec 16 11 80 	mov    -0x7feee914(,%edx,4),%ecx
801028b3:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801028b7:	42                   	inc    %edx
801028b8:	39 d0                	cmp    %edx,%eax
801028ba:	75 f0                	jne    801028ac <write_head+0x2c>
  }
  bwrite(buf);
801028bc:	83 ec 0c             	sub    $0xc,%esp
801028bf:	53                   	push   %ebx
801028c0:	e8 bf d8 ff ff       	call   80100184 <bwrite>
  brelse(buf);
801028c5:	89 1c 24             	mov    %ebx,(%esp)
801028c8:	e8 ef d8 ff ff       	call   801001bc <brelse>
}
801028cd:	83 c4 10             	add    $0x10,%esp
801028d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028d3:	c9                   	leave  
801028d4:	c3                   	ret    
801028d5:	8d 76 00             	lea    0x0(%esi),%esi

801028d8 <initlog>:
{
801028d8:	55                   	push   %ebp
801028d9:	89 e5                	mov    %esp,%ebp
801028db:	53                   	push   %ebx
801028dc:	83 ec 2c             	sub    $0x2c,%esp
801028df:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
801028e2:	68 60 6d 10 80       	push   $0x80106d60
801028e7:	68 a0 16 11 80       	push   $0x801116a0
801028ec:	e8 97 15 00 00       	call   80103e88 <initlock>
  readsb(dev, &sb);
801028f1:	58                   	pop    %eax
801028f2:	5a                   	pop    %edx
801028f3:	8d 45 dc             	lea    -0x24(%ebp),%eax
801028f6:	50                   	push   %eax
801028f7:	53                   	push   %ebx
801028f8:	e8 8b ea ff ff       	call   80101388 <readsb>
  log.start = sb.logstart;
801028fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102900:	a3 d4 16 11 80       	mov    %eax,0x801116d4
  log.size = sb.nlog;
80102905:	8b 55 e8             	mov    -0x18(%ebp),%edx
80102908:	89 15 d8 16 11 80    	mov    %edx,0x801116d8
  log.dev = dev;
8010290e:	89 1d e4 16 11 80    	mov    %ebx,0x801116e4
  struct buf *buf = bread(log.dev, log.start);
80102914:	59                   	pop    %ecx
80102915:	5a                   	pop    %edx
80102916:	50                   	push   %eax
80102917:	53                   	push   %ebx
80102918:	e8 97 d7 ff ff       	call   801000b4 <bread>
  log.lh.n = lh->n;
8010291d:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102920:	89 1d e8 16 11 80    	mov    %ebx,0x801116e8
  for (i = 0; i < log.lh.n; i++) {
80102926:	83 c4 10             	add    $0x10,%esp
80102929:	85 db                	test   %ebx,%ebx
8010292b:	7e 13                	jle    80102940 <initlog+0x68>
8010292d:	31 d2                	xor    %edx,%edx
8010292f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102930:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102934:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010293b:	42                   	inc    %edx
8010293c:	39 d3                	cmp    %edx,%ebx
8010293e:	75 f0                	jne    80102930 <initlog+0x58>
  brelse(buf);
80102940:	83 ec 0c             	sub    $0xc,%esp
80102943:	50                   	push   %eax
80102944:	e8 73 d8 ff ff       	call   801001bc <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102949:	e8 a6 fe ff ff       	call   801027f4 <install_trans>
  log.lh.n = 0;
8010294e:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
80102955:	00 00 00 
  write_head(); // clear the log
80102958:	e8 23 ff ff ff       	call   80102880 <write_head>
}
8010295d:	83 c4 10             	add    $0x10,%esp
80102960:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102963:	c9                   	leave  
80102964:	c3                   	ret    
80102965:	8d 76 00             	lea    0x0(%esi),%esi

80102968 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102968:	55                   	push   %ebp
80102969:	89 e5                	mov    %esp,%ebp
8010296b:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
8010296e:	68 a0 16 11 80       	push   $0x801116a0
80102973:	e8 c8 16 00 00       	call   80104040 <acquire>
80102978:	83 c4 10             	add    $0x10,%esp
8010297b:	eb 18                	jmp    80102995 <begin_op+0x2d>
8010297d:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102980:	83 ec 08             	sub    $0x8,%esp
80102983:	68 a0 16 11 80       	push   $0x801116a0
80102988:	68 a0 16 11 80       	push   $0x801116a0
8010298d:	e8 6a 11 00 00       	call   80103afc <sleep>
80102992:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102995:	a1 e0 16 11 80       	mov    0x801116e0,%eax
8010299a:	85 c0                	test   %eax,%eax
8010299c:	75 e2                	jne    80102980 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010299e:	a1 dc 16 11 80       	mov    0x801116dc,%eax
801029a3:	8d 50 01             	lea    0x1(%eax),%edx
801029a6:	8d 44 80 05          	lea    0x5(%eax,%eax,4),%eax
801029aa:	01 c0                	add    %eax,%eax
801029ac:	03 05 e8 16 11 80    	add    0x801116e8,%eax
801029b2:	83 f8 1e             	cmp    $0x1e,%eax
801029b5:	7f c9                	jg     80102980 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
801029b7:	89 15 dc 16 11 80    	mov    %edx,0x801116dc
      release(&log.lock);
801029bd:	83 ec 0c             	sub    $0xc,%esp
801029c0:	68 a0 16 11 80       	push   $0x801116a0
801029c5:	e8 16 16 00 00       	call   80103fe0 <release>
      break;
    }
  }
}
801029ca:	83 c4 10             	add    $0x10,%esp
801029cd:	c9                   	leave  
801029ce:	c3                   	ret    
801029cf:	90                   	nop

801029d0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801029d0:	55                   	push   %ebp
801029d1:	89 e5                	mov    %esp,%ebp
801029d3:	57                   	push   %edi
801029d4:	56                   	push   %esi
801029d5:	53                   	push   %ebx
801029d6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801029d9:	68 a0 16 11 80       	push   $0x801116a0
801029de:	e8 5d 16 00 00       	call   80104040 <acquire>
  log.outstanding -= 1;
801029e3:	a1 dc 16 11 80       	mov    0x801116dc,%eax
801029e8:	8d 58 ff             	lea    -0x1(%eax),%ebx
801029eb:	89 1d dc 16 11 80    	mov    %ebx,0x801116dc
  if(log.committing)
801029f1:	83 c4 10             	add    $0x10,%esp
801029f4:	8b 35 e0 16 11 80    	mov    0x801116e0,%esi
801029fa:	85 f6                	test   %esi,%esi
801029fc:	0f 85 12 01 00 00    	jne    80102b14 <end_op+0x144>
    panic("log.committing");
  if(log.outstanding == 0){
80102a02:	85 db                	test   %ebx,%ebx
80102a04:	0f 85 e6 00 00 00    	jne    80102af0 <end_op+0x120>
    do_commit = 1;
    log.committing = 1;
80102a0a:	c7 05 e0 16 11 80 01 	movl   $0x1,0x801116e0
80102a11:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102a14:	83 ec 0c             	sub    $0xc,%esp
80102a17:	68 a0 16 11 80       	push   $0x801116a0
80102a1c:	e8 bf 15 00 00       	call   80103fe0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102a21:	83 c4 10             	add    $0x10,%esp
80102a24:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102a2a:	85 c9                	test   %ecx,%ecx
80102a2c:	7f 3a                	jg     80102a68 <end_op+0x98>
    acquire(&log.lock);
80102a2e:	83 ec 0c             	sub    $0xc,%esp
80102a31:	68 a0 16 11 80       	push   $0x801116a0
80102a36:	e8 05 16 00 00       	call   80104040 <acquire>
    log.committing = 0;
80102a3b:	c7 05 e0 16 11 80 00 	movl   $0x0,0x801116e0
80102a42:	00 00 00 
    wakeup(&log);
80102a45:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102a4c:	e8 67 11 00 00       	call   80103bb8 <wakeup>
    release(&log.lock);
80102a51:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102a58:	e8 83 15 00 00       	call   80103fe0 <release>
80102a5d:	83 c4 10             	add    $0x10,%esp
}
80102a60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a63:	5b                   	pop    %ebx
80102a64:	5e                   	pop    %esi
80102a65:	5f                   	pop    %edi
80102a66:	5d                   	pop    %ebp
80102a67:	c3                   	ret    
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102a68:	83 ec 08             	sub    $0x8,%esp
80102a6b:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80102a70:	01 d8                	add    %ebx,%eax
80102a72:	40                   	inc    %eax
80102a73:	50                   	push   %eax
80102a74:	ff 35 e4 16 11 80    	push   0x801116e4
80102a7a:	e8 35 d6 ff ff       	call   801000b4 <bread>
80102a7f:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102a81:	58                   	pop    %eax
80102a82:	5a                   	pop    %edx
80102a83:	ff 34 9d ec 16 11 80 	push   -0x7feee914(,%ebx,4)
80102a8a:	ff 35 e4 16 11 80    	push   0x801116e4
80102a90:	e8 1f d6 ff ff       	call   801000b4 <bread>
80102a95:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102a97:	83 c4 0c             	add    $0xc,%esp
80102a9a:	68 00 02 00 00       	push   $0x200
80102a9f:	8d 40 5c             	lea    0x5c(%eax),%eax
80102aa2:	50                   	push   %eax
80102aa3:	8d 46 5c             	lea    0x5c(%esi),%eax
80102aa6:	50                   	push   %eax
80102aa7:	e8 c0 16 00 00       	call   8010416c <memmove>
    bwrite(to);  // write the log
80102aac:	89 34 24             	mov    %esi,(%esp)
80102aaf:	e8 d0 d6 ff ff       	call   80100184 <bwrite>
    brelse(from);
80102ab4:	89 3c 24             	mov    %edi,(%esp)
80102ab7:	e8 00 d7 ff ff       	call   801001bc <brelse>
    brelse(to);
80102abc:	89 34 24             	mov    %esi,(%esp)
80102abf:	e8 f8 d6 ff ff       	call   801001bc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ac4:	43                   	inc    %ebx
80102ac5:	83 c4 10             	add    $0x10,%esp
80102ac8:	3b 1d e8 16 11 80    	cmp    0x801116e8,%ebx
80102ace:	7c 98                	jl     80102a68 <end_op+0x98>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102ad0:	e8 ab fd ff ff       	call   80102880 <write_head>
    install_trans(); // Now install writes to home locations
80102ad5:	e8 1a fd ff ff       	call   801027f4 <install_trans>
    log.lh.n = 0;
80102ada:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
80102ae1:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ae4:	e8 97 fd ff ff       	call   80102880 <write_head>
80102ae9:	e9 40 ff ff ff       	jmp    80102a2e <end_op+0x5e>
80102aee:	66 90                	xchg   %ax,%ax
    wakeup(&log);
80102af0:	83 ec 0c             	sub    $0xc,%esp
80102af3:	68 a0 16 11 80       	push   $0x801116a0
80102af8:	e8 bb 10 00 00       	call   80103bb8 <wakeup>
  release(&log.lock);
80102afd:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102b04:	e8 d7 14 00 00       	call   80103fe0 <release>
80102b09:	83 c4 10             	add    $0x10,%esp
}
80102b0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b0f:	5b                   	pop    %ebx
80102b10:	5e                   	pop    %esi
80102b11:	5f                   	pop    %edi
80102b12:	5d                   	pop    %ebp
80102b13:	c3                   	ret    
    panic("log.committing");
80102b14:	83 ec 0c             	sub    $0xc,%esp
80102b17:	68 64 6d 10 80       	push   $0x80106d64
80102b1c:	e8 17 d8 ff ff       	call   80100338 <panic>
80102b21:	8d 76 00             	lea    0x0(%esi),%esi

80102b24 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102b24:	55                   	push   %ebp
80102b25:	89 e5                	mov    %esp,%ebp
80102b27:	53                   	push   %ebx
80102b28:	52                   	push   %edx
80102b29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102b2c:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80102b32:	83 fa 1d             	cmp    $0x1d,%edx
80102b35:	7f 79                	jg     80102bb0 <log_write+0x8c>
80102b37:	a1 d8 16 11 80       	mov    0x801116d8,%eax
80102b3c:	48                   	dec    %eax
80102b3d:	39 c2                	cmp    %eax,%edx
80102b3f:	7d 6f                	jge    80102bb0 <log_write+0x8c>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102b41:	a1 dc 16 11 80       	mov    0x801116dc,%eax
80102b46:	85 c0                	test   %eax,%eax
80102b48:	7e 73                	jle    80102bbd <log_write+0x99>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102b4a:	83 ec 0c             	sub    $0xc,%esp
80102b4d:	68 a0 16 11 80       	push   $0x801116a0
80102b52:	e8 e9 14 00 00       	call   80104040 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102b57:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80102b5d:	83 c4 10             	add    $0x10,%esp
80102b60:	85 d2                	test   %edx,%edx
80102b62:	7e 40                	jle    80102ba4 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102b64:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b67:	31 c0                	xor    %eax,%eax
80102b69:	eb 06                	jmp    80102b71 <log_write+0x4d>
80102b6b:	90                   	nop
80102b6c:	40                   	inc    %eax
80102b6d:	39 c2                	cmp    %eax,%edx
80102b6f:	74 23                	je     80102b94 <log_write+0x70>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102b71:	39 0c 85 ec 16 11 80 	cmp    %ecx,-0x7feee914(,%eax,4)
80102b78:	75 f2                	jne    80102b6c <log_write+0x48>
      break;
  }
  log.lh.block[i] = b->blockno;
80102b7a:	89 0c 85 ec 16 11 80 	mov    %ecx,-0x7feee914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102b81:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102b84:	c7 45 08 a0 16 11 80 	movl   $0x801116a0,0x8(%ebp)
}
80102b8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b8e:	c9                   	leave  
  release(&log.lock);
80102b8f:	e9 4c 14 00 00       	jmp    80103fe0 <release>
  log.lh.block[i] = b->blockno;
80102b94:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
    log.lh.n++;
80102b9b:	42                   	inc    %edx
80102b9c:	89 15 e8 16 11 80    	mov    %edx,0x801116e8
80102ba2:	eb dd                	jmp    80102b81 <log_write+0x5d>
  log.lh.block[i] = b->blockno;
80102ba4:	8b 43 08             	mov    0x8(%ebx),%eax
80102ba7:	a3 ec 16 11 80       	mov    %eax,0x801116ec
  if (i == log.lh.n)
80102bac:	75 d3                	jne    80102b81 <log_write+0x5d>
80102bae:	eb eb                	jmp    80102b9b <log_write+0x77>
    panic("too big a transaction");
80102bb0:	83 ec 0c             	sub    $0xc,%esp
80102bb3:	68 73 6d 10 80       	push   $0x80106d73
80102bb8:	e8 7b d7 ff ff       	call   80100338 <panic>
    panic("log_write outside of trans");
80102bbd:	83 ec 0c             	sub    $0xc,%esp
80102bc0:	68 89 6d 10 80       	push   $0x80106d89
80102bc5:	e8 6e d7 ff ff       	call   80100338 <panic>
80102bca:	66 90                	xchg   %ax,%ax

80102bcc <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102bcc:	55                   	push   %ebp
80102bcd:	89 e5                	mov    %esp,%ebp
80102bcf:	53                   	push   %ebx
80102bd0:	50                   	push   %eax
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102bd1:	e8 a2 08 00 00       	call   80103478 <cpuid>
80102bd6:	89 c3                	mov    %eax,%ebx
80102bd8:	e8 9b 08 00 00       	call   80103478 <cpuid>
80102bdd:	52                   	push   %edx
80102bde:	53                   	push   %ebx
80102bdf:	50                   	push   %eax
80102be0:	68 a4 6d 10 80       	push   $0x80106da4
80102be5:	e8 32 da ff ff       	call   8010061c <cprintf>
  idtinit();       // load idt register
80102bea:	e8 75 25 00 00       	call   80105164 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102bef:	e8 20 08 00 00       	call   80103414 <mycpu>
80102bf4:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102bf6:	b8 01 00 00 00       	mov    $0x1,%eax
80102bfb:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102c02:	e8 31 0b 00 00       	call   80103738 <scheduler>
80102c07:	90                   	nop

80102c08 <mpenter>:
{
80102c08:	55                   	push   %ebp
80102c09:	89 e5                	mov    %esp,%ebp
80102c0b:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102c0e:	e8 9d 35 00 00       	call   801061b0 <switchkvm>
  seginit();
80102c13:	e8 14 35 00 00       	call   8010612c <seginit>
  lapicinit();
80102c18:	e8 83 f8 ff ff       	call   801024a0 <lapicinit>
  mpmain();
80102c1d:	e8 aa ff ff ff       	call   80102bcc <mpmain>
80102c22:	66 90                	xchg   %ax,%ax

80102c24 <main>:
{
80102c24:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102c28:	83 e4 f0             	and    $0xfffffff0,%esp
80102c2b:	ff 71 fc             	push   -0x4(%ecx)
80102c2e:	55                   	push   %ebp
80102c2f:	89 e5                	mov    %esp,%ebp
80102c31:	53                   	push   %ebx
80102c32:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102c33:	83 ec 08             	sub    $0x8,%esp
80102c36:	68 00 00 40 80       	push   $0x80400000
80102c3b:	68 d0 54 11 80       	push   $0x801154d0
80102c40:	e8 af f6 ff ff       	call   801022f4 <kinit1>
  kvmalloc();      // kernel page table
80102c45:	e8 ea 39 00 00       	call   80106634 <kvmalloc>
  mpinit();        // detect other processors
80102c4a:	e8 61 01 00 00       	call   80102db0 <mpinit>
  lapicinit();     // interrupt controller
80102c4f:	e8 4c f8 ff ff       	call   801024a0 <lapicinit>
  seginit();       // segment descriptors
80102c54:	e8 d3 34 00 00       	call   8010612c <seginit>
  picinit();       // disable pic
80102c59:	e8 1a 03 00 00       	call   80102f78 <picinit>
  ioapicinit();    // another interrupt controller
80102c5e:	e8 91 f4 ff ff       	call   801020f4 <ioapicinit>
  consoleinit();   // console hardware
80102c63:	e8 40 dd ff ff       	call   801009a8 <consoleinit>
  uartinit();      // serial port
80102c68:	e8 9b 27 00 00       	call   80105408 <uartinit>
  pinit();         // process table
80102c6d:	e8 86 07 00 00       	call   801033f8 <pinit>
  tvinit();        // trap vectors
80102c72:	e8 81 24 00 00       	call   801050f8 <tvinit>
  binit();         // buffer cache
80102c77:	e8 b8 d3 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80102c7c:	e8 a3 e0 ff ff       	call   80100d24 <fileinit>
  ideinit();       // disk 
80102c81:	e8 92 f2 ff ff       	call   80101f18 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102c86:	83 c4 0c             	add    $0xc,%esp
80102c89:	68 8a 00 00 00       	push   $0x8a
80102c8e:	68 8c a4 10 80       	push   $0x8010a48c
80102c93:	68 00 70 00 80       	push   $0x80007000
80102c98:	e8 cf 14 00 00       	call   8010416c <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102c9d:	8b 15 84 17 11 80    	mov    0x80111784,%edx
80102ca3:	8d 04 92             	lea    (%edx,%edx,4),%eax
80102ca6:	01 c0                	add    %eax,%eax
80102ca8:	01 d0                	add    %edx,%eax
80102caa:	c1 e0 04             	shl    $0x4,%eax
80102cad:	05 a0 17 11 80       	add    $0x801117a0,%eax
80102cb2:	83 c4 10             	add    $0x10,%esp
80102cb5:	3d a0 17 11 80       	cmp    $0x801117a0,%eax
80102cba:	76 74                	jbe    80102d30 <main+0x10c>
80102cbc:	bb a0 17 11 80       	mov    $0x801117a0,%ebx
80102cc1:	eb 20                	jmp    80102ce3 <main+0xbf>
80102cc3:	90                   	nop
80102cc4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102cca:	8b 15 84 17 11 80    	mov    0x80111784,%edx
80102cd0:	8d 04 92             	lea    (%edx,%edx,4),%eax
80102cd3:	01 c0                	add    %eax,%eax
80102cd5:	01 d0                	add    %edx,%eax
80102cd7:	c1 e0 04             	shl    $0x4,%eax
80102cda:	05 a0 17 11 80       	add    $0x801117a0,%eax
80102cdf:	39 c3                	cmp    %eax,%ebx
80102ce1:	73 4d                	jae    80102d30 <main+0x10c>
    if(c == mycpu())  // We've started already.
80102ce3:	e8 2c 07 00 00       	call   80103414 <mycpu>
80102ce8:	39 c3                	cmp    %eax,%ebx
80102cea:	74 d8                	je     80102cc4 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102cec:	e8 67 f6 ff ff       	call   80102358 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102cf1:	05 00 10 00 00       	add    $0x1000,%eax
80102cf6:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
80102cfb:	c7 05 f8 6f 00 80 08 	movl   $0x80102c08,0x80006ff8
80102d02:	2c 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102d05:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102d0c:	90 10 00 

    lapicstartap(c->apicid, V2P(code));
80102d0f:	83 ec 08             	sub    $0x8,%esp
80102d12:	68 00 70 00 00       	push   $0x7000
80102d17:	0f b6 03             	movzbl (%ebx),%eax
80102d1a:	50                   	push   %eax
80102d1b:	e8 94 f8 ff ff       	call   801025b4 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102d20:	83 c4 10             	add    $0x10,%esp
80102d23:	90                   	nop
80102d24:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102d2a:	85 c0                	test   %eax,%eax
80102d2c:	74 f6                	je     80102d24 <main+0x100>
80102d2e:	eb 94                	jmp    80102cc4 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102d30:	83 ec 08             	sub    $0x8,%esp
80102d33:	68 00 00 00 8e       	push   $0x8e000000
80102d38:	68 00 00 40 80       	push   $0x80400000
80102d3d:	e8 5e f5 ff ff       	call   801022a0 <kinit2>
  userinit();      // first user process
80102d42:	e8 89 07 00 00       	call   801034d0 <userinit>
  mpmain();        // finish this processor's setup
80102d47:	e8 80 fe ff ff       	call   80102bcc <mpmain>

80102d4c <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102d4c:	55                   	push   %ebp
80102d4d:	89 e5                	mov    %esp,%ebp
80102d4f:	57                   	push   %edi
80102d50:	56                   	push   %esi
80102d51:	53                   	push   %ebx
80102d52:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80102d55:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
  e = addr+len;
80102d5b:	8d 9c 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
80102d62:	39 de                	cmp    %ebx,%esi
80102d64:	72 0b                	jb     80102d71 <mpsearch1+0x25>
80102d66:	eb 3c                	jmp    80102da4 <mpsearch1+0x58>
80102d68:	8d 7e 10             	lea    0x10(%esi),%edi
80102d6b:	89 fe                	mov    %edi,%esi
80102d6d:	39 fb                	cmp    %edi,%ebx
80102d6f:	76 33                	jbe    80102da4 <mpsearch1+0x58>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102d71:	50                   	push   %eax
80102d72:	6a 04                	push   $0x4
80102d74:	68 b8 6d 10 80       	push   $0x80106db8
80102d79:	56                   	push   %esi
80102d7a:	e8 b5 13 00 00       	call   80104134 <memcmp>
80102d7f:	83 c4 10             	add    $0x10,%esp
80102d82:	85 c0                	test   %eax,%eax
80102d84:	75 e2                	jne    80102d68 <mpsearch1+0x1c>
80102d86:	89 f2                	mov    %esi,%edx
80102d88:	8d 7e 10             	lea    0x10(%esi),%edi
80102d8b:	90                   	nop
    sum += addr[i];
80102d8c:	0f b6 0a             	movzbl (%edx),%ecx
80102d8f:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80102d91:	42                   	inc    %edx
80102d92:	39 fa                	cmp    %edi,%edx
80102d94:	75 f6                	jne    80102d8c <mpsearch1+0x40>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102d96:	84 c0                	test   %al,%al
80102d98:	75 d1                	jne    80102d6b <mpsearch1+0x1f>
      return (struct mp*)p;
  return 0;
}
80102d9a:	89 f0                	mov    %esi,%eax
80102d9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d9f:	5b                   	pop    %ebx
80102da0:	5e                   	pop    %esi
80102da1:	5f                   	pop    %edi
80102da2:	5d                   	pop    %ebp
80102da3:	c3                   	ret    
  return 0;
80102da4:	31 f6                	xor    %esi,%esi
}
80102da6:	89 f0                	mov    %esi,%eax
80102da8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dab:	5b                   	pop    %ebx
80102dac:	5e                   	pop    %esi
80102dad:	5f                   	pop    %edi
80102dae:	5d                   	pop    %ebp
80102daf:	c3                   	ret    

80102db0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102db0:	55                   	push   %ebp
80102db1:	89 e5                	mov    %esp,%ebp
80102db3:	57                   	push   %edi
80102db4:	56                   	push   %esi
80102db5:	53                   	push   %ebx
80102db6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102db9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102dc0:	c1 e0 08             	shl    $0x8,%eax
80102dc3:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102dca:	09 d0                	or     %edx,%eax
80102dcc:	c1 e0 04             	shl    $0x4,%eax
80102dcf:	75 1b                	jne    80102dec <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102dd1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102dd8:	c1 e0 08             	shl    $0x8,%eax
80102ddb:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102de2:	09 d0                	or     %edx,%eax
80102de4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102de7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80102dec:	ba 00 04 00 00       	mov    $0x400,%edx
80102df1:	e8 56 ff ff ff       	call   80102d4c <mpsearch1>
80102df6:	89 c3                	mov    %eax,%ebx
80102df8:	85 c0                	test   %eax,%eax
80102dfa:	0f 84 28 01 00 00    	je     80102f28 <mpinit+0x178>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102e00:	8b 73 04             	mov    0x4(%ebx),%esi
80102e03:	85 f6                	test   %esi,%esi
80102e05:	0f 84 0d 01 00 00    	je     80102f18 <mpinit+0x168>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80102e0b:	8d be 00 00 00 80    	lea    -0x80000000(%esi),%edi
  if(memcmp(conf, "PCMP", 4) != 0)
80102e11:	50                   	push   %eax
80102e12:	6a 04                	push   $0x4
80102e14:	68 bd 6d 10 80       	push   $0x80106dbd
80102e19:	57                   	push   %edi
80102e1a:	e8 15 13 00 00       	call   80104134 <memcmp>
80102e1f:	83 c4 10             	add    $0x10,%esp
80102e22:	85 c0                	test   %eax,%eax
80102e24:	0f 85 ee 00 00 00    	jne    80102f18 <mpinit+0x168>
  if(conf->version != 1 && conf->version != 4)
80102e2a:	8a 86 06 00 00 80    	mov    -0x7ffffffa(%esi),%al
80102e30:	3c 01                	cmp    $0x1,%al
80102e32:	74 08                	je     80102e3c <mpinit+0x8c>
80102e34:	3c 04                	cmp    $0x4,%al
80102e36:	0f 85 dc 00 00 00    	jne    80102f18 <mpinit+0x168>
  if(sum((uchar*)conf, conf->length) != 0)
80102e3c:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80102e43:	66 85 d2             	test   %dx,%dx
80102e46:	74 1f                	je     80102e67 <mpinit+0xb7>
80102e48:	89 f8                	mov    %edi,%eax
80102e4a:	8d 0c 17             	lea    (%edi,%edx,1),%ecx
80102e4d:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  sum = 0;
80102e50:	31 d2                	xor    %edx,%edx
80102e52:	66 90                	xchg   %ax,%ax
    sum += addr[i];
80102e54:	0f b6 08             	movzbl (%eax),%ecx
80102e57:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80102e59:	40                   	inc    %eax
80102e5a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
80102e5d:	75 f5                	jne    80102e54 <mpinit+0xa4>
  if(sum((uchar*)conf, conf->length) != 0)
80102e5f:	84 d2                	test   %dl,%dl
80102e61:	0f 85 b1 00 00 00    	jne    80102f18 <mpinit+0x168>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80102e67:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80102e6d:	a3 80 16 11 80       	mov    %eax,0x80111680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102e72:	8d 96 2c 00 00 80    	lea    -0x7fffffd4(%esi),%edx
80102e78:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
80102e7f:	01 f9                	add    %edi,%ecx
  ismp = 1;
80102e81:	be 01 00 00 00       	mov    $0x1,%esi
80102e86:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80102e89:	8d 76 00             	lea    0x0(%esi),%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102e8c:	39 ca                	cmp    %ecx,%edx
80102e8e:	73 13                	jae    80102ea3 <mpinit+0xf3>
    switch(*p){
80102e90:	8a 02                	mov    (%edx),%al
80102e92:	3c 02                	cmp    $0x2,%al
80102e94:	74 46                	je     80102edc <mpinit+0x12c>
80102e96:	77 38                	ja     80102ed0 <mpinit+0x120>
80102e98:	84 c0                	test   %al,%al
80102e9a:	74 50                	je     80102eec <mpinit+0x13c>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80102e9c:	83 c2 08             	add    $0x8,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102e9f:	39 ca                	cmp    %ecx,%edx
80102ea1:	72 ed                	jb     80102e90 <mpinit+0xe0>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80102ea3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80102ea6:	85 f6                	test   %esi,%esi
80102ea8:	0f 84 bd 00 00 00    	je     80102f6b <mpinit+0x1bb>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80102eae:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80102eb2:	74 12                	je     80102ec6 <mpinit+0x116>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102eb4:	b0 70                	mov    $0x70,%al
80102eb6:	ba 22 00 00 00       	mov    $0x22,%edx
80102ebb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ebc:	ba 23 00 00 00       	mov    $0x23,%edx
80102ec1:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80102ec2:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ec5:	ee                   	out    %al,(%dx)
  }
}
80102ec6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ec9:	5b                   	pop    %ebx
80102eca:	5e                   	pop    %esi
80102ecb:	5f                   	pop    %edi
80102ecc:	5d                   	pop    %ebp
80102ecd:	c3                   	ret    
80102ece:	66 90                	xchg   %ax,%ax
    switch(*p){
80102ed0:	83 e8 03             	sub    $0x3,%eax
80102ed3:	3c 01                	cmp    $0x1,%al
80102ed5:	76 c5                	jbe    80102e9c <mpinit+0xec>
80102ed7:	31 f6                	xor    %esi,%esi
80102ed9:	eb b1                	jmp    80102e8c <mpinit+0xdc>
80102edb:	90                   	nop
      ioapicid = ioapic->apicno;
80102edc:	8a 42 01             	mov    0x1(%edx),%al
80102edf:	a2 80 17 11 80       	mov    %al,0x80111780
      p += sizeof(struct mpioapic);
80102ee4:	83 c2 08             	add    $0x8,%edx
      continue;
80102ee7:	eb a3                	jmp    80102e8c <mpinit+0xdc>
80102ee9:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80102eec:	a1 84 17 11 80       	mov    0x80111784,%eax
80102ef1:	83 f8 07             	cmp    $0x7,%eax
80102ef4:	7f 19                	jg     80102f0f <mpinit+0x15f>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80102ef6:	8d 3c 80             	lea    (%eax,%eax,4),%edi
80102ef9:	01 ff                	add    %edi,%edi
80102efb:	01 c7                	add    %eax,%edi
80102efd:	c1 e7 04             	shl    $0x4,%edi
80102f00:	8a 5a 01             	mov    0x1(%edx),%bl
80102f03:	88 9f a0 17 11 80    	mov    %bl,-0x7feee860(%edi)
        ncpu++;
80102f09:	40                   	inc    %eax
80102f0a:	a3 84 17 11 80       	mov    %eax,0x80111784
      p += sizeof(struct mpproc);
80102f0f:	83 c2 14             	add    $0x14,%edx
      continue;
80102f12:	e9 75 ff ff ff       	jmp    80102e8c <mpinit+0xdc>
80102f17:	90                   	nop
    panic("Expect to run on an SMP");
80102f18:	83 ec 0c             	sub    $0xc,%esp
80102f1b:	68 c2 6d 10 80       	push   $0x80106dc2
80102f20:	e8 13 d4 ff ff       	call   80100338 <panic>
80102f25:	8d 76 00             	lea    0x0(%esi),%esi
{
80102f28:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80102f2d:	eb 0e                	jmp    80102f3d <mpinit+0x18d>
80102f2f:	90                   	nop
80102f30:	8d 73 10             	lea    0x10(%ebx),%esi
  for(p = addr; p < e; p += sizeof(struct mp))
80102f33:	89 f3                	mov    %esi,%ebx
80102f35:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80102f3b:	74 db                	je     80102f18 <mpinit+0x168>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f3d:	52                   	push   %edx
80102f3e:	6a 04                	push   $0x4
80102f40:	68 b8 6d 10 80       	push   $0x80106db8
80102f45:	53                   	push   %ebx
80102f46:	e8 e9 11 00 00       	call   80104134 <memcmp>
80102f4b:	83 c4 10             	add    $0x10,%esp
80102f4e:	85 c0                	test   %eax,%eax
80102f50:	75 de                	jne    80102f30 <mpinit+0x180>
80102f52:	89 da                	mov    %ebx,%edx
80102f54:	8d 73 10             	lea    0x10(%ebx),%esi
80102f57:	90                   	nop
    sum += addr[i];
80102f58:	0f b6 0a             	movzbl (%edx),%ecx
80102f5b:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80102f5d:	42                   	inc    %edx
80102f5e:	39 d6                	cmp    %edx,%esi
80102f60:	75 f6                	jne    80102f58 <mpinit+0x1a8>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f62:	84 c0                	test   %al,%al
80102f64:	75 cd                	jne    80102f33 <mpinit+0x183>
80102f66:	e9 95 fe ff ff       	jmp    80102e00 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80102f6b:	83 ec 0c             	sub    $0xc,%esp
80102f6e:	68 dc 6d 10 80       	push   $0x80106ddc
80102f73:	e8 c0 d3 ff ff       	call   80100338 <panic>

80102f78 <picinit>:
80102f78:	b0 ff                	mov    $0xff,%al
80102f7a:	ba 21 00 00 00       	mov    $0x21,%edx
80102f7f:	ee                   	out    %al,(%dx)
80102f80:	ba a1 00 00 00       	mov    $0xa1,%edx
80102f85:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80102f86:	c3                   	ret    
80102f87:	90                   	nop

80102f88 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80102f88:	55                   	push   %ebp
80102f89:	89 e5                	mov    %esp,%ebp
80102f8b:	57                   	push   %edi
80102f8c:	56                   	push   %esi
80102f8d:	53                   	push   %ebx
80102f8e:	83 ec 0c             	sub    $0xc,%esp
80102f91:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102f94:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80102f97:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80102f9d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80102fa3:	e8 98 dd ff ff       	call   80100d40 <filealloc>
80102fa8:	89 03                	mov    %eax,(%ebx)
80102faa:	85 c0                	test   %eax,%eax
80102fac:	0f 84 a8 00 00 00    	je     8010305a <pipealloc+0xd2>
80102fb2:	e8 89 dd ff ff       	call   80100d40 <filealloc>
80102fb7:	89 06                	mov    %eax,(%esi)
80102fb9:	85 c0                	test   %eax,%eax
80102fbb:	0f 84 87 00 00 00    	je     80103048 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80102fc1:	e8 92 f3 ff ff       	call   80102358 <kalloc>
80102fc6:	89 c7                	mov    %eax,%edi
80102fc8:	85 c0                	test   %eax,%eax
80102fca:	0f 84 ac 00 00 00    	je     8010307c <pipealloc+0xf4>
    goto bad;
  p->readopen = 1;
80102fd0:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80102fd7:	00 00 00 
  p->writeopen = 1;
80102fda:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80102fe1:	00 00 00 
  p->nwrite = 0;
80102fe4:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80102feb:	00 00 00 
  p->nread = 0;
80102fee:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80102ff5:	00 00 00 
  initlock(&p->lock, "pipe");
80102ff8:	83 ec 08             	sub    $0x8,%esp
80102ffb:	68 fb 6d 10 80       	push   $0x80106dfb
80103000:	50                   	push   %eax
80103001:	e8 82 0e 00 00       	call   80103e88 <initlock>
  (*f0)->type = FD_PIPE;
80103006:	8b 03                	mov    (%ebx),%eax
80103008:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010300e:	8b 03                	mov    (%ebx),%eax
80103010:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103014:	8b 03                	mov    (%ebx),%eax
80103016:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010301a:	8b 03                	mov    (%ebx),%eax
8010301c:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010301f:	8b 06                	mov    (%esi),%eax
80103021:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103027:	8b 06                	mov    (%esi),%eax
80103029:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010302d:	8b 06                	mov    (%esi),%eax
8010302f:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103033:	8b 06                	mov    (%esi),%eax
80103035:	89 78 0c             	mov    %edi,0xc(%eax)
  return 0;
80103038:	83 c4 10             	add    $0x10,%esp
8010303b:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
8010303d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103040:	5b                   	pop    %ebx
80103041:	5e                   	pop    %esi
80103042:	5f                   	pop    %edi
80103043:	5d                   	pop    %ebp
80103044:	c3                   	ret    
80103045:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103048:	8b 03                	mov    (%ebx),%eax
8010304a:	85 c0                	test   %eax,%eax
8010304c:	74 1e                	je     8010306c <pipealloc+0xe4>
    fileclose(*f0);
8010304e:	83 ec 0c             	sub    $0xc,%esp
80103051:	50                   	push   %eax
80103052:	e8 8d dd ff ff       	call   80100de4 <fileclose>
80103057:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010305a:	8b 06                	mov    (%esi),%eax
8010305c:	85 c0                	test   %eax,%eax
8010305e:	74 0c                	je     8010306c <pipealloc+0xe4>
    fileclose(*f1);
80103060:	83 ec 0c             	sub    $0xc,%esp
80103063:	50                   	push   %eax
80103064:	e8 7b dd ff ff       	call   80100de4 <fileclose>
80103069:	83 c4 10             	add    $0x10,%esp
  return -1;
8010306c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103071:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103074:	5b                   	pop    %ebx
80103075:	5e                   	pop    %esi
80103076:	5f                   	pop    %edi
80103077:	5d                   	pop    %ebp
80103078:	c3                   	ret    
80103079:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
8010307c:	8b 03                	mov    (%ebx),%eax
8010307e:	85 c0                	test   %eax,%eax
80103080:	75 cc                	jne    8010304e <pipealloc+0xc6>
80103082:	eb d6                	jmp    8010305a <pipealloc+0xd2>

80103084 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103084:	55                   	push   %ebp
80103085:	89 e5                	mov    %esp,%ebp
80103087:	56                   	push   %esi
80103088:	53                   	push   %ebx
80103089:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010308c:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010308f:	83 ec 0c             	sub    $0xc,%esp
80103092:	53                   	push   %ebx
80103093:	e8 a8 0f 00 00       	call   80104040 <acquire>
  if(writable){
80103098:	83 c4 10             	add    $0x10,%esp
8010309b:	85 f6                	test   %esi,%esi
8010309d:	74 5d                	je     801030fc <pipeclose+0x78>
    p->writeopen = 0;
8010309f:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801030a6:	00 00 00 
    wakeup(&p->nread);
801030a9:	83 ec 0c             	sub    $0xc,%esp
801030ac:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801030b2:	50                   	push   %eax
801030b3:	e8 00 0b 00 00       	call   80103bb8 <wakeup>
801030b8:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801030bb:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801030c1:	85 d2                	test   %edx,%edx
801030c3:	75 0a                	jne    801030cf <pipeclose+0x4b>
801030c5:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801030cb:	85 c0                	test   %eax,%eax
801030cd:	74 11                	je     801030e0 <pipeclose+0x5c>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801030cf:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801030d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801030d5:	5b                   	pop    %ebx
801030d6:	5e                   	pop    %esi
801030d7:	5d                   	pop    %ebp
    release(&p->lock);
801030d8:	e9 03 0f 00 00       	jmp    80103fe0 <release>
801030dd:	8d 76 00             	lea    0x0(%esi),%esi
    release(&p->lock);
801030e0:	83 ec 0c             	sub    $0xc,%esp
801030e3:	53                   	push   %ebx
801030e4:	e8 f7 0e 00 00       	call   80103fe0 <release>
    kfree((char*)p);
801030e9:	83 c4 10             	add    $0x10,%esp
801030ec:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801030ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801030f2:	5b                   	pop    %ebx
801030f3:	5e                   	pop    %esi
801030f4:	5d                   	pop    %ebp
    kfree((char*)p);
801030f5:	e9 ce f0 ff ff       	jmp    801021c8 <kfree>
801030fa:	66 90                	xchg   %ax,%ax
    p->readopen = 0;
801030fc:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103103:	00 00 00 
    wakeup(&p->nwrite);
80103106:	83 ec 0c             	sub    $0xc,%esp
80103109:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010310f:	50                   	push   %eax
80103110:	e8 a3 0a 00 00       	call   80103bb8 <wakeup>
80103115:	83 c4 10             	add    $0x10,%esp
80103118:	eb a1                	jmp    801030bb <pipeclose+0x37>
8010311a:	66 90                	xchg   %ax,%ax

8010311c <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
8010311c:	55                   	push   %ebp
8010311d:	89 e5                	mov    %esp,%ebp
8010311f:	57                   	push   %edi
80103120:	56                   	push   %esi
80103121:	53                   	push   %ebx
80103122:	83 ec 28             	sub    $0x28,%esp
80103125:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103128:	53                   	push   %ebx
80103129:	e8 12 0f 00 00       	call   80104040 <acquire>
  for(i = 0; i < n; i++){
8010312e:	83 c4 10             	add    $0x10,%esp
80103131:	8b 45 10             	mov    0x10(%ebp),%eax
80103134:	85 c0                	test   %eax,%eax
80103136:	0f 8e b1 00 00 00    	jle    801031ed <pipewrite+0xd1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010313c:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103142:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103145:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103148:	03 4d 10             	add    0x10(%ebp),%ecx
8010314b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010314e:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103154:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010315a:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103160:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103166:	39 d0                	cmp    %edx,%eax
80103168:	74 38                	je     801031a2 <pipewrite+0x86>
8010316a:	eb 59                	jmp    801031c5 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
8010316c:	e8 3b 03 00 00       	call   801034ac <myproc>
80103171:	8b 48 24             	mov    0x24(%eax),%ecx
80103174:	85 c9                	test   %ecx,%ecx
80103176:	75 34                	jne    801031ac <pipewrite+0x90>
      wakeup(&p->nread);
80103178:	83 ec 0c             	sub    $0xc,%esp
8010317b:	57                   	push   %edi
8010317c:	e8 37 0a 00 00       	call   80103bb8 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103181:	58                   	pop    %eax
80103182:	5a                   	pop    %edx
80103183:	53                   	push   %ebx
80103184:	56                   	push   %esi
80103185:	e8 72 09 00 00       	call   80103afc <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010318a:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103190:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103196:	05 00 02 00 00       	add    $0x200,%eax
8010319b:	83 c4 10             	add    $0x10,%esp
8010319e:	39 c2                	cmp    %eax,%edx
801031a0:	75 26                	jne    801031c8 <pipewrite+0xac>
      if(p->readopen == 0 || myproc()->killed){
801031a2:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801031a8:	85 c0                	test   %eax,%eax
801031aa:	75 c0                	jne    8010316c <pipewrite+0x50>
        release(&p->lock);
801031ac:	83 ec 0c             	sub    $0xc,%esp
801031af:	53                   	push   %ebx
801031b0:	e8 2b 0e 00 00       	call   80103fe0 <release>
        return -1;
801031b5:	83 c4 10             	add    $0x10,%esp
801031b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801031bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031c0:	5b                   	pop    %ebx
801031c1:	5e                   	pop    %esi
801031c2:	5f                   	pop    %edi
801031c3:	5d                   	pop    %ebp
801031c4:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801031c5:	89 c2                	mov    %eax,%edx
801031c7:	90                   	nop
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801031c8:	8d 42 01             	lea    0x1(%edx),%eax
801031cb:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801031d1:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801031d4:	8a 0e                	mov    (%esi),%cl
801031d6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801031dc:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801031e0:	46                   	inc    %esi
801031e1:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801031e4:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801031e7:	0f 85 67 ff ff ff    	jne    80103154 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801031ed:	83 ec 0c             	sub    $0xc,%esp
801031f0:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801031f6:	50                   	push   %eax
801031f7:	e8 bc 09 00 00       	call   80103bb8 <wakeup>
  release(&p->lock);
801031fc:	89 1c 24             	mov    %ebx,(%esp)
801031ff:	e8 dc 0d 00 00       	call   80103fe0 <release>
  return n;
80103204:	83 c4 10             	add    $0x10,%esp
80103207:	8b 45 10             	mov    0x10(%ebp),%eax
8010320a:	eb b1                	jmp    801031bd <pipewrite+0xa1>

8010320c <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
8010320c:	55                   	push   %ebp
8010320d:	89 e5                	mov    %esp,%ebp
8010320f:	57                   	push   %edi
80103210:	56                   	push   %esi
80103211:	53                   	push   %ebx
80103212:	83 ec 18             	sub    $0x18,%esp
80103215:	8b 75 08             	mov    0x8(%ebp),%esi
80103218:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010321b:	56                   	push   %esi
8010321c:	e8 1f 0e 00 00       	call   80104040 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103221:	83 c4 10             	add    $0x10,%esp
80103224:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010322a:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103230:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103236:	74 2f                	je     80103267 <piperead+0x5b>
80103238:	eb 37                	jmp    80103271 <piperead+0x65>
8010323a:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
8010323c:	e8 6b 02 00 00       	call   801034ac <myproc>
80103241:	8b 48 24             	mov    0x24(%eax),%ecx
80103244:	85 c9                	test   %ecx,%ecx
80103246:	0f 85 80 00 00 00    	jne    801032cc <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010324c:	83 ec 08             	sub    $0x8,%esp
8010324f:	56                   	push   %esi
80103250:	53                   	push   %ebx
80103251:	e8 a6 08 00 00       	call   80103afc <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103256:	83 c4 10             	add    $0x10,%esp
80103259:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
8010325f:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103265:	75 0a                	jne    80103271 <piperead+0x65>
80103267:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
8010326d:	85 c0                	test   %eax,%eax
8010326f:	75 cb                	jne    8010323c <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103271:	31 db                	xor    %ebx,%ebx
80103273:	8b 55 10             	mov    0x10(%ebp),%edx
80103276:	85 d2                	test   %edx,%edx
80103278:	7f 1d                	jg     80103297 <piperead+0x8b>
8010327a:	eb 29                	jmp    801032a5 <piperead+0x99>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010327c:	8d 48 01             	lea    0x1(%eax),%ecx
8010327f:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103285:	25 ff 01 00 00       	and    $0x1ff,%eax
8010328a:	8a 44 06 34          	mov    0x34(%esi,%eax,1),%al
8010328e:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103291:	43                   	inc    %ebx
80103292:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103295:	74 0e                	je     801032a5 <piperead+0x99>
    if(p->nread == p->nwrite)
80103297:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010329d:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801032a3:	75 d7                	jne    8010327c <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801032a5:	83 ec 0c             	sub    $0xc,%esp
801032a8:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801032ae:	50                   	push   %eax
801032af:	e8 04 09 00 00       	call   80103bb8 <wakeup>
  release(&p->lock);
801032b4:	89 34 24             	mov    %esi,(%esp)
801032b7:	e8 24 0d 00 00       	call   80103fe0 <release>
  return i;
801032bc:	83 c4 10             	add    $0x10,%esp
}
801032bf:	89 d8                	mov    %ebx,%eax
801032c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032c4:	5b                   	pop    %ebx
801032c5:	5e                   	pop    %esi
801032c6:	5f                   	pop    %edi
801032c7:	5d                   	pop    %ebp
801032c8:	c3                   	ret    
801032c9:	8d 76 00             	lea    0x0(%esi),%esi
      release(&p->lock);
801032cc:	83 ec 0c             	sub    $0xc,%esp
801032cf:	56                   	push   %esi
801032d0:	e8 0b 0d 00 00       	call   80103fe0 <release>
      return -1;
801032d5:	83 c4 10             	add    $0x10,%esp
801032d8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801032dd:	89 d8                	mov    %ebx,%eax
801032df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032e2:	5b                   	pop    %ebx
801032e3:	5e                   	pop    %esi
801032e4:	5f                   	pop    %edi
801032e5:	5d                   	pop    %ebp
801032e6:	c3                   	ret    
801032e7:	90                   	nop

801032e8 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801032e8:	55                   	push   %ebp
801032e9:	89 e5                	mov    %esp,%ebp
801032eb:	53                   	push   %ebx
801032ec:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801032ef:	68 20 1d 11 80       	push   $0x80111d20
801032f4:	e8 47 0d 00 00       	call   80104040 <acquire>
801032f9:	83 c4 10             	add    $0x10,%esp

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801032fc:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
80103301:	eb 0c                	jmp    8010330f <allocproc+0x27>
80103303:	90                   	nop
80103304:	83 c3 7c             	add    $0x7c,%ebx
80103307:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
8010330d:	74 75                	je     80103384 <allocproc+0x9c>
    if(p->state == UNUSED)
8010330f:	8b 4b 0c             	mov    0xc(%ebx),%ecx
80103312:	85 c9                	test   %ecx,%ecx
80103314:	75 ee                	jne    80103304 <allocproc+0x1c>

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80103316:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
8010331d:	a1 04 a0 10 80       	mov    0x8010a004,%eax
80103322:	8d 50 01             	lea    0x1(%eax),%edx
80103325:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
8010332b:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
8010332e:	83 ec 0c             	sub    $0xc,%esp
80103331:	68 20 1d 11 80       	push   $0x80111d20
80103336:	e8 a5 0c 00 00       	call   80103fe0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010333b:	e8 18 f0 ff ff       	call   80102358 <kalloc>
80103340:	89 43 08             	mov    %eax,0x8(%ebx)
80103343:	83 c4 10             	add    $0x10,%esp
80103346:	85 c0                	test   %eax,%eax
80103348:	74 53                	je     8010339d <allocproc+0xb5>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010334a:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
80103350:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103353:	c7 80 b0 0f 00 00 ed 	movl   $0x801050ed,0xfb0(%eax)
8010335a:	50 10 80 

  sp -= sizeof *p->context;
8010335d:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->context = (struct context*)sp;
80103362:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103365:	52                   	push   %edx
80103366:	6a 14                	push   $0x14
80103368:	6a 00                	push   $0x0
8010336a:	50                   	push   %eax
8010336b:	e8 78 0d 00 00       	call   801040e8 <memset>
  p->context->eip = (uint)forkret;
80103370:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103373:	c7 40 10 b0 33 10 80 	movl   $0x801033b0,0x10(%eax)

  return p;
8010337a:	83 c4 10             	add    $0x10,%esp
}
8010337d:	89 d8                	mov    %ebx,%eax
8010337f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103382:	c9                   	leave  
80103383:	c3                   	ret    
  release(&ptable.lock);
80103384:	83 ec 0c             	sub    $0xc,%esp
80103387:	68 20 1d 11 80       	push   $0x80111d20
8010338c:	e8 4f 0c 00 00       	call   80103fe0 <release>
  return 0;
80103391:	83 c4 10             	add    $0x10,%esp
80103394:	31 db                	xor    %ebx,%ebx
}
80103396:	89 d8                	mov    %ebx,%eax
80103398:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010339b:	c9                   	leave  
8010339c:	c3                   	ret    
    p->state = UNUSED;
8010339d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801033a4:	31 db                	xor    %ebx,%ebx
}
801033a6:	89 d8                	mov    %ebx,%eax
801033a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801033ab:	c9                   	leave  
801033ac:	c3                   	ret    
801033ad:	8d 76 00             	lea    0x0(%esi),%esi

801033b0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801033b0:	55                   	push   %ebp
801033b1:	89 e5                	mov    %esp,%ebp
801033b3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801033b6:	68 20 1d 11 80       	push   $0x80111d20
801033bb:	e8 20 0c 00 00       	call   80103fe0 <release>

  if (first) {
801033c0:	83 c4 10             	add    $0x10,%esp
801033c3:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801033c8:	85 c0                	test   %eax,%eax
801033ca:	75 04                	jne    801033d0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801033cc:	c9                   	leave  
801033cd:	c3                   	ret    
801033ce:	66 90                	xchg   %ax,%ax
    first = 0;
801033d0:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801033d7:	00 00 00 
    iinit(ROOTDEV);
801033da:	83 ec 0c             	sub    $0xc,%esp
801033dd:	6a 01                	push   $0x1
801033df:	e8 dc df ff ff       	call   801013c0 <iinit>
    initlog(ROOTDEV);
801033e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801033eb:	e8 e8 f4 ff ff       	call   801028d8 <initlog>
}
801033f0:	83 c4 10             	add    $0x10,%esp
801033f3:	c9                   	leave  
801033f4:	c3                   	ret    
801033f5:	8d 76 00             	lea    0x0(%esi),%esi

801033f8 <pinit>:
{
801033f8:	55                   	push   %ebp
801033f9:	89 e5                	mov    %esp,%ebp
801033fb:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801033fe:	68 00 6e 10 80       	push   $0x80106e00
80103403:	68 20 1d 11 80       	push   $0x80111d20
80103408:	e8 7b 0a 00 00       	call   80103e88 <initlock>
}
8010340d:	83 c4 10             	add    $0x10,%esp
80103410:	c9                   	leave  
80103411:	c3                   	ret    
80103412:	66 90                	xchg   %ax,%ax

80103414 <mycpu>:
{
80103414:	55                   	push   %ebp
80103415:	89 e5                	mov    %esp,%ebp
80103417:	56                   	push   %esi
80103418:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103419:	9c                   	pushf  
8010341a:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010341b:	f6 c4 02             	test   $0x2,%ah
8010341e:	75 4b                	jne    8010346b <mycpu+0x57>
  apicid = lapicid();
80103420:	e8 5f f1 ff ff       	call   80102584 <lapicid>
80103425:	89 c1                	mov    %eax,%ecx
  for (i = 0; i < ncpu; ++i) {
80103427:	8b 1d 84 17 11 80    	mov    0x80111784,%ebx
8010342d:	85 db                	test   %ebx,%ebx
8010342f:	7e 2d                	jle    8010345e <mycpu+0x4a>
80103431:	31 d2                	xor    %edx,%edx
80103433:	eb 08                	jmp    8010343d <mycpu+0x29>
80103435:	8d 76 00             	lea    0x0(%esi),%esi
80103438:	42                   	inc    %edx
80103439:	39 da                	cmp    %ebx,%edx
8010343b:	74 21                	je     8010345e <mycpu+0x4a>
    if (cpus[i].apicid == apicid)
8010343d:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103440:	01 c0                	add    %eax,%eax
80103442:	01 d0                	add    %edx,%eax
80103444:	c1 e0 04             	shl    $0x4,%eax
80103447:	0f b6 b0 a0 17 11 80 	movzbl -0x7feee860(%eax),%esi
8010344e:	39 ce                	cmp    %ecx,%esi
80103450:	75 e6                	jne    80103438 <mycpu+0x24>
      return &cpus[i];
80103452:	05 a0 17 11 80       	add    $0x801117a0,%eax
}
80103457:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010345a:	5b                   	pop    %ebx
8010345b:	5e                   	pop    %esi
8010345c:	5d                   	pop    %ebp
8010345d:	c3                   	ret    
  panic("unknown apicid\n");
8010345e:	83 ec 0c             	sub    $0xc,%esp
80103461:	68 07 6e 10 80       	push   $0x80106e07
80103466:	e8 cd ce ff ff       	call   80100338 <panic>
    panic("mycpu called with interrupts enabled\n");
8010346b:	83 ec 0c             	sub    $0xc,%esp
8010346e:	68 e4 6e 10 80       	push   $0x80106ee4
80103473:	e8 c0 ce ff ff       	call   80100338 <panic>

80103478 <cpuid>:
cpuid() {
80103478:	55                   	push   %ebp
80103479:	89 e5                	mov    %esp,%ebp
8010347b:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
8010347e:	e8 91 ff ff ff       	call   80103414 <mycpu>
80103483:	2d a0 17 11 80       	sub    $0x801117a0,%eax
80103488:	c1 f8 04             	sar    $0x4,%eax
8010348b:	8d 0c c0             	lea    (%eax,%eax,8),%ecx
8010348e:	89 ca                	mov    %ecx,%edx
80103490:	c1 e2 05             	shl    $0x5,%edx
80103493:	29 ca                	sub    %ecx,%edx
80103495:	8d 14 90             	lea    (%eax,%edx,4),%edx
80103498:	8d 0c d0             	lea    (%eax,%edx,8),%ecx
8010349b:	89 ca                	mov    %ecx,%edx
8010349d:	c1 e2 0f             	shl    $0xf,%edx
801034a0:	29 ca                	sub    %ecx,%edx
801034a2:	8d 04 90             	lea    (%eax,%edx,4),%eax
801034a5:	f7 d8                	neg    %eax
}
801034a7:	c9                   	leave  
801034a8:	c3                   	ret    
801034a9:	8d 76 00             	lea    0x0(%esi),%esi

801034ac <myproc>:
myproc(void) {
801034ac:	55                   	push   %ebp
801034ad:	89 e5                	mov    %esp,%ebp
801034af:	83 ec 18             	sub    $0x18,%esp
  pushcli();
801034b2:	e8 3d 0a 00 00       	call   80103ef4 <pushcli>
  c = mycpu();
801034b7:	e8 58 ff ff ff       	call   80103414 <mycpu>
  p = c->proc;
801034bc:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801034c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  popcli();
801034c5:	e8 76 0a 00 00       	call   80103f40 <popcli>
}
801034ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034cd:	c9                   	leave  
801034ce:	c3                   	ret    
801034cf:	90                   	nop

801034d0 <userinit>:
{
801034d0:	55                   	push   %ebp
801034d1:	89 e5                	mov    %esp,%ebp
801034d3:	53                   	push   %ebx
801034d4:	51                   	push   %ecx
  p = allocproc();
801034d5:	e8 0e fe ff ff       	call   801032e8 <allocproc>
801034da:	89 c3                	mov    %eax,%ebx
  initproc = p;
801034dc:	a3 54 3c 11 80       	mov    %eax,0x80113c54
  if((p->pgdir = setupkvm()) == 0)
801034e1:	e8 da 30 00 00       	call   801065c0 <setupkvm>
801034e6:	89 43 04             	mov    %eax,0x4(%ebx)
801034e9:	85 c0                	test   %eax,%eax
801034eb:	0f 84 b3 00 00 00    	je     801035a4 <userinit+0xd4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801034f1:	52                   	push   %edx
801034f2:	68 2c 00 00 00       	push   $0x2c
801034f7:	68 60 a4 10 80       	push   $0x8010a460
801034fc:	50                   	push   %eax
801034fd:	e8 ba 2d 00 00       	call   801062bc <inituvm>
  p->sz = PGSIZE;
80103502:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103508:	83 c4 0c             	add    $0xc,%esp
8010350b:	6a 4c                	push   $0x4c
8010350d:	6a 00                	push   $0x0
8010350f:	ff 73 18             	push   0x18(%ebx)
80103512:	e8 d1 0b 00 00       	call   801040e8 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103517:	8b 43 18             	mov    0x18(%ebx),%eax
8010351a:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103520:	8b 43 18             	mov    0x18(%ebx),%eax
80103523:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103529:	8b 43 18             	mov    0x18(%ebx),%eax
8010352c:	8b 50 2c             	mov    0x2c(%eax),%edx
8010352f:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103533:	8b 43 18             	mov    0x18(%ebx),%eax
80103536:	8b 50 2c             	mov    0x2c(%eax),%edx
80103539:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010353d:	8b 43 18             	mov    0x18(%ebx),%eax
80103540:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103547:	8b 43 18             	mov    0x18(%ebx),%eax
8010354a:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103551:	8b 43 18             	mov    0x18(%ebx),%eax
80103554:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010355b:	83 c4 0c             	add    $0xc,%esp
8010355e:	6a 10                	push   $0x10
80103560:	68 30 6e 10 80       	push   $0x80106e30
80103565:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103568:	50                   	push   %eax
80103569:	e8 ce 0c 00 00       	call   8010423c <safestrcpy>
  p->cwd = namei("/");
8010356e:	c7 04 24 39 6e 10 80 	movl   $0x80106e39,(%esp)
80103575:	e8 ba e8 ff ff       	call   80101e34 <namei>
8010357a:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
8010357d:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103584:	e8 b7 0a 00 00       	call   80104040 <acquire>
  p->state = RUNNABLE;
80103589:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103590:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103597:	e8 44 0a 00 00       	call   80103fe0 <release>
}
8010359c:	83 c4 10             	add    $0x10,%esp
8010359f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801035a2:	c9                   	leave  
801035a3:	c3                   	ret    
    panic("userinit: out of memory?");
801035a4:	83 ec 0c             	sub    $0xc,%esp
801035a7:	68 17 6e 10 80       	push   $0x80106e17
801035ac:	e8 87 cd ff ff       	call   80100338 <panic>
801035b1:	8d 76 00             	lea    0x0(%esi),%esi

801035b4 <growproc>:
{
801035b4:	55                   	push   %ebp
801035b5:	89 e5                	mov    %esp,%ebp
801035b7:	56                   	push   %esi
801035b8:	53                   	push   %ebx
801035b9:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801035bc:	e8 33 09 00 00       	call   80103ef4 <pushcli>
  c = mycpu();
801035c1:	e8 4e fe ff ff       	call   80103414 <mycpu>
  p = c->proc;
801035c6:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801035cc:	e8 6f 09 00 00       	call   80103f40 <popcli>
  sz = curproc->sz;
801035d1:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801035d3:	85 f6                	test   %esi,%esi
801035d5:	7f 19                	jg     801035f0 <growproc+0x3c>
  } else if(n < 0){
801035d7:	75 33                	jne    8010360c <growproc+0x58>
  curproc->sz = sz;
801035d9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801035db:	83 ec 0c             	sub    $0xc,%esp
801035de:	53                   	push   %ebx
801035df:	e8 dc 2b 00 00       	call   801061c0 <switchuvm>
  return 0;
801035e4:	83 c4 10             	add    $0x10,%esp
801035e7:	31 c0                	xor    %eax,%eax
}
801035e9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035ec:	5b                   	pop    %ebx
801035ed:	5e                   	pop    %esi
801035ee:	5d                   	pop    %ebp
801035ef:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801035f0:	51                   	push   %ecx
801035f1:	01 c6                	add    %eax,%esi
801035f3:	56                   	push   %esi
801035f4:	50                   	push   %eax
801035f5:	ff 73 04             	push   0x4(%ebx)
801035f8:	e8 0f 2e 00 00       	call   8010640c <allocuvm>
801035fd:	83 c4 10             	add    $0x10,%esp
80103600:	85 c0                	test   %eax,%eax
80103602:	75 d5                	jne    801035d9 <growproc+0x25>
      return -1;
80103604:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103609:	eb de                	jmp    801035e9 <growproc+0x35>
8010360b:	90                   	nop
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010360c:	52                   	push   %edx
8010360d:	01 c6                	add    %eax,%esi
8010360f:	56                   	push   %esi
80103610:	50                   	push   %eax
80103611:	ff 73 04             	push   0x4(%ebx)
80103614:	e8 1b 2f 00 00       	call   80106534 <deallocuvm>
80103619:	83 c4 10             	add    $0x10,%esp
8010361c:	85 c0                	test   %eax,%eax
8010361e:	75 b9                	jne    801035d9 <growproc+0x25>
80103620:	eb e2                	jmp    80103604 <growproc+0x50>
80103622:	66 90                	xchg   %ax,%ax

80103624 <fork>:
{
80103624:	55                   	push   %ebp
80103625:	89 e5                	mov    %esp,%ebp
80103627:	57                   	push   %edi
80103628:	56                   	push   %esi
80103629:	53                   	push   %ebx
8010362a:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
8010362d:	e8 c2 08 00 00       	call   80103ef4 <pushcli>
  c = mycpu();
80103632:	e8 dd fd ff ff       	call   80103414 <mycpu>
  p = c->proc;
80103637:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010363d:	e8 fe 08 00 00       	call   80103f40 <popcli>
  if((np = allocproc()) == 0){
80103642:	e8 a1 fc ff ff       	call   801032e8 <allocproc>
80103647:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010364a:	85 c0                	test   %eax,%eax
8010364c:	0f 84 b9 00 00 00    	je     8010370b <fork+0xe7>
80103652:	89 c7                	mov    %eax,%edi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103654:	83 ec 08             	sub    $0x8,%esp
80103657:	ff 33                	push   (%ebx)
80103659:	ff 73 04             	push   0x4(%ebx)
8010365c:	e8 37 30 00 00       	call   80106698 <copyuvm>
80103661:	89 47 04             	mov    %eax,0x4(%edi)
80103664:	83 c4 10             	add    $0x10,%esp
80103667:	85 c0                	test   %eax,%eax
80103669:	0f 84 a3 00 00 00    	je     80103712 <fork+0xee>
  np->sz = curproc->sz;
8010366f:	8b 03                	mov    (%ebx),%eax
80103671:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103674:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103676:	89 c8                	mov    %ecx,%eax
80103678:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010367b:	8b 73 18             	mov    0x18(%ebx),%esi
8010367e:	8b 79 18             	mov    0x18(%ecx),%edi
80103681:	b9 13 00 00 00       	mov    $0x13,%ecx
80103686:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tf->eax = 0;
80103688:	8b 40 18             	mov    0x18(%eax),%eax
8010368b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103692:	31 f6                	xor    %esi,%esi
    if(curproc->ofile[i])
80103694:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103698:	85 c0                	test   %eax,%eax
8010369a:	74 13                	je     801036af <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
8010369c:	83 ec 0c             	sub    $0xc,%esp
8010369f:	50                   	push   %eax
801036a0:	e8 fb d6 ff ff       	call   80100da0 <filedup>
801036a5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801036a8:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
801036ac:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NOFILE; i++)
801036af:	46                   	inc    %esi
801036b0:	83 fe 10             	cmp    $0x10,%esi
801036b3:	75 df                	jne    80103694 <fork+0x70>
  np->cwd = idup(curproc->cwd);
801036b5:	83 ec 0c             	sub    $0xc,%esp
801036b8:	ff 73 68             	push   0x68(%ebx)
801036bb:	e8 d4 de ff ff       	call   80101594 <idup>
801036c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801036c3:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801036c6:	83 c4 0c             	add    $0xc,%esp
801036c9:	6a 10                	push   $0x10
801036cb:	83 c3 6c             	add    $0x6c,%ebx
801036ce:	53                   	push   %ebx
801036cf:	8d 47 6c             	lea    0x6c(%edi),%eax
801036d2:	50                   	push   %eax
801036d3:	e8 64 0b 00 00       	call   8010423c <safestrcpy>
  pid = np->pid;
801036d8:	8b 47 10             	mov    0x10(%edi),%eax
801036db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  acquire(&ptable.lock);
801036de:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801036e5:	e8 56 09 00 00       	call   80104040 <acquire>
  np->state = RUNNABLE;
801036ea:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
801036f1:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801036f8:	e8 e3 08 00 00       	call   80103fe0 <release>
  return pid;
801036fd:	83 c4 10             	add    $0x10,%esp
80103700:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80103703:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103706:	5b                   	pop    %ebx
80103707:	5e                   	pop    %esi
80103708:	5f                   	pop    %edi
80103709:	5d                   	pop    %ebp
8010370a:	c3                   	ret    
    return -1;
8010370b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103710:	eb f1                	jmp    80103703 <fork+0xdf>
    kfree(np->kstack);
80103712:	83 ec 0c             	sub    $0xc,%esp
80103715:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103718:	ff 73 08             	push   0x8(%ebx)
8010371b:	e8 a8 ea ff ff       	call   801021c8 <kfree>
    np->kstack = 0;
80103720:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103727:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
8010372e:	83 c4 10             	add    $0x10,%esp
80103731:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103736:	eb cb                	jmp    80103703 <fork+0xdf>

80103738 <scheduler>:
{
80103738:	55                   	push   %ebp
80103739:	89 e5                	mov    %esp,%ebp
8010373b:	57                   	push   %edi
8010373c:	56                   	push   %esi
8010373d:	53                   	push   %ebx
8010373e:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103741:	e8 ce fc ff ff       	call   80103414 <mycpu>
80103746:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103748:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010374f:	00 00 00 
80103752:	8d 78 04             	lea    0x4(%eax),%edi
80103755:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103758:	fb                   	sti    
    acquire(&ptable.lock);
80103759:	83 ec 0c             	sub    $0xc,%esp
8010375c:	68 20 1d 11 80       	push   $0x80111d20
80103761:	e8 da 08 00 00       	call   80104040 <acquire>
80103766:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103769:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
8010376e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80103770:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103774:	75 33                	jne    801037a9 <scheduler+0x71>
      c->proc = p;
80103776:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010377c:	83 ec 0c             	sub    $0xc,%esp
8010377f:	53                   	push   %ebx
80103780:	e8 3b 2a 00 00       	call   801061c0 <switchuvm>
      p->state = RUNNING;
80103785:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
8010378c:	58                   	pop    %eax
8010378d:	5a                   	pop    %edx
8010378e:	ff 73 1c             	push   0x1c(%ebx)
80103791:	57                   	push   %edi
80103792:	e8 f2 0a 00 00       	call   80104289 <swtch>
      switchkvm();
80103797:	e8 14 2a 00 00       	call   801061b0 <switchkvm>
      c->proc = 0;
8010379c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801037a3:	00 00 00 
801037a6:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801037a9:	83 c3 7c             	add    $0x7c,%ebx
801037ac:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801037b2:	75 bc                	jne    80103770 <scheduler+0x38>
    release(&ptable.lock);
801037b4:	83 ec 0c             	sub    $0xc,%esp
801037b7:	68 20 1d 11 80       	push   $0x80111d20
801037bc:	e8 1f 08 00 00       	call   80103fe0 <release>
    sti();
801037c1:	83 c4 10             	add    $0x10,%esp
801037c4:	eb 92                	jmp    80103758 <scheduler+0x20>
801037c6:	66 90                	xchg   %ax,%ax

801037c8 <sched>:
{
801037c8:	55                   	push   %ebp
801037c9:	89 e5                	mov    %esp,%ebp
801037cb:	56                   	push   %esi
801037cc:	53                   	push   %ebx
  pushcli();
801037cd:	e8 22 07 00 00       	call   80103ef4 <pushcli>
  c = mycpu();
801037d2:	e8 3d fc ff ff       	call   80103414 <mycpu>
  p = c->proc;
801037d7:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037dd:	e8 5e 07 00 00       	call   80103f40 <popcli>
  if(!holding(&ptable.lock))
801037e2:	83 ec 0c             	sub    $0xc,%esp
801037e5:	68 20 1d 11 80       	push   $0x80111d20
801037ea:	e8 a9 07 00 00       	call   80103f98 <holding>
801037ef:	83 c4 10             	add    $0x10,%esp
801037f2:	85 c0                	test   %eax,%eax
801037f4:	74 4f                	je     80103845 <sched+0x7d>
  if(mycpu()->ncli != 1)
801037f6:	e8 19 fc ff ff       	call   80103414 <mycpu>
801037fb:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103802:	75 68                	jne    8010386c <sched+0xa4>
  if(p->state == RUNNING)
80103804:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103808:	74 55                	je     8010385f <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010380a:	9c                   	pushf  
8010380b:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010380c:	f6 c4 02             	test   $0x2,%ah
8010380f:	75 41                	jne    80103852 <sched+0x8a>
  intena = mycpu()->intena;
80103811:	e8 fe fb ff ff       	call   80103414 <mycpu>
80103816:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
8010381c:	e8 f3 fb ff ff       	call   80103414 <mycpu>
80103821:	83 ec 08             	sub    $0x8,%esp
80103824:	ff 70 04             	push   0x4(%eax)
80103827:	83 c3 1c             	add    $0x1c,%ebx
8010382a:	53                   	push   %ebx
8010382b:	e8 59 0a 00 00       	call   80104289 <swtch>
  mycpu()->intena = intena;
80103830:	e8 df fb ff ff       	call   80103414 <mycpu>
80103835:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
8010383b:	83 c4 10             	add    $0x10,%esp
8010383e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103841:	5b                   	pop    %ebx
80103842:	5e                   	pop    %esi
80103843:	5d                   	pop    %ebp
80103844:	c3                   	ret    
    panic("sched ptable.lock");
80103845:	83 ec 0c             	sub    $0xc,%esp
80103848:	68 3b 6e 10 80       	push   $0x80106e3b
8010384d:	e8 e6 ca ff ff       	call   80100338 <panic>
    panic("sched interruptible");
80103852:	83 ec 0c             	sub    $0xc,%esp
80103855:	68 67 6e 10 80       	push   $0x80106e67
8010385a:	e8 d9 ca ff ff       	call   80100338 <panic>
    panic("sched running");
8010385f:	83 ec 0c             	sub    $0xc,%esp
80103862:	68 59 6e 10 80       	push   $0x80106e59
80103867:	e8 cc ca ff ff       	call   80100338 <panic>
    panic("sched locks");
8010386c:	83 ec 0c             	sub    $0xc,%esp
8010386f:	68 4d 6e 10 80       	push   $0x80106e4d
80103874:	e8 bf ca ff ff       	call   80100338 <panic>
80103879:	8d 76 00             	lea    0x0(%esi),%esi

8010387c <exit>:
{
8010387c:	55                   	push   %ebp
8010387d:	89 e5                	mov    %esp,%ebp
8010387f:	57                   	push   %edi
80103880:	56                   	push   %esi
80103881:	53                   	push   %ebx
80103882:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103885:	e8 22 fc ff ff       	call   801034ac <myproc>
  if(curproc == initproc)
8010388a:	39 05 54 3c 11 80    	cmp    %eax,0x80113c54
80103890:	0f 84 e9 00 00 00    	je     8010397f <exit+0x103>
80103896:	89 c3                	mov    %eax,%ebx
80103898:	8d 70 28             	lea    0x28(%eax),%esi
8010389b:	8d 78 68             	lea    0x68(%eax),%edi
8010389e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd]){
801038a0:	8b 06                	mov    (%esi),%eax
801038a2:	85 c0                	test   %eax,%eax
801038a4:	74 12                	je     801038b8 <exit+0x3c>
      fileclose(curproc->ofile[fd]);
801038a6:	83 ec 0c             	sub    $0xc,%esp
801038a9:	50                   	push   %eax
801038aa:	e8 35 d5 ff ff       	call   80100de4 <fileclose>
      curproc->ofile[fd] = 0;
801038af:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801038b5:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801038b8:	83 c6 04             	add    $0x4,%esi
801038bb:	39 f7                	cmp    %esi,%edi
801038bd:	75 e1                	jne    801038a0 <exit+0x24>
  begin_op();
801038bf:	e8 a4 f0 ff ff       	call   80102968 <begin_op>
  iput(curproc->cwd);
801038c4:	83 ec 0c             	sub    $0xc,%esp
801038c7:	ff 73 68             	push   0x68(%ebx)
801038ca:	e8 fd dd ff ff       	call   801016cc <iput>
  end_op();
801038cf:	e8 fc f0 ff ff       	call   801029d0 <end_op>
  curproc->cwd = 0;
801038d4:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
801038db:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801038e2:	e8 59 07 00 00       	call   80104040 <acquire>
  wakeup1(curproc->parent);
801038e7:	8b 53 14             	mov    0x14(%ebx),%edx
801038ea:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038ed:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
801038f2:	eb 0a                	jmp    801038fe <exit+0x82>
801038f4:	83 c0 7c             	add    $0x7c,%eax
801038f7:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
801038fc:	74 1c                	je     8010391a <exit+0x9e>
    if(p->state == SLEEPING && p->chan == chan)
801038fe:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103902:	75 f0                	jne    801038f4 <exit+0x78>
80103904:	3b 50 20             	cmp    0x20(%eax),%edx
80103907:	75 eb                	jne    801038f4 <exit+0x78>
      p->state = RUNNABLE;
80103909:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103910:	83 c0 7c             	add    $0x7c,%eax
80103913:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103918:	75 e4                	jne    801038fe <exit+0x82>
      p->parent = initproc;
8010391a:	8b 0d 54 3c 11 80    	mov    0x80113c54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103920:	ba 54 1d 11 80       	mov    $0x80111d54,%edx
80103925:	eb 0c                	jmp    80103933 <exit+0xb7>
80103927:	90                   	nop
80103928:	83 c2 7c             	add    $0x7c,%edx
8010392b:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
80103931:	74 33                	je     80103966 <exit+0xea>
    if(p->parent == curproc){
80103933:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103936:	75 f0                	jne    80103928 <exit+0xac>
      p->parent = initproc;
80103938:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010393b:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
8010393f:	75 e7                	jne    80103928 <exit+0xac>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103941:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103946:	eb 0a                	jmp    80103952 <exit+0xd6>
80103948:	83 c0 7c             	add    $0x7c,%eax
8010394b:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103950:	74 d6                	je     80103928 <exit+0xac>
    if(p->state == SLEEPING && p->chan == chan)
80103952:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103956:	75 f0                	jne    80103948 <exit+0xcc>
80103958:	3b 48 20             	cmp    0x20(%eax),%ecx
8010395b:	75 eb                	jne    80103948 <exit+0xcc>
      p->state = RUNNABLE;
8010395d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103964:	eb e2                	jmp    80103948 <exit+0xcc>
  curproc->state = ZOMBIE;
80103966:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
8010396d:	e8 56 fe ff ff       	call   801037c8 <sched>
  panic("zombie exit");
80103972:	83 ec 0c             	sub    $0xc,%esp
80103975:	68 88 6e 10 80       	push   $0x80106e88
8010397a:	e8 b9 c9 ff ff       	call   80100338 <panic>
    panic("init exiting");
8010397f:	83 ec 0c             	sub    $0xc,%esp
80103982:	68 7b 6e 10 80       	push   $0x80106e7b
80103987:	e8 ac c9 ff ff       	call   80100338 <panic>

8010398c <wait>:
{
8010398c:	55                   	push   %ebp
8010398d:	89 e5                	mov    %esp,%ebp
8010398f:	56                   	push   %esi
80103990:	53                   	push   %ebx
80103991:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80103994:	e8 5b 05 00 00       	call   80103ef4 <pushcli>
  c = mycpu();
80103999:	e8 76 fa ff ff       	call   80103414 <mycpu>
  p = c->proc;
8010399e:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801039a4:	e8 97 05 00 00       	call   80103f40 <popcli>
  acquire(&ptable.lock);
801039a9:	83 ec 0c             	sub    $0xc,%esp
801039ac:	68 20 1d 11 80       	push   $0x80111d20
801039b1:	e8 8a 06 00 00       	call   80104040 <acquire>
801039b6:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801039b9:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039bb:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
801039c0:	eb 0d                	jmp    801039cf <wait+0x43>
801039c2:	66 90                	xchg   %ax,%ax
801039c4:	83 c3 7c             	add    $0x7c,%ebx
801039c7:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801039cd:	74 1b                	je     801039ea <wait+0x5e>
      if(p->parent != curproc)
801039cf:	39 73 14             	cmp    %esi,0x14(%ebx)
801039d2:	75 f0                	jne    801039c4 <wait+0x38>
      if(p->state == ZOMBIE){
801039d4:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801039d8:	74 5a                	je     80103a34 <wait+0xa8>
      havekids = 1;
801039da:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039df:	83 c3 7c             	add    $0x7c,%ebx
801039e2:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801039e8:	75 e5                	jne    801039cf <wait+0x43>
    if(!havekids || curproc->killed){
801039ea:	85 c0                	test   %eax,%eax
801039ec:	0f 84 9c 00 00 00    	je     80103a8e <wait+0x102>
801039f2:	8b 46 24             	mov    0x24(%esi),%eax
801039f5:	85 c0                	test   %eax,%eax
801039f7:	0f 85 91 00 00 00    	jne    80103a8e <wait+0x102>
  pushcli();
801039fd:	e8 f2 04 00 00       	call   80103ef4 <pushcli>
  c = mycpu();
80103a02:	e8 0d fa ff ff       	call   80103414 <mycpu>
  p = c->proc;
80103a07:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a0d:	e8 2e 05 00 00       	call   80103f40 <popcli>
  if(p == 0)
80103a12:	85 db                	test   %ebx,%ebx
80103a14:	0f 84 8b 00 00 00    	je     80103aa5 <wait+0x119>
  p->chan = chan;
80103a1a:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80103a1d:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103a24:	e8 9f fd ff ff       	call   801037c8 <sched>
  p->chan = 0;
80103a29:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103a30:	eb 87                	jmp    801039b9 <wait+0x2d>
80103a32:	66 90                	xchg   %ax,%ax
        pid = p->pid;
80103a34:	8b 43 10             	mov    0x10(%ebx),%eax
80103a37:	89 45 f4             	mov    %eax,-0xc(%ebp)
        kfree(p->kstack);
80103a3a:	83 ec 0c             	sub    $0xc,%esp
80103a3d:	ff 73 08             	push   0x8(%ebx)
80103a40:	e8 83 e7 ff ff       	call   801021c8 <kfree>
        p->kstack = 0;
80103a45:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103a4c:	5a                   	pop    %edx
80103a4d:	ff 73 04             	push   0x4(%ebx)
80103a50:	e8 fb 2a 00 00       	call   80106550 <freevm>
        p->pid = 0;
80103a55:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103a5c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103a63:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103a67:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103a6e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103a75:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103a7c:	e8 5f 05 00 00       	call   80103fe0 <release>
        return pid;
80103a81:	83 c4 10             	add    $0x10,%esp
80103a84:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103a87:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a8a:	5b                   	pop    %ebx
80103a8b:	5e                   	pop    %esi
80103a8c:	5d                   	pop    %ebp
80103a8d:	c3                   	ret    
      release(&ptable.lock);
80103a8e:	83 ec 0c             	sub    $0xc,%esp
80103a91:	68 20 1d 11 80       	push   $0x80111d20
80103a96:	e8 45 05 00 00       	call   80103fe0 <release>
      return -1;
80103a9b:	83 c4 10             	add    $0x10,%esp
80103a9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103aa3:	eb e2                	jmp    80103a87 <wait+0xfb>
    panic("sleep");
80103aa5:	83 ec 0c             	sub    $0xc,%esp
80103aa8:	68 94 6e 10 80       	push   $0x80106e94
80103aad:	e8 86 c8 ff ff       	call   80100338 <panic>
80103ab2:	66 90                	xchg   %ax,%ax

80103ab4 <yield>:
{
80103ab4:	55                   	push   %ebp
80103ab5:	89 e5                	mov    %esp,%ebp
80103ab7:	53                   	push   %ebx
80103ab8:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103abb:	68 20 1d 11 80       	push   $0x80111d20
80103ac0:	e8 7b 05 00 00       	call   80104040 <acquire>
  pushcli();
80103ac5:	e8 2a 04 00 00       	call   80103ef4 <pushcli>
  c = mycpu();
80103aca:	e8 45 f9 ff ff       	call   80103414 <mycpu>
  p = c->proc;
80103acf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ad5:	e8 66 04 00 00       	call   80103f40 <popcli>
  myproc()->state = RUNNABLE;
80103ada:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103ae1:	e8 e2 fc ff ff       	call   801037c8 <sched>
  release(&ptable.lock);
80103ae6:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103aed:	e8 ee 04 00 00       	call   80103fe0 <release>
}
80103af2:	83 c4 10             	add    $0x10,%esp
80103af5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103af8:	c9                   	leave  
80103af9:	c3                   	ret    
80103afa:	66 90                	xchg   %ax,%ax

80103afc <sleep>:
{
80103afc:	55                   	push   %ebp
80103afd:	89 e5                	mov    %esp,%ebp
80103aff:	57                   	push   %edi
80103b00:	56                   	push   %esi
80103b01:	53                   	push   %ebx
80103b02:	83 ec 0c             	sub    $0xc,%esp
80103b05:	8b 7d 08             	mov    0x8(%ebp),%edi
80103b08:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103b0b:	e8 e4 03 00 00       	call   80103ef4 <pushcli>
  c = mycpu();
80103b10:	e8 ff f8 ff ff       	call   80103414 <mycpu>
  p = c->proc;
80103b15:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b1b:	e8 20 04 00 00       	call   80103f40 <popcli>
  if(p == 0)
80103b20:	85 db                	test   %ebx,%ebx
80103b22:	0f 84 83 00 00 00    	je     80103bab <sleep+0xaf>
  if(lk == 0)
80103b28:	85 f6                	test   %esi,%esi
80103b2a:	74 72                	je     80103b9e <sleep+0xa2>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103b2c:	81 fe 20 1d 11 80    	cmp    $0x80111d20,%esi
80103b32:	74 4c                	je     80103b80 <sleep+0x84>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103b34:	83 ec 0c             	sub    $0xc,%esp
80103b37:	68 20 1d 11 80       	push   $0x80111d20
80103b3c:	e8 ff 04 00 00       	call   80104040 <acquire>
    release(lk);
80103b41:	89 34 24             	mov    %esi,(%esp)
80103b44:	e8 97 04 00 00       	call   80103fe0 <release>
  p->chan = chan;
80103b49:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103b4c:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103b53:	e8 70 fc ff ff       	call   801037c8 <sched>
  p->chan = 0;
80103b58:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103b5f:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103b66:	e8 75 04 00 00       	call   80103fe0 <release>
    acquire(lk);
80103b6b:	83 c4 10             	add    $0x10,%esp
80103b6e:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103b71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b74:	5b                   	pop    %ebx
80103b75:	5e                   	pop    %esi
80103b76:	5f                   	pop    %edi
80103b77:	5d                   	pop    %ebp
    acquire(lk);
80103b78:	e9 c3 04 00 00       	jmp    80104040 <acquire>
80103b7d:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
80103b80:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103b83:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103b8a:	e8 39 fc ff ff       	call   801037c8 <sched>
  p->chan = 0;
80103b8f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103b96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b99:	5b                   	pop    %ebx
80103b9a:	5e                   	pop    %esi
80103b9b:	5f                   	pop    %edi
80103b9c:	5d                   	pop    %ebp
80103b9d:	c3                   	ret    
    panic("sleep without lk");
80103b9e:	83 ec 0c             	sub    $0xc,%esp
80103ba1:	68 9a 6e 10 80       	push   $0x80106e9a
80103ba6:	e8 8d c7 ff ff       	call   80100338 <panic>
    panic("sleep");
80103bab:	83 ec 0c             	sub    $0xc,%esp
80103bae:	68 94 6e 10 80       	push   $0x80106e94
80103bb3:	e8 80 c7 ff ff       	call   80100338 <panic>

80103bb8 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103bb8:	55                   	push   %ebp
80103bb9:	89 e5                	mov    %esp,%ebp
80103bbb:	53                   	push   %ebx
80103bbc:	83 ec 10             	sub    $0x10,%esp
80103bbf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103bc2:	68 20 1d 11 80       	push   $0x80111d20
80103bc7:	e8 74 04 00 00       	call   80104040 <acquire>
80103bcc:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bcf:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103bd4:	eb 0c                	jmp    80103be2 <wakeup+0x2a>
80103bd6:	66 90                	xchg   %ax,%ax
80103bd8:	83 c0 7c             	add    $0x7c,%eax
80103bdb:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103be0:	74 1c                	je     80103bfe <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80103be2:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103be6:	75 f0                	jne    80103bd8 <wakeup+0x20>
80103be8:	3b 58 20             	cmp    0x20(%eax),%ebx
80103beb:	75 eb                	jne    80103bd8 <wakeup+0x20>
      p->state = RUNNABLE;
80103bed:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bf4:	83 c0 7c             	add    $0x7c,%eax
80103bf7:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103bfc:	75 e4                	jne    80103be2 <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80103bfe:	c7 45 08 20 1d 11 80 	movl   $0x80111d20,0x8(%ebp)
}
80103c05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c08:	c9                   	leave  
  release(&ptable.lock);
80103c09:	e9 d2 03 00 00       	jmp    80103fe0 <release>
80103c0e:	66 90                	xchg   %ax,%ax

80103c10 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	53                   	push   %ebx
80103c14:	83 ec 10             	sub    $0x10,%esp
80103c17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103c1a:	68 20 1d 11 80       	push   $0x80111d20
80103c1f:	e8 1c 04 00 00       	call   80104040 <acquire>
80103c24:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c27:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103c2c:	eb 0c                	jmp    80103c3a <kill+0x2a>
80103c2e:	66 90                	xchg   %ax,%ax
80103c30:	83 c0 7c             	add    $0x7c,%eax
80103c33:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103c38:	74 32                	je     80103c6c <kill+0x5c>
    if(p->pid == pid){
80103c3a:	39 58 10             	cmp    %ebx,0x10(%eax)
80103c3d:	75 f1                	jne    80103c30 <kill+0x20>
      p->killed = 1;
80103c3f:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103c46:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103c4a:	75 07                	jne    80103c53 <kill+0x43>
        p->state = RUNNABLE;
80103c4c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80103c53:	83 ec 0c             	sub    $0xc,%esp
80103c56:	68 20 1d 11 80       	push   $0x80111d20
80103c5b:	e8 80 03 00 00       	call   80103fe0 <release>
      return 0;
80103c60:	83 c4 10             	add    $0x10,%esp
80103c63:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103c65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c68:	c9                   	leave  
80103c69:	c3                   	ret    
80103c6a:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
80103c6c:	83 ec 0c             	sub    $0xc,%esp
80103c6f:	68 20 1d 11 80       	push   $0x80111d20
80103c74:	e8 67 03 00 00       	call   80103fe0 <release>
  return -1;
80103c79:	83 c4 10             	add    $0x10,%esp
80103c7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103c81:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c84:	c9                   	leave  
80103c85:	c3                   	ret    
80103c86:	66 90                	xchg   %ax,%ax

80103c88 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103c88:	55                   	push   %ebp
80103c89:	89 e5                	mov    %esp,%ebp
80103c8b:	57                   	push   %edi
80103c8c:	56                   	push   %esi
80103c8d:	53                   	push   %ebx
80103c8e:	83 ec 3c             	sub    $0x3c,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c91:	bb c0 1d 11 80       	mov    $0x80111dc0,%ebx
80103c96:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103c99:	eb 3f                	jmp    80103cda <procdump+0x52>
80103c9b:	90                   	nop
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103c9c:	8b 04 85 0c 6f 10 80 	mov    -0x7fef90f4(,%eax,4),%eax
80103ca3:	85 c0                	test   %eax,%eax
80103ca5:	74 3f                	je     80103ce6 <procdump+0x5e>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
80103ca7:	53                   	push   %ebx
80103ca8:	50                   	push   %eax
80103ca9:	ff 73 a4             	push   -0x5c(%ebx)
80103cac:	68 af 6e 10 80       	push   $0x80106eaf
80103cb1:	e8 66 c9 ff ff       	call   8010061c <cprintf>
    if(p->state == SLEEPING){
80103cb6:	83 c4 10             	add    $0x10,%esp
80103cb9:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80103cbd:	74 31                	je     80103cf0 <procdump+0x68>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103cbf:	83 ec 0c             	sub    $0xc,%esp
80103cc2:	68 1b 72 10 80       	push   $0x8010721b
80103cc7:	e8 50 c9 ff ff       	call   8010061c <cprintf>
80103ccc:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ccf:	83 c3 7c             	add    $0x7c,%ebx
80103cd2:	81 fb c0 3c 11 80    	cmp    $0x80113cc0,%ebx
80103cd8:	74 52                	je     80103d2c <procdump+0xa4>
    if(p->state == UNUSED)
80103cda:	8b 43 a0             	mov    -0x60(%ebx),%eax
80103cdd:	85 c0                	test   %eax,%eax
80103cdf:	74 ee                	je     80103ccf <procdump+0x47>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103ce1:	83 f8 05             	cmp    $0x5,%eax
80103ce4:	76 b6                	jbe    80103c9c <procdump+0x14>
      state = "???";
80103ce6:	b8 ab 6e 10 80       	mov    $0x80106eab,%eax
80103ceb:	eb ba                	jmp    80103ca7 <procdump+0x1f>
80103ced:	8d 76 00             	lea    0x0(%esi),%esi
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103cf0:	83 ec 08             	sub    $0x8,%esp
80103cf3:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103cf6:	50                   	push   %eax
80103cf7:	8b 43 b0             	mov    -0x50(%ebx),%eax
80103cfa:	8b 40 0c             	mov    0xc(%eax),%eax
80103cfd:	83 c0 08             	add    $0x8,%eax
80103d00:	50                   	push   %eax
80103d01:	e8 9e 01 00 00       	call   80103ea4 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80103d06:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103d09:	83 c4 10             	add    $0x10,%esp
80103d0c:	8b 17                	mov    (%edi),%edx
80103d0e:	85 d2                	test   %edx,%edx
80103d10:	74 ad                	je     80103cbf <procdump+0x37>
        cprintf(" %p", pc[i]);
80103d12:	83 ec 08             	sub    $0x8,%esp
80103d15:	52                   	push   %edx
80103d16:	68 01 69 10 80       	push   $0x80106901
80103d1b:	e8 fc c8 ff ff       	call   8010061c <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80103d20:	83 c7 04             	add    $0x4,%edi
80103d23:	83 c4 10             	add    $0x10,%esp
80103d26:	39 fe                	cmp    %edi,%esi
80103d28:	75 e2                	jne    80103d0c <procdump+0x84>
80103d2a:	eb 93                	jmp    80103cbf <procdump+0x37>
  }
}
80103d2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d2f:	5b                   	pop    %ebx
80103d30:	5e                   	pop    %esi
80103d31:	5f                   	pop    %edi
80103d32:	5d                   	pop    %ebp
80103d33:	c3                   	ret    

80103d34 <getprocs>:

int getprocs() {
80103d34:	55                   	push   %ebp
80103d35:	89 e5                	mov    %esp,%ebp
80103d37:	53                   	push   %ebx
80103d38:	83 ec 10             	sub    $0x10,%esp
  
  struct proc *p;
  int n_procs = 0;
  
  acquire(&ptable.lock);
80103d3b:	68 20 1d 11 80       	push   $0x80111d20
80103d40:	e8 fb 02 00 00       	call   80104040 <acquire>
80103d45:	83 c4 10             	add    $0x10,%esp
  int n_procs = 0;
80103d48:	31 db                	xor    %ebx,%ebx
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) if(p->state != UNUSED) n_procs++;
80103d4a:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103d4f:	90                   	nop
80103d50:	8b 50 0c             	mov    0xc(%eax),%edx
80103d53:	85 d2                	test   %edx,%edx
80103d55:	74 01                	je     80103d58 <getprocs+0x24>
80103d57:	43                   	inc    %ebx
80103d58:	83 c0 7c             	add    $0x7c,%eax
80103d5b:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103d60:	75 ee                	jne    80103d50 <getprocs+0x1c>
  release(&ptable.lock);
80103d62:	83 ec 0c             	sub    $0xc,%esp
80103d65:	68 20 1d 11 80       	push   $0x80111d20
80103d6a:	e8 71 02 00 00       	call   80103fe0 <release>
  
  return n_procs;
}
80103d6f:	89 d8                	mov    %ebx,%eax
80103d71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d74:	c9                   	leave  
80103d75:	c3                   	ret    
80103d76:	66 90                	xchg   %ax,%ax

80103d78 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80103d78:	55                   	push   %ebp
80103d79:	89 e5                	mov    %esp,%ebp
80103d7b:	53                   	push   %ebx
80103d7c:	83 ec 0c             	sub    $0xc,%esp
80103d7f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80103d82:	68 24 6f 10 80       	push   $0x80106f24
80103d87:	8d 43 04             	lea    0x4(%ebx),%eax
80103d8a:	50                   	push   %eax
80103d8b:	e8 f8 00 00 00       	call   80103e88 <initlock>
  lk->name = name;
80103d90:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d93:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
80103d96:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80103d9c:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
}
80103da3:	83 c4 10             	add    $0x10,%esp
80103da6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103da9:	c9                   	leave  
80103daa:	c3                   	ret    
80103dab:	90                   	nop

80103dac <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80103dac:	55                   	push   %ebp
80103dad:	89 e5                	mov    %esp,%ebp
80103daf:	56                   	push   %esi
80103db0:	53                   	push   %ebx
80103db1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103db4:	8d 73 04             	lea    0x4(%ebx),%esi
80103db7:	83 ec 0c             	sub    $0xc,%esp
80103dba:	56                   	push   %esi
80103dbb:	e8 80 02 00 00       	call   80104040 <acquire>
  while (lk->locked) {
80103dc0:	83 c4 10             	add    $0x10,%esp
80103dc3:	8b 13                	mov    (%ebx),%edx
80103dc5:	85 d2                	test   %edx,%edx
80103dc7:	74 16                	je     80103ddf <acquiresleep+0x33>
80103dc9:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80103dcc:	83 ec 08             	sub    $0x8,%esp
80103dcf:	56                   	push   %esi
80103dd0:	53                   	push   %ebx
80103dd1:	e8 26 fd ff ff       	call   80103afc <sleep>
  while (lk->locked) {
80103dd6:	83 c4 10             	add    $0x10,%esp
80103dd9:	8b 03                	mov    (%ebx),%eax
80103ddb:	85 c0                	test   %eax,%eax
80103ddd:	75 ed                	jne    80103dcc <acquiresleep+0x20>
  }
  lk->locked = 1;
80103ddf:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80103de5:	e8 c2 f6 ff ff       	call   801034ac <myproc>
80103dea:	8b 40 10             	mov    0x10(%eax),%eax
80103ded:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80103df0:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103df3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103df6:	5b                   	pop    %ebx
80103df7:	5e                   	pop    %esi
80103df8:	5d                   	pop    %ebp
  release(&lk->lk);
80103df9:	e9 e2 01 00 00       	jmp    80103fe0 <release>
80103dfe:	66 90                	xchg   %ax,%ax

80103e00 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	56                   	push   %esi
80103e04:	53                   	push   %ebx
80103e05:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103e08:	8d 73 04             	lea    0x4(%ebx),%esi
80103e0b:	83 ec 0c             	sub    $0xc,%esp
80103e0e:	56                   	push   %esi
80103e0f:	e8 2c 02 00 00       	call   80104040 <acquire>
  lk->locked = 0;
80103e14:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80103e1a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80103e21:	89 1c 24             	mov    %ebx,(%esp)
80103e24:	e8 8f fd ff ff       	call   80103bb8 <wakeup>
  release(&lk->lk);
80103e29:	83 c4 10             	add    $0x10,%esp
80103e2c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103e2f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e32:	5b                   	pop    %ebx
80103e33:	5e                   	pop    %esi
80103e34:	5d                   	pop    %ebp
  release(&lk->lk);
80103e35:	e9 a6 01 00 00       	jmp    80103fe0 <release>
80103e3a:	66 90                	xchg   %ax,%ax

80103e3c <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80103e3c:	55                   	push   %ebp
80103e3d:	89 e5                	mov    %esp,%ebp
80103e3f:	56                   	push   %esi
80103e40:	53                   	push   %ebx
80103e41:	83 ec 1c             	sub    $0x1c,%esp
80103e44:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80103e47:	8d 73 04             	lea    0x4(%ebx),%esi
80103e4a:	56                   	push   %esi
80103e4b:	e8 f0 01 00 00       	call   80104040 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80103e50:	83 c4 10             	add    $0x10,%esp
80103e53:	8b 03                	mov    (%ebx),%eax
80103e55:	85 c0                	test   %eax,%eax
80103e57:	75 1b                	jne    80103e74 <holdingsleep+0x38>
80103e59:	31 c0                	xor    %eax,%eax
80103e5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&lk->lk);
80103e5e:	83 ec 0c             	sub    $0xc,%esp
80103e61:	56                   	push   %esi
80103e62:	e8 79 01 00 00       	call   80103fe0 <release>
  return r;
}
80103e67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e6d:	5b                   	pop    %ebx
80103e6e:	5e                   	pop    %esi
80103e6f:	5d                   	pop    %ebp
80103e70:	c3                   	ret    
80103e71:	8d 76 00             	lea    0x0(%esi),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80103e74:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80103e77:	e8 30 f6 ff ff       	call   801034ac <myproc>
80103e7c:	39 58 10             	cmp    %ebx,0x10(%eax)
80103e7f:	0f 94 c0             	sete   %al
80103e82:	0f b6 c0             	movzbl %al,%eax
80103e85:	eb d4                	jmp    80103e5b <holdingsleep+0x1f>
80103e87:	90                   	nop

80103e88 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80103e88:	55                   	push   %ebp
80103e89:	89 e5                	mov    %esp,%ebp
80103e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80103e8e:	8b 55 0c             	mov    0xc(%ebp),%edx
80103e91:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80103e94:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80103e9a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80103ea1:	5d                   	pop    %ebp
80103ea2:	c3                   	ret    
80103ea3:	90                   	nop

80103ea4 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80103ea4:	55                   	push   %ebp
80103ea5:	89 e5                	mov    %esp,%ebp
80103ea7:	53                   	push   %ebx
80103ea8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80103eab:	8b 45 08             	mov    0x8(%ebp),%eax
80103eae:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80103eb1:	31 d2                	xor    %edx,%edx
80103eb3:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80103eb4:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80103eba:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80103ec0:	77 16                	ja     80103ed8 <getcallerpcs+0x34>
      break;
    pcs[i] = ebp[1];     // saved %eip
80103ec2:	8b 58 04             	mov    0x4(%eax),%ebx
80103ec5:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
    ebp = (uint*)ebp[0]; // saved %ebp
80103ec8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80103eca:	42                   	inc    %edx
80103ecb:	83 fa 0a             	cmp    $0xa,%edx
80103ece:	75 e4                	jne    80103eb4 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80103ed0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ed3:	c9                   	leave  
80103ed4:	c3                   	ret    
80103ed5:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80103ed8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80103edb:	8d 51 28             	lea    0x28(%ecx),%edx
80103ede:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80103ee0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80103ee6:	83 c0 04             	add    $0x4,%eax
80103ee9:	39 d0                	cmp    %edx,%eax
80103eeb:	75 f3                	jne    80103ee0 <getcallerpcs+0x3c>
}
80103eed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ef0:	c9                   	leave  
80103ef1:	c3                   	ret    
80103ef2:	66 90                	xchg   %ax,%ax

80103ef4 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80103ef4:	55                   	push   %ebp
80103ef5:	89 e5                	mov    %esp,%ebp
80103ef7:	53                   	push   %ebx
80103ef8:	50                   	push   %eax
80103ef9:	9c                   	pushf  
80103efa:	5b                   	pop    %ebx
  asm volatile("cli");
80103efb:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80103efc:	e8 13 f5 ff ff       	call   80103414 <mycpu>
80103f01:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80103f07:	85 d2                	test   %edx,%edx
80103f09:	74 11                	je     80103f1c <pushcli+0x28>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80103f0b:	e8 04 f5 ff ff       	call   80103414 <mycpu>
80103f10:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80103f16:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f19:	c9                   	leave  
80103f1a:	c3                   	ret    
80103f1b:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80103f1c:	e8 f3 f4 ff ff       	call   80103414 <mycpu>
80103f21:	81 e3 00 02 00 00    	and    $0x200,%ebx
80103f27:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80103f2d:	e8 e2 f4 ff ff       	call   80103414 <mycpu>
80103f32:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80103f38:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f3b:	c9                   	leave  
80103f3c:	c3                   	ret    
80103f3d:	8d 76 00             	lea    0x0(%esi),%esi

80103f40 <popcli>:

void
popcli(void)
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103f46:	9c                   	pushf  
80103f47:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103f48:	f6 c4 02             	test   $0x2,%ah
80103f4b:	75 31                	jne    80103f7e <popcli+0x3e>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80103f4d:	e8 c2 f4 ff ff       	call   80103414 <mycpu>
80103f52:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80103f58:	78 31                	js     80103f8b <popcli+0x4b>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103f5a:	e8 b5 f4 ff ff       	call   80103414 <mycpu>
80103f5f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80103f65:	85 d2                	test   %edx,%edx
80103f67:	74 03                	je     80103f6c <popcli+0x2c>
    sti();
}
80103f69:	c9                   	leave  
80103f6a:	c3                   	ret    
80103f6b:	90                   	nop
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103f6c:	e8 a3 f4 ff ff       	call   80103414 <mycpu>
80103f71:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103f77:	85 c0                	test   %eax,%eax
80103f79:	74 ee                	je     80103f69 <popcli+0x29>
  asm volatile("sti");
80103f7b:	fb                   	sti    
}
80103f7c:	c9                   	leave  
80103f7d:	c3                   	ret    
    panic("popcli - interruptible");
80103f7e:	83 ec 0c             	sub    $0xc,%esp
80103f81:	68 2f 6f 10 80       	push   $0x80106f2f
80103f86:	e8 ad c3 ff ff       	call   80100338 <panic>
    panic("popcli");
80103f8b:	83 ec 0c             	sub    $0xc,%esp
80103f8e:	68 46 6f 10 80       	push   $0x80106f46
80103f93:	e8 a0 c3 ff ff       	call   80100338 <panic>

80103f98 <holding>:
{
80103f98:	55                   	push   %ebp
80103f99:	89 e5                	mov    %esp,%ebp
80103f9b:	53                   	push   %ebx
80103f9c:	83 ec 14             	sub    $0x14,%esp
80103f9f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80103fa2:	e8 4d ff ff ff       	call   80103ef4 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80103fa7:	8b 03                	mov    (%ebx),%eax
80103fa9:	85 c0                	test   %eax,%eax
80103fab:	75 13                	jne    80103fc0 <holding+0x28>
80103fad:	31 c0                	xor    %eax,%eax
80103faf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  popcli();
80103fb2:	e8 89 ff ff ff       	call   80103f40 <popcli>
}
80103fb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fbd:	c9                   	leave  
80103fbe:	c3                   	ret    
80103fbf:	90                   	nop
  r = lock->locked && lock->cpu == mycpu();
80103fc0:	8b 5b 08             	mov    0x8(%ebx),%ebx
80103fc3:	e8 4c f4 ff ff       	call   80103414 <mycpu>
80103fc8:	39 c3                	cmp    %eax,%ebx
80103fca:	0f 94 c0             	sete   %al
80103fcd:	0f b6 c0             	movzbl %al,%eax
80103fd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  popcli();
80103fd3:	e8 68 ff ff ff       	call   80103f40 <popcli>
}
80103fd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fdb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fde:	c9                   	leave  
80103fdf:	c3                   	ret    

80103fe0 <release>:
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	56                   	push   %esi
80103fe4:	53                   	push   %ebx
80103fe5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80103fe8:	e8 07 ff ff ff       	call   80103ef4 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80103fed:	8b 03                	mov    (%ebx),%eax
80103fef:	85 c0                	test   %eax,%eax
80103ff1:	75 15                	jne    80104008 <release+0x28>
  popcli();
80103ff3:	e8 48 ff ff ff       	call   80103f40 <popcli>
    panic("release");
80103ff8:	83 ec 0c             	sub    $0xc,%esp
80103ffb:	68 4d 6f 10 80       	push   $0x80106f4d
80104000:	e8 33 c3 ff ff       	call   80100338 <panic>
80104005:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104008:	8b 73 08             	mov    0x8(%ebx),%esi
8010400b:	e8 04 f4 ff ff       	call   80103414 <mycpu>
80104010:	39 c6                	cmp    %eax,%esi
80104012:	75 df                	jne    80103ff3 <release+0x13>
  popcli();
80104014:	e8 27 ff ff ff       	call   80103f40 <popcli>
  lk->pcs[0] = 0;
80104019:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104020:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104027:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010402c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104032:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104035:	5b                   	pop    %ebx
80104036:	5e                   	pop    %esi
80104037:	5d                   	pop    %ebp
  popcli();
80104038:	e9 03 ff ff ff       	jmp    80103f40 <popcli>
8010403d:	8d 76 00             	lea    0x0(%esi),%esi

80104040 <acquire>:
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	53                   	push   %ebx
80104044:	50                   	push   %eax
  pushcli(); // disable interrupts to avoid deadlock.
80104045:	e8 aa fe ff ff       	call   80103ef4 <pushcli>
  if(holding(lk))
8010404a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010404d:	e8 a2 fe ff ff       	call   80103ef4 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104052:	8b 13                	mov    (%ebx),%edx
80104054:	85 d2                	test   %edx,%edx
80104056:	75 70                	jne    801040c8 <acquire+0x88>
  popcli();
80104058:	e8 e3 fe ff ff       	call   80103f40 <popcli>
  asm volatile("lock; xchgl %0, %1" :
8010405d:	b9 01 00 00 00       	mov    $0x1,%ecx
80104062:	66 90                	xchg   %ax,%ax
  while(xchg(&lk->locked, 1) != 0)
80104064:	8b 55 08             	mov    0x8(%ebp),%edx
80104067:	89 c8                	mov    %ecx,%eax
80104069:	f0 87 02             	lock xchg %eax,(%edx)
8010406c:	85 c0                	test   %eax,%eax
8010406e:	75 f4                	jne    80104064 <acquire+0x24>
  __sync_synchronize();
80104070:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104075:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104078:	e8 97 f3 ff ff       	call   80103414 <mycpu>
8010407d:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
80104080:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
80104083:	31 c0                	xor    %eax,%eax
  ebp = (uint*)v - 2;
80104085:	89 ea                	mov    %ebp,%edx
80104087:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104088:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010408e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104094:	77 16                	ja     801040ac <acquire+0x6c>
    pcs[i] = ebp[1];     // saved %eip
80104096:	8b 5a 04             	mov    0x4(%edx),%ebx
80104099:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
    ebp = (uint*)ebp[0]; // saved %ebp
8010409d:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010409f:	40                   	inc    %eax
801040a0:	83 f8 0a             	cmp    $0xa,%eax
801040a3:	75 e3                	jne    80104088 <acquire+0x48>
}
801040a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040a8:	c9                   	leave  
801040a9:	c3                   	ret    
801040aa:	66 90                	xchg   %ax,%ax
  for(; i < 10; i++)
801040ac:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
801040b0:	8d 51 34             	lea    0x34(%ecx),%edx
801040b3:	90                   	nop
    pcs[i] = 0;
801040b4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801040ba:	83 c0 04             	add    $0x4,%eax
801040bd:	39 c2                	cmp    %eax,%edx
801040bf:	75 f3                	jne    801040b4 <acquire+0x74>
}
801040c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040c4:	c9                   	leave  
801040c5:	c3                   	ret    
801040c6:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
801040c8:	8b 5b 08             	mov    0x8(%ebx),%ebx
801040cb:	e8 44 f3 ff ff       	call   80103414 <mycpu>
801040d0:	39 c3                	cmp    %eax,%ebx
801040d2:	75 84                	jne    80104058 <acquire+0x18>
  popcli();
801040d4:	e8 67 fe ff ff       	call   80103f40 <popcli>
    panic("acquire");
801040d9:	83 ec 0c             	sub    $0xc,%esp
801040dc:	68 55 6f 10 80       	push   $0x80106f55
801040e1:	e8 52 c2 ff ff       	call   80100338 <panic>
801040e6:	66 90                	xchg   %ax,%ax

801040e8 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801040e8:	55                   	push   %ebp
801040e9:	89 e5                	mov    %esp,%ebp
801040eb:	57                   	push   %edi
801040ec:	53                   	push   %ebx
801040ed:	8b 55 08             	mov    0x8(%ebp),%edx
801040f0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801040f3:	89 d0                	mov    %edx,%eax
801040f5:	09 c8                	or     %ecx,%eax
801040f7:	a8 03                	test   $0x3,%al
801040f9:	75 29                	jne    80104124 <memset+0x3c>
    c &= 0xFF;
801040fb:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801040ff:	c1 e9 02             	shr    $0x2,%ecx
80104102:	8b 45 0c             	mov    0xc(%ebp),%eax
80104105:	c1 e0 18             	shl    $0x18,%eax
80104108:	89 fb                	mov    %edi,%ebx
8010410a:	c1 e3 10             	shl    $0x10,%ebx
8010410d:	09 d8                	or     %ebx,%eax
8010410f:	09 f8                	or     %edi,%eax
80104111:	c1 e7 08             	shl    $0x8,%edi
80104114:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104116:	89 d7                	mov    %edx,%edi
80104118:	fc                   	cld    
80104119:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
8010411b:	89 d0                	mov    %edx,%eax
8010411d:	5b                   	pop    %ebx
8010411e:	5f                   	pop    %edi
8010411f:	5d                   	pop    %ebp
80104120:	c3                   	ret    
80104121:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" :
80104124:	89 d7                	mov    %edx,%edi
80104126:	8b 45 0c             	mov    0xc(%ebp),%eax
80104129:	fc                   	cld    
8010412a:	f3 aa                	rep stos %al,%es:(%edi)
8010412c:	89 d0                	mov    %edx,%eax
8010412e:	5b                   	pop    %ebx
8010412f:	5f                   	pop    %edi
80104130:	5d                   	pop    %ebp
80104131:	c3                   	ret    
80104132:	66 90                	xchg   %ax,%ax

80104134 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104134:	55                   	push   %ebp
80104135:	89 e5                	mov    %esp,%ebp
80104137:	56                   	push   %esi
80104138:	53                   	push   %ebx
80104139:	8b 55 08             	mov    0x8(%ebp),%edx
8010413c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010413f:	8b 75 10             	mov    0x10(%ebp),%esi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104142:	85 f6                	test   %esi,%esi
80104144:	74 1e                	je     80104164 <memcmp+0x30>
80104146:	01 c6                	add    %eax,%esi
80104148:	eb 08                	jmp    80104152 <memcmp+0x1e>
8010414a:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
8010414c:	42                   	inc    %edx
8010414d:	40                   	inc    %eax
  while(n-- > 0){
8010414e:	39 f0                	cmp    %esi,%eax
80104150:	74 12                	je     80104164 <memcmp+0x30>
    if(*s1 != *s2)
80104152:	8a 0a                	mov    (%edx),%cl
80104154:	0f b6 18             	movzbl (%eax),%ebx
80104157:	38 d9                	cmp    %bl,%cl
80104159:	74 f1                	je     8010414c <memcmp+0x18>
      return *s1 - *s2;
8010415b:	0f b6 c1             	movzbl %cl,%eax
8010415e:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104160:	5b                   	pop    %ebx
80104161:	5e                   	pop    %esi
80104162:	5d                   	pop    %ebp
80104163:	c3                   	ret    
  return 0;
80104164:	31 c0                	xor    %eax,%eax
}
80104166:	5b                   	pop    %ebx
80104167:	5e                   	pop    %esi
80104168:	5d                   	pop    %ebp
80104169:	c3                   	ret    
8010416a:	66 90                	xchg   %ax,%ax

8010416c <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
8010416c:	55                   	push   %ebp
8010416d:	89 e5                	mov    %esp,%ebp
8010416f:	57                   	push   %edi
80104170:	56                   	push   %esi
80104171:	8b 55 08             	mov    0x8(%ebp),%edx
80104174:	8b 75 0c             	mov    0xc(%ebp),%esi
80104177:	8b 4d 10             	mov    0x10(%ebp),%ecx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010417a:	39 d6                	cmp    %edx,%esi
8010417c:	73 07                	jae    80104185 <memmove+0x19>
8010417e:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104181:	39 fa                	cmp    %edi,%edx
80104183:	72 17                	jb     8010419c <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104185:	85 c9                	test   %ecx,%ecx
80104187:	74 0c                	je     80104195 <memmove+0x29>
80104189:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
8010418c:	89 d7                	mov    %edx,%edi
8010418e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104190:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104191:	39 c6                	cmp    %eax,%esi
80104193:	75 fb                	jne    80104190 <memmove+0x24>

  return dst;
}
80104195:	89 d0                	mov    %edx,%eax
80104197:	5e                   	pop    %esi
80104198:	5f                   	pop    %edi
80104199:	5d                   	pop    %ebp
8010419a:	c3                   	ret    
8010419b:	90                   	nop
8010419c:	8d 41 ff             	lea    -0x1(%ecx),%eax
    while(n-- > 0)
8010419f:	85 c9                	test   %ecx,%ecx
801041a1:	74 f2                	je     80104195 <memmove+0x29>
801041a3:	90                   	nop
      *--d = *--s;
801041a4:	8a 0c 06             	mov    (%esi,%eax,1),%cl
801041a7:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
801041aa:	83 e8 01             	sub    $0x1,%eax
801041ad:	73 f5                	jae    801041a4 <memmove+0x38>
}
801041af:	89 d0                	mov    %edx,%eax
801041b1:	5e                   	pop    %esi
801041b2:	5f                   	pop    %edi
801041b3:	5d                   	pop    %ebp
801041b4:	c3                   	ret    
801041b5:	8d 76 00             	lea    0x0(%esi),%esi

801041b8 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801041b8:	eb b2                	jmp    8010416c <memmove>
801041ba:	66 90                	xchg   %ax,%ax

801041bc <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801041bc:	55                   	push   %ebp
801041bd:	89 e5                	mov    %esp,%ebp
801041bf:	56                   	push   %esi
801041c0:	53                   	push   %ebx
801041c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801041c4:	8b 55 0c             	mov    0xc(%ebp),%edx
801041c7:	8b 75 10             	mov    0x10(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801041ca:	85 f6                	test   %esi,%esi
801041cc:	74 22                	je     801041f0 <strncmp+0x34>
801041ce:	01 d6                	add    %edx,%esi
801041d0:	eb 0c                	jmp    801041de <strncmp+0x22>
801041d2:	66 90                	xchg   %ax,%ax
801041d4:	38 c8                	cmp    %cl,%al
801041d6:	75 10                	jne    801041e8 <strncmp+0x2c>
    n--, p++, q++;
801041d8:	43                   	inc    %ebx
801041d9:	42                   	inc    %edx
  while(n > 0 && *p && *p == *q)
801041da:	39 f2                	cmp    %esi,%edx
801041dc:	74 12                	je     801041f0 <strncmp+0x34>
801041de:	0f b6 03             	movzbl (%ebx),%eax
801041e1:	0f b6 0a             	movzbl (%edx),%ecx
801041e4:	84 c0                	test   %al,%al
801041e6:	75 ec                	jne    801041d4 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801041e8:	29 c8                	sub    %ecx,%eax
}
801041ea:	5b                   	pop    %ebx
801041eb:	5e                   	pop    %esi
801041ec:	5d                   	pop    %ebp
801041ed:	c3                   	ret    
801041ee:	66 90                	xchg   %ax,%ax
    return 0;
801041f0:	31 c0                	xor    %eax,%eax
}
801041f2:	5b                   	pop    %ebx
801041f3:	5e                   	pop    %esi
801041f4:	5d                   	pop    %ebp
801041f5:	c3                   	ret    
801041f6:	66 90                	xchg   %ax,%ax

801041f8 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801041f8:	55                   	push   %ebp
801041f9:	89 e5                	mov    %esp,%ebp
801041fb:	56                   	push   %esi
801041fc:	53                   	push   %ebx
801041fd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104200:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104203:	8b 55 08             	mov    0x8(%ebp),%edx
80104206:	eb 0c                	jmp    80104214 <strncpy+0x1c>
80104208:	41                   	inc    %ecx
80104209:	42                   	inc    %edx
8010420a:	8a 41 ff             	mov    -0x1(%ecx),%al
8010420d:	88 42 ff             	mov    %al,-0x1(%edx)
80104210:	84 c0                	test   %al,%al
80104212:	74 07                	je     8010421b <strncpy+0x23>
80104214:	89 de                	mov    %ebx,%esi
80104216:	4b                   	dec    %ebx
80104217:	85 f6                	test   %esi,%esi
80104219:	7f ed                	jg     80104208 <strncpy+0x10>
    ;
  while(n-- > 0)
8010421b:	89 d1                	mov    %edx,%ecx
8010421d:	85 db                	test   %ebx,%ebx
8010421f:	7e 14                	jle    80104235 <strncpy+0x3d>
80104221:	8d 76 00             	lea    0x0(%esi),%esi
    *s++ = 0;
80104224:	41                   	inc    %ecx
80104225:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80104229:	89 d3                	mov    %edx,%ebx
8010422b:	29 cb                	sub    %ecx,%ebx
8010422d:	8d 5c 1e ff          	lea    -0x1(%esi,%ebx,1),%ebx
80104231:	85 db                	test   %ebx,%ebx
80104233:	7f ef                	jg     80104224 <strncpy+0x2c>
  return os;
}
80104235:	8b 45 08             	mov    0x8(%ebp),%eax
80104238:	5b                   	pop    %ebx
80104239:	5e                   	pop    %esi
8010423a:	5d                   	pop    %ebp
8010423b:	c3                   	ret    

8010423c <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
8010423c:	55                   	push   %ebp
8010423d:	89 e5                	mov    %esp,%ebp
8010423f:	56                   	push   %esi
80104240:	53                   	push   %ebx
80104241:	8b 45 08             	mov    0x8(%ebp),%eax
80104244:	8b 55 0c             	mov    0xc(%ebp),%edx
80104247:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  if(n <= 0)
8010424a:	85 c9                	test   %ecx,%ecx
8010424c:	7e 1d                	jle    8010426b <safestrcpy+0x2f>
8010424e:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104252:	89 c1                	mov    %eax,%ecx
80104254:	eb 0e                	jmp    80104264 <safestrcpy+0x28>
80104256:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104258:	42                   	inc    %edx
80104259:	41                   	inc    %ecx
8010425a:	8a 5a ff             	mov    -0x1(%edx),%bl
8010425d:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104260:	84 db                	test   %bl,%bl
80104262:	74 04                	je     80104268 <safestrcpy+0x2c>
80104264:	39 f2                	cmp    %esi,%edx
80104266:	75 f0                	jne    80104258 <safestrcpy+0x1c>
    ;
  *s = 0;
80104268:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
8010426b:	5b                   	pop    %ebx
8010426c:	5e                   	pop    %esi
8010426d:	5d                   	pop    %ebp
8010426e:	c3                   	ret    
8010426f:	90                   	nop

80104270 <strlen>:

int
strlen(const char *s)
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104276:	31 c0                	xor    %eax,%eax
80104278:	80 3a 00             	cmpb   $0x0,(%edx)
8010427b:	74 0a                	je     80104287 <strlen+0x17>
8010427d:	8d 76 00             	lea    0x0(%esi),%esi
80104280:	40                   	inc    %eax
80104281:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104285:	75 f9                	jne    80104280 <strlen+0x10>
    ;
  return n;
}
80104287:	5d                   	pop    %ebp
80104288:	c3                   	ret    

80104289 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104289:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010428d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104291:	55                   	push   %ebp
  pushl %ebx
80104292:	53                   	push   %ebx
  pushl %esi
80104293:	56                   	push   %esi
  pushl %edi
80104294:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104295:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104297:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104299:	5f                   	pop    %edi
  popl %esi
8010429a:	5e                   	pop    %esi
  popl %ebx
8010429b:	5b                   	pop    %ebx
  popl %ebp
8010429c:	5d                   	pop    %ebp
  ret
8010429d:	c3                   	ret    
8010429e:	66 90                	xchg   %ax,%ax

801042a0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	50                   	push   %eax
801042a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801042a8:	e8 ff f1 ff ff       	call   801034ac <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801042ad:	8b 00                	mov    (%eax),%eax
801042af:	39 d8                	cmp    %ebx,%eax
801042b1:	76 15                	jbe    801042c8 <fetchint+0x28>
801042b3:	8d 53 04             	lea    0x4(%ebx),%edx
801042b6:	39 d0                	cmp    %edx,%eax
801042b8:	72 0e                	jb     801042c8 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
801042ba:	8b 13                	mov    (%ebx),%edx
801042bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801042bf:	89 10                	mov    %edx,(%eax)
  return 0;
801042c1:	31 c0                	xor    %eax,%eax
}
801042c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042c6:	c9                   	leave  
801042c7:	c3                   	ret    
    return -1;
801042c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042cd:	eb f4                	jmp    801042c3 <fetchint+0x23>
801042cf:	90                   	nop

801042d0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	53                   	push   %ebx
801042d4:	50                   	push   %eax
801042d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801042d8:	e8 cf f1 ff ff       	call   801034ac <myproc>

  if(addr >= curproc->sz)
801042dd:	39 18                	cmp    %ebx,(%eax)
801042df:	76 23                	jbe    80104304 <fetchstr+0x34>
    return -1;
  *pp = (char*)addr;
801042e1:	8b 55 0c             	mov    0xc(%ebp),%edx
801042e4:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801042e6:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801042e8:	39 d3                	cmp    %edx,%ebx
801042ea:	73 18                	jae    80104304 <fetchstr+0x34>
801042ec:	89 d8                	mov    %ebx,%eax
801042ee:	eb 05                	jmp    801042f5 <fetchstr+0x25>
801042f0:	40                   	inc    %eax
801042f1:	39 c2                	cmp    %eax,%edx
801042f3:	76 0f                	jbe    80104304 <fetchstr+0x34>
    if(*s == 0)
801042f5:	80 38 00             	cmpb   $0x0,(%eax)
801042f8:	75 f6                	jne    801042f0 <fetchstr+0x20>
      return s - *pp;
801042fa:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801042fc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042ff:	c9                   	leave  
80104300:	c3                   	ret    
80104301:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104304:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104309:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010430c:	c9                   	leave  
8010430d:	c3                   	ret    
8010430e:	66 90                	xchg   %ax,%ax

80104310 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	56                   	push   %esi
80104314:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104315:	e8 92 f1 ff ff       	call   801034ac <myproc>
8010431a:	8b 40 18             	mov    0x18(%eax),%eax
8010431d:	8b 40 44             	mov    0x44(%eax),%eax
80104320:	8b 55 08             	mov    0x8(%ebp),%edx
80104323:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80104326:	8d 73 04             	lea    0x4(%ebx),%esi
  struct proc *curproc = myproc();
80104329:	e8 7e f1 ff ff       	call   801034ac <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010432e:	8b 00                	mov    (%eax),%eax
80104330:	39 c6                	cmp    %eax,%esi
80104332:	73 18                	jae    8010434c <argint+0x3c>
80104334:	8d 53 08             	lea    0x8(%ebx),%edx
80104337:	39 d0                	cmp    %edx,%eax
80104339:	72 11                	jb     8010434c <argint+0x3c>
  *ip = *(int*)(addr);
8010433b:	8b 53 04             	mov    0x4(%ebx),%edx
8010433e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104341:	89 10                	mov    %edx,(%eax)
  return 0;
80104343:	31 c0                	xor    %eax,%eax
}
80104345:	5b                   	pop    %ebx
80104346:	5e                   	pop    %esi
80104347:	5d                   	pop    %ebp
80104348:	c3                   	ret    
80104349:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
8010434c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104351:	eb f2                	jmp    80104345 <argint+0x35>
80104353:	90                   	nop

80104354 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104354:	55                   	push   %ebp
80104355:	89 e5                	mov    %esp,%ebp
80104357:	57                   	push   %edi
80104358:	56                   	push   %esi
80104359:	53                   	push   %ebx
8010435a:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
8010435d:	e8 4a f1 ff ff       	call   801034ac <myproc>
80104362:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104364:	e8 43 f1 ff ff       	call   801034ac <myproc>
80104369:	8b 40 18             	mov    0x18(%eax),%eax
8010436c:	8b 40 44             	mov    0x44(%eax),%eax
8010436f:	8b 55 08             	mov    0x8(%ebp),%edx
80104372:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80104375:	8d 7b 04             	lea    0x4(%ebx),%edi
  struct proc *curproc = myproc();
80104378:	e8 2f f1 ff ff       	call   801034ac <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010437d:	8b 00                	mov    (%eax),%eax
8010437f:	39 c7                	cmp    %eax,%edi
80104381:	73 31                	jae    801043b4 <argptr+0x60>
80104383:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104386:	39 c8                	cmp    %ecx,%eax
80104388:	72 2a                	jb     801043b4 <argptr+0x60>
  *ip = *(int*)(addr);
8010438a:	8b 43 04             	mov    0x4(%ebx),%eax
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010438d:	8b 55 10             	mov    0x10(%ebp),%edx
80104390:	85 d2                	test   %edx,%edx
80104392:	78 20                	js     801043b4 <argptr+0x60>
80104394:	8b 16                	mov    (%esi),%edx
80104396:	39 c2                	cmp    %eax,%edx
80104398:	76 1a                	jbe    801043b4 <argptr+0x60>
8010439a:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010439d:	01 c3                	add    %eax,%ebx
8010439f:	39 da                	cmp    %ebx,%edx
801043a1:	72 11                	jb     801043b4 <argptr+0x60>
    return -1;
  *pp = (char*)i;
801043a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801043a6:	89 02                	mov    %eax,(%edx)
  return 0;
801043a8:	31 c0                	xor    %eax,%eax
}
801043aa:	83 c4 0c             	add    $0xc,%esp
801043ad:	5b                   	pop    %ebx
801043ae:	5e                   	pop    %esi
801043af:	5f                   	pop    %edi
801043b0:	5d                   	pop    %ebp
801043b1:	c3                   	ret    
801043b2:	66 90                	xchg   %ax,%ax
    return -1;
801043b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801043b9:	eb ef                	jmp    801043aa <argptr+0x56>
801043bb:	90                   	nop

801043bc <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801043bc:	55                   	push   %ebp
801043bd:	89 e5                	mov    %esp,%ebp
801043bf:	56                   	push   %esi
801043c0:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801043c1:	e8 e6 f0 ff ff       	call   801034ac <myproc>
801043c6:	8b 40 18             	mov    0x18(%eax),%eax
801043c9:	8b 40 44             	mov    0x44(%eax),%eax
801043cc:	8b 55 08             	mov    0x8(%ebp),%edx
801043cf:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
801043d2:	8d 73 04             	lea    0x4(%ebx),%esi
  struct proc *curproc = myproc();
801043d5:	e8 d2 f0 ff ff       	call   801034ac <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801043da:	8b 00                	mov    (%eax),%eax
801043dc:	39 c6                	cmp    %eax,%esi
801043de:	73 34                	jae    80104414 <argstr+0x58>
801043e0:	8d 53 08             	lea    0x8(%ebx),%edx
801043e3:	39 d0                	cmp    %edx,%eax
801043e5:	72 2d                	jb     80104414 <argstr+0x58>
  *ip = *(int*)(addr);
801043e7:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
801043ea:	e8 bd f0 ff ff       	call   801034ac <myproc>
  if(addr >= curproc->sz)
801043ef:	3b 18                	cmp    (%eax),%ebx
801043f1:	73 21                	jae    80104414 <argstr+0x58>
  *pp = (char*)addr;
801043f3:	8b 55 0c             	mov    0xc(%ebp),%edx
801043f6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801043f8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801043fa:	39 d3                	cmp    %edx,%ebx
801043fc:	73 16                	jae    80104414 <argstr+0x58>
801043fe:	89 d8                	mov    %ebx,%eax
80104400:	eb 07                	jmp    80104409 <argstr+0x4d>
80104402:	66 90                	xchg   %ax,%ax
80104404:	40                   	inc    %eax
80104405:	39 c2                	cmp    %eax,%edx
80104407:	76 0b                	jbe    80104414 <argstr+0x58>
    if(*s == 0)
80104409:	80 38 00             	cmpb   $0x0,(%eax)
8010440c:	75 f6                	jne    80104404 <argstr+0x48>
      return s - *pp;
8010440e:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104410:	5b                   	pop    %ebx
80104411:	5e                   	pop    %esi
80104412:	5d                   	pop    %ebp
80104413:	c3                   	ret    
    return -1;
80104414:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104419:	5b                   	pop    %ebx
8010441a:	5e                   	pop    %esi
8010441b:	5d                   	pop    %ebp
8010441c:	c3                   	ret    
8010441d:	8d 76 00             	lea    0x0(%esi),%esi

80104420 <syscall>:
[SYS_getprocs] sys_getprocs,
};

void
syscall(void)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	53                   	push   %ebx
80104424:	50                   	push   %eax
  int num;
  struct proc *curproc = myproc();
80104425:	e8 82 f0 ff ff       	call   801034ac <myproc>
8010442a:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010442c:	8b 40 18             	mov    0x18(%eax),%eax
8010442f:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104432:	8d 50 ff             	lea    -0x1(%eax),%edx
80104435:	83 fa 15             	cmp    $0x15,%edx
80104438:	77 1a                	ja     80104454 <syscall+0x34>
8010443a:	8b 14 85 80 6f 10 80 	mov    -0x7fef9080(,%eax,4),%edx
80104441:	85 d2                	test   %edx,%edx
80104443:	74 0f                	je     80104454 <syscall+0x34>
    curproc->tf->eax = syscalls[num]();
80104445:	ff d2                	call   *%edx
80104447:	8b 53 18             	mov    0x18(%ebx),%edx
8010444a:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010444d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104450:	c9                   	leave  
80104451:	c3                   	ret    
80104452:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80104454:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104455:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104458:	50                   	push   %eax
80104459:	ff 73 10             	push   0x10(%ebx)
8010445c:	68 5d 6f 10 80       	push   $0x80106f5d
80104461:	e8 b6 c1 ff ff       	call   8010061c <cprintf>
    curproc->tf->eax = -1;
80104466:	8b 43 18             	mov    0x18(%ebx),%eax
80104469:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
80104470:	83 c4 10             	add    $0x10,%esp
}
80104473:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104476:	c9                   	leave  
80104477:	c3                   	ret    

80104478 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104478:	55                   	push   %ebp
80104479:	89 e5                	mov    %esp,%ebp
8010447b:	57                   	push   %edi
8010447c:	56                   	push   %esi
8010447d:	53                   	push   %ebx
8010447e:	83 ec 34             	sub    $0x34,%esp
80104481:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104484:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104487:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010448a:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010448d:	8d 7d da             	lea    -0x26(%ebp),%edi
80104490:	57                   	push   %edi
80104491:	50                   	push   %eax
80104492:	e8 b5 d9 ff ff       	call   80101e4c <nameiparent>
80104497:	83 c4 10             	add    $0x10,%esp
8010449a:	85 c0                	test   %eax,%eax
8010449c:	0f 84 22 01 00 00    	je     801045c4 <create+0x14c>
801044a2:	89 c3                	mov    %eax,%ebx
    return 0;
  ilock(dp);
801044a4:	83 ec 0c             	sub    $0xc,%esp
801044a7:	50                   	push   %eax
801044a8:	e8 13 d1 ff ff       	call   801015c0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801044ad:	83 c4 0c             	add    $0xc,%esp
801044b0:	6a 00                	push   $0x0
801044b2:	57                   	push   %edi
801044b3:	53                   	push   %ebx
801044b4:	e8 03 d6 ff ff       	call   80101abc <dirlookup>
801044b9:	89 c6                	mov    %eax,%esi
801044bb:	83 c4 10             	add    $0x10,%esp
801044be:	85 c0                	test   %eax,%eax
801044c0:	74 46                	je     80104508 <create+0x90>
    iunlockput(dp);
801044c2:	83 ec 0c             	sub    $0xc,%esp
801044c5:	53                   	push   %ebx
801044c6:	e8 45 d3 ff ff       	call   80101810 <iunlockput>
    ilock(ip);
801044cb:	89 34 24             	mov    %esi,(%esp)
801044ce:	e8 ed d0 ff ff       	call   801015c0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801044d3:	83 c4 10             	add    $0x10,%esp
801044d6:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801044db:	75 13                	jne    801044f0 <create+0x78>
801044dd:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801044e2:	75 0c                	jne    801044f0 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801044e4:	89 f0                	mov    %esi,%eax
801044e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044e9:	5b                   	pop    %ebx
801044ea:	5e                   	pop    %esi
801044eb:	5f                   	pop    %edi
801044ec:	5d                   	pop    %ebp
801044ed:	c3                   	ret    
801044ee:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
801044f0:	83 ec 0c             	sub    $0xc,%esp
801044f3:	56                   	push   %esi
801044f4:	e8 17 d3 ff ff       	call   80101810 <iunlockput>
    return 0;
801044f9:	83 c4 10             	add    $0x10,%esp
801044fc:	31 f6                	xor    %esi,%esi
}
801044fe:	89 f0                	mov    %esi,%eax
80104500:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104503:	5b                   	pop    %ebx
80104504:	5e                   	pop    %esi
80104505:	5f                   	pop    %edi
80104506:	5d                   	pop    %ebp
80104507:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104508:	83 ec 08             	sub    $0x8,%esp
8010450b:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
8010450f:	50                   	push   %eax
80104510:	ff 33                	push   (%ebx)
80104512:	e8 51 cf ff ff       	call   80101468 <ialloc>
80104517:	89 c6                	mov    %eax,%esi
80104519:	83 c4 10             	add    $0x10,%esp
8010451c:	85 c0                	test   %eax,%eax
8010451e:	0f 84 b9 00 00 00    	je     801045dd <create+0x165>
  ilock(ip);
80104524:	83 ec 0c             	sub    $0xc,%esp
80104527:	50                   	push   %eax
80104528:	e8 93 d0 ff ff       	call   801015c0 <ilock>
  ip->major = major;
8010452d:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104530:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104534:	8b 45 cc             	mov    -0x34(%ebp),%eax
80104537:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
8010453b:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  iupdate(ip);
80104541:	89 34 24             	mov    %esi,(%esp)
80104544:	e8 cf cf ff ff       	call   80101518 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104549:	83 c4 10             	add    $0x10,%esp
8010454c:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104551:	74 29                	je     8010457c <create+0x104>
  if(dirlink(dp, name, ip->inum) < 0)
80104553:	50                   	push   %eax
80104554:	ff 76 04             	push   0x4(%esi)
80104557:	57                   	push   %edi
80104558:	53                   	push   %ebx
80104559:	e8 26 d8 ff ff       	call   80101d84 <dirlink>
8010455e:	83 c4 10             	add    $0x10,%esp
80104561:	85 c0                	test   %eax,%eax
80104563:	78 6b                	js     801045d0 <create+0x158>
  iunlockput(dp);
80104565:	83 ec 0c             	sub    $0xc,%esp
80104568:	53                   	push   %ebx
80104569:	e8 a2 d2 ff ff       	call   80101810 <iunlockput>
  return ip;
8010456e:	83 c4 10             	add    $0x10,%esp
}
80104571:	89 f0                	mov    %esi,%eax
80104573:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104576:	5b                   	pop    %ebx
80104577:	5e                   	pop    %esi
80104578:	5f                   	pop    %edi
80104579:	5d                   	pop    %ebp
8010457a:	c3                   	ret    
8010457b:	90                   	nop
    dp->nlink++;  // for ".."
8010457c:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80104580:	83 ec 0c             	sub    $0xc,%esp
80104583:	53                   	push   %ebx
80104584:	e8 8f cf ff ff       	call   80101518 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104589:	83 c4 0c             	add    $0xc,%esp
8010458c:	ff 76 04             	push   0x4(%esi)
8010458f:	68 f8 6f 10 80       	push   $0x80106ff8
80104594:	56                   	push   %esi
80104595:	e8 ea d7 ff ff       	call   80101d84 <dirlink>
8010459a:	83 c4 10             	add    $0x10,%esp
8010459d:	85 c0                	test   %eax,%eax
8010459f:	78 16                	js     801045b7 <create+0x13f>
801045a1:	52                   	push   %edx
801045a2:	ff 73 04             	push   0x4(%ebx)
801045a5:	68 f7 6f 10 80       	push   $0x80106ff7
801045aa:	56                   	push   %esi
801045ab:	e8 d4 d7 ff ff       	call   80101d84 <dirlink>
801045b0:	83 c4 10             	add    $0x10,%esp
801045b3:	85 c0                	test   %eax,%eax
801045b5:	79 9c                	jns    80104553 <create+0xdb>
      panic("create dots");
801045b7:	83 ec 0c             	sub    $0xc,%esp
801045ba:	68 eb 6f 10 80       	push   $0x80106feb
801045bf:	e8 74 bd ff ff       	call   80100338 <panic>
    return 0;
801045c4:	31 f6                	xor    %esi,%esi
}
801045c6:	89 f0                	mov    %esi,%eax
801045c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045cb:	5b                   	pop    %ebx
801045cc:	5e                   	pop    %esi
801045cd:	5f                   	pop    %edi
801045ce:	5d                   	pop    %ebp
801045cf:	c3                   	ret    
    panic("create: dirlink");
801045d0:	83 ec 0c             	sub    $0xc,%esp
801045d3:	68 fa 6f 10 80       	push   $0x80106ffa
801045d8:	e8 5b bd ff ff       	call   80100338 <panic>
    panic("create: ialloc");
801045dd:	83 ec 0c             	sub    $0xc,%esp
801045e0:	68 dc 6f 10 80       	push   $0x80106fdc
801045e5:	e8 4e bd ff ff       	call   80100338 <panic>
801045ea:	66 90                	xchg   %ax,%ax

801045ec <sys_dup>:
{
801045ec:	55                   	push   %ebp
801045ed:	89 e5                	mov    %esp,%ebp
801045ef:	56                   	push   %esi
801045f0:	53                   	push   %ebx
801045f1:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801045f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801045f7:	50                   	push   %eax
801045f8:	6a 00                	push   $0x0
801045fa:	e8 11 fd ff ff       	call   80104310 <argint>
801045ff:	83 c4 10             	add    $0x10,%esp
80104602:	85 c0                	test   %eax,%eax
80104604:	78 2c                	js     80104632 <sys_dup+0x46>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104606:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010460a:	77 26                	ja     80104632 <sys_dup+0x46>
8010460c:	e8 9b ee ff ff       	call   801034ac <myproc>
80104611:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104614:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104618:	85 f6                	test   %esi,%esi
8010461a:	74 16                	je     80104632 <sys_dup+0x46>
  struct proc *curproc = myproc();
8010461c:	e8 8b ee ff ff       	call   801034ac <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104621:	31 db                	xor    %ebx,%ebx
80104623:	90                   	nop
    if(curproc->ofile[fd] == 0){
80104624:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104628:	85 d2                	test   %edx,%edx
8010462a:	74 14                	je     80104640 <sys_dup+0x54>
  for(fd = 0; fd < NOFILE; fd++){
8010462c:	43                   	inc    %ebx
8010462d:	83 fb 10             	cmp    $0x10,%ebx
80104630:	75 f2                	jne    80104624 <sys_dup+0x38>
    return -1;
80104632:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104637:	89 d8                	mov    %ebx,%eax
80104639:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010463c:	5b                   	pop    %ebx
8010463d:	5e                   	pop    %esi
8010463e:	5d                   	pop    %ebp
8010463f:	c3                   	ret    
      curproc->ofile[fd] = f;
80104640:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104644:	83 ec 0c             	sub    $0xc,%esp
80104647:	56                   	push   %esi
80104648:	e8 53 c7 ff ff       	call   80100da0 <filedup>
  return fd;
8010464d:	83 c4 10             	add    $0x10,%esp
}
80104650:	89 d8                	mov    %ebx,%eax
80104652:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104655:	5b                   	pop    %ebx
80104656:	5e                   	pop    %esi
80104657:	5d                   	pop    %ebp
80104658:	c3                   	ret    
80104659:	8d 76 00             	lea    0x0(%esi),%esi

8010465c <sys_read>:
{
8010465c:	55                   	push   %ebp
8010465d:	89 e5                	mov    %esp,%ebp
8010465f:	56                   	push   %esi
80104660:	53                   	push   %ebx
80104661:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104664:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80104667:	53                   	push   %ebx
80104668:	6a 00                	push   $0x0
8010466a:	e8 a1 fc ff ff       	call   80104310 <argint>
8010466f:	83 c4 10             	add    $0x10,%esp
80104672:	85 c0                	test   %eax,%eax
80104674:	78 56                	js     801046cc <sys_read+0x70>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104676:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010467a:	77 50                	ja     801046cc <sys_read+0x70>
8010467c:	e8 2b ee ff ff       	call   801034ac <myproc>
80104681:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104684:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104688:	85 f6                	test   %esi,%esi
8010468a:	74 40                	je     801046cc <sys_read+0x70>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010468c:	83 ec 08             	sub    $0x8,%esp
8010468f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104692:	50                   	push   %eax
80104693:	6a 02                	push   $0x2
80104695:	e8 76 fc ff ff       	call   80104310 <argint>
8010469a:	83 c4 10             	add    $0x10,%esp
8010469d:	85 c0                	test   %eax,%eax
8010469f:	78 2b                	js     801046cc <sys_read+0x70>
801046a1:	52                   	push   %edx
801046a2:	ff 75 f0             	push   -0x10(%ebp)
801046a5:	53                   	push   %ebx
801046a6:	6a 01                	push   $0x1
801046a8:	e8 a7 fc ff ff       	call   80104354 <argptr>
801046ad:	83 c4 10             	add    $0x10,%esp
801046b0:	85 c0                	test   %eax,%eax
801046b2:	78 18                	js     801046cc <sys_read+0x70>
  return fileread(f, p, n);
801046b4:	50                   	push   %eax
801046b5:	ff 75 f0             	push   -0x10(%ebp)
801046b8:	ff 75 f4             	push   -0xc(%ebp)
801046bb:	56                   	push   %esi
801046bc:	e8 27 c8 ff ff       	call   80100ee8 <fileread>
801046c1:	83 c4 10             	add    $0x10,%esp
}
801046c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046c7:	5b                   	pop    %ebx
801046c8:	5e                   	pop    %esi
801046c9:	5d                   	pop    %ebp
801046ca:	c3                   	ret    
801046cb:	90                   	nop
    return -1;
801046cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046d1:	eb f1                	jmp    801046c4 <sys_read+0x68>
801046d3:	90                   	nop

801046d4 <sys_write>:
{
801046d4:	55                   	push   %ebp
801046d5:	89 e5                	mov    %esp,%ebp
801046d7:	56                   	push   %esi
801046d8:	53                   	push   %ebx
801046d9:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801046dc:	8d 5d f4             	lea    -0xc(%ebp),%ebx
801046df:	53                   	push   %ebx
801046e0:	6a 00                	push   $0x0
801046e2:	e8 29 fc ff ff       	call   80104310 <argint>
801046e7:	83 c4 10             	add    $0x10,%esp
801046ea:	85 c0                	test   %eax,%eax
801046ec:	78 56                	js     80104744 <sys_write+0x70>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801046ee:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801046f2:	77 50                	ja     80104744 <sys_write+0x70>
801046f4:	e8 b3 ed ff ff       	call   801034ac <myproc>
801046f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046fc:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104700:	85 f6                	test   %esi,%esi
80104702:	74 40                	je     80104744 <sys_write+0x70>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104704:	83 ec 08             	sub    $0x8,%esp
80104707:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010470a:	50                   	push   %eax
8010470b:	6a 02                	push   $0x2
8010470d:	e8 fe fb ff ff       	call   80104310 <argint>
80104712:	83 c4 10             	add    $0x10,%esp
80104715:	85 c0                	test   %eax,%eax
80104717:	78 2b                	js     80104744 <sys_write+0x70>
80104719:	52                   	push   %edx
8010471a:	ff 75 f0             	push   -0x10(%ebp)
8010471d:	53                   	push   %ebx
8010471e:	6a 01                	push   $0x1
80104720:	e8 2f fc ff ff       	call   80104354 <argptr>
80104725:	83 c4 10             	add    $0x10,%esp
80104728:	85 c0                	test   %eax,%eax
8010472a:	78 18                	js     80104744 <sys_write+0x70>
  return filewrite(f, p, n);
8010472c:	50                   	push   %eax
8010472d:	ff 75 f0             	push   -0x10(%ebp)
80104730:	ff 75 f4             	push   -0xc(%ebp)
80104733:	56                   	push   %esi
80104734:	e8 3b c8 ff ff       	call   80100f74 <filewrite>
80104739:	83 c4 10             	add    $0x10,%esp
}
8010473c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010473f:	5b                   	pop    %ebx
80104740:	5e                   	pop    %esi
80104741:	5d                   	pop    %ebp
80104742:	c3                   	ret    
80104743:	90                   	nop
    return -1;
80104744:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104749:	eb f1                	jmp    8010473c <sys_write+0x68>
8010474b:	90                   	nop

8010474c <sys_close>:
{
8010474c:	55                   	push   %ebp
8010474d:	89 e5                	mov    %esp,%ebp
8010474f:	56                   	push   %esi
80104750:	53                   	push   %ebx
80104751:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104754:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104757:	50                   	push   %eax
80104758:	6a 00                	push   $0x0
8010475a:	e8 b1 fb ff ff       	call   80104310 <argint>
8010475f:	83 c4 10             	add    $0x10,%esp
80104762:	85 c0                	test   %eax,%eax
80104764:	78 3e                	js     801047a4 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104766:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010476a:	77 38                	ja     801047a4 <sys_close+0x58>
8010476c:	e8 3b ed ff ff       	call   801034ac <myproc>
80104771:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104774:	8d 5a 08             	lea    0x8(%edx),%ebx
80104777:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
8010477b:	85 f6                	test   %esi,%esi
8010477d:	74 25                	je     801047a4 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
8010477f:	e8 28 ed ff ff       	call   801034ac <myproc>
80104784:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
8010478b:	00 
  fileclose(f);
8010478c:	83 ec 0c             	sub    $0xc,%esp
8010478f:	56                   	push   %esi
80104790:	e8 4f c6 ff ff       	call   80100de4 <fileclose>
  return 0;
80104795:	83 c4 10             	add    $0x10,%esp
80104798:	31 c0                	xor    %eax,%eax
}
8010479a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010479d:	5b                   	pop    %ebx
8010479e:	5e                   	pop    %esi
8010479f:	5d                   	pop    %ebp
801047a0:	c3                   	ret    
801047a1:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801047a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047a9:	eb ef                	jmp    8010479a <sys_close+0x4e>
801047ab:	90                   	nop

801047ac <sys_fstat>:
{
801047ac:	55                   	push   %ebp
801047ad:	89 e5                	mov    %esp,%ebp
801047af:	56                   	push   %esi
801047b0:	53                   	push   %ebx
801047b1:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801047b4:	8d 5d f4             	lea    -0xc(%ebp),%ebx
801047b7:	53                   	push   %ebx
801047b8:	6a 00                	push   $0x0
801047ba:	e8 51 fb ff ff       	call   80104310 <argint>
801047bf:	83 c4 10             	add    $0x10,%esp
801047c2:	85 c0                	test   %eax,%eax
801047c4:	78 3e                	js     80104804 <sys_fstat+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801047c6:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801047ca:	77 38                	ja     80104804 <sys_fstat+0x58>
801047cc:	e8 db ec ff ff       	call   801034ac <myproc>
801047d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801047d4:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801047d8:	85 f6                	test   %esi,%esi
801047da:	74 28                	je     80104804 <sys_fstat+0x58>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801047dc:	50                   	push   %eax
801047dd:	6a 14                	push   $0x14
801047df:	53                   	push   %ebx
801047e0:	6a 01                	push   $0x1
801047e2:	e8 6d fb ff ff       	call   80104354 <argptr>
801047e7:	83 c4 10             	add    $0x10,%esp
801047ea:	85 c0                	test   %eax,%eax
801047ec:	78 16                	js     80104804 <sys_fstat+0x58>
  return filestat(f, st);
801047ee:	83 ec 08             	sub    $0x8,%esp
801047f1:	ff 75 f4             	push   -0xc(%ebp)
801047f4:	56                   	push   %esi
801047f5:	e8 aa c6 ff ff       	call   80100ea4 <filestat>
801047fa:	83 c4 10             	add    $0x10,%esp
}
801047fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104800:	5b                   	pop    %ebx
80104801:	5e                   	pop    %esi
80104802:	5d                   	pop    %ebp
80104803:	c3                   	ret    
    return -1;
80104804:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104809:	eb f2                	jmp    801047fd <sys_fstat+0x51>
8010480b:	90                   	nop

8010480c <sys_link>:
{
8010480c:	55                   	push   %ebp
8010480d:	89 e5                	mov    %esp,%ebp
8010480f:	57                   	push   %edi
80104810:	56                   	push   %esi
80104811:	53                   	push   %ebx
80104812:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104815:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104818:	50                   	push   %eax
80104819:	6a 00                	push   $0x0
8010481b:	e8 9c fb ff ff       	call   801043bc <argstr>
80104820:	83 c4 10             	add    $0x10,%esp
80104823:	85 c0                	test   %eax,%eax
80104825:	0f 88 f2 00 00 00    	js     8010491d <sys_link+0x111>
8010482b:	83 ec 08             	sub    $0x8,%esp
8010482e:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104831:	50                   	push   %eax
80104832:	6a 01                	push   $0x1
80104834:	e8 83 fb ff ff       	call   801043bc <argstr>
80104839:	83 c4 10             	add    $0x10,%esp
8010483c:	85 c0                	test   %eax,%eax
8010483e:	0f 88 d9 00 00 00    	js     8010491d <sys_link+0x111>
  begin_op();
80104844:	e8 1f e1 ff ff       	call   80102968 <begin_op>
  if((ip = namei(old)) == 0){
80104849:	83 ec 0c             	sub    $0xc,%esp
8010484c:	ff 75 d4             	push   -0x2c(%ebp)
8010484f:	e8 e0 d5 ff ff       	call   80101e34 <namei>
80104854:	89 c3                	mov    %eax,%ebx
80104856:	83 c4 10             	add    $0x10,%esp
80104859:	85 c0                	test   %eax,%eax
8010485b:	0f 84 db 00 00 00    	je     8010493c <sys_link+0x130>
  ilock(ip);
80104861:	83 ec 0c             	sub    $0xc,%esp
80104864:	50                   	push   %eax
80104865:	e8 56 cd ff ff       	call   801015c0 <ilock>
  if(ip->type == T_DIR){
8010486a:	83 c4 10             	add    $0x10,%esp
8010486d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104872:	0f 84 ac 00 00 00    	je     80104924 <sys_link+0x118>
  ip->nlink++;
80104878:	66 ff 43 56          	incw   0x56(%ebx)
  iupdate(ip);
8010487c:	83 ec 0c             	sub    $0xc,%esp
8010487f:	53                   	push   %ebx
80104880:	e8 93 cc ff ff       	call   80101518 <iupdate>
  iunlock(ip);
80104885:	89 1c 24             	mov    %ebx,(%esp)
80104888:	e8 fb cd ff ff       	call   80101688 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
8010488d:	5a                   	pop    %edx
8010488e:	59                   	pop    %ecx
8010488f:	8d 7d da             	lea    -0x26(%ebp),%edi
80104892:	57                   	push   %edi
80104893:	ff 75 d0             	push   -0x30(%ebp)
80104896:	e8 b1 d5 ff ff       	call   80101e4c <nameiparent>
8010489b:	89 c6                	mov    %eax,%esi
8010489d:	83 c4 10             	add    $0x10,%esp
801048a0:	85 c0                	test   %eax,%eax
801048a2:	74 54                	je     801048f8 <sys_link+0xec>
  ilock(dp);
801048a4:	83 ec 0c             	sub    $0xc,%esp
801048a7:	50                   	push   %eax
801048a8:	e8 13 cd ff ff       	call   801015c0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801048ad:	83 c4 10             	add    $0x10,%esp
801048b0:	8b 03                	mov    (%ebx),%eax
801048b2:	39 06                	cmp    %eax,(%esi)
801048b4:	75 36                	jne    801048ec <sys_link+0xe0>
801048b6:	50                   	push   %eax
801048b7:	ff 73 04             	push   0x4(%ebx)
801048ba:	57                   	push   %edi
801048bb:	56                   	push   %esi
801048bc:	e8 c3 d4 ff ff       	call   80101d84 <dirlink>
801048c1:	83 c4 10             	add    $0x10,%esp
801048c4:	85 c0                	test   %eax,%eax
801048c6:	78 24                	js     801048ec <sys_link+0xe0>
  iunlockput(dp);
801048c8:	83 ec 0c             	sub    $0xc,%esp
801048cb:	56                   	push   %esi
801048cc:	e8 3f cf ff ff       	call   80101810 <iunlockput>
  iput(ip);
801048d1:	89 1c 24             	mov    %ebx,(%esp)
801048d4:	e8 f3 cd ff ff       	call   801016cc <iput>
  end_op();
801048d9:	e8 f2 e0 ff ff       	call   801029d0 <end_op>
  return 0;
801048de:	83 c4 10             	add    $0x10,%esp
801048e1:	31 c0                	xor    %eax,%eax
}
801048e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048e6:	5b                   	pop    %ebx
801048e7:	5e                   	pop    %esi
801048e8:	5f                   	pop    %edi
801048e9:	5d                   	pop    %ebp
801048ea:	c3                   	ret    
801048eb:	90                   	nop
    iunlockput(dp);
801048ec:	83 ec 0c             	sub    $0xc,%esp
801048ef:	56                   	push   %esi
801048f0:	e8 1b cf ff ff       	call   80101810 <iunlockput>
    goto bad;
801048f5:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801048f8:	83 ec 0c             	sub    $0xc,%esp
801048fb:	53                   	push   %ebx
801048fc:	e8 bf cc ff ff       	call   801015c0 <ilock>
  ip->nlink--;
80104901:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80104905:	89 1c 24             	mov    %ebx,(%esp)
80104908:	e8 0b cc ff ff       	call   80101518 <iupdate>
  iunlockput(ip);
8010490d:	89 1c 24             	mov    %ebx,(%esp)
80104910:	e8 fb ce ff ff       	call   80101810 <iunlockput>
  end_op();
80104915:	e8 b6 e0 ff ff       	call   801029d0 <end_op>
  return -1;
8010491a:	83 c4 10             	add    $0x10,%esp
8010491d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104922:	eb bf                	jmp    801048e3 <sys_link+0xd7>
    iunlockput(ip);
80104924:	83 ec 0c             	sub    $0xc,%esp
80104927:	53                   	push   %ebx
80104928:	e8 e3 ce ff ff       	call   80101810 <iunlockput>
    end_op();
8010492d:	e8 9e e0 ff ff       	call   801029d0 <end_op>
    return -1;
80104932:	83 c4 10             	add    $0x10,%esp
80104935:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010493a:	eb a7                	jmp    801048e3 <sys_link+0xd7>
    end_op();
8010493c:	e8 8f e0 ff ff       	call   801029d0 <end_op>
    return -1;
80104941:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104946:	eb 9b                	jmp    801048e3 <sys_link+0xd7>

80104948 <sys_unlink>:
{
80104948:	55                   	push   %ebp
80104949:	89 e5                	mov    %esp,%ebp
8010494b:	57                   	push   %edi
8010494c:	56                   	push   %esi
8010494d:	53                   	push   %ebx
8010494e:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80104951:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104954:	50                   	push   %eax
80104955:	6a 00                	push   $0x0
80104957:	e8 60 fa ff ff       	call   801043bc <argstr>
8010495c:	83 c4 10             	add    $0x10,%esp
8010495f:	85 c0                	test   %eax,%eax
80104961:	0f 88 71 01 00 00    	js     80104ad8 <sys_unlink+0x190>
  begin_op();
80104967:	e8 fc df ff ff       	call   80102968 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
8010496c:	83 ec 08             	sub    $0x8,%esp
8010496f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80104972:	53                   	push   %ebx
80104973:	ff 75 c0             	push   -0x40(%ebp)
80104976:	e8 d1 d4 ff ff       	call   80101e4c <nameiparent>
8010497b:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010497e:	83 c4 10             	add    $0x10,%esp
80104981:	85 c0                	test   %eax,%eax
80104983:	0f 84 59 01 00 00    	je     80104ae2 <sys_unlink+0x19a>
  ilock(dp);
80104989:	83 ec 0c             	sub    $0xc,%esp
8010498c:	8b 7d b4             	mov    -0x4c(%ebp),%edi
8010498f:	57                   	push   %edi
80104990:	e8 2b cc ff ff       	call   801015c0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104995:	59                   	pop    %ecx
80104996:	5e                   	pop    %esi
80104997:	68 f8 6f 10 80       	push   $0x80106ff8
8010499c:	53                   	push   %ebx
8010499d:	e8 02 d1 ff ff       	call   80101aa4 <namecmp>
801049a2:	83 c4 10             	add    $0x10,%esp
801049a5:	85 c0                	test   %eax,%eax
801049a7:	0f 84 f7 00 00 00    	je     80104aa4 <sys_unlink+0x15c>
801049ad:	83 ec 08             	sub    $0x8,%esp
801049b0:	68 f7 6f 10 80       	push   $0x80106ff7
801049b5:	53                   	push   %ebx
801049b6:	e8 e9 d0 ff ff       	call   80101aa4 <namecmp>
801049bb:	83 c4 10             	add    $0x10,%esp
801049be:	85 c0                	test   %eax,%eax
801049c0:	0f 84 de 00 00 00    	je     80104aa4 <sys_unlink+0x15c>
  if((ip = dirlookup(dp, name, &off)) == 0)
801049c6:	52                   	push   %edx
801049c7:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801049ca:	50                   	push   %eax
801049cb:	53                   	push   %ebx
801049cc:	57                   	push   %edi
801049cd:	e8 ea d0 ff ff       	call   80101abc <dirlookup>
801049d2:	89 c3                	mov    %eax,%ebx
801049d4:	83 c4 10             	add    $0x10,%esp
801049d7:	85 c0                	test   %eax,%eax
801049d9:	0f 84 c5 00 00 00    	je     80104aa4 <sys_unlink+0x15c>
  ilock(ip);
801049df:	83 ec 0c             	sub    $0xc,%esp
801049e2:	50                   	push   %eax
801049e3:	e8 d8 cb ff ff       	call   801015c0 <ilock>
  if(ip->nlink < 1)
801049e8:	83 c4 10             	add    $0x10,%esp
801049eb:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801049f0:	0f 8e 15 01 00 00    	jle    80104b0b <sys_unlink+0x1c3>
  if(ip->type == T_DIR && !isdirempty(ip)){
801049f6:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801049fb:	74 67                	je     80104a64 <sys_unlink+0x11c>
801049fd:	8d 7d d8             	lea    -0x28(%ebp),%edi
  memset(&de, 0, sizeof(de));
80104a00:	50                   	push   %eax
80104a01:	6a 10                	push   $0x10
80104a03:	6a 00                	push   $0x0
80104a05:	57                   	push   %edi
80104a06:	e8 dd f6 ff ff       	call   801040e8 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104a0b:	6a 10                	push   $0x10
80104a0d:	ff 75 c4             	push   -0x3c(%ebp)
80104a10:	57                   	push   %edi
80104a11:	ff 75 b4             	push   -0x4c(%ebp)
80104a14:	e8 6b cf ff ff       	call   80101984 <writei>
80104a19:	83 c4 20             	add    $0x20,%esp
80104a1c:	83 f8 10             	cmp    $0x10,%eax
80104a1f:	0f 85 d9 00 00 00    	jne    80104afe <sys_unlink+0x1b6>
  if(ip->type == T_DIR){
80104a25:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104a2a:	0f 84 90 00 00 00    	je     80104ac0 <sys_unlink+0x178>
  iunlockput(dp);
80104a30:	83 ec 0c             	sub    $0xc,%esp
80104a33:	ff 75 b4             	push   -0x4c(%ebp)
80104a36:	e8 d5 cd ff ff       	call   80101810 <iunlockput>
  ip->nlink--;
80104a3b:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80104a3f:	89 1c 24             	mov    %ebx,(%esp)
80104a42:	e8 d1 ca ff ff       	call   80101518 <iupdate>
  iunlockput(ip);
80104a47:	89 1c 24             	mov    %ebx,(%esp)
80104a4a:	e8 c1 cd ff ff       	call   80101810 <iunlockput>
  end_op();
80104a4f:	e8 7c df ff ff       	call   801029d0 <end_op>
  return 0;
80104a54:	83 c4 10             	add    $0x10,%esp
80104a57:	31 c0                	xor    %eax,%eax
}
80104a59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a5c:	5b                   	pop    %ebx
80104a5d:	5e                   	pop    %esi
80104a5e:	5f                   	pop    %edi
80104a5f:	5d                   	pop    %ebp
80104a60:	c3                   	ret    
80104a61:	8d 76 00             	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104a64:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104a68:	76 93                	jbe    801049fd <sys_unlink+0xb5>
80104a6a:	be 20 00 00 00       	mov    $0x20,%esi
80104a6f:	8d 7d d8             	lea    -0x28(%ebp),%edi
80104a72:	eb 08                	jmp    80104a7c <sys_unlink+0x134>
80104a74:	83 c6 10             	add    $0x10,%esi
80104a77:	3b 73 58             	cmp    0x58(%ebx),%esi
80104a7a:	73 84                	jae    80104a00 <sys_unlink+0xb8>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104a7c:	6a 10                	push   $0x10
80104a7e:	56                   	push   %esi
80104a7f:	57                   	push   %edi
80104a80:	53                   	push   %ebx
80104a81:	e8 06 ce ff ff       	call   8010188c <readi>
80104a86:	83 c4 10             	add    $0x10,%esp
80104a89:	83 f8 10             	cmp    $0x10,%eax
80104a8c:	75 63                	jne    80104af1 <sys_unlink+0x1a9>
    if(de.inum != 0)
80104a8e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104a93:	74 df                	je     80104a74 <sys_unlink+0x12c>
    iunlockput(ip);
80104a95:	83 ec 0c             	sub    $0xc,%esp
80104a98:	53                   	push   %ebx
80104a99:	e8 72 cd ff ff       	call   80101810 <iunlockput>
    goto bad;
80104a9e:	83 c4 10             	add    $0x10,%esp
80104aa1:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80104aa4:	83 ec 0c             	sub    $0xc,%esp
80104aa7:	ff 75 b4             	push   -0x4c(%ebp)
80104aaa:	e8 61 cd ff ff       	call   80101810 <iunlockput>
  end_op();
80104aaf:	e8 1c df ff ff       	call   801029d0 <end_op>
  return -1;
80104ab4:	83 c4 10             	add    $0x10,%esp
80104ab7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104abc:	eb 9b                	jmp    80104a59 <sys_unlink+0x111>
80104abe:	66 90                	xchg   %ax,%ax
    dp->nlink--;
80104ac0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104ac3:	66 ff 48 56          	decw   0x56(%eax)
    iupdate(dp);
80104ac7:	83 ec 0c             	sub    $0xc,%esp
80104aca:	50                   	push   %eax
80104acb:	e8 48 ca ff ff       	call   80101518 <iupdate>
80104ad0:	83 c4 10             	add    $0x10,%esp
80104ad3:	e9 58 ff ff ff       	jmp    80104a30 <sys_unlink+0xe8>
    return -1;
80104ad8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104add:	e9 77 ff ff ff       	jmp    80104a59 <sys_unlink+0x111>
    end_op();
80104ae2:	e8 e9 de ff ff       	call   801029d0 <end_op>
    return -1;
80104ae7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104aec:	e9 68 ff ff ff       	jmp    80104a59 <sys_unlink+0x111>
      panic("isdirempty: readi");
80104af1:	83 ec 0c             	sub    $0xc,%esp
80104af4:	68 1c 70 10 80       	push   $0x8010701c
80104af9:	e8 3a b8 ff ff       	call   80100338 <panic>
    panic("unlink: writei");
80104afe:	83 ec 0c             	sub    $0xc,%esp
80104b01:	68 2e 70 10 80       	push   $0x8010702e
80104b06:	e8 2d b8 ff ff       	call   80100338 <panic>
    panic("unlink: nlink < 1");
80104b0b:	83 ec 0c             	sub    $0xc,%esp
80104b0e:	68 0a 70 10 80       	push   $0x8010700a
80104b13:	e8 20 b8 ff ff       	call   80100338 <panic>

80104b18 <sys_open>:

int
sys_open(void)
{
80104b18:	55                   	push   %ebp
80104b19:	89 e5                	mov    %esp,%ebp
80104b1b:	56                   	push   %esi
80104b1c:	53                   	push   %ebx
80104b1d:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104b20:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b23:	50                   	push   %eax
80104b24:	6a 00                	push   $0x0
80104b26:	e8 91 f8 ff ff       	call   801043bc <argstr>
80104b2b:	83 c4 10             	add    $0x10,%esp
80104b2e:	85 c0                	test   %eax,%eax
80104b30:	0f 88 8d 00 00 00    	js     80104bc3 <sys_open+0xab>
80104b36:	83 ec 08             	sub    $0x8,%esp
80104b39:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b3c:	50                   	push   %eax
80104b3d:	6a 01                	push   $0x1
80104b3f:	e8 cc f7 ff ff       	call   80104310 <argint>
80104b44:	83 c4 10             	add    $0x10,%esp
80104b47:	85 c0                	test   %eax,%eax
80104b49:	78 78                	js     80104bc3 <sys_open+0xab>
    return -1;

  begin_op();
80104b4b:	e8 18 de ff ff       	call   80102968 <begin_op>

  if(omode & O_CREATE){
80104b50:	f6 45 f5 02          	testb  $0x2,-0xb(%ebp)
80104b54:	75 76                	jne    80104bcc <sys_open+0xb4>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80104b56:	83 ec 0c             	sub    $0xc,%esp
80104b59:	ff 75 f0             	push   -0x10(%ebp)
80104b5c:	e8 d3 d2 ff ff       	call   80101e34 <namei>
80104b61:	89 c3                	mov    %eax,%ebx
80104b63:	83 c4 10             	add    $0x10,%esp
80104b66:	85 c0                	test   %eax,%eax
80104b68:	74 7f                	je     80104be9 <sys_open+0xd1>
      end_op();
      return -1;
    }
    ilock(ip);
80104b6a:	83 ec 0c             	sub    $0xc,%esp
80104b6d:	50                   	push   %eax
80104b6e:	e8 4d ca ff ff       	call   801015c0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80104b73:	83 c4 10             	add    $0x10,%esp
80104b76:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104b7b:	0f 84 bf 00 00 00    	je     80104c40 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80104b81:	e8 ba c1 ff ff       	call   80100d40 <filealloc>
80104b86:	89 c6                	mov    %eax,%esi
80104b88:	85 c0                	test   %eax,%eax
80104b8a:	74 26                	je     80104bb2 <sys_open+0x9a>
  struct proc *curproc = myproc();
80104b8c:	e8 1b e9 ff ff       	call   801034ac <myproc>
80104b91:	89 c2                	mov    %eax,%edx
  for(fd = 0; fd < NOFILE; fd++){
80104b93:	31 c0                	xor    %eax,%eax
80104b95:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80104b98:	8b 4c 82 28          	mov    0x28(%edx,%eax,4),%ecx
80104b9c:	85 c9                	test   %ecx,%ecx
80104b9e:	74 58                	je     80104bf8 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80104ba0:	40                   	inc    %eax
80104ba1:	83 f8 10             	cmp    $0x10,%eax
80104ba4:	75 f2                	jne    80104b98 <sys_open+0x80>
    if(f)
      fileclose(f);
80104ba6:	83 ec 0c             	sub    $0xc,%esp
80104ba9:	56                   	push   %esi
80104baa:	e8 35 c2 ff ff       	call   80100de4 <fileclose>
80104baf:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80104bb2:	83 ec 0c             	sub    $0xc,%esp
80104bb5:	53                   	push   %ebx
80104bb6:	e8 55 cc ff ff       	call   80101810 <iunlockput>
    end_op();
80104bbb:	e8 10 de ff ff       	call   801029d0 <end_op>
    return -1;
80104bc0:	83 c4 10             	add    $0x10,%esp
80104bc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bc8:	eb 6d                	jmp    80104c37 <sys_open+0x11f>
80104bca:	66 90                	xchg   %ax,%ax
    ip = create(path, T_FILE, 0, 0);
80104bcc:	83 ec 0c             	sub    $0xc,%esp
80104bcf:	6a 00                	push   $0x0
80104bd1:	31 c9                	xor    %ecx,%ecx
80104bd3:	ba 02 00 00 00       	mov    $0x2,%edx
80104bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bdb:	e8 98 f8 ff ff       	call   80104478 <create>
80104be0:	89 c3                	mov    %eax,%ebx
    if(ip == 0){
80104be2:	83 c4 10             	add    $0x10,%esp
80104be5:	85 c0                	test   %eax,%eax
80104be7:	75 98                	jne    80104b81 <sys_open+0x69>
      end_op();
80104be9:	e8 e2 dd ff ff       	call   801029d0 <end_op>
      return -1;
80104bee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bf3:	eb 42                	jmp    80104c37 <sys_open+0x11f>
80104bf5:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80104bf8:	89 74 82 28          	mov    %esi,0x28(%edx,%eax,4)
80104bfc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  }
  iunlock(ip);
80104bff:	83 ec 0c             	sub    $0xc,%esp
80104c02:	53                   	push   %ebx
80104c03:	e8 80 ca ff ff       	call   80101688 <iunlock>
  end_op();
80104c08:	e8 c3 dd ff ff       	call   801029d0 <end_op>

  f->type = FD_INODE;
80104c0d:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
80104c13:	89 5e 10             	mov    %ebx,0x10(%esi)
  f->off = 0;
80104c16:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80104c1d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80104c20:	89 ca                	mov    %ecx,%edx
80104c22:	f7 d2                	not    %edx
80104c24:	83 e2 01             	and    $0x1,%edx
80104c27:	88 56 08             	mov    %dl,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104c2a:	83 c4 10             	add    $0x10,%esp
80104c2d:	83 e1 03             	and    $0x3,%ecx
80104c30:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
80104c34:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80104c37:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c3a:	5b                   	pop    %ebx
80104c3b:	5e                   	pop    %esi
80104c3c:	5d                   	pop    %ebp
80104c3d:	c3                   	ret    
80104c3e:	66 90                	xchg   %ax,%ax
    if(ip->type == T_DIR && omode != O_RDONLY){
80104c40:	8b 75 f4             	mov    -0xc(%ebp),%esi
80104c43:	85 f6                	test   %esi,%esi
80104c45:	0f 84 36 ff ff ff    	je     80104b81 <sys_open+0x69>
80104c4b:	e9 62 ff ff ff       	jmp    80104bb2 <sys_open+0x9a>

80104c50 <sys_mkdir>:

int
sys_mkdir(void)
{
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80104c56:	e8 0d dd ff ff       	call   80102968 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80104c5b:	83 ec 08             	sub    $0x8,%esp
80104c5e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c61:	50                   	push   %eax
80104c62:	6a 00                	push   $0x0
80104c64:	e8 53 f7 ff ff       	call   801043bc <argstr>
80104c69:	83 c4 10             	add    $0x10,%esp
80104c6c:	85 c0                	test   %eax,%eax
80104c6e:	78 30                	js     80104ca0 <sys_mkdir+0x50>
80104c70:	83 ec 0c             	sub    $0xc,%esp
80104c73:	6a 00                	push   $0x0
80104c75:	31 c9                	xor    %ecx,%ecx
80104c77:	ba 01 00 00 00       	mov    $0x1,%edx
80104c7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c7f:	e8 f4 f7 ff ff       	call   80104478 <create>
80104c84:	83 c4 10             	add    $0x10,%esp
80104c87:	85 c0                	test   %eax,%eax
80104c89:	74 15                	je     80104ca0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104c8b:	83 ec 0c             	sub    $0xc,%esp
80104c8e:	50                   	push   %eax
80104c8f:	e8 7c cb ff ff       	call   80101810 <iunlockput>
  end_op();
80104c94:	e8 37 dd ff ff       	call   801029d0 <end_op>
  return 0;
80104c99:	83 c4 10             	add    $0x10,%esp
80104c9c:	31 c0                	xor    %eax,%eax
}
80104c9e:	c9                   	leave  
80104c9f:	c3                   	ret    
    end_op();
80104ca0:	e8 2b dd ff ff       	call   801029d0 <end_op>
    return -1;
80104ca5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104caa:	c9                   	leave  
80104cab:	c3                   	ret    

80104cac <sys_mknod>:

int
sys_mknod(void)
{
80104cac:	55                   	push   %ebp
80104cad:	89 e5                	mov    %esp,%ebp
80104caf:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80104cb2:	e8 b1 dc ff ff       	call   80102968 <begin_op>
  if((argstr(0, &path)) < 0 ||
80104cb7:	83 ec 08             	sub    $0x8,%esp
80104cba:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104cbd:	50                   	push   %eax
80104cbe:	6a 00                	push   $0x0
80104cc0:	e8 f7 f6 ff ff       	call   801043bc <argstr>
80104cc5:	83 c4 10             	add    $0x10,%esp
80104cc8:	85 c0                	test   %eax,%eax
80104cca:	78 60                	js     80104d2c <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80104ccc:	83 ec 08             	sub    $0x8,%esp
80104ccf:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104cd2:	50                   	push   %eax
80104cd3:	6a 01                	push   $0x1
80104cd5:	e8 36 f6 ff ff       	call   80104310 <argint>
  if((argstr(0, &path)) < 0 ||
80104cda:	83 c4 10             	add    $0x10,%esp
80104cdd:	85 c0                	test   %eax,%eax
80104cdf:	78 4b                	js     80104d2c <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80104ce1:	83 ec 08             	sub    $0x8,%esp
80104ce4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ce7:	50                   	push   %eax
80104ce8:	6a 02                	push   $0x2
80104cea:	e8 21 f6 ff ff       	call   80104310 <argint>
     argint(1, &major) < 0 ||
80104cef:	83 c4 10             	add    $0x10,%esp
80104cf2:	85 c0                	test   %eax,%eax
80104cf4:	78 36                	js     80104d2c <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80104cf6:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80104cfa:	83 ec 0c             	sub    $0xc,%esp
80104cfd:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80104d01:	50                   	push   %eax
80104d02:	ba 03 00 00 00       	mov    $0x3,%edx
80104d07:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104d0a:	e8 69 f7 ff ff       	call   80104478 <create>
     argint(2, &minor) < 0 ||
80104d0f:	83 c4 10             	add    $0x10,%esp
80104d12:	85 c0                	test   %eax,%eax
80104d14:	74 16                	je     80104d2c <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104d16:	83 ec 0c             	sub    $0xc,%esp
80104d19:	50                   	push   %eax
80104d1a:	e8 f1 ca ff ff       	call   80101810 <iunlockput>
  end_op();
80104d1f:	e8 ac dc ff ff       	call   801029d0 <end_op>
  return 0;
80104d24:	83 c4 10             	add    $0x10,%esp
80104d27:	31 c0                	xor    %eax,%eax
}
80104d29:	c9                   	leave  
80104d2a:	c3                   	ret    
80104d2b:	90                   	nop
    end_op();
80104d2c:	e8 9f dc ff ff       	call   801029d0 <end_op>
    return -1;
80104d31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d36:	c9                   	leave  
80104d37:	c3                   	ret    

80104d38 <sys_chdir>:

int
sys_chdir(void)
{
80104d38:	55                   	push   %ebp
80104d39:	89 e5                	mov    %esp,%ebp
80104d3b:	56                   	push   %esi
80104d3c:	53                   	push   %ebx
80104d3d:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80104d40:	e8 67 e7 ff ff       	call   801034ac <myproc>
80104d45:	89 c6                	mov    %eax,%esi
  
  begin_op();
80104d47:	e8 1c dc ff ff       	call   80102968 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80104d4c:	83 ec 08             	sub    $0x8,%esp
80104d4f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d52:	50                   	push   %eax
80104d53:	6a 00                	push   $0x0
80104d55:	e8 62 f6 ff ff       	call   801043bc <argstr>
80104d5a:	83 c4 10             	add    $0x10,%esp
80104d5d:	85 c0                	test   %eax,%eax
80104d5f:	78 67                	js     80104dc8 <sys_chdir+0x90>
80104d61:	83 ec 0c             	sub    $0xc,%esp
80104d64:	ff 75 f4             	push   -0xc(%ebp)
80104d67:	e8 c8 d0 ff ff       	call   80101e34 <namei>
80104d6c:	89 c3                	mov    %eax,%ebx
80104d6e:	83 c4 10             	add    $0x10,%esp
80104d71:	85 c0                	test   %eax,%eax
80104d73:	74 53                	je     80104dc8 <sys_chdir+0x90>
    end_op();
    return -1;
  }
  ilock(ip);
80104d75:	83 ec 0c             	sub    $0xc,%esp
80104d78:	50                   	push   %eax
80104d79:	e8 42 c8 ff ff       	call   801015c0 <ilock>
  if(ip->type != T_DIR){
80104d7e:	83 c4 10             	add    $0x10,%esp
80104d81:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104d86:	75 28                	jne    80104db0 <sys_chdir+0x78>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104d88:	83 ec 0c             	sub    $0xc,%esp
80104d8b:	53                   	push   %ebx
80104d8c:	e8 f7 c8 ff ff       	call   80101688 <iunlock>
  iput(curproc->cwd);
80104d91:	58                   	pop    %eax
80104d92:	ff 76 68             	push   0x68(%esi)
80104d95:	e8 32 c9 ff ff       	call   801016cc <iput>
  end_op();
80104d9a:	e8 31 dc ff ff       	call   801029d0 <end_op>
  curproc->cwd = ip;
80104d9f:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80104da2:	83 c4 10             	add    $0x10,%esp
80104da5:	31 c0                	xor    %eax,%eax
}
80104da7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104daa:	5b                   	pop    %ebx
80104dab:	5e                   	pop    %esi
80104dac:	5d                   	pop    %ebp
80104dad:	c3                   	ret    
80104dae:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104db0:	83 ec 0c             	sub    $0xc,%esp
80104db3:	53                   	push   %ebx
80104db4:	e8 57 ca ff ff       	call   80101810 <iunlockput>
    end_op();
80104db9:	e8 12 dc ff ff       	call   801029d0 <end_op>
    return -1;
80104dbe:	83 c4 10             	add    $0x10,%esp
80104dc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104dc6:	eb df                	jmp    80104da7 <sys_chdir+0x6f>
    end_op();
80104dc8:	e8 03 dc ff ff       	call   801029d0 <end_op>
    return -1;
80104dcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104dd2:	eb d3                	jmp    80104da7 <sys_chdir+0x6f>

80104dd4 <sys_exec>:

int
sys_exec(void)
{
80104dd4:	55                   	push   %ebp
80104dd5:	89 e5                	mov    %esp,%ebp
80104dd7:	57                   	push   %edi
80104dd8:	56                   	push   %esi
80104dd9:	53                   	push   %ebx
80104dda:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80104de0:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80104de6:	50                   	push   %eax
80104de7:	6a 00                	push   $0x0
80104de9:	e8 ce f5 ff ff       	call   801043bc <argstr>
80104dee:	83 c4 10             	add    $0x10,%esp
80104df1:	85 c0                	test   %eax,%eax
80104df3:	78 79                	js     80104e6e <sys_exec+0x9a>
80104df5:	83 ec 08             	sub    $0x8,%esp
80104df8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80104dfe:	50                   	push   %eax
80104dff:	6a 01                	push   $0x1
80104e01:	e8 0a f5 ff ff       	call   80104310 <argint>
80104e06:	83 c4 10             	add    $0x10,%esp
80104e09:	85 c0                	test   %eax,%eax
80104e0b:	78 61                	js     80104e6e <sys_exec+0x9a>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80104e0d:	50                   	push   %eax
80104e0e:	68 80 00 00 00       	push   $0x80
80104e13:	6a 00                	push   $0x0
80104e15:	8d bd 68 ff ff ff    	lea    -0x98(%ebp),%edi
80104e1b:	57                   	push   %edi
80104e1c:	e8 c7 f2 ff ff       	call   801040e8 <memset>
80104e21:	83 c4 10             	add    $0x10,%esp
80104e24:	31 db                	xor    %ebx,%ebx
  for(i=0;; i++){
80104e26:	31 f6                	xor    %esi,%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80104e28:	83 ec 08             	sub    $0x8,%esp
80104e2b:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80104e31:	50                   	push   %eax
80104e32:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80104e38:	01 d8                	add    %ebx,%eax
80104e3a:	50                   	push   %eax
80104e3b:	e8 60 f4 ff ff       	call   801042a0 <fetchint>
80104e40:	83 c4 10             	add    $0x10,%esp
80104e43:	85 c0                	test   %eax,%eax
80104e45:	78 27                	js     80104e6e <sys_exec+0x9a>
      return -1;
    if(uarg == 0){
80104e47:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80104e4d:	85 c0                	test   %eax,%eax
80104e4f:	74 2b                	je     80104e7c <sys_exec+0xa8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80104e51:	83 ec 08             	sub    $0x8,%esp
80104e54:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
80104e57:	52                   	push   %edx
80104e58:	50                   	push   %eax
80104e59:	e8 72 f4 ff ff       	call   801042d0 <fetchstr>
80104e5e:	83 c4 10             	add    $0x10,%esp
80104e61:	85 c0                	test   %eax,%eax
80104e63:	78 09                	js     80104e6e <sys_exec+0x9a>
  for(i=0;; i++){
80104e65:	46                   	inc    %esi
    if(i >= NELEM(argv))
80104e66:	83 c3 04             	add    $0x4,%ebx
80104e69:	83 fe 20             	cmp    $0x20,%esi
80104e6c:	75 ba                	jne    80104e28 <sys_exec+0x54>
    return -1;
80104e6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return -1;
  }
  return exec(path, argv);
}
80104e73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e76:	5b                   	pop    %ebx
80104e77:	5e                   	pop    %esi
80104e78:	5f                   	pop    %edi
80104e79:	5d                   	pop    %ebp
80104e7a:	c3                   	ret    
80104e7b:	90                   	nop
      argv[i] = 0;
80104e7c:	c7 84 b5 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%esi,4)
80104e83:	00 00 00 00 
  return exec(path, argv);
80104e87:	83 ec 08             	sub    $0x8,%esp
80104e8a:	57                   	push   %edi
80104e8b:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80104e91:	e8 56 bb ff ff       	call   801009ec <exec>
80104e96:	83 c4 10             	add    $0x10,%esp
}
80104e99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e9c:	5b                   	pop    %ebx
80104e9d:	5e                   	pop    %esi
80104e9e:	5f                   	pop    %edi
80104e9f:	5d                   	pop    %ebp
80104ea0:	c3                   	ret    
80104ea1:	8d 76 00             	lea    0x0(%esi),%esi

80104ea4 <sys_pipe>:

int
sys_pipe(void)
{
80104ea4:	55                   	push   %ebp
80104ea5:	89 e5                	mov    %esp,%ebp
80104ea7:	57                   	push   %edi
80104ea8:	56                   	push   %esi
80104ea9:	53                   	push   %ebx
80104eaa:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80104ead:	6a 08                	push   $0x8
80104eaf:	8d 45 dc             	lea    -0x24(%ebp),%eax
80104eb2:	50                   	push   %eax
80104eb3:	6a 00                	push   $0x0
80104eb5:	e8 9a f4 ff ff       	call   80104354 <argptr>
80104eba:	83 c4 10             	add    $0x10,%esp
80104ebd:	85 c0                	test   %eax,%eax
80104ebf:	78 48                	js     80104f09 <sys_pipe+0x65>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80104ec1:	83 ec 08             	sub    $0x8,%esp
80104ec4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104ec7:	50                   	push   %eax
80104ec8:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104ecb:	50                   	push   %eax
80104ecc:	e8 b7 e0 ff ff       	call   80102f88 <pipealloc>
80104ed1:	83 c4 10             	add    $0x10,%esp
80104ed4:	85 c0                	test   %eax,%eax
80104ed6:	78 31                	js     80104f09 <sys_pipe+0x65>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104ed8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  struct proc *curproc = myproc();
80104edb:	e8 cc e5 ff ff       	call   801034ac <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104ee0:	31 db                	xor    %ebx,%ebx
80104ee2:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80104ee4:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80104ee8:	85 f6                	test   %esi,%esi
80104eea:	74 24                	je     80104f10 <sys_pipe+0x6c>
  for(fd = 0; fd < NOFILE; fd++){
80104eec:	43                   	inc    %ebx
80104eed:	83 fb 10             	cmp    $0x10,%ebx
80104ef0:	75 f2                	jne    80104ee4 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80104ef2:	83 ec 0c             	sub    $0xc,%esp
80104ef5:	ff 75 e0             	push   -0x20(%ebp)
80104ef8:	e8 e7 be ff ff       	call   80100de4 <fileclose>
    fileclose(wf);
80104efd:	58                   	pop    %eax
80104efe:	ff 75 e4             	push   -0x1c(%ebp)
80104f01:	e8 de be ff ff       	call   80100de4 <fileclose>
    return -1;
80104f06:	83 c4 10             	add    $0x10,%esp
80104f09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f0e:	eb 45                	jmp    80104f55 <sys_pipe+0xb1>
      curproc->ofile[fd] = f;
80104f10:	8d 73 08             	lea    0x8(%ebx),%esi
80104f13:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104f17:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80104f1a:	e8 8d e5 ff ff       	call   801034ac <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104f1f:	31 d2                	xor    %edx,%edx
80104f21:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80104f24:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80104f28:	85 c9                	test   %ecx,%ecx
80104f2a:	74 18                	je     80104f44 <sys_pipe+0xa0>
  for(fd = 0; fd < NOFILE; fd++){
80104f2c:	42                   	inc    %edx
80104f2d:	83 fa 10             	cmp    $0x10,%edx
80104f30:	75 f2                	jne    80104f24 <sys_pipe+0x80>
      myproc()->ofile[fd0] = 0;
80104f32:	e8 75 e5 ff ff       	call   801034ac <myproc>
80104f37:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80104f3e:	00 
80104f3f:	eb b1                	jmp    80104ef2 <sys_pipe+0x4e>
80104f41:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80104f44:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80104f48:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104f4b:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80104f4d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104f50:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80104f53:	31 c0                	xor    %eax,%eax
}
80104f55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f58:	5b                   	pop    %ebx
80104f59:	5e                   	pop    %esi
80104f5a:	5f                   	pop    %edi
80104f5b:	5d                   	pop    %ebp
80104f5c:	c3                   	ret    
80104f5d:	66 90                	xchg   %ax,%ax
80104f5f:	90                   	nop

80104f60 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80104f60:	e9 bf e6 ff ff       	jmp    80103624 <fork>
80104f65:	8d 76 00             	lea    0x0(%esi),%esi

80104f68 <sys_exit>:
}

int
sys_exit(void)
{
80104f68:	55                   	push   %ebp
80104f69:	89 e5                	mov    %esp,%ebp
80104f6b:	83 ec 08             	sub    $0x8,%esp
  exit();
80104f6e:	e8 09 e9 ff ff       	call   8010387c <exit>
  return 0;  // not reached
}
80104f73:	31 c0                	xor    %eax,%eax
80104f75:	c9                   	leave  
80104f76:	c3                   	ret    
80104f77:	90                   	nop

80104f78 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80104f78:	e9 0f ea ff ff       	jmp    8010398c <wait>
80104f7d:	8d 76 00             	lea    0x0(%esi),%esi

80104f80 <sys_kill>:
}

int
sys_kill(void)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80104f86:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f89:	50                   	push   %eax
80104f8a:	6a 00                	push   $0x0
80104f8c:	e8 7f f3 ff ff       	call   80104310 <argint>
80104f91:	83 c4 10             	add    $0x10,%esp
80104f94:	85 c0                	test   %eax,%eax
80104f96:	78 10                	js     80104fa8 <sys_kill+0x28>
    return -1;
  return kill(pid);
80104f98:	83 ec 0c             	sub    $0xc,%esp
80104f9b:	ff 75 f4             	push   -0xc(%ebp)
80104f9e:	e8 6d ec ff ff       	call   80103c10 <kill>
80104fa3:	83 c4 10             	add    $0x10,%esp
}
80104fa6:	c9                   	leave  
80104fa7:	c3                   	ret    
    return -1;
80104fa8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fad:	c9                   	leave  
80104fae:	c3                   	ret    
80104faf:	90                   	nop

80104fb0 <sys_getpid>:

int
sys_getpid(void)
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80104fb6:	e8 f1 e4 ff ff       	call   801034ac <myproc>
80104fbb:	8b 40 10             	mov    0x10(%eax),%eax
}
80104fbe:	c9                   	leave  
80104fbf:	c3                   	ret    

80104fc0 <sys_sbrk>:

int
sys_sbrk(void)
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	53                   	push   %ebx
80104fc4:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80104fc7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fca:	50                   	push   %eax
80104fcb:	6a 00                	push   $0x0
80104fcd:	e8 3e f3 ff ff       	call   80104310 <argint>
80104fd2:	83 c4 10             	add    $0x10,%esp
80104fd5:	85 c0                	test   %eax,%eax
80104fd7:	78 23                	js     80104ffc <sys_sbrk+0x3c>
    return -1;
  addr = myproc()->sz;
80104fd9:	e8 ce e4 ff ff       	call   801034ac <myproc>
80104fde:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80104fe0:	83 ec 0c             	sub    $0xc,%esp
80104fe3:	ff 75 f4             	push   -0xc(%ebp)
80104fe6:	e8 c9 e5 ff ff       	call   801035b4 <growproc>
80104feb:	83 c4 10             	add    $0x10,%esp
80104fee:	85 c0                	test   %eax,%eax
80104ff0:	78 0a                	js     80104ffc <sys_sbrk+0x3c>
    return -1;
  return addr;
}
80104ff2:	89 d8                	mov    %ebx,%eax
80104ff4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ff7:	c9                   	leave  
80104ff8:	c3                   	ret    
80104ff9:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104ffc:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105001:	eb ef                	jmp    80104ff2 <sys_sbrk+0x32>
80105003:	90                   	nop

80105004 <sys_sleep>:

int
sys_sleep(void)
{
80105004:	55                   	push   %ebp
80105005:	89 e5                	mov    %esp,%ebp
80105007:	53                   	push   %ebx
80105008:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010500b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010500e:	50                   	push   %eax
8010500f:	6a 00                	push   $0x0
80105011:	e8 fa f2 ff ff       	call   80104310 <argint>
80105016:	83 c4 10             	add    $0x10,%esp
80105019:	85 c0                	test   %eax,%eax
8010501b:	78 7e                	js     8010509b <sys_sleep+0x97>
    return -1;
  acquire(&tickslock);
8010501d:	83 ec 0c             	sub    $0xc,%esp
80105020:	68 80 3c 11 80       	push   $0x80113c80
80105025:	e8 16 f0 ff ff       	call   80104040 <acquire>
  ticks0 = ticks;
8010502a:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  while(ticks - ticks0 < n){
80105030:	83 c4 10             	add    $0x10,%esp
80105033:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105036:	85 d2                	test   %edx,%edx
80105038:	75 23                	jne    8010505d <sys_sleep+0x59>
8010503a:	eb 48                	jmp    80105084 <sys_sleep+0x80>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
8010503c:	83 ec 08             	sub    $0x8,%esp
8010503f:	68 80 3c 11 80       	push   $0x80113c80
80105044:	68 60 3c 11 80       	push   $0x80113c60
80105049:	e8 ae ea ff ff       	call   80103afc <sleep>
  while(ticks - ticks0 < n){
8010504e:	a1 60 3c 11 80       	mov    0x80113c60,%eax
80105053:	29 d8                	sub    %ebx,%eax
80105055:	83 c4 10             	add    $0x10,%esp
80105058:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010505b:	73 27                	jae    80105084 <sys_sleep+0x80>
    if(myproc()->killed){
8010505d:	e8 4a e4 ff ff       	call   801034ac <myproc>
80105062:	8b 40 24             	mov    0x24(%eax),%eax
80105065:	85 c0                	test   %eax,%eax
80105067:	74 d3                	je     8010503c <sys_sleep+0x38>
      release(&tickslock);
80105069:	83 ec 0c             	sub    $0xc,%esp
8010506c:	68 80 3c 11 80       	push   $0x80113c80
80105071:	e8 6a ef ff ff       	call   80103fe0 <release>
      return -1;
80105076:	83 c4 10             	add    $0x10,%esp
80105079:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
8010507e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105081:	c9                   	leave  
80105082:	c3                   	ret    
80105083:	90                   	nop
  release(&tickslock);
80105084:	83 ec 0c             	sub    $0xc,%esp
80105087:	68 80 3c 11 80       	push   $0x80113c80
8010508c:	e8 4f ef ff ff       	call   80103fe0 <release>
  return 0;
80105091:	83 c4 10             	add    $0x10,%esp
80105094:	31 c0                	xor    %eax,%eax
}
80105096:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105099:	c9                   	leave  
8010509a:	c3                   	ret    
    return -1;
8010509b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050a0:	eb f4                	jmp    80105096 <sys_sleep+0x92>
801050a2:	66 90                	xchg   %ax,%ax

801050a4 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801050a4:	55                   	push   %ebp
801050a5:	89 e5                	mov    %esp,%ebp
801050a7:	83 ec 24             	sub    $0x24,%esp
  uint xticks;

  acquire(&tickslock);
801050aa:	68 80 3c 11 80       	push   $0x80113c80
801050af:	e8 8c ef ff ff       	call   80104040 <acquire>
  xticks = ticks;
801050b4:	a1 60 3c 11 80       	mov    0x80113c60,%eax
801050b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801050bc:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
801050c3:	e8 18 ef ff ff       	call   80103fe0 <release>
  return xticks;
}
801050c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050cb:	c9                   	leave  
801050cc:	c3                   	ret    
801050cd:	8d 76 00             	lea    0x0(%esi),%esi

801050d0 <sys_getprocs>:

//eh
int sys_getprocs (void) { return getprocs(); }
801050d0:	e9 5f ec ff ff       	jmp    80103d34 <getprocs>

801050d5 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801050d5:	1e                   	push   %ds
  pushl %es
801050d6:	06                   	push   %es
  pushl %fs
801050d7:	0f a0                	push   %fs
  pushl %gs
801050d9:	0f a8                	push   %gs
  pushal
801050db:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801050dc:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801050e0:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801050e2:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801050e4:	54                   	push   %esp
  call trap
801050e5:	e8 9e 00 00 00       	call   80105188 <trap>
  addl $4, %esp
801050ea:	83 c4 04             	add    $0x4,%esp

801050ed <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801050ed:	61                   	popa   
  popl %gs
801050ee:	0f a9                	pop    %gs
  popl %fs
801050f0:	0f a1                	pop    %fs
  popl %es
801050f2:	07                   	pop    %es
  popl %ds
801050f3:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801050f4:	83 c4 08             	add    $0x8,%esp
  iret
801050f7:	cf                   	iret   

801050f8 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801050f8:	55                   	push   %ebp
801050f9:	89 e5                	mov    %esp,%ebp
801050fb:	83 ec 08             	sub    $0x8,%esp
  int i;

  for(i = 0; i < 256; i++)
801050fe:	31 c0                	xor    %eax,%eax
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105100:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105107:	66 89 14 c5 c0 3c 11 	mov    %dx,-0x7feec340(,%eax,8)
8010510e:	80 
8010510f:	c7 04 c5 c2 3c 11 80 	movl   $0x8e000008,-0x7feec33e(,%eax,8)
80105116:	08 00 00 8e 
8010511a:	c1 ea 10             	shr    $0x10,%edx
8010511d:	66 89 14 c5 c6 3c 11 	mov    %dx,-0x7feec33a(,%eax,8)
80105124:	80 
  for(i = 0; i < 256; i++)
80105125:	40                   	inc    %eax
80105126:	3d 00 01 00 00       	cmp    $0x100,%eax
8010512b:	75 d3                	jne    80105100 <tvinit+0x8>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010512d:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105132:	66 a3 c0 3e 11 80    	mov    %ax,0x80113ec0
80105138:	c7 05 c2 3e 11 80 08 	movl   $0xef000008,0x80113ec2
8010513f:	00 00 ef 
80105142:	c1 e8 10             	shr    $0x10,%eax
80105145:	66 a3 c6 3e 11 80    	mov    %ax,0x80113ec6

  initlock(&tickslock, "time");
8010514b:	83 ec 08             	sub    $0x8,%esp
8010514e:	68 3d 70 10 80       	push   $0x8010703d
80105153:	68 80 3c 11 80       	push   $0x80113c80
80105158:	e8 2b ed ff ff       	call   80103e88 <initlock>
}
8010515d:	83 c4 10             	add    $0x10,%esp
80105160:	c9                   	leave  
80105161:	c3                   	ret    
80105162:	66 90                	xchg   %ax,%ax

80105164 <idtinit>:

void
idtinit(void)
{
80105164:	55                   	push   %ebp
80105165:	89 e5                	mov    %esp,%ebp
80105167:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
8010516a:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80105170:	b8 c0 3c 11 80       	mov    $0x80113cc0,%eax
80105175:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105179:	c1 e8 10             	shr    $0x10,%eax
8010517c:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105180:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105183:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105186:	c9                   	leave  
80105187:	c3                   	ret    

80105188 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105188:	55                   	push   %ebp
80105189:	89 e5                	mov    %esp,%ebp
8010518b:	57                   	push   %edi
8010518c:	56                   	push   %esi
8010518d:	53                   	push   %ebx
8010518e:	83 ec 1c             	sub    $0x1c,%esp
80105191:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105194:	8b 43 30             	mov    0x30(%ebx),%eax
80105197:	83 f8 40             	cmp    $0x40,%eax
8010519a:	0f 84 4c 01 00 00    	je     801052ec <trap+0x164>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801051a0:	83 e8 20             	sub    $0x20,%eax
801051a3:	83 f8 1f             	cmp    $0x1f,%eax
801051a6:	77 7c                	ja     80105224 <trap+0x9c>
801051a8:	ff 24 85 e4 70 10 80 	jmp    *-0x7fef8f1c(,%eax,4)
801051af:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801051b0:	e8 cb cd ff ff       	call   80101f80 <ideintr>
    lapiceoi();
801051b5:	e8 de d3 ff ff       	call   80102598 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801051ba:	e8 ed e2 ff ff       	call   801034ac <myproc>
801051bf:	85 c0                	test   %eax,%eax
801051c1:	74 1c                	je     801051df <trap+0x57>
801051c3:	e8 e4 e2 ff ff       	call   801034ac <myproc>
801051c8:	8b 50 24             	mov    0x24(%eax),%edx
801051cb:	85 d2                	test   %edx,%edx
801051cd:	74 10                	je     801051df <trap+0x57>
801051cf:	8b 43 3c             	mov    0x3c(%ebx),%eax
801051d2:	83 e0 03             	and    $0x3,%eax
801051d5:	66 83 f8 03          	cmp    $0x3,%ax
801051d9:	0f 84 c1 01 00 00    	je     801053a0 <trap+0x218>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801051df:	e8 c8 e2 ff ff       	call   801034ac <myproc>
801051e4:	85 c0                	test   %eax,%eax
801051e6:	74 0f                	je     801051f7 <trap+0x6f>
801051e8:	e8 bf e2 ff ff       	call   801034ac <myproc>
801051ed:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801051f1:	0f 84 ad 00 00 00    	je     801052a4 <trap+0x11c>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801051f7:	e8 b0 e2 ff ff       	call   801034ac <myproc>
801051fc:	85 c0                	test   %eax,%eax
801051fe:	74 1c                	je     8010521c <trap+0x94>
80105200:	e8 a7 e2 ff ff       	call   801034ac <myproc>
80105205:	8b 40 24             	mov    0x24(%eax),%eax
80105208:	85 c0                	test   %eax,%eax
8010520a:	74 10                	je     8010521c <trap+0x94>
8010520c:	8b 43 3c             	mov    0x3c(%ebx),%eax
8010520f:	83 e0 03             	and    $0x3,%eax
80105212:	66 83 f8 03          	cmp    $0x3,%ax
80105216:	0f 84 fd 00 00 00    	je     80105319 <trap+0x191>
    exit();
}
8010521c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010521f:	5b                   	pop    %ebx
80105220:	5e                   	pop    %esi
80105221:	5f                   	pop    %edi
80105222:	5d                   	pop    %ebp
80105223:	c3                   	ret    
    if(myproc() == 0 || (tf->cs&3) == 0){
80105224:	e8 83 e2 ff ff       	call   801034ac <myproc>
80105229:	8b 7b 38             	mov    0x38(%ebx),%edi
8010522c:	85 c0                	test   %eax,%eax
8010522e:	0f 84 82 01 00 00    	je     801053b6 <trap+0x22e>
80105234:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105238:	0f 84 78 01 00 00    	je     801053b6 <trap+0x22e>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010523e:	0f 20 d1             	mov    %cr2,%ecx
80105241:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105244:	e8 2f e2 ff ff       	call   80103478 <cpuid>
80105249:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010524c:	8b 43 34             	mov    0x34(%ebx),%eax
8010524f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105252:	8b 73 30             	mov    0x30(%ebx),%esi
            myproc()->pid, myproc()->name, tf->trapno,
80105255:	e8 52 e2 ff ff       	call   801034ac <myproc>
8010525a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010525d:	e8 4a e2 ff ff       	call   801034ac <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105262:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105265:	51                   	push   %ecx
80105266:	57                   	push   %edi
80105267:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010526a:	52                   	push   %edx
8010526b:	ff 75 e4             	push   -0x1c(%ebp)
8010526e:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010526f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105272:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105275:	56                   	push   %esi
80105276:	ff 70 10             	push   0x10(%eax)
80105279:	68 a0 70 10 80       	push   $0x801070a0
8010527e:	e8 99 b3 ff ff       	call   8010061c <cprintf>
    myproc()->killed = 1;
80105283:	83 c4 20             	add    $0x20,%esp
80105286:	e8 21 e2 ff ff       	call   801034ac <myproc>
8010528b:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105292:	e8 15 e2 ff ff       	call   801034ac <myproc>
80105297:	85 c0                	test   %eax,%eax
80105299:	0f 85 24 ff ff ff    	jne    801051c3 <trap+0x3b>
8010529f:	e9 3b ff ff ff       	jmp    801051df <trap+0x57>
  if(myproc() && myproc()->state == RUNNING &&
801052a4:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801052a8:	0f 85 49 ff ff ff    	jne    801051f7 <trap+0x6f>
    yield();
801052ae:	e8 01 e8 ff ff       	call   80103ab4 <yield>
801052b3:	e9 3f ff ff ff       	jmp    801051f7 <trap+0x6f>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801052b8:	8b 7b 38             	mov    0x38(%ebx),%edi
801052bb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801052bf:	e8 b4 e1 ff ff       	call   80103478 <cpuid>
801052c4:	57                   	push   %edi
801052c5:	56                   	push   %esi
801052c6:	50                   	push   %eax
801052c7:	68 48 70 10 80       	push   $0x80107048
801052cc:	e8 4b b3 ff ff       	call   8010061c <cprintf>
    lapiceoi();
801052d1:	e8 c2 d2 ff ff       	call   80102598 <lapiceoi>
    break;
801052d6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801052d9:	e8 ce e1 ff ff       	call   801034ac <myproc>
801052de:	85 c0                	test   %eax,%eax
801052e0:	0f 85 dd fe ff ff    	jne    801051c3 <trap+0x3b>
801052e6:	e9 f4 fe ff ff       	jmp    801051df <trap+0x57>
801052eb:	90                   	nop
    if(myproc()->killed)
801052ec:	e8 bb e1 ff ff       	call   801034ac <myproc>
801052f1:	8b 70 24             	mov    0x24(%eax),%esi
801052f4:	85 f6                	test   %esi,%esi
801052f6:	0f 85 b0 00 00 00    	jne    801053ac <trap+0x224>
    myproc()->tf = tf;
801052fc:	e8 ab e1 ff ff       	call   801034ac <myproc>
80105301:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105304:	e8 17 f1 ff ff       	call   80104420 <syscall>
    if(myproc()->killed)
80105309:	e8 9e e1 ff ff       	call   801034ac <myproc>
8010530e:	8b 48 24             	mov    0x24(%eax),%ecx
80105311:	85 c9                	test   %ecx,%ecx
80105313:	0f 84 03 ff ff ff    	je     8010521c <trap+0x94>
}
80105319:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010531c:	5b                   	pop    %ebx
8010531d:	5e                   	pop    %esi
8010531e:	5f                   	pop    %edi
8010531f:	5d                   	pop    %ebp
      exit();
80105320:	e9 57 e5 ff ff       	jmp    8010387c <exit>
80105325:	8d 76 00             	lea    0x0(%esi),%esi
    uartintr();
80105328:	e8 ef 01 00 00       	call   8010551c <uartintr>
    lapiceoi();
8010532d:	e8 66 d2 ff ff       	call   80102598 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105332:	e8 75 e1 ff ff       	call   801034ac <myproc>
80105337:	85 c0                	test   %eax,%eax
80105339:	0f 85 84 fe ff ff    	jne    801051c3 <trap+0x3b>
8010533f:	e9 9b fe ff ff       	jmp    801051df <trap+0x57>
    kbdintr();
80105344:	e8 3f d1 ff ff       	call   80102488 <kbdintr>
    lapiceoi();
80105349:	e8 4a d2 ff ff       	call   80102598 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010534e:	e8 59 e1 ff ff       	call   801034ac <myproc>
80105353:	85 c0                	test   %eax,%eax
80105355:	0f 85 68 fe ff ff    	jne    801051c3 <trap+0x3b>
8010535b:	e9 7f fe ff ff       	jmp    801051df <trap+0x57>
    if(cpuid() == 0){
80105360:	e8 13 e1 ff ff       	call   80103478 <cpuid>
80105365:	85 c0                	test   %eax,%eax
80105367:	0f 85 48 fe ff ff    	jne    801051b5 <trap+0x2d>
      acquire(&tickslock);
8010536d:	83 ec 0c             	sub    $0xc,%esp
80105370:	68 80 3c 11 80       	push   $0x80113c80
80105375:	e8 c6 ec ff ff       	call   80104040 <acquire>
      ticks++;
8010537a:	ff 05 60 3c 11 80    	incl   0x80113c60
      wakeup(&ticks);
80105380:	c7 04 24 60 3c 11 80 	movl   $0x80113c60,(%esp)
80105387:	e8 2c e8 ff ff       	call   80103bb8 <wakeup>
      release(&tickslock);
8010538c:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80105393:	e8 48 ec ff ff       	call   80103fe0 <release>
80105398:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010539b:	e9 15 fe ff ff       	jmp    801051b5 <trap+0x2d>
    exit();
801053a0:	e8 d7 e4 ff ff       	call   8010387c <exit>
801053a5:	e9 35 fe ff ff       	jmp    801051df <trap+0x57>
801053aa:	66 90                	xchg   %ax,%ax
      exit();
801053ac:	e8 cb e4 ff ff       	call   8010387c <exit>
801053b1:	e9 46 ff ff ff       	jmp    801052fc <trap+0x174>
801053b6:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801053b9:	e8 ba e0 ff ff       	call   80103478 <cpuid>
801053be:	83 ec 0c             	sub    $0xc,%esp
801053c1:	56                   	push   %esi
801053c2:	57                   	push   %edi
801053c3:	50                   	push   %eax
801053c4:	ff 73 30             	push   0x30(%ebx)
801053c7:	68 6c 70 10 80       	push   $0x8010706c
801053cc:	e8 4b b2 ff ff       	call   8010061c <cprintf>
      panic("trap");
801053d1:	83 c4 14             	add    $0x14,%esp
801053d4:	68 42 70 10 80       	push   $0x80107042
801053d9:	e8 5a af ff ff       	call   80100338 <panic>
801053de:	66 90                	xchg   %ax,%ax

801053e0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801053e0:	a1 c0 44 11 80       	mov    0x801144c0,%eax
801053e5:	85 c0                	test   %eax,%eax
801053e7:	74 17                	je     80105400 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801053e9:	ba fd 03 00 00       	mov    $0x3fd,%edx
801053ee:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801053ef:	a8 01                	test   $0x1,%al
801053f1:	74 0d                	je     80105400 <uartgetc+0x20>
801053f3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801053f8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801053f9:	0f b6 c0             	movzbl %al,%eax
801053fc:	c3                   	ret    
801053fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105400:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105405:	c3                   	ret    
80105406:	66 90                	xchg   %ax,%ax

80105408 <uartinit>:
{
80105408:	55                   	push   %ebp
80105409:	89 e5                	mov    %esp,%ebp
8010540b:	57                   	push   %edi
8010540c:	56                   	push   %esi
8010540d:	53                   	push   %ebx
8010540e:	83 ec 1c             	sub    $0x1c,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105411:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105416:	31 c0                	xor    %eax,%eax
80105418:	89 fa                	mov    %edi,%edx
8010541a:	ee                   	out    %al,(%dx)
8010541b:	bb fb 03 00 00       	mov    $0x3fb,%ebx
80105420:	b0 80                	mov    $0x80,%al
80105422:	89 da                	mov    %ebx,%edx
80105424:	ee                   	out    %al,(%dx)
80105425:	be f8 03 00 00       	mov    $0x3f8,%esi
8010542a:	b0 0c                	mov    $0xc,%al
8010542c:	89 f2                	mov    %esi,%edx
8010542e:	ee                   	out    %al,(%dx)
8010542f:	b9 f9 03 00 00       	mov    $0x3f9,%ecx
80105434:	31 c0                	xor    %eax,%eax
80105436:	89 ca                	mov    %ecx,%edx
80105438:	ee                   	out    %al,(%dx)
80105439:	b0 03                	mov    $0x3,%al
8010543b:	89 da                	mov    %ebx,%edx
8010543d:	ee                   	out    %al,(%dx)
8010543e:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105443:	31 c0                	xor    %eax,%eax
80105445:	ee                   	out    %al,(%dx)
80105446:	b0 01                	mov    $0x1,%al
80105448:	89 ca                	mov    %ecx,%edx
8010544a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010544b:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105450:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105451:	fe c0                	inc    %al
80105453:	74 77                	je     801054cc <uartinit+0xc4>
  uart = 1;
80105455:	c7 05 c0 44 11 80 01 	movl   $0x1,0x801144c0
8010545c:	00 00 00 
8010545f:	89 fa                	mov    %edi,%edx
80105461:	ec                   	in     (%dx),%al
80105462:	89 f2                	mov    %esi,%edx
80105464:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105465:	83 ec 08             	sub    $0x8,%esp
80105468:	6a 00                	push   $0x0
8010546a:	6a 04                	push   $0x4
8010546c:	e8 23 cd ff ff       	call   80102194 <ioapicenable>
80105471:	83 c4 10             	add    $0x10,%esp
80105474:	c6 45 e7 76          	movb   $0x76,-0x19(%ebp)
  for(p="xv6...\n"; *p; p++)
80105478:	bf 64 71 10 80       	mov    $0x80107164,%edi
8010547d:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
80105481:	be fd 03 00 00       	mov    $0x3fd,%esi
80105486:	66 90                	xchg   %ax,%ax
  if(!uart)
80105488:	a1 c0 44 11 80       	mov    0x801144c0,%eax
8010548d:	85 c0                	test   %eax,%eax
8010548f:	74 27                	je     801054b8 <uartinit+0xb0>
80105491:	bb 80 00 00 00       	mov    $0x80,%ebx
80105496:	eb 10                	jmp    801054a8 <uartinit+0xa0>
    microdelay(10);
80105498:	83 ec 0c             	sub    $0xc,%esp
8010549b:	6a 0a                	push   $0xa
8010549d:	e8 0e d1 ff ff       	call   801025b0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801054a2:	83 c4 10             	add    $0x10,%esp
801054a5:	4b                   	dec    %ebx
801054a6:	74 07                	je     801054af <uartinit+0xa7>
801054a8:	89 f2                	mov    %esi,%edx
801054aa:	ec                   	in     (%dx),%al
801054ab:	a8 20                	test   $0x20,%al
801054ad:	74 e9                	je     80105498 <uartinit+0x90>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801054af:	8a 45 e6             	mov    -0x1a(%ebp),%al
801054b2:	ba f8 03 00 00       	mov    $0x3f8,%edx
801054b7:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
801054b8:	47                   	inc    %edi
801054b9:	8a 45 e7             	mov    -0x19(%ebp),%al
801054bc:	84 c0                	test   %al,%al
801054be:	74 0c                	je     801054cc <uartinit+0xc4>
801054c0:	88 45 e6             	mov    %al,-0x1a(%ebp)
801054c3:	8a 47 01             	mov    0x1(%edi),%al
801054c6:	88 45 e7             	mov    %al,-0x19(%ebp)
801054c9:	eb bd                	jmp    80105488 <uartinit+0x80>
801054cb:	90                   	nop
}
801054cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054cf:	5b                   	pop    %ebx
801054d0:	5e                   	pop    %esi
801054d1:	5f                   	pop    %edi
801054d2:	5d                   	pop    %ebp
801054d3:	c3                   	ret    

801054d4 <uartputc>:
  if(!uart)
801054d4:	a1 c0 44 11 80       	mov    0x801144c0,%eax
801054d9:	85 c0                	test   %eax,%eax
801054db:	74 3b                	je     80105518 <uartputc+0x44>
{
801054dd:	55                   	push   %ebp
801054de:	89 e5                	mov    %esp,%ebp
801054e0:	56                   	push   %esi
801054e1:	53                   	push   %ebx
801054e2:	bb 80 00 00 00       	mov    $0x80,%ebx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801054e7:	be fd 03 00 00       	mov    $0x3fd,%esi
801054ec:	eb 12                	jmp    80105500 <uartputc+0x2c>
801054ee:	66 90                	xchg   %ax,%ax
    microdelay(10);
801054f0:	83 ec 0c             	sub    $0xc,%esp
801054f3:	6a 0a                	push   $0xa
801054f5:	e8 b6 d0 ff ff       	call   801025b0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801054fa:	83 c4 10             	add    $0x10,%esp
801054fd:	4b                   	dec    %ebx
801054fe:	74 07                	je     80105507 <uartputc+0x33>
80105500:	89 f2                	mov    %esi,%edx
80105502:	ec                   	in     (%dx),%al
80105503:	a8 20                	test   $0x20,%al
80105505:	74 e9                	je     801054f0 <uartputc+0x1c>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105507:	8b 45 08             	mov    0x8(%ebp),%eax
8010550a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010550f:	ee                   	out    %al,(%dx)
}
80105510:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105513:	5b                   	pop    %ebx
80105514:	5e                   	pop    %esi
80105515:	5d                   	pop    %ebp
80105516:	c3                   	ret    
80105517:	90                   	nop
80105518:	c3                   	ret    
80105519:	8d 76 00             	lea    0x0(%esi),%esi

8010551c <uartintr>:

void
uartintr(void)
{
8010551c:	55                   	push   %ebp
8010551d:	89 e5                	mov    %esp,%ebp
8010551f:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105522:	68 e0 53 10 80       	push   $0x801053e0
80105527:	e8 b8 b2 ff ff       	call   801007e4 <consoleintr>
}
8010552c:	83 c4 10             	add    $0x10,%esp
8010552f:	c9                   	leave  
80105530:	c3                   	ret    

80105531 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105531:	6a 00                	push   $0x0
  pushl $0
80105533:	6a 00                	push   $0x0
  jmp alltraps
80105535:	e9 9b fb ff ff       	jmp    801050d5 <alltraps>

8010553a <vector1>:
.globl vector1
vector1:
  pushl $0
8010553a:	6a 00                	push   $0x0
  pushl $1
8010553c:	6a 01                	push   $0x1
  jmp alltraps
8010553e:	e9 92 fb ff ff       	jmp    801050d5 <alltraps>

80105543 <vector2>:
.globl vector2
vector2:
  pushl $0
80105543:	6a 00                	push   $0x0
  pushl $2
80105545:	6a 02                	push   $0x2
  jmp alltraps
80105547:	e9 89 fb ff ff       	jmp    801050d5 <alltraps>

8010554c <vector3>:
.globl vector3
vector3:
  pushl $0
8010554c:	6a 00                	push   $0x0
  pushl $3
8010554e:	6a 03                	push   $0x3
  jmp alltraps
80105550:	e9 80 fb ff ff       	jmp    801050d5 <alltraps>

80105555 <vector4>:
.globl vector4
vector4:
  pushl $0
80105555:	6a 00                	push   $0x0
  pushl $4
80105557:	6a 04                	push   $0x4
  jmp alltraps
80105559:	e9 77 fb ff ff       	jmp    801050d5 <alltraps>

8010555e <vector5>:
.globl vector5
vector5:
  pushl $0
8010555e:	6a 00                	push   $0x0
  pushl $5
80105560:	6a 05                	push   $0x5
  jmp alltraps
80105562:	e9 6e fb ff ff       	jmp    801050d5 <alltraps>

80105567 <vector6>:
.globl vector6
vector6:
  pushl $0
80105567:	6a 00                	push   $0x0
  pushl $6
80105569:	6a 06                	push   $0x6
  jmp alltraps
8010556b:	e9 65 fb ff ff       	jmp    801050d5 <alltraps>

80105570 <vector7>:
.globl vector7
vector7:
  pushl $0
80105570:	6a 00                	push   $0x0
  pushl $7
80105572:	6a 07                	push   $0x7
  jmp alltraps
80105574:	e9 5c fb ff ff       	jmp    801050d5 <alltraps>

80105579 <vector8>:
.globl vector8
vector8:
  pushl $8
80105579:	6a 08                	push   $0x8
  jmp alltraps
8010557b:	e9 55 fb ff ff       	jmp    801050d5 <alltraps>

80105580 <vector9>:
.globl vector9
vector9:
  pushl $0
80105580:	6a 00                	push   $0x0
  pushl $9
80105582:	6a 09                	push   $0x9
  jmp alltraps
80105584:	e9 4c fb ff ff       	jmp    801050d5 <alltraps>

80105589 <vector10>:
.globl vector10
vector10:
  pushl $10
80105589:	6a 0a                	push   $0xa
  jmp alltraps
8010558b:	e9 45 fb ff ff       	jmp    801050d5 <alltraps>

80105590 <vector11>:
.globl vector11
vector11:
  pushl $11
80105590:	6a 0b                	push   $0xb
  jmp alltraps
80105592:	e9 3e fb ff ff       	jmp    801050d5 <alltraps>

80105597 <vector12>:
.globl vector12
vector12:
  pushl $12
80105597:	6a 0c                	push   $0xc
  jmp alltraps
80105599:	e9 37 fb ff ff       	jmp    801050d5 <alltraps>

8010559e <vector13>:
.globl vector13
vector13:
  pushl $13
8010559e:	6a 0d                	push   $0xd
  jmp alltraps
801055a0:	e9 30 fb ff ff       	jmp    801050d5 <alltraps>

801055a5 <vector14>:
.globl vector14
vector14:
  pushl $14
801055a5:	6a 0e                	push   $0xe
  jmp alltraps
801055a7:	e9 29 fb ff ff       	jmp    801050d5 <alltraps>

801055ac <vector15>:
.globl vector15
vector15:
  pushl $0
801055ac:	6a 00                	push   $0x0
  pushl $15
801055ae:	6a 0f                	push   $0xf
  jmp alltraps
801055b0:	e9 20 fb ff ff       	jmp    801050d5 <alltraps>

801055b5 <vector16>:
.globl vector16
vector16:
  pushl $0
801055b5:	6a 00                	push   $0x0
  pushl $16
801055b7:	6a 10                	push   $0x10
  jmp alltraps
801055b9:	e9 17 fb ff ff       	jmp    801050d5 <alltraps>

801055be <vector17>:
.globl vector17
vector17:
  pushl $17
801055be:	6a 11                	push   $0x11
  jmp alltraps
801055c0:	e9 10 fb ff ff       	jmp    801050d5 <alltraps>

801055c5 <vector18>:
.globl vector18
vector18:
  pushl $0
801055c5:	6a 00                	push   $0x0
  pushl $18
801055c7:	6a 12                	push   $0x12
  jmp alltraps
801055c9:	e9 07 fb ff ff       	jmp    801050d5 <alltraps>

801055ce <vector19>:
.globl vector19
vector19:
  pushl $0
801055ce:	6a 00                	push   $0x0
  pushl $19
801055d0:	6a 13                	push   $0x13
  jmp alltraps
801055d2:	e9 fe fa ff ff       	jmp    801050d5 <alltraps>

801055d7 <vector20>:
.globl vector20
vector20:
  pushl $0
801055d7:	6a 00                	push   $0x0
  pushl $20
801055d9:	6a 14                	push   $0x14
  jmp alltraps
801055db:	e9 f5 fa ff ff       	jmp    801050d5 <alltraps>

801055e0 <vector21>:
.globl vector21
vector21:
  pushl $0
801055e0:	6a 00                	push   $0x0
  pushl $21
801055e2:	6a 15                	push   $0x15
  jmp alltraps
801055e4:	e9 ec fa ff ff       	jmp    801050d5 <alltraps>

801055e9 <vector22>:
.globl vector22
vector22:
  pushl $0
801055e9:	6a 00                	push   $0x0
  pushl $22
801055eb:	6a 16                	push   $0x16
  jmp alltraps
801055ed:	e9 e3 fa ff ff       	jmp    801050d5 <alltraps>

801055f2 <vector23>:
.globl vector23
vector23:
  pushl $0
801055f2:	6a 00                	push   $0x0
  pushl $23
801055f4:	6a 17                	push   $0x17
  jmp alltraps
801055f6:	e9 da fa ff ff       	jmp    801050d5 <alltraps>

801055fb <vector24>:
.globl vector24
vector24:
  pushl $0
801055fb:	6a 00                	push   $0x0
  pushl $24
801055fd:	6a 18                	push   $0x18
  jmp alltraps
801055ff:	e9 d1 fa ff ff       	jmp    801050d5 <alltraps>

80105604 <vector25>:
.globl vector25
vector25:
  pushl $0
80105604:	6a 00                	push   $0x0
  pushl $25
80105606:	6a 19                	push   $0x19
  jmp alltraps
80105608:	e9 c8 fa ff ff       	jmp    801050d5 <alltraps>

8010560d <vector26>:
.globl vector26
vector26:
  pushl $0
8010560d:	6a 00                	push   $0x0
  pushl $26
8010560f:	6a 1a                	push   $0x1a
  jmp alltraps
80105611:	e9 bf fa ff ff       	jmp    801050d5 <alltraps>

80105616 <vector27>:
.globl vector27
vector27:
  pushl $0
80105616:	6a 00                	push   $0x0
  pushl $27
80105618:	6a 1b                	push   $0x1b
  jmp alltraps
8010561a:	e9 b6 fa ff ff       	jmp    801050d5 <alltraps>

8010561f <vector28>:
.globl vector28
vector28:
  pushl $0
8010561f:	6a 00                	push   $0x0
  pushl $28
80105621:	6a 1c                	push   $0x1c
  jmp alltraps
80105623:	e9 ad fa ff ff       	jmp    801050d5 <alltraps>

80105628 <vector29>:
.globl vector29
vector29:
  pushl $0
80105628:	6a 00                	push   $0x0
  pushl $29
8010562a:	6a 1d                	push   $0x1d
  jmp alltraps
8010562c:	e9 a4 fa ff ff       	jmp    801050d5 <alltraps>

80105631 <vector30>:
.globl vector30
vector30:
  pushl $0
80105631:	6a 00                	push   $0x0
  pushl $30
80105633:	6a 1e                	push   $0x1e
  jmp alltraps
80105635:	e9 9b fa ff ff       	jmp    801050d5 <alltraps>

8010563a <vector31>:
.globl vector31
vector31:
  pushl $0
8010563a:	6a 00                	push   $0x0
  pushl $31
8010563c:	6a 1f                	push   $0x1f
  jmp alltraps
8010563e:	e9 92 fa ff ff       	jmp    801050d5 <alltraps>

80105643 <vector32>:
.globl vector32
vector32:
  pushl $0
80105643:	6a 00                	push   $0x0
  pushl $32
80105645:	6a 20                	push   $0x20
  jmp alltraps
80105647:	e9 89 fa ff ff       	jmp    801050d5 <alltraps>

8010564c <vector33>:
.globl vector33
vector33:
  pushl $0
8010564c:	6a 00                	push   $0x0
  pushl $33
8010564e:	6a 21                	push   $0x21
  jmp alltraps
80105650:	e9 80 fa ff ff       	jmp    801050d5 <alltraps>

80105655 <vector34>:
.globl vector34
vector34:
  pushl $0
80105655:	6a 00                	push   $0x0
  pushl $34
80105657:	6a 22                	push   $0x22
  jmp alltraps
80105659:	e9 77 fa ff ff       	jmp    801050d5 <alltraps>

8010565e <vector35>:
.globl vector35
vector35:
  pushl $0
8010565e:	6a 00                	push   $0x0
  pushl $35
80105660:	6a 23                	push   $0x23
  jmp alltraps
80105662:	e9 6e fa ff ff       	jmp    801050d5 <alltraps>

80105667 <vector36>:
.globl vector36
vector36:
  pushl $0
80105667:	6a 00                	push   $0x0
  pushl $36
80105669:	6a 24                	push   $0x24
  jmp alltraps
8010566b:	e9 65 fa ff ff       	jmp    801050d5 <alltraps>

80105670 <vector37>:
.globl vector37
vector37:
  pushl $0
80105670:	6a 00                	push   $0x0
  pushl $37
80105672:	6a 25                	push   $0x25
  jmp alltraps
80105674:	e9 5c fa ff ff       	jmp    801050d5 <alltraps>

80105679 <vector38>:
.globl vector38
vector38:
  pushl $0
80105679:	6a 00                	push   $0x0
  pushl $38
8010567b:	6a 26                	push   $0x26
  jmp alltraps
8010567d:	e9 53 fa ff ff       	jmp    801050d5 <alltraps>

80105682 <vector39>:
.globl vector39
vector39:
  pushl $0
80105682:	6a 00                	push   $0x0
  pushl $39
80105684:	6a 27                	push   $0x27
  jmp alltraps
80105686:	e9 4a fa ff ff       	jmp    801050d5 <alltraps>

8010568b <vector40>:
.globl vector40
vector40:
  pushl $0
8010568b:	6a 00                	push   $0x0
  pushl $40
8010568d:	6a 28                	push   $0x28
  jmp alltraps
8010568f:	e9 41 fa ff ff       	jmp    801050d5 <alltraps>

80105694 <vector41>:
.globl vector41
vector41:
  pushl $0
80105694:	6a 00                	push   $0x0
  pushl $41
80105696:	6a 29                	push   $0x29
  jmp alltraps
80105698:	e9 38 fa ff ff       	jmp    801050d5 <alltraps>

8010569d <vector42>:
.globl vector42
vector42:
  pushl $0
8010569d:	6a 00                	push   $0x0
  pushl $42
8010569f:	6a 2a                	push   $0x2a
  jmp alltraps
801056a1:	e9 2f fa ff ff       	jmp    801050d5 <alltraps>

801056a6 <vector43>:
.globl vector43
vector43:
  pushl $0
801056a6:	6a 00                	push   $0x0
  pushl $43
801056a8:	6a 2b                	push   $0x2b
  jmp alltraps
801056aa:	e9 26 fa ff ff       	jmp    801050d5 <alltraps>

801056af <vector44>:
.globl vector44
vector44:
  pushl $0
801056af:	6a 00                	push   $0x0
  pushl $44
801056b1:	6a 2c                	push   $0x2c
  jmp alltraps
801056b3:	e9 1d fa ff ff       	jmp    801050d5 <alltraps>

801056b8 <vector45>:
.globl vector45
vector45:
  pushl $0
801056b8:	6a 00                	push   $0x0
  pushl $45
801056ba:	6a 2d                	push   $0x2d
  jmp alltraps
801056bc:	e9 14 fa ff ff       	jmp    801050d5 <alltraps>

801056c1 <vector46>:
.globl vector46
vector46:
  pushl $0
801056c1:	6a 00                	push   $0x0
  pushl $46
801056c3:	6a 2e                	push   $0x2e
  jmp alltraps
801056c5:	e9 0b fa ff ff       	jmp    801050d5 <alltraps>

801056ca <vector47>:
.globl vector47
vector47:
  pushl $0
801056ca:	6a 00                	push   $0x0
  pushl $47
801056cc:	6a 2f                	push   $0x2f
  jmp alltraps
801056ce:	e9 02 fa ff ff       	jmp    801050d5 <alltraps>

801056d3 <vector48>:
.globl vector48
vector48:
  pushl $0
801056d3:	6a 00                	push   $0x0
  pushl $48
801056d5:	6a 30                	push   $0x30
  jmp alltraps
801056d7:	e9 f9 f9 ff ff       	jmp    801050d5 <alltraps>

801056dc <vector49>:
.globl vector49
vector49:
  pushl $0
801056dc:	6a 00                	push   $0x0
  pushl $49
801056de:	6a 31                	push   $0x31
  jmp alltraps
801056e0:	e9 f0 f9 ff ff       	jmp    801050d5 <alltraps>

801056e5 <vector50>:
.globl vector50
vector50:
  pushl $0
801056e5:	6a 00                	push   $0x0
  pushl $50
801056e7:	6a 32                	push   $0x32
  jmp alltraps
801056e9:	e9 e7 f9 ff ff       	jmp    801050d5 <alltraps>

801056ee <vector51>:
.globl vector51
vector51:
  pushl $0
801056ee:	6a 00                	push   $0x0
  pushl $51
801056f0:	6a 33                	push   $0x33
  jmp alltraps
801056f2:	e9 de f9 ff ff       	jmp    801050d5 <alltraps>

801056f7 <vector52>:
.globl vector52
vector52:
  pushl $0
801056f7:	6a 00                	push   $0x0
  pushl $52
801056f9:	6a 34                	push   $0x34
  jmp alltraps
801056fb:	e9 d5 f9 ff ff       	jmp    801050d5 <alltraps>

80105700 <vector53>:
.globl vector53
vector53:
  pushl $0
80105700:	6a 00                	push   $0x0
  pushl $53
80105702:	6a 35                	push   $0x35
  jmp alltraps
80105704:	e9 cc f9 ff ff       	jmp    801050d5 <alltraps>

80105709 <vector54>:
.globl vector54
vector54:
  pushl $0
80105709:	6a 00                	push   $0x0
  pushl $54
8010570b:	6a 36                	push   $0x36
  jmp alltraps
8010570d:	e9 c3 f9 ff ff       	jmp    801050d5 <alltraps>

80105712 <vector55>:
.globl vector55
vector55:
  pushl $0
80105712:	6a 00                	push   $0x0
  pushl $55
80105714:	6a 37                	push   $0x37
  jmp alltraps
80105716:	e9 ba f9 ff ff       	jmp    801050d5 <alltraps>

8010571b <vector56>:
.globl vector56
vector56:
  pushl $0
8010571b:	6a 00                	push   $0x0
  pushl $56
8010571d:	6a 38                	push   $0x38
  jmp alltraps
8010571f:	e9 b1 f9 ff ff       	jmp    801050d5 <alltraps>

80105724 <vector57>:
.globl vector57
vector57:
  pushl $0
80105724:	6a 00                	push   $0x0
  pushl $57
80105726:	6a 39                	push   $0x39
  jmp alltraps
80105728:	e9 a8 f9 ff ff       	jmp    801050d5 <alltraps>

8010572d <vector58>:
.globl vector58
vector58:
  pushl $0
8010572d:	6a 00                	push   $0x0
  pushl $58
8010572f:	6a 3a                	push   $0x3a
  jmp alltraps
80105731:	e9 9f f9 ff ff       	jmp    801050d5 <alltraps>

80105736 <vector59>:
.globl vector59
vector59:
  pushl $0
80105736:	6a 00                	push   $0x0
  pushl $59
80105738:	6a 3b                	push   $0x3b
  jmp alltraps
8010573a:	e9 96 f9 ff ff       	jmp    801050d5 <alltraps>

8010573f <vector60>:
.globl vector60
vector60:
  pushl $0
8010573f:	6a 00                	push   $0x0
  pushl $60
80105741:	6a 3c                	push   $0x3c
  jmp alltraps
80105743:	e9 8d f9 ff ff       	jmp    801050d5 <alltraps>

80105748 <vector61>:
.globl vector61
vector61:
  pushl $0
80105748:	6a 00                	push   $0x0
  pushl $61
8010574a:	6a 3d                	push   $0x3d
  jmp alltraps
8010574c:	e9 84 f9 ff ff       	jmp    801050d5 <alltraps>

80105751 <vector62>:
.globl vector62
vector62:
  pushl $0
80105751:	6a 00                	push   $0x0
  pushl $62
80105753:	6a 3e                	push   $0x3e
  jmp alltraps
80105755:	e9 7b f9 ff ff       	jmp    801050d5 <alltraps>

8010575a <vector63>:
.globl vector63
vector63:
  pushl $0
8010575a:	6a 00                	push   $0x0
  pushl $63
8010575c:	6a 3f                	push   $0x3f
  jmp alltraps
8010575e:	e9 72 f9 ff ff       	jmp    801050d5 <alltraps>

80105763 <vector64>:
.globl vector64
vector64:
  pushl $0
80105763:	6a 00                	push   $0x0
  pushl $64
80105765:	6a 40                	push   $0x40
  jmp alltraps
80105767:	e9 69 f9 ff ff       	jmp    801050d5 <alltraps>

8010576c <vector65>:
.globl vector65
vector65:
  pushl $0
8010576c:	6a 00                	push   $0x0
  pushl $65
8010576e:	6a 41                	push   $0x41
  jmp alltraps
80105770:	e9 60 f9 ff ff       	jmp    801050d5 <alltraps>

80105775 <vector66>:
.globl vector66
vector66:
  pushl $0
80105775:	6a 00                	push   $0x0
  pushl $66
80105777:	6a 42                	push   $0x42
  jmp alltraps
80105779:	e9 57 f9 ff ff       	jmp    801050d5 <alltraps>

8010577e <vector67>:
.globl vector67
vector67:
  pushl $0
8010577e:	6a 00                	push   $0x0
  pushl $67
80105780:	6a 43                	push   $0x43
  jmp alltraps
80105782:	e9 4e f9 ff ff       	jmp    801050d5 <alltraps>

80105787 <vector68>:
.globl vector68
vector68:
  pushl $0
80105787:	6a 00                	push   $0x0
  pushl $68
80105789:	6a 44                	push   $0x44
  jmp alltraps
8010578b:	e9 45 f9 ff ff       	jmp    801050d5 <alltraps>

80105790 <vector69>:
.globl vector69
vector69:
  pushl $0
80105790:	6a 00                	push   $0x0
  pushl $69
80105792:	6a 45                	push   $0x45
  jmp alltraps
80105794:	e9 3c f9 ff ff       	jmp    801050d5 <alltraps>

80105799 <vector70>:
.globl vector70
vector70:
  pushl $0
80105799:	6a 00                	push   $0x0
  pushl $70
8010579b:	6a 46                	push   $0x46
  jmp alltraps
8010579d:	e9 33 f9 ff ff       	jmp    801050d5 <alltraps>

801057a2 <vector71>:
.globl vector71
vector71:
  pushl $0
801057a2:	6a 00                	push   $0x0
  pushl $71
801057a4:	6a 47                	push   $0x47
  jmp alltraps
801057a6:	e9 2a f9 ff ff       	jmp    801050d5 <alltraps>

801057ab <vector72>:
.globl vector72
vector72:
  pushl $0
801057ab:	6a 00                	push   $0x0
  pushl $72
801057ad:	6a 48                	push   $0x48
  jmp alltraps
801057af:	e9 21 f9 ff ff       	jmp    801050d5 <alltraps>

801057b4 <vector73>:
.globl vector73
vector73:
  pushl $0
801057b4:	6a 00                	push   $0x0
  pushl $73
801057b6:	6a 49                	push   $0x49
  jmp alltraps
801057b8:	e9 18 f9 ff ff       	jmp    801050d5 <alltraps>

801057bd <vector74>:
.globl vector74
vector74:
  pushl $0
801057bd:	6a 00                	push   $0x0
  pushl $74
801057bf:	6a 4a                	push   $0x4a
  jmp alltraps
801057c1:	e9 0f f9 ff ff       	jmp    801050d5 <alltraps>

801057c6 <vector75>:
.globl vector75
vector75:
  pushl $0
801057c6:	6a 00                	push   $0x0
  pushl $75
801057c8:	6a 4b                	push   $0x4b
  jmp alltraps
801057ca:	e9 06 f9 ff ff       	jmp    801050d5 <alltraps>

801057cf <vector76>:
.globl vector76
vector76:
  pushl $0
801057cf:	6a 00                	push   $0x0
  pushl $76
801057d1:	6a 4c                	push   $0x4c
  jmp alltraps
801057d3:	e9 fd f8 ff ff       	jmp    801050d5 <alltraps>

801057d8 <vector77>:
.globl vector77
vector77:
  pushl $0
801057d8:	6a 00                	push   $0x0
  pushl $77
801057da:	6a 4d                	push   $0x4d
  jmp alltraps
801057dc:	e9 f4 f8 ff ff       	jmp    801050d5 <alltraps>

801057e1 <vector78>:
.globl vector78
vector78:
  pushl $0
801057e1:	6a 00                	push   $0x0
  pushl $78
801057e3:	6a 4e                	push   $0x4e
  jmp alltraps
801057e5:	e9 eb f8 ff ff       	jmp    801050d5 <alltraps>

801057ea <vector79>:
.globl vector79
vector79:
  pushl $0
801057ea:	6a 00                	push   $0x0
  pushl $79
801057ec:	6a 4f                	push   $0x4f
  jmp alltraps
801057ee:	e9 e2 f8 ff ff       	jmp    801050d5 <alltraps>

801057f3 <vector80>:
.globl vector80
vector80:
  pushl $0
801057f3:	6a 00                	push   $0x0
  pushl $80
801057f5:	6a 50                	push   $0x50
  jmp alltraps
801057f7:	e9 d9 f8 ff ff       	jmp    801050d5 <alltraps>

801057fc <vector81>:
.globl vector81
vector81:
  pushl $0
801057fc:	6a 00                	push   $0x0
  pushl $81
801057fe:	6a 51                	push   $0x51
  jmp alltraps
80105800:	e9 d0 f8 ff ff       	jmp    801050d5 <alltraps>

80105805 <vector82>:
.globl vector82
vector82:
  pushl $0
80105805:	6a 00                	push   $0x0
  pushl $82
80105807:	6a 52                	push   $0x52
  jmp alltraps
80105809:	e9 c7 f8 ff ff       	jmp    801050d5 <alltraps>

8010580e <vector83>:
.globl vector83
vector83:
  pushl $0
8010580e:	6a 00                	push   $0x0
  pushl $83
80105810:	6a 53                	push   $0x53
  jmp alltraps
80105812:	e9 be f8 ff ff       	jmp    801050d5 <alltraps>

80105817 <vector84>:
.globl vector84
vector84:
  pushl $0
80105817:	6a 00                	push   $0x0
  pushl $84
80105819:	6a 54                	push   $0x54
  jmp alltraps
8010581b:	e9 b5 f8 ff ff       	jmp    801050d5 <alltraps>

80105820 <vector85>:
.globl vector85
vector85:
  pushl $0
80105820:	6a 00                	push   $0x0
  pushl $85
80105822:	6a 55                	push   $0x55
  jmp alltraps
80105824:	e9 ac f8 ff ff       	jmp    801050d5 <alltraps>

80105829 <vector86>:
.globl vector86
vector86:
  pushl $0
80105829:	6a 00                	push   $0x0
  pushl $86
8010582b:	6a 56                	push   $0x56
  jmp alltraps
8010582d:	e9 a3 f8 ff ff       	jmp    801050d5 <alltraps>

80105832 <vector87>:
.globl vector87
vector87:
  pushl $0
80105832:	6a 00                	push   $0x0
  pushl $87
80105834:	6a 57                	push   $0x57
  jmp alltraps
80105836:	e9 9a f8 ff ff       	jmp    801050d5 <alltraps>

8010583b <vector88>:
.globl vector88
vector88:
  pushl $0
8010583b:	6a 00                	push   $0x0
  pushl $88
8010583d:	6a 58                	push   $0x58
  jmp alltraps
8010583f:	e9 91 f8 ff ff       	jmp    801050d5 <alltraps>

80105844 <vector89>:
.globl vector89
vector89:
  pushl $0
80105844:	6a 00                	push   $0x0
  pushl $89
80105846:	6a 59                	push   $0x59
  jmp alltraps
80105848:	e9 88 f8 ff ff       	jmp    801050d5 <alltraps>

8010584d <vector90>:
.globl vector90
vector90:
  pushl $0
8010584d:	6a 00                	push   $0x0
  pushl $90
8010584f:	6a 5a                	push   $0x5a
  jmp alltraps
80105851:	e9 7f f8 ff ff       	jmp    801050d5 <alltraps>

80105856 <vector91>:
.globl vector91
vector91:
  pushl $0
80105856:	6a 00                	push   $0x0
  pushl $91
80105858:	6a 5b                	push   $0x5b
  jmp alltraps
8010585a:	e9 76 f8 ff ff       	jmp    801050d5 <alltraps>

8010585f <vector92>:
.globl vector92
vector92:
  pushl $0
8010585f:	6a 00                	push   $0x0
  pushl $92
80105861:	6a 5c                	push   $0x5c
  jmp alltraps
80105863:	e9 6d f8 ff ff       	jmp    801050d5 <alltraps>

80105868 <vector93>:
.globl vector93
vector93:
  pushl $0
80105868:	6a 00                	push   $0x0
  pushl $93
8010586a:	6a 5d                	push   $0x5d
  jmp alltraps
8010586c:	e9 64 f8 ff ff       	jmp    801050d5 <alltraps>

80105871 <vector94>:
.globl vector94
vector94:
  pushl $0
80105871:	6a 00                	push   $0x0
  pushl $94
80105873:	6a 5e                	push   $0x5e
  jmp alltraps
80105875:	e9 5b f8 ff ff       	jmp    801050d5 <alltraps>

8010587a <vector95>:
.globl vector95
vector95:
  pushl $0
8010587a:	6a 00                	push   $0x0
  pushl $95
8010587c:	6a 5f                	push   $0x5f
  jmp alltraps
8010587e:	e9 52 f8 ff ff       	jmp    801050d5 <alltraps>

80105883 <vector96>:
.globl vector96
vector96:
  pushl $0
80105883:	6a 00                	push   $0x0
  pushl $96
80105885:	6a 60                	push   $0x60
  jmp alltraps
80105887:	e9 49 f8 ff ff       	jmp    801050d5 <alltraps>

8010588c <vector97>:
.globl vector97
vector97:
  pushl $0
8010588c:	6a 00                	push   $0x0
  pushl $97
8010588e:	6a 61                	push   $0x61
  jmp alltraps
80105890:	e9 40 f8 ff ff       	jmp    801050d5 <alltraps>

80105895 <vector98>:
.globl vector98
vector98:
  pushl $0
80105895:	6a 00                	push   $0x0
  pushl $98
80105897:	6a 62                	push   $0x62
  jmp alltraps
80105899:	e9 37 f8 ff ff       	jmp    801050d5 <alltraps>

8010589e <vector99>:
.globl vector99
vector99:
  pushl $0
8010589e:	6a 00                	push   $0x0
  pushl $99
801058a0:	6a 63                	push   $0x63
  jmp alltraps
801058a2:	e9 2e f8 ff ff       	jmp    801050d5 <alltraps>

801058a7 <vector100>:
.globl vector100
vector100:
  pushl $0
801058a7:	6a 00                	push   $0x0
  pushl $100
801058a9:	6a 64                	push   $0x64
  jmp alltraps
801058ab:	e9 25 f8 ff ff       	jmp    801050d5 <alltraps>

801058b0 <vector101>:
.globl vector101
vector101:
  pushl $0
801058b0:	6a 00                	push   $0x0
  pushl $101
801058b2:	6a 65                	push   $0x65
  jmp alltraps
801058b4:	e9 1c f8 ff ff       	jmp    801050d5 <alltraps>

801058b9 <vector102>:
.globl vector102
vector102:
  pushl $0
801058b9:	6a 00                	push   $0x0
  pushl $102
801058bb:	6a 66                	push   $0x66
  jmp alltraps
801058bd:	e9 13 f8 ff ff       	jmp    801050d5 <alltraps>

801058c2 <vector103>:
.globl vector103
vector103:
  pushl $0
801058c2:	6a 00                	push   $0x0
  pushl $103
801058c4:	6a 67                	push   $0x67
  jmp alltraps
801058c6:	e9 0a f8 ff ff       	jmp    801050d5 <alltraps>

801058cb <vector104>:
.globl vector104
vector104:
  pushl $0
801058cb:	6a 00                	push   $0x0
  pushl $104
801058cd:	6a 68                	push   $0x68
  jmp alltraps
801058cf:	e9 01 f8 ff ff       	jmp    801050d5 <alltraps>

801058d4 <vector105>:
.globl vector105
vector105:
  pushl $0
801058d4:	6a 00                	push   $0x0
  pushl $105
801058d6:	6a 69                	push   $0x69
  jmp alltraps
801058d8:	e9 f8 f7 ff ff       	jmp    801050d5 <alltraps>

801058dd <vector106>:
.globl vector106
vector106:
  pushl $0
801058dd:	6a 00                	push   $0x0
  pushl $106
801058df:	6a 6a                	push   $0x6a
  jmp alltraps
801058e1:	e9 ef f7 ff ff       	jmp    801050d5 <alltraps>

801058e6 <vector107>:
.globl vector107
vector107:
  pushl $0
801058e6:	6a 00                	push   $0x0
  pushl $107
801058e8:	6a 6b                	push   $0x6b
  jmp alltraps
801058ea:	e9 e6 f7 ff ff       	jmp    801050d5 <alltraps>

801058ef <vector108>:
.globl vector108
vector108:
  pushl $0
801058ef:	6a 00                	push   $0x0
  pushl $108
801058f1:	6a 6c                	push   $0x6c
  jmp alltraps
801058f3:	e9 dd f7 ff ff       	jmp    801050d5 <alltraps>

801058f8 <vector109>:
.globl vector109
vector109:
  pushl $0
801058f8:	6a 00                	push   $0x0
  pushl $109
801058fa:	6a 6d                	push   $0x6d
  jmp alltraps
801058fc:	e9 d4 f7 ff ff       	jmp    801050d5 <alltraps>

80105901 <vector110>:
.globl vector110
vector110:
  pushl $0
80105901:	6a 00                	push   $0x0
  pushl $110
80105903:	6a 6e                	push   $0x6e
  jmp alltraps
80105905:	e9 cb f7 ff ff       	jmp    801050d5 <alltraps>

8010590a <vector111>:
.globl vector111
vector111:
  pushl $0
8010590a:	6a 00                	push   $0x0
  pushl $111
8010590c:	6a 6f                	push   $0x6f
  jmp alltraps
8010590e:	e9 c2 f7 ff ff       	jmp    801050d5 <alltraps>

80105913 <vector112>:
.globl vector112
vector112:
  pushl $0
80105913:	6a 00                	push   $0x0
  pushl $112
80105915:	6a 70                	push   $0x70
  jmp alltraps
80105917:	e9 b9 f7 ff ff       	jmp    801050d5 <alltraps>

8010591c <vector113>:
.globl vector113
vector113:
  pushl $0
8010591c:	6a 00                	push   $0x0
  pushl $113
8010591e:	6a 71                	push   $0x71
  jmp alltraps
80105920:	e9 b0 f7 ff ff       	jmp    801050d5 <alltraps>

80105925 <vector114>:
.globl vector114
vector114:
  pushl $0
80105925:	6a 00                	push   $0x0
  pushl $114
80105927:	6a 72                	push   $0x72
  jmp alltraps
80105929:	e9 a7 f7 ff ff       	jmp    801050d5 <alltraps>

8010592e <vector115>:
.globl vector115
vector115:
  pushl $0
8010592e:	6a 00                	push   $0x0
  pushl $115
80105930:	6a 73                	push   $0x73
  jmp alltraps
80105932:	e9 9e f7 ff ff       	jmp    801050d5 <alltraps>

80105937 <vector116>:
.globl vector116
vector116:
  pushl $0
80105937:	6a 00                	push   $0x0
  pushl $116
80105939:	6a 74                	push   $0x74
  jmp alltraps
8010593b:	e9 95 f7 ff ff       	jmp    801050d5 <alltraps>

80105940 <vector117>:
.globl vector117
vector117:
  pushl $0
80105940:	6a 00                	push   $0x0
  pushl $117
80105942:	6a 75                	push   $0x75
  jmp alltraps
80105944:	e9 8c f7 ff ff       	jmp    801050d5 <alltraps>

80105949 <vector118>:
.globl vector118
vector118:
  pushl $0
80105949:	6a 00                	push   $0x0
  pushl $118
8010594b:	6a 76                	push   $0x76
  jmp alltraps
8010594d:	e9 83 f7 ff ff       	jmp    801050d5 <alltraps>

80105952 <vector119>:
.globl vector119
vector119:
  pushl $0
80105952:	6a 00                	push   $0x0
  pushl $119
80105954:	6a 77                	push   $0x77
  jmp alltraps
80105956:	e9 7a f7 ff ff       	jmp    801050d5 <alltraps>

8010595b <vector120>:
.globl vector120
vector120:
  pushl $0
8010595b:	6a 00                	push   $0x0
  pushl $120
8010595d:	6a 78                	push   $0x78
  jmp alltraps
8010595f:	e9 71 f7 ff ff       	jmp    801050d5 <alltraps>

80105964 <vector121>:
.globl vector121
vector121:
  pushl $0
80105964:	6a 00                	push   $0x0
  pushl $121
80105966:	6a 79                	push   $0x79
  jmp alltraps
80105968:	e9 68 f7 ff ff       	jmp    801050d5 <alltraps>

8010596d <vector122>:
.globl vector122
vector122:
  pushl $0
8010596d:	6a 00                	push   $0x0
  pushl $122
8010596f:	6a 7a                	push   $0x7a
  jmp alltraps
80105971:	e9 5f f7 ff ff       	jmp    801050d5 <alltraps>

80105976 <vector123>:
.globl vector123
vector123:
  pushl $0
80105976:	6a 00                	push   $0x0
  pushl $123
80105978:	6a 7b                	push   $0x7b
  jmp alltraps
8010597a:	e9 56 f7 ff ff       	jmp    801050d5 <alltraps>

8010597f <vector124>:
.globl vector124
vector124:
  pushl $0
8010597f:	6a 00                	push   $0x0
  pushl $124
80105981:	6a 7c                	push   $0x7c
  jmp alltraps
80105983:	e9 4d f7 ff ff       	jmp    801050d5 <alltraps>

80105988 <vector125>:
.globl vector125
vector125:
  pushl $0
80105988:	6a 00                	push   $0x0
  pushl $125
8010598a:	6a 7d                	push   $0x7d
  jmp alltraps
8010598c:	e9 44 f7 ff ff       	jmp    801050d5 <alltraps>

80105991 <vector126>:
.globl vector126
vector126:
  pushl $0
80105991:	6a 00                	push   $0x0
  pushl $126
80105993:	6a 7e                	push   $0x7e
  jmp alltraps
80105995:	e9 3b f7 ff ff       	jmp    801050d5 <alltraps>

8010599a <vector127>:
.globl vector127
vector127:
  pushl $0
8010599a:	6a 00                	push   $0x0
  pushl $127
8010599c:	6a 7f                	push   $0x7f
  jmp alltraps
8010599e:	e9 32 f7 ff ff       	jmp    801050d5 <alltraps>

801059a3 <vector128>:
.globl vector128
vector128:
  pushl $0
801059a3:	6a 00                	push   $0x0
  pushl $128
801059a5:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801059aa:	e9 26 f7 ff ff       	jmp    801050d5 <alltraps>

801059af <vector129>:
.globl vector129
vector129:
  pushl $0
801059af:	6a 00                	push   $0x0
  pushl $129
801059b1:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801059b6:	e9 1a f7 ff ff       	jmp    801050d5 <alltraps>

801059bb <vector130>:
.globl vector130
vector130:
  pushl $0
801059bb:	6a 00                	push   $0x0
  pushl $130
801059bd:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801059c2:	e9 0e f7 ff ff       	jmp    801050d5 <alltraps>

801059c7 <vector131>:
.globl vector131
vector131:
  pushl $0
801059c7:	6a 00                	push   $0x0
  pushl $131
801059c9:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801059ce:	e9 02 f7 ff ff       	jmp    801050d5 <alltraps>

801059d3 <vector132>:
.globl vector132
vector132:
  pushl $0
801059d3:	6a 00                	push   $0x0
  pushl $132
801059d5:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801059da:	e9 f6 f6 ff ff       	jmp    801050d5 <alltraps>

801059df <vector133>:
.globl vector133
vector133:
  pushl $0
801059df:	6a 00                	push   $0x0
  pushl $133
801059e1:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801059e6:	e9 ea f6 ff ff       	jmp    801050d5 <alltraps>

801059eb <vector134>:
.globl vector134
vector134:
  pushl $0
801059eb:	6a 00                	push   $0x0
  pushl $134
801059ed:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801059f2:	e9 de f6 ff ff       	jmp    801050d5 <alltraps>

801059f7 <vector135>:
.globl vector135
vector135:
  pushl $0
801059f7:	6a 00                	push   $0x0
  pushl $135
801059f9:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801059fe:	e9 d2 f6 ff ff       	jmp    801050d5 <alltraps>

80105a03 <vector136>:
.globl vector136
vector136:
  pushl $0
80105a03:	6a 00                	push   $0x0
  pushl $136
80105a05:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80105a0a:	e9 c6 f6 ff ff       	jmp    801050d5 <alltraps>

80105a0f <vector137>:
.globl vector137
vector137:
  pushl $0
80105a0f:	6a 00                	push   $0x0
  pushl $137
80105a11:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80105a16:	e9 ba f6 ff ff       	jmp    801050d5 <alltraps>

80105a1b <vector138>:
.globl vector138
vector138:
  pushl $0
80105a1b:	6a 00                	push   $0x0
  pushl $138
80105a1d:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80105a22:	e9 ae f6 ff ff       	jmp    801050d5 <alltraps>

80105a27 <vector139>:
.globl vector139
vector139:
  pushl $0
80105a27:	6a 00                	push   $0x0
  pushl $139
80105a29:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80105a2e:	e9 a2 f6 ff ff       	jmp    801050d5 <alltraps>

80105a33 <vector140>:
.globl vector140
vector140:
  pushl $0
80105a33:	6a 00                	push   $0x0
  pushl $140
80105a35:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80105a3a:	e9 96 f6 ff ff       	jmp    801050d5 <alltraps>

80105a3f <vector141>:
.globl vector141
vector141:
  pushl $0
80105a3f:	6a 00                	push   $0x0
  pushl $141
80105a41:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80105a46:	e9 8a f6 ff ff       	jmp    801050d5 <alltraps>

80105a4b <vector142>:
.globl vector142
vector142:
  pushl $0
80105a4b:	6a 00                	push   $0x0
  pushl $142
80105a4d:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80105a52:	e9 7e f6 ff ff       	jmp    801050d5 <alltraps>

80105a57 <vector143>:
.globl vector143
vector143:
  pushl $0
80105a57:	6a 00                	push   $0x0
  pushl $143
80105a59:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80105a5e:	e9 72 f6 ff ff       	jmp    801050d5 <alltraps>

80105a63 <vector144>:
.globl vector144
vector144:
  pushl $0
80105a63:	6a 00                	push   $0x0
  pushl $144
80105a65:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80105a6a:	e9 66 f6 ff ff       	jmp    801050d5 <alltraps>

80105a6f <vector145>:
.globl vector145
vector145:
  pushl $0
80105a6f:	6a 00                	push   $0x0
  pushl $145
80105a71:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80105a76:	e9 5a f6 ff ff       	jmp    801050d5 <alltraps>

80105a7b <vector146>:
.globl vector146
vector146:
  pushl $0
80105a7b:	6a 00                	push   $0x0
  pushl $146
80105a7d:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80105a82:	e9 4e f6 ff ff       	jmp    801050d5 <alltraps>

80105a87 <vector147>:
.globl vector147
vector147:
  pushl $0
80105a87:	6a 00                	push   $0x0
  pushl $147
80105a89:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80105a8e:	e9 42 f6 ff ff       	jmp    801050d5 <alltraps>

80105a93 <vector148>:
.globl vector148
vector148:
  pushl $0
80105a93:	6a 00                	push   $0x0
  pushl $148
80105a95:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80105a9a:	e9 36 f6 ff ff       	jmp    801050d5 <alltraps>

80105a9f <vector149>:
.globl vector149
vector149:
  pushl $0
80105a9f:	6a 00                	push   $0x0
  pushl $149
80105aa1:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80105aa6:	e9 2a f6 ff ff       	jmp    801050d5 <alltraps>

80105aab <vector150>:
.globl vector150
vector150:
  pushl $0
80105aab:	6a 00                	push   $0x0
  pushl $150
80105aad:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80105ab2:	e9 1e f6 ff ff       	jmp    801050d5 <alltraps>

80105ab7 <vector151>:
.globl vector151
vector151:
  pushl $0
80105ab7:	6a 00                	push   $0x0
  pushl $151
80105ab9:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80105abe:	e9 12 f6 ff ff       	jmp    801050d5 <alltraps>

80105ac3 <vector152>:
.globl vector152
vector152:
  pushl $0
80105ac3:	6a 00                	push   $0x0
  pushl $152
80105ac5:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80105aca:	e9 06 f6 ff ff       	jmp    801050d5 <alltraps>

80105acf <vector153>:
.globl vector153
vector153:
  pushl $0
80105acf:	6a 00                	push   $0x0
  pushl $153
80105ad1:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80105ad6:	e9 fa f5 ff ff       	jmp    801050d5 <alltraps>

80105adb <vector154>:
.globl vector154
vector154:
  pushl $0
80105adb:	6a 00                	push   $0x0
  pushl $154
80105add:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80105ae2:	e9 ee f5 ff ff       	jmp    801050d5 <alltraps>

80105ae7 <vector155>:
.globl vector155
vector155:
  pushl $0
80105ae7:	6a 00                	push   $0x0
  pushl $155
80105ae9:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80105aee:	e9 e2 f5 ff ff       	jmp    801050d5 <alltraps>

80105af3 <vector156>:
.globl vector156
vector156:
  pushl $0
80105af3:	6a 00                	push   $0x0
  pushl $156
80105af5:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80105afa:	e9 d6 f5 ff ff       	jmp    801050d5 <alltraps>

80105aff <vector157>:
.globl vector157
vector157:
  pushl $0
80105aff:	6a 00                	push   $0x0
  pushl $157
80105b01:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80105b06:	e9 ca f5 ff ff       	jmp    801050d5 <alltraps>

80105b0b <vector158>:
.globl vector158
vector158:
  pushl $0
80105b0b:	6a 00                	push   $0x0
  pushl $158
80105b0d:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80105b12:	e9 be f5 ff ff       	jmp    801050d5 <alltraps>

80105b17 <vector159>:
.globl vector159
vector159:
  pushl $0
80105b17:	6a 00                	push   $0x0
  pushl $159
80105b19:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80105b1e:	e9 b2 f5 ff ff       	jmp    801050d5 <alltraps>

80105b23 <vector160>:
.globl vector160
vector160:
  pushl $0
80105b23:	6a 00                	push   $0x0
  pushl $160
80105b25:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80105b2a:	e9 a6 f5 ff ff       	jmp    801050d5 <alltraps>

80105b2f <vector161>:
.globl vector161
vector161:
  pushl $0
80105b2f:	6a 00                	push   $0x0
  pushl $161
80105b31:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80105b36:	e9 9a f5 ff ff       	jmp    801050d5 <alltraps>

80105b3b <vector162>:
.globl vector162
vector162:
  pushl $0
80105b3b:	6a 00                	push   $0x0
  pushl $162
80105b3d:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80105b42:	e9 8e f5 ff ff       	jmp    801050d5 <alltraps>

80105b47 <vector163>:
.globl vector163
vector163:
  pushl $0
80105b47:	6a 00                	push   $0x0
  pushl $163
80105b49:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80105b4e:	e9 82 f5 ff ff       	jmp    801050d5 <alltraps>

80105b53 <vector164>:
.globl vector164
vector164:
  pushl $0
80105b53:	6a 00                	push   $0x0
  pushl $164
80105b55:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80105b5a:	e9 76 f5 ff ff       	jmp    801050d5 <alltraps>

80105b5f <vector165>:
.globl vector165
vector165:
  pushl $0
80105b5f:	6a 00                	push   $0x0
  pushl $165
80105b61:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80105b66:	e9 6a f5 ff ff       	jmp    801050d5 <alltraps>

80105b6b <vector166>:
.globl vector166
vector166:
  pushl $0
80105b6b:	6a 00                	push   $0x0
  pushl $166
80105b6d:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80105b72:	e9 5e f5 ff ff       	jmp    801050d5 <alltraps>

80105b77 <vector167>:
.globl vector167
vector167:
  pushl $0
80105b77:	6a 00                	push   $0x0
  pushl $167
80105b79:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80105b7e:	e9 52 f5 ff ff       	jmp    801050d5 <alltraps>

80105b83 <vector168>:
.globl vector168
vector168:
  pushl $0
80105b83:	6a 00                	push   $0x0
  pushl $168
80105b85:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80105b8a:	e9 46 f5 ff ff       	jmp    801050d5 <alltraps>

80105b8f <vector169>:
.globl vector169
vector169:
  pushl $0
80105b8f:	6a 00                	push   $0x0
  pushl $169
80105b91:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80105b96:	e9 3a f5 ff ff       	jmp    801050d5 <alltraps>

80105b9b <vector170>:
.globl vector170
vector170:
  pushl $0
80105b9b:	6a 00                	push   $0x0
  pushl $170
80105b9d:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80105ba2:	e9 2e f5 ff ff       	jmp    801050d5 <alltraps>

80105ba7 <vector171>:
.globl vector171
vector171:
  pushl $0
80105ba7:	6a 00                	push   $0x0
  pushl $171
80105ba9:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80105bae:	e9 22 f5 ff ff       	jmp    801050d5 <alltraps>

80105bb3 <vector172>:
.globl vector172
vector172:
  pushl $0
80105bb3:	6a 00                	push   $0x0
  pushl $172
80105bb5:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80105bba:	e9 16 f5 ff ff       	jmp    801050d5 <alltraps>

80105bbf <vector173>:
.globl vector173
vector173:
  pushl $0
80105bbf:	6a 00                	push   $0x0
  pushl $173
80105bc1:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80105bc6:	e9 0a f5 ff ff       	jmp    801050d5 <alltraps>

80105bcb <vector174>:
.globl vector174
vector174:
  pushl $0
80105bcb:	6a 00                	push   $0x0
  pushl $174
80105bcd:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80105bd2:	e9 fe f4 ff ff       	jmp    801050d5 <alltraps>

80105bd7 <vector175>:
.globl vector175
vector175:
  pushl $0
80105bd7:	6a 00                	push   $0x0
  pushl $175
80105bd9:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80105bde:	e9 f2 f4 ff ff       	jmp    801050d5 <alltraps>

80105be3 <vector176>:
.globl vector176
vector176:
  pushl $0
80105be3:	6a 00                	push   $0x0
  pushl $176
80105be5:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80105bea:	e9 e6 f4 ff ff       	jmp    801050d5 <alltraps>

80105bef <vector177>:
.globl vector177
vector177:
  pushl $0
80105bef:	6a 00                	push   $0x0
  pushl $177
80105bf1:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80105bf6:	e9 da f4 ff ff       	jmp    801050d5 <alltraps>

80105bfb <vector178>:
.globl vector178
vector178:
  pushl $0
80105bfb:	6a 00                	push   $0x0
  pushl $178
80105bfd:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80105c02:	e9 ce f4 ff ff       	jmp    801050d5 <alltraps>

80105c07 <vector179>:
.globl vector179
vector179:
  pushl $0
80105c07:	6a 00                	push   $0x0
  pushl $179
80105c09:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80105c0e:	e9 c2 f4 ff ff       	jmp    801050d5 <alltraps>

80105c13 <vector180>:
.globl vector180
vector180:
  pushl $0
80105c13:	6a 00                	push   $0x0
  pushl $180
80105c15:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80105c1a:	e9 b6 f4 ff ff       	jmp    801050d5 <alltraps>

80105c1f <vector181>:
.globl vector181
vector181:
  pushl $0
80105c1f:	6a 00                	push   $0x0
  pushl $181
80105c21:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80105c26:	e9 aa f4 ff ff       	jmp    801050d5 <alltraps>

80105c2b <vector182>:
.globl vector182
vector182:
  pushl $0
80105c2b:	6a 00                	push   $0x0
  pushl $182
80105c2d:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80105c32:	e9 9e f4 ff ff       	jmp    801050d5 <alltraps>

80105c37 <vector183>:
.globl vector183
vector183:
  pushl $0
80105c37:	6a 00                	push   $0x0
  pushl $183
80105c39:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80105c3e:	e9 92 f4 ff ff       	jmp    801050d5 <alltraps>

80105c43 <vector184>:
.globl vector184
vector184:
  pushl $0
80105c43:	6a 00                	push   $0x0
  pushl $184
80105c45:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80105c4a:	e9 86 f4 ff ff       	jmp    801050d5 <alltraps>

80105c4f <vector185>:
.globl vector185
vector185:
  pushl $0
80105c4f:	6a 00                	push   $0x0
  pushl $185
80105c51:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80105c56:	e9 7a f4 ff ff       	jmp    801050d5 <alltraps>

80105c5b <vector186>:
.globl vector186
vector186:
  pushl $0
80105c5b:	6a 00                	push   $0x0
  pushl $186
80105c5d:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80105c62:	e9 6e f4 ff ff       	jmp    801050d5 <alltraps>

80105c67 <vector187>:
.globl vector187
vector187:
  pushl $0
80105c67:	6a 00                	push   $0x0
  pushl $187
80105c69:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80105c6e:	e9 62 f4 ff ff       	jmp    801050d5 <alltraps>

80105c73 <vector188>:
.globl vector188
vector188:
  pushl $0
80105c73:	6a 00                	push   $0x0
  pushl $188
80105c75:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80105c7a:	e9 56 f4 ff ff       	jmp    801050d5 <alltraps>

80105c7f <vector189>:
.globl vector189
vector189:
  pushl $0
80105c7f:	6a 00                	push   $0x0
  pushl $189
80105c81:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80105c86:	e9 4a f4 ff ff       	jmp    801050d5 <alltraps>

80105c8b <vector190>:
.globl vector190
vector190:
  pushl $0
80105c8b:	6a 00                	push   $0x0
  pushl $190
80105c8d:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80105c92:	e9 3e f4 ff ff       	jmp    801050d5 <alltraps>

80105c97 <vector191>:
.globl vector191
vector191:
  pushl $0
80105c97:	6a 00                	push   $0x0
  pushl $191
80105c99:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80105c9e:	e9 32 f4 ff ff       	jmp    801050d5 <alltraps>

80105ca3 <vector192>:
.globl vector192
vector192:
  pushl $0
80105ca3:	6a 00                	push   $0x0
  pushl $192
80105ca5:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80105caa:	e9 26 f4 ff ff       	jmp    801050d5 <alltraps>

80105caf <vector193>:
.globl vector193
vector193:
  pushl $0
80105caf:	6a 00                	push   $0x0
  pushl $193
80105cb1:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80105cb6:	e9 1a f4 ff ff       	jmp    801050d5 <alltraps>

80105cbb <vector194>:
.globl vector194
vector194:
  pushl $0
80105cbb:	6a 00                	push   $0x0
  pushl $194
80105cbd:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80105cc2:	e9 0e f4 ff ff       	jmp    801050d5 <alltraps>

80105cc7 <vector195>:
.globl vector195
vector195:
  pushl $0
80105cc7:	6a 00                	push   $0x0
  pushl $195
80105cc9:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80105cce:	e9 02 f4 ff ff       	jmp    801050d5 <alltraps>

80105cd3 <vector196>:
.globl vector196
vector196:
  pushl $0
80105cd3:	6a 00                	push   $0x0
  pushl $196
80105cd5:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80105cda:	e9 f6 f3 ff ff       	jmp    801050d5 <alltraps>

80105cdf <vector197>:
.globl vector197
vector197:
  pushl $0
80105cdf:	6a 00                	push   $0x0
  pushl $197
80105ce1:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80105ce6:	e9 ea f3 ff ff       	jmp    801050d5 <alltraps>

80105ceb <vector198>:
.globl vector198
vector198:
  pushl $0
80105ceb:	6a 00                	push   $0x0
  pushl $198
80105ced:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80105cf2:	e9 de f3 ff ff       	jmp    801050d5 <alltraps>

80105cf7 <vector199>:
.globl vector199
vector199:
  pushl $0
80105cf7:	6a 00                	push   $0x0
  pushl $199
80105cf9:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80105cfe:	e9 d2 f3 ff ff       	jmp    801050d5 <alltraps>

80105d03 <vector200>:
.globl vector200
vector200:
  pushl $0
80105d03:	6a 00                	push   $0x0
  pushl $200
80105d05:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80105d0a:	e9 c6 f3 ff ff       	jmp    801050d5 <alltraps>

80105d0f <vector201>:
.globl vector201
vector201:
  pushl $0
80105d0f:	6a 00                	push   $0x0
  pushl $201
80105d11:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80105d16:	e9 ba f3 ff ff       	jmp    801050d5 <alltraps>

80105d1b <vector202>:
.globl vector202
vector202:
  pushl $0
80105d1b:	6a 00                	push   $0x0
  pushl $202
80105d1d:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80105d22:	e9 ae f3 ff ff       	jmp    801050d5 <alltraps>

80105d27 <vector203>:
.globl vector203
vector203:
  pushl $0
80105d27:	6a 00                	push   $0x0
  pushl $203
80105d29:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80105d2e:	e9 a2 f3 ff ff       	jmp    801050d5 <alltraps>

80105d33 <vector204>:
.globl vector204
vector204:
  pushl $0
80105d33:	6a 00                	push   $0x0
  pushl $204
80105d35:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80105d3a:	e9 96 f3 ff ff       	jmp    801050d5 <alltraps>

80105d3f <vector205>:
.globl vector205
vector205:
  pushl $0
80105d3f:	6a 00                	push   $0x0
  pushl $205
80105d41:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80105d46:	e9 8a f3 ff ff       	jmp    801050d5 <alltraps>

80105d4b <vector206>:
.globl vector206
vector206:
  pushl $0
80105d4b:	6a 00                	push   $0x0
  pushl $206
80105d4d:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80105d52:	e9 7e f3 ff ff       	jmp    801050d5 <alltraps>

80105d57 <vector207>:
.globl vector207
vector207:
  pushl $0
80105d57:	6a 00                	push   $0x0
  pushl $207
80105d59:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80105d5e:	e9 72 f3 ff ff       	jmp    801050d5 <alltraps>

80105d63 <vector208>:
.globl vector208
vector208:
  pushl $0
80105d63:	6a 00                	push   $0x0
  pushl $208
80105d65:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80105d6a:	e9 66 f3 ff ff       	jmp    801050d5 <alltraps>

80105d6f <vector209>:
.globl vector209
vector209:
  pushl $0
80105d6f:	6a 00                	push   $0x0
  pushl $209
80105d71:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80105d76:	e9 5a f3 ff ff       	jmp    801050d5 <alltraps>

80105d7b <vector210>:
.globl vector210
vector210:
  pushl $0
80105d7b:	6a 00                	push   $0x0
  pushl $210
80105d7d:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80105d82:	e9 4e f3 ff ff       	jmp    801050d5 <alltraps>

80105d87 <vector211>:
.globl vector211
vector211:
  pushl $0
80105d87:	6a 00                	push   $0x0
  pushl $211
80105d89:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80105d8e:	e9 42 f3 ff ff       	jmp    801050d5 <alltraps>

80105d93 <vector212>:
.globl vector212
vector212:
  pushl $0
80105d93:	6a 00                	push   $0x0
  pushl $212
80105d95:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80105d9a:	e9 36 f3 ff ff       	jmp    801050d5 <alltraps>

80105d9f <vector213>:
.globl vector213
vector213:
  pushl $0
80105d9f:	6a 00                	push   $0x0
  pushl $213
80105da1:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80105da6:	e9 2a f3 ff ff       	jmp    801050d5 <alltraps>

80105dab <vector214>:
.globl vector214
vector214:
  pushl $0
80105dab:	6a 00                	push   $0x0
  pushl $214
80105dad:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80105db2:	e9 1e f3 ff ff       	jmp    801050d5 <alltraps>

80105db7 <vector215>:
.globl vector215
vector215:
  pushl $0
80105db7:	6a 00                	push   $0x0
  pushl $215
80105db9:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80105dbe:	e9 12 f3 ff ff       	jmp    801050d5 <alltraps>

80105dc3 <vector216>:
.globl vector216
vector216:
  pushl $0
80105dc3:	6a 00                	push   $0x0
  pushl $216
80105dc5:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80105dca:	e9 06 f3 ff ff       	jmp    801050d5 <alltraps>

80105dcf <vector217>:
.globl vector217
vector217:
  pushl $0
80105dcf:	6a 00                	push   $0x0
  pushl $217
80105dd1:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80105dd6:	e9 fa f2 ff ff       	jmp    801050d5 <alltraps>

80105ddb <vector218>:
.globl vector218
vector218:
  pushl $0
80105ddb:	6a 00                	push   $0x0
  pushl $218
80105ddd:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80105de2:	e9 ee f2 ff ff       	jmp    801050d5 <alltraps>

80105de7 <vector219>:
.globl vector219
vector219:
  pushl $0
80105de7:	6a 00                	push   $0x0
  pushl $219
80105de9:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80105dee:	e9 e2 f2 ff ff       	jmp    801050d5 <alltraps>

80105df3 <vector220>:
.globl vector220
vector220:
  pushl $0
80105df3:	6a 00                	push   $0x0
  pushl $220
80105df5:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80105dfa:	e9 d6 f2 ff ff       	jmp    801050d5 <alltraps>

80105dff <vector221>:
.globl vector221
vector221:
  pushl $0
80105dff:	6a 00                	push   $0x0
  pushl $221
80105e01:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80105e06:	e9 ca f2 ff ff       	jmp    801050d5 <alltraps>

80105e0b <vector222>:
.globl vector222
vector222:
  pushl $0
80105e0b:	6a 00                	push   $0x0
  pushl $222
80105e0d:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80105e12:	e9 be f2 ff ff       	jmp    801050d5 <alltraps>

80105e17 <vector223>:
.globl vector223
vector223:
  pushl $0
80105e17:	6a 00                	push   $0x0
  pushl $223
80105e19:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80105e1e:	e9 b2 f2 ff ff       	jmp    801050d5 <alltraps>

80105e23 <vector224>:
.globl vector224
vector224:
  pushl $0
80105e23:	6a 00                	push   $0x0
  pushl $224
80105e25:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80105e2a:	e9 a6 f2 ff ff       	jmp    801050d5 <alltraps>

80105e2f <vector225>:
.globl vector225
vector225:
  pushl $0
80105e2f:	6a 00                	push   $0x0
  pushl $225
80105e31:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80105e36:	e9 9a f2 ff ff       	jmp    801050d5 <alltraps>

80105e3b <vector226>:
.globl vector226
vector226:
  pushl $0
80105e3b:	6a 00                	push   $0x0
  pushl $226
80105e3d:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80105e42:	e9 8e f2 ff ff       	jmp    801050d5 <alltraps>

80105e47 <vector227>:
.globl vector227
vector227:
  pushl $0
80105e47:	6a 00                	push   $0x0
  pushl $227
80105e49:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80105e4e:	e9 82 f2 ff ff       	jmp    801050d5 <alltraps>

80105e53 <vector228>:
.globl vector228
vector228:
  pushl $0
80105e53:	6a 00                	push   $0x0
  pushl $228
80105e55:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80105e5a:	e9 76 f2 ff ff       	jmp    801050d5 <alltraps>

80105e5f <vector229>:
.globl vector229
vector229:
  pushl $0
80105e5f:	6a 00                	push   $0x0
  pushl $229
80105e61:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80105e66:	e9 6a f2 ff ff       	jmp    801050d5 <alltraps>

80105e6b <vector230>:
.globl vector230
vector230:
  pushl $0
80105e6b:	6a 00                	push   $0x0
  pushl $230
80105e6d:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80105e72:	e9 5e f2 ff ff       	jmp    801050d5 <alltraps>

80105e77 <vector231>:
.globl vector231
vector231:
  pushl $0
80105e77:	6a 00                	push   $0x0
  pushl $231
80105e79:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80105e7e:	e9 52 f2 ff ff       	jmp    801050d5 <alltraps>

80105e83 <vector232>:
.globl vector232
vector232:
  pushl $0
80105e83:	6a 00                	push   $0x0
  pushl $232
80105e85:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80105e8a:	e9 46 f2 ff ff       	jmp    801050d5 <alltraps>

80105e8f <vector233>:
.globl vector233
vector233:
  pushl $0
80105e8f:	6a 00                	push   $0x0
  pushl $233
80105e91:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80105e96:	e9 3a f2 ff ff       	jmp    801050d5 <alltraps>

80105e9b <vector234>:
.globl vector234
vector234:
  pushl $0
80105e9b:	6a 00                	push   $0x0
  pushl $234
80105e9d:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80105ea2:	e9 2e f2 ff ff       	jmp    801050d5 <alltraps>

80105ea7 <vector235>:
.globl vector235
vector235:
  pushl $0
80105ea7:	6a 00                	push   $0x0
  pushl $235
80105ea9:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80105eae:	e9 22 f2 ff ff       	jmp    801050d5 <alltraps>

80105eb3 <vector236>:
.globl vector236
vector236:
  pushl $0
80105eb3:	6a 00                	push   $0x0
  pushl $236
80105eb5:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80105eba:	e9 16 f2 ff ff       	jmp    801050d5 <alltraps>

80105ebf <vector237>:
.globl vector237
vector237:
  pushl $0
80105ebf:	6a 00                	push   $0x0
  pushl $237
80105ec1:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80105ec6:	e9 0a f2 ff ff       	jmp    801050d5 <alltraps>

80105ecb <vector238>:
.globl vector238
vector238:
  pushl $0
80105ecb:	6a 00                	push   $0x0
  pushl $238
80105ecd:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80105ed2:	e9 fe f1 ff ff       	jmp    801050d5 <alltraps>

80105ed7 <vector239>:
.globl vector239
vector239:
  pushl $0
80105ed7:	6a 00                	push   $0x0
  pushl $239
80105ed9:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80105ede:	e9 f2 f1 ff ff       	jmp    801050d5 <alltraps>

80105ee3 <vector240>:
.globl vector240
vector240:
  pushl $0
80105ee3:	6a 00                	push   $0x0
  pushl $240
80105ee5:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80105eea:	e9 e6 f1 ff ff       	jmp    801050d5 <alltraps>

80105eef <vector241>:
.globl vector241
vector241:
  pushl $0
80105eef:	6a 00                	push   $0x0
  pushl $241
80105ef1:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80105ef6:	e9 da f1 ff ff       	jmp    801050d5 <alltraps>

80105efb <vector242>:
.globl vector242
vector242:
  pushl $0
80105efb:	6a 00                	push   $0x0
  pushl $242
80105efd:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80105f02:	e9 ce f1 ff ff       	jmp    801050d5 <alltraps>

80105f07 <vector243>:
.globl vector243
vector243:
  pushl $0
80105f07:	6a 00                	push   $0x0
  pushl $243
80105f09:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80105f0e:	e9 c2 f1 ff ff       	jmp    801050d5 <alltraps>

80105f13 <vector244>:
.globl vector244
vector244:
  pushl $0
80105f13:	6a 00                	push   $0x0
  pushl $244
80105f15:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80105f1a:	e9 b6 f1 ff ff       	jmp    801050d5 <alltraps>

80105f1f <vector245>:
.globl vector245
vector245:
  pushl $0
80105f1f:	6a 00                	push   $0x0
  pushl $245
80105f21:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80105f26:	e9 aa f1 ff ff       	jmp    801050d5 <alltraps>

80105f2b <vector246>:
.globl vector246
vector246:
  pushl $0
80105f2b:	6a 00                	push   $0x0
  pushl $246
80105f2d:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80105f32:	e9 9e f1 ff ff       	jmp    801050d5 <alltraps>

80105f37 <vector247>:
.globl vector247
vector247:
  pushl $0
80105f37:	6a 00                	push   $0x0
  pushl $247
80105f39:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80105f3e:	e9 92 f1 ff ff       	jmp    801050d5 <alltraps>

80105f43 <vector248>:
.globl vector248
vector248:
  pushl $0
80105f43:	6a 00                	push   $0x0
  pushl $248
80105f45:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80105f4a:	e9 86 f1 ff ff       	jmp    801050d5 <alltraps>

80105f4f <vector249>:
.globl vector249
vector249:
  pushl $0
80105f4f:	6a 00                	push   $0x0
  pushl $249
80105f51:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80105f56:	e9 7a f1 ff ff       	jmp    801050d5 <alltraps>

80105f5b <vector250>:
.globl vector250
vector250:
  pushl $0
80105f5b:	6a 00                	push   $0x0
  pushl $250
80105f5d:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80105f62:	e9 6e f1 ff ff       	jmp    801050d5 <alltraps>

80105f67 <vector251>:
.globl vector251
vector251:
  pushl $0
80105f67:	6a 00                	push   $0x0
  pushl $251
80105f69:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80105f6e:	e9 62 f1 ff ff       	jmp    801050d5 <alltraps>

80105f73 <vector252>:
.globl vector252
vector252:
  pushl $0
80105f73:	6a 00                	push   $0x0
  pushl $252
80105f75:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80105f7a:	e9 56 f1 ff ff       	jmp    801050d5 <alltraps>

80105f7f <vector253>:
.globl vector253
vector253:
  pushl $0
80105f7f:	6a 00                	push   $0x0
  pushl $253
80105f81:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80105f86:	e9 4a f1 ff ff       	jmp    801050d5 <alltraps>

80105f8b <vector254>:
.globl vector254
vector254:
  pushl $0
80105f8b:	6a 00                	push   $0x0
  pushl $254
80105f8d:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80105f92:	e9 3e f1 ff ff       	jmp    801050d5 <alltraps>

80105f97 <vector255>:
.globl vector255
vector255:
  pushl $0
80105f97:	6a 00                	push   $0x0
  pushl $255
80105f99:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80105f9e:	e9 32 f1 ff ff       	jmp    801050d5 <alltraps>
80105fa3:	90                   	nop

80105fa4 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80105fa4:	55                   	push   %ebp
80105fa5:	89 e5                	mov    %esp,%ebp
80105fa7:	57                   	push   %edi
80105fa8:	56                   	push   %esi
80105fa9:	53                   	push   %ebx
80105faa:	83 ec 1c             	sub    $0x1c,%esp
80105fad:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105fb0:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80105fb3:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80105fb9:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80105fbf:	39 d3                	cmp    %edx,%ebx
80105fc1:	73 4a                	jae    8010600d <deallocuvm.part.0+0x69>
80105fc3:	89 c6                	mov    %eax,%esi
80105fc5:	eb 0c                	jmp    80105fd3 <deallocuvm.part.0+0x2f>
80105fc7:	90                   	nop
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80105fc8:	40                   	inc    %eax
80105fc9:	c1 e0 16             	shl    $0x16,%eax
80105fcc:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80105fce:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
80105fd1:	76 3a                	jbe    8010600d <deallocuvm.part.0+0x69>
  pde = &pgdir[PDX(va)];
80105fd3:	89 d8                	mov    %ebx,%eax
80105fd5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80105fd8:	8b 0c 86             	mov    (%esi,%eax,4),%ecx
80105fdb:	f6 c1 01             	test   $0x1,%cl
80105fde:	74 e8                	je     80105fc8 <deallocuvm.part.0+0x24>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80105fe0:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80105fe6:	89 df                	mov    %ebx,%edi
80105fe8:	c1 ef 0a             	shr    $0xa,%edi
80105feb:	81 e7 fc 0f 00 00    	and    $0xffc,%edi
80105ff1:	8d bc 39 00 00 00 80 	lea    -0x80000000(%ecx,%edi,1),%edi
    if(!pte)
80105ff8:	85 ff                	test   %edi,%edi
80105ffa:	74 cc                	je     80105fc8 <deallocuvm.part.0+0x24>
    else if((*pte & PTE_P) != 0){
80105ffc:	8b 07                	mov    (%edi),%eax
80105ffe:	a8 01                	test   $0x1,%al
80106000:	75 16                	jne    80106018 <deallocuvm.part.0+0x74>
  for(; a  < oldsz; a += PGSIZE){
80106002:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106008:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010600b:	77 c6                	ja     80105fd3 <deallocuvm.part.0+0x2f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
8010600d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106010:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106013:	5b                   	pop    %ebx
80106014:	5e                   	pop    %esi
80106015:	5f                   	pop    %edi
80106016:	5d                   	pop    %ebp
80106017:	c3                   	ret    
      if(pa == 0)
80106018:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010601d:	74 1f                	je     8010603e <deallocuvm.part.0+0x9a>
      kfree(v);
8010601f:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106022:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106027:	50                   	push   %eax
80106028:	e8 9b c1 ff ff       	call   801021c8 <kfree>
      *pte = 0;
8010602d:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  for(; a  < oldsz; a += PGSIZE){
80106033:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106039:	83 c4 10             	add    $0x10,%esp
8010603c:	eb 90                	jmp    80105fce <deallocuvm.part.0+0x2a>
        panic("kfree");
8010603e:	83 ec 0c             	sub    $0xc,%esp
80106041:	68 26 6b 10 80       	push   $0x80106b26
80106046:	e8 ed a2 ff ff       	call   80100338 <panic>
8010604b:	90                   	nop

8010604c <mappages>:
{
8010604c:	55                   	push   %ebp
8010604d:	89 e5                	mov    %esp,%ebp
8010604f:	57                   	push   %edi
80106050:	56                   	push   %esi
80106051:	53                   	push   %ebx
80106052:	83 ec 1c             	sub    $0x1c,%esp
80106055:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  a = (char*)PGROUNDDOWN((uint)va);
80106058:	89 d3                	mov    %edx,%ebx
8010605a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106060:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106064:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106069:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010606c:	8b 45 08             	mov    0x8(%ebp),%eax
8010606f:	29 d8                	sub    %ebx,%eax
80106071:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106074:	eb 39                	jmp    801060af <mappages+0x63>
80106076:	66 90                	xchg   %ax,%ax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106078:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
8010607d:	89 da                	mov    %ebx,%edx
8010607f:	c1 ea 0a             	shr    $0xa,%edx
80106082:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106088:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010608f:	85 c0                	test   %eax,%eax
80106091:	74 71                	je     80106104 <mappages+0xb8>
    if(*pte & PTE_P)
80106093:	f6 00 01             	testb  $0x1,(%eax)
80106096:	0f 85 82 00 00 00    	jne    8010611e <mappages+0xd2>
    *pte = pa | perm | PTE_P;
8010609c:	0b 75 0c             	or     0xc(%ebp),%esi
8010609f:	83 ce 01             	or     $0x1,%esi
801060a2:	89 30                	mov    %esi,(%eax)
    if(a == last)
801060a4:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
801060a7:	74 6b                	je     80106114 <mappages+0xc8>
    a += PGSIZE;
801060a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801060af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801060b2:	8d 34 18             	lea    (%eax,%ebx,1),%esi
  pde = &pgdir[PDX(va)];
801060b5:	89 d8                	mov    %ebx,%eax
801060b7:	c1 e8 16             	shr    $0x16,%eax
801060ba:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801060bd:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801060c0:	8b 07                	mov    (%edi),%eax
801060c2:	a8 01                	test   $0x1,%al
801060c4:	75 b2                	jne    80106078 <mappages+0x2c>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801060c6:	e8 8d c2 ff ff       	call   80102358 <kalloc>
801060cb:	89 c2                	mov    %eax,%edx
801060cd:	85 c0                	test   %eax,%eax
801060cf:	74 33                	je     80106104 <mappages+0xb8>
    memset(pgtab, 0, PGSIZE);
801060d1:	50                   	push   %eax
801060d2:	68 00 10 00 00       	push   $0x1000
801060d7:	6a 00                	push   $0x0
801060d9:	52                   	push   %edx
801060da:	89 55 d8             	mov    %edx,-0x28(%ebp)
801060dd:	e8 06 e0 ff ff       	call   801040e8 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801060e2:	8b 55 d8             	mov    -0x28(%ebp),%edx
801060e5:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801060eb:	83 c8 07             	or     $0x7,%eax
801060ee:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801060f0:	89 d8                	mov    %ebx,%eax
801060f2:	c1 e8 0a             	shr    $0xa,%eax
801060f5:	25 fc 0f 00 00       	and    $0xffc,%eax
801060fa:	01 d0                	add    %edx,%eax
801060fc:	83 c4 10             	add    $0x10,%esp
801060ff:	eb 92                	jmp    80106093 <mappages+0x47>
80106101:	8d 76 00             	lea    0x0(%esi),%esi
      return -1;
80106104:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106109:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010610c:	5b                   	pop    %ebx
8010610d:	5e                   	pop    %esi
8010610e:	5f                   	pop    %edi
8010610f:	5d                   	pop    %ebp
80106110:	c3                   	ret    
80106111:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
80106114:	31 c0                	xor    %eax,%eax
}
80106116:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106119:	5b                   	pop    %ebx
8010611a:	5e                   	pop    %esi
8010611b:	5f                   	pop    %edi
8010611c:	5d                   	pop    %ebp
8010611d:	c3                   	ret    
      panic("remap");
8010611e:	83 ec 0c             	sub    $0xc,%esp
80106121:	68 6c 71 10 80       	push   $0x8010716c
80106126:	e8 0d a2 ff ff       	call   80100338 <panic>
8010612b:	90                   	nop

8010612c <seginit>:
{
8010612c:	55                   	push   %ebp
8010612d:	89 e5                	mov    %esp,%ebp
8010612f:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106132:	e8 41 d3 ff ff       	call   80103478 <cpuid>
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106137:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010613a:	01 d2                	add    %edx,%edx
8010613c:	01 d0                	add    %edx,%eax
8010613e:	c1 e0 04             	shl    $0x4,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106141:	c7 80 18 18 11 80 ff 	movl   $0xffff,-0x7feee7e8(%eax)
80106148:	ff 00 00 
8010614b:	c7 80 1c 18 11 80 00 	movl   $0xcf9a00,-0x7feee7e4(%eax)
80106152:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106155:	c7 80 20 18 11 80 ff 	movl   $0xffff,-0x7feee7e0(%eax)
8010615c:	ff 00 00 
8010615f:	c7 80 24 18 11 80 00 	movl   $0xcf9200,-0x7feee7dc(%eax)
80106166:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106169:	c7 80 28 18 11 80 ff 	movl   $0xffff,-0x7feee7d8(%eax)
80106170:	ff 00 00 
80106173:	c7 80 2c 18 11 80 00 	movl   $0xcffa00,-0x7feee7d4(%eax)
8010617a:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010617d:	c7 80 30 18 11 80 ff 	movl   $0xffff,-0x7feee7d0(%eax)
80106184:	ff 00 00 
80106187:	c7 80 34 18 11 80 00 	movl   $0xcff200,-0x7feee7cc(%eax)
8010618e:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106191:	05 10 18 11 80       	add    $0x80111810,%eax
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106196:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
  pd[1] = (uint)p;
8010619c:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801061a0:	c1 e8 10             	shr    $0x10,%eax
801061a3:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
801061a7:	8d 45 f2             	lea    -0xe(%ebp),%eax
801061aa:	0f 01 10             	lgdtl  (%eax)
}
801061ad:	c9                   	leave  
801061ae:	c3                   	ret    
801061af:	90                   	nop

801061b0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801061b0:	a1 c4 44 11 80       	mov    0x801144c4,%eax
801061b5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801061ba:	0f 22 d8             	mov    %eax,%cr3
}
801061bd:	c3                   	ret    
801061be:	66 90                	xchg   %ax,%ax

801061c0 <switchuvm>:
{
801061c0:	55                   	push   %ebp
801061c1:	89 e5                	mov    %esp,%ebp
801061c3:	57                   	push   %edi
801061c4:	56                   	push   %esi
801061c5:	53                   	push   %ebx
801061c6:	83 ec 1c             	sub    $0x1c,%esp
801061c9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801061cc:	85 f6                	test   %esi,%esi
801061ce:	0f 84 bf 00 00 00    	je     80106293 <switchuvm+0xd3>
  if(p->kstack == 0)
801061d4:	8b 56 08             	mov    0x8(%esi),%edx
801061d7:	85 d2                	test   %edx,%edx
801061d9:	0f 84 ce 00 00 00    	je     801062ad <switchuvm+0xed>
  if(p->pgdir == 0)
801061df:	8b 46 04             	mov    0x4(%esi),%eax
801061e2:	85 c0                	test   %eax,%eax
801061e4:	0f 84 b6 00 00 00    	je     801062a0 <switchuvm+0xe0>
  pushcli();
801061ea:	e8 05 dd ff ff       	call   80103ef4 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801061ef:	e8 20 d2 ff ff       	call   80103414 <mycpu>
801061f4:	89 c3                	mov    %eax,%ebx
801061f6:	e8 19 d2 ff ff       	call   80103414 <mycpu>
801061fb:	89 c7                	mov    %eax,%edi
801061fd:	e8 12 d2 ff ff       	call   80103414 <mycpu>
80106202:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106205:	e8 0a d2 ff ff       	call   80103414 <mycpu>
8010620a:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
80106211:	67 00 
80106213:	83 c7 08             	add    $0x8,%edi
80106216:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010621d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106220:	83 c1 08             	add    $0x8,%ecx
80106223:	c1 e9 10             	shr    $0x10,%ecx
80106226:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
8010622c:	66 c7 83 9d 00 00 00 	movw   $0x4099,0x9d(%ebx)
80106233:	99 40 
80106235:	83 c0 08             	add    $0x8,%eax
80106238:	c1 e8 18             	shr    $0x18,%eax
8010623b:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
80106241:	e8 ce d1 ff ff       	call   80103414 <mycpu>
80106246:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010624d:	e8 c2 d1 ff ff       	call   80103414 <mycpu>
80106252:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106258:	8b 5e 08             	mov    0x8(%esi),%ebx
8010625b:	e8 b4 d1 ff ff       	call   80103414 <mycpu>
80106260:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106266:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106269:	e8 a6 d1 ff ff       	call   80103414 <mycpu>
8010626e:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106274:	b8 28 00 00 00       	mov    $0x28,%eax
80106279:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
8010627c:	8b 46 04             	mov    0x4(%esi),%eax
8010627f:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106284:	0f 22 d8             	mov    %eax,%cr3
}
80106287:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010628a:	5b                   	pop    %ebx
8010628b:	5e                   	pop    %esi
8010628c:	5f                   	pop    %edi
8010628d:	5d                   	pop    %ebp
  popcli();
8010628e:	e9 ad dc ff ff       	jmp    80103f40 <popcli>
    panic("switchuvm: no process");
80106293:	83 ec 0c             	sub    $0xc,%esp
80106296:	68 72 71 10 80       	push   $0x80107172
8010629b:	e8 98 a0 ff ff       	call   80100338 <panic>
    panic("switchuvm: no pgdir");
801062a0:	83 ec 0c             	sub    $0xc,%esp
801062a3:	68 9d 71 10 80       	push   $0x8010719d
801062a8:	e8 8b a0 ff ff       	call   80100338 <panic>
    panic("switchuvm: no kstack");
801062ad:	83 ec 0c             	sub    $0xc,%esp
801062b0:	68 88 71 10 80       	push   $0x80107188
801062b5:	e8 7e a0 ff ff       	call   80100338 <panic>
801062ba:	66 90                	xchg   %ax,%ax

801062bc <inituvm>:
{
801062bc:	55                   	push   %ebp
801062bd:	89 e5                	mov    %esp,%ebp
801062bf:	57                   	push   %edi
801062c0:	56                   	push   %esi
801062c1:	53                   	push   %ebx
801062c2:	83 ec 1c             	sub    $0x1c,%esp
801062c5:	8b 45 08             	mov    0x8(%ebp),%eax
801062c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801062cb:	8b 7d 0c             	mov    0xc(%ebp),%edi
801062ce:	8b 75 10             	mov    0x10(%ebp),%esi
  if(sz >= PGSIZE)
801062d1:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801062d7:	77 47                	ja     80106320 <inituvm+0x64>
  mem = kalloc();
801062d9:	e8 7a c0 ff ff       	call   80102358 <kalloc>
801062de:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801062e0:	50                   	push   %eax
801062e1:	68 00 10 00 00       	push   $0x1000
801062e6:	6a 00                	push   $0x0
801062e8:	53                   	push   %ebx
801062e9:	e8 fa dd ff ff       	call   801040e8 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801062ee:	5a                   	pop    %edx
801062ef:	59                   	pop    %ecx
801062f0:	6a 06                	push   $0x6
801062f2:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801062f8:	50                   	push   %eax
801062f9:	b9 00 10 00 00       	mov    $0x1000,%ecx
801062fe:	31 d2                	xor    %edx,%edx
80106300:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106303:	e8 44 fd ff ff       	call   8010604c <mappages>
  memmove(mem, init, sz);
80106308:	83 c4 10             	add    $0x10,%esp
8010630b:	89 75 10             	mov    %esi,0x10(%ebp)
8010630e:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106311:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106314:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106317:	5b                   	pop    %ebx
80106318:	5e                   	pop    %esi
80106319:	5f                   	pop    %edi
8010631a:	5d                   	pop    %ebp
  memmove(mem, init, sz);
8010631b:	e9 4c de ff ff       	jmp    8010416c <memmove>
    panic("inituvm: more than a page");
80106320:	83 ec 0c             	sub    $0xc,%esp
80106323:	68 b1 71 10 80       	push   $0x801071b1
80106328:	e8 0b a0 ff ff       	call   80100338 <panic>
8010632d:	8d 76 00             	lea    0x0(%esi),%esi

80106330 <loaduvm>:
{
80106330:	55                   	push   %ebp
80106331:	89 e5                	mov    %esp,%ebp
80106333:	57                   	push   %edi
80106334:	56                   	push   %esi
80106335:	53                   	push   %ebx
80106336:	83 ec 1c             	sub    $0x1c,%esp
80106339:	8b 45 0c             	mov    0xc(%ebp),%eax
8010633c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010633f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106344:	0f 85 b3 00 00 00    	jne    801063fd <loaduvm+0xcd>
  for(i = 0; i < sz; i += PGSIZE){
8010634a:	85 f6                	test   %esi,%esi
8010634c:	0f 84 8a 00 00 00    	je     801063dc <loaduvm+0xac>
80106352:	89 f3                	mov    %esi,%ebx
80106354:	01 f0                	add    %esi,%eax
80106356:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106359:	8b 45 14             	mov    0x14(%ebp),%eax
8010635c:	01 f0                	add    %esi,%eax
8010635e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106361:	8d 76 00             	lea    0x0(%esi),%esi
  pde = &pgdir[PDX(va)];
80106364:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106367:	29 d8                	sub    %ebx,%eax
80106369:	89 c2                	mov    %eax,%edx
8010636b:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
8010636e:	8b 7d 08             	mov    0x8(%ebp),%edi
80106371:	8b 14 97             	mov    (%edi,%edx,4),%edx
80106374:	f6 c2 01             	test   $0x1,%dl
80106377:	75 0f                	jne    80106388 <loaduvm+0x58>
      panic("loaduvm: address should exist");
80106379:	83 ec 0c             	sub    $0xc,%esp
8010637c:	68 cb 71 10 80       	push   $0x801071cb
80106381:	e8 b2 9f ff ff       	call   80100338 <panic>
80106386:	66 90                	xchg   %ax,%ax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106388:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
8010638e:	c1 e8 0a             	shr    $0xa,%eax
80106391:	25 fc 0f 00 00       	and    $0xffc,%eax
80106396:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010639d:	85 c0                	test   %eax,%eax
8010639f:	74 d8                	je     80106379 <loaduvm+0x49>
    pa = PTE_ADDR(*pte);
801063a1:	8b 00                	mov    (%eax),%eax
801063a3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801063a8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801063ae:	77 38                	ja     801063e8 <loaduvm+0xb8>
801063b0:	89 df                	mov    %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801063b2:	57                   	push   %edi
801063b3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801063b6:	29 d9                	sub    %ebx,%ecx
801063b8:	51                   	push   %ecx
801063b9:	05 00 00 00 80       	add    $0x80000000,%eax
801063be:	50                   	push   %eax
801063bf:	ff 75 10             	push   0x10(%ebp)
801063c2:	e8 c5 b4 ff ff       	call   8010188c <readi>
801063c7:	83 c4 10             	add    $0x10,%esp
801063ca:	39 f8                	cmp    %edi,%eax
801063cc:	75 22                	jne    801063f0 <loaduvm+0xc0>
  for(i = 0; i < sz; i += PGSIZE){
801063ce:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801063d4:	89 f0                	mov    %esi,%eax
801063d6:	29 d8                	sub    %ebx,%eax
801063d8:	39 c6                	cmp    %eax,%esi
801063da:	77 88                	ja     80106364 <loaduvm+0x34>
  return 0;
801063dc:	31 c0                	xor    %eax,%eax
}
801063de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063e1:	5b                   	pop    %ebx
801063e2:	5e                   	pop    %esi
801063e3:	5f                   	pop    %edi
801063e4:	5d                   	pop    %ebp
801063e5:	c3                   	ret    
801063e6:	66 90                	xchg   %ax,%ax
      n = PGSIZE;
801063e8:	bf 00 10 00 00       	mov    $0x1000,%edi
801063ed:	eb c3                	jmp    801063b2 <loaduvm+0x82>
801063ef:	90                   	nop
      return -1;
801063f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063f8:	5b                   	pop    %ebx
801063f9:	5e                   	pop    %esi
801063fa:	5f                   	pop    %edi
801063fb:	5d                   	pop    %ebp
801063fc:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
801063fd:	83 ec 0c             	sub    $0xc,%esp
80106400:	68 6c 72 10 80       	push   $0x8010726c
80106405:	e8 2e 9f ff ff       	call   80100338 <panic>
8010640a:	66 90                	xchg   %ax,%ax

8010640c <allocuvm>:
{
8010640c:	55                   	push   %ebp
8010640d:	89 e5                	mov    %esp,%ebp
8010640f:	57                   	push   %edi
80106410:	56                   	push   %esi
80106411:	53                   	push   %ebx
80106412:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106415:	8b 7d 10             	mov    0x10(%ebp),%edi
80106418:	85 ff                	test   %edi,%edi
8010641a:	0f 88 b8 00 00 00    	js     801064d8 <allocuvm+0xcc>
  if(newsz < oldsz)
80106420:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106423:	0f 82 9f 00 00 00    	jb     801064c8 <allocuvm+0xbc>
  a = PGROUNDUP(oldsz);
80106429:	8b 45 0c             	mov    0xc(%ebp),%eax
8010642c:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80106432:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80106438:	39 75 10             	cmp    %esi,0x10(%ebp)
8010643b:	0f 86 8a 00 00 00    	jbe    801064cb <allocuvm+0xbf>
80106441:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106444:	8b 7d 10             	mov    0x10(%ebp),%edi
80106447:	eb 40                	jmp    80106489 <allocuvm+0x7d>
80106449:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
8010644c:	50                   	push   %eax
8010644d:	68 00 10 00 00       	push   $0x1000
80106452:	6a 00                	push   $0x0
80106454:	53                   	push   %ebx
80106455:	e8 8e dc ff ff       	call   801040e8 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
8010645a:	5a                   	pop    %edx
8010645b:	59                   	pop    %ecx
8010645c:	6a 06                	push   $0x6
8010645e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106464:	50                   	push   %eax
80106465:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010646a:	89 f2                	mov    %esi,%edx
8010646c:	8b 45 08             	mov    0x8(%ebp),%eax
8010646f:	e8 d8 fb ff ff       	call   8010604c <mappages>
80106474:	83 c4 10             	add    $0x10,%esp
80106477:	85 c0                	test   %eax,%eax
80106479:	78 69                	js     801064e4 <allocuvm+0xd8>
  for(; a < newsz; a += PGSIZE){
8010647b:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106481:	39 f7                	cmp    %esi,%edi
80106483:	0f 86 9b 00 00 00    	jbe    80106524 <allocuvm+0x118>
    mem = kalloc();
80106489:	e8 ca be ff ff       	call   80102358 <kalloc>
8010648e:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106490:	85 c0                	test   %eax,%eax
80106492:	75 b8                	jne    8010644c <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106494:	83 ec 0c             	sub    $0xc,%esp
80106497:	68 e9 71 10 80       	push   $0x801071e9
8010649c:	e8 7b a1 ff ff       	call   8010061c <cprintf>
  if(newsz >= oldsz)
801064a1:	83 c4 10             	add    $0x10,%esp
801064a4:	8b 45 0c             	mov    0xc(%ebp),%eax
801064a7:	39 45 10             	cmp    %eax,0x10(%ebp)
801064aa:	74 2c                	je     801064d8 <allocuvm+0xcc>
801064ac:	89 c1                	mov    %eax,%ecx
801064ae:	8b 55 10             	mov    0x10(%ebp),%edx
801064b1:	8b 45 08             	mov    0x8(%ebp),%eax
801064b4:	e8 eb fa ff ff       	call   80105fa4 <deallocuvm.part.0>
      return 0;
801064b9:	31 ff                	xor    %edi,%edi
}
801064bb:	89 f8                	mov    %edi,%eax
801064bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064c0:	5b                   	pop    %ebx
801064c1:	5e                   	pop    %esi
801064c2:	5f                   	pop    %edi
801064c3:	5d                   	pop    %ebp
801064c4:	c3                   	ret    
801064c5:	8d 76 00             	lea    0x0(%esi),%esi
    return oldsz;
801064c8:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801064cb:	89 f8                	mov    %edi,%eax
801064cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064d0:	5b                   	pop    %ebx
801064d1:	5e                   	pop    %esi
801064d2:	5f                   	pop    %edi
801064d3:	5d                   	pop    %ebp
801064d4:	c3                   	ret    
801064d5:	8d 76 00             	lea    0x0(%esi),%esi
    return 0;
801064d8:	31 ff                	xor    %edi,%edi
}
801064da:	89 f8                	mov    %edi,%eax
801064dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064df:	5b                   	pop    %ebx
801064e0:	5e                   	pop    %esi
801064e1:	5f                   	pop    %edi
801064e2:	5d                   	pop    %ebp
801064e3:	c3                   	ret    
      cprintf("allocuvm out of memory (2)\n");
801064e4:	83 ec 0c             	sub    $0xc,%esp
801064e7:	68 01 72 10 80       	push   $0x80107201
801064ec:	e8 2b a1 ff ff       	call   8010061c <cprintf>
  if(newsz >= oldsz)
801064f1:	83 c4 10             	add    $0x10,%esp
801064f4:	8b 45 0c             	mov    0xc(%ebp),%eax
801064f7:	39 45 10             	cmp    %eax,0x10(%ebp)
801064fa:	74 0d                	je     80106509 <allocuvm+0xfd>
801064fc:	89 c1                	mov    %eax,%ecx
801064fe:	8b 55 10             	mov    0x10(%ebp),%edx
80106501:	8b 45 08             	mov    0x8(%ebp),%eax
80106504:	e8 9b fa ff ff       	call   80105fa4 <deallocuvm.part.0>
      kfree(mem);
80106509:	83 ec 0c             	sub    $0xc,%esp
8010650c:	53                   	push   %ebx
8010650d:	e8 b6 bc ff ff       	call   801021c8 <kfree>
      return 0;
80106512:	83 c4 10             	add    $0x10,%esp
80106515:	31 ff                	xor    %edi,%edi
}
80106517:	89 f8                	mov    %edi,%eax
80106519:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010651c:	5b                   	pop    %ebx
8010651d:	5e                   	pop    %esi
8010651e:	5f                   	pop    %edi
8010651f:	5d                   	pop    %ebp
80106520:	c3                   	ret    
80106521:	8d 76 00             	lea    0x0(%esi),%esi
80106524:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106527:	89 f8                	mov    %edi,%eax
80106529:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010652c:	5b                   	pop    %ebx
8010652d:	5e                   	pop    %esi
8010652e:	5f                   	pop    %edi
8010652f:	5d                   	pop    %ebp
80106530:	c3                   	ret    
80106531:	8d 76 00             	lea    0x0(%esi),%esi

80106534 <deallocuvm>:
{
80106534:	55                   	push   %ebp
80106535:	89 e5                	mov    %esp,%ebp
80106537:	8b 45 08             	mov    0x8(%ebp),%eax
8010653a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010653d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if(newsz >= oldsz)
80106540:	39 d1                	cmp    %edx,%ecx
80106542:	73 08                	jae    8010654c <deallocuvm+0x18>
}
80106544:	5d                   	pop    %ebp
80106545:	e9 5a fa ff ff       	jmp    80105fa4 <deallocuvm.part.0>
8010654a:	66 90                	xchg   %ax,%ax
8010654c:	89 d0                	mov    %edx,%eax
8010654e:	5d                   	pop    %ebp
8010654f:	c3                   	ret    

80106550 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106550:	55                   	push   %ebp
80106551:	89 e5                	mov    %esp,%ebp
80106553:	57                   	push   %edi
80106554:	56                   	push   %esi
80106555:	53                   	push   %ebx
80106556:	83 ec 0c             	sub    $0xc,%esp
80106559:	8b 7d 08             	mov    0x8(%ebp),%edi
  uint i;

  if(pgdir == 0)
8010655c:	85 ff                	test   %edi,%edi
8010655e:	74 51                	je     801065b1 <freevm+0x61>
  if(newsz >= oldsz)
80106560:	31 c9                	xor    %ecx,%ecx
80106562:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106567:	89 f8                	mov    %edi,%eax
80106569:	e8 36 fa ff ff       	call   80105fa4 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
8010656e:	89 fb                	mov    %edi,%ebx
80106570:	8d b7 00 10 00 00    	lea    0x1000(%edi),%esi
80106576:	eb 07                	jmp    8010657f <freevm+0x2f>
80106578:	83 c3 04             	add    $0x4,%ebx
8010657b:	39 de                	cmp    %ebx,%esi
8010657d:	74 23                	je     801065a2 <freevm+0x52>
    if(pgdir[i] & PTE_P){
8010657f:	8b 03                	mov    (%ebx),%eax
80106581:	a8 01                	test   $0x1,%al
80106583:	74 f3                	je     80106578 <freevm+0x28>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106585:	83 ec 0c             	sub    $0xc,%esp
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106588:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010658d:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106592:	50                   	push   %eax
80106593:	e8 30 bc ff ff       	call   801021c8 <kfree>
80106598:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010659b:	83 c3 04             	add    $0x4,%ebx
8010659e:	39 de                	cmp    %ebx,%esi
801065a0:	75 dd                	jne    8010657f <freevm+0x2f>
    }
  }
  kfree((char*)pgdir);
801065a2:	89 7d 08             	mov    %edi,0x8(%ebp)
}
801065a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801065a8:	5b                   	pop    %ebx
801065a9:	5e                   	pop    %esi
801065aa:	5f                   	pop    %edi
801065ab:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801065ac:	e9 17 bc ff ff       	jmp    801021c8 <kfree>
    panic("freevm: no pgdir");
801065b1:	83 ec 0c             	sub    $0xc,%esp
801065b4:	68 1d 72 10 80       	push   $0x8010721d
801065b9:	e8 7a 9d ff ff       	call   80100338 <panic>
801065be:	66 90                	xchg   %ax,%ax

801065c0 <setupkvm>:
{
801065c0:	55                   	push   %ebp
801065c1:	89 e5                	mov    %esp,%ebp
801065c3:	56                   	push   %esi
801065c4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801065c5:	e8 8e bd ff ff       	call   80102358 <kalloc>
801065ca:	89 c6                	mov    %eax,%esi
801065cc:	85 c0                	test   %eax,%eax
801065ce:	74 40                	je     80106610 <setupkvm+0x50>
  memset(pgdir, 0, PGSIZE);
801065d0:	50                   	push   %eax
801065d1:	68 00 10 00 00       	push   $0x1000
801065d6:	6a 00                	push   $0x0
801065d8:	56                   	push   %esi
801065d9:	e8 0a db ff ff       	call   801040e8 <memset>
801065de:	83 c4 10             	add    $0x10,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801065e1:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
                (uint)k->phys_start, k->perm) < 0) {
801065e6:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801065e9:	8b 4b 08             	mov    0x8(%ebx),%ecx
801065ec:	29 c1                	sub    %eax,%ecx
801065ee:	83 ec 08             	sub    $0x8,%esp
801065f1:	ff 73 0c             	push   0xc(%ebx)
801065f4:	50                   	push   %eax
801065f5:	8b 13                	mov    (%ebx),%edx
801065f7:	89 f0                	mov    %esi,%eax
801065f9:	e8 4e fa ff ff       	call   8010604c <mappages>
801065fe:	83 c4 10             	add    $0x10,%esp
80106601:	85 c0                	test   %eax,%eax
80106603:	78 17                	js     8010661c <setupkvm+0x5c>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106605:	83 c3 10             	add    $0x10,%ebx
80106608:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
8010660e:	75 d6                	jne    801065e6 <setupkvm+0x26>
}
80106610:	89 f0                	mov    %esi,%eax
80106612:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106615:	5b                   	pop    %ebx
80106616:	5e                   	pop    %esi
80106617:	5d                   	pop    %ebp
80106618:	c3                   	ret    
80106619:	8d 76 00             	lea    0x0(%esi),%esi
      freevm(pgdir);
8010661c:	83 ec 0c             	sub    $0xc,%esp
8010661f:	56                   	push   %esi
80106620:	e8 2b ff ff ff       	call   80106550 <freevm>
      return 0;
80106625:	83 c4 10             	add    $0x10,%esp
80106628:	31 f6                	xor    %esi,%esi
}
8010662a:	89 f0                	mov    %esi,%eax
8010662c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010662f:	5b                   	pop    %ebx
80106630:	5e                   	pop    %esi
80106631:	5d                   	pop    %ebp
80106632:	c3                   	ret    
80106633:	90                   	nop

80106634 <kvmalloc>:
{
80106634:	55                   	push   %ebp
80106635:	89 e5                	mov    %esp,%ebp
80106637:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
8010663a:	e8 81 ff ff ff       	call   801065c0 <setupkvm>
8010663f:	a3 c4 44 11 80       	mov    %eax,0x801144c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106644:	05 00 00 00 80       	add    $0x80000000,%eax
80106649:	0f 22 d8             	mov    %eax,%cr3
}
8010664c:	c9                   	leave  
8010664d:	c3                   	ret    
8010664e:	66 90                	xchg   %ax,%ax

80106650 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106650:	55                   	push   %ebp
80106651:	89 e5                	mov    %esp,%ebp
80106653:	83 ec 08             	sub    $0x8,%esp
  pde = &pgdir[PDX(va)];
80106656:	8b 55 0c             	mov    0xc(%ebp),%edx
80106659:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
8010665c:	8b 45 08             	mov    0x8(%ebp),%eax
8010665f:	8b 04 90             	mov    (%eax,%edx,4),%eax
80106662:	a8 01                	test   $0x1,%al
80106664:	75 0e                	jne    80106674 <clearpteu+0x24>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106666:	83 ec 0c             	sub    $0xc,%esp
80106669:	68 2e 72 10 80       	push   $0x8010722e
8010666e:	e8 c5 9c ff ff       	call   80100338 <panic>
80106673:	90                   	nop
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106674:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106679:	89 c2                	mov    %eax,%edx
  return &pgtab[PTX(va)];
8010667b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010667e:	c1 e8 0a             	shr    $0xa,%eax
80106681:	25 fc 0f 00 00       	and    $0xffc,%eax
80106686:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
8010668d:	85 c0                	test   %eax,%eax
8010668f:	74 d5                	je     80106666 <clearpteu+0x16>
  *pte &= ~PTE_U;
80106691:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106694:	c9                   	leave  
80106695:	c3                   	ret    
80106696:	66 90                	xchg   %ax,%ax

80106698 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106698:	55                   	push   %ebp
80106699:	89 e5                	mov    %esp,%ebp
8010669b:	57                   	push   %edi
8010669c:	56                   	push   %esi
8010669d:	53                   	push   %ebx
8010669e:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801066a1:	e8 1a ff ff ff       	call   801065c0 <setupkvm>
801066a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801066a9:	85 c0                	test   %eax,%eax
801066ab:	0f 84 b0 00 00 00    	je     80106761 <copyuvm+0xc9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801066b1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801066b4:	85 db                	test   %ebx,%ebx
801066b6:	0f 84 a5 00 00 00    	je     80106761 <copyuvm+0xc9>
801066bc:	31 ff                	xor    %edi,%edi
801066be:	66 90                	xchg   %ax,%ax
  pde = &pgdir[PDX(va)];
801066c0:	89 f8                	mov    %edi,%eax
801066c2:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801066c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
801066c8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801066cb:	a8 01                	test   $0x1,%al
801066cd:	75 0d                	jne    801066dc <copyuvm+0x44>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801066cf:	83 ec 0c             	sub    $0xc,%esp
801066d2:	68 38 72 10 80       	push   $0x80107238
801066d7:	e8 5c 9c ff ff       	call   80100338 <panic>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801066dc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801066e1:	89 fa                	mov    %edi,%edx
801066e3:	c1 ea 0a             	shr    $0xa,%edx
801066e6:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801066ec:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801066f3:	85 c0                	test   %eax,%eax
801066f5:	74 d8                	je     801066cf <copyuvm+0x37>
    if(!(*pte & PTE_P))
801066f7:	8b 18                	mov    (%eax),%ebx
801066f9:	f6 c3 01             	test   $0x1,%bl
801066fc:	0f 84 96 00 00 00    	je     80106798 <copyuvm+0x100>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106702:	89 d8                	mov    %ebx,%eax
80106704:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106709:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    flags = PTE_FLAGS(*pte);
8010670c:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    if((mem = kalloc()) == 0)
80106712:	e8 41 bc ff ff       	call   80102358 <kalloc>
80106717:	89 c6                	mov    %eax,%esi
80106719:	85 c0                	test   %eax,%eax
8010671b:	74 5b                	je     80106778 <copyuvm+0xe0>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
8010671d:	50                   	push   %eax
8010671e:	68 00 10 00 00       	push   $0x1000
80106723:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106726:	05 00 00 00 80       	add    $0x80000000,%eax
8010672b:	50                   	push   %eax
8010672c:	56                   	push   %esi
8010672d:	e8 3a da ff ff       	call   8010416c <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106732:	5a                   	pop    %edx
80106733:	59                   	pop    %ecx
80106734:	53                   	push   %ebx
80106735:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010673b:	50                   	push   %eax
8010673c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106741:	89 fa                	mov    %edi,%edx
80106743:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106746:	e8 01 f9 ff ff       	call   8010604c <mappages>
8010674b:	83 c4 10             	add    $0x10,%esp
8010674e:	85 c0                	test   %eax,%eax
80106750:	78 1a                	js     8010676c <copyuvm+0xd4>
  for(i = 0; i < sz; i += PGSIZE){
80106752:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106758:	39 7d 0c             	cmp    %edi,0xc(%ebp)
8010675b:	0f 87 5f ff ff ff    	ja     801066c0 <copyuvm+0x28>
  return d;

bad:
  freevm(d);
  return 0;
}
80106761:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106764:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106767:	5b                   	pop    %ebx
80106768:	5e                   	pop    %esi
80106769:	5f                   	pop    %edi
8010676a:	5d                   	pop    %ebp
8010676b:	c3                   	ret    
      kfree(mem);
8010676c:	83 ec 0c             	sub    $0xc,%esp
8010676f:	56                   	push   %esi
80106770:	e8 53 ba ff ff       	call   801021c8 <kfree>
      goto bad;
80106775:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80106778:	83 ec 0c             	sub    $0xc,%esp
8010677b:	ff 75 e0             	push   -0x20(%ebp)
8010677e:	e8 cd fd ff ff       	call   80106550 <freevm>
  return 0;
80106783:	83 c4 10             	add    $0x10,%esp
80106786:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
8010678d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106790:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106793:	5b                   	pop    %ebx
80106794:	5e                   	pop    %esi
80106795:	5f                   	pop    %edi
80106796:	5d                   	pop    %ebp
80106797:	c3                   	ret    
      panic("copyuvm: page not present");
80106798:	83 ec 0c             	sub    $0xc,%esp
8010679b:	68 52 72 10 80       	push   $0x80107252
801067a0:	e8 93 9b ff ff       	call   80100338 <panic>
801067a5:	8d 76 00             	lea    0x0(%esi),%esi

801067a8 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801067a8:	55                   	push   %ebp
801067a9:	89 e5                	mov    %esp,%ebp
  pde = &pgdir[PDX(va)];
801067ab:	8b 55 0c             	mov    0xc(%ebp),%edx
801067ae:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801067b1:	8b 45 08             	mov    0x8(%ebp),%eax
801067b4:	8b 04 90             	mov    (%eax,%edx,4),%eax
801067b7:	a8 01                	test   $0x1,%al
801067b9:	0f 84 f3 00 00 00    	je     801068b2 <uva2ka.cold>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801067bf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801067c4:	89 c2                	mov    %eax,%edx
  return &pgtab[PTX(va)];
801067c6:	8b 45 0c             	mov    0xc(%ebp),%eax
801067c9:	c1 e8 0c             	shr    $0xc,%eax
801067cc:	25 ff 03 00 00       	and    $0x3ff,%eax
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
801067d1:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801067d8:	89 c2                	mov    %eax,%edx
801067da:	83 e2 05             	and    $0x5,%edx
801067dd:	83 fa 05             	cmp    $0x5,%edx
801067e0:	75 0e                	jne    801067f0 <uva2ka+0x48>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801067e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801067e7:	05 00 00 00 80       	add    $0x80000000,%eax
}
801067ec:	5d                   	pop    %ebp
801067ed:	c3                   	ret    
801067ee:	66 90                	xchg   %ax,%ax
    return 0;
801067f0:	31 c0                	xor    %eax,%eax
}
801067f2:	5d                   	pop    %ebp
801067f3:	c3                   	ret    

801067f4 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801067f4:	55                   	push   %ebp
801067f5:	89 e5                	mov    %esp,%ebp
801067f7:	57                   	push   %edi
801067f8:	56                   	push   %esi
801067f9:	53                   	push   %ebx
801067fa:	83 ec 0c             	sub    $0xc,%esp
801067fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80106800:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106803:	8b 4d 14             	mov    0x14(%ebp),%ecx
80106806:	85 c9                	test   %ecx,%ecx
80106808:	0f 84 9a 00 00 00    	je     801068a8 <copyout+0xb4>
8010680e:	89 fe                	mov    %edi,%esi
80106810:	eb 45                	jmp    80106857 <copyout+0x63>
80106812:	66 90                	xchg   %ax,%ax
  return (char*)P2V(PTE_ADDR(*pte));
80106814:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010681a:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80106820:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80106826:	74 71                	je     80106899 <copyout+0xa5>
      return -1;
    n = PGSIZE - (va - va0);
80106828:	89 fb                	mov    %edi,%ebx
8010682a:	29 c3                	sub    %eax,%ebx
8010682c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106832:	3b 5d 14             	cmp    0x14(%ebp),%ebx
80106835:	76 03                	jbe    8010683a <copyout+0x46>
80106837:	8b 5d 14             	mov    0x14(%ebp),%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
8010683a:	52                   	push   %edx
8010683b:	53                   	push   %ebx
8010683c:	56                   	push   %esi
8010683d:	29 f8                	sub    %edi,%eax
8010683f:	01 c1                	add    %eax,%ecx
80106841:	51                   	push   %ecx
80106842:	e8 25 d9 ff ff       	call   8010416c <memmove>
    len -= n;
    buf += n;
80106847:	01 de                	add    %ebx,%esi
    va = va0 + PGSIZE;
80106849:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010684f:	83 c4 10             	add    $0x10,%esp
80106852:	29 5d 14             	sub    %ebx,0x14(%ebp)
80106855:	74 51                	je     801068a8 <copyout+0xb4>
    va0 = (uint)PGROUNDDOWN(va);
80106857:	89 c7                	mov    %eax,%edi
80106859:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  pde = &pgdir[PDX(va)];
8010685f:	89 c1                	mov    %eax,%ecx
80106861:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106864:	8b 55 08             	mov    0x8(%ebp),%edx
80106867:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
8010686a:	f6 c1 01             	test   $0x1,%cl
8010686d:	0f 84 46 00 00 00    	je     801068b9 <copyout.cold>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106873:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106879:	89 fb                	mov    %edi,%ebx
8010687b:	c1 eb 0c             	shr    $0xc,%ebx
8010687e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80106884:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010688b:	89 d9                	mov    %ebx,%ecx
8010688d:	83 e1 05             	and    $0x5,%ecx
80106890:	83 f9 05             	cmp    $0x5,%ecx
80106893:	0f 84 7b ff ff ff    	je     80106814 <copyout+0x20>
      return -1;
80106899:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
8010689e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068a1:	5b                   	pop    %ebx
801068a2:	5e                   	pop    %esi
801068a3:	5f                   	pop    %edi
801068a4:	5d                   	pop    %ebp
801068a5:	c3                   	ret    
801068a6:	66 90                	xchg   %ax,%ax
  return 0;
801068a8:	31 c0                	xor    %eax,%eax
}
801068aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068ad:	5b                   	pop    %ebx
801068ae:	5e                   	pop    %esi
801068af:	5f                   	pop    %edi
801068b0:	5d                   	pop    %ebp
801068b1:	c3                   	ret    

801068b2 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801068b2:	a1 00 00 00 00       	mov    0x0,%eax
801068b7:	0f 0b                	ud2    

801068b9 <copyout.cold>:
801068b9:	a1 00 00 00 00       	mov    0x0,%eax
801068be:	0f 0b                	ud2    
