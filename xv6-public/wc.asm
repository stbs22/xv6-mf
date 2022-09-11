
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
  64:	68 4f 07 00 00       	push   $0x74f
  69:	6a 01                	push   $0x1
  6b:	e8 d8 03 00 00       	call   448 <printf>
      exit();
  70:	e8 aa 02 00 00       	call   31f <exit>
    wc(0, "");
  75:	52                   	push   %edx
  76:	52                   	push   %edx
  77:	68 41 07 00 00       	push   $0x741
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
  e1:	68 2c 07 00 00       	push   $0x72c
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
 11d:	68 42 07 00 00       	push   $0x742
 122:	6a 01                	push   $0x1
 124:	e8 1f 03 00 00       	call   448 <printf>
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
 136:	68 32 07 00 00       	push   $0x732
 13b:	6a 01                	push   $0x1
 13d:	e8 06 03 00 00       	call   448 <printf>
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
 3bf:	90                   	nop

000003c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	83 ec 3c             	sub    $0x3c,%esp
 3c9:	89 45 bc             	mov    %eax,-0x44(%ebp)
 3cc:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3cf:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
 3d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3d4:	85 db                	test   %ebx,%ebx
 3d6:	74 04                	je     3dc <printint+0x1c>
 3d8:	85 d2                	test   %edx,%edx
 3da:	78 68                	js     444 <printint+0x84>
  neg = 0;
 3dc:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3e3:	31 ff                	xor    %edi,%edi
 3e5:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 3e8:	89 c8                	mov    %ecx,%eax
 3ea:	31 d2                	xor    %edx,%edx
 3ec:	f7 75 c4             	divl   -0x3c(%ebp)
 3ef:	89 fb                	mov    %edi,%ebx
 3f1:	8d 7f 01             	lea    0x1(%edi),%edi
 3f4:	8a 92 c4 07 00 00    	mov    0x7c4(%edx),%dl
 3fa:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 3fe:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 401:	89 c1                	mov    %eax,%ecx
 403:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 406:	3b 45 c0             	cmp    -0x40(%ebp),%eax
 409:	76 dd                	jbe    3e8 <printint+0x28>
  if(neg)
 40b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 40e:	85 c9                	test   %ecx,%ecx
 410:	74 09                	je     41b <printint+0x5b>
    buf[i++] = '-';
 412:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
 417:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
 419:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
 41b:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 41f:	8b 7d bc             	mov    -0x44(%ebp),%edi
 422:	eb 03                	jmp    427 <printint+0x67>
    putc(fd, buf[i]);
 424:	8a 13                	mov    (%ebx),%dl
 426:	4b                   	dec    %ebx
 427:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
 42a:	50                   	push   %eax
 42b:	6a 01                	push   $0x1
 42d:	56                   	push   %esi
 42e:	57                   	push   %edi
 42f:	e8 0b ff ff ff       	call   33f <write>
  while(--i >= 0)
 434:	83 c4 10             	add    $0x10,%esp
 437:	39 de                	cmp    %ebx,%esi
 439:	75 e9                	jne    424 <printint+0x64>
}
 43b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 43e:	5b                   	pop    %ebx
 43f:	5e                   	pop    %esi
 440:	5f                   	pop    %edi
 441:	5d                   	pop    %ebp
 442:	c3                   	ret    
 443:	90                   	nop
    x = -xx;
 444:	f7 d9                	neg    %ecx
 446:	eb 9b                	jmp    3e3 <printint+0x23>

00000448 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 448:	55                   	push   %ebp
 449:	89 e5                	mov    %esp,%ebp
 44b:	57                   	push   %edi
 44c:	56                   	push   %esi
 44d:	53                   	push   %ebx
 44e:	83 ec 2c             	sub    $0x2c,%esp
 451:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 454:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 457:	8a 13                	mov    (%ebx),%dl
 459:	84 d2                	test   %dl,%dl
 45b:	74 64                	je     4c1 <printf+0x79>
 45d:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 45e:	8d 45 10             	lea    0x10(%ebp),%eax
 461:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
 464:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
 466:	8d 7d e7             	lea    -0x19(%ebp),%edi
 469:	eb 24                	jmp    48f <printf+0x47>
 46b:	90                   	nop
 46c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 46f:	83 f8 25             	cmp    $0x25,%eax
 472:	74 40                	je     4b4 <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
 474:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 477:	50                   	push   %eax
 478:	6a 01                	push   $0x1
 47a:	57                   	push   %edi
 47b:	56                   	push   %esi
 47c:	e8 be fe ff ff       	call   33f <write>
        putc(fd, c);
 481:	83 c4 10             	add    $0x10,%esp
 484:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
 487:	43                   	inc    %ebx
 488:	8a 53 ff             	mov    -0x1(%ebx),%dl
 48b:	84 d2                	test   %dl,%dl
 48d:	74 32                	je     4c1 <printf+0x79>
    c = fmt[i] & 0xff;
 48f:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 492:	85 c9                	test   %ecx,%ecx
 494:	74 d6                	je     46c <printf+0x24>
      }
    } else if(state == '%'){
 496:	83 f9 25             	cmp    $0x25,%ecx
 499:	75 ec                	jne    487 <printf+0x3f>
      if(c == 'd'){
 49b:	83 f8 25             	cmp    $0x25,%eax
 49e:	0f 84 e4 00 00 00    	je     588 <printf+0x140>
 4a4:	83 e8 63             	sub    $0x63,%eax
 4a7:	83 f8 15             	cmp    $0x15,%eax
 4aa:	77 20                	ja     4cc <printf+0x84>
 4ac:	ff 24 85 6c 07 00 00 	jmp    *0x76c(,%eax,4)
 4b3:	90                   	nop
        state = '%';
 4b4:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
 4b9:	43                   	inc    %ebx
 4ba:	8a 53 ff             	mov    -0x1(%ebx),%dl
 4bd:	84 d2                	test   %dl,%dl
 4bf:	75 ce                	jne    48f <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4c4:	5b                   	pop    %ebx
 4c5:	5e                   	pop    %esi
 4c6:	5f                   	pop    %edi
 4c7:	5d                   	pop    %ebp
 4c8:	c3                   	ret    
 4c9:	8d 76 00             	lea    0x0(%esi),%esi
 4cc:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
 4cf:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 4d3:	50                   	push   %eax
 4d4:	6a 01                	push   $0x1
 4d6:	57                   	push   %edi
 4d7:	56                   	push   %esi
 4d8:	e8 62 fe ff ff       	call   33f <write>
        putc(fd, c);
 4dd:	8a 55 d4             	mov    -0x2c(%ebp),%dl
 4e0:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4e3:	83 c4 0c             	add    $0xc,%esp
 4e6:	6a 01                	push   $0x1
 4e8:	57                   	push   %edi
 4e9:	56                   	push   %esi
 4ea:	e8 50 fe ff ff       	call   33f <write>
        putc(fd, c);
 4ef:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4f2:	31 c9                	xor    %ecx,%ecx
 4f4:	eb 91                	jmp    487 <printf+0x3f>
 4f6:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 4f8:	83 ec 0c             	sub    $0xc,%esp
 4fb:	6a 00                	push   $0x0
 4fd:	b9 10 00 00 00       	mov    $0x10,%ecx
 502:	8b 45 d0             	mov    -0x30(%ebp),%eax
 505:	8b 10                	mov    (%eax),%edx
 507:	89 f0                	mov    %esi,%eax
 509:	e8 b2 fe ff ff       	call   3c0 <printint>
        ap++;
 50e:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 512:	83 c4 10             	add    $0x10,%esp
      state = 0;
 515:	31 c9                	xor    %ecx,%ecx
        ap++;
 517:	e9 6b ff ff ff       	jmp    487 <printf+0x3f>
        s = (char*)*ap;
 51c:	8b 45 d0             	mov    -0x30(%ebp),%eax
 51f:	8b 10                	mov    (%eax),%edx
        ap++;
 521:	83 c0 04             	add    $0x4,%eax
 524:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 527:	85 d2                	test   %edx,%edx
 529:	74 69                	je     594 <printf+0x14c>
        while(*s != 0){
 52b:	8a 02                	mov    (%edx),%al
 52d:	84 c0                	test   %al,%al
 52f:	74 71                	je     5a2 <printf+0x15a>
 531:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 534:	89 d3                	mov    %edx,%ebx
 536:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
 538:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 53b:	50                   	push   %eax
 53c:	6a 01                	push   $0x1
 53e:	57                   	push   %edi
 53f:	56                   	push   %esi
 540:	e8 fa fd ff ff       	call   33f <write>
          s++;
 545:	43                   	inc    %ebx
        while(*s != 0){
 546:	8a 03                	mov    (%ebx),%al
 548:	83 c4 10             	add    $0x10,%esp
 54b:	84 c0                	test   %al,%al
 54d:	75 e9                	jne    538 <printf+0xf0>
      state = 0;
 54f:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 552:	31 c9                	xor    %ecx,%ecx
 554:	e9 2e ff ff ff       	jmp    487 <printf+0x3f>
 559:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 55c:	83 ec 0c             	sub    $0xc,%esp
 55f:	6a 01                	push   $0x1
 561:	b9 0a 00 00 00       	mov    $0xa,%ecx
 566:	eb 9a                	jmp    502 <printf+0xba>
        putc(fd, *ap);
 568:	8b 45 d0             	mov    -0x30(%ebp),%eax
 56b:	8b 00                	mov    (%eax),%eax
 56d:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 570:	51                   	push   %ecx
 571:	6a 01                	push   $0x1
 573:	57                   	push   %edi
 574:	56                   	push   %esi
 575:	e8 c5 fd ff ff       	call   33f <write>
        ap++;
 57a:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 57e:	83 c4 10             	add    $0x10,%esp
      state = 0;
 581:	31 c9                	xor    %ecx,%ecx
 583:	e9 ff fe ff ff       	jmp    487 <printf+0x3f>
        putc(fd, c);
 588:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 58b:	52                   	push   %edx
 58c:	e9 55 ff ff ff       	jmp    4e6 <printf+0x9e>
 591:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
 594:	ba 63 07 00 00       	mov    $0x763,%edx
        while(*s != 0){
 599:	b0 28                	mov    $0x28,%al
 59b:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 59e:	89 d3                	mov    %edx,%ebx
 5a0:	eb 96                	jmp    538 <printf+0xf0>
      state = 0;
 5a2:	31 c9                	xor    %ecx,%ecx
 5a4:	e9 de fe ff ff       	jmp    487 <printf+0x3f>
 5a9:	66 90                	xchg   %ax,%ax
 5ab:	90                   	nop

000005ac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5ac:	55                   	push   %ebp
 5ad:	89 e5                	mov    %esp,%ebp
 5af:	57                   	push   %edi
 5b0:	56                   	push   %esi
 5b1:	53                   	push   %ebx
 5b2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b5:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b8:	a1 e0 09 00 00       	mov    0x9e0,%eax
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
 5c0:	89 c2                	mov    %eax,%edx
 5c2:	8b 00                	mov    (%eax),%eax
 5c4:	39 ca                	cmp    %ecx,%edx
 5c6:	73 2c                	jae    5f4 <free+0x48>
 5c8:	39 c1                	cmp    %eax,%ecx
 5ca:	72 04                	jb     5d0 <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5cc:	39 c2                	cmp    %eax,%edx
 5ce:	72 f0                	jb     5c0 <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5d3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5d6:	39 f8                	cmp    %edi,%eax
 5d8:	74 2c                	je     606 <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5da:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5dd:	8b 42 04             	mov    0x4(%edx),%eax
 5e0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 5e3:	39 f1                	cmp    %esi,%ecx
 5e5:	74 36                	je     61d <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 5e7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
 5e9:	89 15 e0 09 00 00    	mov    %edx,0x9e0
}
 5ef:	5b                   	pop    %ebx
 5f0:	5e                   	pop    %esi
 5f1:	5f                   	pop    %edi
 5f2:	5d                   	pop    %ebp
 5f3:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f4:	39 c2                	cmp    %eax,%edx
 5f6:	72 c8                	jb     5c0 <free+0x14>
 5f8:	39 c1                	cmp    %eax,%ecx
 5fa:	73 c4                	jae    5c0 <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
 5fc:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5ff:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 602:	39 f8                	cmp    %edi,%eax
 604:	75 d4                	jne    5da <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
 606:	03 70 04             	add    0x4(%eax),%esi
 609:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 60c:	8b 02                	mov    (%edx),%eax
 60e:	8b 00                	mov    (%eax),%eax
 610:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 613:	8b 42 04             	mov    0x4(%edx),%eax
 616:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 619:	39 f1                	cmp    %esi,%ecx
 61b:	75 ca                	jne    5e7 <free+0x3b>
    p->s.size += bp->s.size;
 61d:	03 43 fc             	add    -0x4(%ebx),%eax
 620:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 623:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 626:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 628:	89 15 e0 09 00 00    	mov    %edx,0x9e0
}
 62e:	5b                   	pop    %ebx
 62f:	5e                   	pop    %esi
 630:	5f                   	pop    %edi
 631:	5d                   	pop    %ebp
 632:	c3                   	ret    
 633:	90                   	nop

00000634 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 634:	55                   	push   %ebp
 635:	89 e5                	mov    %esp,%ebp
 637:	57                   	push   %edi
 638:	56                   	push   %esi
 639:	53                   	push   %ebx
 63a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 63d:	8b 45 08             	mov    0x8(%ebp),%eax
 640:	8d 70 07             	lea    0x7(%eax),%esi
 643:	c1 ee 03             	shr    $0x3,%esi
 646:	46                   	inc    %esi
  if((prevp = freep) == 0){
 647:	8b 3d e0 09 00 00    	mov    0x9e0,%edi
 64d:	85 ff                	test   %edi,%edi
 64f:	0f 84 a3 00 00 00    	je     6f8 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 655:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 657:	8b 4a 04             	mov    0x4(%edx),%ecx
 65a:	39 f1                	cmp    %esi,%ecx
 65c:	73 68                	jae    6c6 <malloc+0x92>
 65e:	89 f3                	mov    %esi,%ebx
 660:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 666:	0f 82 80 00 00 00    	jb     6ec <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
 66c:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 673:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 676:	eb 11                	jmp    689 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 678:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 67a:	8b 48 04             	mov    0x4(%eax),%ecx
 67d:	39 f1                	cmp    %esi,%ecx
 67f:	73 4b                	jae    6cc <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 681:	8b 3d e0 09 00 00    	mov    0x9e0,%edi
 687:	89 c2                	mov    %eax,%edx
 689:	39 d7                	cmp    %edx,%edi
 68b:	75 eb                	jne    678 <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
 68d:	83 ec 0c             	sub    $0xc,%esp
 690:	ff 75 e4             	push   -0x1c(%ebp)
 693:	e8 0f fd ff ff       	call   3a7 <sbrk>
  if(p == (char*)-1)
 698:	83 c4 10             	add    $0x10,%esp
 69b:	83 f8 ff             	cmp    $0xffffffff,%eax
 69e:	74 1c                	je     6bc <malloc+0x88>
  hp->s.size = nu;
 6a0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6a3:	83 ec 0c             	sub    $0xc,%esp
 6a6:	83 c0 08             	add    $0x8,%eax
 6a9:	50                   	push   %eax
 6aa:	e8 fd fe ff ff       	call   5ac <free>
  return freep;
 6af:	8b 15 e0 09 00 00    	mov    0x9e0,%edx
      if((p = morecore(nunits)) == 0)
 6b5:	83 c4 10             	add    $0x10,%esp
 6b8:	85 d2                	test   %edx,%edx
 6ba:	75 bc                	jne    678 <malloc+0x44>
        return 0;
 6bc:	31 c0                	xor    %eax,%eax
  }
}
 6be:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6c1:	5b                   	pop    %ebx
 6c2:	5e                   	pop    %esi
 6c3:	5f                   	pop    %edi
 6c4:	5d                   	pop    %ebp
 6c5:	c3                   	ret    
    if(p->s.size >= nunits){
 6c6:	89 d0                	mov    %edx,%eax
 6c8:	89 fa                	mov    %edi,%edx
 6ca:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 6cc:	39 ce                	cmp    %ecx,%esi
 6ce:	74 54                	je     724 <malloc+0xf0>
        p->s.size -= nunits;
 6d0:	29 f1                	sub    %esi,%ecx
 6d2:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6d5:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6d8:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 6db:	89 15 e0 09 00 00    	mov    %edx,0x9e0
      return (void*)(p + 1);
 6e1:	83 c0 08             	add    $0x8,%eax
}
 6e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6e7:	5b                   	pop    %ebx
 6e8:	5e                   	pop    %esi
 6e9:	5f                   	pop    %edi
 6ea:	5d                   	pop    %ebp
 6eb:	c3                   	ret    
 6ec:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6f1:	e9 76 ff ff ff       	jmp    66c <malloc+0x38>
 6f6:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 6f8:	c7 05 e0 09 00 00 e4 	movl   $0x9e4,0x9e0
 6ff:	09 00 00 
 702:	c7 05 e4 09 00 00 e4 	movl   $0x9e4,0x9e4
 709:	09 00 00 
    base.s.size = 0;
 70c:	c7 05 e8 09 00 00 00 	movl   $0x0,0x9e8
 713:	00 00 00 
 716:	bf e4 09 00 00       	mov    $0x9e4,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 71b:	89 fa                	mov    %edi,%edx
 71d:	e9 3c ff ff ff       	jmp    65e <malloc+0x2a>
 722:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 724:	8b 08                	mov    (%eax),%ecx
 726:	89 0a                	mov    %ecx,(%edx)
 728:	eb b1                	jmp    6db <malloc+0xa7>
