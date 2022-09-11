
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	50                   	push   %eax
  if(fork() > 0)
   f:	e8 e7 01 00 00       	call   1fb <fork>
  14:	85 c0                	test   %eax,%eax
  16:	7e 0d                	jle    25 <main+0x25>
    sleep(5);  // Let child exit before parent.
  18:	83 ec 0c             	sub    $0xc,%esp
  1b:	6a 05                	push   $0x5
  1d:	e8 71 02 00 00       	call   293 <sleep>
  22:	83 c4 10             	add    $0x10,%esp
  exit();
  25:	e8 d9 01 00 00       	call   203 <exit>
  2a:	66 90                	xchg   %ax,%ax

0000002c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  2c:	55                   	push   %ebp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	53                   	push   %ebx
  30:	8b 4d 08             	mov    0x8(%ebp),%ecx
  33:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  36:	31 c0                	xor    %eax,%eax
  38:	8a 14 03             	mov    (%ebx,%eax,1),%dl
  3b:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  3e:	40                   	inc    %eax
  3f:	84 d2                	test   %dl,%dl
  41:	75 f5                	jne    38 <strcpy+0xc>
    ;
  return os;
}
  43:	89 c8                	mov    %ecx,%eax
  45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  48:	c9                   	leave  
  49:	c3                   	ret    
  4a:	66 90                	xchg   %ax,%ax

0000004c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4c:	55                   	push   %ebp
  4d:	89 e5                	mov    %esp,%ebp
  4f:	53                   	push   %ebx
  50:	8b 55 08             	mov    0x8(%ebp),%edx
  53:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  56:	0f b6 02             	movzbl (%edx),%eax
  59:	84 c0                	test   %al,%al
  5b:	75 10                	jne    6d <strcmp+0x21>
  5d:	eb 2a                	jmp    89 <strcmp+0x3d>
  5f:	90                   	nop
    p++, q++;
  60:	42                   	inc    %edx
  61:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
  64:	0f b6 02             	movzbl (%edx),%eax
  67:	84 c0                	test   %al,%al
  69:	74 11                	je     7c <strcmp+0x30>
    p++, q++;
  6b:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
  6d:	0f b6 0b             	movzbl (%ebx),%ecx
  70:	38 c1                	cmp    %al,%cl
  72:	74 ec                	je     60 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  74:	29 c8                	sub    %ecx,%eax
}
  76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  79:	c9                   	leave  
  7a:	c3                   	ret    
  7b:	90                   	nop
  return (uchar)*p - (uchar)*q;
  7c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  80:	31 c0                	xor    %eax,%eax
  82:	29 c8                	sub    %ecx,%eax
}
  84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  87:	c9                   	leave  
  88:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
  89:	0f b6 0b             	movzbl (%ebx),%ecx
  8c:	31 c0                	xor    %eax,%eax
  8e:	eb e4                	jmp    74 <strcmp+0x28>

00000090 <strlen>:

uint
strlen(const char *s)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  96:	80 3a 00             	cmpb   $0x0,(%edx)
  99:	74 15                	je     b0 <strlen+0x20>
  9b:	31 c0                	xor    %eax,%eax
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	40                   	inc    %eax
  a1:	89 c1                	mov    %eax,%ecx
  a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  a7:	75 f7                	jne    a0 <strlen+0x10>
    ;
  return n;
}
  a9:	89 c8                	mov    %ecx,%eax
  ab:	5d                   	pop    %ebp
  ac:	c3                   	ret    
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  b0:	31 c9                	xor    %ecx,%ecx
}
  b2:	89 c8                	mov    %ecx,%eax
  b4:	5d                   	pop    %ebp
  b5:	c3                   	ret    
  b6:	66 90                	xchg   %ax,%ax

000000b8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  bb:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  bc:	8b 7d 08             	mov    0x8(%ebp),%edi
  bf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  c5:	fc                   	cld    
  c6:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  c8:	8b 45 08             	mov    0x8(%ebp),%eax
  cb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  ce:	c9                   	leave  
  cf:	c3                   	ret    

000000d0 <strchr>:

char*
strchr(const char *s, char c)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
  d9:	8a 10                	mov    (%eax),%dl
  db:	84 d2                	test   %dl,%dl
  dd:	75 0c                	jne    eb <strchr+0x1b>
  df:	eb 13                	jmp    f4 <strchr+0x24>
  e1:	8d 76 00             	lea    0x0(%esi),%esi
  e4:	40                   	inc    %eax
  e5:	8a 10                	mov    (%eax),%dl
  e7:	84 d2                	test   %dl,%dl
  e9:	74 09                	je     f4 <strchr+0x24>
    if(*s == c)
  eb:	38 d1                	cmp    %dl,%cl
  ed:	75 f5                	jne    e4 <strchr+0x14>
      return (char*)s;
  return 0;
}
  ef:	5d                   	pop    %ebp
  f0:	c3                   	ret    
  f1:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
  f4:	31 c0                	xor    %eax,%eax
}
  f6:	5d                   	pop    %ebp
  f7:	c3                   	ret    

000000f8 <gets>:

char*
gets(char *buf, int max)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	57                   	push   %edi
  fc:	56                   	push   %esi
  fd:	53                   	push   %ebx
  fe:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 101:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 103:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 106:	eb 24                	jmp    12c <gets+0x34>
    cc = read(0, &c, 1);
 108:	50                   	push   %eax
 109:	6a 01                	push   $0x1
 10b:	57                   	push   %edi
 10c:	6a 00                	push   $0x0
 10e:	e8 08 01 00 00       	call   21b <read>
    if(cc < 1)
 113:	83 c4 10             	add    $0x10,%esp
 116:	85 c0                	test   %eax,%eax
 118:	7e 1c                	jle    136 <gets+0x3e>
      break;
    buf[i++] = c;
 11a:	8a 45 e7             	mov    -0x19(%ebp),%al
 11d:	8b 55 08             	mov    0x8(%ebp),%edx
 120:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 124:	3c 0a                	cmp    $0xa,%al
 126:	74 20                	je     148 <gets+0x50>
 128:	3c 0d                	cmp    $0xd,%al
 12a:	74 1c                	je     148 <gets+0x50>
  for(i=0; i+1 < max; ){
 12c:	89 de                	mov    %ebx,%esi
 12e:	8d 5b 01             	lea    0x1(%ebx),%ebx
 131:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 134:	7c d2                	jl     108 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 136:	8b 45 08             	mov    0x8(%ebp),%eax
 139:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 13d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 140:	5b                   	pop    %ebx
 141:	5e                   	pop    %esi
 142:	5f                   	pop    %edi
 143:	5d                   	pop    %ebp
 144:	c3                   	ret    
 145:	8d 76 00             	lea    0x0(%esi),%esi
 148:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 14a:	8b 45 08             	mov    0x8(%ebp),%eax
 14d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 151:	8d 65 f4             	lea    -0xc(%ebp),%esp
 154:	5b                   	pop    %ebx
 155:	5e                   	pop    %esi
 156:	5f                   	pop    %edi
 157:	5d                   	pop    %ebp
 158:	c3                   	ret    
 159:	8d 76 00             	lea    0x0(%esi),%esi

0000015c <stat>:

int
stat(const char *n, struct stat *st)
{
 15c:	55                   	push   %ebp
 15d:	89 e5                	mov    %esp,%ebp
 15f:	56                   	push   %esi
 160:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 161:	83 ec 08             	sub    $0x8,%esp
 164:	6a 00                	push   $0x0
 166:	ff 75 08             	push   0x8(%ebp)
 169:	e8 d5 00 00 00       	call   243 <open>
  if(fd < 0)
 16e:	83 c4 10             	add    $0x10,%esp
 171:	85 c0                	test   %eax,%eax
 173:	78 27                	js     19c <stat+0x40>
 175:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 177:	83 ec 08             	sub    $0x8,%esp
 17a:	ff 75 0c             	push   0xc(%ebp)
 17d:	50                   	push   %eax
 17e:	e8 d8 00 00 00       	call   25b <fstat>
 183:	89 c6                	mov    %eax,%esi
  close(fd);
 185:	89 1c 24             	mov    %ebx,(%esp)
 188:	e8 9e 00 00 00       	call   22b <close>
  return r;
 18d:	83 c4 10             	add    $0x10,%esp
}
 190:	89 f0                	mov    %esi,%eax
 192:	8d 65 f8             	lea    -0x8(%ebp),%esp
 195:	5b                   	pop    %ebx
 196:	5e                   	pop    %esi
 197:	5d                   	pop    %ebp
 198:	c3                   	ret    
 199:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 19c:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1a1:	eb ed                	jmp    190 <stat+0x34>
 1a3:	90                   	nop

000001a4 <atoi>:

int
atoi(const char *s)
{
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	53                   	push   %ebx
 1a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ab:	0f be 01             	movsbl (%ecx),%eax
 1ae:	8d 50 d0             	lea    -0x30(%eax),%edx
 1b1:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 1b4:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1b9:	77 16                	ja     1d1 <atoi+0x2d>
 1bb:	90                   	nop
    n = n*10 + *s++ - '0';
 1bc:	41                   	inc    %ecx
 1bd:	8d 14 92             	lea    (%edx,%edx,4),%edx
 1c0:	01 d2                	add    %edx,%edx
 1c2:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 1c6:	0f be 01             	movsbl (%ecx),%eax
 1c9:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1cc:	80 fb 09             	cmp    $0x9,%bl
 1cf:	76 eb                	jbe    1bc <atoi+0x18>
  return n;
}
 1d1:	89 d0                	mov    %edx,%eax
 1d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1d6:	c9                   	leave  
 1d7:	c3                   	ret    

000001d8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1d8:	55                   	push   %ebp
 1d9:	89 e5                	mov    %esp,%ebp
 1db:	57                   	push   %edi
 1dc:	56                   	push   %esi
 1dd:	8b 55 08             	mov    0x8(%ebp),%edx
 1e0:	8b 75 0c             	mov    0xc(%ebp),%esi
 1e3:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1e6:	85 c0                	test   %eax,%eax
 1e8:	7e 0b                	jle    1f5 <memmove+0x1d>
 1ea:	01 d0                	add    %edx,%eax
  dst = vdst;
 1ec:	89 d7                	mov    %edx,%edi
 1ee:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 1f0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 1f1:	39 f8                	cmp    %edi,%eax
 1f3:	75 fb                	jne    1f0 <memmove+0x18>
  return vdst;
}
 1f5:	89 d0                	mov    %edx,%eax
 1f7:	5e                   	pop    %esi
 1f8:	5f                   	pop    %edi
 1f9:	5d                   	pop    %ebp
 1fa:	c3                   	ret    

000001fb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1fb:	b8 01 00 00 00       	mov    $0x1,%eax
 200:	cd 40                	int    $0x40
 202:	c3                   	ret    

00000203 <exit>:
SYSCALL(exit)
 203:	b8 02 00 00 00       	mov    $0x2,%eax
 208:	cd 40                	int    $0x40
 20a:	c3                   	ret    

0000020b <wait>:
SYSCALL(wait)
 20b:	b8 03 00 00 00       	mov    $0x3,%eax
 210:	cd 40                	int    $0x40
 212:	c3                   	ret    

00000213 <pipe>:
SYSCALL(pipe)
 213:	b8 04 00 00 00       	mov    $0x4,%eax
 218:	cd 40                	int    $0x40
 21a:	c3                   	ret    

0000021b <read>:
SYSCALL(read)
 21b:	b8 05 00 00 00       	mov    $0x5,%eax
 220:	cd 40                	int    $0x40
 222:	c3                   	ret    

00000223 <write>:
SYSCALL(write)
 223:	b8 10 00 00 00       	mov    $0x10,%eax
 228:	cd 40                	int    $0x40
 22a:	c3                   	ret    

0000022b <close>:
SYSCALL(close)
 22b:	b8 15 00 00 00       	mov    $0x15,%eax
 230:	cd 40                	int    $0x40
 232:	c3                   	ret    

00000233 <kill>:
SYSCALL(kill)
 233:	b8 06 00 00 00       	mov    $0x6,%eax
 238:	cd 40                	int    $0x40
 23a:	c3                   	ret    

0000023b <exec>:
SYSCALL(exec)
 23b:	b8 07 00 00 00       	mov    $0x7,%eax
 240:	cd 40                	int    $0x40
 242:	c3                   	ret    

00000243 <open>:
SYSCALL(open)
 243:	b8 0f 00 00 00       	mov    $0xf,%eax
 248:	cd 40                	int    $0x40
 24a:	c3                   	ret    

0000024b <mknod>:
SYSCALL(mknod)
 24b:	b8 11 00 00 00       	mov    $0x11,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret    

00000253 <unlink>:
SYSCALL(unlink)
 253:	b8 12 00 00 00       	mov    $0x12,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret    

0000025b <fstat>:
SYSCALL(fstat)
 25b:	b8 08 00 00 00       	mov    $0x8,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret    

00000263 <link>:
SYSCALL(link)
 263:	b8 13 00 00 00       	mov    $0x13,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret    

0000026b <mkdir>:
SYSCALL(mkdir)
 26b:	b8 14 00 00 00       	mov    $0x14,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <chdir>:
SYSCALL(chdir)
 273:	b8 09 00 00 00       	mov    $0x9,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <dup>:
SYSCALL(dup)
 27b:	b8 0a 00 00 00       	mov    $0xa,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <getpid>:
SYSCALL(getpid)
 283:	b8 0b 00 00 00       	mov    $0xb,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <sbrk>:
SYSCALL(sbrk)
 28b:	b8 0c 00 00 00       	mov    $0xc,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <sleep>:
SYSCALL(sleep)
 293:	b8 0d 00 00 00       	mov    $0xd,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <uptime>:
SYSCALL(uptime)
 29b:	b8 0e 00 00 00       	mov    $0xe,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <getprocs>:
SYSCALL(getprocs)
 2a3:	b8 16 00 00 00       	mov    $0x16,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    
 2ab:	90                   	nop

000002ac <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2ac:	55                   	push   %ebp
 2ad:	89 e5                	mov    %esp,%ebp
 2af:	57                   	push   %edi
 2b0:	56                   	push   %esi
 2b1:	53                   	push   %ebx
 2b2:	83 ec 3c             	sub    $0x3c,%esp
 2b5:	89 45 bc             	mov    %eax,-0x44(%ebp)
 2b8:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2bb:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
 2bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2c0:	85 db                	test   %ebx,%ebx
 2c2:	74 04                	je     2c8 <printint+0x1c>
 2c4:	85 d2                	test   %edx,%edx
 2c6:	78 68                	js     330 <printint+0x84>
  neg = 0;
 2c8:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2cf:	31 ff                	xor    %edi,%edi
 2d1:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 2d4:	89 c8                	mov    %ecx,%eax
 2d6:	31 d2                	xor    %edx,%edx
 2d8:	f7 75 c4             	divl   -0x3c(%ebp)
 2db:	89 fb                	mov    %edi,%ebx
 2dd:	8d 7f 01             	lea    0x1(%edi),%edi
 2e0:	8a 92 78 06 00 00    	mov    0x678(%edx),%dl
 2e6:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 2ea:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 2ed:	89 c1                	mov    %eax,%ecx
 2ef:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 2f2:	3b 45 c0             	cmp    -0x40(%ebp),%eax
 2f5:	76 dd                	jbe    2d4 <printint+0x28>
  if(neg)
 2f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2fa:	85 c9                	test   %ecx,%ecx
 2fc:	74 09                	je     307 <printint+0x5b>
    buf[i++] = '-';
 2fe:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
 303:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
 305:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
 307:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 30b:	8b 7d bc             	mov    -0x44(%ebp),%edi
 30e:	eb 03                	jmp    313 <printint+0x67>
    putc(fd, buf[i]);
 310:	8a 13                	mov    (%ebx),%dl
 312:	4b                   	dec    %ebx
 313:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
 316:	50                   	push   %eax
 317:	6a 01                	push   $0x1
 319:	56                   	push   %esi
 31a:	57                   	push   %edi
 31b:	e8 03 ff ff ff       	call   223 <write>
  while(--i >= 0)
 320:	83 c4 10             	add    $0x10,%esp
 323:	39 de                	cmp    %ebx,%esi
 325:	75 e9                	jne    310 <printint+0x64>
}
 327:	8d 65 f4             	lea    -0xc(%ebp),%esp
 32a:	5b                   	pop    %ebx
 32b:	5e                   	pop    %esi
 32c:	5f                   	pop    %edi
 32d:	5d                   	pop    %ebp
 32e:	c3                   	ret    
 32f:	90                   	nop
    x = -xx;
 330:	f7 d9                	neg    %ecx
 332:	eb 9b                	jmp    2cf <printint+0x23>

00000334 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 334:	55                   	push   %ebp
 335:	89 e5                	mov    %esp,%ebp
 337:	57                   	push   %edi
 338:	56                   	push   %esi
 339:	53                   	push   %ebx
 33a:	83 ec 2c             	sub    $0x2c,%esp
 33d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 340:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 343:	8a 13                	mov    (%ebx),%dl
 345:	84 d2                	test   %dl,%dl
 347:	74 64                	je     3ad <printf+0x79>
 349:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 34a:	8d 45 10             	lea    0x10(%ebp),%eax
 34d:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
 350:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
 352:	8d 7d e7             	lea    -0x19(%ebp),%edi
 355:	eb 24                	jmp    37b <printf+0x47>
 357:	90                   	nop
 358:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 35b:	83 f8 25             	cmp    $0x25,%eax
 35e:	74 40                	je     3a0 <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
 360:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 363:	50                   	push   %eax
 364:	6a 01                	push   $0x1
 366:	57                   	push   %edi
 367:	56                   	push   %esi
 368:	e8 b6 fe ff ff       	call   223 <write>
        putc(fd, c);
 36d:	83 c4 10             	add    $0x10,%esp
 370:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
 373:	43                   	inc    %ebx
 374:	8a 53 ff             	mov    -0x1(%ebx),%dl
 377:	84 d2                	test   %dl,%dl
 379:	74 32                	je     3ad <printf+0x79>
    c = fmt[i] & 0xff;
 37b:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 37e:	85 c9                	test   %ecx,%ecx
 380:	74 d6                	je     358 <printf+0x24>
      }
    } else if(state == '%'){
 382:	83 f9 25             	cmp    $0x25,%ecx
 385:	75 ec                	jne    373 <printf+0x3f>
      if(c == 'd'){
 387:	83 f8 25             	cmp    $0x25,%eax
 38a:	0f 84 e4 00 00 00    	je     474 <printf+0x140>
 390:	83 e8 63             	sub    $0x63,%eax
 393:	83 f8 15             	cmp    $0x15,%eax
 396:	77 20                	ja     3b8 <printf+0x84>
 398:	ff 24 85 20 06 00 00 	jmp    *0x620(,%eax,4)
 39f:	90                   	nop
        state = '%';
 3a0:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
 3a5:	43                   	inc    %ebx
 3a6:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3a9:	84 d2                	test   %dl,%dl
 3ab:	75 ce                	jne    37b <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3b0:	5b                   	pop    %ebx
 3b1:	5e                   	pop    %esi
 3b2:	5f                   	pop    %edi
 3b3:	5d                   	pop    %ebp
 3b4:	c3                   	ret    
 3b5:	8d 76 00             	lea    0x0(%esi),%esi
 3b8:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
 3bb:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3bf:	50                   	push   %eax
 3c0:	6a 01                	push   $0x1
 3c2:	57                   	push   %edi
 3c3:	56                   	push   %esi
 3c4:	e8 5a fe ff ff       	call   223 <write>
        putc(fd, c);
 3c9:	8a 55 d4             	mov    -0x2c(%ebp),%dl
 3cc:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 3cf:	83 c4 0c             	add    $0xc,%esp
 3d2:	6a 01                	push   $0x1
 3d4:	57                   	push   %edi
 3d5:	56                   	push   %esi
 3d6:	e8 48 fe ff ff       	call   223 <write>
        putc(fd, c);
 3db:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3de:	31 c9                	xor    %ecx,%ecx
 3e0:	eb 91                	jmp    373 <printf+0x3f>
 3e2:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 3e4:	83 ec 0c             	sub    $0xc,%esp
 3e7:	6a 00                	push   $0x0
 3e9:	b9 10 00 00 00       	mov    $0x10,%ecx
 3ee:	8b 45 d0             	mov    -0x30(%ebp),%eax
 3f1:	8b 10                	mov    (%eax),%edx
 3f3:	89 f0                	mov    %esi,%eax
 3f5:	e8 b2 fe ff ff       	call   2ac <printint>
        ap++;
 3fa:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 3fe:	83 c4 10             	add    $0x10,%esp
      state = 0;
 401:	31 c9                	xor    %ecx,%ecx
        ap++;
 403:	e9 6b ff ff ff       	jmp    373 <printf+0x3f>
        s = (char*)*ap;
 408:	8b 45 d0             	mov    -0x30(%ebp),%eax
 40b:	8b 10                	mov    (%eax),%edx
        ap++;
 40d:	83 c0 04             	add    $0x4,%eax
 410:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 413:	85 d2                	test   %edx,%edx
 415:	74 69                	je     480 <printf+0x14c>
        while(*s != 0){
 417:	8a 02                	mov    (%edx),%al
 419:	84 c0                	test   %al,%al
 41b:	74 71                	je     48e <printf+0x15a>
 41d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 420:	89 d3                	mov    %edx,%ebx
 422:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
 424:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 427:	50                   	push   %eax
 428:	6a 01                	push   $0x1
 42a:	57                   	push   %edi
 42b:	56                   	push   %esi
 42c:	e8 f2 fd ff ff       	call   223 <write>
          s++;
 431:	43                   	inc    %ebx
        while(*s != 0){
 432:	8a 03                	mov    (%ebx),%al
 434:	83 c4 10             	add    $0x10,%esp
 437:	84 c0                	test   %al,%al
 439:	75 e9                	jne    424 <printf+0xf0>
      state = 0;
 43b:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 43e:	31 c9                	xor    %ecx,%ecx
 440:	e9 2e ff ff ff       	jmp    373 <printf+0x3f>
 445:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 448:	83 ec 0c             	sub    $0xc,%esp
 44b:	6a 01                	push   $0x1
 44d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 452:	eb 9a                	jmp    3ee <printf+0xba>
        putc(fd, *ap);
 454:	8b 45 d0             	mov    -0x30(%ebp),%eax
 457:	8b 00                	mov    (%eax),%eax
 459:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 45c:	51                   	push   %ecx
 45d:	6a 01                	push   $0x1
 45f:	57                   	push   %edi
 460:	56                   	push   %esi
 461:	e8 bd fd ff ff       	call   223 <write>
        ap++;
 466:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 46a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 46d:	31 c9                	xor    %ecx,%ecx
 46f:	e9 ff fe ff ff       	jmp    373 <printf+0x3f>
        putc(fd, c);
 474:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 477:	52                   	push   %edx
 478:	e9 55 ff ff ff       	jmp    3d2 <printf+0x9e>
 47d:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
 480:	ba 18 06 00 00       	mov    $0x618,%edx
        while(*s != 0){
 485:	b0 28                	mov    $0x28,%al
 487:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 48a:	89 d3                	mov    %edx,%ebx
 48c:	eb 96                	jmp    424 <printf+0xf0>
      state = 0;
 48e:	31 c9                	xor    %ecx,%ecx
 490:	e9 de fe ff ff       	jmp    373 <printf+0x3f>
 495:	66 90                	xchg   %ax,%ax
 497:	90                   	nop

00000498 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 498:	55                   	push   %ebp
 499:	89 e5                	mov    %esp,%ebp
 49b:	57                   	push   %edi
 49c:	56                   	push   %esi
 49d:	53                   	push   %ebx
 49e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4a1:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4a4:	a1 8c 06 00 00       	mov    0x68c,%eax
 4a9:	8d 76 00             	lea    0x0(%esi),%esi
 4ac:	89 c2                	mov    %eax,%edx
 4ae:	8b 00                	mov    (%eax),%eax
 4b0:	39 ca                	cmp    %ecx,%edx
 4b2:	73 2c                	jae    4e0 <free+0x48>
 4b4:	39 c1                	cmp    %eax,%ecx
 4b6:	72 04                	jb     4bc <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4b8:	39 c2                	cmp    %eax,%edx
 4ba:	72 f0                	jb     4ac <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4bc:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4bf:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4c2:	39 f8                	cmp    %edi,%eax
 4c4:	74 2c                	je     4f2 <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 4c6:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4c9:	8b 42 04             	mov    0x4(%edx),%eax
 4cc:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 4cf:	39 f1                	cmp    %esi,%ecx
 4d1:	74 36                	je     509 <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 4d3:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
 4d5:	89 15 8c 06 00 00    	mov    %edx,0x68c
}
 4db:	5b                   	pop    %ebx
 4dc:	5e                   	pop    %esi
 4dd:	5f                   	pop    %edi
 4de:	5d                   	pop    %ebp
 4df:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4e0:	39 c2                	cmp    %eax,%edx
 4e2:	72 c8                	jb     4ac <free+0x14>
 4e4:	39 c1                	cmp    %eax,%ecx
 4e6:	73 c4                	jae    4ac <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
 4e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4ee:	39 f8                	cmp    %edi,%eax
 4f0:	75 d4                	jne    4c6 <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
 4f2:	03 70 04             	add    0x4(%eax),%esi
 4f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 4f8:	8b 02                	mov    (%edx),%eax
 4fa:	8b 00                	mov    (%eax),%eax
 4fc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 4ff:	8b 42 04             	mov    0x4(%edx),%eax
 502:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 505:	39 f1                	cmp    %esi,%ecx
 507:	75 ca                	jne    4d3 <free+0x3b>
    p->s.size += bp->s.size;
 509:	03 43 fc             	add    -0x4(%ebx),%eax
 50c:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 50f:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 512:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 514:	89 15 8c 06 00 00    	mov    %edx,0x68c
}
 51a:	5b                   	pop    %ebx
 51b:	5e                   	pop    %esi
 51c:	5f                   	pop    %edi
 51d:	5d                   	pop    %ebp
 51e:	c3                   	ret    
 51f:	90                   	nop

00000520 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 529:	8b 45 08             	mov    0x8(%ebp),%eax
 52c:	8d 70 07             	lea    0x7(%eax),%esi
 52f:	c1 ee 03             	shr    $0x3,%esi
 532:	46                   	inc    %esi
  if((prevp = freep) == 0){
 533:	8b 3d 8c 06 00 00    	mov    0x68c,%edi
 539:	85 ff                	test   %edi,%edi
 53b:	0f 84 a3 00 00 00    	je     5e4 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 541:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 543:	8b 4a 04             	mov    0x4(%edx),%ecx
 546:	39 f1                	cmp    %esi,%ecx
 548:	73 68                	jae    5b2 <malloc+0x92>
 54a:	89 f3                	mov    %esi,%ebx
 54c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 552:	0f 82 80 00 00 00    	jb     5d8 <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
 558:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 55f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 562:	eb 11                	jmp    575 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 564:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 566:	8b 48 04             	mov    0x4(%eax),%ecx
 569:	39 f1                	cmp    %esi,%ecx
 56b:	73 4b                	jae    5b8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 56d:	8b 3d 8c 06 00 00    	mov    0x68c,%edi
 573:	89 c2                	mov    %eax,%edx
 575:	39 d7                	cmp    %edx,%edi
 577:	75 eb                	jne    564 <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
 579:	83 ec 0c             	sub    $0xc,%esp
 57c:	ff 75 e4             	push   -0x1c(%ebp)
 57f:	e8 07 fd ff ff       	call   28b <sbrk>
  if(p == (char*)-1)
 584:	83 c4 10             	add    $0x10,%esp
 587:	83 f8 ff             	cmp    $0xffffffff,%eax
 58a:	74 1c                	je     5a8 <malloc+0x88>
  hp->s.size = nu;
 58c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 58f:	83 ec 0c             	sub    $0xc,%esp
 592:	83 c0 08             	add    $0x8,%eax
 595:	50                   	push   %eax
 596:	e8 fd fe ff ff       	call   498 <free>
  return freep;
 59b:	8b 15 8c 06 00 00    	mov    0x68c,%edx
      if((p = morecore(nunits)) == 0)
 5a1:	83 c4 10             	add    $0x10,%esp
 5a4:	85 d2                	test   %edx,%edx
 5a6:	75 bc                	jne    564 <malloc+0x44>
        return 0;
 5a8:	31 c0                	xor    %eax,%eax
  }
}
 5aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ad:	5b                   	pop    %ebx
 5ae:	5e                   	pop    %esi
 5af:	5f                   	pop    %edi
 5b0:	5d                   	pop    %ebp
 5b1:	c3                   	ret    
    if(p->s.size >= nunits){
 5b2:	89 d0                	mov    %edx,%eax
 5b4:	89 fa                	mov    %edi,%edx
 5b6:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 5b8:	39 ce                	cmp    %ecx,%esi
 5ba:	74 54                	je     610 <malloc+0xf0>
        p->s.size -= nunits;
 5bc:	29 f1                	sub    %esi,%ecx
 5be:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5c1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5c4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 5c7:	89 15 8c 06 00 00    	mov    %edx,0x68c
      return (void*)(p + 1);
 5cd:	83 c0 08             	add    $0x8,%eax
}
 5d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5d3:	5b                   	pop    %ebx
 5d4:	5e                   	pop    %esi
 5d5:	5f                   	pop    %edi
 5d6:	5d                   	pop    %ebp
 5d7:	c3                   	ret    
 5d8:	bb 00 10 00 00       	mov    $0x1000,%ebx
 5dd:	e9 76 ff ff ff       	jmp    558 <malloc+0x38>
 5e2:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 5e4:	c7 05 8c 06 00 00 90 	movl   $0x690,0x68c
 5eb:	06 00 00 
 5ee:	c7 05 90 06 00 00 90 	movl   $0x690,0x690
 5f5:	06 00 00 
    base.s.size = 0;
 5f8:	c7 05 94 06 00 00 00 	movl   $0x0,0x694
 5ff:	00 00 00 
 602:	bf 90 06 00 00       	mov    $0x690,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 607:	89 fa                	mov    %edi,%edx
 609:	e9 3c ff ff ff       	jmp    54a <malloc+0x2a>
 60e:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 610:	8b 08                	mov    (%eax),%ecx
 612:	89 0a                	mov    %ecx,(%edx)
 614:	eb b1                	jmp    5c7 <malloc+0xa7>
