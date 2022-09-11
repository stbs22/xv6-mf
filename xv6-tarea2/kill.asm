
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 26                	jle    44 <main+0x44>
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  1e:	bb 01 00 00 00       	mov    $0x1,%ebx
  23:	90                   	nop
    kill(atoi(argv[i]));
  24:	83 ec 0c             	sub    $0xc,%esp
  27:	ff 34 9f             	push   (%edi,%ebx,4)
  2a:	e8 a1 01 00 00       	call   1d0 <atoi>
  2f:	89 04 24             	mov    %eax,(%esp)
  32:	e8 28 02 00 00       	call   25f <kill>
  for(i=1; i<argc; i++)
  37:	43                   	inc    %ebx
  38:	83 c4 10             	add    $0x10,%esp
  3b:	39 de                	cmp    %ebx,%esi
  3d:	75 e5                	jne    24 <main+0x24>
  exit();
  3f:	e8 eb 01 00 00       	call   22f <exit>
    printf(2, "usage: kill pid...\n");
  44:	50                   	push   %eax
  45:	50                   	push   %eax
  46:	68 44 06 00 00       	push   $0x644
  4b:	6a 02                	push   $0x2
  4d:	e8 0e 03 00 00       	call   360 <printf>
    exit();
  52:	e8 d8 01 00 00       	call   22f <exit>
  57:	90                   	nop

00000058 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  58:	55                   	push   %ebp
  59:	89 e5                	mov    %esp,%ebp
  5b:	53                   	push   %ebx
  5c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  5f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  62:	31 c0                	xor    %eax,%eax
  64:	8a 14 03             	mov    (%ebx,%eax,1),%dl
  67:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  6a:	40                   	inc    %eax
  6b:	84 d2                	test   %dl,%dl
  6d:	75 f5                	jne    64 <strcpy+0xc>
    ;
  return os;
}
  6f:	89 c8                	mov    %ecx,%eax
  71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  74:	c9                   	leave  
  75:	c3                   	ret    
  76:	66 90                	xchg   %ax,%ax

00000078 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  78:	55                   	push   %ebp
  79:	89 e5                	mov    %esp,%ebp
  7b:	53                   	push   %ebx
  7c:	8b 55 08             	mov    0x8(%ebp),%edx
  7f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  82:	0f b6 02             	movzbl (%edx),%eax
  85:	84 c0                	test   %al,%al
  87:	75 10                	jne    99 <strcmp+0x21>
  89:	eb 2a                	jmp    b5 <strcmp+0x3d>
  8b:	90                   	nop
    p++, q++;
  8c:	42                   	inc    %edx
  8d:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
  90:	0f b6 02             	movzbl (%edx),%eax
  93:	84 c0                	test   %al,%al
  95:	74 11                	je     a8 <strcmp+0x30>
    p++, q++;
  97:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
  99:	0f b6 0b             	movzbl (%ebx),%ecx
  9c:	38 c1                	cmp    %al,%cl
  9e:	74 ec                	je     8c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  a0:	29 c8                	sub    %ecx,%eax
}
  a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  a5:	c9                   	leave  
  a6:	c3                   	ret    
  a7:	90                   	nop
  return (uchar)*p - (uchar)*q;
  a8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  ac:	31 c0                	xor    %eax,%eax
  ae:	29 c8                	sub    %ecx,%eax
}
  b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b3:	c9                   	leave  
  b4:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
  b5:	0f b6 0b             	movzbl (%ebx),%ecx
  b8:	31 c0                	xor    %eax,%eax
  ba:	eb e4                	jmp    a0 <strcmp+0x28>

000000bc <strlen>:

uint
strlen(const char *s)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  bf:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  c2:	80 3a 00             	cmpb   $0x0,(%edx)
  c5:	74 15                	je     dc <strlen+0x20>
  c7:	31 c0                	xor    %eax,%eax
  c9:	8d 76 00             	lea    0x0(%esi),%esi
  cc:	40                   	inc    %eax
  cd:	89 c1                	mov    %eax,%ecx
  cf:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  d3:	75 f7                	jne    cc <strlen+0x10>
    ;
  return n;
}
  d5:	89 c8                	mov    %ecx,%eax
  d7:	5d                   	pop    %ebp
  d8:	c3                   	ret    
  d9:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  dc:	31 c9                	xor    %ecx,%ecx
}
  de:	89 c8                	mov    %ecx,%eax
  e0:	5d                   	pop    %ebp
  e1:	c3                   	ret    
  e2:	66 90                	xchg   %ax,%ax

000000e4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  e7:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e8:	8b 7d 08             	mov    0x8(%ebp),%edi
  eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  f1:	fc                   	cld    
  f2:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	8b 7d fc             	mov    -0x4(%ebp),%edi
  fa:	c9                   	leave  
  fb:	c3                   	ret    

000000fc <strchr>:

char*
strchr(const char *s, char c)
{
  fc:	55                   	push   %ebp
  fd:	89 e5                	mov    %esp,%ebp
  ff:	8b 45 08             	mov    0x8(%ebp),%eax
 102:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 105:	8a 10                	mov    (%eax),%dl
 107:	84 d2                	test   %dl,%dl
 109:	75 0c                	jne    117 <strchr+0x1b>
 10b:	eb 13                	jmp    120 <strchr+0x24>
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	40                   	inc    %eax
 111:	8a 10                	mov    (%eax),%dl
 113:	84 d2                	test   %dl,%dl
 115:	74 09                	je     120 <strchr+0x24>
    if(*s == c)
 117:	38 d1                	cmp    %dl,%cl
 119:	75 f5                	jne    110 <strchr+0x14>
      return (char*)s;
  return 0;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 120:	31 c0                	xor    %eax,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    

00000124 <gets>:

char*
gets(char *buf, int max)
{
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	57                   	push   %edi
 128:	56                   	push   %esi
 129:	53                   	push   %ebx
 12a:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12d:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 12f:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 132:	eb 24                	jmp    158 <gets+0x34>
    cc = read(0, &c, 1);
 134:	50                   	push   %eax
 135:	6a 01                	push   $0x1
 137:	57                   	push   %edi
 138:	6a 00                	push   $0x0
 13a:	e8 08 01 00 00       	call   247 <read>
    if(cc < 1)
 13f:	83 c4 10             	add    $0x10,%esp
 142:	85 c0                	test   %eax,%eax
 144:	7e 1c                	jle    162 <gets+0x3e>
      break;
    buf[i++] = c;
 146:	8a 45 e7             	mov    -0x19(%ebp),%al
 149:	8b 55 08             	mov    0x8(%ebp),%edx
 14c:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 150:	3c 0a                	cmp    $0xa,%al
 152:	74 20                	je     174 <gets+0x50>
 154:	3c 0d                	cmp    $0xd,%al
 156:	74 1c                	je     174 <gets+0x50>
  for(i=0; i+1 < max; ){
 158:	89 de                	mov    %ebx,%esi
 15a:	8d 5b 01             	lea    0x1(%ebx),%ebx
 15d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 160:	7c d2                	jl     134 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 162:	8b 45 08             	mov    0x8(%ebp),%eax
 165:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 169:	8d 65 f4             	lea    -0xc(%ebp),%esp
 16c:	5b                   	pop    %ebx
 16d:	5e                   	pop    %esi
 16e:	5f                   	pop    %edi
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret    
 171:	8d 76 00             	lea    0x0(%esi),%esi
 174:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 17d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 180:	5b                   	pop    %ebx
 181:	5e                   	pop    %esi
 182:	5f                   	pop    %edi
 183:	5d                   	pop    %ebp
 184:	c3                   	ret    
 185:	8d 76 00             	lea    0x0(%esi),%esi

00000188 <stat>:

int
stat(const char *n, struct stat *st)
{
 188:	55                   	push   %ebp
 189:	89 e5                	mov    %esp,%ebp
 18b:	56                   	push   %esi
 18c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18d:	83 ec 08             	sub    $0x8,%esp
 190:	6a 00                	push   $0x0
 192:	ff 75 08             	push   0x8(%ebp)
 195:	e8 d5 00 00 00       	call   26f <open>
  if(fd < 0)
 19a:	83 c4 10             	add    $0x10,%esp
 19d:	85 c0                	test   %eax,%eax
 19f:	78 27                	js     1c8 <stat+0x40>
 1a1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1a3:	83 ec 08             	sub    $0x8,%esp
 1a6:	ff 75 0c             	push   0xc(%ebp)
 1a9:	50                   	push   %eax
 1aa:	e8 d8 00 00 00       	call   287 <fstat>
 1af:	89 c6                	mov    %eax,%esi
  close(fd);
 1b1:	89 1c 24             	mov    %ebx,(%esp)
 1b4:	e8 9e 00 00 00       	call   257 <close>
  return r;
 1b9:	83 c4 10             	add    $0x10,%esp
}
 1bc:	89 f0                	mov    %esi,%eax
 1be:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c1:	5b                   	pop    %ebx
 1c2:	5e                   	pop    %esi
 1c3:	5d                   	pop    %ebp
 1c4:	c3                   	ret    
 1c5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1c8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1cd:	eb ed                	jmp    1bc <stat+0x34>
 1cf:	90                   	nop

000001d0 <atoi>:

int
atoi(const char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d7:	0f be 01             	movsbl (%ecx),%eax
 1da:	8d 50 d0             	lea    -0x30(%eax),%edx
 1dd:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 1e0:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1e5:	77 16                	ja     1fd <atoi+0x2d>
 1e7:	90                   	nop
    n = n*10 + *s++ - '0';
 1e8:	41                   	inc    %ecx
 1e9:	8d 14 92             	lea    (%edx,%edx,4),%edx
 1ec:	01 d2                	add    %edx,%edx
 1ee:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 1f2:	0f be 01             	movsbl (%ecx),%eax
 1f5:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1f8:	80 fb 09             	cmp    $0x9,%bl
 1fb:	76 eb                	jbe    1e8 <atoi+0x18>
  return n;
}
 1fd:	89 d0                	mov    %edx,%eax
 1ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 202:	c9                   	leave  
 203:	c3                   	ret    

00000204 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	57                   	push   %edi
 208:	56                   	push   %esi
 209:	8b 55 08             	mov    0x8(%ebp),%edx
 20c:	8b 75 0c             	mov    0xc(%ebp),%esi
 20f:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 212:	85 c0                	test   %eax,%eax
 214:	7e 0b                	jle    221 <memmove+0x1d>
 216:	01 d0                	add    %edx,%eax
  dst = vdst;
 218:	89 d7                	mov    %edx,%edi
 21a:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 21c:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 21d:	39 f8                	cmp    %edi,%eax
 21f:	75 fb                	jne    21c <memmove+0x18>
  return vdst;
}
 221:	89 d0                	mov    %edx,%eax
 223:	5e                   	pop    %esi
 224:	5f                   	pop    %edi
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    

00000227 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 227:	b8 01 00 00 00       	mov    $0x1,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <exit>:
SYSCALL(exit)
 22f:	b8 02 00 00 00       	mov    $0x2,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <wait>:
SYSCALL(wait)
 237:	b8 03 00 00 00       	mov    $0x3,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <pipe>:
SYSCALL(pipe)
 23f:	b8 04 00 00 00       	mov    $0x4,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <read>:
SYSCALL(read)
 247:	b8 05 00 00 00       	mov    $0x5,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <write>:
SYSCALL(write)
 24f:	b8 10 00 00 00       	mov    $0x10,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <close>:
SYSCALL(close)
 257:	b8 15 00 00 00       	mov    $0x15,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <kill>:
SYSCALL(kill)
 25f:	b8 06 00 00 00       	mov    $0x6,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <exec>:
SYSCALL(exec)
 267:	b8 07 00 00 00       	mov    $0x7,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <open>:
SYSCALL(open)
 26f:	b8 0f 00 00 00       	mov    $0xf,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <mknod>:
SYSCALL(mknod)
 277:	b8 11 00 00 00       	mov    $0x11,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <unlink>:
SYSCALL(unlink)
 27f:	b8 12 00 00 00       	mov    $0x12,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <fstat>:
SYSCALL(fstat)
 287:	b8 08 00 00 00       	mov    $0x8,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <link>:
SYSCALL(link)
 28f:	b8 13 00 00 00       	mov    $0x13,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <mkdir>:
SYSCALL(mkdir)
 297:	b8 14 00 00 00       	mov    $0x14,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <chdir>:
SYSCALL(chdir)
 29f:	b8 09 00 00 00       	mov    $0x9,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <dup>:
SYSCALL(dup)
 2a7:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <getpid>:
SYSCALL(getpid)
 2af:	b8 0b 00 00 00       	mov    $0xb,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <sbrk>:
SYSCALL(sbrk)
 2b7:	b8 0c 00 00 00       	mov    $0xc,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <sleep>:
SYSCALL(sleep)
 2bf:	b8 0d 00 00 00       	mov    $0xd,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <uptime>:
SYSCALL(uptime)
 2c7:	b8 0e 00 00 00       	mov    $0xe,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <getprocs>:
SYSCALL(getprocs)
 2cf:	b8 16 00 00 00       	mov    $0x16,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    
 2d7:	90                   	nop

000002d8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2d8:	55                   	push   %ebp
 2d9:	89 e5                	mov    %esp,%ebp
 2db:	57                   	push   %edi
 2dc:	56                   	push   %esi
 2dd:	53                   	push   %ebx
 2de:	83 ec 3c             	sub    $0x3c,%esp
 2e1:	89 45 bc             	mov    %eax,-0x44(%ebp)
 2e4:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2e7:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
 2e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2ec:	85 db                	test   %ebx,%ebx
 2ee:	74 04                	je     2f4 <printint+0x1c>
 2f0:	85 d2                	test   %edx,%edx
 2f2:	78 68                	js     35c <printint+0x84>
  neg = 0;
 2f4:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2fb:	31 ff                	xor    %edi,%edi
 2fd:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 300:	89 c8                	mov    %ecx,%eax
 302:	31 d2                	xor    %edx,%edx
 304:	f7 75 c4             	divl   -0x3c(%ebp)
 307:	89 fb                	mov    %edi,%ebx
 309:	8d 7f 01             	lea    0x1(%edi),%edi
 30c:	8a 92 b8 06 00 00    	mov    0x6b8(%edx),%dl
 312:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 316:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 319:	89 c1                	mov    %eax,%ecx
 31b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 31e:	3b 45 c0             	cmp    -0x40(%ebp),%eax
 321:	76 dd                	jbe    300 <printint+0x28>
  if(neg)
 323:	8b 4d 08             	mov    0x8(%ebp),%ecx
 326:	85 c9                	test   %ecx,%ecx
 328:	74 09                	je     333 <printint+0x5b>
    buf[i++] = '-';
 32a:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
 32f:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
 331:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
 333:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 337:	8b 7d bc             	mov    -0x44(%ebp),%edi
 33a:	eb 03                	jmp    33f <printint+0x67>
    putc(fd, buf[i]);
 33c:	8a 13                	mov    (%ebx),%dl
 33e:	4b                   	dec    %ebx
 33f:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
 342:	50                   	push   %eax
 343:	6a 01                	push   $0x1
 345:	56                   	push   %esi
 346:	57                   	push   %edi
 347:	e8 03 ff ff ff       	call   24f <write>
  while(--i >= 0)
 34c:	83 c4 10             	add    $0x10,%esp
 34f:	39 de                	cmp    %ebx,%esi
 351:	75 e9                	jne    33c <printint+0x64>
}
 353:	8d 65 f4             	lea    -0xc(%ebp),%esp
 356:	5b                   	pop    %ebx
 357:	5e                   	pop    %esi
 358:	5f                   	pop    %edi
 359:	5d                   	pop    %ebp
 35a:	c3                   	ret    
 35b:	90                   	nop
    x = -xx;
 35c:	f7 d9                	neg    %ecx
 35e:	eb 9b                	jmp    2fb <printint+0x23>

00000360 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	83 ec 2c             	sub    $0x2c,%esp
 369:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 36c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 36f:	8a 13                	mov    (%ebx),%dl
 371:	84 d2                	test   %dl,%dl
 373:	74 64                	je     3d9 <printf+0x79>
 375:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 376:	8d 45 10             	lea    0x10(%ebp),%eax
 379:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
 37c:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
 37e:	8d 7d e7             	lea    -0x19(%ebp),%edi
 381:	eb 24                	jmp    3a7 <printf+0x47>
 383:	90                   	nop
 384:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 387:	83 f8 25             	cmp    $0x25,%eax
 38a:	74 40                	je     3cc <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
 38c:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 38f:	50                   	push   %eax
 390:	6a 01                	push   $0x1
 392:	57                   	push   %edi
 393:	56                   	push   %esi
 394:	e8 b6 fe ff ff       	call   24f <write>
        putc(fd, c);
 399:	83 c4 10             	add    $0x10,%esp
 39c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
 39f:	43                   	inc    %ebx
 3a0:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3a3:	84 d2                	test   %dl,%dl
 3a5:	74 32                	je     3d9 <printf+0x79>
    c = fmt[i] & 0xff;
 3a7:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 3aa:	85 c9                	test   %ecx,%ecx
 3ac:	74 d6                	je     384 <printf+0x24>
      }
    } else if(state == '%'){
 3ae:	83 f9 25             	cmp    $0x25,%ecx
 3b1:	75 ec                	jne    39f <printf+0x3f>
      if(c == 'd'){
 3b3:	83 f8 25             	cmp    $0x25,%eax
 3b6:	0f 84 e4 00 00 00    	je     4a0 <printf+0x140>
 3bc:	83 e8 63             	sub    $0x63,%eax
 3bf:	83 f8 15             	cmp    $0x15,%eax
 3c2:	77 20                	ja     3e4 <printf+0x84>
 3c4:	ff 24 85 60 06 00 00 	jmp    *0x660(,%eax,4)
 3cb:	90                   	nop
        state = '%';
 3cc:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
 3d1:	43                   	inc    %ebx
 3d2:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3d5:	84 d2                	test   %dl,%dl
 3d7:	75 ce                	jne    3a7 <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3dc:	5b                   	pop    %ebx
 3dd:	5e                   	pop    %esi
 3de:	5f                   	pop    %edi
 3df:	5d                   	pop    %ebp
 3e0:	c3                   	ret    
 3e1:	8d 76 00             	lea    0x0(%esi),%esi
 3e4:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
 3e7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3eb:	50                   	push   %eax
 3ec:	6a 01                	push   $0x1
 3ee:	57                   	push   %edi
 3ef:	56                   	push   %esi
 3f0:	e8 5a fe ff ff       	call   24f <write>
        putc(fd, c);
 3f5:	8a 55 d4             	mov    -0x2c(%ebp),%dl
 3f8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 3fb:	83 c4 0c             	add    $0xc,%esp
 3fe:	6a 01                	push   $0x1
 400:	57                   	push   %edi
 401:	56                   	push   %esi
 402:	e8 48 fe ff ff       	call   24f <write>
        putc(fd, c);
 407:	83 c4 10             	add    $0x10,%esp
      state = 0;
 40a:	31 c9                	xor    %ecx,%ecx
 40c:	eb 91                	jmp    39f <printf+0x3f>
 40e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 410:	83 ec 0c             	sub    $0xc,%esp
 413:	6a 00                	push   $0x0
 415:	b9 10 00 00 00       	mov    $0x10,%ecx
 41a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 41d:	8b 10                	mov    (%eax),%edx
 41f:	89 f0                	mov    %esi,%eax
 421:	e8 b2 fe ff ff       	call   2d8 <printint>
        ap++;
 426:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 42a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 42d:	31 c9                	xor    %ecx,%ecx
        ap++;
 42f:	e9 6b ff ff ff       	jmp    39f <printf+0x3f>
        s = (char*)*ap;
 434:	8b 45 d0             	mov    -0x30(%ebp),%eax
 437:	8b 10                	mov    (%eax),%edx
        ap++;
 439:	83 c0 04             	add    $0x4,%eax
 43c:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 43f:	85 d2                	test   %edx,%edx
 441:	74 69                	je     4ac <printf+0x14c>
        while(*s != 0){
 443:	8a 02                	mov    (%edx),%al
 445:	84 c0                	test   %al,%al
 447:	74 71                	je     4ba <printf+0x15a>
 449:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 44c:	89 d3                	mov    %edx,%ebx
 44e:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
 450:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 453:	50                   	push   %eax
 454:	6a 01                	push   $0x1
 456:	57                   	push   %edi
 457:	56                   	push   %esi
 458:	e8 f2 fd ff ff       	call   24f <write>
          s++;
 45d:	43                   	inc    %ebx
        while(*s != 0){
 45e:	8a 03                	mov    (%ebx),%al
 460:	83 c4 10             	add    $0x10,%esp
 463:	84 c0                	test   %al,%al
 465:	75 e9                	jne    450 <printf+0xf0>
      state = 0;
 467:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 46a:	31 c9                	xor    %ecx,%ecx
 46c:	e9 2e ff ff ff       	jmp    39f <printf+0x3f>
 471:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 474:	83 ec 0c             	sub    $0xc,%esp
 477:	6a 01                	push   $0x1
 479:	b9 0a 00 00 00       	mov    $0xa,%ecx
 47e:	eb 9a                	jmp    41a <printf+0xba>
        putc(fd, *ap);
 480:	8b 45 d0             	mov    -0x30(%ebp),%eax
 483:	8b 00                	mov    (%eax),%eax
 485:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 488:	51                   	push   %ecx
 489:	6a 01                	push   $0x1
 48b:	57                   	push   %edi
 48c:	56                   	push   %esi
 48d:	e8 bd fd ff ff       	call   24f <write>
        ap++;
 492:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 496:	83 c4 10             	add    $0x10,%esp
      state = 0;
 499:	31 c9                	xor    %ecx,%ecx
 49b:	e9 ff fe ff ff       	jmp    39f <printf+0x3f>
        putc(fd, c);
 4a0:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4a3:	52                   	push   %edx
 4a4:	e9 55 ff ff ff       	jmp    3fe <printf+0x9e>
 4a9:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
 4ac:	ba 58 06 00 00       	mov    $0x658,%edx
        while(*s != 0){
 4b1:	b0 28                	mov    $0x28,%al
 4b3:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 4b6:	89 d3                	mov    %edx,%ebx
 4b8:	eb 96                	jmp    450 <printf+0xf0>
      state = 0;
 4ba:	31 c9                	xor    %ecx,%ecx
 4bc:	e9 de fe ff ff       	jmp    39f <printf+0x3f>
 4c1:	66 90                	xchg   %ax,%ax
 4c3:	90                   	nop

000004c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4c4:	55                   	push   %ebp
 4c5:	89 e5                	mov    %esp,%ebp
 4c7:	57                   	push   %edi
 4c8:	56                   	push   %esi
 4c9:	53                   	push   %ebx
 4ca:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4cd:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4d0:	a1 cc 06 00 00       	mov    0x6cc,%eax
 4d5:	8d 76 00             	lea    0x0(%esi),%esi
 4d8:	89 c2                	mov    %eax,%edx
 4da:	8b 00                	mov    (%eax),%eax
 4dc:	39 ca                	cmp    %ecx,%edx
 4de:	73 2c                	jae    50c <free+0x48>
 4e0:	39 c1                	cmp    %eax,%ecx
 4e2:	72 04                	jb     4e8 <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4e4:	39 c2                	cmp    %eax,%edx
 4e6:	72 f0                	jb     4d8 <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4ee:	39 f8                	cmp    %edi,%eax
 4f0:	74 2c                	je     51e <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 4f2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4f5:	8b 42 04             	mov    0x4(%edx),%eax
 4f8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 4fb:	39 f1                	cmp    %esi,%ecx
 4fd:	74 36                	je     535 <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 4ff:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
 501:	89 15 cc 06 00 00    	mov    %edx,0x6cc
}
 507:	5b                   	pop    %ebx
 508:	5e                   	pop    %esi
 509:	5f                   	pop    %edi
 50a:	5d                   	pop    %ebp
 50b:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 50c:	39 c2                	cmp    %eax,%edx
 50e:	72 c8                	jb     4d8 <free+0x14>
 510:	39 c1                	cmp    %eax,%ecx
 512:	73 c4                	jae    4d8 <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
 514:	8b 73 fc             	mov    -0x4(%ebx),%esi
 517:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 51a:	39 f8                	cmp    %edi,%eax
 51c:	75 d4                	jne    4f2 <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
 51e:	03 70 04             	add    0x4(%eax),%esi
 521:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 524:	8b 02                	mov    (%edx),%eax
 526:	8b 00                	mov    (%eax),%eax
 528:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 52b:	8b 42 04             	mov    0x4(%edx),%eax
 52e:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 531:	39 f1                	cmp    %esi,%ecx
 533:	75 ca                	jne    4ff <free+0x3b>
    p->s.size += bp->s.size;
 535:	03 43 fc             	add    -0x4(%ebx),%eax
 538:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 53b:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 53e:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 540:	89 15 cc 06 00 00    	mov    %edx,0x6cc
}
 546:	5b                   	pop    %ebx
 547:	5e                   	pop    %esi
 548:	5f                   	pop    %edi
 549:	5d                   	pop    %ebp
 54a:	c3                   	ret    
 54b:	90                   	nop

0000054c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 54c:	55                   	push   %ebp
 54d:	89 e5                	mov    %esp,%ebp
 54f:	57                   	push   %edi
 550:	56                   	push   %esi
 551:	53                   	push   %ebx
 552:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 555:	8b 45 08             	mov    0x8(%ebp),%eax
 558:	8d 70 07             	lea    0x7(%eax),%esi
 55b:	c1 ee 03             	shr    $0x3,%esi
 55e:	46                   	inc    %esi
  if((prevp = freep) == 0){
 55f:	8b 3d cc 06 00 00    	mov    0x6cc,%edi
 565:	85 ff                	test   %edi,%edi
 567:	0f 84 a3 00 00 00    	je     610 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 56d:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 56f:	8b 4a 04             	mov    0x4(%edx),%ecx
 572:	39 f1                	cmp    %esi,%ecx
 574:	73 68                	jae    5de <malloc+0x92>
 576:	89 f3                	mov    %esi,%ebx
 578:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 57e:	0f 82 80 00 00 00    	jb     604 <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
 584:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 58b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 58e:	eb 11                	jmp    5a1 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 590:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 592:	8b 48 04             	mov    0x4(%eax),%ecx
 595:	39 f1                	cmp    %esi,%ecx
 597:	73 4b                	jae    5e4 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 599:	8b 3d cc 06 00 00    	mov    0x6cc,%edi
 59f:	89 c2                	mov    %eax,%edx
 5a1:	39 d7                	cmp    %edx,%edi
 5a3:	75 eb                	jne    590 <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
 5a5:	83 ec 0c             	sub    $0xc,%esp
 5a8:	ff 75 e4             	push   -0x1c(%ebp)
 5ab:	e8 07 fd ff ff       	call   2b7 <sbrk>
  if(p == (char*)-1)
 5b0:	83 c4 10             	add    $0x10,%esp
 5b3:	83 f8 ff             	cmp    $0xffffffff,%eax
 5b6:	74 1c                	je     5d4 <malloc+0x88>
  hp->s.size = nu;
 5b8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 5bb:	83 ec 0c             	sub    $0xc,%esp
 5be:	83 c0 08             	add    $0x8,%eax
 5c1:	50                   	push   %eax
 5c2:	e8 fd fe ff ff       	call   4c4 <free>
  return freep;
 5c7:	8b 15 cc 06 00 00    	mov    0x6cc,%edx
      if((p = morecore(nunits)) == 0)
 5cd:	83 c4 10             	add    $0x10,%esp
 5d0:	85 d2                	test   %edx,%edx
 5d2:	75 bc                	jne    590 <malloc+0x44>
        return 0;
 5d4:	31 c0                	xor    %eax,%eax
  }
}
 5d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5d9:	5b                   	pop    %ebx
 5da:	5e                   	pop    %esi
 5db:	5f                   	pop    %edi
 5dc:	5d                   	pop    %ebp
 5dd:	c3                   	ret    
    if(p->s.size >= nunits){
 5de:	89 d0                	mov    %edx,%eax
 5e0:	89 fa                	mov    %edi,%edx
 5e2:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 5e4:	39 ce                	cmp    %ecx,%esi
 5e6:	74 54                	je     63c <malloc+0xf0>
        p->s.size -= nunits;
 5e8:	29 f1                	sub    %esi,%ecx
 5ea:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5ed:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5f0:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 5f3:	89 15 cc 06 00 00    	mov    %edx,0x6cc
      return (void*)(p + 1);
 5f9:	83 c0 08             	add    $0x8,%eax
}
 5fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ff:	5b                   	pop    %ebx
 600:	5e                   	pop    %esi
 601:	5f                   	pop    %edi
 602:	5d                   	pop    %ebp
 603:	c3                   	ret    
 604:	bb 00 10 00 00       	mov    $0x1000,%ebx
 609:	e9 76 ff ff ff       	jmp    584 <malloc+0x38>
 60e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 610:	c7 05 cc 06 00 00 d0 	movl   $0x6d0,0x6cc
 617:	06 00 00 
 61a:	c7 05 d0 06 00 00 d0 	movl   $0x6d0,0x6d0
 621:	06 00 00 
    base.s.size = 0;
 624:	c7 05 d4 06 00 00 00 	movl   $0x0,0x6d4
 62b:	00 00 00 
 62e:	bf d0 06 00 00       	mov    $0x6d0,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 633:	89 fa                	mov    %edi,%edx
 635:	e9 3c ff ff ff       	jmp    576 <malloc+0x2a>
 63a:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 63c:	8b 08                	mov    (%eax),%ecx
 63e:	89 0a                	mov    %ecx,(%edx)
 640:	eb b1                	jmp    5f3 <malloc+0xa7>
