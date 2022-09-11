
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

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
  11:	81 ec 20 02 00 00    	sub    $0x220,%esp
  int fd, i;
  char path[] = "stressfs0";
  17:	be 1f 07 00 00       	mov    $0x71f,%esi
  1c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  21:	8d bd de fd ff ff    	lea    -0x222(%ebp),%edi
  27:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  char data[512];

  printf(1, "stressfs starting\n");
  29:	68 fc 06 00 00       	push   $0x6fc
  2e:	6a 01                	push   $0x1
  30:	e8 e3 03 00 00       	call   418 <printf>
  memset(data, 'a', sizeof(data));
  35:	83 c4 0c             	add    $0xc,%esp
  38:	68 00 02 00 00       	push   $0x200
  3d:	6a 61                	push   $0x61
  3f:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
  45:	56                   	push   %esi
  46:	e8 51 01 00 00       	call   19c <memset>
  4b:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  4e:	31 db                	xor    %ebx,%ebx
    if(fork() > 0)
  50:	e8 8a 02 00 00       	call   2df <fork>
  55:	85 c0                	test   %eax,%eax
  57:	0f 8f a9 00 00 00    	jg     106 <main+0x106>
  for(i = 0; i < 4; i++)
  5d:	43                   	inc    %ebx
  5e:	83 fb 04             	cmp    $0x4,%ebx
  61:	75 ed                	jne    50 <main+0x50>
  63:	bf 04 00 00 00       	mov    $0x4,%edi
      break;

  printf(1, "write %d\n", i);
  68:	50                   	push   %eax
  69:	53                   	push   %ebx
  6a:	68 0f 07 00 00       	push   $0x70f
  6f:	6a 01                	push   $0x1
  71:	e8 a2 03 00 00       	call   418 <printf>

  path[8] += i;
  76:	89 f8                	mov    %edi,%eax
  78:	00 85 e6 fd ff ff    	add    %al,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  7e:	58                   	pop    %eax
  7f:	5a                   	pop    %edx
  80:	68 02 02 00 00       	push   $0x202
  85:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  8b:	50                   	push   %eax
  8c:	e8 96 02 00 00       	call   327 <open>
  91:	89 c7                	mov    %eax,%edi
  93:	83 c4 10             	add    $0x10,%esp
  96:	bb 14 00 00 00       	mov    $0x14,%ebx
  9b:	90                   	nop
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  9c:	50                   	push   %eax
  9d:	68 00 02 00 00       	push   $0x200
  a2:	56                   	push   %esi
  a3:	57                   	push   %edi
  a4:	e8 5e 02 00 00       	call   307 <write>
  for(i = 0; i < 20; i++)
  a9:	83 c4 10             	add    $0x10,%esp
  ac:	4b                   	dec    %ebx
  ad:	75 ed                	jne    9c <main+0x9c>
  close(fd);
  af:	83 ec 0c             	sub    $0xc,%esp
  b2:	57                   	push   %edi
  b3:	e8 57 02 00 00       	call   30f <close>

  printf(1, "read\n");
  b8:	5a                   	pop    %edx
  b9:	59                   	pop    %ecx
  ba:	68 19 07 00 00       	push   $0x719
  bf:	6a 01                	push   $0x1
  c1:	e8 52 03 00 00       	call   418 <printf>

  fd = open(path, O_RDONLY);
  c6:	5b                   	pop    %ebx
  c7:	5f                   	pop    %edi
  c8:	6a 00                	push   $0x0
  ca:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  d0:	50                   	push   %eax
  d1:	e8 51 02 00 00       	call   327 <open>
  d6:	89 c7                	mov    %eax,%edi
  d8:	83 c4 10             	add    $0x10,%esp
  db:	bb 14 00 00 00       	mov    $0x14,%ebx
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  e0:	50                   	push   %eax
  e1:	68 00 02 00 00       	push   $0x200
  e6:	56                   	push   %esi
  e7:	57                   	push   %edi
  e8:	e8 12 02 00 00       	call   2ff <read>
  for (i = 0; i < 20; i++)
  ed:	83 c4 10             	add    $0x10,%esp
  f0:	4b                   	dec    %ebx
  f1:	75 ed                	jne    e0 <main+0xe0>
  close(fd);
  f3:	83 ec 0c             	sub    $0xc,%esp
  f6:	57                   	push   %edi
  f7:	e8 13 02 00 00       	call   30f <close>

  wait();
  fc:	e8 ee 01 00 00       	call   2ef <wait>

  exit();
 101:	e8 e1 01 00 00       	call   2e7 <exit>
  path[8] += i;
 106:	89 df                	mov    %ebx,%edi
 108:	e9 5b ff ff ff       	jmp    68 <main+0x68>
 10d:	66 90                	xchg   %ax,%ax
 10f:	90                   	nop

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 4d 08             	mov    0x8(%ebp),%ecx
 117:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	31 c0                	xor    %eax,%eax
 11c:	8a 14 03             	mov    (%ebx,%eax,1),%dl
 11f:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 122:	40                   	inc    %eax
 123:	84 d2                	test   %dl,%dl
 125:	75 f5                	jne    11c <strcpy+0xc>
    ;
  return os;
}
 127:	89 c8                	mov    %ecx,%eax
 129:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 12c:	c9                   	leave  
 12d:	c3                   	ret    
 12e:	66 90                	xchg   %ax,%ax

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 55 08             	mov    0x8(%ebp),%edx
 137:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 13a:	0f b6 02             	movzbl (%edx),%eax
 13d:	84 c0                	test   %al,%al
 13f:	75 10                	jne    151 <strcmp+0x21>
 141:	eb 2a                	jmp    16d <strcmp+0x3d>
 143:	90                   	nop
    p++, q++;
 144:	42                   	inc    %edx
 145:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
 148:	0f b6 02             	movzbl (%edx),%eax
 14b:	84 c0                	test   %al,%al
 14d:	74 11                	je     160 <strcmp+0x30>
    p++, q++;
 14f:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
 151:	0f b6 0b             	movzbl (%ebx),%ecx
 154:	38 c1                	cmp    %al,%cl
 156:	74 ec                	je     144 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 158:	29 c8                	sub    %ecx,%eax
}
 15a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 15d:	c9                   	leave  
 15e:	c3                   	ret    
 15f:	90                   	nop
  return (uchar)*p - (uchar)*q;
 160:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 164:	31 c0                	xor    %eax,%eax
 166:	29 c8                	sub    %ecx,%eax
}
 168:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 16b:	c9                   	leave  
 16c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 16d:	0f b6 0b             	movzbl (%ebx),%ecx
 170:	31 c0                	xor    %eax,%eax
 172:	eb e4                	jmp    158 <strcmp+0x28>

00000174 <strlen>:

uint
strlen(const char *s)
{
 174:	55                   	push   %ebp
 175:	89 e5                	mov    %esp,%ebp
 177:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 17a:	80 3a 00             	cmpb   $0x0,(%edx)
 17d:	74 15                	je     194 <strlen+0x20>
 17f:	31 c0                	xor    %eax,%eax
 181:	8d 76 00             	lea    0x0(%esi),%esi
 184:	40                   	inc    %eax
 185:	89 c1                	mov    %eax,%ecx
 187:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 18b:	75 f7                	jne    184 <strlen+0x10>
    ;
  return n;
}
 18d:	89 c8                	mov    %ecx,%eax
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    
 191:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 194:	31 c9                	xor    %ecx,%ecx
}
 196:	89 c8                	mov    %ecx,%eax
 198:	5d                   	pop    %ebp
 199:	c3                   	ret    
 19a:	66 90                	xchg   %ax,%ax

0000019c <memset>:

void*
memset(void *dst, int c, uint n)
{
 19c:	55                   	push   %ebp
 19d:	89 e5                	mov    %esp,%ebp
 19f:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a0:	8b 7d 08             	mov    0x8(%ebp),%edi
 1a3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a9:	fc                   	cld    
 1aa:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1ac:	8b 45 08             	mov    0x8(%ebp),%eax
 1af:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1b2:	c9                   	leave  
 1b3:	c3                   	ret    

000001b4 <strchr>:

char*
strchr(const char *s, char c)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 1bd:	8a 10                	mov    (%eax),%dl
 1bf:	84 d2                	test   %dl,%dl
 1c1:	75 0c                	jne    1cf <strchr+0x1b>
 1c3:	eb 13                	jmp    1d8 <strchr+0x24>
 1c5:	8d 76 00             	lea    0x0(%esi),%esi
 1c8:	40                   	inc    %eax
 1c9:	8a 10                	mov    (%eax),%dl
 1cb:	84 d2                	test   %dl,%dl
 1cd:	74 09                	je     1d8 <strchr+0x24>
    if(*s == c)
 1cf:	38 d1                	cmp    %dl,%cl
 1d1:	75 f5                	jne    1c8 <strchr+0x14>
      return (char*)s;
  return 0;
}
 1d3:	5d                   	pop    %ebp
 1d4:	c3                   	ret    
 1d5:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 1d8:	31 c0                	xor    %eax,%eax
}
 1da:	5d                   	pop    %ebp
 1db:	c3                   	ret    

000001dc <gets>:

char*
gets(char *buf, int max)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	57                   	push   %edi
 1e0:	56                   	push   %esi
 1e1:	53                   	push   %ebx
 1e2:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e5:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 1e7:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1ea:	eb 24                	jmp    210 <gets+0x34>
    cc = read(0, &c, 1);
 1ec:	50                   	push   %eax
 1ed:	6a 01                	push   $0x1
 1ef:	57                   	push   %edi
 1f0:	6a 00                	push   $0x0
 1f2:	e8 08 01 00 00       	call   2ff <read>
    if(cc < 1)
 1f7:	83 c4 10             	add    $0x10,%esp
 1fa:	85 c0                	test   %eax,%eax
 1fc:	7e 1c                	jle    21a <gets+0x3e>
      break;
    buf[i++] = c;
 1fe:	8a 45 e7             	mov    -0x19(%ebp),%al
 201:	8b 55 08             	mov    0x8(%ebp),%edx
 204:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 208:	3c 0a                	cmp    $0xa,%al
 20a:	74 20                	je     22c <gets+0x50>
 20c:	3c 0d                	cmp    $0xd,%al
 20e:	74 1c                	je     22c <gets+0x50>
  for(i=0; i+1 < max; ){
 210:	89 de                	mov    %ebx,%esi
 212:	8d 5b 01             	lea    0x1(%ebx),%ebx
 215:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 218:	7c d2                	jl     1ec <gets+0x10>
      break;
  }
  buf[i] = '\0';
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 221:	8d 65 f4             	lea    -0xc(%ebp),%esp
 224:	5b                   	pop    %ebx
 225:	5e                   	pop    %esi
 226:	5f                   	pop    %edi
 227:	5d                   	pop    %ebp
 228:	c3                   	ret    
 229:	8d 76 00             	lea    0x0(%esi),%esi
 22c:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 22e:	8b 45 08             	mov    0x8(%ebp),%eax
 231:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 235:	8d 65 f4             	lea    -0xc(%ebp),%esp
 238:	5b                   	pop    %ebx
 239:	5e                   	pop    %esi
 23a:	5f                   	pop    %edi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi

00000240 <stat>:

int
stat(const char *n, struct stat *st)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	56                   	push   %esi
 244:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 245:	83 ec 08             	sub    $0x8,%esp
 248:	6a 00                	push   $0x0
 24a:	ff 75 08             	push   0x8(%ebp)
 24d:	e8 d5 00 00 00       	call   327 <open>
  if(fd < 0)
 252:	83 c4 10             	add    $0x10,%esp
 255:	85 c0                	test   %eax,%eax
 257:	78 27                	js     280 <stat+0x40>
 259:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 25b:	83 ec 08             	sub    $0x8,%esp
 25e:	ff 75 0c             	push   0xc(%ebp)
 261:	50                   	push   %eax
 262:	e8 d8 00 00 00       	call   33f <fstat>
 267:	89 c6                	mov    %eax,%esi
  close(fd);
 269:	89 1c 24             	mov    %ebx,(%esp)
 26c:	e8 9e 00 00 00       	call   30f <close>
  return r;
 271:	83 c4 10             	add    $0x10,%esp
}
 274:	89 f0                	mov    %esi,%eax
 276:	8d 65 f8             	lea    -0x8(%ebp),%esp
 279:	5b                   	pop    %ebx
 27a:	5e                   	pop    %esi
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret    
 27d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 280:	be ff ff ff ff       	mov    $0xffffffff,%esi
 285:	eb ed                	jmp    274 <stat+0x34>
 287:	90                   	nop

00000288 <atoi>:

int
atoi(const char *s)
{
 288:	55                   	push   %ebp
 289:	89 e5                	mov    %esp,%ebp
 28b:	53                   	push   %ebx
 28c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 28f:	0f be 01             	movsbl (%ecx),%eax
 292:	8d 50 d0             	lea    -0x30(%eax),%edx
 295:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 298:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 29d:	77 16                	ja     2b5 <atoi+0x2d>
 29f:	90                   	nop
    n = n*10 + *s++ - '0';
 2a0:	41                   	inc    %ecx
 2a1:	8d 14 92             	lea    (%edx,%edx,4),%edx
 2a4:	01 d2                	add    %edx,%edx
 2a6:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 2aa:	0f be 01             	movsbl (%ecx),%eax
 2ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2b0:	80 fb 09             	cmp    $0x9,%bl
 2b3:	76 eb                	jbe    2a0 <atoi+0x18>
  return n;
}
 2b5:	89 d0                	mov    %edx,%eax
 2b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2ba:	c9                   	leave  
 2bb:	c3                   	ret    

000002bc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2bc:	55                   	push   %ebp
 2bd:	89 e5                	mov    %esp,%ebp
 2bf:	57                   	push   %edi
 2c0:	56                   	push   %esi
 2c1:	8b 55 08             	mov    0x8(%ebp),%edx
 2c4:	8b 75 0c             	mov    0xc(%ebp),%esi
 2c7:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ca:	85 c0                	test   %eax,%eax
 2cc:	7e 0b                	jle    2d9 <memmove+0x1d>
 2ce:	01 d0                	add    %edx,%eax
  dst = vdst;
 2d0:	89 d7                	mov    %edx,%edi
 2d2:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 2d4:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2d5:	39 f8                	cmp    %edi,%eax
 2d7:	75 fb                	jne    2d4 <memmove+0x18>
  return vdst;
}
 2d9:	89 d0                	mov    %edx,%eax
 2db:	5e                   	pop    %esi
 2dc:	5f                   	pop    %edi
 2dd:	5d                   	pop    %ebp
 2de:	c3                   	ret    

000002df <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2df:	b8 01 00 00 00       	mov    $0x1,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <exit>:
SYSCALL(exit)
 2e7:	b8 02 00 00 00       	mov    $0x2,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <wait>:
SYSCALL(wait)
 2ef:	b8 03 00 00 00       	mov    $0x3,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <pipe>:
SYSCALL(pipe)
 2f7:	b8 04 00 00 00       	mov    $0x4,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <read>:
SYSCALL(read)
 2ff:	b8 05 00 00 00       	mov    $0x5,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <write>:
SYSCALL(write)
 307:	b8 10 00 00 00       	mov    $0x10,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <close>:
SYSCALL(close)
 30f:	b8 15 00 00 00       	mov    $0x15,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <kill>:
SYSCALL(kill)
 317:	b8 06 00 00 00       	mov    $0x6,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <exec>:
SYSCALL(exec)
 31f:	b8 07 00 00 00       	mov    $0x7,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <open>:
SYSCALL(open)
 327:	b8 0f 00 00 00       	mov    $0xf,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <mknod>:
SYSCALL(mknod)
 32f:	b8 11 00 00 00       	mov    $0x11,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <unlink>:
SYSCALL(unlink)
 337:	b8 12 00 00 00       	mov    $0x12,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <fstat>:
SYSCALL(fstat)
 33f:	b8 08 00 00 00       	mov    $0x8,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <link>:
SYSCALL(link)
 347:	b8 13 00 00 00       	mov    $0x13,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <mkdir>:
SYSCALL(mkdir)
 34f:	b8 14 00 00 00       	mov    $0x14,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <chdir>:
SYSCALL(chdir)
 357:	b8 09 00 00 00       	mov    $0x9,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <dup>:
SYSCALL(dup)
 35f:	b8 0a 00 00 00       	mov    $0xa,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <getpid>:
SYSCALL(getpid)
 367:	b8 0b 00 00 00       	mov    $0xb,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <sbrk>:
SYSCALL(sbrk)
 36f:	b8 0c 00 00 00       	mov    $0xc,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <sleep>:
SYSCALL(sleep)
 377:	b8 0d 00 00 00       	mov    $0xd,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <uptime>:
SYSCALL(uptime)
 37f:	b8 0e 00 00 00       	mov    $0xe,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <getprocs>:
SYSCALL(getprocs)
 387:	b8 16 00 00 00       	mov    $0x16,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    
 38f:	90                   	nop

00000390 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	83 ec 3c             	sub    $0x3c,%esp
 399:	89 45 bc             	mov    %eax,-0x44(%ebp)
 39c:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 39f:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
 3a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3a4:	85 db                	test   %ebx,%ebx
 3a6:	74 04                	je     3ac <printint+0x1c>
 3a8:	85 d2                	test   %edx,%edx
 3aa:	78 68                	js     414 <printint+0x84>
  neg = 0;
 3ac:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3b3:	31 ff                	xor    %edi,%edi
 3b5:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 3b8:	89 c8                	mov    %ecx,%eax
 3ba:	31 d2                	xor    %edx,%edx
 3bc:	f7 75 c4             	divl   -0x3c(%ebp)
 3bf:	89 fb                	mov    %edi,%ebx
 3c1:	8d 7f 01             	lea    0x1(%edi),%edi
 3c4:	8a 92 88 07 00 00    	mov    0x788(%edx),%dl
 3ca:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 3ce:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 3d1:	89 c1                	mov    %eax,%ecx
 3d3:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3d6:	3b 45 c0             	cmp    -0x40(%ebp),%eax
 3d9:	76 dd                	jbe    3b8 <printint+0x28>
  if(neg)
 3db:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3de:	85 c9                	test   %ecx,%ecx
 3e0:	74 09                	je     3eb <printint+0x5b>
    buf[i++] = '-';
 3e2:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
 3e7:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
 3e9:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
 3eb:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 3ef:	8b 7d bc             	mov    -0x44(%ebp),%edi
 3f2:	eb 03                	jmp    3f7 <printint+0x67>
    putc(fd, buf[i]);
 3f4:	8a 13                	mov    (%ebx),%dl
 3f6:	4b                   	dec    %ebx
 3f7:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
 3fa:	50                   	push   %eax
 3fb:	6a 01                	push   $0x1
 3fd:	56                   	push   %esi
 3fe:	57                   	push   %edi
 3ff:	e8 03 ff ff ff       	call   307 <write>
  while(--i >= 0)
 404:	83 c4 10             	add    $0x10,%esp
 407:	39 de                	cmp    %ebx,%esi
 409:	75 e9                	jne    3f4 <printint+0x64>
}
 40b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 40e:	5b                   	pop    %ebx
 40f:	5e                   	pop    %esi
 410:	5f                   	pop    %edi
 411:	5d                   	pop    %ebp
 412:	c3                   	ret    
 413:	90                   	nop
    x = -xx;
 414:	f7 d9                	neg    %ecx
 416:	eb 9b                	jmp    3b3 <printint+0x23>

00000418 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 418:	55                   	push   %ebp
 419:	89 e5                	mov    %esp,%ebp
 41b:	57                   	push   %edi
 41c:	56                   	push   %esi
 41d:	53                   	push   %ebx
 41e:	83 ec 2c             	sub    $0x2c,%esp
 421:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 424:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 427:	8a 13                	mov    (%ebx),%dl
 429:	84 d2                	test   %dl,%dl
 42b:	74 64                	je     491 <printf+0x79>
 42d:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 42e:	8d 45 10             	lea    0x10(%ebp),%eax
 431:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
 434:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
 436:	8d 7d e7             	lea    -0x19(%ebp),%edi
 439:	eb 24                	jmp    45f <printf+0x47>
 43b:	90                   	nop
 43c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 43f:	83 f8 25             	cmp    $0x25,%eax
 442:	74 40                	je     484 <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
 444:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 447:	50                   	push   %eax
 448:	6a 01                	push   $0x1
 44a:	57                   	push   %edi
 44b:	56                   	push   %esi
 44c:	e8 b6 fe ff ff       	call   307 <write>
        putc(fd, c);
 451:	83 c4 10             	add    $0x10,%esp
 454:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
 457:	43                   	inc    %ebx
 458:	8a 53 ff             	mov    -0x1(%ebx),%dl
 45b:	84 d2                	test   %dl,%dl
 45d:	74 32                	je     491 <printf+0x79>
    c = fmt[i] & 0xff;
 45f:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 462:	85 c9                	test   %ecx,%ecx
 464:	74 d6                	je     43c <printf+0x24>
      }
    } else if(state == '%'){
 466:	83 f9 25             	cmp    $0x25,%ecx
 469:	75 ec                	jne    457 <printf+0x3f>
      if(c == 'd'){
 46b:	83 f8 25             	cmp    $0x25,%eax
 46e:	0f 84 e4 00 00 00    	je     558 <printf+0x140>
 474:	83 e8 63             	sub    $0x63,%eax
 477:	83 f8 15             	cmp    $0x15,%eax
 47a:	77 20                	ja     49c <printf+0x84>
 47c:	ff 24 85 30 07 00 00 	jmp    *0x730(,%eax,4)
 483:	90                   	nop
        state = '%';
 484:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
 489:	43                   	inc    %ebx
 48a:	8a 53 ff             	mov    -0x1(%ebx),%dl
 48d:	84 d2                	test   %dl,%dl
 48f:	75 ce                	jne    45f <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 491:	8d 65 f4             	lea    -0xc(%ebp),%esp
 494:	5b                   	pop    %ebx
 495:	5e                   	pop    %esi
 496:	5f                   	pop    %edi
 497:	5d                   	pop    %ebp
 498:	c3                   	ret    
 499:	8d 76 00             	lea    0x0(%esi),%esi
 49c:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
 49f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 4a3:	50                   	push   %eax
 4a4:	6a 01                	push   $0x1
 4a6:	57                   	push   %edi
 4a7:	56                   	push   %esi
 4a8:	e8 5a fe ff ff       	call   307 <write>
        putc(fd, c);
 4ad:	8a 55 d4             	mov    -0x2c(%ebp),%dl
 4b0:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4b3:	83 c4 0c             	add    $0xc,%esp
 4b6:	6a 01                	push   $0x1
 4b8:	57                   	push   %edi
 4b9:	56                   	push   %esi
 4ba:	e8 48 fe ff ff       	call   307 <write>
        putc(fd, c);
 4bf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4c2:	31 c9                	xor    %ecx,%ecx
 4c4:	eb 91                	jmp    457 <printf+0x3f>
 4c6:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 4c8:	83 ec 0c             	sub    $0xc,%esp
 4cb:	6a 00                	push   $0x0
 4cd:	b9 10 00 00 00       	mov    $0x10,%ecx
 4d2:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4d5:	8b 10                	mov    (%eax),%edx
 4d7:	89 f0                	mov    %esi,%eax
 4d9:	e8 b2 fe ff ff       	call   390 <printint>
        ap++;
 4de:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 4e2:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4e5:	31 c9                	xor    %ecx,%ecx
        ap++;
 4e7:	e9 6b ff ff ff       	jmp    457 <printf+0x3f>
        s = (char*)*ap;
 4ec:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4ef:	8b 10                	mov    (%eax),%edx
        ap++;
 4f1:	83 c0 04             	add    $0x4,%eax
 4f4:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 4f7:	85 d2                	test   %edx,%edx
 4f9:	74 69                	je     564 <printf+0x14c>
        while(*s != 0){
 4fb:	8a 02                	mov    (%edx),%al
 4fd:	84 c0                	test   %al,%al
 4ff:	74 71                	je     572 <printf+0x15a>
 501:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 504:	89 d3                	mov    %edx,%ebx
 506:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
 508:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 50b:	50                   	push   %eax
 50c:	6a 01                	push   $0x1
 50e:	57                   	push   %edi
 50f:	56                   	push   %esi
 510:	e8 f2 fd ff ff       	call   307 <write>
          s++;
 515:	43                   	inc    %ebx
        while(*s != 0){
 516:	8a 03                	mov    (%ebx),%al
 518:	83 c4 10             	add    $0x10,%esp
 51b:	84 c0                	test   %al,%al
 51d:	75 e9                	jne    508 <printf+0xf0>
      state = 0;
 51f:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 522:	31 c9                	xor    %ecx,%ecx
 524:	e9 2e ff ff ff       	jmp    457 <printf+0x3f>
 529:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 52c:	83 ec 0c             	sub    $0xc,%esp
 52f:	6a 01                	push   $0x1
 531:	b9 0a 00 00 00       	mov    $0xa,%ecx
 536:	eb 9a                	jmp    4d2 <printf+0xba>
        putc(fd, *ap);
 538:	8b 45 d0             	mov    -0x30(%ebp),%eax
 53b:	8b 00                	mov    (%eax),%eax
 53d:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 540:	51                   	push   %ecx
 541:	6a 01                	push   $0x1
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	e8 bd fd ff ff       	call   307 <write>
        ap++;
 54a:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 54e:	83 c4 10             	add    $0x10,%esp
      state = 0;
 551:	31 c9                	xor    %ecx,%ecx
 553:	e9 ff fe ff ff       	jmp    457 <printf+0x3f>
        putc(fd, c);
 558:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 55b:	52                   	push   %edx
 55c:	e9 55 ff ff ff       	jmp    4b6 <printf+0x9e>
 561:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
 564:	ba 29 07 00 00       	mov    $0x729,%edx
        while(*s != 0){
 569:	b0 28                	mov    $0x28,%al
 56b:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 56e:	89 d3                	mov    %edx,%ebx
 570:	eb 96                	jmp    508 <printf+0xf0>
      state = 0;
 572:	31 c9                	xor    %ecx,%ecx
 574:	e9 de fe ff ff       	jmp    457 <printf+0x3f>
 579:	66 90                	xchg   %ax,%ax
 57b:	90                   	nop

0000057c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 57c:	55                   	push   %ebp
 57d:	89 e5                	mov    %esp,%ebp
 57f:	57                   	push   %edi
 580:	56                   	push   %esi
 581:	53                   	push   %ebx
 582:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 585:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 588:	a1 9c 07 00 00       	mov    0x79c,%eax
 58d:	8d 76 00             	lea    0x0(%esi),%esi
 590:	89 c2                	mov    %eax,%edx
 592:	8b 00                	mov    (%eax),%eax
 594:	39 ca                	cmp    %ecx,%edx
 596:	73 2c                	jae    5c4 <free+0x48>
 598:	39 c1                	cmp    %eax,%ecx
 59a:	72 04                	jb     5a0 <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 59c:	39 c2                	cmp    %eax,%edx
 59e:	72 f0                	jb     590 <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5a0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5a3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5a6:	39 f8                	cmp    %edi,%eax
 5a8:	74 2c                	je     5d6 <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5aa:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5ad:	8b 42 04             	mov    0x4(%edx),%eax
 5b0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 5b3:	39 f1                	cmp    %esi,%ecx
 5b5:	74 36                	je     5ed <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 5b7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
 5b9:	89 15 9c 07 00 00    	mov    %edx,0x79c
}
 5bf:	5b                   	pop    %ebx
 5c0:	5e                   	pop    %esi
 5c1:	5f                   	pop    %edi
 5c2:	5d                   	pop    %ebp
 5c3:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c4:	39 c2                	cmp    %eax,%edx
 5c6:	72 c8                	jb     590 <free+0x14>
 5c8:	39 c1                	cmp    %eax,%ecx
 5ca:	73 c4                	jae    590 <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
 5cc:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5cf:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5d2:	39 f8                	cmp    %edi,%eax
 5d4:	75 d4                	jne    5aa <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
 5d6:	03 70 04             	add    0x4(%eax),%esi
 5d9:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5dc:	8b 02                	mov    (%edx),%eax
 5de:	8b 00                	mov    (%eax),%eax
 5e0:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 5e3:	8b 42 04             	mov    0x4(%edx),%eax
 5e6:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 5e9:	39 f1                	cmp    %esi,%ecx
 5eb:	75 ca                	jne    5b7 <free+0x3b>
    p->s.size += bp->s.size;
 5ed:	03 43 fc             	add    -0x4(%ebx),%eax
 5f0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 5f3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 5f6:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 5f8:	89 15 9c 07 00 00    	mov    %edx,0x79c
}
 5fe:	5b                   	pop    %ebx
 5ff:	5e                   	pop    %esi
 600:	5f                   	pop    %edi
 601:	5d                   	pop    %ebp
 602:	c3                   	ret    
 603:	90                   	nop

00000604 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 604:	55                   	push   %ebp
 605:	89 e5                	mov    %esp,%ebp
 607:	57                   	push   %edi
 608:	56                   	push   %esi
 609:	53                   	push   %ebx
 60a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 60d:	8b 45 08             	mov    0x8(%ebp),%eax
 610:	8d 70 07             	lea    0x7(%eax),%esi
 613:	c1 ee 03             	shr    $0x3,%esi
 616:	46                   	inc    %esi
  if((prevp = freep) == 0){
 617:	8b 3d 9c 07 00 00    	mov    0x79c,%edi
 61d:	85 ff                	test   %edi,%edi
 61f:	0f 84 a3 00 00 00    	je     6c8 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 625:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 627:	8b 4a 04             	mov    0x4(%edx),%ecx
 62a:	39 f1                	cmp    %esi,%ecx
 62c:	73 68                	jae    696 <malloc+0x92>
 62e:	89 f3                	mov    %esi,%ebx
 630:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 636:	0f 82 80 00 00 00    	jb     6bc <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
 63c:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 643:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 646:	eb 11                	jmp    659 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 648:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 64a:	8b 48 04             	mov    0x4(%eax),%ecx
 64d:	39 f1                	cmp    %esi,%ecx
 64f:	73 4b                	jae    69c <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 651:	8b 3d 9c 07 00 00    	mov    0x79c,%edi
 657:	89 c2                	mov    %eax,%edx
 659:	39 d7                	cmp    %edx,%edi
 65b:	75 eb                	jne    648 <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
 65d:	83 ec 0c             	sub    $0xc,%esp
 660:	ff 75 e4             	push   -0x1c(%ebp)
 663:	e8 07 fd ff ff       	call   36f <sbrk>
  if(p == (char*)-1)
 668:	83 c4 10             	add    $0x10,%esp
 66b:	83 f8 ff             	cmp    $0xffffffff,%eax
 66e:	74 1c                	je     68c <malloc+0x88>
  hp->s.size = nu;
 670:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 673:	83 ec 0c             	sub    $0xc,%esp
 676:	83 c0 08             	add    $0x8,%eax
 679:	50                   	push   %eax
 67a:	e8 fd fe ff ff       	call   57c <free>
  return freep;
 67f:	8b 15 9c 07 00 00    	mov    0x79c,%edx
      if((p = morecore(nunits)) == 0)
 685:	83 c4 10             	add    $0x10,%esp
 688:	85 d2                	test   %edx,%edx
 68a:	75 bc                	jne    648 <malloc+0x44>
        return 0;
 68c:	31 c0                	xor    %eax,%eax
  }
}
 68e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 691:	5b                   	pop    %ebx
 692:	5e                   	pop    %esi
 693:	5f                   	pop    %edi
 694:	5d                   	pop    %ebp
 695:	c3                   	ret    
    if(p->s.size >= nunits){
 696:	89 d0                	mov    %edx,%eax
 698:	89 fa                	mov    %edi,%edx
 69a:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 69c:	39 ce                	cmp    %ecx,%esi
 69e:	74 54                	je     6f4 <malloc+0xf0>
        p->s.size -= nunits;
 6a0:	29 f1                	sub    %esi,%ecx
 6a2:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6a5:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6a8:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 6ab:	89 15 9c 07 00 00    	mov    %edx,0x79c
      return (void*)(p + 1);
 6b1:	83 c0 08             	add    $0x8,%eax
}
 6b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6b7:	5b                   	pop    %ebx
 6b8:	5e                   	pop    %esi
 6b9:	5f                   	pop    %edi
 6ba:	5d                   	pop    %ebp
 6bb:	c3                   	ret    
 6bc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6c1:	e9 76 ff ff ff       	jmp    63c <malloc+0x38>
 6c6:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 6c8:	c7 05 9c 07 00 00 a0 	movl   $0x7a0,0x79c
 6cf:	07 00 00 
 6d2:	c7 05 a0 07 00 00 a0 	movl   $0x7a0,0x7a0
 6d9:	07 00 00 
    base.s.size = 0;
 6dc:	c7 05 a4 07 00 00 00 	movl   $0x0,0x7a4
 6e3:	00 00 00 
 6e6:	bf a0 07 00 00       	mov    $0x7a0,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6eb:	89 fa                	mov    %edi,%edx
 6ed:	e9 3c ff ff ff       	jmp    62e <malloc+0x2a>
 6f2:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 6f4:	8b 08                	mov    (%eax),%ecx
 6f6:	89 0a                	mov    %ecx,(%edx)
 6f8:	eb b1                	jmp    6ab <malloc+0xa7>
