
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
  1d:	7e 56                	jle    75 <main+0x75>
  1f:	83 c3 04             	add    $0x4,%ebx
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  22:	be 01 00 00 00       	mov    $0x1,%esi
  27:	90                   	nop
    if((fd = open(argv[i], 0)) < 0){
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	6a 00                	push   $0x0
  2d:	ff 33                	push   (%ebx)
  2f:	e8 2b 03 00 00       	call   35f <open>
  34:	89 c7                	mov    %eax,%edi
  36:	83 c4 10             	add    $0x10,%esp
  39:	85 c0                	test   %eax,%eax
  3b:	78 24                	js     61 <main+0x61>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  3d:	83 ec 08             	sub    $0x8,%esp
  40:	ff 33                	push   (%ebx)
  42:	50                   	push   %eax
  43:	e8 40 00 00 00       	call   88 <wc>
    close(fd);
  48:	89 3c 24             	mov    %edi,(%esp)
  4b:	e8 f7 02 00 00       	call   347 <close>
  for(i = 1; i < argc; i++){
  50:	46                   	inc    %esi
  51:	83 c3 04             	add    $0x4,%ebx
  54:	83 c4 10             	add    $0x10,%esp
  57:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  5a:	75 cc                	jne    28 <main+0x28>
  }
  exit();
  5c:	e8 be 02 00 00       	call   31f <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  61:	50                   	push   %eax
  62:	ff 33                	push   (%ebx)
  64:	68 57 07 00 00       	push   $0x757
  69:	6a 01                	push   $0x1
  6b:	e8 e0 03 00 00       	call   450 <printf>
      exit();
  70:	e8 aa 02 00 00       	call   31f <exit>
    wc(0, "");
  75:	52                   	push   %edx
  76:	52                   	push   %edx
  77:	68 49 07 00 00       	push   $0x749
  7c:	6a 00                	push   $0x0
  7e:	e8 05 00 00 00       	call   88 <wc>
    exit();
  83:	e8 97 02 00 00       	call   31f <exit>

00000088 <wc>:
{
  88:	55                   	push   %ebp
  89:	89 e5                	mov    %esp,%ebp
  8b:	57                   	push   %edi
  8c:	56                   	push   %esi
  8d:	53                   	push   %ebx
  8e:	83 ec 1c             	sub    $0x1c,%esp
  inword = 0;
  91:	31 f6                	xor    %esi,%esi
  l = w = c = 0;
  93:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  9a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  a1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  a8:	52                   	push   %edx
  a9:	68 00 02 00 00       	push   $0x200
  ae:	68 e0 07 00 00       	push   $0x7e0
  b3:	ff 75 08             	push   0x8(%ebp)
  b6:	e8 7c 02 00 00       	call   337 <read>
  bb:	89 c3                	mov    %eax,%ebx
  bd:	83 c4 10             	add    $0x10,%esp
  c0:	85 c0                	test   %eax,%eax
  c2:	7e 48                	jle    10c <wc+0x84>
    for(i=0; i<n; i++){
  c4:	31 ff                	xor    %edi,%edi
  c6:	eb 07                	jmp    cf <wc+0x47>
        inword = 0;
  c8:	31 f6                	xor    %esi,%esi
    for(i=0; i<n; i++){
  ca:	47                   	inc    %edi
  cb:	39 fb                	cmp    %edi,%ebx
  cd:	74 35                	je     104 <wc+0x7c>
      if(buf[i] == '\n')
  cf:	0f be 87 e0 07 00 00 	movsbl 0x7e0(%edi),%eax
  d6:	3c 0a                	cmp    $0xa,%al
  d8:	75 03                	jne    dd <wc+0x55>
        l++;
  da:	ff 45 e4             	incl   -0x1c(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  dd:	83 ec 08             	sub    $0x8,%esp
  e0:	50                   	push   %eax
  e1:	68 34 07 00 00       	push   $0x734
  e6:	e8 01 01 00 00       	call   1ec <strchr>
  eb:	83 c4 10             	add    $0x10,%esp
  ee:	85 c0                	test   %eax,%eax
  f0:	75 d6                	jne    c8 <wc+0x40>
      else if(!inword){
  f2:	85 f6                	test   %esi,%esi
  f4:	75 d4                	jne    ca <wc+0x42>
        w++;
  f6:	ff 45 e0             	incl   -0x20(%ebp)
        inword = 1;
  f9:	be 01 00 00 00       	mov    $0x1,%esi
    for(i=0; i<n; i++){
  fe:	47                   	inc    %edi
  ff:	39 fb                	cmp    %edi,%ebx
 101:	75 cc                	jne    cf <wc+0x47>
 103:	90                   	nop
      c++;
 104:	01 5d dc             	add    %ebx,-0x24(%ebp)
 107:	eb 9f                	jmp    a8 <wc+0x20>
 109:	8d 76 00             	lea    0x0(%esi),%esi
  if(n < 0){
 10c:	75 26                	jne    134 <wc+0xac>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 10e:	83 ec 08             	sub    $0x8,%esp
 111:	ff 75 0c             	push   0xc(%ebp)
 114:	ff 75 dc             	push   -0x24(%ebp)
 117:	ff 75 e0             	push   -0x20(%ebp)
 11a:	ff 75 e4             	push   -0x1c(%ebp)
 11d:	68 4a 07 00 00       	push   $0x74a
 122:	6a 01                	push   $0x1
 124:	e8 27 03 00 00       	call   450 <printf>
}
 129:	83 c4 20             	add    $0x20,%esp
 12c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 12f:	5b                   	pop    %ebx
 130:	5e                   	pop    %esi
 131:	5f                   	pop    %edi
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    
    printf(1, "wc: read error\n");
 134:	50                   	push   %eax
 135:	50                   	push   %eax
 136:	68 3a 07 00 00       	push   $0x73a
 13b:	6a 01                	push   $0x1
 13d:	e8 0e 03 00 00       	call   450 <printf>
    exit();
 142:	e8 d8 01 00 00       	call   31f <exit>
 147:	90                   	nop

00000148 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
 14b:	53                   	push   %ebx
 14c:	8b 4d 08             	mov    0x8(%ebp),%ecx
 14f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 152:	31 c0                	xor    %eax,%eax
 154:	8a 14 03             	mov    (%ebx,%eax,1),%dl
 157:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 15a:	40                   	inc    %eax
 15b:	84 d2                	test   %dl,%dl
 15d:	75 f5                	jne    154 <strcpy+0xc>
    ;
  return os;
}
 15f:	89 c8                	mov    %ecx,%eax
 161:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 164:	c9                   	leave  
 165:	c3                   	ret    
 166:	66 90                	xchg   %ax,%ax

00000168 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 168:	55                   	push   %ebp
 169:	89 e5                	mov    %esp,%ebp
 16b:	53                   	push   %ebx
 16c:	8b 55 08             	mov    0x8(%ebp),%edx
 16f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 172:	0f b6 02             	movzbl (%edx),%eax
 175:	84 c0                	test   %al,%al
 177:	75 10                	jne    189 <strcmp+0x21>
 179:	eb 2a                	jmp    1a5 <strcmp+0x3d>
 17b:	90                   	nop
    p++, q++;
 17c:	42                   	inc    %edx
 17d:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
 180:	0f b6 02             	movzbl (%edx),%eax
 183:	84 c0                	test   %al,%al
 185:	74 11                	je     198 <strcmp+0x30>
    p++, q++;
 187:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
 189:	0f b6 0b             	movzbl (%ebx),%ecx
 18c:	38 c1                	cmp    %al,%cl
 18e:	74 ec                	je     17c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 190:	29 c8                	sub    %ecx,%eax
}
 192:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 195:	c9                   	leave  
 196:	c3                   	ret    
 197:	90                   	nop
  return (uchar)*p - (uchar)*q;
 198:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 19c:	31 c0                	xor    %eax,%eax
 19e:	29 c8                	sub    %ecx,%eax
}
 1a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1a3:	c9                   	leave  
 1a4:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 1a5:	0f b6 0b             	movzbl (%ebx),%ecx
 1a8:	31 c0                	xor    %eax,%eax
 1aa:	eb e4                	jmp    190 <strcmp+0x28>

000001ac <strlen>:

uint
strlen(const char *s)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1b2:	80 3a 00             	cmpb   $0x0,(%edx)
 1b5:	74 15                	je     1cc <strlen+0x20>
 1b7:	31 c0                	xor    %eax,%eax
 1b9:	8d 76 00             	lea    0x0(%esi),%esi
 1bc:	40                   	inc    %eax
 1bd:	89 c1                	mov    %eax,%ecx
 1bf:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1c3:	75 f7                	jne    1bc <strlen+0x10>
    ;
  return n;
}
 1c5:	89 c8                	mov    %ecx,%eax
 1c7:	5d                   	pop    %ebp
 1c8:	c3                   	ret    
 1c9:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 1cc:	31 c9                	xor    %ecx,%ecx
}
 1ce:	89 c8                	mov    %ecx,%eax
 1d0:	5d                   	pop    %ebp
 1d1:	c3                   	ret    
 1d2:	66 90                	xchg   %ax,%ax

000001d4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d8:	8b 7d 08             	mov    0x8(%ebp),%edi
 1db:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1de:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e1:	fc                   	cld    
 1e2:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1ea:	c9                   	leave  
 1eb:	c3                   	ret    

000001ec <strchr>:

char*
strchr(const char *s, char c)
{
 1ec:	55                   	push   %ebp
 1ed:	89 e5                	mov    %esp,%ebp
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
 1f2:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 1f5:	8a 10                	mov    (%eax),%dl
 1f7:	84 d2                	test   %dl,%dl
 1f9:	75 0c                	jne    207 <strchr+0x1b>
 1fb:	eb 13                	jmp    210 <strchr+0x24>
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
 200:	40                   	inc    %eax
 201:	8a 10                	mov    (%eax),%dl
 203:	84 d2                	test   %dl,%dl
 205:	74 09                	je     210 <strchr+0x24>
    if(*s == c)
 207:	38 d1                	cmp    %dl,%cl
 209:	75 f5                	jne    200 <strchr+0x14>
      return (char*)s;
  return 0;
}
 20b:	5d                   	pop    %ebp
 20c:	c3                   	ret    
 20d:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 210:	31 c0                	xor    %eax,%eax
}
 212:	5d                   	pop    %ebp
 213:	c3                   	ret    

00000214 <gets>:

char*
gets(char *buf, int max)
{
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	57                   	push   %edi
 218:	56                   	push   %esi
 219:	53                   	push   %ebx
 21a:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21d:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 21f:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 222:	eb 24                	jmp    248 <gets+0x34>
    cc = read(0, &c, 1);
 224:	50                   	push   %eax
 225:	6a 01                	push   $0x1
 227:	57                   	push   %edi
 228:	6a 00                	push   $0x0
 22a:	e8 08 01 00 00       	call   337 <read>
    if(cc < 1)
 22f:	83 c4 10             	add    $0x10,%esp
 232:	85 c0                	test   %eax,%eax
 234:	7e 1c                	jle    252 <gets+0x3e>
      break;
    buf[i++] = c;
 236:	8a 45 e7             	mov    -0x19(%ebp),%al
 239:	8b 55 08             	mov    0x8(%ebp),%edx
 23c:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 240:	3c 0a                	cmp    $0xa,%al
 242:	74 20                	je     264 <gets+0x50>
 244:	3c 0d                	cmp    $0xd,%al
 246:	74 1c                	je     264 <gets+0x50>
  for(i=0; i+1 < max; ){
 248:	89 de                	mov    %ebx,%esi
 24a:	8d 5b 01             	lea    0x1(%ebx),%ebx
 24d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 250:	7c d2                	jl     224 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 252:	8b 45 08             	mov    0x8(%ebp),%eax
 255:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 259:	8d 65 f4             	lea    -0xc(%ebp),%esp
 25c:	5b                   	pop    %ebx
 25d:	5e                   	pop    %esi
 25e:	5f                   	pop    %edi
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret    
 261:	8d 76 00             	lea    0x0(%esi),%esi
 264:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 266:	8b 45 08             	mov    0x8(%ebp),%eax
 269:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 26d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 270:	5b                   	pop    %ebx
 271:	5e                   	pop    %esi
 272:	5f                   	pop    %edi
 273:	5d                   	pop    %ebp
 274:	c3                   	ret    
 275:	8d 76 00             	lea    0x0(%esi),%esi

00000278 <stat>:

int
stat(const char *n, struct stat *st)
{
 278:	55                   	push   %ebp
 279:	89 e5                	mov    %esp,%ebp
 27b:	56                   	push   %esi
 27c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 27d:	83 ec 08             	sub    $0x8,%esp
 280:	6a 00                	push   $0x0
 282:	ff 75 08             	push   0x8(%ebp)
 285:	e8 d5 00 00 00       	call   35f <open>
  if(fd < 0)
 28a:	83 c4 10             	add    $0x10,%esp
 28d:	85 c0                	test   %eax,%eax
 28f:	78 27                	js     2b8 <stat+0x40>
 291:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 293:	83 ec 08             	sub    $0x8,%esp
 296:	ff 75 0c             	push   0xc(%ebp)
 299:	50                   	push   %eax
 29a:	e8 d8 00 00 00       	call   377 <fstat>
 29f:	89 c6                	mov    %eax,%esi
  close(fd);
 2a1:	89 1c 24             	mov    %ebx,(%esp)
 2a4:	e8 9e 00 00 00       	call   347 <close>
  return r;
 2a9:	83 c4 10             	add    $0x10,%esp
}
 2ac:	89 f0                	mov    %esi,%eax
 2ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b1:	5b                   	pop    %ebx
 2b2:	5e                   	pop    %esi
 2b3:	5d                   	pop    %ebp
 2b4:	c3                   	ret    
 2b5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2b8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2bd:	eb ed                	jmp    2ac <stat+0x34>
 2bf:	90                   	nop

000002c0 <atoi>:

int
atoi(const char *s)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	53                   	push   %ebx
 2c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c7:	0f be 01             	movsbl (%ecx),%eax
 2ca:	8d 50 d0             	lea    -0x30(%eax),%edx
 2cd:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 2d0:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 2d5:	77 16                	ja     2ed <atoi+0x2d>
 2d7:	90                   	nop
    n = n*10 + *s++ - '0';
 2d8:	41                   	inc    %ecx
 2d9:	8d 14 92             	lea    (%edx,%edx,4),%edx
 2dc:	01 d2                	add    %edx,%edx
 2de:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 2e2:	0f be 01             	movsbl (%ecx),%eax
 2e5:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2e8:	80 fb 09             	cmp    $0x9,%bl
 2eb:	76 eb                	jbe    2d8 <atoi+0x18>
  return n;
}
 2ed:	89 d0                	mov    %edx,%eax
 2ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2f2:	c9                   	leave  
 2f3:	c3                   	ret    

000002f4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2f4:	55                   	push   %ebp
 2f5:	89 e5                	mov    %esp,%ebp
 2f7:	57                   	push   %edi
 2f8:	56                   	push   %esi
 2f9:	8b 55 08             	mov    0x8(%ebp),%edx
 2fc:	8b 75 0c             	mov    0xc(%ebp),%esi
 2ff:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 302:	85 c0                	test   %eax,%eax
 304:	7e 0b                	jle    311 <memmove+0x1d>
 306:	01 d0                	add    %edx,%eax
  dst = vdst;
 308:	89 d7                	mov    %edx,%edi
 30a:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 30c:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 30d:	39 f8                	cmp    %edi,%eax
 30f:	75 fb                	jne    30c <memmove+0x18>
  return vdst;
}
 311:	89 d0                	mov    %edx,%eax
 313:	5e                   	pop    %esi
 314:	5f                   	pop    %edi
 315:	5d                   	pop    %ebp
 316:	c3                   	ret    

00000317 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 317:	b8 01 00 00 00       	mov    $0x1,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <exit>:
SYSCALL(exit)
 31f:	b8 02 00 00 00       	mov    $0x2,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <wait>:
SYSCALL(wait)
 327:	b8 03 00 00 00       	mov    $0x3,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <pipe>:
SYSCALL(pipe)
 32f:	b8 04 00 00 00       	mov    $0x4,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <read>:
SYSCALL(read)
 337:	b8 05 00 00 00       	mov    $0x5,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <write>:
SYSCALL(write)
 33f:	b8 10 00 00 00       	mov    $0x10,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <close>:
SYSCALL(close)
 347:	b8 15 00 00 00       	mov    $0x15,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <kill>:
SYSCALL(kill)
 34f:	b8 06 00 00 00       	mov    $0x6,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <exec>:
SYSCALL(exec)
 357:	b8 07 00 00 00       	mov    $0x7,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <open>:
SYSCALL(open)
 35f:	b8 0f 00 00 00       	mov    $0xf,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <mknod>:
SYSCALL(mknod)
 367:	b8 11 00 00 00       	mov    $0x11,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <unlink>:
SYSCALL(unlink)
 36f:	b8 12 00 00 00       	mov    $0x12,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <fstat>:
SYSCALL(fstat)
 377:	b8 08 00 00 00       	mov    $0x8,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <link>:
SYSCALL(link)
 37f:	b8 13 00 00 00       	mov    $0x13,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <mkdir>:
SYSCALL(mkdir)
 387:	b8 14 00 00 00       	mov    $0x14,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <chdir>:
SYSCALL(chdir)
 38f:	b8 09 00 00 00       	mov    $0x9,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <dup>:
SYSCALL(dup)
 397:	b8 0a 00 00 00       	mov    $0xa,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <getpid>:
SYSCALL(getpid)
 39f:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <sbrk>:
SYSCALL(sbrk)
 3a7:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <sleep>:
SYSCALL(sleep)
 3af:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <uptime>:
SYSCALL(uptime)
 3b7:	b8 0e 00 00 00       	mov    $0xe,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <getprocs>:
SYSCALL(getprocs)
 3bf:	b8 16 00 00 00       	mov    $0x16,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    
 3c7:	90                   	nop

000003c8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3c8:	55                   	push   %ebp
 3c9:	89 e5                	mov    %esp,%ebp
 3cb:	57                   	push   %edi
 3cc:	56                   	push   %esi
 3cd:	53                   	push   %ebx
 3ce:	83 ec 3c             	sub    $0x3c,%esp
 3d1:	89 45 bc             	mov    %eax,-0x44(%ebp)
 3d4:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3d7:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
 3d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3dc:	85 db                	test   %ebx,%ebx
 3de:	74 04                	je     3e4 <printint+0x1c>
 3e0:	85 d2                	test   %edx,%edx
 3e2:	78 68                	js     44c <printint+0x84>
  neg = 0;
 3e4:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3eb:	31 ff                	xor    %edi,%edi
 3ed:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 3f0:	89 c8                	mov    %ecx,%eax
 3f2:	31 d2                	xor    %edx,%edx
 3f4:	f7 75 c4             	divl   -0x3c(%ebp)
 3f7:	89 fb                	mov    %edi,%ebx
 3f9:	8d 7f 01             	lea    0x1(%edi),%edi
 3fc:	8a 92 cc 07 00 00    	mov    0x7cc(%edx),%dl
 402:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 406:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 409:	89 c1                	mov    %eax,%ecx
 40b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 40e:	3b 45 c0             	cmp    -0x40(%ebp),%eax
 411:	76 dd                	jbe    3f0 <printint+0x28>
  if(neg)
 413:	8b 4d 08             	mov    0x8(%ebp),%ecx
 416:	85 c9                	test   %ecx,%ecx
 418:	74 09                	je     423 <printint+0x5b>
    buf[i++] = '-';
 41a:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
 41f:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
 421:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
 423:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 427:	8b 7d bc             	mov    -0x44(%ebp),%edi
 42a:	eb 03                	jmp    42f <printint+0x67>
    putc(fd, buf[i]);
 42c:	8a 13                	mov    (%ebx),%dl
 42e:	4b                   	dec    %ebx
 42f:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
 432:	50                   	push   %eax
 433:	6a 01                	push   $0x1
 435:	56                   	push   %esi
 436:	57                   	push   %edi
 437:	e8 03 ff ff ff       	call   33f <write>
  while(--i >= 0)
 43c:	83 c4 10             	add    $0x10,%esp
 43f:	39 de                	cmp    %ebx,%esi
 441:	75 e9                	jne    42c <printint+0x64>
}
 443:	8d 65 f4             	lea    -0xc(%ebp),%esp
 446:	5b                   	pop    %ebx
 447:	5e                   	pop    %esi
 448:	5f                   	pop    %edi
 449:	5d                   	pop    %ebp
 44a:	c3                   	ret    
 44b:	90                   	nop
    x = -xx;
 44c:	f7 d9                	neg    %ecx
 44e:	eb 9b                	jmp    3eb <printint+0x23>

00000450 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	83 ec 2c             	sub    $0x2c,%esp
 459:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 45c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 45f:	8a 13                	mov    (%ebx),%dl
 461:	84 d2                	test   %dl,%dl
 463:	74 64                	je     4c9 <printf+0x79>
 465:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 466:	8d 45 10             	lea    0x10(%ebp),%eax
 469:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
 46c:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
 46e:	8d 7d e7             	lea    -0x19(%ebp),%edi
 471:	eb 24                	jmp    497 <printf+0x47>
 473:	90                   	nop
 474:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 477:	83 f8 25             	cmp    $0x25,%eax
 47a:	74 40                	je     4bc <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
 47c:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 47f:	50                   	push   %eax
 480:	6a 01                	push   $0x1
 482:	57                   	push   %edi
 483:	56                   	push   %esi
 484:	e8 b6 fe ff ff       	call   33f <write>
        putc(fd, c);
 489:	83 c4 10             	add    $0x10,%esp
 48c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
 48f:	43                   	inc    %ebx
 490:	8a 53 ff             	mov    -0x1(%ebx),%dl
 493:	84 d2                	test   %dl,%dl
 495:	74 32                	je     4c9 <printf+0x79>
    c = fmt[i] & 0xff;
 497:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 49a:	85 c9                	test   %ecx,%ecx
 49c:	74 d6                	je     474 <printf+0x24>
      }
    } else if(state == '%'){
 49e:	83 f9 25             	cmp    $0x25,%ecx
 4a1:	75 ec                	jne    48f <printf+0x3f>
      if(c == 'd'){
 4a3:	83 f8 25             	cmp    $0x25,%eax
 4a6:	0f 84 e4 00 00 00    	je     590 <printf+0x140>
 4ac:	83 e8 63             	sub    $0x63,%eax
 4af:	83 f8 15             	cmp    $0x15,%eax
 4b2:	77 20                	ja     4d4 <printf+0x84>
 4b4:	ff 24 85 74 07 00 00 	jmp    *0x774(,%eax,4)
 4bb:	90                   	nop
        state = '%';
 4bc:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
 4c1:	43                   	inc    %ebx
 4c2:	8a 53 ff             	mov    -0x1(%ebx),%dl
 4c5:	84 d2                	test   %dl,%dl
 4c7:	75 ce                	jne    497 <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4cc:	5b                   	pop    %ebx
 4cd:	5e                   	pop    %esi
 4ce:	5f                   	pop    %edi
 4cf:	5d                   	pop    %ebp
 4d0:	c3                   	ret    
 4d1:	8d 76 00             	lea    0x0(%esi),%esi
 4d4:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
 4d7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 4db:	50                   	push   %eax
 4dc:	6a 01                	push   $0x1
 4de:	57                   	push   %edi
 4df:	56                   	push   %esi
 4e0:	e8 5a fe ff ff       	call   33f <write>
        putc(fd, c);
 4e5:	8a 55 d4             	mov    -0x2c(%ebp),%dl
 4e8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4eb:	83 c4 0c             	add    $0xc,%esp
 4ee:	6a 01                	push   $0x1
 4f0:	57                   	push   %edi
 4f1:	56                   	push   %esi
 4f2:	e8 48 fe ff ff       	call   33f <write>
        putc(fd, c);
 4f7:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4fa:	31 c9                	xor    %ecx,%ecx
 4fc:	eb 91                	jmp    48f <printf+0x3f>
 4fe:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 500:	83 ec 0c             	sub    $0xc,%esp
 503:	6a 00                	push   $0x0
 505:	b9 10 00 00 00       	mov    $0x10,%ecx
 50a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 50d:	8b 10                	mov    (%eax),%edx
 50f:	89 f0                	mov    %esi,%eax
 511:	e8 b2 fe ff ff       	call   3c8 <printint>
        ap++;
 516:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 51a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 51d:	31 c9                	xor    %ecx,%ecx
        ap++;
 51f:	e9 6b ff ff ff       	jmp    48f <printf+0x3f>
        s = (char*)*ap;
 524:	8b 45 d0             	mov    -0x30(%ebp),%eax
 527:	8b 10                	mov    (%eax),%edx
        ap++;
 529:	83 c0 04             	add    $0x4,%eax
 52c:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 52f:	85 d2                	test   %edx,%edx
 531:	74 69                	je     59c <printf+0x14c>
        while(*s != 0){
 533:	8a 02                	mov    (%edx),%al
 535:	84 c0                	test   %al,%al
 537:	74 71                	je     5aa <printf+0x15a>
 539:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 53c:	89 d3                	mov    %edx,%ebx
 53e:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
 540:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 543:	50                   	push   %eax
 544:	6a 01                	push   $0x1
 546:	57                   	push   %edi
 547:	56                   	push   %esi
 548:	e8 f2 fd ff ff       	call   33f <write>
          s++;
 54d:	43                   	inc    %ebx
        while(*s != 0){
 54e:	8a 03                	mov    (%ebx),%al
 550:	83 c4 10             	add    $0x10,%esp
 553:	84 c0                	test   %al,%al
 555:	75 e9                	jne    540 <printf+0xf0>
      state = 0;
 557:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 55a:	31 c9                	xor    %ecx,%ecx
 55c:	e9 2e ff ff ff       	jmp    48f <printf+0x3f>
 561:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 564:	83 ec 0c             	sub    $0xc,%esp
 567:	6a 01                	push   $0x1
 569:	b9 0a 00 00 00       	mov    $0xa,%ecx
 56e:	eb 9a                	jmp    50a <printf+0xba>
        putc(fd, *ap);
 570:	8b 45 d0             	mov    -0x30(%ebp),%eax
 573:	8b 00                	mov    (%eax),%eax
 575:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 578:	51                   	push   %ecx
 579:	6a 01                	push   $0x1
 57b:	57                   	push   %edi
 57c:	56                   	push   %esi
 57d:	e8 bd fd ff ff       	call   33f <write>
        ap++;
 582:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 586:	83 c4 10             	add    $0x10,%esp
      state = 0;
 589:	31 c9                	xor    %ecx,%ecx
 58b:	e9 ff fe ff ff       	jmp    48f <printf+0x3f>
        putc(fd, c);
 590:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 593:	52                   	push   %edx
 594:	e9 55 ff ff ff       	jmp    4ee <printf+0x9e>
 599:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
 59c:	ba 6b 07 00 00       	mov    $0x76b,%edx
        while(*s != 0){
 5a1:	b0 28                	mov    $0x28,%al
 5a3:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 5a6:	89 d3                	mov    %edx,%ebx
 5a8:	eb 96                	jmp    540 <printf+0xf0>
      state = 0;
 5aa:	31 c9                	xor    %ecx,%ecx
 5ac:	e9 de fe ff ff       	jmp    48f <printf+0x3f>
 5b1:	66 90                	xchg   %ax,%ax
 5b3:	90                   	nop

000005b4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b4:	55                   	push   %ebp
 5b5:	89 e5                	mov    %esp,%ebp
 5b7:	57                   	push   %edi
 5b8:	56                   	push   %esi
 5b9:	53                   	push   %ebx
 5ba:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5bd:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c0:	a1 e0 09 00 00       	mov    0x9e0,%eax
 5c5:	8d 76 00             	lea    0x0(%esi),%esi
 5c8:	89 c2                	mov    %eax,%edx
 5ca:	8b 00                	mov    (%eax),%eax
 5cc:	39 ca                	cmp    %ecx,%edx
 5ce:	73 2c                	jae    5fc <free+0x48>
 5d0:	39 c1                	cmp    %eax,%ecx
 5d2:	72 04                	jb     5d8 <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d4:	39 c2                	cmp    %eax,%edx
 5d6:	72 f0                	jb     5c8 <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5de:	39 f8                	cmp    %edi,%eax
 5e0:	74 2c                	je     60e <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5e2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5e5:	8b 42 04             	mov    0x4(%edx),%eax
 5e8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 5eb:	39 f1                	cmp    %esi,%ecx
 5ed:	74 36                	je     625 <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 5ef:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
 5f1:	89 15 e0 09 00 00    	mov    %edx,0x9e0
}
 5f7:	5b                   	pop    %ebx
 5f8:	5e                   	pop    %esi
 5f9:	5f                   	pop    %edi
 5fa:	5d                   	pop    %ebp
 5fb:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5fc:	39 c2                	cmp    %eax,%edx
 5fe:	72 c8                	jb     5c8 <free+0x14>
 600:	39 c1                	cmp    %eax,%ecx
 602:	73 c4                	jae    5c8 <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
 604:	8b 73 fc             	mov    -0x4(%ebx),%esi
 607:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 60a:	39 f8                	cmp    %edi,%eax
 60c:	75 d4                	jne    5e2 <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
 60e:	03 70 04             	add    0x4(%eax),%esi
 611:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 614:	8b 02                	mov    (%edx),%eax
 616:	8b 00                	mov    (%eax),%eax
 618:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 61b:	8b 42 04             	mov    0x4(%edx),%eax
 61e:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 621:	39 f1                	cmp    %esi,%ecx
 623:	75 ca                	jne    5ef <free+0x3b>
    p->s.size += bp->s.size;
 625:	03 43 fc             	add    -0x4(%ebx),%eax
 628:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 62b:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 62e:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 630:	89 15 e0 09 00 00    	mov    %edx,0x9e0
}
 636:	5b                   	pop    %ebx
 637:	5e                   	pop    %esi
 638:	5f                   	pop    %edi
 639:	5d                   	pop    %ebp
 63a:	c3                   	ret    
 63b:	90                   	nop

0000063c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 63c:	55                   	push   %ebp
 63d:	89 e5                	mov    %esp,%ebp
 63f:	57                   	push   %edi
 640:	56                   	push   %esi
 641:	53                   	push   %ebx
 642:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 645:	8b 45 08             	mov    0x8(%ebp),%eax
 648:	8d 70 07             	lea    0x7(%eax),%esi
 64b:	c1 ee 03             	shr    $0x3,%esi
 64e:	46                   	inc    %esi
  if((prevp = freep) == 0){
 64f:	8b 3d e0 09 00 00    	mov    0x9e0,%edi
 655:	85 ff                	test   %edi,%edi
 657:	0f 84 a3 00 00 00    	je     700 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 65d:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 65f:	8b 4a 04             	mov    0x4(%edx),%ecx
 662:	39 f1                	cmp    %esi,%ecx
 664:	73 68                	jae    6ce <malloc+0x92>
 666:	89 f3                	mov    %esi,%ebx
 668:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 66e:	0f 82 80 00 00 00    	jb     6f4 <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
 674:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 67b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 67e:	eb 11                	jmp    691 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 680:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 682:	8b 48 04             	mov    0x4(%eax),%ecx
 685:	39 f1                	cmp    %esi,%ecx
 687:	73 4b                	jae    6d4 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 689:	8b 3d e0 09 00 00    	mov    0x9e0,%edi
 68f:	89 c2                	mov    %eax,%edx
 691:	39 d7                	cmp    %edx,%edi
 693:	75 eb                	jne    680 <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
 695:	83 ec 0c             	sub    $0xc,%esp
 698:	ff 75 e4             	push   -0x1c(%ebp)
 69b:	e8 07 fd ff ff       	call   3a7 <sbrk>
  if(p == (char*)-1)
 6a0:	83 c4 10             	add    $0x10,%esp
 6a3:	83 f8 ff             	cmp    $0xffffffff,%eax
 6a6:	74 1c                	je     6c4 <malloc+0x88>
  hp->s.size = nu;
 6a8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6ab:	83 ec 0c             	sub    $0xc,%esp
 6ae:	83 c0 08             	add    $0x8,%eax
 6b1:	50                   	push   %eax
 6b2:	e8 fd fe ff ff       	call   5b4 <free>
  return freep;
 6b7:	8b 15 e0 09 00 00    	mov    0x9e0,%edx
      if((p = morecore(nunits)) == 0)
 6bd:	83 c4 10             	add    $0x10,%esp
 6c0:	85 d2                	test   %edx,%edx
 6c2:	75 bc                	jne    680 <malloc+0x44>
        return 0;
 6c4:	31 c0                	xor    %eax,%eax
  }
}
 6c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6c9:	5b                   	pop    %ebx
 6ca:	5e                   	pop    %esi
 6cb:	5f                   	pop    %edi
 6cc:	5d                   	pop    %ebp
 6cd:	c3                   	ret    
    if(p->s.size >= nunits){
 6ce:	89 d0                	mov    %edx,%eax
 6d0:	89 fa                	mov    %edi,%edx
 6d2:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 6d4:	39 ce                	cmp    %ecx,%esi
 6d6:	74 54                	je     72c <malloc+0xf0>
        p->s.size -= nunits;
 6d8:	29 f1                	sub    %esi,%ecx
 6da:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6dd:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6e0:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 6e3:	89 15 e0 09 00 00    	mov    %edx,0x9e0
      return (void*)(p + 1);
 6e9:	83 c0 08             	add    $0x8,%eax
}
 6ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6ef:	5b                   	pop    %ebx
 6f0:	5e                   	pop    %esi
 6f1:	5f                   	pop    %edi
 6f2:	5d                   	pop    %ebp
 6f3:	c3                   	ret    
 6f4:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6f9:	e9 76 ff ff ff       	jmp    674 <malloc+0x38>
 6fe:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 700:	c7 05 e0 09 00 00 e4 	movl   $0x9e4,0x9e0
 707:	09 00 00 
 70a:	c7 05 e4 09 00 00 e4 	movl   $0x9e4,0x9e4
 711:	09 00 00 
    base.s.size = 0;
 714:	c7 05 e8 09 00 00 00 	movl   $0x0,0x9e8
 71b:	00 00 00 
 71e:	bf e4 09 00 00       	mov    $0x9e4,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 723:	89 fa                	mov    %edi,%edx
 725:	e9 3c ff ff ff       	jmp    666 <malloc+0x2a>
 72a:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 72c:	8b 08                	mov    (%eax),%ecx
 72e:	89 0a                	mov    %ecx,(%edx)
 730:	eb b1                	jmp    6e3 <malloc+0xa7>
