
_mkdir:     file format elf32-i386


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
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int i;

  if(argc < 2){
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 3c                	jle    5a <main+0x5a>
  1e:	83 c3 04             	add    $0x4,%ebx
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  21:	bf 01 00 00 00       	mov    $0x1,%edi
  26:	66 90                	xchg   %ax,%ax
    if(mkdir(argv[i]) < 0){
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 33                	push   (%ebx)
  2d:	e8 7d 02 00 00       	call   2af <mkdir>
  32:	83 c4 10             	add    $0x10,%esp
  35:	85 c0                	test   %eax,%eax
  37:	78 0d                	js     46 <main+0x46>
  for(i = 1; i < argc; i++){
  39:	47                   	inc    %edi
  3a:	83 c3 04             	add    $0x4,%ebx
  3d:	39 fe                	cmp    %edi,%esi
  3f:	75 e7                	jne    28 <main+0x28>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  41:	e8 01 02 00 00       	call   247 <exit>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  46:	50                   	push   %eax
  47:	ff 33                	push   (%ebx)
  49:	68 73 06 00 00       	push   $0x673
  4e:	6a 02                	push   $0x2
  50:	e8 23 03 00 00       	call   378 <printf>
      break;
  55:	83 c4 10             	add    $0x10,%esp
  58:	eb e7                	jmp    41 <main+0x41>
    printf(2, "Usage: mkdir files...\n");
  5a:	52                   	push   %edx
  5b:	52                   	push   %edx
  5c:	68 5c 06 00 00       	push   $0x65c
  61:	6a 02                	push   $0x2
  63:	e8 10 03 00 00       	call   378 <printf>
    exit();
  68:	e8 da 01 00 00       	call   247 <exit>
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 4d 08             	mov    0x8(%ebp),%ecx
  77:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	31 c0                	xor    %eax,%eax
  7c:	8a 14 03             	mov    (%ebx,%eax,1),%dl
  7f:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  82:	40                   	inc    %eax
  83:	84 d2                	test   %dl,%dl
  85:	75 f5                	jne    7c <strcpy+0xc>
    ;
  return os;
}
  87:	89 c8                	mov    %ecx,%eax
  89:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8c:	c9                   	leave  
  8d:	c3                   	ret    
  8e:	66 90                	xchg   %ax,%ax

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	75 10                	jne    b1 <strcmp+0x21>
  a1:	eb 2a                	jmp    cd <strcmp+0x3d>
  a3:	90                   	nop
    p++, q++;
  a4:	42                   	inc    %edx
  a5:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
  a8:	0f b6 02             	movzbl (%edx),%eax
  ab:	84 c0                	test   %al,%al
  ad:	74 11                	je     c0 <strcmp+0x30>
    p++, q++;
  af:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
  b1:	0f b6 0b             	movzbl (%ebx),%ecx
  b4:	38 c1                	cmp    %al,%cl
  b6:	74 ec                	je     a4 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  b8:	29 c8                	sub    %ecx,%eax
}
  ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  bd:	c9                   	leave  
  be:	c3                   	ret    
  bf:	90                   	nop
  return (uchar)*p - (uchar)*q;
  c0:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  c4:	31 c0                	xor    %eax,%eax
  c6:	29 c8                	sub    %ecx,%eax
}
  c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  cb:	c9                   	leave  
  cc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
  cd:	0f b6 0b             	movzbl (%ebx),%ecx
  d0:	31 c0                	xor    %eax,%eax
  d2:	eb e4                	jmp    b8 <strcmp+0x28>

000000d4 <strlen>:

uint
strlen(const char *s)
{
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  da:	80 3a 00             	cmpb   $0x0,(%edx)
  dd:	74 15                	je     f4 <strlen+0x20>
  df:	31 c0                	xor    %eax,%eax
  e1:	8d 76 00             	lea    0x0(%esi),%esi
  e4:	40                   	inc    %eax
  e5:	89 c1                	mov    %eax,%ecx
  e7:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  eb:	75 f7                	jne    e4 <strlen+0x10>
    ;
  return n;
}
  ed:	89 c8                	mov    %ecx,%eax
  ef:	5d                   	pop    %ebp
  f0:	c3                   	ret    
  f1:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  f4:	31 c9                	xor    %ecx,%ecx
}
  f6:	89 c8                	mov    %ecx,%eax
  f8:	5d                   	pop    %ebp
  f9:	c3                   	ret    
  fa:	66 90                	xchg   %ax,%ax

000000fc <memset>:

void*
memset(void *dst, int c, uint n)
{
  fc:	55                   	push   %ebp
  fd:	89 e5                	mov    %esp,%ebp
  ff:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 100:	8b 7d 08             	mov    0x8(%ebp),%edi
 103:	8b 4d 10             	mov    0x10(%ebp),%ecx
 106:	8b 45 0c             	mov    0xc(%ebp),%eax
 109:	fc                   	cld    
 10a:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 10c:	8b 45 08             	mov    0x8(%ebp),%eax
 10f:	8b 7d fc             	mov    -0x4(%ebp),%edi
 112:	c9                   	leave  
 113:	c3                   	ret    

00000114 <strchr>:

char*
strchr(const char *s, char c)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	8b 45 08             	mov    0x8(%ebp),%eax
 11a:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 11d:	8a 10                	mov    (%eax),%dl
 11f:	84 d2                	test   %dl,%dl
 121:	75 0c                	jne    12f <strchr+0x1b>
 123:	eb 13                	jmp    138 <strchr+0x24>
 125:	8d 76 00             	lea    0x0(%esi),%esi
 128:	40                   	inc    %eax
 129:	8a 10                	mov    (%eax),%dl
 12b:	84 d2                	test   %dl,%dl
 12d:	74 09                	je     138 <strchr+0x24>
    if(*s == c)
 12f:	38 d1                	cmp    %dl,%cl
 131:	75 f5                	jne    128 <strchr+0x14>
      return (char*)s;
  return 0;
}
 133:	5d                   	pop    %ebp
 134:	c3                   	ret    
 135:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 138:	31 c0                	xor    %eax,%eax
}
 13a:	5d                   	pop    %ebp
 13b:	c3                   	ret    

0000013c <gets>:

char*
gets(char *buf, int max)
{
 13c:	55                   	push   %ebp
 13d:	89 e5                	mov    %esp,%ebp
 13f:	57                   	push   %edi
 140:	56                   	push   %esi
 141:	53                   	push   %ebx
 142:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 145:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 147:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 14a:	eb 24                	jmp    170 <gets+0x34>
    cc = read(0, &c, 1);
 14c:	50                   	push   %eax
 14d:	6a 01                	push   $0x1
 14f:	57                   	push   %edi
 150:	6a 00                	push   $0x0
 152:	e8 08 01 00 00       	call   25f <read>
    if(cc < 1)
 157:	83 c4 10             	add    $0x10,%esp
 15a:	85 c0                	test   %eax,%eax
 15c:	7e 1c                	jle    17a <gets+0x3e>
      break;
    buf[i++] = c;
 15e:	8a 45 e7             	mov    -0x19(%ebp),%al
 161:	8b 55 08             	mov    0x8(%ebp),%edx
 164:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 168:	3c 0a                	cmp    $0xa,%al
 16a:	74 20                	je     18c <gets+0x50>
 16c:	3c 0d                	cmp    $0xd,%al
 16e:	74 1c                	je     18c <gets+0x50>
  for(i=0; i+1 < max; ){
 170:	89 de                	mov    %ebx,%esi
 172:	8d 5b 01             	lea    0x1(%ebx),%ebx
 175:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 178:	7c d2                	jl     14c <gets+0x10>
      break;
  }
  buf[i] = '\0';
 17a:	8b 45 08             	mov    0x8(%ebp),%eax
 17d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 181:	8d 65 f4             	lea    -0xc(%ebp),%esp
 184:	5b                   	pop    %ebx
 185:	5e                   	pop    %esi
 186:	5f                   	pop    %edi
 187:	5d                   	pop    %ebp
 188:	c3                   	ret    
 189:	8d 76 00             	lea    0x0(%esi),%esi
 18c:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 195:	8d 65 f4             	lea    -0xc(%ebp),%esp
 198:	5b                   	pop    %ebx
 199:	5e                   	pop    %esi
 19a:	5f                   	pop    %edi
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
 19d:	8d 76 00             	lea    0x0(%esi),%esi

000001a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	56                   	push   %esi
 1a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a5:	83 ec 08             	sub    $0x8,%esp
 1a8:	6a 00                	push   $0x0
 1aa:	ff 75 08             	push   0x8(%ebp)
 1ad:	e8 d5 00 00 00       	call   287 <open>
  if(fd < 0)
 1b2:	83 c4 10             	add    $0x10,%esp
 1b5:	85 c0                	test   %eax,%eax
 1b7:	78 27                	js     1e0 <stat+0x40>
 1b9:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1bb:	83 ec 08             	sub    $0x8,%esp
 1be:	ff 75 0c             	push   0xc(%ebp)
 1c1:	50                   	push   %eax
 1c2:	e8 d8 00 00 00       	call   29f <fstat>
 1c7:	89 c6                	mov    %eax,%esi
  close(fd);
 1c9:	89 1c 24             	mov    %ebx,(%esp)
 1cc:	e8 9e 00 00 00       	call   26f <close>
  return r;
 1d1:	83 c4 10             	add    $0x10,%esp
}
 1d4:	89 f0                	mov    %esi,%eax
 1d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1d9:	5b                   	pop    %ebx
 1da:	5e                   	pop    %esi
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1e5:	eb ed                	jmp    1d4 <stat+0x34>
 1e7:	90                   	nop

000001e8 <atoi>:

int
atoi(const char *s)
{
 1e8:	55                   	push   %ebp
 1e9:	89 e5                	mov    %esp,%ebp
 1eb:	53                   	push   %ebx
 1ec:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ef:	0f be 01             	movsbl (%ecx),%eax
 1f2:	8d 50 d0             	lea    -0x30(%eax),%edx
 1f5:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 1f8:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1fd:	77 16                	ja     215 <atoi+0x2d>
 1ff:	90                   	nop
    n = n*10 + *s++ - '0';
 200:	41                   	inc    %ecx
 201:	8d 14 92             	lea    (%edx,%edx,4),%edx
 204:	01 d2                	add    %edx,%edx
 206:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 20a:	0f be 01             	movsbl (%ecx),%eax
 20d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 210:	80 fb 09             	cmp    $0x9,%bl
 213:	76 eb                	jbe    200 <atoi+0x18>
  return n;
}
 215:	89 d0                	mov    %edx,%eax
 217:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 21a:	c9                   	leave  
 21b:	c3                   	ret    

0000021c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 21c:	55                   	push   %ebp
 21d:	89 e5                	mov    %esp,%ebp
 21f:	57                   	push   %edi
 220:	56                   	push   %esi
 221:	8b 55 08             	mov    0x8(%ebp),%edx
 224:	8b 75 0c             	mov    0xc(%ebp),%esi
 227:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 22a:	85 c0                	test   %eax,%eax
 22c:	7e 0b                	jle    239 <memmove+0x1d>
 22e:	01 d0                	add    %edx,%eax
  dst = vdst;
 230:	89 d7                	mov    %edx,%edi
 232:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 234:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 235:	39 f8                	cmp    %edi,%eax
 237:	75 fb                	jne    234 <memmove+0x18>
  return vdst;
}
 239:	89 d0                	mov    %edx,%eax
 23b:	5e                   	pop    %esi
 23c:	5f                   	pop    %edi
 23d:	5d                   	pop    %ebp
 23e:	c3                   	ret    

0000023f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 23f:	b8 01 00 00 00       	mov    $0x1,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <exit>:
SYSCALL(exit)
 247:	b8 02 00 00 00       	mov    $0x2,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <wait>:
SYSCALL(wait)
 24f:	b8 03 00 00 00       	mov    $0x3,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <pipe>:
SYSCALL(pipe)
 257:	b8 04 00 00 00       	mov    $0x4,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <read>:
SYSCALL(read)
 25f:	b8 05 00 00 00       	mov    $0x5,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <write>:
SYSCALL(write)
 267:	b8 10 00 00 00       	mov    $0x10,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <close>:
SYSCALL(close)
 26f:	b8 15 00 00 00       	mov    $0x15,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <kill>:
SYSCALL(kill)
 277:	b8 06 00 00 00       	mov    $0x6,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <exec>:
SYSCALL(exec)
 27f:	b8 07 00 00 00       	mov    $0x7,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <open>:
SYSCALL(open)
 287:	b8 0f 00 00 00       	mov    $0xf,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <mknod>:
SYSCALL(mknod)
 28f:	b8 11 00 00 00       	mov    $0x11,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <unlink>:
SYSCALL(unlink)
 297:	b8 12 00 00 00       	mov    $0x12,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <fstat>:
SYSCALL(fstat)
 29f:	b8 08 00 00 00       	mov    $0x8,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <link>:
SYSCALL(link)
 2a7:	b8 13 00 00 00       	mov    $0x13,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <mkdir>:
SYSCALL(mkdir)
 2af:	b8 14 00 00 00       	mov    $0x14,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <chdir>:
SYSCALL(chdir)
 2b7:	b8 09 00 00 00       	mov    $0x9,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <dup>:
SYSCALL(dup)
 2bf:	b8 0a 00 00 00       	mov    $0xa,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <getpid>:
SYSCALL(getpid)
 2c7:	b8 0b 00 00 00       	mov    $0xb,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <sbrk>:
SYSCALL(sbrk)
 2cf:	b8 0c 00 00 00       	mov    $0xc,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <sleep>:
SYSCALL(sleep)
 2d7:	b8 0d 00 00 00       	mov    $0xd,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <uptime>:
SYSCALL(uptime)
 2df:	b8 0e 00 00 00       	mov    $0xe,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <getprocs>:
SYSCALL(getprocs)
 2e7:	b8 16 00 00 00       	mov    $0x16,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    
 2ef:	90                   	nop

000002f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	56                   	push   %esi
 2f5:	53                   	push   %ebx
 2f6:	83 ec 3c             	sub    $0x3c,%esp
 2f9:	89 45 bc             	mov    %eax,-0x44(%ebp)
 2fc:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2ff:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
 301:	8b 5d 08             	mov    0x8(%ebp),%ebx
 304:	85 db                	test   %ebx,%ebx
 306:	74 04                	je     30c <printint+0x1c>
 308:	85 d2                	test   %edx,%edx
 30a:	78 68                	js     374 <printint+0x84>
  neg = 0;
 30c:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 313:	31 ff                	xor    %edi,%edi
 315:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 318:	89 c8                	mov    %ecx,%eax
 31a:	31 d2                	xor    %edx,%edx
 31c:	f7 75 c4             	divl   -0x3c(%ebp)
 31f:	89 fb                	mov    %edi,%ebx
 321:	8d 7f 01             	lea    0x1(%edi),%edi
 324:	8a 92 f0 06 00 00    	mov    0x6f0(%edx),%dl
 32a:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 32e:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 331:	89 c1                	mov    %eax,%ecx
 333:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 336:	3b 45 c0             	cmp    -0x40(%ebp),%eax
 339:	76 dd                	jbe    318 <printint+0x28>
  if(neg)
 33b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 33e:	85 c9                	test   %ecx,%ecx
 340:	74 09                	je     34b <printint+0x5b>
    buf[i++] = '-';
 342:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
 347:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
 349:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
 34b:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 34f:	8b 7d bc             	mov    -0x44(%ebp),%edi
 352:	eb 03                	jmp    357 <printint+0x67>
    putc(fd, buf[i]);
 354:	8a 13                	mov    (%ebx),%dl
 356:	4b                   	dec    %ebx
 357:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
 35a:	50                   	push   %eax
 35b:	6a 01                	push   $0x1
 35d:	56                   	push   %esi
 35e:	57                   	push   %edi
 35f:	e8 03 ff ff ff       	call   267 <write>
  while(--i >= 0)
 364:	83 c4 10             	add    $0x10,%esp
 367:	39 de                	cmp    %ebx,%esi
 369:	75 e9                	jne    354 <printint+0x64>
}
 36b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 36e:	5b                   	pop    %ebx
 36f:	5e                   	pop    %esi
 370:	5f                   	pop    %edi
 371:	5d                   	pop    %ebp
 372:	c3                   	ret    
 373:	90                   	nop
    x = -xx;
 374:	f7 d9                	neg    %ecx
 376:	eb 9b                	jmp    313 <printint+0x23>

00000378 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 378:	55                   	push   %ebp
 379:	89 e5                	mov    %esp,%ebp
 37b:	57                   	push   %edi
 37c:	56                   	push   %esi
 37d:	53                   	push   %ebx
 37e:	83 ec 2c             	sub    $0x2c,%esp
 381:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 384:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 387:	8a 13                	mov    (%ebx),%dl
 389:	84 d2                	test   %dl,%dl
 38b:	74 64                	je     3f1 <printf+0x79>
 38d:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 38e:	8d 45 10             	lea    0x10(%ebp),%eax
 391:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
 394:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
 396:	8d 7d e7             	lea    -0x19(%ebp),%edi
 399:	eb 24                	jmp    3bf <printf+0x47>
 39b:	90                   	nop
 39c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 39f:	83 f8 25             	cmp    $0x25,%eax
 3a2:	74 40                	je     3e4 <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
 3a4:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 3a7:	50                   	push   %eax
 3a8:	6a 01                	push   $0x1
 3aa:	57                   	push   %edi
 3ab:	56                   	push   %esi
 3ac:	e8 b6 fe ff ff       	call   267 <write>
        putc(fd, c);
 3b1:	83 c4 10             	add    $0x10,%esp
 3b4:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
 3b7:	43                   	inc    %ebx
 3b8:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3bb:	84 d2                	test   %dl,%dl
 3bd:	74 32                	je     3f1 <printf+0x79>
    c = fmt[i] & 0xff;
 3bf:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 3c2:	85 c9                	test   %ecx,%ecx
 3c4:	74 d6                	je     39c <printf+0x24>
      }
    } else if(state == '%'){
 3c6:	83 f9 25             	cmp    $0x25,%ecx
 3c9:	75 ec                	jne    3b7 <printf+0x3f>
      if(c == 'd'){
 3cb:	83 f8 25             	cmp    $0x25,%eax
 3ce:	0f 84 e4 00 00 00    	je     4b8 <printf+0x140>
 3d4:	83 e8 63             	sub    $0x63,%eax
 3d7:	83 f8 15             	cmp    $0x15,%eax
 3da:	77 20                	ja     3fc <printf+0x84>
 3dc:	ff 24 85 98 06 00 00 	jmp    *0x698(,%eax,4)
 3e3:	90                   	nop
        state = '%';
 3e4:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
 3e9:	43                   	inc    %ebx
 3ea:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3ed:	84 d2                	test   %dl,%dl
 3ef:	75 ce                	jne    3bf <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f4:	5b                   	pop    %ebx
 3f5:	5e                   	pop    %esi
 3f6:	5f                   	pop    %edi
 3f7:	5d                   	pop    %ebp
 3f8:	c3                   	ret    
 3f9:	8d 76 00             	lea    0x0(%esi),%esi
 3fc:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
 3ff:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 403:	50                   	push   %eax
 404:	6a 01                	push   $0x1
 406:	57                   	push   %edi
 407:	56                   	push   %esi
 408:	e8 5a fe ff ff       	call   267 <write>
        putc(fd, c);
 40d:	8a 55 d4             	mov    -0x2c(%ebp),%dl
 410:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 413:	83 c4 0c             	add    $0xc,%esp
 416:	6a 01                	push   $0x1
 418:	57                   	push   %edi
 419:	56                   	push   %esi
 41a:	e8 48 fe ff ff       	call   267 <write>
        putc(fd, c);
 41f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 422:	31 c9                	xor    %ecx,%ecx
 424:	eb 91                	jmp    3b7 <printf+0x3f>
 426:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 428:	83 ec 0c             	sub    $0xc,%esp
 42b:	6a 00                	push   $0x0
 42d:	b9 10 00 00 00       	mov    $0x10,%ecx
 432:	8b 45 d0             	mov    -0x30(%ebp),%eax
 435:	8b 10                	mov    (%eax),%edx
 437:	89 f0                	mov    %esi,%eax
 439:	e8 b2 fe ff ff       	call   2f0 <printint>
        ap++;
 43e:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 442:	83 c4 10             	add    $0x10,%esp
      state = 0;
 445:	31 c9                	xor    %ecx,%ecx
        ap++;
 447:	e9 6b ff ff ff       	jmp    3b7 <printf+0x3f>
        s = (char*)*ap;
 44c:	8b 45 d0             	mov    -0x30(%ebp),%eax
 44f:	8b 10                	mov    (%eax),%edx
        ap++;
 451:	83 c0 04             	add    $0x4,%eax
 454:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 457:	85 d2                	test   %edx,%edx
 459:	74 69                	je     4c4 <printf+0x14c>
        while(*s != 0){
 45b:	8a 02                	mov    (%edx),%al
 45d:	84 c0                	test   %al,%al
 45f:	74 71                	je     4d2 <printf+0x15a>
 461:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 464:	89 d3                	mov    %edx,%ebx
 466:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
 468:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 46b:	50                   	push   %eax
 46c:	6a 01                	push   $0x1
 46e:	57                   	push   %edi
 46f:	56                   	push   %esi
 470:	e8 f2 fd ff ff       	call   267 <write>
          s++;
 475:	43                   	inc    %ebx
        while(*s != 0){
 476:	8a 03                	mov    (%ebx),%al
 478:	83 c4 10             	add    $0x10,%esp
 47b:	84 c0                	test   %al,%al
 47d:	75 e9                	jne    468 <printf+0xf0>
      state = 0;
 47f:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 482:	31 c9                	xor    %ecx,%ecx
 484:	e9 2e ff ff ff       	jmp    3b7 <printf+0x3f>
 489:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 48c:	83 ec 0c             	sub    $0xc,%esp
 48f:	6a 01                	push   $0x1
 491:	b9 0a 00 00 00       	mov    $0xa,%ecx
 496:	eb 9a                	jmp    432 <printf+0xba>
        putc(fd, *ap);
 498:	8b 45 d0             	mov    -0x30(%ebp),%eax
 49b:	8b 00                	mov    (%eax),%eax
 49d:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 4a0:	51                   	push   %ecx
 4a1:	6a 01                	push   $0x1
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	e8 bd fd ff ff       	call   267 <write>
        ap++;
 4aa:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 4ae:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4b1:	31 c9                	xor    %ecx,%ecx
 4b3:	e9 ff fe ff ff       	jmp    3b7 <printf+0x3f>
        putc(fd, c);
 4b8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4bb:	52                   	push   %edx
 4bc:	e9 55 ff ff ff       	jmp    416 <printf+0x9e>
 4c1:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
 4c4:	ba 8f 06 00 00       	mov    $0x68f,%edx
        while(*s != 0){
 4c9:	b0 28                	mov    $0x28,%al
 4cb:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 4ce:	89 d3                	mov    %edx,%ebx
 4d0:	eb 96                	jmp    468 <printf+0xf0>
      state = 0;
 4d2:	31 c9                	xor    %ecx,%ecx
 4d4:	e9 de fe ff ff       	jmp    3b7 <printf+0x3f>
 4d9:	66 90                	xchg   %ax,%ax
 4db:	90                   	nop

000004dc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4dc:	55                   	push   %ebp
 4dd:	89 e5                	mov    %esp,%ebp
 4df:	57                   	push   %edi
 4e0:	56                   	push   %esi
 4e1:	53                   	push   %ebx
 4e2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4e5:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4e8:	a1 04 07 00 00       	mov    0x704,%eax
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
 4f0:	89 c2                	mov    %eax,%edx
 4f2:	8b 00                	mov    (%eax),%eax
 4f4:	39 ca                	cmp    %ecx,%edx
 4f6:	73 2c                	jae    524 <free+0x48>
 4f8:	39 c1                	cmp    %eax,%ecx
 4fa:	72 04                	jb     500 <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4fc:	39 c2                	cmp    %eax,%edx
 4fe:	72 f0                	jb     4f0 <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
 500:	8b 73 fc             	mov    -0x4(%ebx),%esi
 503:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 506:	39 f8                	cmp    %edi,%eax
 508:	74 2c                	je     536 <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 50a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 50d:	8b 42 04             	mov    0x4(%edx),%eax
 510:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 513:	39 f1                	cmp    %esi,%ecx
 515:	74 36                	je     54d <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 517:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
 519:	89 15 04 07 00 00    	mov    %edx,0x704
}
 51f:	5b                   	pop    %ebx
 520:	5e                   	pop    %esi
 521:	5f                   	pop    %edi
 522:	5d                   	pop    %ebp
 523:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 524:	39 c2                	cmp    %eax,%edx
 526:	72 c8                	jb     4f0 <free+0x14>
 528:	39 c1                	cmp    %eax,%ecx
 52a:	73 c4                	jae    4f0 <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
 52c:	8b 73 fc             	mov    -0x4(%ebx),%esi
 52f:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 532:	39 f8                	cmp    %edi,%eax
 534:	75 d4                	jne    50a <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
 536:	03 70 04             	add    0x4(%eax),%esi
 539:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 53c:	8b 02                	mov    (%edx),%eax
 53e:	8b 00                	mov    (%eax),%eax
 540:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 543:	8b 42 04             	mov    0x4(%edx),%eax
 546:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 549:	39 f1                	cmp    %esi,%ecx
 54b:	75 ca                	jne    517 <free+0x3b>
    p->s.size += bp->s.size;
 54d:	03 43 fc             	add    -0x4(%ebx),%eax
 550:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 553:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 556:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 558:	89 15 04 07 00 00    	mov    %edx,0x704
}
 55e:	5b                   	pop    %ebx
 55f:	5e                   	pop    %esi
 560:	5f                   	pop    %edi
 561:	5d                   	pop    %ebp
 562:	c3                   	ret    
 563:	90                   	nop

00000564 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 564:	55                   	push   %ebp
 565:	89 e5                	mov    %esp,%ebp
 567:	57                   	push   %edi
 568:	56                   	push   %esi
 569:	53                   	push   %ebx
 56a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 56d:	8b 45 08             	mov    0x8(%ebp),%eax
 570:	8d 70 07             	lea    0x7(%eax),%esi
 573:	c1 ee 03             	shr    $0x3,%esi
 576:	46                   	inc    %esi
  if((prevp = freep) == 0){
 577:	8b 3d 04 07 00 00    	mov    0x704,%edi
 57d:	85 ff                	test   %edi,%edi
 57f:	0f 84 a3 00 00 00    	je     628 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 585:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 587:	8b 4a 04             	mov    0x4(%edx),%ecx
 58a:	39 f1                	cmp    %esi,%ecx
 58c:	73 68                	jae    5f6 <malloc+0x92>
 58e:	89 f3                	mov    %esi,%ebx
 590:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 596:	0f 82 80 00 00 00    	jb     61c <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
 59c:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 5a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 5a6:	eb 11                	jmp    5b9 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5aa:	8b 48 04             	mov    0x4(%eax),%ecx
 5ad:	39 f1                	cmp    %esi,%ecx
 5af:	73 4b                	jae    5fc <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5b1:	8b 3d 04 07 00 00    	mov    0x704,%edi
 5b7:	89 c2                	mov    %eax,%edx
 5b9:	39 d7                	cmp    %edx,%edi
 5bb:	75 eb                	jne    5a8 <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
 5bd:	83 ec 0c             	sub    $0xc,%esp
 5c0:	ff 75 e4             	push   -0x1c(%ebp)
 5c3:	e8 07 fd ff ff       	call   2cf <sbrk>
  if(p == (char*)-1)
 5c8:	83 c4 10             	add    $0x10,%esp
 5cb:	83 f8 ff             	cmp    $0xffffffff,%eax
 5ce:	74 1c                	je     5ec <malloc+0x88>
  hp->s.size = nu;
 5d0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 5d3:	83 ec 0c             	sub    $0xc,%esp
 5d6:	83 c0 08             	add    $0x8,%eax
 5d9:	50                   	push   %eax
 5da:	e8 fd fe ff ff       	call   4dc <free>
  return freep;
 5df:	8b 15 04 07 00 00    	mov    0x704,%edx
      if((p = morecore(nunits)) == 0)
 5e5:	83 c4 10             	add    $0x10,%esp
 5e8:	85 d2                	test   %edx,%edx
 5ea:	75 bc                	jne    5a8 <malloc+0x44>
        return 0;
 5ec:	31 c0                	xor    %eax,%eax
  }
}
 5ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f1:	5b                   	pop    %ebx
 5f2:	5e                   	pop    %esi
 5f3:	5f                   	pop    %edi
 5f4:	5d                   	pop    %ebp
 5f5:	c3                   	ret    
    if(p->s.size >= nunits){
 5f6:	89 d0                	mov    %edx,%eax
 5f8:	89 fa                	mov    %edi,%edx
 5fa:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 5fc:	39 ce                	cmp    %ecx,%esi
 5fe:	74 54                	je     654 <malloc+0xf0>
        p->s.size -= nunits;
 600:	29 f1                	sub    %esi,%ecx
 602:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 605:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 608:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 60b:	89 15 04 07 00 00    	mov    %edx,0x704
      return (void*)(p + 1);
 611:	83 c0 08             	add    $0x8,%eax
}
 614:	8d 65 f4             	lea    -0xc(%ebp),%esp
 617:	5b                   	pop    %ebx
 618:	5e                   	pop    %esi
 619:	5f                   	pop    %edi
 61a:	5d                   	pop    %ebp
 61b:	c3                   	ret    
 61c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 621:	e9 76 ff ff ff       	jmp    59c <malloc+0x38>
 626:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 628:	c7 05 04 07 00 00 08 	movl   $0x708,0x704
 62f:	07 00 00 
 632:	c7 05 08 07 00 00 08 	movl   $0x708,0x708
 639:	07 00 00 
    base.s.size = 0;
 63c:	c7 05 0c 07 00 00 00 	movl   $0x0,0x70c
 643:	00 00 00 
 646:	bf 08 07 00 00       	mov    $0x708,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 64b:	89 fa                	mov    %edi,%edx
 64d:	e9 3c ff ff ff       	jmp    58e <malloc+0x2a>
 652:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 654:	8b 08                	mov    (%eax),%ecx
 656:	89 0a                	mov    %ecx,(%edx)
 658:	eb b1                	jmp    60b <malloc+0xa7>
