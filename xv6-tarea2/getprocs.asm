
_getprocs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

#include "types.h"
#include "stat.h"
#include "user.h"

int main(void) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	50                   	push   %eax

  printf(1,"La cantidad de procesos corrindo en el sistema son %d\n",getprocs());
   f:	e8 8b 02 00 00       	call   29f <getprocs>
  14:	52                   	push   %edx
  15:	50                   	push   %eax
  16:	68 14 06 00 00       	push   $0x614
  1b:	6a 01                	push   $0x1
  1d:	e8 0e 03 00 00       	call   330 <printf>

  exit();
  22:	e8 d8 01 00 00       	call   1ff <exit>
  27:	90                   	nop

00000028 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  28:	55                   	push   %ebp
  29:	89 e5                	mov    %esp,%ebp
  2b:	53                   	push   %ebx
  2c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  2f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  32:	31 c0                	xor    %eax,%eax
  34:	8a 14 03             	mov    (%ebx,%eax,1),%dl
  37:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  3a:	40                   	inc    %eax
  3b:	84 d2                	test   %dl,%dl
  3d:	75 f5                	jne    34 <strcpy+0xc>
    ;
  return os;
}
  3f:	89 c8                	mov    %ecx,%eax
  41:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  44:	c9                   	leave  
  45:	c3                   	ret    
  46:	66 90                	xchg   %ax,%ax

00000048 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  48:	55                   	push   %ebp
  49:	89 e5                	mov    %esp,%ebp
  4b:	53                   	push   %ebx
  4c:	8b 55 08             	mov    0x8(%ebp),%edx
  4f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  52:	0f b6 02             	movzbl (%edx),%eax
  55:	84 c0                	test   %al,%al
  57:	75 10                	jne    69 <strcmp+0x21>
  59:	eb 2a                	jmp    85 <strcmp+0x3d>
  5b:	90                   	nop
    p++, q++;
  5c:	42                   	inc    %edx
  5d:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
  60:	0f b6 02             	movzbl (%edx),%eax
  63:	84 c0                	test   %al,%al
  65:	74 11                	je     78 <strcmp+0x30>
    p++, q++;
  67:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
  69:	0f b6 0b             	movzbl (%ebx),%ecx
  6c:	38 c1                	cmp    %al,%cl
  6e:	74 ec                	je     5c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  70:	29 c8                	sub    %ecx,%eax
}
  72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  75:	c9                   	leave  
  76:	c3                   	ret    
  77:	90                   	nop
  return (uchar)*p - (uchar)*q;
  78:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  7c:	31 c0                	xor    %eax,%eax
  7e:	29 c8                	sub    %ecx,%eax
}
  80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  83:	c9                   	leave  
  84:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
  85:	0f b6 0b             	movzbl (%ebx),%ecx
  88:	31 c0                	xor    %eax,%eax
  8a:	eb e4                	jmp    70 <strcmp+0x28>

0000008c <strlen>:

uint
strlen(const char *s)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  92:	80 3a 00             	cmpb   $0x0,(%edx)
  95:	74 15                	je     ac <strlen+0x20>
  97:	31 c0                	xor    %eax,%eax
  99:	8d 76 00             	lea    0x0(%esi),%esi
  9c:	40                   	inc    %eax
  9d:	89 c1                	mov    %eax,%ecx
  9f:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  a3:	75 f7                	jne    9c <strlen+0x10>
    ;
  return n;
}
  a5:	89 c8                	mov    %ecx,%eax
  a7:	5d                   	pop    %ebp
  a8:	c3                   	ret    
  a9:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  ac:	31 c9                	xor    %ecx,%ecx
}
  ae:	89 c8                	mov    %ecx,%eax
  b0:	5d                   	pop    %ebp
  b1:	c3                   	ret    
  b2:	66 90                	xchg   %ax,%ax

000000b4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  b8:	8b 7d 08             	mov    0x8(%ebp),%edi
  bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  be:	8b 45 0c             	mov    0xc(%ebp),%eax
  c1:	fc                   	cld    
  c2:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  c4:	8b 45 08             	mov    0x8(%ebp),%eax
  c7:	8b 7d fc             	mov    -0x4(%ebp),%edi
  ca:	c9                   	leave  
  cb:	c3                   	ret    

000000cc <strchr>:

char*
strchr(const char *s, char c)
{
  cc:	55                   	push   %ebp
  cd:	89 e5                	mov    %esp,%ebp
  cf:	8b 45 08             	mov    0x8(%ebp),%eax
  d2:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
  d5:	8a 10                	mov    (%eax),%dl
  d7:	84 d2                	test   %dl,%dl
  d9:	75 0c                	jne    e7 <strchr+0x1b>
  db:	eb 13                	jmp    f0 <strchr+0x24>
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	40                   	inc    %eax
  e1:	8a 10                	mov    (%eax),%dl
  e3:	84 d2                	test   %dl,%dl
  e5:	74 09                	je     f0 <strchr+0x24>
    if(*s == c)
  e7:	38 d1                	cmp    %dl,%cl
  e9:	75 f5                	jne    e0 <strchr+0x14>
      return (char*)s;
  return 0;
}
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret    
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
  f0:	31 c0                	xor    %eax,%eax
}
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    

000000f4 <gets>:

char*
gets(char *buf, int max)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	57                   	push   %edi
  f8:	56                   	push   %esi
  f9:	53                   	push   %ebx
  fa:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  fd:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
  ff:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 102:	eb 24                	jmp    128 <gets+0x34>
    cc = read(0, &c, 1);
 104:	50                   	push   %eax
 105:	6a 01                	push   $0x1
 107:	57                   	push   %edi
 108:	6a 00                	push   $0x0
 10a:	e8 08 01 00 00       	call   217 <read>
    if(cc < 1)
 10f:	83 c4 10             	add    $0x10,%esp
 112:	85 c0                	test   %eax,%eax
 114:	7e 1c                	jle    132 <gets+0x3e>
      break;
    buf[i++] = c;
 116:	8a 45 e7             	mov    -0x19(%ebp),%al
 119:	8b 55 08             	mov    0x8(%ebp),%edx
 11c:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 120:	3c 0a                	cmp    $0xa,%al
 122:	74 20                	je     144 <gets+0x50>
 124:	3c 0d                	cmp    $0xd,%al
 126:	74 1c                	je     144 <gets+0x50>
  for(i=0; i+1 < max; ){
 128:	89 de                	mov    %ebx,%esi
 12a:	8d 5b 01             	lea    0x1(%ebx),%ebx
 12d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 130:	7c d2                	jl     104 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 132:	8b 45 08             	mov    0x8(%ebp),%eax
 135:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 139:	8d 65 f4             	lea    -0xc(%ebp),%esp
 13c:	5b                   	pop    %ebx
 13d:	5e                   	pop    %esi
 13e:	5f                   	pop    %edi
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret    
 141:	8d 76 00             	lea    0x0(%esi),%esi
 144:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 146:	8b 45 08             	mov    0x8(%ebp),%eax
 149:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 14d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 150:	5b                   	pop    %ebx
 151:	5e                   	pop    %esi
 152:	5f                   	pop    %edi
 153:	5d                   	pop    %ebp
 154:	c3                   	ret    
 155:	8d 76 00             	lea    0x0(%esi),%esi

00000158 <stat>:

int
stat(const char *n, struct stat *st)
{
 158:	55                   	push   %ebp
 159:	89 e5                	mov    %esp,%ebp
 15b:	56                   	push   %esi
 15c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 15d:	83 ec 08             	sub    $0x8,%esp
 160:	6a 00                	push   $0x0
 162:	ff 75 08             	push   0x8(%ebp)
 165:	e8 d5 00 00 00       	call   23f <open>
  if(fd < 0)
 16a:	83 c4 10             	add    $0x10,%esp
 16d:	85 c0                	test   %eax,%eax
 16f:	78 27                	js     198 <stat+0x40>
 171:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 173:	83 ec 08             	sub    $0x8,%esp
 176:	ff 75 0c             	push   0xc(%ebp)
 179:	50                   	push   %eax
 17a:	e8 d8 00 00 00       	call   257 <fstat>
 17f:	89 c6                	mov    %eax,%esi
  close(fd);
 181:	89 1c 24             	mov    %ebx,(%esp)
 184:	e8 9e 00 00 00       	call   227 <close>
  return r;
 189:	83 c4 10             	add    $0x10,%esp
}
 18c:	89 f0                	mov    %esi,%eax
 18e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 191:	5b                   	pop    %ebx
 192:	5e                   	pop    %esi
 193:	5d                   	pop    %ebp
 194:	c3                   	ret    
 195:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 198:	be ff ff ff ff       	mov    $0xffffffff,%esi
 19d:	eb ed                	jmp    18c <stat+0x34>
 19f:	90                   	nop

000001a0 <atoi>:

int
atoi(const char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	53                   	push   %ebx
 1a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1a7:	0f be 01             	movsbl (%ecx),%eax
 1aa:	8d 50 d0             	lea    -0x30(%eax),%edx
 1ad:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 1b0:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1b5:	77 16                	ja     1cd <atoi+0x2d>
 1b7:	90                   	nop
    n = n*10 + *s++ - '0';
 1b8:	41                   	inc    %ecx
 1b9:	8d 14 92             	lea    (%edx,%edx,4),%edx
 1bc:	01 d2                	add    %edx,%edx
 1be:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 1c2:	0f be 01             	movsbl (%ecx),%eax
 1c5:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1c8:	80 fb 09             	cmp    $0x9,%bl
 1cb:	76 eb                	jbe    1b8 <atoi+0x18>
  return n;
}
 1cd:	89 d0                	mov    %edx,%eax
 1cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1d2:	c9                   	leave  
 1d3:	c3                   	ret    

000001d4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	57                   	push   %edi
 1d8:	56                   	push   %esi
 1d9:	8b 55 08             	mov    0x8(%ebp),%edx
 1dc:	8b 75 0c             	mov    0xc(%ebp),%esi
 1df:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1e2:	85 c0                	test   %eax,%eax
 1e4:	7e 0b                	jle    1f1 <memmove+0x1d>
 1e6:	01 d0                	add    %edx,%eax
  dst = vdst;
 1e8:	89 d7                	mov    %edx,%edi
 1ea:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 1ec:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 1ed:	39 f8                	cmp    %edi,%eax
 1ef:	75 fb                	jne    1ec <memmove+0x18>
  return vdst;
}
 1f1:	89 d0                	mov    %edx,%eax
 1f3:	5e                   	pop    %esi
 1f4:	5f                   	pop    %edi
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    

000001f7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1f7:	b8 01 00 00 00       	mov    $0x1,%eax
 1fc:	cd 40                	int    $0x40
 1fe:	c3                   	ret    

000001ff <exit>:
SYSCALL(exit)
 1ff:	b8 02 00 00 00       	mov    $0x2,%eax
 204:	cd 40                	int    $0x40
 206:	c3                   	ret    

00000207 <wait>:
SYSCALL(wait)
 207:	b8 03 00 00 00       	mov    $0x3,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <pipe>:
SYSCALL(pipe)
 20f:	b8 04 00 00 00       	mov    $0x4,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <read>:
SYSCALL(read)
 217:	b8 05 00 00 00       	mov    $0x5,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <write>:
SYSCALL(write)
 21f:	b8 10 00 00 00       	mov    $0x10,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <close>:
SYSCALL(close)
 227:	b8 15 00 00 00       	mov    $0x15,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <kill>:
SYSCALL(kill)
 22f:	b8 06 00 00 00       	mov    $0x6,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <exec>:
SYSCALL(exec)
 237:	b8 07 00 00 00       	mov    $0x7,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <open>:
SYSCALL(open)
 23f:	b8 0f 00 00 00       	mov    $0xf,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <mknod>:
SYSCALL(mknod)
 247:	b8 11 00 00 00       	mov    $0x11,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <unlink>:
SYSCALL(unlink)
 24f:	b8 12 00 00 00       	mov    $0x12,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <fstat>:
SYSCALL(fstat)
 257:	b8 08 00 00 00       	mov    $0x8,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <link>:
SYSCALL(link)
 25f:	b8 13 00 00 00       	mov    $0x13,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <mkdir>:
SYSCALL(mkdir)
 267:	b8 14 00 00 00       	mov    $0x14,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <chdir>:
SYSCALL(chdir)
 26f:	b8 09 00 00 00       	mov    $0x9,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <dup>:
SYSCALL(dup)
 277:	b8 0a 00 00 00       	mov    $0xa,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <getpid>:
SYSCALL(getpid)
 27f:	b8 0b 00 00 00       	mov    $0xb,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <sbrk>:
SYSCALL(sbrk)
 287:	b8 0c 00 00 00       	mov    $0xc,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <sleep>:
SYSCALL(sleep)
 28f:	b8 0d 00 00 00       	mov    $0xd,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <uptime>:
SYSCALL(uptime)
 297:	b8 0e 00 00 00       	mov    $0xe,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <getprocs>:
SYSCALL(getprocs)
 29f:	b8 16 00 00 00       	mov    $0x16,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    
 2a7:	90                   	nop

000002a8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2a8:	55                   	push   %ebp
 2a9:	89 e5                	mov    %esp,%ebp
 2ab:	57                   	push   %edi
 2ac:	56                   	push   %esi
 2ad:	53                   	push   %ebx
 2ae:	83 ec 3c             	sub    $0x3c,%esp
 2b1:	89 45 bc             	mov    %eax,-0x44(%ebp)
 2b4:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2b7:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
 2b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2bc:	85 db                	test   %ebx,%ebx
 2be:	74 04                	je     2c4 <printint+0x1c>
 2c0:	85 d2                	test   %edx,%edx
 2c2:	78 68                	js     32c <printint+0x84>
  neg = 0;
 2c4:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2cb:	31 ff                	xor    %edi,%edi
 2cd:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 2d0:	89 c8                	mov    %ecx,%eax
 2d2:	31 d2                	xor    %edx,%edx
 2d4:	f7 75 c4             	divl   -0x3c(%ebp)
 2d7:	89 fb                	mov    %edi,%ebx
 2d9:	8d 7f 01             	lea    0x1(%edi),%edi
 2dc:	8a 92 ac 06 00 00    	mov    0x6ac(%edx),%dl
 2e2:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 2e6:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 2e9:	89 c1                	mov    %eax,%ecx
 2eb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 2ee:	3b 45 c0             	cmp    -0x40(%ebp),%eax
 2f1:	76 dd                	jbe    2d0 <printint+0x28>
  if(neg)
 2f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2f6:	85 c9                	test   %ecx,%ecx
 2f8:	74 09                	je     303 <printint+0x5b>
    buf[i++] = '-';
 2fa:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
 2ff:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
 301:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
 303:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 307:	8b 7d bc             	mov    -0x44(%ebp),%edi
 30a:	eb 03                	jmp    30f <printint+0x67>
    putc(fd, buf[i]);
 30c:	8a 13                	mov    (%ebx),%dl
 30e:	4b                   	dec    %ebx
 30f:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
 312:	50                   	push   %eax
 313:	6a 01                	push   $0x1
 315:	56                   	push   %esi
 316:	57                   	push   %edi
 317:	e8 03 ff ff ff       	call   21f <write>
  while(--i >= 0)
 31c:	83 c4 10             	add    $0x10,%esp
 31f:	39 de                	cmp    %ebx,%esi
 321:	75 e9                	jne    30c <printint+0x64>
}
 323:	8d 65 f4             	lea    -0xc(%ebp),%esp
 326:	5b                   	pop    %ebx
 327:	5e                   	pop    %esi
 328:	5f                   	pop    %edi
 329:	5d                   	pop    %ebp
 32a:	c3                   	ret    
 32b:	90                   	nop
    x = -xx;
 32c:	f7 d9                	neg    %ecx
 32e:	eb 9b                	jmp    2cb <printint+0x23>

00000330 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	53                   	push   %ebx
 336:	83 ec 2c             	sub    $0x2c,%esp
 339:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 33c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 33f:	8a 13                	mov    (%ebx),%dl
 341:	84 d2                	test   %dl,%dl
 343:	74 64                	je     3a9 <printf+0x79>
 345:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 346:	8d 45 10             	lea    0x10(%ebp),%eax
 349:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
 34c:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
 34e:	8d 7d e7             	lea    -0x19(%ebp),%edi
 351:	eb 24                	jmp    377 <printf+0x47>
 353:	90                   	nop
 354:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 357:	83 f8 25             	cmp    $0x25,%eax
 35a:	74 40                	je     39c <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
 35c:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 35f:	50                   	push   %eax
 360:	6a 01                	push   $0x1
 362:	57                   	push   %edi
 363:	56                   	push   %esi
 364:	e8 b6 fe ff ff       	call   21f <write>
        putc(fd, c);
 369:	83 c4 10             	add    $0x10,%esp
 36c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
 36f:	43                   	inc    %ebx
 370:	8a 53 ff             	mov    -0x1(%ebx),%dl
 373:	84 d2                	test   %dl,%dl
 375:	74 32                	je     3a9 <printf+0x79>
    c = fmt[i] & 0xff;
 377:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 37a:	85 c9                	test   %ecx,%ecx
 37c:	74 d6                	je     354 <printf+0x24>
      }
    } else if(state == '%'){
 37e:	83 f9 25             	cmp    $0x25,%ecx
 381:	75 ec                	jne    36f <printf+0x3f>
      if(c == 'd'){
 383:	83 f8 25             	cmp    $0x25,%eax
 386:	0f 84 e4 00 00 00    	je     470 <printf+0x140>
 38c:	83 e8 63             	sub    $0x63,%eax
 38f:	83 f8 15             	cmp    $0x15,%eax
 392:	77 20                	ja     3b4 <printf+0x84>
 394:	ff 24 85 54 06 00 00 	jmp    *0x654(,%eax,4)
 39b:	90                   	nop
        state = '%';
 39c:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
 3a1:	43                   	inc    %ebx
 3a2:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3a5:	84 d2                	test   %dl,%dl
 3a7:	75 ce                	jne    377 <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ac:	5b                   	pop    %ebx
 3ad:	5e                   	pop    %esi
 3ae:	5f                   	pop    %edi
 3af:	5d                   	pop    %ebp
 3b0:	c3                   	ret    
 3b1:	8d 76 00             	lea    0x0(%esi),%esi
 3b4:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
 3b7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3bb:	50                   	push   %eax
 3bc:	6a 01                	push   $0x1
 3be:	57                   	push   %edi
 3bf:	56                   	push   %esi
 3c0:	e8 5a fe ff ff       	call   21f <write>
        putc(fd, c);
 3c5:	8a 55 d4             	mov    -0x2c(%ebp),%dl
 3c8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 3cb:	83 c4 0c             	add    $0xc,%esp
 3ce:	6a 01                	push   $0x1
 3d0:	57                   	push   %edi
 3d1:	56                   	push   %esi
 3d2:	e8 48 fe ff ff       	call   21f <write>
        putc(fd, c);
 3d7:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3da:	31 c9                	xor    %ecx,%ecx
 3dc:	eb 91                	jmp    36f <printf+0x3f>
 3de:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 3e0:	83 ec 0c             	sub    $0xc,%esp
 3e3:	6a 00                	push   $0x0
 3e5:	b9 10 00 00 00       	mov    $0x10,%ecx
 3ea:	8b 45 d0             	mov    -0x30(%ebp),%eax
 3ed:	8b 10                	mov    (%eax),%edx
 3ef:	89 f0                	mov    %esi,%eax
 3f1:	e8 b2 fe ff ff       	call   2a8 <printint>
        ap++;
 3f6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 3fa:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3fd:	31 c9                	xor    %ecx,%ecx
        ap++;
 3ff:	e9 6b ff ff ff       	jmp    36f <printf+0x3f>
        s = (char*)*ap;
 404:	8b 45 d0             	mov    -0x30(%ebp),%eax
 407:	8b 10                	mov    (%eax),%edx
        ap++;
 409:	83 c0 04             	add    $0x4,%eax
 40c:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 40f:	85 d2                	test   %edx,%edx
 411:	74 69                	je     47c <printf+0x14c>
        while(*s != 0){
 413:	8a 02                	mov    (%edx),%al
 415:	84 c0                	test   %al,%al
 417:	74 71                	je     48a <printf+0x15a>
 419:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 41c:	89 d3                	mov    %edx,%ebx
 41e:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
 420:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 423:	50                   	push   %eax
 424:	6a 01                	push   $0x1
 426:	57                   	push   %edi
 427:	56                   	push   %esi
 428:	e8 f2 fd ff ff       	call   21f <write>
          s++;
 42d:	43                   	inc    %ebx
        while(*s != 0){
 42e:	8a 03                	mov    (%ebx),%al
 430:	83 c4 10             	add    $0x10,%esp
 433:	84 c0                	test   %al,%al
 435:	75 e9                	jne    420 <printf+0xf0>
      state = 0;
 437:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 43a:	31 c9                	xor    %ecx,%ecx
 43c:	e9 2e ff ff ff       	jmp    36f <printf+0x3f>
 441:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 444:	83 ec 0c             	sub    $0xc,%esp
 447:	6a 01                	push   $0x1
 449:	b9 0a 00 00 00       	mov    $0xa,%ecx
 44e:	eb 9a                	jmp    3ea <printf+0xba>
        putc(fd, *ap);
 450:	8b 45 d0             	mov    -0x30(%ebp),%eax
 453:	8b 00                	mov    (%eax),%eax
 455:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 458:	51                   	push   %ecx
 459:	6a 01                	push   $0x1
 45b:	57                   	push   %edi
 45c:	56                   	push   %esi
 45d:	e8 bd fd ff ff       	call   21f <write>
        ap++;
 462:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 466:	83 c4 10             	add    $0x10,%esp
      state = 0;
 469:	31 c9                	xor    %ecx,%ecx
 46b:	e9 ff fe ff ff       	jmp    36f <printf+0x3f>
        putc(fd, c);
 470:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 473:	52                   	push   %edx
 474:	e9 55 ff ff ff       	jmp    3ce <printf+0x9e>
 479:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
 47c:	ba 4b 06 00 00       	mov    $0x64b,%edx
        while(*s != 0){
 481:	b0 28                	mov    $0x28,%al
 483:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 486:	89 d3                	mov    %edx,%ebx
 488:	eb 96                	jmp    420 <printf+0xf0>
      state = 0;
 48a:	31 c9                	xor    %ecx,%ecx
 48c:	e9 de fe ff ff       	jmp    36f <printf+0x3f>
 491:	66 90                	xchg   %ax,%ax
 493:	90                   	nop

00000494 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 494:	55                   	push   %ebp
 495:	89 e5                	mov    %esp,%ebp
 497:	57                   	push   %edi
 498:	56                   	push   %esi
 499:	53                   	push   %ebx
 49a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 49d:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4a0:	a1 c0 06 00 00       	mov    0x6c0,%eax
 4a5:	8d 76 00             	lea    0x0(%esi),%esi
 4a8:	89 c2                	mov    %eax,%edx
 4aa:	8b 00                	mov    (%eax),%eax
 4ac:	39 ca                	cmp    %ecx,%edx
 4ae:	73 2c                	jae    4dc <free+0x48>
 4b0:	39 c1                	cmp    %eax,%ecx
 4b2:	72 04                	jb     4b8 <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4b4:	39 c2                	cmp    %eax,%edx
 4b6:	72 f0                	jb     4a8 <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4be:	39 f8                	cmp    %edi,%eax
 4c0:	74 2c                	je     4ee <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 4c2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4c5:	8b 42 04             	mov    0x4(%edx),%eax
 4c8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 4cb:	39 f1                	cmp    %esi,%ecx
 4cd:	74 36                	je     505 <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 4cf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
 4d1:	89 15 c0 06 00 00    	mov    %edx,0x6c0
}
 4d7:	5b                   	pop    %ebx
 4d8:	5e                   	pop    %esi
 4d9:	5f                   	pop    %edi
 4da:	5d                   	pop    %ebp
 4db:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4dc:	39 c2                	cmp    %eax,%edx
 4de:	72 c8                	jb     4a8 <free+0x14>
 4e0:	39 c1                	cmp    %eax,%ecx
 4e2:	73 c4                	jae    4a8 <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
 4e4:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4e7:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4ea:	39 f8                	cmp    %edi,%eax
 4ec:	75 d4                	jne    4c2 <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
 4ee:	03 70 04             	add    0x4(%eax),%esi
 4f1:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 4f4:	8b 02                	mov    (%edx),%eax
 4f6:	8b 00                	mov    (%eax),%eax
 4f8:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 4fb:	8b 42 04             	mov    0x4(%edx),%eax
 4fe:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 501:	39 f1                	cmp    %esi,%ecx
 503:	75 ca                	jne    4cf <free+0x3b>
    p->s.size += bp->s.size;
 505:	03 43 fc             	add    -0x4(%ebx),%eax
 508:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 50b:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 50e:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 510:	89 15 c0 06 00 00    	mov    %edx,0x6c0
}
 516:	5b                   	pop    %ebx
 517:	5e                   	pop    %esi
 518:	5f                   	pop    %edi
 519:	5d                   	pop    %ebp
 51a:	c3                   	ret    
 51b:	90                   	nop

0000051c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 51c:	55                   	push   %ebp
 51d:	89 e5                	mov    %esp,%ebp
 51f:	57                   	push   %edi
 520:	56                   	push   %esi
 521:	53                   	push   %ebx
 522:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 525:	8b 45 08             	mov    0x8(%ebp),%eax
 528:	8d 70 07             	lea    0x7(%eax),%esi
 52b:	c1 ee 03             	shr    $0x3,%esi
 52e:	46                   	inc    %esi
  if((prevp = freep) == 0){
 52f:	8b 3d c0 06 00 00    	mov    0x6c0,%edi
 535:	85 ff                	test   %edi,%edi
 537:	0f 84 a3 00 00 00    	je     5e0 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 53d:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 53f:	8b 4a 04             	mov    0x4(%edx),%ecx
 542:	39 f1                	cmp    %esi,%ecx
 544:	73 68                	jae    5ae <malloc+0x92>
 546:	89 f3                	mov    %esi,%ebx
 548:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 54e:	0f 82 80 00 00 00    	jb     5d4 <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
 554:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 55b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 55e:	eb 11                	jmp    571 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 560:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 562:	8b 48 04             	mov    0x4(%eax),%ecx
 565:	39 f1                	cmp    %esi,%ecx
 567:	73 4b                	jae    5b4 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 569:	8b 3d c0 06 00 00    	mov    0x6c0,%edi
 56f:	89 c2                	mov    %eax,%edx
 571:	39 d7                	cmp    %edx,%edi
 573:	75 eb                	jne    560 <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
 575:	83 ec 0c             	sub    $0xc,%esp
 578:	ff 75 e4             	push   -0x1c(%ebp)
 57b:	e8 07 fd ff ff       	call   287 <sbrk>
  if(p == (char*)-1)
 580:	83 c4 10             	add    $0x10,%esp
 583:	83 f8 ff             	cmp    $0xffffffff,%eax
 586:	74 1c                	je     5a4 <malloc+0x88>
  hp->s.size = nu;
 588:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 58b:	83 ec 0c             	sub    $0xc,%esp
 58e:	83 c0 08             	add    $0x8,%eax
 591:	50                   	push   %eax
 592:	e8 fd fe ff ff       	call   494 <free>
  return freep;
 597:	8b 15 c0 06 00 00    	mov    0x6c0,%edx
      if((p = morecore(nunits)) == 0)
 59d:	83 c4 10             	add    $0x10,%esp
 5a0:	85 d2                	test   %edx,%edx
 5a2:	75 bc                	jne    560 <malloc+0x44>
        return 0;
 5a4:	31 c0                	xor    %eax,%eax
  }
}
 5a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5a9:	5b                   	pop    %ebx
 5aa:	5e                   	pop    %esi
 5ab:	5f                   	pop    %edi
 5ac:	5d                   	pop    %ebp
 5ad:	c3                   	ret    
    if(p->s.size >= nunits){
 5ae:	89 d0                	mov    %edx,%eax
 5b0:	89 fa                	mov    %edi,%edx
 5b2:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 5b4:	39 ce                	cmp    %ecx,%esi
 5b6:	74 54                	je     60c <malloc+0xf0>
        p->s.size -= nunits;
 5b8:	29 f1                	sub    %esi,%ecx
 5ba:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5bd:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5c0:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 5c3:	89 15 c0 06 00 00    	mov    %edx,0x6c0
      return (void*)(p + 1);
 5c9:	83 c0 08             	add    $0x8,%eax
}
 5cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5cf:	5b                   	pop    %ebx
 5d0:	5e                   	pop    %esi
 5d1:	5f                   	pop    %edi
 5d2:	5d                   	pop    %ebp
 5d3:	c3                   	ret    
 5d4:	bb 00 10 00 00       	mov    $0x1000,%ebx
 5d9:	e9 76 ff ff ff       	jmp    554 <malloc+0x38>
 5de:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 5e0:	c7 05 c0 06 00 00 c4 	movl   $0x6c4,0x6c0
 5e7:	06 00 00 
 5ea:	c7 05 c4 06 00 00 c4 	movl   $0x6c4,0x6c4
 5f1:	06 00 00 
    base.s.size = 0;
 5f4:	c7 05 c8 06 00 00 00 	movl   $0x0,0x6c8
 5fb:	00 00 00 
 5fe:	bf c4 06 00 00       	mov    $0x6c4,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 603:	89 fa                	mov    %edi,%edx
 605:	e9 3c ff ff ff       	jmp    546 <malloc+0x2a>
 60a:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 60c:	8b 08                	mov    (%eax),%ecx
 60e:	89 0a                	mov    %ecx,(%edx)
 610:	eb b1                	jmp    5c3 <malloc+0xa7>
