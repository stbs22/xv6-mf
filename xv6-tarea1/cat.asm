
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;

  if(argc <= 1){
  1c:	48                   	dec    %eax
  1d:	7e 54                	jle    73 <main+0x73>
  1f:	83 c3 04             	add    $0x4,%ebx
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  22:	be 01 00 00 00       	mov    $0x1,%esi
  27:	90                   	nop
    if((fd = open(argv[i], 0)) < 0){
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	6a 00                	push   $0x0
  2d:	ff 33                	push   (%ebx)
  2f:	e8 d3 02 00 00       	call   307 <open>
  34:	89 c7                	mov    %eax,%edi
  36:	83 c4 10             	add    $0x10,%esp
  39:	85 c0                	test   %eax,%eax
  3b:	78 22                	js     5f <main+0x5f>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  3d:	83 ec 0c             	sub    $0xc,%esp
  40:	50                   	push   %eax
  41:	e8 3e 00 00 00       	call   84 <cat>
    close(fd);
  46:	89 3c 24             	mov    %edi,(%esp)
  49:	e8 a1 02 00 00       	call   2ef <close>
  for(i = 1; i < argc; i++){
  4e:	46                   	inc    %esi
  4f:	83 c3 04             	add    $0x4,%ebx
  52:	83 c4 10             	add    $0x10,%esp
  55:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  58:	75 ce                	jne    28 <main+0x28>
  }
  exit();
  5a:	e8 68 02 00 00       	call   2c7 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  5f:	50                   	push   %eax
  60:	ff 33                	push   (%ebx)
  62:	68 ff 06 00 00       	push   $0x6ff
  67:	6a 01                	push   $0x1
  69:	e8 8a 03 00 00       	call   3f8 <printf>
      exit();
  6e:	e8 54 02 00 00       	call   2c7 <exit>
    cat(0);
  73:	83 ec 0c             	sub    $0xc,%esp
  76:	6a 00                	push   $0x0
  78:	e8 07 00 00 00       	call   84 <cat>
    exit();
  7d:	e8 45 02 00 00       	call   2c7 <exit>
  82:	66 90                	xchg   %ax,%ax

00000084 <cat>:
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	56                   	push   %esi
  88:	53                   	push   %ebx
  89:	8b 75 08             	mov    0x8(%ebp),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  8c:	eb 17                	jmp    a5 <cat+0x21>
  8e:	66 90                	xchg   %ax,%ax
    if (write(1, buf, n) != n) {
  90:	51                   	push   %ecx
  91:	53                   	push   %ebx
  92:	68 a0 07 00 00       	push   $0x7a0
  97:	6a 01                	push   $0x1
  99:	e8 49 02 00 00       	call   2e7 <write>
  9e:	83 c4 10             	add    $0x10,%esp
  a1:	39 d8                	cmp    %ebx,%eax
  a3:	75 23                	jne    c8 <cat+0x44>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  a5:	52                   	push   %edx
  a6:	68 00 02 00 00       	push   $0x200
  ab:	68 a0 07 00 00       	push   $0x7a0
  b0:	56                   	push   %esi
  b1:	e8 29 02 00 00       	call   2df <read>
  b6:	89 c3                	mov    %eax,%ebx
  b8:	83 c4 10             	add    $0x10,%esp
  bb:	85 c0                	test   %eax,%eax
  bd:	7f d1                	jg     90 <cat+0xc>
  if(n < 0){
  bf:	75 1b                	jne    dc <cat+0x58>
}
  c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  c4:	5b                   	pop    %ebx
  c5:	5e                   	pop    %esi
  c6:	5d                   	pop    %ebp
  c7:	c3                   	ret    
      printf(1, "cat: write error\n");
  c8:	83 ec 08             	sub    $0x8,%esp
  cb:	68 dc 06 00 00       	push   $0x6dc
  d0:	6a 01                	push   $0x1
  d2:	e8 21 03 00 00       	call   3f8 <printf>
      exit();
  d7:	e8 eb 01 00 00       	call   2c7 <exit>
    printf(1, "cat: read error\n");
  dc:	50                   	push   %eax
  dd:	50                   	push   %eax
  de:	68 ee 06 00 00       	push   $0x6ee
  e3:	6a 01                	push   $0x1
  e5:	e8 0e 03 00 00       	call   3f8 <printf>
    exit();
  ea:	e8 d8 01 00 00       	call   2c7 <exit>
  ef:	90                   	nop

000000f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  fa:	31 c0                	xor    %eax,%eax
  fc:	8a 14 03             	mov    (%ebx,%eax,1),%dl
  ff:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 102:	40                   	inc    %eax
 103:	84 d2                	test   %dl,%dl
 105:	75 f5                	jne    fc <strcpy+0xc>
    ;
  return os;
}
 107:	89 c8                	mov    %ecx,%eax
 109:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 10c:	c9                   	leave  
 10d:	c3                   	ret    
 10e:	66 90                	xchg   %ax,%ax

00000110 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 55 08             	mov    0x8(%ebp),%edx
 117:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 11a:	0f b6 02             	movzbl (%edx),%eax
 11d:	84 c0                	test   %al,%al
 11f:	75 10                	jne    131 <strcmp+0x21>
 121:	eb 2a                	jmp    14d <strcmp+0x3d>
 123:	90                   	nop
    p++, q++;
 124:	42                   	inc    %edx
 125:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
 128:	0f b6 02             	movzbl (%edx),%eax
 12b:	84 c0                	test   %al,%al
 12d:	74 11                	je     140 <strcmp+0x30>
    p++, q++;
 12f:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
 131:	0f b6 0b             	movzbl (%ebx),%ecx
 134:	38 c1                	cmp    %al,%cl
 136:	74 ec                	je     124 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 138:	29 c8                	sub    %ecx,%eax
}
 13a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 13d:	c9                   	leave  
 13e:	c3                   	ret    
 13f:	90                   	nop
  return (uchar)*p - (uchar)*q;
 140:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 144:	31 c0                	xor    %eax,%eax
 146:	29 c8                	sub    %ecx,%eax
}
 148:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 14b:	c9                   	leave  
 14c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 14d:	0f b6 0b             	movzbl (%ebx),%ecx
 150:	31 c0                	xor    %eax,%eax
 152:	eb e4                	jmp    138 <strcmp+0x28>

00000154 <strlen>:

uint
strlen(const char *s)
{
 154:	55                   	push   %ebp
 155:	89 e5                	mov    %esp,%ebp
 157:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 15a:	80 3a 00             	cmpb   $0x0,(%edx)
 15d:	74 15                	je     174 <strlen+0x20>
 15f:	31 c0                	xor    %eax,%eax
 161:	8d 76 00             	lea    0x0(%esi),%esi
 164:	40                   	inc    %eax
 165:	89 c1                	mov    %eax,%ecx
 167:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 16b:	75 f7                	jne    164 <strlen+0x10>
    ;
  return n;
}
 16d:	89 c8                	mov    %ecx,%eax
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret    
 171:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 174:	31 c9                	xor    %ecx,%ecx
}
 176:	89 c8                	mov    %ecx,%eax
 178:	5d                   	pop    %ebp
 179:	c3                   	ret    
 17a:	66 90                	xchg   %ax,%ax

0000017c <memset>:

void*
memset(void *dst, int c, uint n)
{
 17c:	55                   	push   %ebp
 17d:	89 e5                	mov    %esp,%ebp
 17f:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 180:	8b 7d 08             	mov    0x8(%ebp),%edi
 183:	8b 4d 10             	mov    0x10(%ebp),%ecx
 186:	8b 45 0c             	mov    0xc(%ebp),%eax
 189:	fc                   	cld    
 18a:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	8b 7d fc             	mov    -0x4(%ebp),%edi
 192:	c9                   	leave  
 193:	c3                   	ret    

00000194 <strchr>:

char*
strchr(const char *s, char c)
{
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	8b 45 08             	mov    0x8(%ebp),%eax
 19a:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 19d:	8a 10                	mov    (%eax),%dl
 19f:	84 d2                	test   %dl,%dl
 1a1:	75 0c                	jne    1af <strchr+0x1b>
 1a3:	eb 13                	jmp    1b8 <strchr+0x24>
 1a5:	8d 76 00             	lea    0x0(%esi),%esi
 1a8:	40                   	inc    %eax
 1a9:	8a 10                	mov    (%eax),%dl
 1ab:	84 d2                	test   %dl,%dl
 1ad:	74 09                	je     1b8 <strchr+0x24>
    if(*s == c)
 1af:	38 d1                	cmp    %dl,%cl
 1b1:	75 f5                	jne    1a8 <strchr+0x14>
      return (char*)s;
  return 0;
}
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 1b8:	31 c0                	xor    %eax,%eax
}
 1ba:	5d                   	pop    %ebp
 1bb:	c3                   	ret    

000001bc <gets>:

char*
gets(char *buf, int max)
{
 1bc:	55                   	push   %ebp
 1bd:	89 e5                	mov    %esp,%ebp
 1bf:	57                   	push   %edi
 1c0:	56                   	push   %esi
 1c1:	53                   	push   %ebx
 1c2:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c5:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 1c7:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1ca:	eb 24                	jmp    1f0 <gets+0x34>
    cc = read(0, &c, 1);
 1cc:	50                   	push   %eax
 1cd:	6a 01                	push   $0x1
 1cf:	57                   	push   %edi
 1d0:	6a 00                	push   $0x0
 1d2:	e8 08 01 00 00       	call   2df <read>
    if(cc < 1)
 1d7:	83 c4 10             	add    $0x10,%esp
 1da:	85 c0                	test   %eax,%eax
 1dc:	7e 1c                	jle    1fa <gets+0x3e>
      break;
    buf[i++] = c;
 1de:	8a 45 e7             	mov    -0x19(%ebp),%al
 1e1:	8b 55 08             	mov    0x8(%ebp),%edx
 1e4:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1e8:	3c 0a                	cmp    $0xa,%al
 1ea:	74 20                	je     20c <gets+0x50>
 1ec:	3c 0d                	cmp    $0xd,%al
 1ee:	74 1c                	je     20c <gets+0x50>
  for(i=0; i+1 < max; ){
 1f0:	89 de                	mov    %ebx,%esi
 1f2:	8d 5b 01             	lea    0x1(%ebx),%ebx
 1f5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1f8:	7c d2                	jl     1cc <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1fa:	8b 45 08             	mov    0x8(%ebp),%eax
 1fd:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 201:	8d 65 f4             	lea    -0xc(%ebp),%esp
 204:	5b                   	pop    %ebx
 205:	5e                   	pop    %esi
 206:	5f                   	pop    %edi
 207:	5d                   	pop    %ebp
 208:	c3                   	ret    
 209:	8d 76 00             	lea    0x0(%esi),%esi
 20c:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 20e:	8b 45 08             	mov    0x8(%ebp),%eax
 211:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 215:	8d 65 f4             	lea    -0xc(%ebp),%esp
 218:	5b                   	pop    %ebx
 219:	5e                   	pop    %esi
 21a:	5f                   	pop    %edi
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
 21d:	8d 76 00             	lea    0x0(%esi),%esi

00000220 <stat>:

int
stat(const char *n, struct stat *st)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	56                   	push   %esi
 224:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 225:	83 ec 08             	sub    $0x8,%esp
 228:	6a 00                	push   $0x0
 22a:	ff 75 08             	push   0x8(%ebp)
 22d:	e8 d5 00 00 00       	call   307 <open>
  if(fd < 0)
 232:	83 c4 10             	add    $0x10,%esp
 235:	85 c0                	test   %eax,%eax
 237:	78 27                	js     260 <stat+0x40>
 239:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 23b:	83 ec 08             	sub    $0x8,%esp
 23e:	ff 75 0c             	push   0xc(%ebp)
 241:	50                   	push   %eax
 242:	e8 d8 00 00 00       	call   31f <fstat>
 247:	89 c6                	mov    %eax,%esi
  close(fd);
 249:	89 1c 24             	mov    %ebx,(%esp)
 24c:	e8 9e 00 00 00       	call   2ef <close>
  return r;
 251:	83 c4 10             	add    $0x10,%esp
}
 254:	89 f0                	mov    %esi,%eax
 256:	8d 65 f8             	lea    -0x8(%ebp),%esp
 259:	5b                   	pop    %ebx
 25a:	5e                   	pop    %esi
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
 25d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 260:	be ff ff ff ff       	mov    $0xffffffff,%esi
 265:	eb ed                	jmp    254 <stat+0x34>
 267:	90                   	nop

00000268 <atoi>:

int
atoi(const char *s)
{
 268:	55                   	push   %ebp
 269:	89 e5                	mov    %esp,%ebp
 26b:	53                   	push   %ebx
 26c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26f:	0f be 01             	movsbl (%ecx),%eax
 272:	8d 50 d0             	lea    -0x30(%eax),%edx
 275:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 278:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 27d:	77 16                	ja     295 <atoi+0x2d>
 27f:	90                   	nop
    n = n*10 + *s++ - '0';
 280:	41                   	inc    %ecx
 281:	8d 14 92             	lea    (%edx,%edx,4),%edx
 284:	01 d2                	add    %edx,%edx
 286:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 28a:	0f be 01             	movsbl (%ecx),%eax
 28d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x18>
  return n;
}
 295:	89 d0                	mov    %edx,%eax
 297:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 29a:	c9                   	leave  
 29b:	c3                   	ret    

0000029c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 29c:	55                   	push   %ebp
 29d:	89 e5                	mov    %esp,%ebp
 29f:	57                   	push   %edi
 2a0:	56                   	push   %esi
 2a1:	8b 55 08             	mov    0x8(%ebp),%edx
 2a4:	8b 75 0c             	mov    0xc(%ebp),%esi
 2a7:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2aa:	85 c0                	test   %eax,%eax
 2ac:	7e 0b                	jle    2b9 <memmove+0x1d>
 2ae:	01 d0                	add    %edx,%eax
  dst = vdst;
 2b0:	89 d7                	mov    %edx,%edi
 2b2:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 2b4:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2b5:	39 f8                	cmp    %edi,%eax
 2b7:	75 fb                	jne    2b4 <memmove+0x18>
  return vdst;
}
 2b9:	89 d0                	mov    %edx,%eax
 2bb:	5e                   	pop    %esi
 2bc:	5f                   	pop    %edi
 2bd:	5d                   	pop    %ebp
 2be:	c3                   	ret    

000002bf <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2bf:	b8 01 00 00 00       	mov    $0x1,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <exit>:
SYSCALL(exit)
 2c7:	b8 02 00 00 00       	mov    $0x2,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <wait>:
SYSCALL(wait)
 2cf:	b8 03 00 00 00       	mov    $0x3,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <pipe>:
SYSCALL(pipe)
 2d7:	b8 04 00 00 00       	mov    $0x4,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <read>:
SYSCALL(read)
 2df:	b8 05 00 00 00       	mov    $0x5,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <write>:
SYSCALL(write)
 2e7:	b8 10 00 00 00       	mov    $0x10,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <close>:
SYSCALL(close)
 2ef:	b8 15 00 00 00       	mov    $0x15,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <kill>:
SYSCALL(kill)
 2f7:	b8 06 00 00 00       	mov    $0x6,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <exec>:
SYSCALL(exec)
 2ff:	b8 07 00 00 00       	mov    $0x7,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <open>:
SYSCALL(open)
 307:	b8 0f 00 00 00       	mov    $0xf,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <mknod>:
SYSCALL(mknod)
 30f:	b8 11 00 00 00       	mov    $0x11,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <unlink>:
SYSCALL(unlink)
 317:	b8 12 00 00 00       	mov    $0x12,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <fstat>:
SYSCALL(fstat)
 31f:	b8 08 00 00 00       	mov    $0x8,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <link>:
SYSCALL(link)
 327:	b8 13 00 00 00       	mov    $0x13,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <mkdir>:
SYSCALL(mkdir)
 32f:	b8 14 00 00 00       	mov    $0x14,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <chdir>:
SYSCALL(chdir)
 337:	b8 09 00 00 00       	mov    $0x9,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <dup>:
SYSCALL(dup)
 33f:	b8 0a 00 00 00       	mov    $0xa,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <getpid>:
SYSCALL(getpid)
 347:	b8 0b 00 00 00       	mov    $0xb,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <sbrk>:
SYSCALL(sbrk)
 34f:	b8 0c 00 00 00       	mov    $0xc,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <sleep>:
SYSCALL(sleep)
 357:	b8 0d 00 00 00       	mov    $0xd,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <uptime>:
SYSCALL(uptime)
 35f:	b8 0e 00 00 00       	mov    $0xe,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <getprocs>:
SYSCALL(getprocs)
 367:	b8 16 00 00 00       	mov    $0x16,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    
 36f:	90                   	nop

00000370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	83 ec 3c             	sub    $0x3c,%esp
 379:	89 45 bc             	mov    %eax,-0x44(%ebp)
 37c:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 37f:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
 381:	8b 5d 08             	mov    0x8(%ebp),%ebx
 384:	85 db                	test   %ebx,%ebx
 386:	74 04                	je     38c <printint+0x1c>
 388:	85 d2                	test   %edx,%edx
 38a:	78 68                	js     3f4 <printint+0x84>
  neg = 0;
 38c:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 393:	31 ff                	xor    %edi,%edi
 395:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 398:	89 c8                	mov    %ecx,%eax
 39a:	31 d2                	xor    %edx,%edx
 39c:	f7 75 c4             	divl   -0x3c(%ebp)
 39f:	89 fb                	mov    %edi,%ebx
 3a1:	8d 7f 01             	lea    0x1(%edi),%edi
 3a4:	8a 92 74 07 00 00    	mov    0x774(%edx),%dl
 3aa:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 3ae:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 3b1:	89 c1                	mov    %eax,%ecx
 3b3:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3b6:	3b 45 c0             	cmp    -0x40(%ebp),%eax
 3b9:	76 dd                	jbe    398 <printint+0x28>
  if(neg)
 3bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3be:	85 c9                	test   %ecx,%ecx
 3c0:	74 09                	je     3cb <printint+0x5b>
    buf[i++] = '-';
 3c2:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
 3c7:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
 3c9:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
 3cb:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 3cf:	8b 7d bc             	mov    -0x44(%ebp),%edi
 3d2:	eb 03                	jmp    3d7 <printint+0x67>
    putc(fd, buf[i]);
 3d4:	8a 13                	mov    (%ebx),%dl
 3d6:	4b                   	dec    %ebx
 3d7:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
 3da:	50                   	push   %eax
 3db:	6a 01                	push   $0x1
 3dd:	56                   	push   %esi
 3de:	57                   	push   %edi
 3df:	e8 03 ff ff ff       	call   2e7 <write>
  while(--i >= 0)
 3e4:	83 c4 10             	add    $0x10,%esp
 3e7:	39 de                	cmp    %ebx,%esi
 3e9:	75 e9                	jne    3d4 <printint+0x64>
}
 3eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ee:	5b                   	pop    %ebx
 3ef:	5e                   	pop    %esi
 3f0:	5f                   	pop    %edi
 3f1:	5d                   	pop    %ebp
 3f2:	c3                   	ret    
 3f3:	90                   	nop
    x = -xx;
 3f4:	f7 d9                	neg    %ecx
 3f6:	eb 9b                	jmp    393 <printint+0x23>

000003f8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3f8:	55                   	push   %ebp
 3f9:	89 e5                	mov    %esp,%ebp
 3fb:	57                   	push   %edi
 3fc:	56                   	push   %esi
 3fd:	53                   	push   %ebx
 3fe:	83 ec 2c             	sub    $0x2c,%esp
 401:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 404:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 407:	8a 13                	mov    (%ebx),%dl
 409:	84 d2                	test   %dl,%dl
 40b:	74 64                	je     471 <printf+0x79>
 40d:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 40e:	8d 45 10             	lea    0x10(%ebp),%eax
 411:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
 414:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
 416:	8d 7d e7             	lea    -0x19(%ebp),%edi
 419:	eb 24                	jmp    43f <printf+0x47>
 41b:	90                   	nop
 41c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 41f:	83 f8 25             	cmp    $0x25,%eax
 422:	74 40                	je     464 <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
 424:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 427:	50                   	push   %eax
 428:	6a 01                	push   $0x1
 42a:	57                   	push   %edi
 42b:	56                   	push   %esi
 42c:	e8 b6 fe ff ff       	call   2e7 <write>
        putc(fd, c);
 431:	83 c4 10             	add    $0x10,%esp
 434:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
 437:	43                   	inc    %ebx
 438:	8a 53 ff             	mov    -0x1(%ebx),%dl
 43b:	84 d2                	test   %dl,%dl
 43d:	74 32                	je     471 <printf+0x79>
    c = fmt[i] & 0xff;
 43f:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 442:	85 c9                	test   %ecx,%ecx
 444:	74 d6                	je     41c <printf+0x24>
      }
    } else if(state == '%'){
 446:	83 f9 25             	cmp    $0x25,%ecx
 449:	75 ec                	jne    437 <printf+0x3f>
      if(c == 'd'){
 44b:	83 f8 25             	cmp    $0x25,%eax
 44e:	0f 84 e4 00 00 00    	je     538 <printf+0x140>
 454:	83 e8 63             	sub    $0x63,%eax
 457:	83 f8 15             	cmp    $0x15,%eax
 45a:	77 20                	ja     47c <printf+0x84>
 45c:	ff 24 85 1c 07 00 00 	jmp    *0x71c(,%eax,4)
 463:	90                   	nop
        state = '%';
 464:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
 469:	43                   	inc    %ebx
 46a:	8a 53 ff             	mov    -0x1(%ebx),%dl
 46d:	84 d2                	test   %dl,%dl
 46f:	75 ce                	jne    43f <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 471:	8d 65 f4             	lea    -0xc(%ebp),%esp
 474:	5b                   	pop    %ebx
 475:	5e                   	pop    %esi
 476:	5f                   	pop    %edi
 477:	5d                   	pop    %ebp
 478:	c3                   	ret    
 479:	8d 76 00             	lea    0x0(%esi),%esi
 47c:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
 47f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 483:	50                   	push   %eax
 484:	6a 01                	push   $0x1
 486:	57                   	push   %edi
 487:	56                   	push   %esi
 488:	e8 5a fe ff ff       	call   2e7 <write>
        putc(fd, c);
 48d:	8a 55 d4             	mov    -0x2c(%ebp),%dl
 490:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 493:	83 c4 0c             	add    $0xc,%esp
 496:	6a 01                	push   $0x1
 498:	57                   	push   %edi
 499:	56                   	push   %esi
 49a:	e8 48 fe ff ff       	call   2e7 <write>
        putc(fd, c);
 49f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4a2:	31 c9                	xor    %ecx,%ecx
 4a4:	eb 91                	jmp    437 <printf+0x3f>
 4a6:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 4a8:	83 ec 0c             	sub    $0xc,%esp
 4ab:	6a 00                	push   $0x0
 4ad:	b9 10 00 00 00       	mov    $0x10,%ecx
 4b2:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4b5:	8b 10                	mov    (%eax),%edx
 4b7:	89 f0                	mov    %esi,%eax
 4b9:	e8 b2 fe ff ff       	call   370 <printint>
        ap++;
 4be:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 4c2:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4c5:	31 c9                	xor    %ecx,%ecx
        ap++;
 4c7:	e9 6b ff ff ff       	jmp    437 <printf+0x3f>
        s = (char*)*ap;
 4cc:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4cf:	8b 10                	mov    (%eax),%edx
        ap++;
 4d1:	83 c0 04             	add    $0x4,%eax
 4d4:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 4d7:	85 d2                	test   %edx,%edx
 4d9:	74 69                	je     544 <printf+0x14c>
        while(*s != 0){
 4db:	8a 02                	mov    (%edx),%al
 4dd:	84 c0                	test   %al,%al
 4df:	74 71                	je     552 <printf+0x15a>
 4e1:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 4e4:	89 d3                	mov    %edx,%ebx
 4e6:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
 4e8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 4eb:	50                   	push   %eax
 4ec:	6a 01                	push   $0x1
 4ee:	57                   	push   %edi
 4ef:	56                   	push   %esi
 4f0:	e8 f2 fd ff ff       	call   2e7 <write>
          s++;
 4f5:	43                   	inc    %ebx
        while(*s != 0){
 4f6:	8a 03                	mov    (%ebx),%al
 4f8:	83 c4 10             	add    $0x10,%esp
 4fb:	84 c0                	test   %al,%al
 4fd:	75 e9                	jne    4e8 <printf+0xf0>
      state = 0;
 4ff:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 502:	31 c9                	xor    %ecx,%ecx
 504:	e9 2e ff ff ff       	jmp    437 <printf+0x3f>
 509:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 50c:	83 ec 0c             	sub    $0xc,%esp
 50f:	6a 01                	push   $0x1
 511:	b9 0a 00 00 00       	mov    $0xa,%ecx
 516:	eb 9a                	jmp    4b2 <printf+0xba>
        putc(fd, *ap);
 518:	8b 45 d0             	mov    -0x30(%ebp),%eax
 51b:	8b 00                	mov    (%eax),%eax
 51d:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 520:	51                   	push   %ecx
 521:	6a 01                	push   $0x1
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	e8 bd fd ff ff       	call   2e7 <write>
        ap++;
 52a:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 52e:	83 c4 10             	add    $0x10,%esp
      state = 0;
 531:	31 c9                	xor    %ecx,%ecx
 533:	e9 ff fe ff ff       	jmp    437 <printf+0x3f>
        putc(fd, c);
 538:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 53b:	52                   	push   %edx
 53c:	e9 55 ff ff ff       	jmp    496 <printf+0x9e>
 541:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
 544:	ba 14 07 00 00       	mov    $0x714,%edx
        while(*s != 0){
 549:	b0 28                	mov    $0x28,%al
 54b:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 54e:	89 d3                	mov    %edx,%ebx
 550:	eb 96                	jmp    4e8 <printf+0xf0>
      state = 0;
 552:	31 c9                	xor    %ecx,%ecx
 554:	e9 de fe ff ff       	jmp    437 <printf+0x3f>
 559:	66 90                	xchg   %ax,%ax
 55b:	90                   	nop

0000055c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 55c:	55                   	push   %ebp
 55d:	89 e5                	mov    %esp,%ebp
 55f:	57                   	push   %edi
 560:	56                   	push   %esi
 561:	53                   	push   %ebx
 562:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 565:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 568:	a1 a0 09 00 00       	mov    0x9a0,%eax
 56d:	8d 76 00             	lea    0x0(%esi),%esi
 570:	89 c2                	mov    %eax,%edx
 572:	8b 00                	mov    (%eax),%eax
 574:	39 ca                	cmp    %ecx,%edx
 576:	73 2c                	jae    5a4 <free+0x48>
 578:	39 c1                	cmp    %eax,%ecx
 57a:	72 04                	jb     580 <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 57c:	39 c2                	cmp    %eax,%edx
 57e:	72 f0                	jb     570 <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
 580:	8b 73 fc             	mov    -0x4(%ebx),%esi
 583:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 586:	39 f8                	cmp    %edi,%eax
 588:	74 2c                	je     5b6 <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 58a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 58d:	8b 42 04             	mov    0x4(%edx),%eax
 590:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 593:	39 f1                	cmp    %esi,%ecx
 595:	74 36                	je     5cd <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 597:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
 599:	89 15 a0 09 00 00    	mov    %edx,0x9a0
}
 59f:	5b                   	pop    %ebx
 5a0:	5e                   	pop    %esi
 5a1:	5f                   	pop    %edi
 5a2:	5d                   	pop    %ebp
 5a3:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a4:	39 c2                	cmp    %eax,%edx
 5a6:	72 c8                	jb     570 <free+0x14>
 5a8:	39 c1                	cmp    %eax,%ecx
 5aa:	73 c4                	jae    570 <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
 5ac:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5af:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5b2:	39 f8                	cmp    %edi,%eax
 5b4:	75 d4                	jne    58a <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
 5b6:	03 70 04             	add    0x4(%eax),%esi
 5b9:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5bc:	8b 02                	mov    (%edx),%eax
 5be:	8b 00                	mov    (%eax),%eax
 5c0:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 5c3:	8b 42 04             	mov    0x4(%edx),%eax
 5c6:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 5c9:	39 f1                	cmp    %esi,%ecx
 5cb:	75 ca                	jne    597 <free+0x3b>
    p->s.size += bp->s.size;
 5cd:	03 43 fc             	add    -0x4(%ebx),%eax
 5d0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 5d3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 5d6:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 5d8:	89 15 a0 09 00 00    	mov    %edx,0x9a0
}
 5de:	5b                   	pop    %ebx
 5df:	5e                   	pop    %esi
 5e0:	5f                   	pop    %edi
 5e1:	5d                   	pop    %ebp
 5e2:	c3                   	ret    
 5e3:	90                   	nop

000005e4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5e4:	55                   	push   %ebp
 5e5:	89 e5                	mov    %esp,%ebp
 5e7:	57                   	push   %edi
 5e8:	56                   	push   %esi
 5e9:	53                   	push   %ebx
 5ea:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5ed:	8b 45 08             	mov    0x8(%ebp),%eax
 5f0:	8d 70 07             	lea    0x7(%eax),%esi
 5f3:	c1 ee 03             	shr    $0x3,%esi
 5f6:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5f7:	8b 3d a0 09 00 00    	mov    0x9a0,%edi
 5fd:	85 ff                	test   %edi,%edi
 5ff:	0f 84 a3 00 00 00    	je     6a8 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 605:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 607:	8b 4a 04             	mov    0x4(%edx),%ecx
 60a:	39 f1                	cmp    %esi,%ecx
 60c:	73 68                	jae    676 <malloc+0x92>
 60e:	89 f3                	mov    %esi,%ebx
 610:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 616:	0f 82 80 00 00 00    	jb     69c <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
 61c:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 623:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 626:	eb 11                	jmp    639 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 628:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 62a:	8b 48 04             	mov    0x4(%eax),%ecx
 62d:	39 f1                	cmp    %esi,%ecx
 62f:	73 4b                	jae    67c <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 631:	8b 3d a0 09 00 00    	mov    0x9a0,%edi
 637:	89 c2                	mov    %eax,%edx
 639:	39 d7                	cmp    %edx,%edi
 63b:	75 eb                	jne    628 <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
 63d:	83 ec 0c             	sub    $0xc,%esp
 640:	ff 75 e4             	push   -0x1c(%ebp)
 643:	e8 07 fd ff ff       	call   34f <sbrk>
  if(p == (char*)-1)
 648:	83 c4 10             	add    $0x10,%esp
 64b:	83 f8 ff             	cmp    $0xffffffff,%eax
 64e:	74 1c                	je     66c <malloc+0x88>
  hp->s.size = nu;
 650:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 653:	83 ec 0c             	sub    $0xc,%esp
 656:	83 c0 08             	add    $0x8,%eax
 659:	50                   	push   %eax
 65a:	e8 fd fe ff ff       	call   55c <free>
  return freep;
 65f:	8b 15 a0 09 00 00    	mov    0x9a0,%edx
      if((p = morecore(nunits)) == 0)
 665:	83 c4 10             	add    $0x10,%esp
 668:	85 d2                	test   %edx,%edx
 66a:	75 bc                	jne    628 <malloc+0x44>
        return 0;
 66c:	31 c0                	xor    %eax,%eax
  }
}
 66e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 671:	5b                   	pop    %ebx
 672:	5e                   	pop    %esi
 673:	5f                   	pop    %edi
 674:	5d                   	pop    %ebp
 675:	c3                   	ret    
    if(p->s.size >= nunits){
 676:	89 d0                	mov    %edx,%eax
 678:	89 fa                	mov    %edi,%edx
 67a:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 67c:	39 ce                	cmp    %ecx,%esi
 67e:	74 54                	je     6d4 <malloc+0xf0>
        p->s.size -= nunits;
 680:	29 f1                	sub    %esi,%ecx
 682:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 685:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 688:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 68b:	89 15 a0 09 00 00    	mov    %edx,0x9a0
      return (void*)(p + 1);
 691:	83 c0 08             	add    $0x8,%eax
}
 694:	8d 65 f4             	lea    -0xc(%ebp),%esp
 697:	5b                   	pop    %ebx
 698:	5e                   	pop    %esi
 699:	5f                   	pop    %edi
 69a:	5d                   	pop    %ebp
 69b:	c3                   	ret    
 69c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6a1:	e9 76 ff ff ff       	jmp    61c <malloc+0x38>
 6a6:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 6a8:	c7 05 a0 09 00 00 a4 	movl   $0x9a4,0x9a0
 6af:	09 00 00 
 6b2:	c7 05 a4 09 00 00 a4 	movl   $0x9a4,0x9a4
 6b9:	09 00 00 
    base.s.size = 0;
 6bc:	c7 05 a8 09 00 00 00 	movl   $0x0,0x9a8
 6c3:	00 00 00 
 6c6:	bf a4 09 00 00       	mov    $0x9a4,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6cb:	89 fa                	mov    %edi,%edx
 6cd:	e9 3c ff ff ff       	jmp    60e <malloc+0x2a>
 6d2:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 6d4:	8b 08                	mov    (%eax),%ecx
 6d6:	89 0a                	mov    %ecx,(%edx)
 6d8:	eb b1                	jmp    68b <malloc+0xa7>
