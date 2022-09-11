
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
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

  for(i = 1; i < argc; i++)
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 41                	jle    5f <main+0x5f>
  1e:	bb 01 00 00 00       	mov    $0x1,%ebx
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  23:	43                   	inc    %ebx
  24:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  28:	39 f3                	cmp    %esi,%ebx
  2a:	74 1e                	je     4a <main+0x4a>
  2c:	68 50 06 00 00       	push   $0x650
  31:	50                   	push   %eax
  32:	68 52 06 00 00       	push   $0x652
  37:	6a 01                	push   $0x1
  39:	e8 2e 03 00 00       	call   36c <printf>
  3e:	83 c4 10             	add    $0x10,%esp
  41:	43                   	inc    %ebx
  42:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  46:	39 f3                	cmp    %esi,%ebx
  48:	75 e2                	jne    2c <main+0x2c>
  4a:	68 57 06 00 00       	push   $0x657
  4f:	50                   	push   %eax
  50:	68 52 06 00 00       	push   $0x652
  55:	6a 01                	push   $0x1
  57:	e8 10 03 00 00       	call   36c <printf>
  5c:	83 c4 10             	add    $0x10,%esp
  exit();
  5f:	e8 d7 01 00 00       	call   23b <exit>

00000064 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	53                   	push   %ebx
  68:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6e:	31 c0                	xor    %eax,%eax
  70:	8a 14 03             	mov    (%ebx,%eax,1),%dl
  73:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  76:	40                   	inc    %eax
  77:	84 d2                	test   %dl,%dl
  79:	75 f5                	jne    70 <strcpy+0xc>
    ;
  return os;
}
  7b:	89 c8                	mov    %ecx,%eax
  7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80:	c9                   	leave  
  81:	c3                   	ret    
  82:	66 90                	xchg   %ax,%ax

00000084 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	53                   	push   %ebx
  88:	8b 55 08             	mov    0x8(%ebp),%edx
  8b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  8e:	0f b6 02             	movzbl (%edx),%eax
  91:	84 c0                	test   %al,%al
  93:	75 10                	jne    a5 <strcmp+0x21>
  95:	eb 2a                	jmp    c1 <strcmp+0x3d>
  97:	90                   	nop
    p++, q++;
  98:	42                   	inc    %edx
  99:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
  9c:	0f b6 02             	movzbl (%edx),%eax
  9f:	84 c0                	test   %al,%al
  a1:	74 11                	je     b4 <strcmp+0x30>
    p++, q++;
  a3:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
  a5:	0f b6 0b             	movzbl (%ebx),%ecx
  a8:	38 c1                	cmp    %al,%cl
  aa:	74 ec                	je     98 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  ac:	29 c8                	sub    %ecx,%eax
}
  ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b1:	c9                   	leave  
  b2:	c3                   	ret    
  b3:	90                   	nop
  return (uchar)*p - (uchar)*q;
  b4:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  b8:	31 c0                	xor    %eax,%eax
  ba:	29 c8                	sub    %ecx,%eax
}
  bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  bf:	c9                   	leave  
  c0:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
  c1:	0f b6 0b             	movzbl (%ebx),%ecx
  c4:	31 c0                	xor    %eax,%eax
  c6:	eb e4                	jmp    ac <strcmp+0x28>

000000c8 <strlen>:

uint
strlen(const char *s)
{
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  cb:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  ce:	80 3a 00             	cmpb   $0x0,(%edx)
  d1:	74 15                	je     e8 <strlen+0x20>
  d3:	31 c0                	xor    %eax,%eax
  d5:	8d 76 00             	lea    0x0(%esi),%esi
  d8:	40                   	inc    %eax
  d9:	89 c1                	mov    %eax,%ecx
  db:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  df:	75 f7                	jne    d8 <strlen+0x10>
    ;
  return n;
}
  e1:	89 c8                	mov    %ecx,%eax
  e3:	5d                   	pop    %ebp
  e4:	c3                   	ret    
  e5:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  e8:	31 c9                	xor    %ecx,%ecx
}
  ea:	89 c8                	mov    %ecx,%eax
  ec:	5d                   	pop    %ebp
  ed:	c3                   	ret    
  ee:	66 90                	xchg   %ax,%ax

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f4:	8b 7d 08             	mov    0x8(%ebp),%edi
  f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	fc                   	cld    
  fe:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 100:	8b 45 08             	mov    0x8(%ebp),%eax
 103:	8b 7d fc             	mov    -0x4(%ebp),%edi
 106:	c9                   	leave  
 107:	c3                   	ret    

00000108 <strchr>:

char*
strchr(const char *s, char c)
{
 108:	55                   	push   %ebp
 109:	89 e5                	mov    %esp,%ebp
 10b:	8b 45 08             	mov    0x8(%ebp),%eax
 10e:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 111:	8a 10                	mov    (%eax),%dl
 113:	84 d2                	test   %dl,%dl
 115:	75 0c                	jne    123 <strchr+0x1b>
 117:	eb 13                	jmp    12c <strchr+0x24>
 119:	8d 76 00             	lea    0x0(%esi),%esi
 11c:	40                   	inc    %eax
 11d:	8a 10                	mov    (%eax),%dl
 11f:	84 d2                	test   %dl,%dl
 121:	74 09                	je     12c <strchr+0x24>
    if(*s == c)
 123:	38 d1                	cmp    %dl,%cl
 125:	75 f5                	jne    11c <strchr+0x14>
      return (char*)s;
  return 0;
}
 127:	5d                   	pop    %ebp
 128:	c3                   	ret    
 129:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 12c:	31 c0                	xor    %eax,%eax
}
 12e:	5d                   	pop    %ebp
 12f:	c3                   	ret    

00000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	56                   	push   %esi
 135:	53                   	push   %ebx
 136:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 139:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 13b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 13e:	eb 24                	jmp    164 <gets+0x34>
    cc = read(0, &c, 1);
 140:	50                   	push   %eax
 141:	6a 01                	push   $0x1
 143:	57                   	push   %edi
 144:	6a 00                	push   $0x0
 146:	e8 08 01 00 00       	call   253 <read>
    if(cc < 1)
 14b:	83 c4 10             	add    $0x10,%esp
 14e:	85 c0                	test   %eax,%eax
 150:	7e 1c                	jle    16e <gets+0x3e>
      break;
    buf[i++] = c;
 152:	8a 45 e7             	mov    -0x19(%ebp),%al
 155:	8b 55 08             	mov    0x8(%ebp),%edx
 158:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 15c:	3c 0a                	cmp    $0xa,%al
 15e:	74 20                	je     180 <gets+0x50>
 160:	3c 0d                	cmp    $0xd,%al
 162:	74 1c                	je     180 <gets+0x50>
  for(i=0; i+1 < max; ){
 164:	89 de                	mov    %ebx,%esi
 166:	8d 5b 01             	lea    0x1(%ebx),%ebx
 169:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 16c:	7c d2                	jl     140 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 175:	8d 65 f4             	lea    -0xc(%ebp),%esp
 178:	5b                   	pop    %ebx
 179:	5e                   	pop    %esi
 17a:	5f                   	pop    %edi
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret    
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 182:	8b 45 08             	mov    0x8(%ebp),%eax
 185:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 189:	8d 65 f4             	lea    -0xc(%ebp),%esp
 18c:	5b                   	pop    %ebx
 18d:	5e                   	pop    %esi
 18e:	5f                   	pop    %edi
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    
 191:	8d 76 00             	lea    0x0(%esi),%esi

00000194 <stat>:

int
stat(const char *n, struct stat *st)
{
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	56                   	push   %esi
 198:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 199:	83 ec 08             	sub    $0x8,%esp
 19c:	6a 00                	push   $0x0
 19e:	ff 75 08             	push   0x8(%ebp)
 1a1:	e8 d5 00 00 00       	call   27b <open>
  if(fd < 0)
 1a6:	83 c4 10             	add    $0x10,%esp
 1a9:	85 c0                	test   %eax,%eax
 1ab:	78 27                	js     1d4 <stat+0x40>
 1ad:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1af:	83 ec 08             	sub    $0x8,%esp
 1b2:	ff 75 0c             	push   0xc(%ebp)
 1b5:	50                   	push   %eax
 1b6:	e8 d8 00 00 00       	call   293 <fstat>
 1bb:	89 c6                	mov    %eax,%esi
  close(fd);
 1bd:	89 1c 24             	mov    %ebx,(%esp)
 1c0:	e8 9e 00 00 00       	call   263 <close>
  return r;
 1c5:	83 c4 10             	add    $0x10,%esp
}
 1c8:	89 f0                	mov    %esi,%eax
 1ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1cd:	5b                   	pop    %ebx
 1ce:	5e                   	pop    %esi
 1cf:	5d                   	pop    %ebp
 1d0:	c3                   	ret    
 1d1:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1d4:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1d9:	eb ed                	jmp    1c8 <stat+0x34>
 1db:	90                   	nop

000001dc <atoi>:

int
atoi(const char *s)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	53                   	push   %ebx
 1e0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e3:	0f be 01             	movsbl (%ecx),%eax
 1e6:	8d 50 d0             	lea    -0x30(%eax),%edx
 1e9:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 1ec:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1f1:	77 16                	ja     209 <atoi+0x2d>
 1f3:	90                   	nop
    n = n*10 + *s++ - '0';
 1f4:	41                   	inc    %ecx
 1f5:	8d 14 92             	lea    (%edx,%edx,4),%edx
 1f8:	01 d2                	add    %edx,%edx
 1fa:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 1fe:	0f be 01             	movsbl (%ecx),%eax
 201:	8d 58 d0             	lea    -0x30(%eax),%ebx
 204:	80 fb 09             	cmp    $0x9,%bl
 207:	76 eb                	jbe    1f4 <atoi+0x18>
  return n;
}
 209:	89 d0                	mov    %edx,%eax
 20b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 20e:	c9                   	leave  
 20f:	c3                   	ret    

00000210 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
 215:	8b 55 08             	mov    0x8(%ebp),%edx
 218:	8b 75 0c             	mov    0xc(%ebp),%esi
 21b:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 21e:	85 c0                	test   %eax,%eax
 220:	7e 0b                	jle    22d <memmove+0x1d>
 222:	01 d0                	add    %edx,%eax
  dst = vdst;
 224:	89 d7                	mov    %edx,%edi
 226:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 228:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 229:	39 f8                	cmp    %edi,%eax
 22b:	75 fb                	jne    228 <memmove+0x18>
  return vdst;
}
 22d:	89 d0                	mov    %edx,%eax
 22f:	5e                   	pop    %esi
 230:	5f                   	pop    %edi
 231:	5d                   	pop    %ebp
 232:	c3                   	ret    

00000233 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 233:	b8 01 00 00 00       	mov    $0x1,%eax
 238:	cd 40                	int    $0x40
 23a:	c3                   	ret    

0000023b <exit>:
SYSCALL(exit)
 23b:	b8 02 00 00 00       	mov    $0x2,%eax
 240:	cd 40                	int    $0x40
 242:	c3                   	ret    

00000243 <wait>:
SYSCALL(wait)
 243:	b8 03 00 00 00       	mov    $0x3,%eax
 248:	cd 40                	int    $0x40
 24a:	c3                   	ret    

0000024b <pipe>:
SYSCALL(pipe)
 24b:	b8 04 00 00 00       	mov    $0x4,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret    

00000253 <read>:
SYSCALL(read)
 253:	b8 05 00 00 00       	mov    $0x5,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret    

0000025b <write>:
SYSCALL(write)
 25b:	b8 10 00 00 00       	mov    $0x10,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret    

00000263 <close>:
SYSCALL(close)
 263:	b8 15 00 00 00       	mov    $0x15,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret    

0000026b <kill>:
SYSCALL(kill)
 26b:	b8 06 00 00 00       	mov    $0x6,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <exec>:
SYSCALL(exec)
 273:	b8 07 00 00 00       	mov    $0x7,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <open>:
SYSCALL(open)
 27b:	b8 0f 00 00 00       	mov    $0xf,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <mknod>:
SYSCALL(mknod)
 283:	b8 11 00 00 00       	mov    $0x11,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <unlink>:
SYSCALL(unlink)
 28b:	b8 12 00 00 00       	mov    $0x12,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <fstat>:
SYSCALL(fstat)
 293:	b8 08 00 00 00       	mov    $0x8,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <link>:
SYSCALL(link)
 29b:	b8 13 00 00 00       	mov    $0x13,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <mkdir>:
SYSCALL(mkdir)
 2a3:	b8 14 00 00 00       	mov    $0x14,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <chdir>:
SYSCALL(chdir)
 2ab:	b8 09 00 00 00       	mov    $0x9,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <dup>:
SYSCALL(dup)
 2b3:	b8 0a 00 00 00       	mov    $0xa,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <getpid>:
SYSCALL(getpid)
 2bb:	b8 0b 00 00 00       	mov    $0xb,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <sbrk>:
SYSCALL(sbrk)
 2c3:	b8 0c 00 00 00       	mov    $0xc,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <sleep>:
SYSCALL(sleep)
 2cb:	b8 0d 00 00 00       	mov    $0xd,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <uptime>:
SYSCALL(uptime)
 2d3:	b8 0e 00 00 00       	mov    $0xe,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <getprocs>:
SYSCALL(getprocs)
 2db:	b8 16 00 00 00       	mov    $0x16,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    
 2e3:	90                   	nop

000002e4 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2e4:	55                   	push   %ebp
 2e5:	89 e5                	mov    %esp,%ebp
 2e7:	57                   	push   %edi
 2e8:	56                   	push   %esi
 2e9:	53                   	push   %ebx
 2ea:	83 ec 3c             	sub    $0x3c,%esp
 2ed:	89 45 bc             	mov    %eax,-0x44(%ebp)
 2f0:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2f3:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
 2f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2f8:	85 db                	test   %ebx,%ebx
 2fa:	74 04                	je     300 <printint+0x1c>
 2fc:	85 d2                	test   %edx,%edx
 2fe:	78 68                	js     368 <printint+0x84>
  neg = 0;
 300:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 307:	31 ff                	xor    %edi,%edi
 309:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 30c:	89 c8                	mov    %ecx,%eax
 30e:	31 d2                	xor    %edx,%edx
 310:	f7 75 c4             	divl   -0x3c(%ebp)
 313:	89 fb                	mov    %edi,%ebx
 315:	8d 7f 01             	lea    0x1(%edi),%edi
 318:	8a 92 b8 06 00 00    	mov    0x6b8(%edx),%dl
 31e:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 322:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 325:	89 c1                	mov    %eax,%ecx
 327:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 32a:	3b 45 c0             	cmp    -0x40(%ebp),%eax
 32d:	76 dd                	jbe    30c <printint+0x28>
  if(neg)
 32f:	8b 4d 08             	mov    0x8(%ebp),%ecx
 332:	85 c9                	test   %ecx,%ecx
 334:	74 09                	je     33f <printint+0x5b>
    buf[i++] = '-';
 336:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
 33b:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
 33d:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
 33f:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 343:	8b 7d bc             	mov    -0x44(%ebp),%edi
 346:	eb 03                	jmp    34b <printint+0x67>
    putc(fd, buf[i]);
 348:	8a 13                	mov    (%ebx),%dl
 34a:	4b                   	dec    %ebx
 34b:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
 34e:	50                   	push   %eax
 34f:	6a 01                	push   $0x1
 351:	56                   	push   %esi
 352:	57                   	push   %edi
 353:	e8 03 ff ff ff       	call   25b <write>
  while(--i >= 0)
 358:	83 c4 10             	add    $0x10,%esp
 35b:	39 de                	cmp    %ebx,%esi
 35d:	75 e9                	jne    348 <printint+0x64>
}
 35f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 362:	5b                   	pop    %ebx
 363:	5e                   	pop    %esi
 364:	5f                   	pop    %edi
 365:	5d                   	pop    %ebp
 366:	c3                   	ret    
 367:	90                   	nop
    x = -xx;
 368:	f7 d9                	neg    %ecx
 36a:	eb 9b                	jmp    307 <printint+0x23>

0000036c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	57                   	push   %edi
 370:	56                   	push   %esi
 371:	53                   	push   %ebx
 372:	83 ec 2c             	sub    $0x2c,%esp
 375:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 378:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 37b:	8a 13                	mov    (%ebx),%dl
 37d:	84 d2                	test   %dl,%dl
 37f:	74 64                	je     3e5 <printf+0x79>
 381:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 382:	8d 45 10             	lea    0x10(%ebp),%eax
 385:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
 388:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
 38a:	8d 7d e7             	lea    -0x19(%ebp),%edi
 38d:	eb 24                	jmp    3b3 <printf+0x47>
 38f:	90                   	nop
 390:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 393:	83 f8 25             	cmp    $0x25,%eax
 396:	74 40                	je     3d8 <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
 398:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 39b:	50                   	push   %eax
 39c:	6a 01                	push   $0x1
 39e:	57                   	push   %edi
 39f:	56                   	push   %esi
 3a0:	e8 b6 fe ff ff       	call   25b <write>
        putc(fd, c);
 3a5:	83 c4 10             	add    $0x10,%esp
 3a8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
 3ab:	43                   	inc    %ebx
 3ac:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3af:	84 d2                	test   %dl,%dl
 3b1:	74 32                	je     3e5 <printf+0x79>
    c = fmt[i] & 0xff;
 3b3:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 3b6:	85 c9                	test   %ecx,%ecx
 3b8:	74 d6                	je     390 <printf+0x24>
      }
    } else if(state == '%'){
 3ba:	83 f9 25             	cmp    $0x25,%ecx
 3bd:	75 ec                	jne    3ab <printf+0x3f>
      if(c == 'd'){
 3bf:	83 f8 25             	cmp    $0x25,%eax
 3c2:	0f 84 e4 00 00 00    	je     4ac <printf+0x140>
 3c8:	83 e8 63             	sub    $0x63,%eax
 3cb:	83 f8 15             	cmp    $0x15,%eax
 3ce:	77 20                	ja     3f0 <printf+0x84>
 3d0:	ff 24 85 60 06 00 00 	jmp    *0x660(,%eax,4)
 3d7:	90                   	nop
        state = '%';
 3d8:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
 3dd:	43                   	inc    %ebx
 3de:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3e1:	84 d2                	test   %dl,%dl
 3e3:	75 ce                	jne    3b3 <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e8:	5b                   	pop    %ebx
 3e9:	5e                   	pop    %esi
 3ea:	5f                   	pop    %edi
 3eb:	5d                   	pop    %ebp
 3ec:	c3                   	ret    
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
 3f3:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3f7:	50                   	push   %eax
 3f8:	6a 01                	push   $0x1
 3fa:	57                   	push   %edi
 3fb:	56                   	push   %esi
 3fc:	e8 5a fe ff ff       	call   25b <write>
        putc(fd, c);
 401:	8a 55 d4             	mov    -0x2c(%ebp),%dl
 404:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 407:	83 c4 0c             	add    $0xc,%esp
 40a:	6a 01                	push   $0x1
 40c:	57                   	push   %edi
 40d:	56                   	push   %esi
 40e:	e8 48 fe ff ff       	call   25b <write>
        putc(fd, c);
 413:	83 c4 10             	add    $0x10,%esp
      state = 0;
 416:	31 c9                	xor    %ecx,%ecx
 418:	eb 91                	jmp    3ab <printf+0x3f>
 41a:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 41c:	83 ec 0c             	sub    $0xc,%esp
 41f:	6a 00                	push   $0x0
 421:	b9 10 00 00 00       	mov    $0x10,%ecx
 426:	8b 45 d0             	mov    -0x30(%ebp),%eax
 429:	8b 10                	mov    (%eax),%edx
 42b:	89 f0                	mov    %esi,%eax
 42d:	e8 b2 fe ff ff       	call   2e4 <printint>
        ap++;
 432:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 436:	83 c4 10             	add    $0x10,%esp
      state = 0;
 439:	31 c9                	xor    %ecx,%ecx
        ap++;
 43b:	e9 6b ff ff ff       	jmp    3ab <printf+0x3f>
        s = (char*)*ap;
 440:	8b 45 d0             	mov    -0x30(%ebp),%eax
 443:	8b 10                	mov    (%eax),%edx
        ap++;
 445:	83 c0 04             	add    $0x4,%eax
 448:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 44b:	85 d2                	test   %edx,%edx
 44d:	74 69                	je     4b8 <printf+0x14c>
        while(*s != 0){
 44f:	8a 02                	mov    (%edx),%al
 451:	84 c0                	test   %al,%al
 453:	74 71                	je     4c6 <printf+0x15a>
 455:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 458:	89 d3                	mov    %edx,%ebx
 45a:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
 45c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 45f:	50                   	push   %eax
 460:	6a 01                	push   $0x1
 462:	57                   	push   %edi
 463:	56                   	push   %esi
 464:	e8 f2 fd ff ff       	call   25b <write>
          s++;
 469:	43                   	inc    %ebx
        while(*s != 0){
 46a:	8a 03                	mov    (%ebx),%al
 46c:	83 c4 10             	add    $0x10,%esp
 46f:	84 c0                	test   %al,%al
 471:	75 e9                	jne    45c <printf+0xf0>
      state = 0;
 473:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 476:	31 c9                	xor    %ecx,%ecx
 478:	e9 2e ff ff ff       	jmp    3ab <printf+0x3f>
 47d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 480:	83 ec 0c             	sub    $0xc,%esp
 483:	6a 01                	push   $0x1
 485:	b9 0a 00 00 00       	mov    $0xa,%ecx
 48a:	eb 9a                	jmp    426 <printf+0xba>
        putc(fd, *ap);
 48c:	8b 45 d0             	mov    -0x30(%ebp),%eax
 48f:	8b 00                	mov    (%eax),%eax
 491:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 494:	51                   	push   %ecx
 495:	6a 01                	push   $0x1
 497:	57                   	push   %edi
 498:	56                   	push   %esi
 499:	e8 bd fd ff ff       	call   25b <write>
        ap++;
 49e:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 4a2:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4a5:	31 c9                	xor    %ecx,%ecx
 4a7:	e9 ff fe ff ff       	jmp    3ab <printf+0x3f>
        putc(fd, c);
 4ac:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4af:	52                   	push   %edx
 4b0:	e9 55 ff ff ff       	jmp    40a <printf+0x9e>
 4b5:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
 4b8:	ba 59 06 00 00       	mov    $0x659,%edx
        while(*s != 0){
 4bd:	b0 28                	mov    $0x28,%al
 4bf:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 4c2:	89 d3                	mov    %edx,%ebx
 4c4:	eb 96                	jmp    45c <printf+0xf0>
      state = 0;
 4c6:	31 c9                	xor    %ecx,%ecx
 4c8:	e9 de fe ff ff       	jmp    3ab <printf+0x3f>
 4cd:	66 90                	xchg   %ax,%ax
 4cf:	90                   	nop

000004d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4d9:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4dc:	a1 cc 06 00 00       	mov    0x6cc,%eax
 4e1:	8d 76 00             	lea    0x0(%esi),%esi
 4e4:	89 c2                	mov    %eax,%edx
 4e6:	8b 00                	mov    (%eax),%eax
 4e8:	39 ca                	cmp    %ecx,%edx
 4ea:	73 2c                	jae    518 <free+0x48>
 4ec:	39 c1                	cmp    %eax,%ecx
 4ee:	72 04                	jb     4f4 <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4f0:	39 c2                	cmp    %eax,%edx
 4f2:	72 f0                	jb     4e4 <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4f4:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4f7:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4fa:	39 f8                	cmp    %edi,%eax
 4fc:	74 2c                	je     52a <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 4fe:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 501:	8b 42 04             	mov    0x4(%edx),%eax
 504:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 507:	39 f1                	cmp    %esi,%ecx
 509:	74 36                	je     541 <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 50b:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
 50d:	89 15 cc 06 00 00    	mov    %edx,0x6cc
}
 513:	5b                   	pop    %ebx
 514:	5e                   	pop    %esi
 515:	5f                   	pop    %edi
 516:	5d                   	pop    %ebp
 517:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 518:	39 c2                	cmp    %eax,%edx
 51a:	72 c8                	jb     4e4 <free+0x14>
 51c:	39 c1                	cmp    %eax,%ecx
 51e:	73 c4                	jae    4e4 <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
 520:	8b 73 fc             	mov    -0x4(%ebx),%esi
 523:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 526:	39 f8                	cmp    %edi,%eax
 528:	75 d4                	jne    4fe <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
 52a:	03 70 04             	add    0x4(%eax),%esi
 52d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 530:	8b 02                	mov    (%edx),%eax
 532:	8b 00                	mov    (%eax),%eax
 534:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 537:	8b 42 04             	mov    0x4(%edx),%eax
 53a:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 53d:	39 f1                	cmp    %esi,%ecx
 53f:	75 ca                	jne    50b <free+0x3b>
    p->s.size += bp->s.size;
 541:	03 43 fc             	add    -0x4(%ebx),%eax
 544:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 547:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 54a:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 54c:	89 15 cc 06 00 00    	mov    %edx,0x6cc
}
 552:	5b                   	pop    %ebx
 553:	5e                   	pop    %esi
 554:	5f                   	pop    %edi
 555:	5d                   	pop    %ebp
 556:	c3                   	ret    
 557:	90                   	nop

00000558 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 558:	55                   	push   %ebp
 559:	89 e5                	mov    %esp,%ebp
 55b:	57                   	push   %edi
 55c:	56                   	push   %esi
 55d:	53                   	push   %ebx
 55e:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 561:	8b 45 08             	mov    0x8(%ebp),%eax
 564:	8d 70 07             	lea    0x7(%eax),%esi
 567:	c1 ee 03             	shr    $0x3,%esi
 56a:	46                   	inc    %esi
  if((prevp = freep) == 0){
 56b:	8b 3d cc 06 00 00    	mov    0x6cc,%edi
 571:	85 ff                	test   %edi,%edi
 573:	0f 84 a3 00 00 00    	je     61c <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 579:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 57b:	8b 4a 04             	mov    0x4(%edx),%ecx
 57e:	39 f1                	cmp    %esi,%ecx
 580:	73 68                	jae    5ea <malloc+0x92>
 582:	89 f3                	mov    %esi,%ebx
 584:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 58a:	0f 82 80 00 00 00    	jb     610 <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
 590:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 597:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 59a:	eb 11                	jmp    5ad <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 59c:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 59e:	8b 48 04             	mov    0x4(%eax),%ecx
 5a1:	39 f1                	cmp    %esi,%ecx
 5a3:	73 4b                	jae    5f0 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5a5:	8b 3d cc 06 00 00    	mov    0x6cc,%edi
 5ab:	89 c2                	mov    %eax,%edx
 5ad:	39 d7                	cmp    %edx,%edi
 5af:	75 eb                	jne    59c <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
 5b1:	83 ec 0c             	sub    $0xc,%esp
 5b4:	ff 75 e4             	push   -0x1c(%ebp)
 5b7:	e8 07 fd ff ff       	call   2c3 <sbrk>
  if(p == (char*)-1)
 5bc:	83 c4 10             	add    $0x10,%esp
 5bf:	83 f8 ff             	cmp    $0xffffffff,%eax
 5c2:	74 1c                	je     5e0 <malloc+0x88>
  hp->s.size = nu;
 5c4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 5c7:	83 ec 0c             	sub    $0xc,%esp
 5ca:	83 c0 08             	add    $0x8,%eax
 5cd:	50                   	push   %eax
 5ce:	e8 fd fe ff ff       	call   4d0 <free>
  return freep;
 5d3:	8b 15 cc 06 00 00    	mov    0x6cc,%edx
      if((p = morecore(nunits)) == 0)
 5d9:	83 c4 10             	add    $0x10,%esp
 5dc:	85 d2                	test   %edx,%edx
 5de:	75 bc                	jne    59c <malloc+0x44>
        return 0;
 5e0:	31 c0                	xor    %eax,%eax
  }
}
 5e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5e5:	5b                   	pop    %ebx
 5e6:	5e                   	pop    %esi
 5e7:	5f                   	pop    %edi
 5e8:	5d                   	pop    %ebp
 5e9:	c3                   	ret    
    if(p->s.size >= nunits){
 5ea:	89 d0                	mov    %edx,%eax
 5ec:	89 fa                	mov    %edi,%edx
 5ee:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 5f0:	39 ce                	cmp    %ecx,%esi
 5f2:	74 54                	je     648 <malloc+0xf0>
        p->s.size -= nunits;
 5f4:	29 f1                	sub    %esi,%ecx
 5f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5fc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 5ff:	89 15 cc 06 00 00    	mov    %edx,0x6cc
      return (void*)(p + 1);
 605:	83 c0 08             	add    $0x8,%eax
}
 608:	8d 65 f4             	lea    -0xc(%ebp),%esp
 60b:	5b                   	pop    %ebx
 60c:	5e                   	pop    %esi
 60d:	5f                   	pop    %edi
 60e:	5d                   	pop    %ebp
 60f:	c3                   	ret    
 610:	bb 00 10 00 00       	mov    $0x1000,%ebx
 615:	e9 76 ff ff ff       	jmp    590 <malloc+0x38>
 61a:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 61c:	c7 05 cc 06 00 00 d0 	movl   $0x6d0,0x6cc
 623:	06 00 00 
 626:	c7 05 d0 06 00 00 d0 	movl   $0x6d0,0x6d0
 62d:	06 00 00 
    base.s.size = 0;
 630:	c7 05 d4 06 00 00 00 	movl   $0x0,0x6d4
 637:	00 00 00 
 63a:	bf d0 06 00 00       	mov    $0x6d0,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 63f:	89 fa                	mov    %edi,%edx
 641:	e9 3c ff ff ff       	jmp    582 <malloc+0x2a>
 646:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 648:	8b 08                	mov    (%eax),%ecx
 64a:	89 0a                	mov    %ecx,(%edx)
 64c:	eb b1                	jmp    5ff <malloc+0xa7>
