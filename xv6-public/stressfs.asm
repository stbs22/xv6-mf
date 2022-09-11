
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
  17:	be 17 07 00 00       	mov    $0x717,%esi
  1c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  21:	8d bd de fd ff ff    	lea    -0x222(%ebp),%edi
  27:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  char data[512];

  printf(1, "stressfs starting\n");
  29:	68 f4 06 00 00       	push   $0x6f4
  2e:	6a 01                	push   $0x1
  30:	e8 db 03 00 00       	call   410 <printf>
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
  6a:	68 07 07 00 00       	push   $0x707
  6f:	6a 01                	push   $0x1
  71:	e8 9a 03 00 00       	call   410 <printf>

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
  ba:	68 11 07 00 00       	push   $0x711
  bf:	6a 01                	push   $0x1
  c1:	e8 4a 03 00 00       	call   410 <printf>

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
 387:	90                   	nop

00000388 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 388:	55                   	push   %ebp
 389:	89 e5                	mov    %esp,%ebp
 38b:	57                   	push   %edi
 38c:	56                   	push   %esi
 38d:	53                   	push   %ebx
 38e:	83 ec 3c             	sub    $0x3c,%esp
 391:	89 45 bc             	mov    %eax,-0x44(%ebp)
 394:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 397:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
 399:	8b 5d 08             	mov    0x8(%ebp),%ebx
 39c:	85 db                	test   %ebx,%ebx
 39e:	74 04                	je     3a4 <printint+0x1c>
 3a0:	85 d2                	test   %edx,%edx
 3a2:	78 68                	js     40c <printint+0x84>
  neg = 0;
 3a4:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3ab:	31 ff                	xor    %edi,%edi
 3ad:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 3b0:	89 c8                	mov    %ecx,%eax
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	f7 75 c4             	divl   -0x3c(%ebp)
 3b7:	89 fb                	mov    %edi,%ebx
 3b9:	8d 7f 01             	lea    0x1(%edi),%edi
 3bc:	8a 92 80 07 00 00    	mov    0x780(%edx),%dl
 3c2:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 3c6:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 3c9:	89 c1                	mov    %eax,%ecx
 3cb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3ce:	3b 45 c0             	cmp    -0x40(%ebp),%eax
 3d1:	76 dd                	jbe    3b0 <printint+0x28>
  if(neg)
 3d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3d6:	85 c9                	test   %ecx,%ecx
 3d8:	74 09                	je     3e3 <printint+0x5b>
    buf[i++] = '-';
 3da:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
 3df:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
 3e1:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
 3e3:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 3e7:	8b 7d bc             	mov    -0x44(%ebp),%edi
 3ea:	eb 03                	jmp    3ef <printint+0x67>
    putc(fd, buf[i]);
 3ec:	8a 13                	mov    (%ebx),%dl
 3ee:	4b                   	dec    %ebx
 3ef:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
 3f2:	50                   	push   %eax
 3f3:	6a 01                	push   $0x1
 3f5:	56                   	push   %esi
 3f6:	57                   	push   %edi
 3f7:	e8 0b ff ff ff       	call   307 <write>
  while(--i >= 0)
 3fc:	83 c4 10             	add    $0x10,%esp
 3ff:	39 de                	cmp    %ebx,%esi
 401:	75 e9                	jne    3ec <printint+0x64>
}
 403:	8d 65 f4             	lea    -0xc(%ebp),%esp
 406:	5b                   	pop    %ebx
 407:	5e                   	pop    %esi
 408:	5f                   	pop    %edi
 409:	5d                   	pop    %ebp
 40a:	c3                   	ret    
 40b:	90                   	nop
    x = -xx;
 40c:	f7 d9                	neg    %ecx
 40e:	eb 9b                	jmp    3ab <printint+0x23>

00000410 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 2c             	sub    $0x2c,%esp
 419:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 41c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 41f:	8a 13                	mov    (%ebx),%dl
 421:	84 d2                	test   %dl,%dl
 423:	74 64                	je     489 <printf+0x79>
 425:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 426:	8d 45 10             	lea    0x10(%ebp),%eax
 429:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
 42c:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
 42e:	8d 7d e7             	lea    -0x19(%ebp),%edi
 431:	eb 24                	jmp    457 <printf+0x47>
 433:	90                   	nop
 434:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 437:	83 f8 25             	cmp    $0x25,%eax
 43a:	74 40                	je     47c <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
 43c:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 43f:	50                   	push   %eax
 440:	6a 01                	push   $0x1
 442:	57                   	push   %edi
 443:	56                   	push   %esi
 444:	e8 be fe ff ff       	call   307 <write>
        putc(fd, c);
 449:	83 c4 10             	add    $0x10,%esp
 44c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
 44f:	43                   	inc    %ebx
 450:	8a 53 ff             	mov    -0x1(%ebx),%dl
 453:	84 d2                	test   %dl,%dl
 455:	74 32                	je     489 <printf+0x79>
    c = fmt[i] & 0xff;
 457:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 45a:	85 c9                	test   %ecx,%ecx
 45c:	74 d6                	je     434 <printf+0x24>
      }
    } else if(state == '%'){
 45e:	83 f9 25             	cmp    $0x25,%ecx
 461:	75 ec                	jne    44f <printf+0x3f>
      if(c == 'd'){
 463:	83 f8 25             	cmp    $0x25,%eax
 466:	0f 84 e4 00 00 00    	je     550 <printf+0x140>
 46c:	83 e8 63             	sub    $0x63,%eax
 46f:	83 f8 15             	cmp    $0x15,%eax
 472:	77 20                	ja     494 <printf+0x84>
 474:	ff 24 85 28 07 00 00 	jmp    *0x728(,%eax,4)
 47b:	90                   	nop
        state = '%';
 47c:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
 481:	43                   	inc    %ebx
 482:	8a 53 ff             	mov    -0x1(%ebx),%dl
 485:	84 d2                	test   %dl,%dl
 487:	75 ce                	jne    457 <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 489:	8d 65 f4             	lea    -0xc(%ebp),%esp
 48c:	5b                   	pop    %ebx
 48d:	5e                   	pop    %esi
 48e:	5f                   	pop    %edi
 48f:	5d                   	pop    %ebp
 490:	c3                   	ret    
 491:	8d 76 00             	lea    0x0(%esi),%esi
 494:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
 497:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 49b:	50                   	push   %eax
 49c:	6a 01                	push   $0x1
 49e:	57                   	push   %edi
 49f:	56                   	push   %esi
 4a0:	e8 62 fe ff ff       	call   307 <write>
        putc(fd, c);
 4a5:	8a 55 d4             	mov    -0x2c(%ebp),%dl
 4a8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4ab:	83 c4 0c             	add    $0xc,%esp
 4ae:	6a 01                	push   $0x1
 4b0:	57                   	push   %edi
 4b1:	56                   	push   %esi
 4b2:	e8 50 fe ff ff       	call   307 <write>
        putc(fd, c);
 4b7:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4ba:	31 c9                	xor    %ecx,%ecx
 4bc:	eb 91                	jmp    44f <printf+0x3f>
 4be:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 4c0:	83 ec 0c             	sub    $0xc,%esp
 4c3:	6a 00                	push   $0x0
 4c5:	b9 10 00 00 00       	mov    $0x10,%ecx
 4ca:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4cd:	8b 10                	mov    (%eax),%edx
 4cf:	89 f0                	mov    %esi,%eax
 4d1:	e8 b2 fe ff ff       	call   388 <printint>
        ap++;
 4d6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 4da:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4dd:	31 c9                	xor    %ecx,%ecx
        ap++;
 4df:	e9 6b ff ff ff       	jmp    44f <printf+0x3f>
        s = (char*)*ap;
 4e4:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4e7:	8b 10                	mov    (%eax),%edx
        ap++;
 4e9:	83 c0 04             	add    $0x4,%eax
 4ec:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 4ef:	85 d2                	test   %edx,%edx
 4f1:	74 69                	je     55c <printf+0x14c>
        while(*s != 0){
 4f3:	8a 02                	mov    (%edx),%al
 4f5:	84 c0                	test   %al,%al
 4f7:	74 71                	je     56a <printf+0x15a>
 4f9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 4fc:	89 d3                	mov    %edx,%ebx
 4fe:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
 500:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 503:	50                   	push   %eax
 504:	6a 01                	push   $0x1
 506:	57                   	push   %edi
 507:	56                   	push   %esi
 508:	e8 fa fd ff ff       	call   307 <write>
          s++;
 50d:	43                   	inc    %ebx
        while(*s != 0){
 50e:	8a 03                	mov    (%ebx),%al
 510:	83 c4 10             	add    $0x10,%esp
 513:	84 c0                	test   %al,%al
 515:	75 e9                	jne    500 <printf+0xf0>
      state = 0;
 517:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 51a:	31 c9                	xor    %ecx,%ecx
 51c:	e9 2e ff ff ff       	jmp    44f <printf+0x3f>
 521:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 524:	83 ec 0c             	sub    $0xc,%esp
 527:	6a 01                	push   $0x1
 529:	b9 0a 00 00 00       	mov    $0xa,%ecx
 52e:	eb 9a                	jmp    4ca <printf+0xba>
        putc(fd, *ap);
 530:	8b 45 d0             	mov    -0x30(%ebp),%eax
 533:	8b 00                	mov    (%eax),%eax
 535:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 538:	51                   	push   %ecx
 539:	6a 01                	push   $0x1
 53b:	57                   	push   %edi
 53c:	56                   	push   %esi
 53d:	e8 c5 fd ff ff       	call   307 <write>
        ap++;
 542:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 546:	83 c4 10             	add    $0x10,%esp
      state = 0;
 549:	31 c9                	xor    %ecx,%ecx
 54b:	e9 ff fe ff ff       	jmp    44f <printf+0x3f>
        putc(fd, c);
 550:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 553:	52                   	push   %edx
 554:	e9 55 ff ff ff       	jmp    4ae <printf+0x9e>
 559:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
 55c:	ba 21 07 00 00       	mov    $0x721,%edx
        while(*s != 0){
 561:	b0 28                	mov    $0x28,%al
 563:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 566:	89 d3                	mov    %edx,%ebx
 568:	eb 96                	jmp    500 <printf+0xf0>
      state = 0;
 56a:	31 c9                	xor    %ecx,%ecx
 56c:	e9 de fe ff ff       	jmp    44f <printf+0x3f>
 571:	66 90                	xchg   %ax,%ax
 573:	90                   	nop

00000574 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 574:	55                   	push   %ebp
 575:	89 e5                	mov    %esp,%ebp
 577:	57                   	push   %edi
 578:	56                   	push   %esi
 579:	53                   	push   %ebx
 57a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 57d:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 580:	a1 94 07 00 00       	mov    0x794,%eax
 585:	8d 76 00             	lea    0x0(%esi),%esi
 588:	89 c2                	mov    %eax,%edx
 58a:	8b 00                	mov    (%eax),%eax
 58c:	39 ca                	cmp    %ecx,%edx
 58e:	73 2c                	jae    5bc <free+0x48>
 590:	39 c1                	cmp    %eax,%ecx
 592:	72 04                	jb     598 <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 594:	39 c2                	cmp    %eax,%edx
 596:	72 f0                	jb     588 <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
 598:	8b 73 fc             	mov    -0x4(%ebx),%esi
 59b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 59e:	39 f8                	cmp    %edi,%eax
 5a0:	74 2c                	je     5ce <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5a2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5a5:	8b 42 04             	mov    0x4(%edx),%eax
 5a8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 5ab:	39 f1                	cmp    %esi,%ecx
 5ad:	74 36                	je     5e5 <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 5af:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
 5b1:	89 15 94 07 00 00    	mov    %edx,0x794
}
 5b7:	5b                   	pop    %ebx
 5b8:	5e                   	pop    %esi
 5b9:	5f                   	pop    %edi
 5ba:	5d                   	pop    %ebp
 5bb:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5bc:	39 c2                	cmp    %eax,%edx
 5be:	72 c8                	jb     588 <free+0x14>
 5c0:	39 c1                	cmp    %eax,%ecx
 5c2:	73 c4                	jae    588 <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
 5c4:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5c7:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5ca:	39 f8                	cmp    %edi,%eax
 5cc:	75 d4                	jne    5a2 <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
 5ce:	03 70 04             	add    0x4(%eax),%esi
 5d1:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5d4:	8b 02                	mov    (%edx),%eax
 5d6:	8b 00                	mov    (%eax),%eax
 5d8:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 5db:	8b 42 04             	mov    0x4(%edx),%eax
 5de:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 5e1:	39 f1                	cmp    %esi,%ecx
 5e3:	75 ca                	jne    5af <free+0x3b>
    p->s.size += bp->s.size;
 5e5:	03 43 fc             	add    -0x4(%ebx),%eax
 5e8:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 5eb:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 5ee:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 5f0:	89 15 94 07 00 00    	mov    %edx,0x794
}
 5f6:	5b                   	pop    %ebx
 5f7:	5e                   	pop    %esi
 5f8:	5f                   	pop    %edi
 5f9:	5d                   	pop    %ebp
 5fa:	c3                   	ret    
 5fb:	90                   	nop

000005fc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5fc:	55                   	push   %ebp
 5fd:	89 e5                	mov    %esp,%ebp
 5ff:	57                   	push   %edi
 600:	56                   	push   %esi
 601:	53                   	push   %ebx
 602:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 605:	8b 45 08             	mov    0x8(%ebp),%eax
 608:	8d 70 07             	lea    0x7(%eax),%esi
 60b:	c1 ee 03             	shr    $0x3,%esi
 60e:	46                   	inc    %esi
  if((prevp = freep) == 0){
 60f:	8b 3d 94 07 00 00    	mov    0x794,%edi
 615:	85 ff                	test   %edi,%edi
 617:	0f 84 a3 00 00 00    	je     6c0 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 61d:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 61f:	8b 4a 04             	mov    0x4(%edx),%ecx
 622:	39 f1                	cmp    %esi,%ecx
 624:	73 68                	jae    68e <malloc+0x92>
 626:	89 f3                	mov    %esi,%ebx
 628:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 62e:	0f 82 80 00 00 00    	jb     6b4 <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
 634:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 63b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 63e:	eb 11                	jmp    651 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 640:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 642:	8b 48 04             	mov    0x4(%eax),%ecx
 645:	39 f1                	cmp    %esi,%ecx
 647:	73 4b                	jae    694 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 649:	8b 3d 94 07 00 00    	mov    0x794,%edi
 64f:	89 c2                	mov    %eax,%edx
 651:	39 d7                	cmp    %edx,%edi
 653:	75 eb                	jne    640 <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
 655:	83 ec 0c             	sub    $0xc,%esp
 658:	ff 75 e4             	push   -0x1c(%ebp)
 65b:	e8 0f fd ff ff       	call   36f <sbrk>
  if(p == (char*)-1)
 660:	83 c4 10             	add    $0x10,%esp
 663:	83 f8 ff             	cmp    $0xffffffff,%eax
 666:	74 1c                	je     684 <malloc+0x88>
  hp->s.size = nu;
 668:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 66b:	83 ec 0c             	sub    $0xc,%esp
 66e:	83 c0 08             	add    $0x8,%eax
 671:	50                   	push   %eax
 672:	e8 fd fe ff ff       	call   574 <free>
  return freep;
 677:	8b 15 94 07 00 00    	mov    0x794,%edx
      if((p = morecore(nunits)) == 0)
 67d:	83 c4 10             	add    $0x10,%esp
 680:	85 d2                	test   %edx,%edx
 682:	75 bc                	jne    640 <malloc+0x44>
        return 0;
 684:	31 c0                	xor    %eax,%eax
  }
}
 686:	8d 65 f4             	lea    -0xc(%ebp),%esp
 689:	5b                   	pop    %ebx
 68a:	5e                   	pop    %esi
 68b:	5f                   	pop    %edi
 68c:	5d                   	pop    %ebp
 68d:	c3                   	ret    
    if(p->s.size >= nunits){
 68e:	89 d0                	mov    %edx,%eax
 690:	89 fa                	mov    %edi,%edx
 692:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 694:	39 ce                	cmp    %ecx,%esi
 696:	74 54                	je     6ec <malloc+0xf0>
        p->s.size -= nunits;
 698:	29 f1                	sub    %esi,%ecx
 69a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 69d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6a0:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 6a3:	89 15 94 07 00 00    	mov    %edx,0x794
      return (void*)(p + 1);
 6a9:	83 c0 08             	add    $0x8,%eax
}
 6ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6af:	5b                   	pop    %ebx
 6b0:	5e                   	pop    %esi
 6b1:	5f                   	pop    %edi
 6b2:	5d                   	pop    %ebp
 6b3:	c3                   	ret    
 6b4:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6b9:	e9 76 ff ff ff       	jmp    634 <malloc+0x38>
 6be:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 6c0:	c7 05 94 07 00 00 98 	movl   $0x798,0x794
 6c7:	07 00 00 
 6ca:	c7 05 98 07 00 00 98 	movl   $0x798,0x798
 6d1:	07 00 00 
    base.s.size = 0;
 6d4:	c7 05 9c 07 00 00 00 	movl   $0x0,0x79c
 6db:	00 00 00 
 6de:	bf 98 07 00 00       	mov    $0x798,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e3:	89 fa                	mov    %edi,%edx
 6e5:	e9 3c ff ff ff       	jmp    626 <malloc+0x2a>
 6ea:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 6ec:	8b 08                	mov    (%eax),%ecx
 6ee:	89 0a                	mov    %ecx,(%edx)
 6f0:	eb b1                	jmp    6a3 <malloc+0xa7>
