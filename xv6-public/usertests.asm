
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 6a 49 00 00       	push   $0x496a
      16:	6a 01                	push   $0x1
      18:	e8 7b 36 00 00       	call   3698 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 7e 49 00 00       	push   $0x497e
      26:	e8 84 35 00 00       	call   35af <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 e8 50 00 00       	push   $0x50e8
      39:	6a 01                	push   $0x1
      3b:	e8 58 36 00 00       	call   3698 <printf>
    exit();
      40:	e8 2a 35 00 00       	call   356f <exit>
  }
  close(open("usertests.ran", O_CREATE));
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 7e 49 00 00       	push   $0x497e
      51:	e8 59 35 00 00       	call   35af <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 39 35 00 00       	call   3597 <close>

  argptest();
      5e:	e8 a9 32 00 00       	call   330c <argptest>
  createdelete();
      63:	e8 8c 10 00 00       	call   10f4 <createdelete>
  linkunlink();
      68:	e8 87 18 00 00       	call   18f4 <linkunlink>
  concreate();
      6d:	e8 c2 15 00 00       	call   1634 <concreate>
  fourfiles();
      72:	e8 b5 0e 00 00       	call   f2c <fourfiles>
  sharedfd();
      77:	e8 18 0d 00 00       	call   d94 <sharedfd>

  bigargtest();
      7c:	e8 8f 2f 00 00       	call   3010 <bigargtest>
  bigwrite();
      81:	e8 82 21 00 00       	call   2208 <bigwrite>
  bigargtest();
      86:	e8 85 2f 00 00       	call   3010 <bigargtest>
  bsstest();
      8b:	e8 20 2f 00 00       	call   2fb0 <bsstest>
  sbrktest();
      90:	e8 53 2a 00 00       	call   2ae8 <sbrktest>
  validatetest();
      95:	e8 6a 2e 00 00       	call   2f04 <validatetest>

  opentest();
      9a:	e8 39 03 00 00       	call   3d8 <opentest>
  writetest();
      9f:	e8 c4 03 00 00       	call   468 <writetest>
  writetest1();
      a4:	e8 8b 05 00 00       	call   634 <writetest1>
  createtest();
      a9:	e8 32 07 00 00       	call   7e0 <createtest>

  openiputtest();
      ae:	e8 35 02 00 00       	call   2e8 <openiputtest>
  exitiputtest();
      b3:	e8 3c 01 00 00       	call   1f4 <exitiputtest>
  iputtest();
      b8:	e8 57 00 00 00       	call   114 <iputtest>

  mem();
      bd:	e8 1a 0c 00 00       	call   cdc <mem>
  pipe1();
      c2:	e8 e1 08 00 00       	call   9a8 <pipe1>
  preempt();
      c7:	e8 58 0a 00 00       	call   b24 <preempt>
  exitwait();
      cc:	e8 93 0b 00 00       	call   c64 <exitwait>

  rmdot();
      d1:	e8 f2 24 00 00       	call   25c8 <rmdot>
  fourteen();
      d6:	e8 b9 23 00 00       	call   2494 <fourteen>
  bigfile();
      db:	e8 fc 21 00 00       	call   22dc <bigfile>
  subdir();
      e0:	e8 4b 1a 00 00       	call   1b30 <subdir>
  linktest();
      e5:	e8 3e 13 00 00       	call   1428 <linktest>
  unlinkread();
      ea:	e8 b5 11 00 00       	call   12a4 <unlinkread>
  dirfile();
      ef:	e8 48 26 00 00       	call   273c <dirfile>
  iref();
      f4:	e8 3b 28 00 00       	call   2934 <iref>
  forktest();
      f9:	e8 4e 29 00 00       	call   2a4c <forktest>
  bigdir(); // slow
      fe:	e8 01 19 00 00       	call   1a04 <bigdir>

  uio();
     103:	e8 94 31 00 00       	call   329c <uio>

  exectest();
     108:	e8 53 08 00 00       	call   960 <exectest>

  exit();
     10d:	e8 5d 34 00 00       	call   356f <exit>
     112:	66 90                	xchg   %ax,%ax

00000114 <iputtest>:
{
     114:	55                   	push   %ebp
     115:	89 e5                	mov    %esp,%ebp
     117:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     11a:	68 10 3a 00 00       	push   $0x3a10
     11f:	ff 35 9c 51 00 00    	push   0x519c
     125:	e8 6e 35 00 00       	call   3698 <printf>
  if(mkdir("iputdir") < 0){
     12a:	c7 04 24 a3 39 00 00 	movl   $0x39a3,(%esp)
     131:	e8 a1 34 00 00       	call   35d7 <mkdir>
     136:	83 c4 10             	add    $0x10,%esp
     139:	85 c0                	test   %eax,%eax
     13b:	78 58                	js     195 <iputtest+0x81>
  if(chdir("iputdir") < 0){
     13d:	83 ec 0c             	sub    $0xc,%esp
     140:	68 a3 39 00 00       	push   $0x39a3
     145:	e8 95 34 00 00       	call   35df <chdir>
     14a:	83 c4 10             	add    $0x10,%esp
     14d:	85 c0                	test   %eax,%eax
     14f:	0f 88 85 00 00 00    	js     1da <iputtest+0xc6>
  if(unlink("../iputdir") < 0){
     155:	83 ec 0c             	sub    $0xc,%esp
     158:	68 a0 39 00 00       	push   $0x39a0
     15d:	e8 5d 34 00 00       	call   35bf <unlink>
     162:	83 c4 10             	add    $0x10,%esp
     165:	85 c0                	test   %eax,%eax
     167:	78 5a                	js     1c3 <iputtest+0xaf>
  if(chdir("/") < 0){
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	68 c5 39 00 00       	push   $0x39c5
     171:	e8 69 34 00 00       	call   35df <chdir>
     176:	83 c4 10             	add    $0x10,%esp
     179:	85 c0                	test   %eax,%eax
     17b:	78 2f                	js     1ac <iputtest+0x98>
  printf(stdout, "iput test ok\n");
     17d:	83 ec 08             	sub    $0x8,%esp
     180:	68 48 3a 00 00       	push   $0x3a48
     185:	ff 35 9c 51 00 00    	push   0x519c
     18b:	e8 08 35 00 00       	call   3698 <printf>
}
     190:	83 c4 10             	add    $0x10,%esp
     193:	c9                   	leave  
     194:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     195:	50                   	push   %eax
     196:	50                   	push   %eax
     197:	68 7c 39 00 00       	push   $0x397c
     19c:	ff 35 9c 51 00 00    	push   0x519c
     1a2:	e8 f1 34 00 00       	call   3698 <printf>
    exit();
     1a7:	e8 c3 33 00 00       	call   356f <exit>
    printf(stdout, "chdir / failed\n");
     1ac:	50                   	push   %eax
     1ad:	50                   	push   %eax
     1ae:	68 c7 39 00 00       	push   $0x39c7
     1b3:	ff 35 9c 51 00 00    	push   0x519c
     1b9:	e8 da 34 00 00       	call   3698 <printf>
    exit();
     1be:	e8 ac 33 00 00       	call   356f <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     1c3:	52                   	push   %edx
     1c4:	52                   	push   %edx
     1c5:	68 ab 39 00 00       	push   $0x39ab
     1ca:	ff 35 9c 51 00 00    	push   0x519c
     1d0:	e8 c3 34 00 00       	call   3698 <printf>
    exit();
     1d5:	e8 95 33 00 00       	call   356f <exit>
    printf(stdout, "chdir iputdir failed\n");
     1da:	51                   	push   %ecx
     1db:	51                   	push   %ecx
     1dc:	68 8a 39 00 00       	push   $0x398a
     1e1:	ff 35 9c 51 00 00    	push   0x519c
     1e7:	e8 ac 34 00 00       	call   3698 <printf>
    exit();
     1ec:	e8 7e 33 00 00       	call   356f <exit>
     1f1:	8d 76 00             	lea    0x0(%esi),%esi

000001f4 <exitiputtest>:
{
     1f4:	55                   	push   %ebp
     1f5:	89 e5                	mov    %esp,%ebp
     1f7:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
     1fa:	68 d7 39 00 00       	push   $0x39d7
     1ff:	ff 35 9c 51 00 00    	push   0x519c
     205:	e8 8e 34 00 00       	call   3698 <printf>
  pid = fork();
     20a:	e8 58 33 00 00       	call   3567 <fork>
  if(pid < 0){
     20f:	83 c4 10             	add    $0x10,%esp
     212:	85 c0                	test   %eax,%eax
     214:	0f 88 86 00 00 00    	js     2a0 <exitiputtest+0xac>
  if(pid == 0){
     21a:	75 4c                	jne    268 <exitiputtest+0x74>
    if(mkdir("iputdir") < 0){
     21c:	83 ec 0c             	sub    $0xc,%esp
     21f:	68 a3 39 00 00       	push   $0x39a3
     224:	e8 ae 33 00 00       	call   35d7 <mkdir>
     229:	83 c4 10             	add    $0x10,%esp
     22c:	85 c0                	test   %eax,%eax
     22e:	0f 88 83 00 00 00    	js     2b7 <exitiputtest+0xc3>
    if(chdir("iputdir") < 0){
     234:	83 ec 0c             	sub    $0xc,%esp
     237:	68 a3 39 00 00       	push   $0x39a3
     23c:	e8 9e 33 00 00       	call   35df <chdir>
     241:	83 c4 10             	add    $0x10,%esp
     244:	85 c0                	test   %eax,%eax
     246:	0f 88 82 00 00 00    	js     2ce <exitiputtest+0xda>
    if(unlink("../iputdir") < 0){
     24c:	83 ec 0c             	sub    $0xc,%esp
     24f:	68 a0 39 00 00       	push   $0x39a0
     254:	e8 66 33 00 00       	call   35bf <unlink>
     259:	83 c4 10             	add    $0x10,%esp
     25c:	85 c0                	test   %eax,%eax
     25e:	78 28                	js     288 <exitiputtest+0x94>
    exit();
     260:	e8 0a 33 00 00       	call   356f <exit>
     265:	8d 76 00             	lea    0x0(%esi),%esi
  wait();
     268:	e8 0a 33 00 00       	call   3577 <wait>
  printf(stdout, "exitiput test ok\n");
     26d:	83 ec 08             	sub    $0x8,%esp
     270:	68 fa 39 00 00       	push   $0x39fa
     275:	ff 35 9c 51 00 00    	push   0x519c
     27b:	e8 18 34 00 00       	call   3698 <printf>
}
     280:	83 c4 10             	add    $0x10,%esp
     283:	c9                   	leave  
     284:	c3                   	ret    
     285:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     288:	83 ec 08             	sub    $0x8,%esp
     28b:	68 ab 39 00 00       	push   $0x39ab
     290:	ff 35 9c 51 00 00    	push   0x519c
     296:	e8 fd 33 00 00       	call   3698 <printf>
      exit();
     29b:	e8 cf 32 00 00       	call   356f <exit>
    printf(stdout, "fork failed\n");
     2a0:	51                   	push   %ecx
     2a1:	51                   	push   %ecx
     2a2:	68 bd 48 00 00       	push   $0x48bd
     2a7:	ff 35 9c 51 00 00    	push   0x519c
     2ad:	e8 e6 33 00 00       	call   3698 <printf>
    exit();
     2b2:	e8 b8 32 00 00       	call   356f <exit>
      printf(stdout, "mkdir failed\n");
     2b7:	52                   	push   %edx
     2b8:	52                   	push   %edx
     2b9:	68 7c 39 00 00       	push   $0x397c
     2be:	ff 35 9c 51 00 00    	push   0x519c
     2c4:	e8 cf 33 00 00       	call   3698 <printf>
      exit();
     2c9:	e8 a1 32 00 00       	call   356f <exit>
      printf(stdout, "child chdir failed\n");
     2ce:	50                   	push   %eax
     2cf:	50                   	push   %eax
     2d0:	68 e6 39 00 00       	push   $0x39e6
     2d5:	ff 35 9c 51 00 00    	push   0x519c
     2db:	e8 b8 33 00 00       	call   3698 <printf>
      exit();
     2e0:	e8 8a 32 00 00       	call   356f <exit>
     2e5:	8d 76 00             	lea    0x0(%esi),%esi

000002e8 <openiputtest>:
{
     2e8:	55                   	push   %ebp
     2e9:	89 e5                	mov    %esp,%ebp
     2eb:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
     2ee:	68 0c 3a 00 00       	push   $0x3a0c
     2f3:	ff 35 9c 51 00 00    	push   0x519c
     2f9:	e8 9a 33 00 00       	call   3698 <printf>
  if(mkdir("oidir") < 0){
     2fe:	c7 04 24 1b 3a 00 00 	movl   $0x3a1b,(%esp)
     305:	e8 cd 32 00 00       	call   35d7 <mkdir>
     30a:	83 c4 10             	add    $0x10,%esp
     30d:	85 c0                	test   %eax,%eax
     30f:	0f 88 93 00 00 00    	js     3a8 <openiputtest+0xc0>
  pid = fork();
     315:	e8 4d 32 00 00       	call   3567 <fork>
  if(pid < 0){
     31a:	85 c0                	test   %eax,%eax
     31c:	78 73                	js     391 <openiputtest+0xa9>
  if(pid == 0){
     31e:	75 30                	jne    350 <openiputtest+0x68>
    int fd = open("oidir", O_RDWR);
     320:	83 ec 08             	sub    $0x8,%esp
     323:	6a 02                	push   $0x2
     325:	68 1b 3a 00 00       	push   $0x3a1b
     32a:	e8 80 32 00 00       	call   35af <open>
    if(fd >= 0){
     32f:	83 c4 10             	add    $0x10,%esp
     332:	85 c0                	test   %eax,%eax
     334:	78 56                	js     38c <openiputtest+0xa4>
      printf(stdout, "open directory for write succeeded\n");
     336:	83 ec 08             	sub    $0x8,%esp
     339:	68 a0 49 00 00       	push   $0x49a0
     33e:	ff 35 9c 51 00 00    	push   0x519c
     344:	e8 4f 33 00 00       	call   3698 <printf>
      exit();
     349:	e8 21 32 00 00       	call   356f <exit>
     34e:	66 90                	xchg   %ax,%ax
  sleep(1);
     350:	83 ec 0c             	sub    $0xc,%esp
     353:	6a 01                	push   $0x1
     355:	e8 a5 32 00 00       	call   35ff <sleep>
  if(unlink("oidir") != 0){
     35a:	c7 04 24 1b 3a 00 00 	movl   $0x3a1b,(%esp)
     361:	e8 59 32 00 00       	call   35bf <unlink>
     366:	83 c4 10             	add    $0x10,%esp
     369:	85 c0                	test   %eax,%eax
     36b:	75 52                	jne    3bf <openiputtest+0xd7>
  wait();
     36d:	e8 05 32 00 00       	call   3577 <wait>
  printf(stdout, "openiput test ok\n");
     372:	83 ec 08             	sub    $0x8,%esp
     375:	68 44 3a 00 00       	push   $0x3a44
     37a:	ff 35 9c 51 00 00    	push   0x519c
     380:	e8 13 33 00 00       	call   3698 <printf>
}
     385:	83 c4 10             	add    $0x10,%esp
     388:	c9                   	leave  
     389:	c3                   	ret    
     38a:	66 90                	xchg   %ax,%ax
    exit();
     38c:	e8 de 31 00 00       	call   356f <exit>
    printf(stdout, "fork failed\n");
     391:	52                   	push   %edx
     392:	52                   	push   %edx
     393:	68 bd 48 00 00       	push   $0x48bd
     398:	ff 35 9c 51 00 00    	push   0x519c
     39e:	e8 f5 32 00 00       	call   3698 <printf>
    exit();
     3a3:	e8 c7 31 00 00       	call   356f <exit>
    printf(stdout, "mkdir oidir failed\n");
     3a8:	51                   	push   %ecx
     3a9:	51                   	push   %ecx
     3aa:	68 21 3a 00 00       	push   $0x3a21
     3af:	ff 35 9c 51 00 00    	push   0x519c
     3b5:	e8 de 32 00 00       	call   3698 <printf>
    exit();
     3ba:	e8 b0 31 00 00       	call   356f <exit>
    printf(stdout, "unlink failed\n");
     3bf:	50                   	push   %eax
     3c0:	50                   	push   %eax
     3c1:	68 35 3a 00 00       	push   $0x3a35
     3c6:	ff 35 9c 51 00 00    	push   0x519c
     3cc:	e8 c7 32 00 00       	call   3698 <printf>
    exit();
     3d1:	e8 99 31 00 00       	call   356f <exit>
     3d6:	66 90                	xchg   %ax,%ax

000003d8 <opentest>:
{
     3d8:	55                   	push   %ebp
     3d9:	89 e5                	mov    %esp,%ebp
     3db:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
     3de:	68 56 3a 00 00       	push   $0x3a56
     3e3:	ff 35 9c 51 00 00    	push   0x519c
     3e9:	e8 aa 32 00 00       	call   3698 <printf>
  fd = open("echo", 0);
     3ee:	58                   	pop    %eax
     3ef:	5a                   	pop    %edx
     3f0:	6a 00                	push   $0x0
     3f2:	68 61 3a 00 00       	push   $0x3a61
     3f7:	e8 b3 31 00 00       	call   35af <open>
  if(fd < 0){
     3fc:	83 c4 10             	add    $0x10,%esp
     3ff:	85 c0                	test   %eax,%eax
     401:	78 36                	js     439 <opentest+0x61>
  close(fd);
     403:	83 ec 0c             	sub    $0xc,%esp
     406:	50                   	push   %eax
     407:	e8 8b 31 00 00       	call   3597 <close>
  fd = open("doesnotexist", 0);
     40c:	5a                   	pop    %edx
     40d:	59                   	pop    %ecx
     40e:	6a 00                	push   $0x0
     410:	68 79 3a 00 00       	push   $0x3a79
     415:	e8 95 31 00 00       	call   35af <open>
  if(fd >= 0){
     41a:	83 c4 10             	add    $0x10,%esp
     41d:	85 c0                	test   %eax,%eax
     41f:	79 2f                	jns    450 <opentest+0x78>
  printf(stdout, "open test ok\n");
     421:	83 ec 08             	sub    $0x8,%esp
     424:	68 a4 3a 00 00       	push   $0x3aa4
     429:	ff 35 9c 51 00 00    	push   0x519c
     42f:	e8 64 32 00 00       	call   3698 <printf>
}
     434:	83 c4 10             	add    $0x10,%esp
     437:	c9                   	leave  
     438:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     439:	50                   	push   %eax
     43a:	50                   	push   %eax
     43b:	68 66 3a 00 00       	push   $0x3a66
     440:	ff 35 9c 51 00 00    	push   0x519c
     446:	e8 4d 32 00 00       	call   3698 <printf>
    exit();
     44b:	e8 1f 31 00 00       	call   356f <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     450:	50                   	push   %eax
     451:	50                   	push   %eax
     452:	68 86 3a 00 00       	push   $0x3a86
     457:	ff 35 9c 51 00 00    	push   0x519c
     45d:	e8 36 32 00 00       	call   3698 <printf>
    exit();
     462:	e8 08 31 00 00       	call   356f <exit>
     467:	90                   	nop

00000468 <writetest>:
{
     468:	55                   	push   %ebp
     469:	89 e5                	mov    %esp,%ebp
     46b:	56                   	push   %esi
     46c:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     46d:	83 ec 08             	sub    $0x8,%esp
     470:	68 b2 3a 00 00       	push   $0x3ab2
     475:	ff 35 9c 51 00 00    	push   0x519c
     47b:	e8 18 32 00 00       	call   3698 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     480:	5a                   	pop    %edx
     481:	59                   	pop    %ecx
     482:	68 02 02 00 00       	push   $0x202
     487:	68 c3 3a 00 00       	push   $0x3ac3
     48c:	e8 1e 31 00 00       	call   35af <open>
  if(fd >= 0){
     491:	83 c4 10             	add    $0x10,%esp
     494:	85 c0                	test   %eax,%eax
     496:	0f 88 7e 01 00 00    	js     61a <writetest+0x1b2>
     49c:	89 c6                	mov    %eax,%esi
    printf(stdout, "creat small succeeded; ok\n");
     49e:	83 ec 08             	sub    $0x8,%esp
     4a1:	68 c9 3a 00 00       	push   $0x3ac9
     4a6:	ff 35 9c 51 00 00    	push   0x519c
     4ac:	e8 e7 31 00 00       	call   3698 <printf>
     4b1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
     4b4:	31 db                	xor    %ebx,%ebx
     4b6:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4b8:	50                   	push   %eax
     4b9:	6a 0a                	push   $0xa
     4bb:	68 00 3b 00 00       	push   $0x3b00
     4c0:	56                   	push   %esi
     4c1:	e8 c9 30 00 00       	call   358f <write>
     4c6:	83 c4 10             	add    $0x10,%esp
     4c9:	83 f8 0a             	cmp    $0xa,%eax
     4cc:	0f 85 d5 00 00 00    	jne    5a7 <writetest+0x13f>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4d2:	50                   	push   %eax
     4d3:	6a 0a                	push   $0xa
     4d5:	68 0b 3b 00 00       	push   $0x3b0b
     4da:	56                   	push   %esi
     4db:	e8 af 30 00 00       	call   358f <write>
     4e0:	83 c4 10             	add    $0x10,%esp
     4e3:	83 f8 0a             	cmp    $0xa,%eax
     4e6:	0f 85 d2 00 00 00    	jne    5be <writetest+0x156>
  for(i = 0; i < 100; i++){
     4ec:	43                   	inc    %ebx
     4ed:	83 fb 64             	cmp    $0x64,%ebx
     4f0:	75 c6                	jne    4b8 <writetest+0x50>
  printf(stdout, "writes ok\n");
     4f2:	83 ec 08             	sub    $0x8,%esp
     4f5:	68 16 3b 00 00       	push   $0x3b16
     4fa:	ff 35 9c 51 00 00    	push   0x519c
     500:	e8 93 31 00 00       	call   3698 <printf>
  close(fd);
     505:	89 34 24             	mov    %esi,(%esp)
     508:	e8 8a 30 00 00       	call   3597 <close>
  fd = open("small", O_RDONLY);
     50d:	5b                   	pop    %ebx
     50e:	5e                   	pop    %esi
     50f:	6a 00                	push   $0x0
     511:	68 c3 3a 00 00       	push   $0x3ac3
     516:	e8 94 30 00 00       	call   35af <open>
     51b:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     51d:	83 c4 10             	add    $0x10,%esp
     520:	85 c0                	test   %eax,%eax
     522:	0f 88 ad 00 00 00    	js     5d5 <writetest+0x16d>
    printf(stdout, "open small succeeded ok\n");
     528:	83 ec 08             	sub    $0x8,%esp
     52b:	68 21 3b 00 00       	push   $0x3b21
     530:	ff 35 9c 51 00 00    	push   0x519c
     536:	e8 5d 31 00 00       	call   3698 <printf>
  i = read(fd, buf, 2000);
     53b:	83 c4 0c             	add    $0xc,%esp
     53e:	68 d0 07 00 00       	push   $0x7d0
     543:	68 e0 78 00 00       	push   $0x78e0
     548:	53                   	push   %ebx
     549:	e8 39 30 00 00       	call   3587 <read>
  if(i == 2000){
     54e:	83 c4 10             	add    $0x10,%esp
     551:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     556:	0f 85 90 00 00 00    	jne    5ec <writetest+0x184>
    printf(stdout, "read succeeded ok\n");
     55c:	83 ec 08             	sub    $0x8,%esp
     55f:	68 55 3b 00 00       	push   $0x3b55
     564:	ff 35 9c 51 00 00    	push   0x519c
     56a:	e8 29 31 00 00       	call   3698 <printf>
  close(fd);
     56f:	89 1c 24             	mov    %ebx,(%esp)
     572:	e8 20 30 00 00       	call   3597 <close>
  if(unlink("small") < 0){
     577:	c7 04 24 c3 3a 00 00 	movl   $0x3ac3,(%esp)
     57e:	e8 3c 30 00 00       	call   35bf <unlink>
     583:	83 c4 10             	add    $0x10,%esp
     586:	85 c0                	test   %eax,%eax
     588:	78 79                	js     603 <writetest+0x19b>
  printf(stdout, "small file test ok\n");
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 7d 3b 00 00       	push   $0x3b7d
     592:	ff 35 9c 51 00 00    	push   0x519c
     598:	e8 fb 30 00 00       	call   3698 <printf>
}
     59d:	83 c4 10             	add    $0x10,%esp
     5a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5a3:	5b                   	pop    %ebx
     5a4:	5e                   	pop    %esi
     5a5:	5d                   	pop    %ebp
     5a6:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     5a7:	50                   	push   %eax
     5a8:	53                   	push   %ebx
     5a9:	68 c4 49 00 00       	push   $0x49c4
     5ae:	ff 35 9c 51 00 00    	push   0x519c
     5b4:	e8 df 30 00 00       	call   3698 <printf>
      exit();
     5b9:	e8 b1 2f 00 00       	call   356f <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     5be:	50                   	push   %eax
     5bf:	53                   	push   %ebx
     5c0:	68 e8 49 00 00       	push   $0x49e8
     5c5:	ff 35 9c 51 00 00    	push   0x519c
     5cb:	e8 c8 30 00 00       	call   3698 <printf>
      exit();
     5d0:	e8 9a 2f 00 00       	call   356f <exit>
    printf(stdout, "error: open small failed!\n");
     5d5:	51                   	push   %ecx
     5d6:	51                   	push   %ecx
     5d7:	68 3a 3b 00 00       	push   $0x3b3a
     5dc:	ff 35 9c 51 00 00    	push   0x519c
     5e2:	e8 b1 30 00 00       	call   3698 <printf>
    exit();
     5e7:	e8 83 2f 00 00       	call   356f <exit>
    printf(stdout, "read failed\n");
     5ec:	52                   	push   %edx
     5ed:	52                   	push   %edx
     5ee:	68 81 3e 00 00       	push   $0x3e81
     5f3:	ff 35 9c 51 00 00    	push   0x519c
     5f9:	e8 9a 30 00 00       	call   3698 <printf>
    exit();
     5fe:	e8 6c 2f 00 00       	call   356f <exit>
    printf(stdout, "unlink small failed\n");
     603:	50                   	push   %eax
     604:	50                   	push   %eax
     605:	68 68 3b 00 00       	push   $0x3b68
     60a:	ff 35 9c 51 00 00    	push   0x519c
     610:	e8 83 30 00 00       	call   3698 <printf>
    exit();
     615:	e8 55 2f 00 00       	call   356f <exit>
    printf(stdout, "error: creat small failed!\n");
     61a:	50                   	push   %eax
     61b:	50                   	push   %eax
     61c:	68 e4 3a 00 00       	push   $0x3ae4
     621:	ff 35 9c 51 00 00    	push   0x519c
     627:	e8 6c 30 00 00       	call   3698 <printf>
    exit();
     62c:	e8 3e 2f 00 00       	call   356f <exit>
     631:	8d 76 00             	lea    0x0(%esi),%esi

00000634 <writetest1>:
{
     634:	55                   	push   %ebp
     635:	89 e5                	mov    %esp,%ebp
     637:	56                   	push   %esi
     638:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     639:	83 ec 08             	sub    $0x8,%esp
     63c:	68 91 3b 00 00       	push   $0x3b91
     641:	ff 35 9c 51 00 00    	push   0x519c
     647:	e8 4c 30 00 00       	call   3698 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     64c:	58                   	pop    %eax
     64d:	5a                   	pop    %edx
     64e:	68 02 02 00 00       	push   $0x202
     653:	68 0b 3c 00 00       	push   $0x3c0b
     658:	e8 52 2f 00 00       	call   35af <open>
  if(fd < 0){
     65d:	83 c4 10             	add    $0x10,%esp
     660:	85 c0                	test   %eax,%eax
     662:	0f 88 49 01 00 00    	js     7b1 <writetest1+0x17d>
     668:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     66a:	31 db                	xor    %ebx,%ebx
    ((int*)buf)[0] = i;
     66c:	89 1d e0 78 00 00    	mov    %ebx,0x78e0
    if(write(fd, buf, 512) != 512){
     672:	50                   	push   %eax
     673:	68 00 02 00 00       	push   $0x200
     678:	68 e0 78 00 00       	push   $0x78e0
     67d:	56                   	push   %esi
     67e:	e8 0c 2f 00 00       	call   358f <write>
     683:	83 c4 10             	add    $0x10,%esp
     686:	3d 00 02 00 00       	cmp    $0x200,%eax
     68b:	0f 85 a9 00 00 00    	jne    73a <writetest1+0x106>
  for(i = 0; i < MAXFILE; i++){
     691:	43                   	inc    %ebx
     692:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     698:	75 d2                	jne    66c <writetest1+0x38>
  close(fd);
     69a:	83 ec 0c             	sub    $0xc,%esp
     69d:	56                   	push   %esi
     69e:	e8 f4 2e 00 00       	call   3597 <close>
  fd = open("big", O_RDONLY);
     6a3:	58                   	pop    %eax
     6a4:	5a                   	pop    %edx
     6a5:	6a 00                	push   $0x0
     6a7:	68 0b 3c 00 00       	push   $0x3c0b
     6ac:	e8 fe 2e 00 00       	call   35af <open>
     6b1:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6b3:	83 c4 10             	add    $0x10,%esp
     6b6:	85 c0                	test   %eax,%eax
     6b8:	0f 88 dc 00 00 00    	js     79a <writetest1+0x166>
  n = 0;
     6be:	31 db                	xor    %ebx,%ebx
     6c0:	eb 17                	jmp    6d9 <writetest1+0xa5>
     6c2:	66 90                	xchg   %ax,%ax
    } else if(i != 512){
     6c4:	3d 00 02 00 00       	cmp    $0x200,%eax
     6c9:	0f 85 99 00 00 00    	jne    768 <writetest1+0x134>
    if(((int*)buf)[0] != n){
     6cf:	a1 e0 78 00 00       	mov    0x78e0,%eax
     6d4:	39 d8                	cmp    %ebx,%eax
     6d6:	75 79                	jne    751 <writetest1+0x11d>
    n++;
     6d8:	43                   	inc    %ebx
    i = read(fd, buf, 512);
     6d9:	50                   	push   %eax
     6da:	68 00 02 00 00       	push   $0x200
     6df:	68 e0 78 00 00       	push   $0x78e0
     6e4:	56                   	push   %esi
     6e5:	e8 9d 2e 00 00       	call   3587 <read>
    if(i == 0){
     6ea:	83 c4 10             	add    $0x10,%esp
     6ed:	85 c0                	test   %eax,%eax
     6ef:	75 d3                	jne    6c4 <writetest1+0x90>
      if(n == MAXFILE - 1){
     6f1:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     6f7:	0f 84 82 00 00 00    	je     77f <writetest1+0x14b>
  close(fd);
     6fd:	83 ec 0c             	sub    $0xc,%esp
     700:	56                   	push   %esi
     701:	e8 91 2e 00 00       	call   3597 <close>
  if(unlink("big") < 0){
     706:	c7 04 24 0b 3c 00 00 	movl   $0x3c0b,(%esp)
     70d:	e8 ad 2e 00 00       	call   35bf <unlink>
     712:	83 c4 10             	add    $0x10,%esp
     715:	85 c0                	test   %eax,%eax
     717:	0f 88 ab 00 00 00    	js     7c8 <writetest1+0x194>
  printf(stdout, "big files ok\n");
     71d:	83 ec 08             	sub    $0x8,%esp
     720:	68 32 3c 00 00       	push   $0x3c32
     725:	ff 35 9c 51 00 00    	push   0x519c
     72b:	e8 68 2f 00 00       	call   3698 <printf>
}
     730:	83 c4 10             	add    $0x10,%esp
     733:	8d 65 f8             	lea    -0x8(%ebp),%esp
     736:	5b                   	pop    %ebx
     737:	5e                   	pop    %esi
     738:	5d                   	pop    %ebp
     739:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     73a:	51                   	push   %ecx
     73b:	53                   	push   %ebx
     73c:	68 bb 3b 00 00       	push   $0x3bbb
     741:	ff 35 9c 51 00 00    	push   0x519c
     747:	e8 4c 2f 00 00       	call   3698 <printf>
      exit();
     74c:	e8 1e 2e 00 00       	call   356f <exit>
      printf(stdout, "read content of block %d is %d\n",
     751:	50                   	push   %eax
     752:	53                   	push   %ebx
     753:	68 0c 4a 00 00       	push   $0x4a0c
     758:	ff 35 9c 51 00 00    	push   0x519c
     75e:	e8 35 2f 00 00       	call   3698 <printf>
      exit();
     763:	e8 07 2e 00 00       	call   356f <exit>
      printf(stdout, "read failed %d\n", i);
     768:	52                   	push   %edx
     769:	50                   	push   %eax
     76a:	68 0f 3c 00 00       	push   $0x3c0f
     76f:	ff 35 9c 51 00 00    	push   0x519c
     775:	e8 1e 2f 00 00       	call   3698 <printf>
      exit();
     77a:	e8 f0 2d 00 00       	call   356f <exit>
        printf(stdout, "read only %d blocks from big", n);
     77f:	51                   	push   %ecx
     780:	68 8b 00 00 00       	push   $0x8b
     785:	68 f2 3b 00 00       	push   $0x3bf2
     78a:	ff 35 9c 51 00 00    	push   0x519c
     790:	e8 03 2f 00 00       	call   3698 <printf>
        exit();
     795:	e8 d5 2d 00 00       	call   356f <exit>
    printf(stdout, "error: open big failed!\n");
     79a:	50                   	push   %eax
     79b:	50                   	push   %eax
     79c:	68 d9 3b 00 00       	push   $0x3bd9
     7a1:	ff 35 9c 51 00 00    	push   0x519c
     7a7:	e8 ec 2e 00 00       	call   3698 <printf>
    exit();
     7ac:	e8 be 2d 00 00       	call   356f <exit>
    printf(stdout, "error: creat big failed!\n");
     7b1:	50                   	push   %eax
     7b2:	50                   	push   %eax
     7b3:	68 a1 3b 00 00       	push   $0x3ba1
     7b8:	ff 35 9c 51 00 00    	push   0x519c
     7be:	e8 d5 2e 00 00       	call   3698 <printf>
    exit();
     7c3:	e8 a7 2d 00 00       	call   356f <exit>
    printf(stdout, "unlink big failed\n");
     7c8:	50                   	push   %eax
     7c9:	50                   	push   %eax
     7ca:	68 1f 3c 00 00       	push   $0x3c1f
     7cf:	ff 35 9c 51 00 00    	push   0x519c
     7d5:	e8 be 2e 00 00       	call   3698 <printf>
    exit();
     7da:	e8 90 2d 00 00       	call   356f <exit>
     7df:	90                   	nop

000007e0 <createtest>:
{
     7e0:	55                   	push   %ebp
     7e1:	89 e5                	mov    %esp,%ebp
     7e3:	53                   	push   %ebx
     7e4:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     7e7:	68 2c 4a 00 00       	push   $0x4a2c
     7ec:	ff 35 9c 51 00 00    	push   0x519c
     7f2:	e8 a1 2e 00 00       	call   3698 <printf>
  name[0] = 'a';
     7f7:	c6 05 d0 78 00 00 61 	movb   $0x61,0x78d0
  name[2] = '\0';
     7fe:	c6 05 d2 78 00 00 00 	movb   $0x0,0x78d2
     805:	83 c4 10             	add    $0x10,%esp
     808:	b3 30                	mov    $0x30,%bl
     80a:	66 90                	xchg   %ax,%ax
    name[1] = '0' + i;
     80c:	88 1d d1 78 00 00    	mov    %bl,0x78d1
    fd = open(name, O_CREATE|O_RDWR);
     812:	83 ec 08             	sub    $0x8,%esp
     815:	68 02 02 00 00       	push   $0x202
     81a:	68 d0 78 00 00       	push   $0x78d0
     81f:	e8 8b 2d 00 00       	call   35af <open>
    close(fd);
     824:	89 04 24             	mov    %eax,(%esp)
     827:	e8 6b 2d 00 00       	call   3597 <close>
  for(i = 0; i < 52; i++){
     82c:	43                   	inc    %ebx
     82d:	83 c4 10             	add    $0x10,%esp
     830:	80 fb 64             	cmp    $0x64,%bl
     833:	75 d7                	jne    80c <createtest+0x2c>
  name[0] = 'a';
     835:	c6 05 d0 78 00 00 61 	movb   $0x61,0x78d0
  name[2] = '\0';
     83c:	c6 05 d2 78 00 00 00 	movb   $0x0,0x78d2
     843:	b3 30                	mov    $0x30,%bl
     845:	8d 76 00             	lea    0x0(%esi),%esi
    name[1] = '0' + i;
     848:	88 1d d1 78 00 00    	mov    %bl,0x78d1
    unlink(name);
     84e:	83 ec 0c             	sub    $0xc,%esp
     851:	68 d0 78 00 00       	push   $0x78d0
     856:	e8 64 2d 00 00       	call   35bf <unlink>
  for(i = 0; i < 52; i++){
     85b:	43                   	inc    %ebx
     85c:	83 c4 10             	add    $0x10,%esp
     85f:	80 fb 64             	cmp    $0x64,%bl
     862:	75 e4                	jne    848 <createtest+0x68>
  printf(stdout, "many creates, followed by unlink; ok\n");
     864:	83 ec 08             	sub    $0x8,%esp
     867:	68 54 4a 00 00       	push   $0x4a54
     86c:	ff 35 9c 51 00 00    	push   0x519c
     872:	e8 21 2e 00 00       	call   3698 <printf>
}
     877:	83 c4 10             	add    $0x10,%esp
     87a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     87d:	c9                   	leave  
     87e:	c3                   	ret    
     87f:	90                   	nop

00000880 <dirtest>:
{
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     886:	68 40 3c 00 00       	push   $0x3c40
     88b:	ff 35 9c 51 00 00    	push   0x519c
     891:	e8 02 2e 00 00       	call   3698 <printf>
  if(mkdir("dir0") < 0){
     896:	c7 04 24 4c 3c 00 00 	movl   $0x3c4c,(%esp)
     89d:	e8 35 2d 00 00       	call   35d7 <mkdir>
     8a2:	83 c4 10             	add    $0x10,%esp
     8a5:	85 c0                	test   %eax,%eax
     8a7:	78 58                	js     901 <dirtest+0x81>
  if(chdir("dir0") < 0){
     8a9:	83 ec 0c             	sub    $0xc,%esp
     8ac:	68 4c 3c 00 00       	push   $0x3c4c
     8b1:	e8 29 2d 00 00       	call   35df <chdir>
     8b6:	83 c4 10             	add    $0x10,%esp
     8b9:	85 c0                	test   %eax,%eax
     8bb:	0f 88 85 00 00 00    	js     946 <dirtest+0xc6>
  if(chdir("..") < 0){
     8c1:	83 ec 0c             	sub    $0xc,%esp
     8c4:	68 f1 41 00 00       	push   $0x41f1
     8c9:	e8 11 2d 00 00       	call   35df <chdir>
     8ce:	83 c4 10             	add    $0x10,%esp
     8d1:	85 c0                	test   %eax,%eax
     8d3:	78 5a                	js     92f <dirtest+0xaf>
  if(unlink("dir0") < 0){
     8d5:	83 ec 0c             	sub    $0xc,%esp
     8d8:	68 4c 3c 00 00       	push   $0x3c4c
     8dd:	e8 dd 2c 00 00       	call   35bf <unlink>
     8e2:	83 c4 10             	add    $0x10,%esp
     8e5:	85 c0                	test   %eax,%eax
     8e7:	78 2f                	js     918 <dirtest+0x98>
  printf(stdout, "mkdir test ok\n");
     8e9:	83 ec 08             	sub    $0x8,%esp
     8ec:	68 89 3c 00 00       	push   $0x3c89
     8f1:	ff 35 9c 51 00 00    	push   0x519c
     8f7:	e8 9c 2d 00 00       	call   3698 <printf>
}
     8fc:	83 c4 10             	add    $0x10,%esp
     8ff:	c9                   	leave  
     900:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     901:	50                   	push   %eax
     902:	50                   	push   %eax
     903:	68 7c 39 00 00       	push   $0x397c
     908:	ff 35 9c 51 00 00    	push   0x519c
     90e:	e8 85 2d 00 00       	call   3698 <printf>
    exit();
     913:	e8 57 2c 00 00       	call   356f <exit>
    printf(stdout, "unlink dir0 failed\n");
     918:	50                   	push   %eax
     919:	50                   	push   %eax
     91a:	68 75 3c 00 00       	push   $0x3c75
     91f:	ff 35 9c 51 00 00    	push   0x519c
     925:	e8 6e 2d 00 00       	call   3698 <printf>
    exit();
     92a:	e8 40 2c 00 00       	call   356f <exit>
    printf(stdout, "chdir .. failed\n");
     92f:	52                   	push   %edx
     930:	52                   	push   %edx
     931:	68 64 3c 00 00       	push   $0x3c64
     936:	ff 35 9c 51 00 00    	push   0x519c
     93c:	e8 57 2d 00 00       	call   3698 <printf>
    exit();
     941:	e8 29 2c 00 00       	call   356f <exit>
    printf(stdout, "chdir dir0 failed\n");
     946:	51                   	push   %ecx
     947:	51                   	push   %ecx
     948:	68 51 3c 00 00       	push   $0x3c51
     94d:	ff 35 9c 51 00 00    	push   0x519c
     953:	e8 40 2d 00 00       	call   3698 <printf>
    exit();
     958:	e8 12 2c 00 00       	call   356f <exit>
     95d:	8d 76 00             	lea    0x0(%esi),%esi

00000960 <exectest>:
{
     960:	55                   	push   %ebp
     961:	89 e5                	mov    %esp,%ebp
     963:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     966:	68 98 3c 00 00       	push   $0x3c98
     96b:	ff 35 9c 51 00 00    	push   0x519c
     971:	e8 22 2d 00 00       	call   3698 <printf>
  if(exec("echo", echoargv) < 0){
     976:	5a                   	pop    %edx
     977:	59                   	pop    %ecx
     978:	68 a0 51 00 00       	push   $0x51a0
     97d:	68 61 3a 00 00       	push   $0x3a61
     982:	e8 20 2c 00 00       	call   35a7 <exec>
     987:	83 c4 10             	add    $0x10,%esp
     98a:	85 c0                	test   %eax,%eax
     98c:	78 02                	js     990 <exectest+0x30>
}
     98e:	c9                   	leave  
     98f:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     990:	50                   	push   %eax
     991:	50                   	push   %eax
     992:	68 a3 3c 00 00       	push   $0x3ca3
     997:	ff 35 9c 51 00 00    	push   0x519c
     99d:	e8 f6 2c 00 00       	call   3698 <printf>
    exit();
     9a2:	e8 c8 2b 00 00       	call   356f <exit>
     9a7:	90                   	nop

000009a8 <pipe1>:
{
     9a8:	55                   	push   %ebp
     9a9:	89 e5                	mov    %esp,%ebp
     9ab:	57                   	push   %edi
     9ac:	56                   	push   %esi
     9ad:	53                   	push   %ebx
     9ae:	83 ec 38             	sub    $0x38,%esp
  if(pipe(fds) != 0){
     9b1:	8d 45 e0             	lea    -0x20(%ebp),%eax
     9b4:	50                   	push   %eax
     9b5:	e8 c5 2b 00 00       	call   357f <pipe>
     9ba:	83 c4 10             	add    $0x10,%esp
     9bd:	85 c0                	test   %eax,%eax
     9bf:	0f 85 24 01 00 00    	jne    ae9 <pipe1+0x141>
  pid = fork();
     9c5:	e8 9d 2b 00 00       	call   3567 <fork>
  if(pid == 0){
     9ca:	85 c0                	test   %eax,%eax
     9cc:	0f 84 80 00 00 00    	je     a52 <pipe1+0xaa>
  } else if(pid > 0){
     9d2:	0f 8e 24 01 00 00    	jle    afc <pipe1+0x154>
    close(fds[1]);
     9d8:	83 ec 0c             	sub    $0xc,%esp
     9db:	ff 75 e4             	push   -0x1c(%ebp)
     9de:	e8 b4 2b 00 00       	call   3597 <close>
    while((n = read(fds[0], buf, cc)) > 0){
     9e3:	83 c4 10             	add    $0x10,%esp
    total = 0;
     9e6:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  seq = 0;
     9ed:	31 db                	xor    %ebx,%ebx
    cc = 1;
     9ef:	be 01 00 00 00       	mov    $0x1,%esi
    while((n = read(fds[0], buf, cc)) > 0){
     9f4:	57                   	push   %edi
     9f5:	56                   	push   %esi
     9f6:	68 e0 78 00 00       	push   $0x78e0
     9fb:	ff 75 e0             	push   -0x20(%ebp)
     9fe:	e8 84 2b 00 00       	call   3587 <read>
     a03:	83 c4 10             	add    $0x10,%esp
     a06:	85 c0                	test   %eax,%eax
     a08:	0f 8e 97 00 00 00    	jle    aa5 <pipe1+0xfd>
     a0e:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
      for(i = 0; i < n; i++){
     a11:	31 d2                	xor    %edx,%edx
     a13:	90                   	nop
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a14:	89 d9                	mov    %ebx,%ecx
     a16:	43                   	inc    %ebx
     a17:	38 8a e0 78 00 00    	cmp    %cl,0x78e0(%edx)
     a1d:	75 19                	jne    a38 <pipe1+0x90>
      for(i = 0; i < n; i++){
     a1f:	42                   	inc    %edx
     a20:	39 df                	cmp    %ebx,%edi
     a22:	75 f0                	jne    a14 <pipe1+0x6c>
      total += n;
     a24:	01 45 d4             	add    %eax,-0x2c(%ebp)
      if(cc > sizeof(buf))
     a27:	01 f6                	add    %esi,%esi
     a29:	81 fe 00 20 00 00    	cmp    $0x2000,%esi
     a2f:	7e c3                	jle    9f4 <pipe1+0x4c>
     a31:	be 00 20 00 00       	mov    $0x2000,%esi
     a36:	eb bc                	jmp    9f4 <pipe1+0x4c>
          printf(1, "pipe1 oops 2\n");
     a38:	83 ec 08             	sub    $0x8,%esp
     a3b:	68 d2 3c 00 00       	push   $0x3cd2
     a40:	6a 01                	push   $0x1
     a42:	e8 51 2c 00 00       	call   3698 <printf>
     a47:	83 c4 10             	add    $0x10,%esp
}
     a4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a4d:	5b                   	pop    %ebx
     a4e:	5e                   	pop    %esi
     a4f:	5f                   	pop    %edi
     a50:	5d                   	pop    %ebp
     a51:	c3                   	ret    
    close(fds[0]);
     a52:	83 ec 0c             	sub    $0xc,%esp
     a55:	ff 75 e0             	push   -0x20(%ebp)
     a58:	e8 3a 2b 00 00       	call   3597 <close>
     a5d:	83 c4 10             	add    $0x10,%esp
  seq = 0;
     a60:	31 db                	xor    %ebx,%ebx
      for(i = 0; i < 1033; i++)
     a62:	31 c0                	xor    %eax,%eax
        buf[i] = seq++;
     a64:	8d 14 18             	lea    (%eax,%ebx,1),%edx
     a67:	88 90 e0 78 00 00    	mov    %dl,0x78e0(%eax)
      for(i = 0; i < 1033; i++)
     a6d:	40                   	inc    %eax
     a6e:	3d 09 04 00 00       	cmp    $0x409,%eax
     a73:	75 ef                	jne    a64 <pipe1+0xbc>
        buf[i] = seq++;
     a75:	81 c3 09 04 00 00    	add    $0x409,%ebx
      if(write(fds[1], buf, 1033) != 1033){
     a7b:	50                   	push   %eax
     a7c:	68 09 04 00 00       	push   $0x409
     a81:	68 e0 78 00 00       	push   $0x78e0
     a86:	ff 75 e4             	push   -0x1c(%ebp)
     a89:	e8 01 2b 00 00       	call   358f <write>
     a8e:	83 c4 10             	add    $0x10,%esp
     a91:	3d 09 04 00 00       	cmp    $0x409,%eax
     a96:	75 77                	jne    b0f <pipe1+0x167>
    for(n = 0; n < 5; n++){
     a98:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     a9e:	75 c2                	jne    a62 <pipe1+0xba>
    exit();
     aa0:	e8 ca 2a 00 00       	call   356f <exit>
    if(total != 5 * 1033){
     aa5:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     aac:	75 26                	jne    ad4 <pipe1+0x12c>
    close(fds[0]);
     aae:	83 ec 0c             	sub    $0xc,%esp
     ab1:	ff 75 e0             	push   -0x20(%ebp)
     ab4:	e8 de 2a 00 00       	call   3597 <close>
    wait();
     ab9:	e8 b9 2a 00 00       	call   3577 <wait>
  printf(1, "pipe1 ok\n");
     abe:	5a                   	pop    %edx
     abf:	59                   	pop    %ecx
     ac0:	68 f7 3c 00 00       	push   $0x3cf7
     ac5:	6a 01                	push   $0x1
     ac7:	e8 cc 2b 00 00       	call   3698 <printf>
     acc:	83 c4 10             	add    $0x10,%esp
     acf:	e9 76 ff ff ff       	jmp    a4a <pipe1+0xa2>
      printf(1, "pipe1 oops 3 total %d\n", total);
     ad4:	53                   	push   %ebx
     ad5:	ff 75 d4             	push   -0x2c(%ebp)
     ad8:	68 e0 3c 00 00       	push   $0x3ce0
     add:	6a 01                	push   $0x1
     adf:	e8 b4 2b 00 00       	call   3698 <printf>
      exit();
     ae4:	e8 86 2a 00 00       	call   356f <exit>
    printf(1, "pipe() failed\n");
     ae9:	50                   	push   %eax
     aea:	50                   	push   %eax
     aeb:	68 b5 3c 00 00       	push   $0x3cb5
     af0:	6a 01                	push   $0x1
     af2:	e8 a1 2b 00 00       	call   3698 <printf>
    exit();
     af7:	e8 73 2a 00 00       	call   356f <exit>
    printf(1, "fork() failed\n");
     afc:	50                   	push   %eax
     afd:	50                   	push   %eax
     afe:	68 01 3d 00 00       	push   $0x3d01
     b03:	6a 01                	push   $0x1
     b05:	e8 8e 2b 00 00       	call   3698 <printf>
    exit();
     b0a:	e8 60 2a 00 00       	call   356f <exit>
        printf(1, "pipe1 oops 1\n");
     b0f:	50                   	push   %eax
     b10:	50                   	push   %eax
     b11:	68 c4 3c 00 00       	push   $0x3cc4
     b16:	6a 01                	push   $0x1
     b18:	e8 7b 2b 00 00       	call   3698 <printf>
        exit();
     b1d:	e8 4d 2a 00 00       	call   356f <exit>
     b22:	66 90                	xchg   %ax,%ax

00000b24 <preempt>:
{
     b24:	55                   	push   %ebp
     b25:	89 e5                	mov    %esp,%ebp
     b27:	57                   	push   %edi
     b28:	56                   	push   %esi
     b29:	53                   	push   %ebx
     b2a:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
     b2d:	68 10 3d 00 00       	push   $0x3d10
     b32:	6a 01                	push   $0x1
     b34:	e8 5f 2b 00 00       	call   3698 <printf>
  pid1 = fork();
     b39:	e8 29 2a 00 00       	call   3567 <fork>
  if(pid1 == 0)
     b3e:	83 c4 10             	add    $0x10,%esp
     b41:	85 c0                	test   %eax,%eax
     b43:	75 03                	jne    b48 <preempt+0x24>
    for(;;)
     b45:	eb fe                	jmp    b45 <preempt+0x21>
     b47:	90                   	nop
     b48:	89 c3                	mov    %eax,%ebx
  pid2 = fork();
     b4a:	e8 18 2a 00 00       	call   3567 <fork>
     b4f:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     b51:	85 c0                	test   %eax,%eax
     b53:	75 03                	jne    b58 <preempt+0x34>
    for(;;)
     b55:	eb fe                	jmp    b55 <preempt+0x31>
     b57:	90                   	nop
  pipe(pfds);
     b58:	83 ec 0c             	sub    $0xc,%esp
     b5b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b5e:	50                   	push   %eax
     b5f:	e8 1b 2a 00 00       	call   357f <pipe>
  pid3 = fork();
     b64:	e8 fe 29 00 00       	call   3567 <fork>
     b69:	89 c7                	mov    %eax,%edi
  if(pid3 == 0){
     b6b:	83 c4 10             	add    $0x10,%esp
     b6e:	85 c0                	test   %eax,%eax
     b70:	75 3a                	jne    bac <preempt+0x88>
    close(pfds[0]);
     b72:	83 ec 0c             	sub    $0xc,%esp
     b75:	ff 75 e0             	push   -0x20(%ebp)
     b78:	e8 1a 2a 00 00       	call   3597 <close>
    if(write(pfds[1], "x", 1) != 1)
     b7d:	83 c4 0c             	add    $0xc,%esp
     b80:	6a 01                	push   $0x1
     b82:	68 d5 42 00 00       	push   $0x42d5
     b87:	ff 75 e4             	push   -0x1c(%ebp)
     b8a:	e8 00 2a 00 00       	call   358f <write>
     b8f:	83 c4 10             	add    $0x10,%esp
     b92:	48                   	dec    %eax
     b93:	0f 85 b4 00 00 00    	jne    c4d <preempt+0x129>
    close(pfds[1]);
     b99:	83 ec 0c             	sub    $0xc,%esp
     b9c:	ff 75 e4             	push   -0x1c(%ebp)
     b9f:	e8 f3 29 00 00       	call   3597 <close>
     ba4:	83 c4 10             	add    $0x10,%esp
    for(;;)
     ba7:	eb fe                	jmp    ba7 <preempt+0x83>
     ba9:	8d 76 00             	lea    0x0(%esi),%esi
  close(pfds[1]);
     bac:	83 ec 0c             	sub    $0xc,%esp
     baf:	ff 75 e4             	push   -0x1c(%ebp)
     bb2:	e8 e0 29 00 00       	call   3597 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     bb7:	83 c4 0c             	add    $0xc,%esp
     bba:	68 00 20 00 00       	push   $0x2000
     bbf:	68 e0 78 00 00       	push   $0x78e0
     bc4:	ff 75 e0             	push   -0x20(%ebp)
     bc7:	e8 bb 29 00 00       	call   3587 <read>
     bcc:	83 c4 10             	add    $0x10,%esp
     bcf:	48                   	dec    %eax
     bd0:	75 67                	jne    c39 <preempt+0x115>
  close(pfds[0]);
     bd2:	83 ec 0c             	sub    $0xc,%esp
     bd5:	ff 75 e0             	push   -0x20(%ebp)
     bd8:	e8 ba 29 00 00       	call   3597 <close>
  printf(1, "kill... ");
     bdd:	58                   	pop    %eax
     bde:	5a                   	pop    %edx
     bdf:	68 41 3d 00 00       	push   $0x3d41
     be4:	6a 01                	push   $0x1
     be6:	e8 ad 2a 00 00       	call   3698 <printf>
  kill(pid1);
     beb:	89 1c 24             	mov    %ebx,(%esp)
     bee:	e8 ac 29 00 00       	call   359f <kill>
  kill(pid2);
     bf3:	89 34 24             	mov    %esi,(%esp)
     bf6:	e8 a4 29 00 00       	call   359f <kill>
  kill(pid3);
     bfb:	89 3c 24             	mov    %edi,(%esp)
     bfe:	e8 9c 29 00 00       	call   359f <kill>
  printf(1, "wait... ");
     c03:	59                   	pop    %ecx
     c04:	5b                   	pop    %ebx
     c05:	68 4a 3d 00 00       	push   $0x3d4a
     c0a:	6a 01                	push   $0x1
     c0c:	e8 87 2a 00 00       	call   3698 <printf>
  wait();
     c11:	e8 61 29 00 00       	call   3577 <wait>
  wait();
     c16:	e8 5c 29 00 00       	call   3577 <wait>
  wait();
     c1b:	e8 57 29 00 00       	call   3577 <wait>
  printf(1, "preempt ok\n");
     c20:	5e                   	pop    %esi
     c21:	5f                   	pop    %edi
     c22:	68 53 3d 00 00       	push   $0x3d53
     c27:	6a 01                	push   $0x1
     c29:	e8 6a 2a 00 00       	call   3698 <printf>
     c2e:	83 c4 10             	add    $0x10,%esp
}
     c31:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c34:	5b                   	pop    %ebx
     c35:	5e                   	pop    %esi
     c36:	5f                   	pop    %edi
     c37:	5d                   	pop    %ebp
     c38:	c3                   	ret    
    printf(1, "preempt read error");
     c39:	83 ec 08             	sub    $0x8,%esp
     c3c:	68 2e 3d 00 00       	push   $0x3d2e
     c41:	6a 01                	push   $0x1
     c43:	e8 50 2a 00 00       	call   3698 <printf>
     c48:	83 c4 10             	add    $0x10,%esp
     c4b:	eb e4                	jmp    c31 <preempt+0x10d>
      printf(1, "preempt write error");
     c4d:	83 ec 08             	sub    $0x8,%esp
     c50:	68 1a 3d 00 00       	push   $0x3d1a
     c55:	6a 01                	push   $0x1
     c57:	e8 3c 2a 00 00       	call   3698 <printf>
     c5c:	83 c4 10             	add    $0x10,%esp
     c5f:	e9 35 ff ff ff       	jmp    b99 <preempt+0x75>

00000c64 <exitwait>:
{
     c64:	55                   	push   %ebp
     c65:	89 e5                	mov    %esp,%ebp
     c67:	56                   	push   %esi
     c68:	53                   	push   %ebx
     c69:	be 64 00 00 00       	mov    $0x64,%esi
     c6e:	eb 0e                	jmp    c7e <exitwait+0x1a>
    if(pid){
     c70:	74 64                	je     cd6 <exitwait+0x72>
      if(wait() != pid){
     c72:	e8 00 29 00 00       	call   3577 <wait>
     c77:	39 d8                	cmp    %ebx,%eax
     c79:	75 29                	jne    ca4 <exitwait+0x40>
  for(i = 0; i < 100; i++){
     c7b:	4e                   	dec    %esi
     c7c:	74 3f                	je     cbd <exitwait+0x59>
    pid = fork();
     c7e:	e8 e4 28 00 00       	call   3567 <fork>
     c83:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     c85:	85 c0                	test   %eax,%eax
     c87:	79 e7                	jns    c70 <exitwait+0xc>
      printf(1, "fork failed\n");
     c89:	83 ec 08             	sub    $0x8,%esp
     c8c:	68 bd 48 00 00       	push   $0x48bd
     c91:	6a 01                	push   $0x1
     c93:	e8 00 2a 00 00       	call   3698 <printf>
      return;
     c98:	83 c4 10             	add    $0x10,%esp
}
     c9b:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c9e:	5b                   	pop    %ebx
     c9f:	5e                   	pop    %esi
     ca0:	5d                   	pop    %ebp
     ca1:	c3                   	ret    
     ca2:	66 90                	xchg   %ax,%ax
        printf(1, "wait wrong pid\n");
     ca4:	83 ec 08             	sub    $0x8,%esp
     ca7:	68 5f 3d 00 00       	push   $0x3d5f
     cac:	6a 01                	push   $0x1
     cae:	e8 e5 29 00 00       	call   3698 <printf>
        return;
     cb3:	83 c4 10             	add    $0x10,%esp
}
     cb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cb9:	5b                   	pop    %ebx
     cba:	5e                   	pop    %esi
     cbb:	5d                   	pop    %ebp
     cbc:	c3                   	ret    
  printf(1, "exitwait ok\n");
     cbd:	83 ec 08             	sub    $0x8,%esp
     cc0:	68 6f 3d 00 00       	push   $0x3d6f
     cc5:	6a 01                	push   $0x1
     cc7:	e8 cc 29 00 00       	call   3698 <printf>
     ccc:	83 c4 10             	add    $0x10,%esp
}
     ccf:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cd2:	5b                   	pop    %ebx
     cd3:	5e                   	pop    %esi
     cd4:	5d                   	pop    %ebp
     cd5:	c3                   	ret    
      exit();
     cd6:	e8 94 28 00 00       	call   356f <exit>
     cdb:	90                   	nop

00000cdc <mem>:
{
     cdc:	55                   	push   %ebp
     cdd:	89 e5                	mov    %esp,%ebp
     cdf:	56                   	push   %esi
     ce0:	53                   	push   %ebx
  printf(1, "mem test\n");
     ce1:	83 ec 08             	sub    $0x8,%esp
     ce4:	68 7c 3d 00 00       	push   $0x3d7c
     ce9:	6a 01                	push   $0x1
     ceb:	e8 a8 29 00 00       	call   3698 <printf>
  ppid = getpid();
     cf0:	e8 fa 28 00 00       	call   35ef <getpid>
     cf5:	89 c3                	mov    %eax,%ebx
  if((pid = fork()) == 0){
     cf7:	e8 6b 28 00 00       	call   3567 <fork>
     cfc:	83 c4 10             	add    $0x10,%esp
     cff:	85 c0                	test   %eax,%eax
     d01:	0f 85 81 00 00 00    	jne    d88 <mem+0xac>
    m1 = 0;
     d07:	31 f6                	xor    %esi,%esi
     d09:	eb 05                	jmp    d10 <mem+0x34>
     d0b:	90                   	nop
      *(char**)m2 = m1;
     d0c:	89 30                	mov    %esi,(%eax)
     d0e:	89 c6                	mov    %eax,%esi
    while((m2 = malloc(10001)) != 0){
     d10:	83 ec 0c             	sub    $0xc,%esp
     d13:	68 11 27 00 00       	push   $0x2711
     d18:	e8 67 2b 00 00       	call   3884 <malloc>
     d1d:	83 c4 10             	add    $0x10,%esp
     d20:	85 c0                	test   %eax,%eax
     d22:	75 e8                	jne    d0c <mem+0x30>
    while(m1){
     d24:	85 f6                	test   %esi,%esi
     d26:	74 14                	je     d3c <mem+0x60>
      m2 = *(char**)m1;
     d28:	89 f0                	mov    %esi,%eax
     d2a:	8b 36                	mov    (%esi),%esi
      free(m1);
     d2c:	83 ec 0c             	sub    $0xc,%esp
     d2f:	50                   	push   %eax
     d30:	e8 c7 2a 00 00       	call   37fc <free>
    while(m1){
     d35:	83 c4 10             	add    $0x10,%esp
     d38:	85 f6                	test   %esi,%esi
     d3a:	75 ec                	jne    d28 <mem+0x4c>
    m1 = malloc(1024*20);
     d3c:	83 ec 0c             	sub    $0xc,%esp
     d3f:	68 00 50 00 00       	push   $0x5000
     d44:	e8 3b 2b 00 00       	call   3884 <malloc>
    if(m1 == 0){
     d49:	83 c4 10             	add    $0x10,%esp
     d4c:	85 c0                	test   %eax,%eax
     d4e:	74 1c                	je     d6c <mem+0x90>
    free(m1);
     d50:	83 ec 0c             	sub    $0xc,%esp
     d53:	50                   	push   %eax
     d54:	e8 a3 2a 00 00       	call   37fc <free>
    printf(1, "mem ok\n");
     d59:	58                   	pop    %eax
     d5a:	5a                   	pop    %edx
     d5b:	68 a0 3d 00 00       	push   $0x3da0
     d60:	6a 01                	push   $0x1
     d62:	e8 31 29 00 00       	call   3698 <printf>
    exit();
     d67:	e8 03 28 00 00       	call   356f <exit>
      printf(1, "couldn't allocate mem?!!\n");
     d6c:	83 ec 08             	sub    $0x8,%esp
     d6f:	68 86 3d 00 00       	push   $0x3d86
     d74:	6a 01                	push   $0x1
     d76:	e8 1d 29 00 00       	call   3698 <printf>
      kill(ppid);
     d7b:	89 1c 24             	mov    %ebx,(%esp)
     d7e:	e8 1c 28 00 00       	call   359f <kill>
      exit();
     d83:	e8 e7 27 00 00       	call   356f <exit>
}
     d88:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d8b:	5b                   	pop    %ebx
     d8c:	5e                   	pop    %esi
     d8d:	5d                   	pop    %ebp
    wait();
     d8e:	e9 e4 27 00 00       	jmp    3577 <wait>
     d93:	90                   	nop

00000d94 <sharedfd>:
{
     d94:	55                   	push   %ebp
     d95:	89 e5                	mov    %esp,%ebp
     d97:	57                   	push   %edi
     d98:	56                   	push   %esi
     d99:	53                   	push   %ebx
     d9a:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
     d9d:	68 a8 3d 00 00       	push   $0x3da8
     da2:	6a 01                	push   $0x1
     da4:	e8 ef 28 00 00       	call   3698 <printf>
  unlink("sharedfd");
     da9:	c7 04 24 b7 3d 00 00 	movl   $0x3db7,(%esp)
     db0:	e8 0a 28 00 00       	call   35bf <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     db5:	59                   	pop    %ecx
     db6:	5b                   	pop    %ebx
     db7:	68 02 02 00 00       	push   $0x202
     dbc:	68 b7 3d 00 00       	push   $0x3db7
     dc1:	e8 e9 27 00 00       	call   35af <open>
  if(fd < 0){
     dc6:	83 c4 10             	add    $0x10,%esp
     dc9:	85 c0                	test   %eax,%eax
     dcb:	0f 88 0e 01 00 00    	js     edf <sharedfd+0x14b>
     dd1:	89 c7                	mov    %eax,%edi
  pid = fork();
     dd3:	e8 8f 27 00 00       	call   3567 <fork>
     dd8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     ddb:	83 f8 01             	cmp    $0x1,%eax
     dde:	19 c0                	sbb    %eax,%eax
     de0:	83 e0 f3             	and    $0xfffffff3,%eax
     de3:	83 c0 70             	add    $0x70,%eax
     de6:	52                   	push   %edx
     de7:	6a 0a                	push   $0xa
     de9:	50                   	push   %eax
     dea:	8d 75 de             	lea    -0x22(%ebp),%esi
     ded:	56                   	push   %esi
     dee:	e8 31 26 00 00       	call   3424 <memset>
     df3:	83 c4 10             	add    $0x10,%esp
     df6:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     dfb:	eb 06                	jmp    e03 <sharedfd+0x6f>
     dfd:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 1000; i++){
     e00:	4b                   	dec    %ebx
     e01:	74 24                	je     e27 <sharedfd+0x93>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     e03:	50                   	push   %eax
     e04:	6a 0a                	push   $0xa
     e06:	56                   	push   %esi
     e07:	57                   	push   %edi
     e08:	e8 82 27 00 00       	call   358f <write>
     e0d:	83 c4 10             	add    $0x10,%esp
     e10:	83 f8 0a             	cmp    $0xa,%eax
     e13:	74 eb                	je     e00 <sharedfd+0x6c>
      printf(1, "fstests: write sharedfd failed\n");
     e15:	83 ec 08             	sub    $0x8,%esp
     e18:	68 a8 4a 00 00       	push   $0x4aa8
     e1d:	6a 01                	push   $0x1
     e1f:	e8 74 28 00 00       	call   3698 <printf>
      break;
     e24:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     e27:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
     e2a:	85 db                	test   %ebx,%ebx
     e2c:	0f 84 e1 00 00 00    	je     f13 <sharedfd+0x17f>
    wait();
     e32:	e8 40 27 00 00       	call   3577 <wait>
  close(fd);
     e37:	83 ec 0c             	sub    $0xc,%esp
     e3a:	57                   	push   %edi
     e3b:	e8 57 27 00 00       	call   3597 <close>
  fd = open("sharedfd", 0);
     e40:	5a                   	pop    %edx
     e41:	59                   	pop    %ecx
     e42:	6a 00                	push   $0x0
     e44:	68 b7 3d 00 00       	push   $0x3db7
     e49:	e8 61 27 00 00       	call   35af <open>
     e4e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     e51:	83 c4 10             	add    $0x10,%esp
     e54:	85 c0                	test   %eax,%eax
     e56:	0f 88 9d 00 00 00    	js     ef9 <sharedfd+0x165>
  nc = np = 0;
     e5c:	31 d2                	xor    %edx,%edx
     e5e:	31 ff                	xor    %edi,%edi
     e60:	8d 5d e8             	lea    -0x18(%ebp),%ebx
     e63:	90                   	nop
     e64:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     e67:	50                   	push   %eax
     e68:	6a 0a                	push   $0xa
     e6a:	56                   	push   %esi
     e6b:	ff 75 d0             	push   -0x30(%ebp)
     e6e:	e8 14 27 00 00       	call   3587 <read>
     e73:	83 c4 10             	add    $0x10,%esp
     e76:	85 c0                	test   %eax,%eax
     e78:	7e 1e                	jle    e98 <sharedfd+0x104>
     e7a:	89 f1                	mov    %esi,%ecx
     e7c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     e7f:	eb 0d                	jmp    e8e <sharedfd+0xfa>
     e81:	8d 76 00             	lea    0x0(%esi),%esi
      if(buf[i] == 'p')
     e84:	3c 70                	cmp    $0x70,%al
     e86:	75 01                	jne    e89 <sharedfd+0xf5>
        np++;
     e88:	42                   	inc    %edx
    for(i = 0; i < sizeof(buf); i++){
     e89:	41                   	inc    %ecx
     e8a:	39 d9                	cmp    %ebx,%ecx
     e8c:	74 d6                	je     e64 <sharedfd+0xd0>
      if(buf[i] == 'c')
     e8e:	8a 01                	mov    (%ecx),%al
     e90:	3c 63                	cmp    $0x63,%al
     e92:	75 f0                	jne    e84 <sharedfd+0xf0>
        nc++;
     e94:	47                   	inc    %edi
      if(buf[i] == 'p')
     e95:	eb f2                	jmp    e89 <sharedfd+0xf5>
     e97:	90                   	nop
  close(fd);
     e98:	83 ec 0c             	sub    $0xc,%esp
     e9b:	ff 75 d0             	push   -0x30(%ebp)
     e9e:	e8 f4 26 00 00       	call   3597 <close>
  unlink("sharedfd");
     ea3:	c7 04 24 b7 3d 00 00 	movl   $0x3db7,(%esp)
     eaa:	e8 10 27 00 00       	call   35bf <unlink>
  if(nc == 10000 && np == 10000){
     eaf:	83 c4 10             	add    $0x10,%esp
     eb2:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     eb8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     ebb:	75 5b                	jne    f18 <sharedfd+0x184>
     ebd:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     ec3:	75 53                	jne    f18 <sharedfd+0x184>
    printf(1, "sharedfd ok\n");
     ec5:	83 ec 08             	sub    $0x8,%esp
     ec8:	68 c0 3d 00 00       	push   $0x3dc0
     ecd:	6a 01                	push   $0x1
     ecf:	e8 c4 27 00 00       	call   3698 <printf>
     ed4:	83 c4 10             	add    $0x10,%esp
}
     ed7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     eda:	5b                   	pop    %ebx
     edb:	5e                   	pop    %esi
     edc:	5f                   	pop    %edi
     edd:	5d                   	pop    %ebp
     ede:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for writing");
     edf:	83 ec 08             	sub    $0x8,%esp
     ee2:	68 7c 4a 00 00       	push   $0x4a7c
     ee7:	6a 01                	push   $0x1
     ee9:	e8 aa 27 00 00       	call   3698 <printf>
    return;
     eee:	83 c4 10             	add    $0x10,%esp
}
     ef1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ef4:	5b                   	pop    %ebx
     ef5:	5e                   	pop    %esi
     ef6:	5f                   	pop    %edi
     ef7:	5d                   	pop    %ebp
     ef8:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
     ef9:	83 ec 08             	sub    $0x8,%esp
     efc:	68 c8 4a 00 00       	push   $0x4ac8
     f01:	6a 01                	push   $0x1
     f03:	e8 90 27 00 00       	call   3698 <printf>
    return;
     f08:	83 c4 10             	add    $0x10,%esp
}
     f0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f0e:	5b                   	pop    %ebx
     f0f:	5e                   	pop    %esi
     f10:	5f                   	pop    %edi
     f11:	5d                   	pop    %ebp
     f12:	c3                   	ret    
    exit();
     f13:	e8 57 26 00 00       	call   356f <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
     f18:	52                   	push   %edx
     f19:	57                   	push   %edi
     f1a:	68 cd 3d 00 00       	push   $0x3dcd
     f1f:	6a 01                	push   $0x1
     f21:	e8 72 27 00 00       	call   3698 <printf>
    exit();
     f26:	e8 44 26 00 00       	call   356f <exit>
     f2b:	90                   	nop

00000f2c <fourfiles>:
{
     f2c:	55                   	push   %ebp
     f2d:	89 e5                	mov    %esp,%ebp
     f2f:	57                   	push   %edi
     f30:	56                   	push   %esi
     f31:	53                   	push   %ebx
     f32:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
     f35:	be 14 51 00 00       	mov    $0x5114,%esi
     f3a:	b9 04 00 00 00       	mov    $0x4,%ecx
     f3f:	8d 7d d8             	lea    -0x28(%ebp),%edi
     f42:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  printf(1, "fourfiles test\n");
     f44:	68 e2 3d 00 00       	push   $0x3de2
     f49:	6a 01                	push   $0x1
     f4b:	e8 48 27 00 00       	call   3698 <printf>
     f50:	83 c4 10             	add    $0x10,%esp
  for(pi = 0; pi < 4; pi++){
     f53:	31 db                	xor    %ebx,%ebx
    fname = names[pi];
     f55:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    unlink(fname);
     f59:	83 ec 0c             	sub    $0xc,%esp
     f5c:	56                   	push   %esi
     f5d:	e8 5d 26 00 00       	call   35bf <unlink>
    pid = fork();
     f62:	e8 00 26 00 00       	call   3567 <fork>
    if(pid < 0){
     f67:	83 c4 10             	add    $0x10,%esp
     f6a:	85 c0                	test   %eax,%eax
     f6c:	0f 88 46 01 00 00    	js     10b8 <fourfiles+0x18c>
    if(pid == 0){
     f72:	0f 84 d7 00 00 00    	je     104f <fourfiles+0x123>
  for(pi = 0; pi < 4; pi++){
     f78:	43                   	inc    %ebx
     f79:	83 fb 04             	cmp    $0x4,%ebx
     f7c:	75 d7                	jne    f55 <fourfiles+0x29>
    wait();
     f7e:	e8 f4 25 00 00       	call   3577 <wait>
     f83:	e8 ef 25 00 00       	call   3577 <wait>
     f88:	e8 ea 25 00 00       	call   3577 <wait>
     f8d:	e8 e5 25 00 00       	call   3577 <wait>
  for(i = 0; i < 2; i++){
     f92:	31 f6                	xor    %esi,%esi
    fname = names[i];
     f94:	8b 44 b5 d8          	mov    -0x28(%ebp,%esi,4),%eax
     f98:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
     f9b:	83 ec 08             	sub    $0x8,%esp
     f9e:	6a 00                	push   $0x0
     fa0:	50                   	push   %eax
     fa1:	e8 09 26 00 00       	call   35af <open>
     fa6:	89 c3                	mov    %eax,%ebx
    while((n = read(fd, buf, sizeof(buf))) > 0){
     fa8:	83 c4 10             	add    $0x10,%esp
    total = 0;
     fab:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     fb2:	66 90                	xchg   %ax,%ax
    while((n = read(fd, buf, sizeof(buf))) > 0){
     fb4:	52                   	push   %edx
     fb5:	68 00 20 00 00       	push   $0x2000
     fba:	68 e0 78 00 00       	push   $0x78e0
     fbf:	53                   	push   %ebx
     fc0:	e8 c2 25 00 00       	call   3587 <read>
     fc5:	89 c7                	mov    %eax,%edi
     fc7:	83 c4 10             	add    $0x10,%esp
     fca:	85 c0                	test   %eax,%eax
     fcc:	7e 1f                	jle    fed <fourfiles+0xc1>
      for(j = 0; j < n; j++){
     fce:	31 c0                	xor    %eax,%eax
        if(buf[j] != '0'+i){
     fd0:	0f be 88 e0 78 00 00 	movsbl 0x78e0(%eax),%ecx
     fd7:	83 fe 01             	cmp    $0x1,%esi
     fda:	19 d2                	sbb    %edx,%edx
     fdc:	83 c2 31             	add    $0x31,%edx
     fdf:	39 d1                	cmp    %edx,%ecx
     fe1:	75 58                	jne    103b <fourfiles+0x10f>
      for(j = 0; j < n; j++){
     fe3:	40                   	inc    %eax
     fe4:	39 c7                	cmp    %eax,%edi
     fe6:	75 e8                	jne    fd0 <fourfiles+0xa4>
      total += n;
     fe8:	01 7d d4             	add    %edi,-0x2c(%ebp)
     feb:	eb c7                	jmp    fb4 <fourfiles+0x88>
    close(fd);
     fed:	83 ec 0c             	sub    $0xc,%esp
     ff0:	53                   	push   %ebx
     ff1:	e8 a1 25 00 00       	call   3597 <close>
    if(total != 12*500){
     ff6:	83 c4 10             	add    $0x10,%esp
     ff9:	81 7d d4 70 17 00 00 	cmpl   $0x1770,-0x2c(%ebp)
    1000:	0f 85 c6 00 00 00    	jne    10cc <fourfiles+0x1a0>
    unlink(fname);
    1006:	83 ec 0c             	sub    $0xc,%esp
    1009:	ff 75 d0             	push   -0x30(%ebp)
    100c:	e8 ae 25 00 00       	call   35bf <unlink>
  for(i = 0; i < 2; i++){
    1011:	83 c4 10             	add    $0x10,%esp
    1014:	4e                   	dec    %esi
    1015:	75 1a                	jne    1031 <fourfiles+0x105>
  printf(1, "fourfiles ok\n");
    1017:	83 ec 08             	sub    $0x8,%esp
    101a:	68 20 3e 00 00       	push   $0x3e20
    101f:	6a 01                	push   $0x1
    1021:	e8 72 26 00 00       	call   3698 <printf>
}
    1026:	83 c4 10             	add    $0x10,%esp
    1029:	8d 65 f4             	lea    -0xc(%ebp),%esp
    102c:	5b                   	pop    %ebx
    102d:	5e                   	pop    %esi
    102e:	5f                   	pop    %edi
    102f:	5d                   	pop    %ebp
    1030:	c3                   	ret    
    1031:	be 01 00 00 00       	mov    $0x1,%esi
    1036:	e9 59 ff ff ff       	jmp    f94 <fourfiles+0x68>
          printf(1, "wrong char\n");
    103b:	83 ec 08             	sub    $0x8,%esp
    103e:	68 03 3e 00 00       	push   $0x3e03
    1043:	6a 01                	push   $0x1
    1045:	e8 4e 26 00 00       	call   3698 <printf>
          exit();
    104a:	e8 20 25 00 00       	call   356f <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    104f:	83 ec 08             	sub    $0x8,%esp
    1052:	68 02 02 00 00       	push   $0x202
    1057:	56                   	push   %esi
    1058:	e8 52 25 00 00       	call   35af <open>
    105d:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    105f:	83 c4 10             	add    $0x10,%esp
    1062:	85 c0                	test   %eax,%eax
    1064:	78 3f                	js     10a5 <fourfiles+0x179>
      memset(buf, '0'+pi, 512);
    1066:	50                   	push   %eax
    1067:	68 00 02 00 00       	push   $0x200
    106c:	83 c3 30             	add    $0x30,%ebx
    106f:	53                   	push   %ebx
    1070:	68 e0 78 00 00       	push   $0x78e0
    1075:	e8 aa 23 00 00       	call   3424 <memset>
    107a:	83 c4 10             	add    $0x10,%esp
    107d:	bb 0c 00 00 00       	mov    $0xc,%ebx
        if((n = write(fd, buf, 500)) != 500){
    1082:	57                   	push   %edi
    1083:	68 f4 01 00 00       	push   $0x1f4
    1088:	68 e0 78 00 00       	push   $0x78e0
    108d:	56                   	push   %esi
    108e:	e8 fc 24 00 00       	call   358f <write>
    1093:	83 c4 10             	add    $0x10,%esp
    1096:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    109b:	75 44                	jne    10e1 <fourfiles+0x1b5>
      for(i = 0; i < 12; i++){
    109d:	4b                   	dec    %ebx
    109e:	75 e2                	jne    1082 <fourfiles+0x156>
      exit();
    10a0:	e8 ca 24 00 00       	call   356f <exit>
        printf(1, "create failed\n");
    10a5:	50                   	push   %eax
    10a6:	50                   	push   %eax
    10a7:	68 83 40 00 00       	push   $0x4083
    10ac:	6a 01                	push   $0x1
    10ae:	e8 e5 25 00 00       	call   3698 <printf>
        exit();
    10b3:	e8 b7 24 00 00       	call   356f <exit>
      printf(1, "fork failed\n");
    10b8:	83 ec 08             	sub    $0x8,%esp
    10bb:	68 bd 48 00 00       	push   $0x48bd
    10c0:	6a 01                	push   $0x1
    10c2:	e8 d1 25 00 00       	call   3698 <printf>
      exit();
    10c7:	e8 a3 24 00 00       	call   356f <exit>
      printf(1, "wrong length %d\n", total);
    10cc:	50                   	push   %eax
    10cd:	ff 75 d4             	push   -0x2c(%ebp)
    10d0:	68 0f 3e 00 00       	push   $0x3e0f
    10d5:	6a 01                	push   $0x1
    10d7:	e8 bc 25 00 00       	call   3698 <printf>
      exit();
    10dc:	e8 8e 24 00 00       	call   356f <exit>
          printf(1, "write failed %d\n", n);
    10e1:	51                   	push   %ecx
    10e2:	50                   	push   %eax
    10e3:	68 f2 3d 00 00       	push   $0x3df2
    10e8:	6a 01                	push   $0x1
    10ea:	e8 a9 25 00 00       	call   3698 <printf>
          exit();
    10ef:	e8 7b 24 00 00       	call   356f <exit>

000010f4 <createdelete>:
{
    10f4:	55                   	push   %ebp
    10f5:	89 e5                	mov    %esp,%ebp
    10f7:	57                   	push   %edi
    10f8:	56                   	push   %esi
    10f9:	53                   	push   %ebx
    10fa:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    10fd:	68 34 3e 00 00       	push   $0x3e34
    1102:	6a 01                	push   $0x1
    1104:	e8 8f 25 00 00       	call   3698 <printf>
    1109:	83 c4 10             	add    $0x10,%esp
  for(pi = 0; pi < 4; pi++){
    110c:	31 db                	xor    %ebx,%ebx
    pid = fork();
    110e:	e8 54 24 00 00       	call   3567 <fork>
    if(pid < 0){
    1113:	85 c0                	test   %eax,%eax
    1115:	0f 88 60 01 00 00    	js     127b <createdelete+0x187>
    if(pid == 0){
    111b:	0f 84 c7 00 00 00    	je     11e8 <createdelete+0xf4>
  for(pi = 0; pi < 4; pi++){
    1121:	43                   	inc    %ebx
    1122:	83 fb 04             	cmp    $0x4,%ebx
    1125:	75 e7                	jne    110e <createdelete+0x1a>
    wait();
    1127:	e8 4b 24 00 00       	call   3577 <wait>
    112c:	e8 46 24 00 00       	call   3577 <wait>
    1131:	e8 41 24 00 00       	call   3577 <wait>
    1136:	e8 3c 24 00 00       	call   3577 <wait>
  name[0] = name[1] = name[2] = 0;
    113b:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  for(i = 0; i < N; i++){
    113f:	31 f6                	xor    %esi,%esi
    1141:	8d 7d c8             	lea    -0x38(%ebp),%edi
    for(pi = 0; pi < 4; pi++){
    1144:	8d 46 30             	lea    0x30(%esi),%eax
    1147:	88 45 c7             	mov    %al,-0x39(%ebp)
      name[2] = '\0';
    114a:	b3 70                	mov    $0x70,%bl
      name[0] = 'p' + pi;
    114c:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    114f:	8a 45 c7             	mov    -0x39(%ebp),%al
    1152:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1155:	83 ec 08             	sub    $0x8,%esp
    1158:	6a 00                	push   $0x0
    115a:	57                   	push   %edi
    115b:	e8 4f 24 00 00       	call   35af <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1160:	83 c4 10             	add    $0x10,%esp
    1163:	85 f6                	test   %esi,%esi
    1165:	74 05                	je     116c <createdelete+0x78>
    1167:	83 fe 09             	cmp    $0x9,%esi
    116a:	7e 64                	jle    11d0 <createdelete+0xdc>
    116c:	85 c0                	test   %eax,%eax
    116e:	0f 88 f4 00 00 00    	js     1268 <createdelete+0x174>
        close(fd);
    1174:	83 ec 0c             	sub    $0xc,%esp
    1177:	50                   	push   %eax
    1178:	e8 1a 24 00 00       	call   3597 <close>
    117d:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    1180:	43                   	inc    %ebx
    1181:	80 fb 74             	cmp    $0x74,%bl
    1184:	75 c6                	jne    114c <createdelete+0x58>
  for(i = 0; i < N; i++){
    1186:	46                   	inc    %esi
    1187:	83 fe 14             	cmp    $0x14,%esi
    118a:	75 b8                	jne    1144 <createdelete+0x50>
    118c:	b3 70                	mov    $0x70,%bl
    118e:	66 90                	xchg   %ax,%ax
    for(pi = 0; pi < 4; pi++){
    1190:	8d 43 c0             	lea    -0x40(%ebx),%eax
    1193:	88 45 c7             	mov    %al,-0x39(%ebp)
      name[0] = 'p' + i;
    1196:	be 04 00 00 00       	mov    $0x4,%esi
    119b:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    119e:	8a 45 c7             	mov    -0x39(%ebp),%al
    11a1:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    11a4:	83 ec 0c             	sub    $0xc,%esp
    11a7:	57                   	push   %edi
    11a8:	e8 12 24 00 00       	call   35bf <unlink>
    for(pi = 0; pi < 4; pi++){
    11ad:	83 c4 10             	add    $0x10,%esp
    11b0:	4e                   	dec    %esi
    11b1:	75 e8                	jne    119b <createdelete+0xa7>
  for(i = 0; i < N; i++){
    11b3:	43                   	inc    %ebx
    11b4:	80 fb 84             	cmp    $0x84,%bl
    11b7:	75 d7                	jne    1190 <createdelete+0x9c>
  printf(1, "createdelete ok\n");
    11b9:	83 ec 08             	sub    $0x8,%esp
    11bc:	68 47 3e 00 00       	push   $0x3e47
    11c1:	6a 01                	push   $0x1
    11c3:	e8 d0 24 00 00       	call   3698 <printf>
}
    11c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11cb:	5b                   	pop    %ebx
    11cc:	5e                   	pop    %esi
    11cd:	5f                   	pop    %edi
    11ce:	5d                   	pop    %ebp
    11cf:	c3                   	ret    
      } else if((i >= 1 && i < N/2) && fd >= 0){
    11d0:	85 c0                	test   %eax,%eax
    11d2:	78 ac                	js     1180 <createdelete+0x8c>
        printf(1, "oops createdelete %s did exist\n", name);
    11d4:	50                   	push   %eax
    11d5:	57                   	push   %edi
    11d6:	68 18 4b 00 00       	push   $0x4b18
    11db:	6a 01                	push   $0x1
    11dd:	e8 b6 24 00 00       	call   3698 <printf>
        exit();
    11e2:	e8 88 23 00 00       	call   356f <exit>
    11e7:	90                   	nop
      name[0] = 'p' + pi;
    11e8:	83 c3 70             	add    $0x70,%ebx
    11eb:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    11ee:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    11f2:	be 01 00 00 00       	mov    $0x1,%esi
    11f7:	31 db                	xor    %ebx,%ebx
    11f9:	8d 7d c8             	lea    -0x38(%ebp),%edi
        name[1] = '0' + i;
    11fc:	8d 43 30             	lea    0x30(%ebx),%eax
    11ff:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1202:	83 ec 08             	sub    $0x8,%esp
    1205:	68 02 02 00 00       	push   $0x202
    120a:	57                   	push   %edi
    120b:	e8 9f 23 00 00       	call   35af <open>
        if(fd < 0){
    1210:	83 c4 10             	add    $0x10,%esp
    1213:	85 c0                	test   %eax,%eax
    1215:	78 78                	js     128f <createdelete+0x19b>
        close(fd);
    1217:	83 ec 0c             	sub    $0xc,%esp
    121a:	50                   	push   %eax
    121b:	e8 77 23 00 00       	call   3597 <close>
        if(i > 0 && (i % 2 ) == 0){
    1220:	83 c4 10             	add    $0x10,%esp
    1223:	85 db                	test   %ebx,%ebx
    1225:	74 0a                	je     1231 <createdelete+0x13d>
    1227:	f6 c3 01             	test   $0x1,%bl
    122a:	74 0e                	je     123a <createdelete+0x146>
      for(i = 0; i < N; i++){
    122c:	83 fe 14             	cmp    $0x14,%esi
    122f:	74 04                	je     1235 <createdelete+0x141>
    1231:	43                   	inc    %ebx
    1232:	46                   	inc    %esi
    1233:	eb c7                	jmp    11fc <createdelete+0x108>
      exit();
    1235:	e8 35 23 00 00       	call   356f <exit>
          name[1] = '0' + (i / 2);
    123a:	89 d8                	mov    %ebx,%eax
    123c:	d1 f8                	sar    %eax
    123e:	83 c0 30             	add    $0x30,%eax
    1241:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1244:	83 ec 0c             	sub    $0xc,%esp
    1247:	57                   	push   %edi
    1248:	e8 72 23 00 00       	call   35bf <unlink>
    124d:	83 c4 10             	add    $0x10,%esp
    1250:	85 c0                	test   %eax,%eax
    1252:	79 d8                	jns    122c <createdelete+0x138>
            printf(1, "unlink failed\n");
    1254:	51                   	push   %ecx
    1255:	51                   	push   %ecx
    1256:	68 35 3a 00 00       	push   $0x3a35
    125b:	6a 01                	push   $0x1
    125d:	e8 36 24 00 00       	call   3698 <printf>
            exit();
    1262:	e8 08 23 00 00       	call   356f <exit>
    1267:	90                   	nop
        printf(1, "oops createdelete %s didn't exist\n", name);
    1268:	52                   	push   %edx
    1269:	57                   	push   %edi
    126a:	68 f4 4a 00 00       	push   $0x4af4
    126f:	6a 01                	push   $0x1
    1271:	e8 22 24 00 00       	call   3698 <printf>
        exit();
    1276:	e8 f4 22 00 00       	call   356f <exit>
      printf(1, "fork failed\n");
    127b:	83 ec 08             	sub    $0x8,%esp
    127e:	68 bd 48 00 00       	push   $0x48bd
    1283:	6a 01                	push   $0x1
    1285:	e8 0e 24 00 00       	call   3698 <printf>
      exit();
    128a:	e8 e0 22 00 00       	call   356f <exit>
          printf(1, "create failed\n");
    128f:	83 ec 08             	sub    $0x8,%esp
    1292:	68 83 40 00 00       	push   $0x4083
    1297:	6a 01                	push   $0x1
    1299:	e8 fa 23 00 00       	call   3698 <printf>
          exit();
    129e:	e8 cc 22 00 00       	call   356f <exit>
    12a3:	90                   	nop

000012a4 <unlinkread>:
{
    12a4:	55                   	push   %ebp
    12a5:	89 e5                	mov    %esp,%ebp
    12a7:	56                   	push   %esi
    12a8:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
    12a9:	83 ec 08             	sub    $0x8,%esp
    12ac:	68 58 3e 00 00       	push   $0x3e58
    12b1:	6a 01                	push   $0x1
    12b3:	e8 e0 23 00 00       	call   3698 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    12b8:	5e                   	pop    %esi
    12b9:	58                   	pop    %eax
    12ba:	68 02 02 00 00       	push   $0x202
    12bf:	68 69 3e 00 00       	push   $0x3e69
    12c4:	e8 e6 22 00 00       	call   35af <open>
  if(fd < 0){
    12c9:	83 c4 10             	add    $0x10,%esp
    12cc:	85 c0                	test   %eax,%eax
    12ce:	0f 88 e2 00 00 00    	js     13b6 <unlinkread+0x112>
    12d4:	89 c3                	mov    %eax,%ebx
  write(fd, "hello", 5);
    12d6:	50                   	push   %eax
    12d7:	6a 05                	push   $0x5
    12d9:	68 8e 3e 00 00       	push   $0x3e8e
    12de:	53                   	push   %ebx
    12df:	e8 ab 22 00 00       	call   358f <write>
  close(fd);
    12e4:	89 1c 24             	mov    %ebx,(%esp)
    12e7:	e8 ab 22 00 00       	call   3597 <close>
  fd = open("unlinkread", O_RDWR);
    12ec:	5a                   	pop    %edx
    12ed:	59                   	pop    %ecx
    12ee:	6a 02                	push   $0x2
    12f0:	68 69 3e 00 00       	push   $0x3e69
    12f5:	e8 b5 22 00 00       	call   35af <open>
    12fa:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    12fc:	83 c4 10             	add    $0x10,%esp
    12ff:	85 c0                	test   %eax,%eax
    1301:	0f 88 0e 01 00 00    	js     1415 <unlinkread+0x171>
  if(unlink("unlinkread") != 0){
    1307:	83 ec 0c             	sub    $0xc,%esp
    130a:	68 69 3e 00 00       	push   $0x3e69
    130f:	e8 ab 22 00 00       	call   35bf <unlink>
    1314:	83 c4 10             	add    $0x10,%esp
    1317:	85 c0                	test   %eax,%eax
    1319:	0f 85 e3 00 00 00    	jne    1402 <unlinkread+0x15e>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    131f:	83 ec 08             	sub    $0x8,%esp
    1322:	68 02 02 00 00       	push   $0x202
    1327:	68 69 3e 00 00       	push   $0x3e69
    132c:	e8 7e 22 00 00       	call   35af <open>
    1331:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    1333:	83 c4 0c             	add    $0xc,%esp
    1336:	6a 03                	push   $0x3
    1338:	68 c6 3e 00 00       	push   $0x3ec6
    133d:	50                   	push   %eax
    133e:	e8 4c 22 00 00       	call   358f <write>
  close(fd1);
    1343:	89 34 24             	mov    %esi,(%esp)
    1346:	e8 4c 22 00 00       	call   3597 <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    134b:	83 c4 0c             	add    $0xc,%esp
    134e:	68 00 20 00 00       	push   $0x2000
    1353:	68 e0 78 00 00       	push   $0x78e0
    1358:	53                   	push   %ebx
    1359:	e8 29 22 00 00       	call   3587 <read>
    135e:	83 c4 10             	add    $0x10,%esp
    1361:	83 f8 05             	cmp    $0x5,%eax
    1364:	0f 85 85 00 00 00    	jne    13ef <unlinkread+0x14b>
  if(buf[0] != 'h'){
    136a:	80 3d e0 78 00 00 68 	cmpb   $0x68,0x78e0
    1371:	75 69                	jne    13dc <unlinkread+0x138>
  if(write(fd, buf, 10) != 10){
    1373:	56                   	push   %esi
    1374:	6a 0a                	push   $0xa
    1376:	68 e0 78 00 00       	push   $0x78e0
    137b:	53                   	push   %ebx
    137c:	e8 0e 22 00 00       	call   358f <write>
    1381:	83 c4 10             	add    $0x10,%esp
    1384:	83 f8 0a             	cmp    $0xa,%eax
    1387:	75 40                	jne    13c9 <unlinkread+0x125>
  close(fd);
    1389:	83 ec 0c             	sub    $0xc,%esp
    138c:	53                   	push   %ebx
    138d:	e8 05 22 00 00       	call   3597 <close>
  unlink("unlinkread");
    1392:	c7 04 24 69 3e 00 00 	movl   $0x3e69,(%esp)
    1399:	e8 21 22 00 00       	call   35bf <unlink>
  printf(1, "unlinkread ok\n");
    139e:	58                   	pop    %eax
    139f:	5a                   	pop    %edx
    13a0:	68 11 3f 00 00       	push   $0x3f11
    13a5:	6a 01                	push   $0x1
    13a7:	e8 ec 22 00 00       	call   3698 <printf>
}
    13ac:	83 c4 10             	add    $0x10,%esp
    13af:	8d 65 f8             	lea    -0x8(%ebp),%esp
    13b2:	5b                   	pop    %ebx
    13b3:	5e                   	pop    %esi
    13b4:	5d                   	pop    %ebp
    13b5:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    13b6:	53                   	push   %ebx
    13b7:	53                   	push   %ebx
    13b8:	68 74 3e 00 00       	push   $0x3e74
    13bd:	6a 01                	push   $0x1
    13bf:	e8 d4 22 00 00       	call   3698 <printf>
    exit();
    13c4:	e8 a6 21 00 00       	call   356f <exit>
    printf(1, "unlinkread write failed\n");
    13c9:	51                   	push   %ecx
    13ca:	51                   	push   %ecx
    13cb:	68 f8 3e 00 00       	push   $0x3ef8
    13d0:	6a 01                	push   $0x1
    13d2:	e8 c1 22 00 00       	call   3698 <printf>
    exit();
    13d7:	e8 93 21 00 00       	call   356f <exit>
    printf(1, "unlinkread wrong data\n");
    13dc:	50                   	push   %eax
    13dd:	50                   	push   %eax
    13de:	68 e1 3e 00 00       	push   $0x3ee1
    13e3:	6a 01                	push   $0x1
    13e5:	e8 ae 22 00 00       	call   3698 <printf>
    exit();
    13ea:	e8 80 21 00 00       	call   356f <exit>
    printf(1, "unlinkread read failed");
    13ef:	50                   	push   %eax
    13f0:	50                   	push   %eax
    13f1:	68 ca 3e 00 00       	push   $0x3eca
    13f6:	6a 01                	push   $0x1
    13f8:	e8 9b 22 00 00       	call   3698 <printf>
    exit();
    13fd:	e8 6d 21 00 00       	call   356f <exit>
    printf(1, "unlink unlinkread failed\n");
    1402:	50                   	push   %eax
    1403:	50                   	push   %eax
    1404:	68 ac 3e 00 00       	push   $0x3eac
    1409:	6a 01                	push   $0x1
    140b:	e8 88 22 00 00       	call   3698 <printf>
    exit();
    1410:	e8 5a 21 00 00       	call   356f <exit>
    printf(1, "open unlinkread failed\n");
    1415:	50                   	push   %eax
    1416:	50                   	push   %eax
    1417:	68 94 3e 00 00       	push   $0x3e94
    141c:	6a 01                	push   $0x1
    141e:	e8 75 22 00 00       	call   3698 <printf>
    exit();
    1423:	e8 47 21 00 00       	call   356f <exit>

00001428 <linktest>:
{
    1428:	55                   	push   %ebp
    1429:	89 e5                	mov    %esp,%ebp
    142b:	53                   	push   %ebx
    142c:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
    142f:	68 20 3f 00 00       	push   $0x3f20
    1434:	6a 01                	push   $0x1
    1436:	e8 5d 22 00 00       	call   3698 <printf>
  unlink("lf1");
    143b:	c7 04 24 2a 3f 00 00 	movl   $0x3f2a,(%esp)
    1442:	e8 78 21 00 00       	call   35bf <unlink>
  unlink("lf2");
    1447:	c7 04 24 2e 3f 00 00 	movl   $0x3f2e,(%esp)
    144e:	e8 6c 21 00 00       	call   35bf <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    1453:	58                   	pop    %eax
    1454:	5a                   	pop    %edx
    1455:	68 02 02 00 00       	push   $0x202
    145a:	68 2a 3f 00 00       	push   $0x3f2a
    145f:	e8 4b 21 00 00       	call   35af <open>
  if(fd < 0){
    1464:	83 c4 10             	add    $0x10,%esp
    1467:	85 c0                	test   %eax,%eax
    1469:	0f 88 1a 01 00 00    	js     1589 <linktest+0x161>
    146f:	89 c3                	mov    %eax,%ebx
  if(write(fd, "hello", 5) != 5){
    1471:	50                   	push   %eax
    1472:	6a 05                	push   $0x5
    1474:	68 8e 3e 00 00       	push   $0x3e8e
    1479:	53                   	push   %ebx
    147a:	e8 10 21 00 00       	call   358f <write>
    147f:	83 c4 10             	add    $0x10,%esp
    1482:	83 f8 05             	cmp    $0x5,%eax
    1485:	0f 85 96 01 00 00    	jne    1621 <linktest+0x1f9>
  close(fd);
    148b:	83 ec 0c             	sub    $0xc,%esp
    148e:	53                   	push   %ebx
    148f:	e8 03 21 00 00       	call   3597 <close>
  if(link("lf1", "lf2") < 0){
    1494:	5b                   	pop    %ebx
    1495:	58                   	pop    %eax
    1496:	68 2e 3f 00 00       	push   $0x3f2e
    149b:	68 2a 3f 00 00       	push   $0x3f2a
    14a0:	e8 2a 21 00 00       	call   35cf <link>
    14a5:	83 c4 10             	add    $0x10,%esp
    14a8:	85 c0                	test   %eax,%eax
    14aa:	0f 88 5e 01 00 00    	js     160e <linktest+0x1e6>
  unlink("lf1");
    14b0:	83 ec 0c             	sub    $0xc,%esp
    14b3:	68 2a 3f 00 00       	push   $0x3f2a
    14b8:	e8 02 21 00 00       	call   35bf <unlink>
  if(open("lf1", 0) >= 0){
    14bd:	58                   	pop    %eax
    14be:	5a                   	pop    %edx
    14bf:	6a 00                	push   $0x0
    14c1:	68 2a 3f 00 00       	push   $0x3f2a
    14c6:	e8 e4 20 00 00       	call   35af <open>
    14cb:	83 c4 10             	add    $0x10,%esp
    14ce:	85 c0                	test   %eax,%eax
    14d0:	0f 89 25 01 00 00    	jns    15fb <linktest+0x1d3>
  fd = open("lf2", 0);
    14d6:	83 ec 08             	sub    $0x8,%esp
    14d9:	6a 00                	push   $0x0
    14db:	68 2e 3f 00 00       	push   $0x3f2e
    14e0:	e8 ca 20 00 00       	call   35af <open>
    14e5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    14e7:	83 c4 10             	add    $0x10,%esp
    14ea:	85 c0                	test   %eax,%eax
    14ec:	0f 88 f6 00 00 00    	js     15e8 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != 5){
    14f2:	50                   	push   %eax
    14f3:	68 00 20 00 00       	push   $0x2000
    14f8:	68 e0 78 00 00       	push   $0x78e0
    14fd:	53                   	push   %ebx
    14fe:	e8 84 20 00 00       	call   3587 <read>
    1503:	83 c4 10             	add    $0x10,%esp
    1506:	83 f8 05             	cmp    $0x5,%eax
    1509:	0f 85 c6 00 00 00    	jne    15d5 <linktest+0x1ad>
  close(fd);
    150f:	83 ec 0c             	sub    $0xc,%esp
    1512:	53                   	push   %ebx
    1513:	e8 7f 20 00 00       	call   3597 <close>
  if(link("lf2", "lf2") >= 0){
    1518:	58                   	pop    %eax
    1519:	5a                   	pop    %edx
    151a:	68 2e 3f 00 00       	push   $0x3f2e
    151f:	68 2e 3f 00 00       	push   $0x3f2e
    1524:	e8 a6 20 00 00       	call   35cf <link>
    1529:	83 c4 10             	add    $0x10,%esp
    152c:	85 c0                	test   %eax,%eax
    152e:	0f 89 8e 00 00 00    	jns    15c2 <linktest+0x19a>
  unlink("lf2");
    1534:	83 ec 0c             	sub    $0xc,%esp
    1537:	68 2e 3f 00 00       	push   $0x3f2e
    153c:	e8 7e 20 00 00       	call   35bf <unlink>
  if(link("lf2", "lf1") >= 0){
    1541:	59                   	pop    %ecx
    1542:	5b                   	pop    %ebx
    1543:	68 2a 3f 00 00       	push   $0x3f2a
    1548:	68 2e 3f 00 00       	push   $0x3f2e
    154d:	e8 7d 20 00 00       	call   35cf <link>
    1552:	83 c4 10             	add    $0x10,%esp
    1555:	85 c0                	test   %eax,%eax
    1557:	79 56                	jns    15af <linktest+0x187>
  if(link(".", "lf1") >= 0){
    1559:	83 ec 08             	sub    $0x8,%esp
    155c:	68 2a 3f 00 00       	push   $0x3f2a
    1561:	68 f2 41 00 00       	push   $0x41f2
    1566:	e8 64 20 00 00       	call   35cf <link>
    156b:	83 c4 10             	add    $0x10,%esp
    156e:	85 c0                	test   %eax,%eax
    1570:	79 2a                	jns    159c <linktest+0x174>
  printf(1, "linktest ok\n");
    1572:	83 ec 08             	sub    $0x8,%esp
    1575:	68 c8 3f 00 00       	push   $0x3fc8
    157a:	6a 01                	push   $0x1
    157c:	e8 17 21 00 00       	call   3698 <printf>
}
    1581:	83 c4 10             	add    $0x10,%esp
    1584:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1587:	c9                   	leave  
    1588:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    1589:	50                   	push   %eax
    158a:	50                   	push   %eax
    158b:	68 32 3f 00 00       	push   $0x3f32
    1590:	6a 01                	push   $0x1
    1592:	e8 01 21 00 00       	call   3698 <printf>
    exit();
    1597:	e8 d3 1f 00 00       	call   356f <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    159c:	50                   	push   %eax
    159d:	50                   	push   %eax
    159e:	68 ac 3f 00 00       	push   $0x3fac
    15a3:	6a 01                	push   $0x1
    15a5:	e8 ee 20 00 00       	call   3698 <printf>
    exit();
    15aa:	e8 c0 1f 00 00       	call   356f <exit>
    printf(1, "link non-existant succeeded! oops\n");
    15af:	52                   	push   %edx
    15b0:	52                   	push   %edx
    15b1:	68 60 4b 00 00       	push   $0x4b60
    15b6:	6a 01                	push   $0x1
    15b8:	e8 db 20 00 00       	call   3698 <printf>
    exit();
    15bd:	e8 ad 1f 00 00       	call   356f <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    15c2:	50                   	push   %eax
    15c3:	50                   	push   %eax
    15c4:	68 8e 3f 00 00       	push   $0x3f8e
    15c9:	6a 01                	push   $0x1
    15cb:	e8 c8 20 00 00       	call   3698 <printf>
    exit();
    15d0:	e8 9a 1f 00 00       	call   356f <exit>
    printf(1, "read lf2 failed\n");
    15d5:	51                   	push   %ecx
    15d6:	51                   	push   %ecx
    15d7:	68 7d 3f 00 00       	push   $0x3f7d
    15dc:	6a 01                	push   $0x1
    15de:	e8 b5 20 00 00       	call   3698 <printf>
    exit();
    15e3:	e8 87 1f 00 00       	call   356f <exit>
    printf(1, "open lf2 failed\n");
    15e8:	50                   	push   %eax
    15e9:	50                   	push   %eax
    15ea:	68 6c 3f 00 00       	push   $0x3f6c
    15ef:	6a 01                	push   $0x1
    15f1:	e8 a2 20 00 00       	call   3698 <printf>
    exit();
    15f6:	e8 74 1f 00 00       	call   356f <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    15fb:	50                   	push   %eax
    15fc:	50                   	push   %eax
    15fd:	68 38 4b 00 00       	push   $0x4b38
    1602:	6a 01                	push   $0x1
    1604:	e8 8f 20 00 00       	call   3698 <printf>
    exit();
    1609:	e8 61 1f 00 00       	call   356f <exit>
    printf(1, "link lf1 lf2 failed\n");
    160e:	51                   	push   %ecx
    160f:	51                   	push   %ecx
    1610:	68 57 3f 00 00       	push   $0x3f57
    1615:	6a 01                	push   $0x1
    1617:	e8 7c 20 00 00       	call   3698 <printf>
    exit();
    161c:	e8 4e 1f 00 00       	call   356f <exit>
    printf(1, "write lf1 failed\n");
    1621:	50                   	push   %eax
    1622:	50                   	push   %eax
    1623:	68 45 3f 00 00       	push   $0x3f45
    1628:	6a 01                	push   $0x1
    162a:	e8 69 20 00 00       	call   3698 <printf>
    exit();
    162f:	e8 3b 1f 00 00       	call   356f <exit>

00001634 <concreate>:
{
    1634:	55                   	push   %ebp
    1635:	89 e5                	mov    %esp,%ebp
    1637:	57                   	push   %edi
    1638:	56                   	push   %esi
    1639:	53                   	push   %ebx
    163a:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
    163d:	68 d5 3f 00 00       	push   $0x3fd5
    1642:	6a 01                	push   $0x1
    1644:	e8 4f 20 00 00       	call   3698 <printf>
  file[0] = 'C';
    1649:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    164d:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    1651:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 40; i++){
    1654:	31 f6                	xor    %esi,%esi
    1656:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    1659:	bf 03 00 00 00       	mov    $0x3,%edi
    165e:	eb 3c                	jmp    169c <concreate+0x68>
    1660:	89 f0                	mov    %esi,%eax
    1662:	99                   	cltd   
    1663:	f7 ff                	idiv   %edi
    if(pid && (i % 3) == 1){
    1665:	4a                   	dec    %edx
    1666:	0f 84 9c 00 00 00    	je     1708 <concreate+0xd4>
      fd = open(file, O_CREATE | O_RDWR);
    166c:	83 ec 08             	sub    $0x8,%esp
    166f:	68 02 02 00 00       	push   $0x202
    1674:	53                   	push   %ebx
    1675:	e8 35 1f 00 00       	call   35af <open>
      if(fd < 0){
    167a:	83 c4 10             	add    $0x10,%esp
    167d:	85 c0                	test   %eax,%eax
    167f:	78 5c                	js     16dd <concreate+0xa9>
      close(fd);
    1681:	83 ec 0c             	sub    $0xc,%esp
    1684:	50                   	push   %eax
    1685:	e8 0d 1f 00 00       	call   3597 <close>
    168a:	83 c4 10             	add    $0x10,%esp
      wait();
    168d:	e8 e5 1e 00 00       	call   3577 <wait>
  for(i = 0; i < 40; i++){
    1692:	46                   	inc    %esi
    1693:	83 fe 28             	cmp    $0x28,%esi
    1696:	0f 84 8c 00 00 00    	je     1728 <concreate+0xf4>
    file[1] = '0' + i;
    169c:	8d 46 30             	lea    0x30(%esi),%eax
    169f:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    16a2:	83 ec 0c             	sub    $0xc,%esp
    16a5:	53                   	push   %ebx
    16a6:	e8 14 1f 00 00       	call   35bf <unlink>
    pid = fork();
    16ab:	e8 b7 1e 00 00       	call   3567 <fork>
    if(pid && (i % 3) == 1){
    16b0:	83 c4 10             	add    $0x10,%esp
    16b3:	85 c0                	test   %eax,%eax
    16b5:	75 a9                	jne    1660 <concreate+0x2c>
      link("C0", file);
    16b7:	b9 05 00 00 00       	mov    $0x5,%ecx
    16bc:	89 f0                	mov    %esi,%eax
    16be:	99                   	cltd   
    16bf:	f7 f9                	idiv   %ecx
    } else if(pid == 0 && (i % 5) == 1){
    16c1:	4a                   	dec    %edx
    16c2:	74 2c                	je     16f0 <concreate+0xbc>
      fd = open(file, O_CREATE | O_RDWR);
    16c4:	83 ec 08             	sub    $0x8,%esp
    16c7:	68 02 02 00 00       	push   $0x202
    16cc:	53                   	push   %ebx
    16cd:	e8 dd 1e 00 00       	call   35af <open>
      if(fd < 0){
    16d2:	83 c4 10             	add    $0x10,%esp
    16d5:	85 c0                	test   %eax,%eax
    16d7:	0f 89 05 02 00 00    	jns    18e2 <concreate+0x2ae>
        printf(1, "concreate create %s failed\n", file);
    16dd:	51                   	push   %ecx
    16de:	53                   	push   %ebx
    16df:	68 e8 3f 00 00       	push   $0x3fe8
    16e4:	6a 01                	push   $0x1
    16e6:	e8 ad 1f 00 00       	call   3698 <printf>
        exit();
    16eb:	e8 7f 1e 00 00       	call   356f <exit>
      link("C0", file);
    16f0:	83 ec 08             	sub    $0x8,%esp
    16f3:	53                   	push   %ebx
    16f4:	68 e5 3f 00 00       	push   $0x3fe5
    16f9:	e8 d1 1e 00 00       	call   35cf <link>
    16fe:	83 c4 10             	add    $0x10,%esp
      exit();
    1701:	e8 69 1e 00 00       	call   356f <exit>
    1706:	66 90                	xchg   %ax,%ax
      link("C0", file);
    1708:	83 ec 08             	sub    $0x8,%esp
    170b:	53                   	push   %ebx
    170c:	68 e5 3f 00 00       	push   $0x3fe5
    1711:	e8 b9 1e 00 00       	call   35cf <link>
    1716:	83 c4 10             	add    $0x10,%esp
      wait();
    1719:	e8 59 1e 00 00       	call   3577 <wait>
  for(i = 0; i < 40; i++){
    171e:	46                   	inc    %esi
    171f:	83 fe 28             	cmp    $0x28,%esi
    1722:	0f 85 74 ff ff ff    	jne    169c <concreate+0x68>
  memset(fa, 0, sizeof(fa));
    1728:	50                   	push   %eax
    1729:	6a 28                	push   $0x28
    172b:	6a 00                	push   $0x0
    172d:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1730:	50                   	push   %eax
    1731:	e8 ee 1c 00 00       	call   3424 <memset>
  fd = open(".", 0);
    1736:	58                   	pop    %eax
    1737:	5a                   	pop    %edx
    1738:	6a 00                	push   $0x0
    173a:	68 f2 41 00 00       	push   $0x41f2
    173f:	e8 6b 1e 00 00       	call   35af <open>
    1744:	89 c6                	mov    %eax,%esi
  while(read(fd, &de, sizeof(de)) > 0){
    1746:	83 c4 10             	add    $0x10,%esp
  n = 0;
    1749:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    1750:	8d 7d b0             	lea    -0x50(%ebp),%edi
    1753:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    1754:	50                   	push   %eax
    1755:	6a 10                	push   $0x10
    1757:	57                   	push   %edi
    1758:	56                   	push   %esi
    1759:	e8 29 1e 00 00       	call   3587 <read>
    175e:	83 c4 10             	add    $0x10,%esp
    1761:	85 c0                	test   %eax,%eax
    1763:	7e 3b                	jle    17a0 <concreate+0x16c>
    if(de.inum == 0)
    1765:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    176a:	74 e8                	je     1754 <concreate+0x120>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    176c:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    1770:	75 e2                	jne    1754 <concreate+0x120>
    1772:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1776:	75 dc                	jne    1754 <concreate+0x120>
      i = de.name[1] - '0';
    1778:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    177c:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    177f:	83 f8 27             	cmp    $0x27,%eax
    1782:	0f 87 44 01 00 00    	ja     18cc <concreate+0x298>
      if(fa[i]){
    1788:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    178d:	0f 85 23 01 00 00    	jne    18b6 <concreate+0x282>
      fa[i] = 1;
    1793:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    1798:	ff 45 a4             	incl   -0x5c(%ebp)
    179b:	eb b7                	jmp    1754 <concreate+0x120>
    179d:	8d 76 00             	lea    0x0(%esi),%esi
  close(fd);
    17a0:	83 ec 0c             	sub    $0xc,%esp
    17a3:	56                   	push   %esi
    17a4:	e8 ee 1d 00 00       	call   3597 <close>
  if(n != 40){
    17a9:	83 c4 10             	add    $0x10,%esp
    17ac:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    17b0:	0f 85 ed 00 00 00    	jne    18a3 <concreate+0x26f>
  for(i = 0; i < 40; i++){
    17b6:	31 f6                	xor    %esi,%esi
    17b8:	eb 69                	jmp    1823 <concreate+0x1ef>
    17ba:	66 90                	xchg   %ax,%ax
    if(((i % 3) == 0 && pid == 0) ||
    17bc:	85 ff                	test   %edi,%edi
    17be:	0f 85 8d 00 00 00    	jne    1851 <concreate+0x21d>
      close(open(file, 0));
    17c4:	83 ec 08             	sub    $0x8,%esp
    17c7:	6a 00                	push   $0x0
    17c9:	53                   	push   %ebx
    17ca:	e8 e0 1d 00 00       	call   35af <open>
    17cf:	89 04 24             	mov    %eax,(%esp)
    17d2:	e8 c0 1d 00 00       	call   3597 <close>
      close(open(file, 0));
    17d7:	58                   	pop    %eax
    17d8:	5a                   	pop    %edx
    17d9:	6a 00                	push   $0x0
    17db:	53                   	push   %ebx
    17dc:	e8 ce 1d 00 00       	call   35af <open>
    17e1:	89 04 24             	mov    %eax,(%esp)
    17e4:	e8 ae 1d 00 00       	call   3597 <close>
      close(open(file, 0));
    17e9:	59                   	pop    %ecx
    17ea:	58                   	pop    %eax
    17eb:	6a 00                	push   $0x0
    17ed:	53                   	push   %ebx
    17ee:	e8 bc 1d 00 00       	call   35af <open>
    17f3:	89 04 24             	mov    %eax,(%esp)
    17f6:	e8 9c 1d 00 00       	call   3597 <close>
      close(open(file, 0));
    17fb:	58                   	pop    %eax
    17fc:	5a                   	pop    %edx
    17fd:	6a 00                	push   $0x0
    17ff:	53                   	push   %ebx
    1800:	e8 aa 1d 00 00       	call   35af <open>
    1805:	89 04 24             	mov    %eax,(%esp)
    1808:	e8 8a 1d 00 00       	call   3597 <close>
    180d:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    1810:	85 ff                	test   %edi,%edi
    1812:	0f 84 e9 fe ff ff    	je     1701 <concreate+0xcd>
      wait();
    1818:	e8 5a 1d 00 00       	call   3577 <wait>
  for(i = 0; i < 40; i++){
    181d:	46                   	inc    %esi
    181e:	83 fe 28             	cmp    $0x28,%esi
    1821:	74 55                	je     1878 <concreate+0x244>
    file[1] = '0' + i;
    1823:	8d 46 30             	lea    0x30(%esi),%eax
    1826:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    1829:	e8 39 1d 00 00       	call   3567 <fork>
    182e:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    1830:	85 c0                	test   %eax,%eax
    1832:	78 5b                	js     188f <concreate+0x25b>
    if(((i % 3) == 0 && pid == 0) ||
    1834:	89 f0                	mov    %esi,%eax
    1836:	b9 03 00 00 00       	mov    $0x3,%ecx
    183b:	99                   	cltd   
    183c:	f7 f9                	idiv   %ecx
    183e:	85 d2                	test   %edx,%edx
    1840:	0f 84 76 ff ff ff    	je     17bc <concreate+0x188>
    1846:	4a                   	dec    %edx
    1847:	75 08                	jne    1851 <concreate+0x21d>
       ((i % 3) == 1 && pid != 0)){
    1849:	85 ff                	test   %edi,%edi
    184b:	0f 85 73 ff ff ff    	jne    17c4 <concreate+0x190>
      unlink(file);
    1851:	83 ec 0c             	sub    $0xc,%esp
    1854:	53                   	push   %ebx
    1855:	e8 65 1d 00 00       	call   35bf <unlink>
      unlink(file);
    185a:	89 1c 24             	mov    %ebx,(%esp)
    185d:	e8 5d 1d 00 00       	call   35bf <unlink>
      unlink(file);
    1862:	89 1c 24             	mov    %ebx,(%esp)
    1865:	e8 55 1d 00 00       	call   35bf <unlink>
      unlink(file);
    186a:	89 1c 24             	mov    %ebx,(%esp)
    186d:	e8 4d 1d 00 00       	call   35bf <unlink>
    1872:	83 c4 10             	add    $0x10,%esp
    1875:	eb 99                	jmp    1810 <concreate+0x1dc>
    1877:	90                   	nop
  printf(1, "concreate ok\n");
    1878:	83 ec 08             	sub    $0x8,%esp
    187b:	68 3a 40 00 00       	push   $0x403a
    1880:	6a 01                	push   $0x1
    1882:	e8 11 1e 00 00       	call   3698 <printf>
}
    1887:	8d 65 f4             	lea    -0xc(%ebp),%esp
    188a:	5b                   	pop    %ebx
    188b:	5e                   	pop    %esi
    188c:	5f                   	pop    %edi
    188d:	5d                   	pop    %ebp
    188e:	c3                   	ret    
      printf(1, "fork failed\n");
    188f:	83 ec 08             	sub    $0x8,%esp
    1892:	68 bd 48 00 00       	push   $0x48bd
    1897:	6a 01                	push   $0x1
    1899:	e8 fa 1d 00 00       	call   3698 <printf>
      exit();
    189e:	e8 cc 1c 00 00       	call   356f <exit>
    printf(1, "concreate not enough files in directory listing\n");
    18a3:	51                   	push   %ecx
    18a4:	51                   	push   %ecx
    18a5:	68 84 4b 00 00       	push   $0x4b84
    18aa:	6a 01                	push   $0x1
    18ac:	e8 e7 1d 00 00       	call   3698 <printf>
    exit();
    18b1:	e8 b9 1c 00 00       	call   356f <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    18b6:	50                   	push   %eax
    18b7:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    18ba:	50                   	push   %eax
    18bb:	68 1d 40 00 00       	push   $0x401d
    18c0:	6a 01                	push   $0x1
    18c2:	e8 d1 1d 00 00       	call   3698 <printf>
        exit();
    18c7:	e8 a3 1c 00 00       	call   356f <exit>
        printf(1, "concreate weird file %s\n", de.name);
    18cc:	50                   	push   %eax
    18cd:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    18d0:	50                   	push   %eax
    18d1:	68 04 40 00 00       	push   $0x4004
    18d6:	6a 01                	push   $0x1
    18d8:	e8 bb 1d 00 00       	call   3698 <printf>
        exit();
    18dd:	e8 8d 1c 00 00       	call   356f <exit>
      close(fd);
    18e2:	83 ec 0c             	sub    $0xc,%esp
    18e5:	50                   	push   %eax
    18e6:	e8 ac 1c 00 00       	call   3597 <close>
    18eb:	83 c4 10             	add    $0x10,%esp
    18ee:	e9 0e fe ff ff       	jmp    1701 <concreate+0xcd>
    18f3:	90                   	nop

000018f4 <linkunlink>:
{
    18f4:	55                   	push   %ebp
    18f5:	89 e5                	mov    %esp,%ebp
    18f7:	57                   	push   %edi
    18f8:	56                   	push   %esi
    18f9:	53                   	push   %ebx
    18fa:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
    18fd:	68 48 40 00 00       	push   $0x4048
    1902:	6a 01                	push   $0x1
    1904:	e8 8f 1d 00 00       	call   3698 <printf>
  unlink("x");
    1909:	c7 04 24 d5 42 00 00 	movl   $0x42d5,(%esp)
    1910:	e8 aa 1c 00 00       	call   35bf <unlink>
  pid = fork();
    1915:	e8 4d 1c 00 00       	call   3567 <fork>
    191a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    191d:	83 c4 10             	add    $0x10,%esp
    1920:	85 c0                	test   %eax,%eax
    1922:	0f 88 c2 00 00 00    	js     19ea <linkunlink+0xf6>
  unsigned int x = (pid ? 1 : 97);
    1928:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    192c:	19 ff                	sbb    %edi,%edi
    192e:	83 e7 60             	and    $0x60,%edi
    1931:	47                   	inc    %edi
    1932:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1937:	be 03 00 00 00       	mov    $0x3,%esi
    193c:	eb 1c                	jmp    195a <linkunlink+0x66>
    193e:	66 90                	xchg   %ax,%ax
    } else if((x % 3) == 1){
    1940:	4a                   	dec    %edx
    1941:	0f 84 89 00 00 00    	je     19d0 <linkunlink+0xdc>
      unlink("x");
    1947:	83 ec 0c             	sub    $0xc,%esp
    194a:	68 d5 42 00 00       	push   $0x42d5
    194f:	e8 6b 1c 00 00       	call   35bf <unlink>
    1954:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1957:	4b                   	dec    %ebx
    1958:	74 52                	je     19ac <linkunlink+0xb8>
    x = x * 1103515245 + 12345;
    195a:	89 f8                	mov    %edi,%eax
    195c:	c1 e0 09             	shl    $0x9,%eax
    195f:	29 f8                	sub    %edi,%eax
    1961:	8d 14 87             	lea    (%edi,%eax,4),%edx
    1964:	89 d0                	mov    %edx,%eax
    1966:	c1 e0 09             	shl    $0x9,%eax
    1969:	29 d0                	sub    %edx,%eax
    196b:	01 c0                	add    %eax,%eax
    196d:	01 f8                	add    %edi,%eax
    196f:	89 c2                	mov    %eax,%edx
    1971:	c1 e2 05             	shl    $0x5,%edx
    1974:	01 d0                	add    %edx,%eax
    1976:	c1 e0 02             	shl    $0x2,%eax
    1979:	29 f8                	sub    %edi,%eax
    197b:	8d bc 87 39 30 00 00 	lea    0x3039(%edi,%eax,4),%edi
    if((x % 3) == 0){
    1982:	89 f8                	mov    %edi,%eax
    1984:	31 d2                	xor    %edx,%edx
    1986:	f7 f6                	div    %esi
    1988:	85 d2                	test   %edx,%edx
    198a:	75 b4                	jne    1940 <linkunlink+0x4c>
      close(open("x", O_RDWR | O_CREATE));
    198c:	83 ec 08             	sub    $0x8,%esp
    198f:	68 02 02 00 00       	push   $0x202
    1994:	68 d5 42 00 00       	push   $0x42d5
    1999:	e8 11 1c 00 00       	call   35af <open>
    199e:	89 04 24             	mov    %eax,(%esp)
    19a1:	e8 f1 1b 00 00       	call   3597 <close>
    19a6:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    19a9:	4b                   	dec    %ebx
    19aa:	75 ae                	jne    195a <linkunlink+0x66>
  if(pid)
    19ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19af:	85 c0                	test   %eax,%eax
    19b1:	74 4a                	je     19fd <linkunlink+0x109>
    wait();
    19b3:	e8 bf 1b 00 00       	call   3577 <wait>
  printf(1, "linkunlink ok\n");
    19b8:	83 ec 08             	sub    $0x8,%esp
    19bb:	68 5d 40 00 00       	push   $0x405d
    19c0:	6a 01                	push   $0x1
    19c2:	e8 d1 1c 00 00       	call   3698 <printf>
}
    19c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19ca:	5b                   	pop    %ebx
    19cb:	5e                   	pop    %esi
    19cc:	5f                   	pop    %edi
    19cd:	5d                   	pop    %ebp
    19ce:	c3                   	ret    
    19cf:	90                   	nop
      link("cat", "x");
    19d0:	83 ec 08             	sub    $0x8,%esp
    19d3:	68 d5 42 00 00       	push   $0x42d5
    19d8:	68 59 40 00 00       	push   $0x4059
    19dd:	e8 ed 1b 00 00       	call   35cf <link>
    19e2:	83 c4 10             	add    $0x10,%esp
    19e5:	e9 6d ff ff ff       	jmp    1957 <linkunlink+0x63>
    printf(1, "fork failed\n");
    19ea:	52                   	push   %edx
    19eb:	52                   	push   %edx
    19ec:	68 bd 48 00 00       	push   $0x48bd
    19f1:	6a 01                	push   $0x1
    19f3:	e8 a0 1c 00 00       	call   3698 <printf>
    exit();
    19f8:	e8 72 1b 00 00       	call   356f <exit>
    exit();
    19fd:	e8 6d 1b 00 00       	call   356f <exit>
    1a02:	66 90                	xchg   %ax,%ax

00001a04 <bigdir>:
{
    1a04:	55                   	push   %ebp
    1a05:	89 e5                	mov    %esp,%ebp
    1a07:	57                   	push   %edi
    1a08:	56                   	push   %esi
    1a09:	53                   	push   %ebx
    1a0a:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
    1a0d:	68 6c 40 00 00       	push   $0x406c
    1a12:	6a 01                	push   $0x1
    1a14:	e8 7f 1c 00 00       	call   3698 <printf>
  unlink("bd");
    1a19:	c7 04 24 79 40 00 00 	movl   $0x4079,(%esp)
    1a20:	e8 9a 1b 00 00       	call   35bf <unlink>
  fd = open("bd", O_CREATE);
    1a25:	5a                   	pop    %edx
    1a26:	59                   	pop    %ecx
    1a27:	68 00 02 00 00       	push   $0x200
    1a2c:	68 79 40 00 00       	push   $0x4079
    1a31:	e8 79 1b 00 00       	call   35af <open>
  if(fd < 0){
    1a36:	83 c4 10             	add    $0x10,%esp
    1a39:	85 c0                	test   %eax,%eax
    1a3b:	0f 88 dc 00 00 00    	js     1b1d <bigdir+0x119>
  close(fd);
    1a41:	83 ec 0c             	sub    $0xc,%esp
    1a44:	50                   	push   %eax
    1a45:	e8 4d 1b 00 00       	call   3597 <close>
    1a4a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1a4d:	31 f6                	xor    %esi,%esi
    1a4f:	8d 7d de             	lea    -0x22(%ebp),%edi
    1a52:	66 90                	xchg   %ax,%ax
    name[0] = 'x';
    1a54:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1a58:	89 f0                	mov    %esi,%eax
    1a5a:	c1 f8 06             	sar    $0x6,%eax
    1a5d:	83 c0 30             	add    $0x30,%eax
    1a60:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1a63:	89 f0                	mov    %esi,%eax
    1a65:	83 e0 3f             	and    $0x3f,%eax
    1a68:	83 c0 30             	add    $0x30,%eax
    1a6b:	88 45 e0             	mov    %al,-0x20(%ebp)
    name[3] = '\0';
    1a6e:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    if(link("bd", name) != 0){
    1a72:	83 ec 08             	sub    $0x8,%esp
    1a75:	57                   	push   %edi
    1a76:	68 79 40 00 00       	push   $0x4079
    1a7b:	e8 4f 1b 00 00       	call   35cf <link>
    1a80:	89 c3                	mov    %eax,%ebx
    1a82:	83 c4 10             	add    $0x10,%esp
    1a85:	85 c0                	test   %eax,%eax
    1a87:	75 6c                	jne    1af5 <bigdir+0xf1>
  for(i = 0; i < 500; i++){
    1a89:	46                   	inc    %esi
    1a8a:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1a90:	75 c2                	jne    1a54 <bigdir+0x50>
  unlink("bd");
    1a92:	83 ec 0c             	sub    $0xc,%esp
    1a95:	68 79 40 00 00       	push   $0x4079
    1a9a:	e8 20 1b 00 00       	call   35bf <unlink>
    1a9f:	83 c4 10             	add    $0x10,%esp
    1aa2:	66 90                	xchg   %ax,%ax
    name[0] = 'x';
    1aa4:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1aa8:	89 d8                	mov    %ebx,%eax
    1aaa:	c1 f8 06             	sar    $0x6,%eax
    1aad:	83 c0 30             	add    $0x30,%eax
    1ab0:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1ab3:	89 d8                	mov    %ebx,%eax
    1ab5:	83 e0 3f             	and    $0x3f,%eax
    1ab8:	83 c0 30             	add    $0x30,%eax
    1abb:	88 45 e0             	mov    %al,-0x20(%ebp)
    name[3] = '\0';
    1abe:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    if(unlink(name) != 0){
    1ac2:	83 ec 0c             	sub    $0xc,%esp
    1ac5:	57                   	push   %edi
    1ac6:	e8 f4 1a 00 00       	call   35bf <unlink>
    1acb:	83 c4 10             	add    $0x10,%esp
    1ace:	85 c0                	test   %eax,%eax
    1ad0:	75 37                	jne    1b09 <bigdir+0x105>
  for(i = 0; i < 500; i++){
    1ad2:	43                   	inc    %ebx
    1ad3:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1ad9:	75 c9                	jne    1aa4 <bigdir+0xa0>
  printf(1, "bigdir ok\n");
    1adb:	83 ec 08             	sub    $0x8,%esp
    1ade:	68 bb 40 00 00       	push   $0x40bb
    1ae3:	6a 01                	push   $0x1
    1ae5:	e8 ae 1b 00 00       	call   3698 <printf>
    1aea:	83 c4 10             	add    $0x10,%esp
}
    1aed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1af0:	5b                   	pop    %ebx
    1af1:	5e                   	pop    %esi
    1af2:	5f                   	pop    %edi
    1af3:	5d                   	pop    %ebp
    1af4:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    1af5:	83 ec 08             	sub    $0x8,%esp
    1af8:	68 92 40 00 00       	push   $0x4092
    1afd:	6a 01                	push   $0x1
    1aff:	e8 94 1b 00 00       	call   3698 <printf>
      exit();
    1b04:	e8 66 1a 00 00       	call   356f <exit>
      printf(1, "bigdir unlink failed");
    1b09:	83 ec 08             	sub    $0x8,%esp
    1b0c:	68 a6 40 00 00       	push   $0x40a6
    1b11:	6a 01                	push   $0x1
    1b13:	e8 80 1b 00 00       	call   3698 <printf>
      exit();
    1b18:	e8 52 1a 00 00       	call   356f <exit>
    printf(1, "bigdir create failed\n");
    1b1d:	50                   	push   %eax
    1b1e:	50                   	push   %eax
    1b1f:	68 7c 40 00 00       	push   $0x407c
    1b24:	6a 01                	push   $0x1
    1b26:	e8 6d 1b 00 00       	call   3698 <printf>
    exit();
    1b2b:	e8 3f 1a 00 00       	call   356f <exit>

00001b30 <subdir>:
{
    1b30:	55                   	push   %ebp
    1b31:	89 e5                	mov    %esp,%ebp
    1b33:	53                   	push   %ebx
    1b34:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
    1b37:	68 c6 40 00 00       	push   $0x40c6
    1b3c:	6a 01                	push   $0x1
    1b3e:	e8 55 1b 00 00       	call   3698 <printf>
  unlink("ff");
    1b43:	c7 04 24 4f 41 00 00 	movl   $0x414f,(%esp)
    1b4a:	e8 70 1a 00 00       	call   35bf <unlink>
  if(mkdir("dd") != 0){
    1b4f:	c7 04 24 ec 41 00 00 	movl   $0x41ec,(%esp)
    1b56:	e8 7c 1a 00 00       	call   35d7 <mkdir>
    1b5b:	83 c4 10             	add    $0x10,%esp
    1b5e:	85 c0                	test   %eax,%eax
    1b60:	0f 85 ab 05 00 00    	jne    2111 <subdir+0x5e1>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1b66:	83 ec 08             	sub    $0x8,%esp
    1b69:	68 02 02 00 00       	push   $0x202
    1b6e:	68 25 41 00 00       	push   $0x4125
    1b73:	e8 37 1a 00 00       	call   35af <open>
    1b78:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1b7a:	83 c4 10             	add    $0x10,%esp
    1b7d:	85 c0                	test   %eax,%eax
    1b7f:	0f 88 79 05 00 00    	js     20fe <subdir+0x5ce>
  write(fd, "ff", 2);
    1b85:	50                   	push   %eax
    1b86:	6a 02                	push   $0x2
    1b88:	68 4f 41 00 00       	push   $0x414f
    1b8d:	53                   	push   %ebx
    1b8e:	e8 fc 19 00 00       	call   358f <write>
  close(fd);
    1b93:	89 1c 24             	mov    %ebx,(%esp)
    1b96:	e8 fc 19 00 00       	call   3597 <close>
  if(unlink("dd") >= 0){
    1b9b:	c7 04 24 ec 41 00 00 	movl   $0x41ec,(%esp)
    1ba2:	e8 18 1a 00 00       	call   35bf <unlink>
    1ba7:	83 c4 10             	add    $0x10,%esp
    1baa:	85 c0                	test   %eax,%eax
    1bac:	0f 89 39 05 00 00    	jns    20eb <subdir+0x5bb>
  if(mkdir("/dd/dd") != 0){
    1bb2:	83 ec 0c             	sub    $0xc,%esp
    1bb5:	68 00 41 00 00       	push   $0x4100
    1bba:	e8 18 1a 00 00       	call   35d7 <mkdir>
    1bbf:	83 c4 10             	add    $0x10,%esp
    1bc2:	85 c0                	test   %eax,%eax
    1bc4:	0f 85 0e 05 00 00    	jne    20d8 <subdir+0x5a8>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1bca:	83 ec 08             	sub    $0x8,%esp
    1bcd:	68 02 02 00 00       	push   $0x202
    1bd2:	68 22 41 00 00       	push   $0x4122
    1bd7:	e8 d3 19 00 00       	call   35af <open>
    1bdc:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1bde:	83 c4 10             	add    $0x10,%esp
    1be1:	85 c0                	test   %eax,%eax
    1be3:	0f 88 1e 04 00 00    	js     2007 <subdir+0x4d7>
  write(fd, "FF", 2);
    1be9:	50                   	push   %eax
    1bea:	6a 02                	push   $0x2
    1bec:	68 43 41 00 00       	push   $0x4143
    1bf1:	53                   	push   %ebx
    1bf2:	e8 98 19 00 00       	call   358f <write>
  close(fd);
    1bf7:	89 1c 24             	mov    %ebx,(%esp)
    1bfa:	e8 98 19 00 00       	call   3597 <close>
  fd = open("dd/dd/../ff", 0);
    1bff:	58                   	pop    %eax
    1c00:	5a                   	pop    %edx
    1c01:	6a 00                	push   $0x0
    1c03:	68 46 41 00 00       	push   $0x4146
    1c08:	e8 a2 19 00 00       	call   35af <open>
    1c0d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1c0f:	83 c4 10             	add    $0x10,%esp
    1c12:	85 c0                	test   %eax,%eax
    1c14:	0f 88 da 03 00 00    	js     1ff4 <subdir+0x4c4>
  cc = read(fd, buf, sizeof(buf));
    1c1a:	50                   	push   %eax
    1c1b:	68 00 20 00 00       	push   $0x2000
    1c20:	68 e0 78 00 00       	push   $0x78e0
    1c25:	53                   	push   %ebx
    1c26:	e8 5c 19 00 00       	call   3587 <read>
  if(cc != 2 || buf[0] != 'f'){
    1c2b:	83 c4 10             	add    $0x10,%esp
    1c2e:	83 f8 02             	cmp    $0x2,%eax
    1c31:	0f 85 38 03 00 00    	jne    1f6f <subdir+0x43f>
    1c37:	80 3d e0 78 00 00 66 	cmpb   $0x66,0x78e0
    1c3e:	0f 85 2b 03 00 00    	jne    1f6f <subdir+0x43f>
  close(fd);
    1c44:	83 ec 0c             	sub    $0xc,%esp
    1c47:	53                   	push   %ebx
    1c48:	e8 4a 19 00 00       	call   3597 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1c4d:	58                   	pop    %eax
    1c4e:	5a                   	pop    %edx
    1c4f:	68 86 41 00 00       	push   $0x4186
    1c54:	68 22 41 00 00       	push   $0x4122
    1c59:	e8 71 19 00 00       	call   35cf <link>
    1c5e:	83 c4 10             	add    $0x10,%esp
    1c61:	85 c0                	test   %eax,%eax
    1c63:	0f 85 c4 03 00 00    	jne    202d <subdir+0x4fd>
  if(unlink("dd/dd/ff") != 0){
    1c69:	83 ec 0c             	sub    $0xc,%esp
    1c6c:	68 22 41 00 00       	push   $0x4122
    1c71:	e8 49 19 00 00       	call   35bf <unlink>
    1c76:	83 c4 10             	add    $0x10,%esp
    1c79:	85 c0                	test   %eax,%eax
    1c7b:	0f 85 14 03 00 00    	jne    1f95 <subdir+0x465>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1c81:	83 ec 08             	sub    $0x8,%esp
    1c84:	6a 00                	push   $0x0
    1c86:	68 22 41 00 00       	push   $0x4122
    1c8b:	e8 1f 19 00 00       	call   35af <open>
    1c90:	83 c4 10             	add    $0x10,%esp
    1c93:	85 c0                	test   %eax,%eax
    1c95:	0f 89 2a 04 00 00    	jns    20c5 <subdir+0x595>
  if(chdir("dd") != 0){
    1c9b:	83 ec 0c             	sub    $0xc,%esp
    1c9e:	68 ec 41 00 00       	push   $0x41ec
    1ca3:	e8 37 19 00 00       	call   35df <chdir>
    1ca8:	83 c4 10             	add    $0x10,%esp
    1cab:	85 c0                	test   %eax,%eax
    1cad:	0f 85 ff 03 00 00    	jne    20b2 <subdir+0x582>
  if(chdir("dd/../../dd") != 0){
    1cb3:	83 ec 0c             	sub    $0xc,%esp
    1cb6:	68 ba 41 00 00       	push   $0x41ba
    1cbb:	e8 1f 19 00 00       	call   35df <chdir>
    1cc0:	83 c4 10             	add    $0x10,%esp
    1cc3:	85 c0                	test   %eax,%eax
    1cc5:	0f 85 b7 02 00 00    	jne    1f82 <subdir+0x452>
  if(chdir("dd/../../../dd") != 0){
    1ccb:	83 ec 0c             	sub    $0xc,%esp
    1cce:	68 e0 41 00 00       	push   $0x41e0
    1cd3:	e8 07 19 00 00       	call   35df <chdir>
    1cd8:	83 c4 10             	add    $0x10,%esp
    1cdb:	85 c0                	test   %eax,%eax
    1cdd:	0f 85 9f 02 00 00    	jne    1f82 <subdir+0x452>
  if(chdir("./..") != 0){
    1ce3:	83 ec 0c             	sub    $0xc,%esp
    1ce6:	68 ef 41 00 00       	push   $0x41ef
    1ceb:	e8 ef 18 00 00       	call   35df <chdir>
    1cf0:	83 c4 10             	add    $0x10,%esp
    1cf3:	85 c0                	test   %eax,%eax
    1cf5:	0f 85 1f 03 00 00    	jne    201a <subdir+0x4ea>
  fd = open("dd/dd/ffff", 0);
    1cfb:	83 ec 08             	sub    $0x8,%esp
    1cfe:	6a 00                	push   $0x0
    1d00:	68 86 41 00 00       	push   $0x4186
    1d05:	e8 a5 18 00 00       	call   35af <open>
    1d0a:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d0c:	83 c4 10             	add    $0x10,%esp
    1d0f:	85 c0                	test   %eax,%eax
    1d11:	0f 88 de 04 00 00    	js     21f5 <subdir+0x6c5>
  if(read(fd, buf, sizeof(buf)) != 2){
    1d17:	50                   	push   %eax
    1d18:	68 00 20 00 00       	push   $0x2000
    1d1d:	68 e0 78 00 00       	push   $0x78e0
    1d22:	53                   	push   %ebx
    1d23:	e8 5f 18 00 00       	call   3587 <read>
    1d28:	83 c4 10             	add    $0x10,%esp
    1d2b:	83 f8 02             	cmp    $0x2,%eax
    1d2e:	0f 85 ae 04 00 00    	jne    21e2 <subdir+0x6b2>
  close(fd);
    1d34:	83 ec 0c             	sub    $0xc,%esp
    1d37:	53                   	push   %ebx
    1d38:	e8 5a 18 00 00       	call   3597 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1d3d:	58                   	pop    %eax
    1d3e:	5a                   	pop    %edx
    1d3f:	6a 00                	push   $0x0
    1d41:	68 22 41 00 00       	push   $0x4122
    1d46:	e8 64 18 00 00       	call   35af <open>
    1d4b:	83 c4 10             	add    $0x10,%esp
    1d4e:	85 c0                	test   %eax,%eax
    1d50:	0f 89 65 02 00 00    	jns    1fbb <subdir+0x48b>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1d56:	83 ec 08             	sub    $0x8,%esp
    1d59:	68 02 02 00 00       	push   $0x202
    1d5e:	68 3a 42 00 00       	push   $0x423a
    1d63:	e8 47 18 00 00       	call   35af <open>
    1d68:	83 c4 10             	add    $0x10,%esp
    1d6b:	85 c0                	test   %eax,%eax
    1d6d:	0f 89 35 02 00 00    	jns    1fa8 <subdir+0x478>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1d73:	83 ec 08             	sub    $0x8,%esp
    1d76:	68 02 02 00 00       	push   $0x202
    1d7b:	68 5f 42 00 00       	push   $0x425f
    1d80:	e8 2a 18 00 00       	call   35af <open>
    1d85:	83 c4 10             	add    $0x10,%esp
    1d88:	85 c0                	test   %eax,%eax
    1d8a:	0f 89 0f 03 00 00    	jns    209f <subdir+0x56f>
  if(open("dd", O_CREATE) >= 0){
    1d90:	83 ec 08             	sub    $0x8,%esp
    1d93:	68 00 02 00 00       	push   $0x200
    1d98:	68 ec 41 00 00       	push   $0x41ec
    1d9d:	e8 0d 18 00 00       	call   35af <open>
    1da2:	83 c4 10             	add    $0x10,%esp
    1da5:	85 c0                	test   %eax,%eax
    1da7:	0f 89 df 02 00 00    	jns    208c <subdir+0x55c>
  if(open("dd", O_RDWR) >= 0){
    1dad:	83 ec 08             	sub    $0x8,%esp
    1db0:	6a 02                	push   $0x2
    1db2:	68 ec 41 00 00       	push   $0x41ec
    1db7:	e8 f3 17 00 00       	call   35af <open>
    1dbc:	83 c4 10             	add    $0x10,%esp
    1dbf:	85 c0                	test   %eax,%eax
    1dc1:	0f 89 b2 02 00 00    	jns    2079 <subdir+0x549>
  if(open("dd", O_WRONLY) >= 0){
    1dc7:	83 ec 08             	sub    $0x8,%esp
    1dca:	6a 01                	push   $0x1
    1dcc:	68 ec 41 00 00       	push   $0x41ec
    1dd1:	e8 d9 17 00 00       	call   35af <open>
    1dd6:	83 c4 10             	add    $0x10,%esp
    1dd9:	85 c0                	test   %eax,%eax
    1ddb:	0f 89 85 02 00 00    	jns    2066 <subdir+0x536>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1de1:	83 ec 08             	sub    $0x8,%esp
    1de4:	68 ce 42 00 00       	push   $0x42ce
    1de9:	68 3a 42 00 00       	push   $0x423a
    1dee:	e8 dc 17 00 00       	call   35cf <link>
    1df3:	83 c4 10             	add    $0x10,%esp
    1df6:	85 c0                	test   %eax,%eax
    1df8:	0f 84 55 02 00 00    	je     2053 <subdir+0x523>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1dfe:	83 ec 08             	sub    $0x8,%esp
    1e01:	68 ce 42 00 00       	push   $0x42ce
    1e06:	68 5f 42 00 00       	push   $0x425f
    1e0b:	e8 bf 17 00 00       	call   35cf <link>
    1e10:	83 c4 10             	add    $0x10,%esp
    1e13:	85 c0                	test   %eax,%eax
    1e15:	0f 84 25 02 00 00    	je     2040 <subdir+0x510>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1e1b:	83 ec 08             	sub    $0x8,%esp
    1e1e:	68 86 41 00 00       	push   $0x4186
    1e23:	68 25 41 00 00       	push   $0x4125
    1e28:	e8 a2 17 00 00       	call   35cf <link>
    1e2d:	83 c4 10             	add    $0x10,%esp
    1e30:	85 c0                	test   %eax,%eax
    1e32:	0f 84 a9 01 00 00    	je     1fe1 <subdir+0x4b1>
  if(mkdir("dd/ff/ff") == 0){
    1e38:	83 ec 0c             	sub    $0xc,%esp
    1e3b:	68 3a 42 00 00       	push   $0x423a
    1e40:	e8 92 17 00 00       	call   35d7 <mkdir>
    1e45:	83 c4 10             	add    $0x10,%esp
    1e48:	85 c0                	test   %eax,%eax
    1e4a:	0f 84 7e 01 00 00    	je     1fce <subdir+0x49e>
  if(mkdir("dd/xx/ff") == 0){
    1e50:	83 ec 0c             	sub    $0xc,%esp
    1e53:	68 5f 42 00 00       	push   $0x425f
    1e58:	e8 7a 17 00 00       	call   35d7 <mkdir>
    1e5d:	83 c4 10             	add    $0x10,%esp
    1e60:	85 c0                	test   %eax,%eax
    1e62:	0f 84 67 03 00 00    	je     21cf <subdir+0x69f>
  if(mkdir("dd/dd/ffff") == 0){
    1e68:	83 ec 0c             	sub    $0xc,%esp
    1e6b:	68 86 41 00 00       	push   $0x4186
    1e70:	e8 62 17 00 00       	call   35d7 <mkdir>
    1e75:	83 c4 10             	add    $0x10,%esp
    1e78:	85 c0                	test   %eax,%eax
    1e7a:	0f 84 3c 03 00 00    	je     21bc <subdir+0x68c>
  if(unlink("dd/xx/ff") == 0){
    1e80:	83 ec 0c             	sub    $0xc,%esp
    1e83:	68 5f 42 00 00       	push   $0x425f
    1e88:	e8 32 17 00 00       	call   35bf <unlink>
    1e8d:	83 c4 10             	add    $0x10,%esp
    1e90:	85 c0                	test   %eax,%eax
    1e92:	0f 84 11 03 00 00    	je     21a9 <subdir+0x679>
  if(unlink("dd/ff/ff") == 0){
    1e98:	83 ec 0c             	sub    $0xc,%esp
    1e9b:	68 3a 42 00 00       	push   $0x423a
    1ea0:	e8 1a 17 00 00       	call   35bf <unlink>
    1ea5:	83 c4 10             	add    $0x10,%esp
    1ea8:	85 c0                	test   %eax,%eax
    1eaa:	0f 84 e6 02 00 00    	je     2196 <subdir+0x666>
  if(chdir("dd/ff") == 0){
    1eb0:	83 ec 0c             	sub    $0xc,%esp
    1eb3:	68 25 41 00 00       	push   $0x4125
    1eb8:	e8 22 17 00 00       	call   35df <chdir>
    1ebd:	83 c4 10             	add    $0x10,%esp
    1ec0:	85 c0                	test   %eax,%eax
    1ec2:	0f 84 bb 02 00 00    	je     2183 <subdir+0x653>
  if(chdir("dd/xx") == 0){
    1ec8:	83 ec 0c             	sub    $0xc,%esp
    1ecb:	68 d1 42 00 00       	push   $0x42d1
    1ed0:	e8 0a 17 00 00       	call   35df <chdir>
    1ed5:	83 c4 10             	add    $0x10,%esp
    1ed8:	85 c0                	test   %eax,%eax
    1eda:	0f 84 90 02 00 00    	je     2170 <subdir+0x640>
  if(unlink("dd/dd/ffff") != 0){
    1ee0:	83 ec 0c             	sub    $0xc,%esp
    1ee3:	68 86 41 00 00       	push   $0x4186
    1ee8:	e8 d2 16 00 00       	call   35bf <unlink>
    1eed:	83 c4 10             	add    $0x10,%esp
    1ef0:	85 c0                	test   %eax,%eax
    1ef2:	0f 85 9d 00 00 00    	jne    1f95 <subdir+0x465>
  if(unlink("dd/ff") != 0){
    1ef8:	83 ec 0c             	sub    $0xc,%esp
    1efb:	68 25 41 00 00       	push   $0x4125
    1f00:	e8 ba 16 00 00       	call   35bf <unlink>
    1f05:	83 c4 10             	add    $0x10,%esp
    1f08:	85 c0                	test   %eax,%eax
    1f0a:	0f 85 4d 02 00 00    	jne    215d <subdir+0x62d>
  if(unlink("dd") == 0){
    1f10:	83 ec 0c             	sub    $0xc,%esp
    1f13:	68 ec 41 00 00       	push   $0x41ec
    1f18:	e8 a2 16 00 00       	call   35bf <unlink>
    1f1d:	83 c4 10             	add    $0x10,%esp
    1f20:	85 c0                	test   %eax,%eax
    1f22:	0f 84 22 02 00 00    	je     214a <subdir+0x61a>
  if(unlink("dd/dd") < 0){
    1f28:	83 ec 0c             	sub    $0xc,%esp
    1f2b:	68 01 41 00 00       	push   $0x4101
    1f30:	e8 8a 16 00 00       	call   35bf <unlink>
    1f35:	83 c4 10             	add    $0x10,%esp
    1f38:	85 c0                	test   %eax,%eax
    1f3a:	0f 88 f7 01 00 00    	js     2137 <subdir+0x607>
  if(unlink("dd") < 0){
    1f40:	83 ec 0c             	sub    $0xc,%esp
    1f43:	68 ec 41 00 00       	push   $0x41ec
    1f48:	e8 72 16 00 00       	call   35bf <unlink>
    1f4d:	83 c4 10             	add    $0x10,%esp
    1f50:	85 c0                	test   %eax,%eax
    1f52:	0f 88 cc 01 00 00    	js     2124 <subdir+0x5f4>
  printf(1, "subdir ok\n");
    1f58:	83 ec 08             	sub    $0x8,%esp
    1f5b:	68 ce 43 00 00       	push   $0x43ce
    1f60:	6a 01                	push   $0x1
    1f62:	e8 31 17 00 00       	call   3698 <printf>
}
    1f67:	83 c4 10             	add    $0x10,%esp
    1f6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1f6d:	c9                   	leave  
    1f6e:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    1f6f:	51                   	push   %ecx
    1f70:	51                   	push   %ecx
    1f71:	68 6b 41 00 00       	push   $0x416b
    1f76:	6a 01                	push   $0x1
    1f78:	e8 1b 17 00 00       	call   3698 <printf>
    exit();
    1f7d:	e8 ed 15 00 00       	call   356f <exit>
    printf(1, "chdir dd/../../dd failed\n");
    1f82:	50                   	push   %eax
    1f83:	50                   	push   %eax
    1f84:	68 c6 41 00 00       	push   $0x41c6
    1f89:	6a 01                	push   $0x1
    1f8b:	e8 08 17 00 00       	call   3698 <printf>
    exit();
    1f90:	e8 da 15 00 00       	call   356f <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    1f95:	51                   	push   %ecx
    1f96:	51                   	push   %ecx
    1f97:	68 91 41 00 00       	push   $0x4191
    1f9c:	6a 01                	push   $0x1
    1f9e:	e8 f5 16 00 00       	call   3698 <printf>
    exit();
    1fa3:	e8 c7 15 00 00       	call   356f <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    1fa8:	51                   	push   %ecx
    1fa9:	51                   	push   %ecx
    1faa:	68 43 42 00 00       	push   $0x4243
    1faf:	6a 01                	push   $0x1
    1fb1:	e8 e2 16 00 00       	call   3698 <printf>
    exit();
    1fb6:	e8 b4 15 00 00       	call   356f <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    1fbb:	53                   	push   %ebx
    1fbc:	53                   	push   %ebx
    1fbd:	68 28 4c 00 00       	push   $0x4c28
    1fc2:	6a 01                	push   $0x1
    1fc4:	e8 cf 16 00 00       	call   3698 <printf>
    exit();
    1fc9:	e8 a1 15 00 00       	call   356f <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    1fce:	51                   	push   %ecx
    1fcf:	51                   	push   %ecx
    1fd0:	68 d7 42 00 00       	push   $0x42d7
    1fd5:	6a 01                	push   $0x1
    1fd7:	e8 bc 16 00 00       	call   3698 <printf>
    exit();
    1fdc:	e8 8e 15 00 00       	call   356f <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    1fe1:	53                   	push   %ebx
    1fe2:	53                   	push   %ebx
    1fe3:	68 98 4c 00 00       	push   $0x4c98
    1fe8:	6a 01                	push   $0x1
    1fea:	e8 a9 16 00 00       	call   3698 <printf>
    exit();
    1fef:	e8 7b 15 00 00       	call   356f <exit>
    printf(1, "open dd/dd/../ff failed\n");
    1ff4:	50                   	push   %eax
    1ff5:	50                   	push   %eax
    1ff6:	68 52 41 00 00       	push   $0x4152
    1ffb:	6a 01                	push   $0x1
    1ffd:	e8 96 16 00 00       	call   3698 <printf>
    exit();
    2002:	e8 68 15 00 00       	call   356f <exit>
    printf(1, "create dd/dd/ff failed\n");
    2007:	51                   	push   %ecx
    2008:	51                   	push   %ecx
    2009:	68 2b 41 00 00       	push   $0x412b
    200e:	6a 01                	push   $0x1
    2010:	e8 83 16 00 00       	call   3698 <printf>
    exit();
    2015:	e8 55 15 00 00       	call   356f <exit>
    printf(1, "chdir ./.. failed\n");
    201a:	50                   	push   %eax
    201b:	50                   	push   %eax
    201c:	68 f4 41 00 00       	push   $0x41f4
    2021:	6a 01                	push   $0x1
    2023:	e8 70 16 00 00       	call   3698 <printf>
    exit();
    2028:	e8 42 15 00 00       	call   356f <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    202d:	53                   	push   %ebx
    202e:	53                   	push   %ebx
    202f:	68 e0 4b 00 00       	push   $0x4be0
    2034:	6a 01                	push   $0x1
    2036:	e8 5d 16 00 00       	call   3698 <printf>
    exit();
    203b:	e8 2f 15 00 00       	call   356f <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2040:	50                   	push   %eax
    2041:	50                   	push   %eax
    2042:	68 74 4c 00 00       	push   $0x4c74
    2047:	6a 01                	push   $0x1
    2049:	e8 4a 16 00 00       	call   3698 <printf>
    exit();
    204e:	e8 1c 15 00 00       	call   356f <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2053:	50                   	push   %eax
    2054:	50                   	push   %eax
    2055:	68 50 4c 00 00       	push   $0x4c50
    205a:	6a 01                	push   $0x1
    205c:	e8 37 16 00 00       	call   3698 <printf>
    exit();
    2061:	e8 09 15 00 00       	call   356f <exit>
    printf(1, "open dd wronly succeeded!\n");
    2066:	50                   	push   %eax
    2067:	50                   	push   %eax
    2068:	68 b3 42 00 00       	push   $0x42b3
    206d:	6a 01                	push   $0x1
    206f:	e8 24 16 00 00       	call   3698 <printf>
    exit();
    2074:	e8 f6 14 00 00       	call   356f <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2079:	50                   	push   %eax
    207a:	50                   	push   %eax
    207b:	68 9a 42 00 00       	push   $0x429a
    2080:	6a 01                	push   $0x1
    2082:	e8 11 16 00 00       	call   3698 <printf>
    exit();
    2087:	e8 e3 14 00 00       	call   356f <exit>
    printf(1, "create dd succeeded!\n");
    208c:	50                   	push   %eax
    208d:	50                   	push   %eax
    208e:	68 84 42 00 00       	push   $0x4284
    2093:	6a 01                	push   $0x1
    2095:	e8 fe 15 00 00       	call   3698 <printf>
    exit();
    209a:	e8 d0 14 00 00       	call   356f <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    209f:	52                   	push   %edx
    20a0:	52                   	push   %edx
    20a1:	68 68 42 00 00       	push   $0x4268
    20a6:	6a 01                	push   $0x1
    20a8:	e8 eb 15 00 00       	call   3698 <printf>
    exit();
    20ad:	e8 bd 14 00 00       	call   356f <exit>
    printf(1, "chdir dd failed\n");
    20b2:	50                   	push   %eax
    20b3:	50                   	push   %eax
    20b4:	68 a9 41 00 00       	push   $0x41a9
    20b9:	6a 01                	push   $0x1
    20bb:	e8 d8 15 00 00       	call   3698 <printf>
    exit();
    20c0:	e8 aa 14 00 00       	call   356f <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    20c5:	52                   	push   %edx
    20c6:	52                   	push   %edx
    20c7:	68 04 4c 00 00       	push   $0x4c04
    20cc:	6a 01                	push   $0x1
    20ce:	e8 c5 15 00 00       	call   3698 <printf>
    exit();
    20d3:	e8 97 14 00 00       	call   356f <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    20d8:	53                   	push   %ebx
    20d9:	53                   	push   %ebx
    20da:	68 07 41 00 00       	push   $0x4107
    20df:	6a 01                	push   $0x1
    20e1:	e8 b2 15 00 00       	call   3698 <printf>
    exit();
    20e6:	e8 84 14 00 00       	call   356f <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    20eb:	50                   	push   %eax
    20ec:	50                   	push   %eax
    20ed:	68 b8 4b 00 00       	push   $0x4bb8
    20f2:	6a 01                	push   $0x1
    20f4:	e8 9f 15 00 00       	call   3698 <printf>
    exit();
    20f9:	e8 71 14 00 00       	call   356f <exit>
    printf(1, "create dd/ff failed\n");
    20fe:	50                   	push   %eax
    20ff:	50                   	push   %eax
    2100:	68 eb 40 00 00       	push   $0x40eb
    2105:	6a 01                	push   $0x1
    2107:	e8 8c 15 00 00       	call   3698 <printf>
    exit();
    210c:	e8 5e 14 00 00       	call   356f <exit>
    printf(1, "subdir mkdir dd failed\n");
    2111:	50                   	push   %eax
    2112:	50                   	push   %eax
    2113:	68 d3 40 00 00       	push   $0x40d3
    2118:	6a 01                	push   $0x1
    211a:	e8 79 15 00 00       	call   3698 <printf>
    exit();
    211f:	e8 4b 14 00 00       	call   356f <exit>
    printf(1, "unlink dd failed\n");
    2124:	50                   	push   %eax
    2125:	50                   	push   %eax
    2126:	68 bc 43 00 00       	push   $0x43bc
    212b:	6a 01                	push   $0x1
    212d:	e8 66 15 00 00       	call   3698 <printf>
    exit();
    2132:	e8 38 14 00 00       	call   356f <exit>
    printf(1, "unlink dd/dd failed\n");
    2137:	52                   	push   %edx
    2138:	52                   	push   %edx
    2139:	68 a7 43 00 00       	push   $0x43a7
    213e:	6a 01                	push   $0x1
    2140:	e8 53 15 00 00       	call   3698 <printf>
    exit();
    2145:	e8 25 14 00 00       	call   356f <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    214a:	51                   	push   %ecx
    214b:	51                   	push   %ecx
    214c:	68 bc 4c 00 00       	push   $0x4cbc
    2151:	6a 01                	push   $0x1
    2153:	e8 40 15 00 00       	call   3698 <printf>
    exit();
    2158:	e8 12 14 00 00       	call   356f <exit>
    printf(1, "unlink dd/ff failed\n");
    215d:	53                   	push   %ebx
    215e:	53                   	push   %ebx
    215f:	68 92 43 00 00       	push   $0x4392
    2164:	6a 01                	push   $0x1
    2166:	e8 2d 15 00 00       	call   3698 <printf>
    exit();
    216b:	e8 ff 13 00 00       	call   356f <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2170:	50                   	push   %eax
    2171:	50                   	push   %eax
    2172:	68 7a 43 00 00       	push   $0x437a
    2177:	6a 01                	push   $0x1
    2179:	e8 1a 15 00 00       	call   3698 <printf>
    exit();
    217e:	e8 ec 13 00 00       	call   356f <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    2183:	50                   	push   %eax
    2184:	50                   	push   %eax
    2185:	68 62 43 00 00       	push   $0x4362
    218a:	6a 01                	push   $0x1
    218c:	e8 07 15 00 00       	call   3698 <printf>
    exit();
    2191:	e8 d9 13 00 00       	call   356f <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2196:	50                   	push   %eax
    2197:	50                   	push   %eax
    2198:	68 46 43 00 00       	push   $0x4346
    219d:	6a 01                	push   $0x1
    219f:	e8 f4 14 00 00       	call   3698 <printf>
    exit();
    21a4:	e8 c6 13 00 00       	call   356f <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    21a9:	50                   	push   %eax
    21aa:	50                   	push   %eax
    21ab:	68 2a 43 00 00       	push   $0x432a
    21b0:	6a 01                	push   $0x1
    21b2:	e8 e1 14 00 00       	call   3698 <printf>
    exit();
    21b7:	e8 b3 13 00 00       	call   356f <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    21bc:	50                   	push   %eax
    21bd:	50                   	push   %eax
    21be:	68 0d 43 00 00       	push   $0x430d
    21c3:	6a 01                	push   $0x1
    21c5:	e8 ce 14 00 00       	call   3698 <printf>
    exit();
    21ca:	e8 a0 13 00 00       	call   356f <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    21cf:	52                   	push   %edx
    21d0:	52                   	push   %edx
    21d1:	68 f2 42 00 00       	push   $0x42f2
    21d6:	6a 01                	push   $0x1
    21d8:	e8 bb 14 00 00       	call   3698 <printf>
    exit();
    21dd:	e8 8d 13 00 00       	call   356f <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    21e2:	51                   	push   %ecx
    21e3:	51                   	push   %ecx
    21e4:	68 1f 42 00 00       	push   $0x421f
    21e9:	6a 01                	push   $0x1
    21eb:	e8 a8 14 00 00       	call   3698 <printf>
    exit();
    21f0:	e8 7a 13 00 00       	call   356f <exit>
    printf(1, "open dd/dd/ffff failed\n");
    21f5:	50                   	push   %eax
    21f6:	50                   	push   %eax
    21f7:	68 07 42 00 00       	push   $0x4207
    21fc:	6a 01                	push   $0x1
    21fe:	e8 95 14 00 00       	call   3698 <printf>
    exit();
    2203:	e8 67 13 00 00       	call   356f <exit>

00002208 <bigwrite>:
{
    2208:	55                   	push   %ebp
    2209:	89 e5                	mov    %esp,%ebp
    220b:	56                   	push   %esi
    220c:	53                   	push   %ebx
  printf(1, "bigwrite test\n");
    220d:	83 ec 08             	sub    $0x8,%esp
    2210:	68 d9 43 00 00       	push   $0x43d9
    2215:	6a 01                	push   $0x1
    2217:	e8 7c 14 00 00       	call   3698 <printf>
  unlink("bigwrite");
    221c:	c7 04 24 e8 43 00 00 	movl   $0x43e8,(%esp)
    2223:	e8 97 13 00 00       	call   35bf <unlink>
    2228:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    222b:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2230:	83 ec 08             	sub    $0x8,%esp
    2233:	68 02 02 00 00       	push   $0x202
    2238:	68 e8 43 00 00       	push   $0x43e8
    223d:	e8 6d 13 00 00       	call   35af <open>
    2242:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2244:	83 c4 10             	add    $0x10,%esp
    2247:	85 c0                	test   %eax,%eax
    2249:	78 7a                	js     22c5 <bigwrite+0xbd>
      int cc = write(fd, buf, sz);
    224b:	52                   	push   %edx
    224c:	53                   	push   %ebx
    224d:	68 e0 78 00 00       	push   $0x78e0
    2252:	50                   	push   %eax
    2253:	e8 37 13 00 00       	call   358f <write>
      if(cc != sz){
    2258:	83 c4 10             	add    $0x10,%esp
    225b:	39 d8                	cmp    %ebx,%eax
    225d:	75 53                	jne    22b2 <bigwrite+0xaa>
      int cc = write(fd, buf, sz);
    225f:	50                   	push   %eax
    2260:	53                   	push   %ebx
    2261:	68 e0 78 00 00       	push   $0x78e0
    2266:	56                   	push   %esi
    2267:	e8 23 13 00 00       	call   358f <write>
      if(cc != sz){
    226c:	83 c4 10             	add    $0x10,%esp
    226f:	39 d8                	cmp    %ebx,%eax
    2271:	75 3f                	jne    22b2 <bigwrite+0xaa>
    close(fd);
    2273:	83 ec 0c             	sub    $0xc,%esp
    2276:	56                   	push   %esi
    2277:	e8 1b 13 00 00       	call   3597 <close>
    unlink("bigwrite");
    227c:	c7 04 24 e8 43 00 00 	movl   $0x43e8,(%esp)
    2283:	e8 37 13 00 00       	call   35bf <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2288:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    228e:	83 c4 10             	add    $0x10,%esp
    2291:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    2297:	75 97                	jne    2230 <bigwrite+0x28>
  printf(1, "bigwrite ok\n");
    2299:	83 ec 08             	sub    $0x8,%esp
    229c:	68 1b 44 00 00       	push   $0x441b
    22a1:	6a 01                	push   $0x1
    22a3:	e8 f0 13 00 00       	call   3698 <printf>
}
    22a8:	83 c4 10             	add    $0x10,%esp
    22ab:	8d 65 f8             	lea    -0x8(%ebp),%esp
    22ae:	5b                   	pop    %ebx
    22af:	5e                   	pop    %esi
    22b0:	5d                   	pop    %ebp
    22b1:	c3                   	ret    
        printf(1, "write(%d) ret %d\n", sz, cc);
    22b2:	50                   	push   %eax
    22b3:	53                   	push   %ebx
    22b4:	68 09 44 00 00       	push   $0x4409
    22b9:	6a 01                	push   $0x1
    22bb:	e8 d8 13 00 00       	call   3698 <printf>
        exit();
    22c0:	e8 aa 12 00 00       	call   356f <exit>
      printf(1, "cannot create bigwrite\n");
    22c5:	83 ec 08             	sub    $0x8,%esp
    22c8:	68 f1 43 00 00       	push   $0x43f1
    22cd:	6a 01                	push   $0x1
    22cf:	e8 c4 13 00 00       	call   3698 <printf>
      exit();
    22d4:	e8 96 12 00 00       	call   356f <exit>
    22d9:	8d 76 00             	lea    0x0(%esi),%esi

000022dc <bigfile>:
{
    22dc:	55                   	push   %ebp
    22dd:	89 e5                	mov    %esp,%ebp
    22df:	57                   	push   %edi
    22e0:	56                   	push   %esi
    22e1:	53                   	push   %ebx
    22e2:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
    22e5:	68 28 44 00 00       	push   $0x4428
    22ea:	6a 01                	push   $0x1
    22ec:	e8 a7 13 00 00       	call   3698 <printf>
  unlink("bigfile");
    22f1:	c7 04 24 44 44 00 00 	movl   $0x4444,(%esp)
    22f8:	e8 c2 12 00 00       	call   35bf <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    22fd:	5e                   	pop    %esi
    22fe:	5f                   	pop    %edi
    22ff:	68 02 02 00 00       	push   $0x202
    2304:	68 44 44 00 00       	push   $0x4444
    2309:	e8 a1 12 00 00       	call   35af <open>
  if(fd < 0){
    230e:	83 c4 10             	add    $0x10,%esp
    2311:	85 c0                	test   %eax,%eax
    2313:	0f 88 52 01 00 00    	js     246b <bigfile+0x18f>
    2319:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    231b:	31 db                	xor    %ebx,%ebx
    231d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(buf, i, 600);
    2320:	51                   	push   %ecx
    2321:	68 58 02 00 00       	push   $0x258
    2326:	53                   	push   %ebx
    2327:	68 e0 78 00 00       	push   $0x78e0
    232c:	e8 f3 10 00 00       	call   3424 <memset>
    if(write(fd, buf, 600) != 600){
    2331:	83 c4 0c             	add    $0xc,%esp
    2334:	68 58 02 00 00       	push   $0x258
    2339:	68 e0 78 00 00       	push   $0x78e0
    233e:	56                   	push   %esi
    233f:	e8 4b 12 00 00       	call   358f <write>
    2344:	83 c4 10             	add    $0x10,%esp
    2347:	3d 58 02 00 00       	cmp    $0x258,%eax
    234c:	0f 85 f2 00 00 00    	jne    2444 <bigfile+0x168>
  for(i = 0; i < 20; i++){
    2352:	43                   	inc    %ebx
    2353:	83 fb 14             	cmp    $0x14,%ebx
    2356:	75 c8                	jne    2320 <bigfile+0x44>
  close(fd);
    2358:	83 ec 0c             	sub    $0xc,%esp
    235b:	56                   	push   %esi
    235c:	e8 36 12 00 00       	call   3597 <close>
  fd = open("bigfile", 0);
    2361:	58                   	pop    %eax
    2362:	5a                   	pop    %edx
    2363:	6a 00                	push   $0x0
    2365:	68 44 44 00 00       	push   $0x4444
    236a:	e8 40 12 00 00       	call   35af <open>
    236f:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2371:	83 c4 10             	add    $0x10,%esp
    2374:	85 c0                	test   %eax,%eax
    2376:	0f 88 dc 00 00 00    	js     2458 <bigfile+0x17c>
  total = 0;
    237c:	31 f6                	xor    %esi,%esi
  for(i = 0; ; i++){
    237e:	31 db                	xor    %ebx,%ebx
    2380:	eb 2e                	jmp    23b0 <bigfile+0xd4>
    2382:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    2384:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2389:	0f 85 8d 00 00 00    	jne    241c <bigfile+0x140>
    if(buf[0] != i/2 || buf[299] != i/2){
    238f:	89 da                	mov    %ebx,%edx
    2391:	d1 fa                	sar    %edx
    2393:	0f be 05 e0 78 00 00 	movsbl 0x78e0,%eax
    239a:	39 d0                	cmp    %edx,%eax
    239c:	75 6a                	jne    2408 <bigfile+0x12c>
    239e:	0f be 15 0b 7a 00 00 	movsbl 0x7a0b,%edx
    23a5:	39 d0                	cmp    %edx,%eax
    23a7:	75 5f                	jne    2408 <bigfile+0x12c>
    total += cc;
    23a9:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  for(i = 0; ; i++){
    23af:	43                   	inc    %ebx
    cc = read(fd, buf, 300);
    23b0:	50                   	push   %eax
    23b1:	68 2c 01 00 00       	push   $0x12c
    23b6:	68 e0 78 00 00       	push   $0x78e0
    23bb:	57                   	push   %edi
    23bc:	e8 c6 11 00 00       	call   3587 <read>
    if(cc < 0){
    23c1:	83 c4 10             	add    $0x10,%esp
    23c4:	85 c0                	test   %eax,%eax
    23c6:	78 68                	js     2430 <bigfile+0x154>
    if(cc == 0)
    23c8:	75 ba                	jne    2384 <bigfile+0xa8>
  close(fd);
    23ca:	83 ec 0c             	sub    $0xc,%esp
    23cd:	57                   	push   %edi
    23ce:	e8 c4 11 00 00       	call   3597 <close>
  if(total != 20*600){
    23d3:	83 c4 10             	add    $0x10,%esp
    23d6:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    23dc:	0f 85 9c 00 00 00    	jne    247e <bigfile+0x1a2>
  unlink("bigfile");
    23e2:	83 ec 0c             	sub    $0xc,%esp
    23e5:	68 44 44 00 00       	push   $0x4444
    23ea:	e8 d0 11 00 00       	call   35bf <unlink>
  printf(1, "bigfile test ok\n");
    23ef:	58                   	pop    %eax
    23f0:	5a                   	pop    %edx
    23f1:	68 d3 44 00 00       	push   $0x44d3
    23f6:	6a 01                	push   $0x1
    23f8:	e8 9b 12 00 00       	call   3698 <printf>
}
    23fd:	83 c4 10             	add    $0x10,%esp
    2400:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2403:	5b                   	pop    %ebx
    2404:	5e                   	pop    %esi
    2405:	5f                   	pop    %edi
    2406:	5d                   	pop    %ebp
    2407:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    2408:	83 ec 08             	sub    $0x8,%esp
    240b:	68 a0 44 00 00       	push   $0x44a0
    2410:	6a 01                	push   $0x1
    2412:	e8 81 12 00 00       	call   3698 <printf>
      exit();
    2417:	e8 53 11 00 00       	call   356f <exit>
      printf(1, "short read bigfile\n");
    241c:	83 ec 08             	sub    $0x8,%esp
    241f:	68 8c 44 00 00       	push   $0x448c
    2424:	6a 01                	push   $0x1
    2426:	e8 6d 12 00 00       	call   3698 <printf>
      exit();
    242b:	e8 3f 11 00 00       	call   356f <exit>
      printf(1, "read bigfile failed\n");
    2430:	83 ec 08             	sub    $0x8,%esp
    2433:	68 77 44 00 00       	push   $0x4477
    2438:	6a 01                	push   $0x1
    243a:	e8 59 12 00 00       	call   3698 <printf>
      exit();
    243f:	e8 2b 11 00 00       	call   356f <exit>
      printf(1, "write bigfile failed\n");
    2444:	83 ec 08             	sub    $0x8,%esp
    2447:	68 4c 44 00 00       	push   $0x444c
    244c:	6a 01                	push   $0x1
    244e:	e8 45 12 00 00       	call   3698 <printf>
      exit();
    2453:	e8 17 11 00 00       	call   356f <exit>
    printf(1, "cannot open bigfile\n");
    2458:	50                   	push   %eax
    2459:	50                   	push   %eax
    245a:	68 62 44 00 00       	push   $0x4462
    245f:	6a 01                	push   $0x1
    2461:	e8 32 12 00 00       	call   3698 <printf>
    exit();
    2466:	e8 04 11 00 00       	call   356f <exit>
    printf(1, "cannot create bigfile");
    246b:	53                   	push   %ebx
    246c:	53                   	push   %ebx
    246d:	68 36 44 00 00       	push   $0x4436
    2472:	6a 01                	push   $0x1
    2474:	e8 1f 12 00 00       	call   3698 <printf>
    exit();
    2479:	e8 f1 10 00 00       	call   356f <exit>
    printf(1, "read bigfile wrong total\n");
    247e:	51                   	push   %ecx
    247f:	51                   	push   %ecx
    2480:	68 b9 44 00 00       	push   $0x44b9
    2485:	6a 01                	push   $0x1
    2487:	e8 0c 12 00 00       	call   3698 <printf>
    exit();
    248c:	e8 de 10 00 00       	call   356f <exit>
    2491:	8d 76 00             	lea    0x0(%esi),%esi

00002494 <fourteen>:
{
    2494:	55                   	push   %ebp
    2495:	89 e5                	mov    %esp,%ebp
    2497:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
    249a:	68 e4 44 00 00       	push   $0x44e4
    249f:	6a 01                	push   $0x1
    24a1:	e8 f2 11 00 00       	call   3698 <printf>
  if(mkdir("12345678901234") != 0){
    24a6:	c7 04 24 1f 45 00 00 	movl   $0x451f,(%esp)
    24ad:	e8 25 11 00 00       	call   35d7 <mkdir>
    24b2:	83 c4 10             	add    $0x10,%esp
    24b5:	85 c0                	test   %eax,%eax
    24b7:	0f 85 97 00 00 00    	jne    2554 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    24bd:	83 ec 0c             	sub    $0xc,%esp
    24c0:	68 dc 4c 00 00       	push   $0x4cdc
    24c5:	e8 0d 11 00 00       	call   35d7 <mkdir>
    24ca:	83 c4 10             	add    $0x10,%esp
    24cd:	85 c0                	test   %eax,%eax
    24cf:	0f 85 de 00 00 00    	jne    25b3 <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    24d5:	83 ec 08             	sub    $0x8,%esp
    24d8:	68 00 02 00 00       	push   $0x200
    24dd:	68 2c 4d 00 00       	push   $0x4d2c
    24e2:	e8 c8 10 00 00       	call   35af <open>
  if(fd < 0){
    24e7:	83 c4 10             	add    $0x10,%esp
    24ea:	85 c0                	test   %eax,%eax
    24ec:	0f 88 ae 00 00 00    	js     25a0 <fourteen+0x10c>
  close(fd);
    24f2:	83 ec 0c             	sub    $0xc,%esp
    24f5:	50                   	push   %eax
    24f6:	e8 9c 10 00 00       	call   3597 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    24fb:	58                   	pop    %eax
    24fc:	5a                   	pop    %edx
    24fd:	6a 00                	push   $0x0
    24ff:	68 9c 4d 00 00       	push   $0x4d9c
    2504:	e8 a6 10 00 00       	call   35af <open>
  if(fd < 0){
    2509:	83 c4 10             	add    $0x10,%esp
    250c:	85 c0                	test   %eax,%eax
    250e:	78 7d                	js     258d <fourteen+0xf9>
  close(fd);
    2510:	83 ec 0c             	sub    $0xc,%esp
    2513:	50                   	push   %eax
    2514:	e8 7e 10 00 00       	call   3597 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2519:	c7 04 24 10 45 00 00 	movl   $0x4510,(%esp)
    2520:	e8 b2 10 00 00       	call   35d7 <mkdir>
    2525:	83 c4 10             	add    $0x10,%esp
    2528:	85 c0                	test   %eax,%eax
    252a:	74 4e                	je     257a <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    252c:	83 ec 0c             	sub    $0xc,%esp
    252f:	68 38 4e 00 00       	push   $0x4e38
    2534:	e8 9e 10 00 00       	call   35d7 <mkdir>
    2539:	83 c4 10             	add    $0x10,%esp
    253c:	85 c0                	test   %eax,%eax
    253e:	74 27                	je     2567 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    2540:	83 ec 08             	sub    $0x8,%esp
    2543:	68 2e 45 00 00       	push   $0x452e
    2548:	6a 01                	push   $0x1
    254a:	e8 49 11 00 00       	call   3698 <printf>
}
    254f:	83 c4 10             	add    $0x10,%esp
    2552:	c9                   	leave  
    2553:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    2554:	50                   	push   %eax
    2555:	50                   	push   %eax
    2556:	68 f3 44 00 00       	push   $0x44f3
    255b:	6a 01                	push   $0x1
    255d:	e8 36 11 00 00       	call   3698 <printf>
    exit();
    2562:	e8 08 10 00 00       	call   356f <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2567:	50                   	push   %eax
    2568:	50                   	push   %eax
    2569:	68 58 4e 00 00       	push   $0x4e58
    256e:	6a 01                	push   $0x1
    2570:	e8 23 11 00 00       	call   3698 <printf>
    exit();
    2575:	e8 f5 0f 00 00       	call   356f <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    257a:	52                   	push   %edx
    257b:	52                   	push   %edx
    257c:	68 08 4e 00 00       	push   $0x4e08
    2581:	6a 01                	push   $0x1
    2583:	e8 10 11 00 00       	call   3698 <printf>
    exit();
    2588:	e8 e2 0f 00 00       	call   356f <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    258d:	51                   	push   %ecx
    258e:	51                   	push   %ecx
    258f:	68 cc 4d 00 00       	push   $0x4dcc
    2594:	6a 01                	push   $0x1
    2596:	e8 fd 10 00 00       	call   3698 <printf>
    exit();
    259b:	e8 cf 0f 00 00       	call   356f <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    25a0:	51                   	push   %ecx
    25a1:	51                   	push   %ecx
    25a2:	68 5c 4d 00 00       	push   $0x4d5c
    25a7:	6a 01                	push   $0x1
    25a9:	e8 ea 10 00 00       	call   3698 <printf>
    exit();
    25ae:	e8 bc 0f 00 00       	call   356f <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    25b3:	50                   	push   %eax
    25b4:	50                   	push   %eax
    25b5:	68 fc 4c 00 00       	push   $0x4cfc
    25ba:	6a 01                	push   $0x1
    25bc:	e8 d7 10 00 00       	call   3698 <printf>
    exit();
    25c1:	e8 a9 0f 00 00       	call   356f <exit>
    25c6:	66 90                	xchg   %ax,%ax

000025c8 <rmdot>:
{
    25c8:	55                   	push   %ebp
    25c9:	89 e5                	mov    %esp,%ebp
    25cb:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    25ce:	68 3b 45 00 00       	push   $0x453b
    25d3:	6a 01                	push   $0x1
    25d5:	e8 be 10 00 00       	call   3698 <printf>
  if(mkdir("dots") != 0){
    25da:	c7 04 24 47 45 00 00 	movl   $0x4547,(%esp)
    25e1:	e8 f1 0f 00 00       	call   35d7 <mkdir>
    25e6:	83 c4 10             	add    $0x10,%esp
    25e9:	85 c0                	test   %eax,%eax
    25eb:	0f 85 b0 00 00 00    	jne    26a1 <rmdot+0xd9>
  if(chdir("dots") != 0){
    25f1:	83 ec 0c             	sub    $0xc,%esp
    25f4:	68 47 45 00 00       	push   $0x4547
    25f9:	e8 e1 0f 00 00       	call   35df <chdir>
    25fe:	83 c4 10             	add    $0x10,%esp
    2601:	85 c0                	test   %eax,%eax
    2603:	0f 85 1d 01 00 00    	jne    2726 <rmdot+0x15e>
  if(unlink(".") == 0){
    2609:	83 ec 0c             	sub    $0xc,%esp
    260c:	68 f2 41 00 00       	push   $0x41f2
    2611:	e8 a9 0f 00 00       	call   35bf <unlink>
    2616:	83 c4 10             	add    $0x10,%esp
    2619:	85 c0                	test   %eax,%eax
    261b:	0f 84 f2 00 00 00    	je     2713 <rmdot+0x14b>
  if(unlink("..") == 0){
    2621:	83 ec 0c             	sub    $0xc,%esp
    2624:	68 f1 41 00 00       	push   $0x41f1
    2629:	e8 91 0f 00 00       	call   35bf <unlink>
    262e:	83 c4 10             	add    $0x10,%esp
    2631:	85 c0                	test   %eax,%eax
    2633:	0f 84 c7 00 00 00    	je     2700 <rmdot+0x138>
  if(chdir("/") != 0){
    2639:	83 ec 0c             	sub    $0xc,%esp
    263c:	68 c5 39 00 00       	push   $0x39c5
    2641:	e8 99 0f 00 00       	call   35df <chdir>
    2646:	83 c4 10             	add    $0x10,%esp
    2649:	85 c0                	test   %eax,%eax
    264b:	0f 85 9c 00 00 00    	jne    26ed <rmdot+0x125>
  if(unlink("dots/.") == 0){
    2651:	83 ec 0c             	sub    $0xc,%esp
    2654:	68 8f 45 00 00       	push   $0x458f
    2659:	e8 61 0f 00 00       	call   35bf <unlink>
    265e:	83 c4 10             	add    $0x10,%esp
    2661:	85 c0                	test   %eax,%eax
    2663:	74 75                	je     26da <rmdot+0x112>
  if(unlink("dots/..") == 0){
    2665:	83 ec 0c             	sub    $0xc,%esp
    2668:	68 ad 45 00 00       	push   $0x45ad
    266d:	e8 4d 0f 00 00       	call   35bf <unlink>
    2672:	83 c4 10             	add    $0x10,%esp
    2675:	85 c0                	test   %eax,%eax
    2677:	74 4e                	je     26c7 <rmdot+0xff>
  if(unlink("dots") != 0){
    2679:	83 ec 0c             	sub    $0xc,%esp
    267c:	68 47 45 00 00       	push   $0x4547
    2681:	e8 39 0f 00 00       	call   35bf <unlink>
    2686:	83 c4 10             	add    $0x10,%esp
    2689:	85 c0                	test   %eax,%eax
    268b:	75 27                	jne    26b4 <rmdot+0xec>
  printf(1, "rmdot ok\n");
    268d:	83 ec 08             	sub    $0x8,%esp
    2690:	68 e2 45 00 00       	push   $0x45e2
    2695:	6a 01                	push   $0x1
    2697:	e8 fc 0f 00 00       	call   3698 <printf>
}
    269c:	83 c4 10             	add    $0x10,%esp
    269f:	c9                   	leave  
    26a0:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    26a1:	50                   	push   %eax
    26a2:	50                   	push   %eax
    26a3:	68 4c 45 00 00       	push   $0x454c
    26a8:	6a 01                	push   $0x1
    26aa:	e8 e9 0f 00 00       	call   3698 <printf>
    exit();
    26af:	e8 bb 0e 00 00       	call   356f <exit>
    printf(1, "unlink dots failed!\n");
    26b4:	50                   	push   %eax
    26b5:	50                   	push   %eax
    26b6:	68 cd 45 00 00       	push   $0x45cd
    26bb:	6a 01                	push   $0x1
    26bd:	e8 d6 0f 00 00       	call   3698 <printf>
    exit();
    26c2:	e8 a8 0e 00 00       	call   356f <exit>
    printf(1, "unlink dots/.. worked!\n");
    26c7:	52                   	push   %edx
    26c8:	52                   	push   %edx
    26c9:	68 b5 45 00 00       	push   $0x45b5
    26ce:	6a 01                	push   $0x1
    26d0:	e8 c3 0f 00 00       	call   3698 <printf>
    exit();
    26d5:	e8 95 0e 00 00       	call   356f <exit>
    printf(1, "unlink dots/. worked!\n");
    26da:	51                   	push   %ecx
    26db:	51                   	push   %ecx
    26dc:	68 96 45 00 00       	push   $0x4596
    26e1:	6a 01                	push   $0x1
    26e3:	e8 b0 0f 00 00       	call   3698 <printf>
    exit();
    26e8:	e8 82 0e 00 00       	call   356f <exit>
    printf(1, "chdir / failed\n");
    26ed:	50                   	push   %eax
    26ee:	50                   	push   %eax
    26ef:	68 c7 39 00 00       	push   $0x39c7
    26f4:	6a 01                	push   $0x1
    26f6:	e8 9d 0f 00 00       	call   3698 <printf>
    exit();
    26fb:	e8 6f 0e 00 00       	call   356f <exit>
    printf(1, "rm .. worked!\n");
    2700:	50                   	push   %eax
    2701:	50                   	push   %eax
    2702:	68 80 45 00 00       	push   $0x4580
    2707:	6a 01                	push   $0x1
    2709:	e8 8a 0f 00 00       	call   3698 <printf>
    exit();
    270e:	e8 5c 0e 00 00       	call   356f <exit>
    printf(1, "rm . worked!\n");
    2713:	50                   	push   %eax
    2714:	50                   	push   %eax
    2715:	68 72 45 00 00       	push   $0x4572
    271a:	6a 01                	push   $0x1
    271c:	e8 77 0f 00 00       	call   3698 <printf>
    exit();
    2721:	e8 49 0e 00 00       	call   356f <exit>
    printf(1, "chdir dots failed\n");
    2726:	50                   	push   %eax
    2727:	50                   	push   %eax
    2728:	68 5f 45 00 00       	push   $0x455f
    272d:	6a 01                	push   $0x1
    272f:	e8 64 0f 00 00       	call   3698 <printf>
    exit();
    2734:	e8 36 0e 00 00       	call   356f <exit>
    2739:	8d 76 00             	lea    0x0(%esi),%esi

0000273c <dirfile>:
{
    273c:	55                   	push   %ebp
    273d:	89 e5                	mov    %esp,%ebp
    273f:	53                   	push   %ebx
    2740:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
    2743:	68 ec 45 00 00       	push   $0x45ec
    2748:	6a 01                	push   $0x1
    274a:	e8 49 0f 00 00       	call   3698 <printf>
  fd = open("dirfile", O_CREATE);
    274f:	5b                   	pop    %ebx
    2750:	58                   	pop    %eax
    2751:	68 00 02 00 00       	push   $0x200
    2756:	68 f9 45 00 00       	push   $0x45f9
    275b:	e8 4f 0e 00 00       	call   35af <open>
  if(fd < 0){
    2760:	83 c4 10             	add    $0x10,%esp
    2763:	85 c0                	test   %eax,%eax
    2765:	0f 88 43 01 00 00    	js     28ae <dirfile+0x172>
  close(fd);
    276b:	83 ec 0c             	sub    $0xc,%esp
    276e:	50                   	push   %eax
    276f:	e8 23 0e 00 00       	call   3597 <close>
  if(chdir("dirfile") == 0){
    2774:	c7 04 24 f9 45 00 00 	movl   $0x45f9,(%esp)
    277b:	e8 5f 0e 00 00       	call   35df <chdir>
    2780:	83 c4 10             	add    $0x10,%esp
    2783:	85 c0                	test   %eax,%eax
    2785:	0f 84 10 01 00 00    	je     289b <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    278b:	83 ec 08             	sub    $0x8,%esp
    278e:	6a 00                	push   $0x0
    2790:	68 32 46 00 00       	push   $0x4632
    2795:	e8 15 0e 00 00       	call   35af <open>
  if(fd >= 0){
    279a:	83 c4 10             	add    $0x10,%esp
    279d:	85 c0                	test   %eax,%eax
    279f:	0f 89 e3 00 00 00    	jns    2888 <dirfile+0x14c>
  fd = open("dirfile/xx", O_CREATE);
    27a5:	83 ec 08             	sub    $0x8,%esp
    27a8:	68 00 02 00 00       	push   $0x200
    27ad:	68 32 46 00 00       	push   $0x4632
    27b2:	e8 f8 0d 00 00       	call   35af <open>
  if(fd >= 0){
    27b7:	83 c4 10             	add    $0x10,%esp
    27ba:	85 c0                	test   %eax,%eax
    27bc:	0f 89 c6 00 00 00    	jns    2888 <dirfile+0x14c>
  if(mkdir("dirfile/xx") == 0){
    27c2:	83 ec 0c             	sub    $0xc,%esp
    27c5:	68 32 46 00 00       	push   $0x4632
    27ca:	e8 08 0e 00 00       	call   35d7 <mkdir>
    27cf:	83 c4 10             	add    $0x10,%esp
    27d2:	85 c0                	test   %eax,%eax
    27d4:	0f 84 46 01 00 00    	je     2920 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    27da:	83 ec 0c             	sub    $0xc,%esp
    27dd:	68 32 46 00 00       	push   $0x4632
    27e2:	e8 d8 0d 00 00       	call   35bf <unlink>
    27e7:	83 c4 10             	add    $0x10,%esp
    27ea:	85 c0                	test   %eax,%eax
    27ec:	0f 84 1b 01 00 00    	je     290d <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    27f2:	83 ec 08             	sub    $0x8,%esp
    27f5:	68 32 46 00 00       	push   $0x4632
    27fa:	68 96 46 00 00       	push   $0x4696
    27ff:	e8 cb 0d 00 00       	call   35cf <link>
    2804:	83 c4 10             	add    $0x10,%esp
    2807:	85 c0                	test   %eax,%eax
    2809:	0f 84 eb 00 00 00    	je     28fa <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    280f:	83 ec 0c             	sub    $0xc,%esp
    2812:	68 f9 45 00 00       	push   $0x45f9
    2817:	e8 a3 0d 00 00       	call   35bf <unlink>
    281c:	83 c4 10             	add    $0x10,%esp
    281f:	85 c0                	test   %eax,%eax
    2821:	0f 85 c0 00 00 00    	jne    28e7 <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    2827:	83 ec 08             	sub    $0x8,%esp
    282a:	6a 02                	push   $0x2
    282c:	68 f2 41 00 00       	push   $0x41f2
    2831:	e8 79 0d 00 00       	call   35af <open>
  if(fd >= 0){
    2836:	83 c4 10             	add    $0x10,%esp
    2839:	85 c0                	test   %eax,%eax
    283b:	0f 89 93 00 00 00    	jns    28d4 <dirfile+0x198>
  fd = open(".", 0);
    2841:	83 ec 08             	sub    $0x8,%esp
    2844:	6a 00                	push   $0x0
    2846:	68 f2 41 00 00       	push   $0x41f2
    284b:	e8 5f 0d 00 00       	call   35af <open>
    2850:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2852:	83 c4 0c             	add    $0xc,%esp
    2855:	6a 01                	push   $0x1
    2857:	68 d5 42 00 00       	push   $0x42d5
    285c:	50                   	push   %eax
    285d:	e8 2d 0d 00 00       	call   358f <write>
    2862:	83 c4 10             	add    $0x10,%esp
    2865:	85 c0                	test   %eax,%eax
    2867:	7f 58                	jg     28c1 <dirfile+0x185>
  close(fd);
    2869:	83 ec 0c             	sub    $0xc,%esp
    286c:	53                   	push   %ebx
    286d:	e8 25 0d 00 00       	call   3597 <close>
  printf(1, "dir vs file OK\n");
    2872:	58                   	pop    %eax
    2873:	5a                   	pop    %edx
    2874:	68 c9 46 00 00       	push   $0x46c9
    2879:	6a 01                	push   $0x1
    287b:	e8 18 0e 00 00       	call   3698 <printf>
}
    2880:	83 c4 10             	add    $0x10,%esp
    2883:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2886:	c9                   	leave  
    2887:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    2888:	50                   	push   %eax
    2889:	50                   	push   %eax
    288a:	68 3d 46 00 00       	push   $0x463d
    288f:	6a 01                	push   $0x1
    2891:	e8 02 0e 00 00       	call   3698 <printf>
    exit();
    2896:	e8 d4 0c 00 00       	call   356f <exit>
    printf(1, "chdir dirfile succeeded!\n");
    289b:	52                   	push   %edx
    289c:	52                   	push   %edx
    289d:	68 18 46 00 00       	push   $0x4618
    28a2:	6a 01                	push   $0x1
    28a4:	e8 ef 0d 00 00       	call   3698 <printf>
    exit();
    28a9:	e8 c1 0c 00 00       	call   356f <exit>
    printf(1, "create dirfile failed\n");
    28ae:	51                   	push   %ecx
    28af:	51                   	push   %ecx
    28b0:	68 01 46 00 00       	push   $0x4601
    28b5:	6a 01                	push   $0x1
    28b7:	e8 dc 0d 00 00       	call   3698 <printf>
    exit();
    28bc:	e8 ae 0c 00 00       	call   356f <exit>
    printf(1, "write . succeeded!\n");
    28c1:	51                   	push   %ecx
    28c2:	51                   	push   %ecx
    28c3:	68 b5 46 00 00       	push   $0x46b5
    28c8:	6a 01                	push   $0x1
    28ca:	e8 c9 0d 00 00       	call   3698 <printf>
    exit();
    28cf:	e8 9b 0c 00 00       	call   356f <exit>
    printf(1, "open . for writing succeeded!\n");
    28d4:	53                   	push   %ebx
    28d5:	53                   	push   %ebx
    28d6:	68 ac 4e 00 00       	push   $0x4eac
    28db:	6a 01                	push   $0x1
    28dd:	e8 b6 0d 00 00       	call   3698 <printf>
    exit();
    28e2:	e8 88 0c 00 00       	call   356f <exit>
    printf(1, "unlink dirfile failed!\n");
    28e7:	50                   	push   %eax
    28e8:	50                   	push   %eax
    28e9:	68 9d 46 00 00       	push   $0x469d
    28ee:	6a 01                	push   $0x1
    28f0:	e8 a3 0d 00 00       	call   3698 <printf>
    exit();
    28f5:	e8 75 0c 00 00       	call   356f <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    28fa:	50                   	push   %eax
    28fb:	50                   	push   %eax
    28fc:	68 8c 4e 00 00       	push   $0x4e8c
    2901:	6a 01                	push   $0x1
    2903:	e8 90 0d 00 00       	call   3698 <printf>
    exit();
    2908:	e8 62 0c 00 00       	call   356f <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    290d:	50                   	push   %eax
    290e:	50                   	push   %eax
    290f:	68 78 46 00 00       	push   $0x4678
    2914:	6a 01                	push   $0x1
    2916:	e8 7d 0d 00 00       	call   3698 <printf>
    exit();
    291b:	e8 4f 0c 00 00       	call   356f <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2920:	50                   	push   %eax
    2921:	50                   	push   %eax
    2922:	68 5b 46 00 00       	push   $0x465b
    2927:	6a 01                	push   $0x1
    2929:	e8 6a 0d 00 00       	call   3698 <printf>
    exit();
    292e:	e8 3c 0c 00 00       	call   356f <exit>
    2933:	90                   	nop

00002934 <iref>:
{
    2934:	55                   	push   %ebp
    2935:	89 e5                	mov    %esp,%ebp
    2937:	53                   	push   %ebx
    2938:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
    293b:	68 d9 46 00 00       	push   $0x46d9
    2940:	6a 01                	push   $0x1
    2942:	e8 51 0d 00 00       	call   3698 <printf>
    2947:	83 c4 10             	add    $0x10,%esp
    294a:	bb 33 00 00 00       	mov    $0x33,%ebx
    294f:	90                   	nop
    if(mkdir("irefd") != 0){
    2950:	83 ec 0c             	sub    $0xc,%esp
    2953:	68 ea 46 00 00       	push   $0x46ea
    2958:	e8 7a 0c 00 00       	call   35d7 <mkdir>
    295d:	83 c4 10             	add    $0x10,%esp
    2960:	85 c0                	test   %eax,%eax
    2962:	0f 85 b9 00 00 00    	jne    2a21 <iref+0xed>
    if(chdir("irefd") != 0){
    2968:	83 ec 0c             	sub    $0xc,%esp
    296b:	68 ea 46 00 00       	push   $0x46ea
    2970:	e8 6a 0c 00 00       	call   35df <chdir>
    2975:	83 c4 10             	add    $0x10,%esp
    2978:	85 c0                	test   %eax,%eax
    297a:	0f 85 b5 00 00 00    	jne    2a35 <iref+0x101>
    mkdir("");
    2980:	83 ec 0c             	sub    $0xc,%esp
    2983:	68 9f 3d 00 00       	push   $0x3d9f
    2988:	e8 4a 0c 00 00       	call   35d7 <mkdir>
    link("README", "");
    298d:	59                   	pop    %ecx
    298e:	58                   	pop    %eax
    298f:	68 9f 3d 00 00       	push   $0x3d9f
    2994:	68 96 46 00 00       	push   $0x4696
    2999:	e8 31 0c 00 00       	call   35cf <link>
    fd = open("", O_CREATE);
    299e:	58                   	pop    %eax
    299f:	5a                   	pop    %edx
    29a0:	68 00 02 00 00       	push   $0x200
    29a5:	68 9f 3d 00 00       	push   $0x3d9f
    29aa:	e8 00 0c 00 00       	call   35af <open>
    if(fd >= 0)
    29af:	83 c4 10             	add    $0x10,%esp
    29b2:	85 c0                	test   %eax,%eax
    29b4:	78 0c                	js     29c2 <iref+0x8e>
      close(fd);
    29b6:	83 ec 0c             	sub    $0xc,%esp
    29b9:	50                   	push   %eax
    29ba:	e8 d8 0b 00 00       	call   3597 <close>
    29bf:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    29c2:	83 ec 08             	sub    $0x8,%esp
    29c5:	68 00 02 00 00       	push   $0x200
    29ca:	68 d4 42 00 00       	push   $0x42d4
    29cf:	e8 db 0b 00 00       	call   35af <open>
    if(fd >= 0)
    29d4:	83 c4 10             	add    $0x10,%esp
    29d7:	85 c0                	test   %eax,%eax
    29d9:	78 0c                	js     29e7 <iref+0xb3>
      close(fd);
    29db:	83 ec 0c             	sub    $0xc,%esp
    29de:	50                   	push   %eax
    29df:	e8 b3 0b 00 00       	call   3597 <close>
    29e4:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    29e7:	83 ec 0c             	sub    $0xc,%esp
    29ea:	68 d4 42 00 00       	push   $0x42d4
    29ef:	e8 cb 0b 00 00       	call   35bf <unlink>
  for(i = 0; i < 50 + 1; i++){
    29f4:	83 c4 10             	add    $0x10,%esp
    29f7:	4b                   	dec    %ebx
    29f8:	0f 85 52 ff ff ff    	jne    2950 <iref+0x1c>
  chdir("/");
    29fe:	83 ec 0c             	sub    $0xc,%esp
    2a01:	68 c5 39 00 00       	push   $0x39c5
    2a06:	e8 d4 0b 00 00       	call   35df <chdir>
  printf(1, "empty file name OK\n");
    2a0b:	58                   	pop    %eax
    2a0c:	5a                   	pop    %edx
    2a0d:	68 18 47 00 00       	push   $0x4718
    2a12:	6a 01                	push   $0x1
    2a14:	e8 7f 0c 00 00       	call   3698 <printf>
}
    2a19:	83 c4 10             	add    $0x10,%esp
    2a1c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2a1f:	c9                   	leave  
    2a20:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    2a21:	83 ec 08             	sub    $0x8,%esp
    2a24:	68 f0 46 00 00       	push   $0x46f0
    2a29:	6a 01                	push   $0x1
    2a2b:	e8 68 0c 00 00       	call   3698 <printf>
      exit();
    2a30:	e8 3a 0b 00 00       	call   356f <exit>
      printf(1, "chdir irefd failed\n");
    2a35:	83 ec 08             	sub    $0x8,%esp
    2a38:	68 04 47 00 00       	push   $0x4704
    2a3d:	6a 01                	push   $0x1
    2a3f:	e8 54 0c 00 00       	call   3698 <printf>
      exit();
    2a44:	e8 26 0b 00 00       	call   356f <exit>
    2a49:	8d 76 00             	lea    0x0(%esi),%esi

00002a4c <forktest>:
{
    2a4c:	55                   	push   %ebp
    2a4d:	89 e5                	mov    %esp,%ebp
    2a4f:	53                   	push   %ebx
    2a50:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
    2a53:	68 2c 47 00 00       	push   $0x472c
    2a58:	6a 01                	push   $0x1
    2a5a:	e8 39 0c 00 00       	call   3698 <printf>
    2a5f:	83 c4 10             	add    $0x10,%esp
  for(n=0; n<1000; n++){
    2a62:	31 db                	xor    %ebx,%ebx
    2a64:	eb 0d                	jmp    2a73 <forktest+0x27>
    2a66:	66 90                	xchg   %ax,%ax
    if(pid == 0)
    2a68:	74 3e                	je     2aa8 <forktest+0x5c>
  for(n=0; n<1000; n++){
    2a6a:	43                   	inc    %ebx
    2a6b:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2a71:	74 61                	je     2ad4 <forktest+0x88>
    pid = fork();
    2a73:	e8 ef 0a 00 00       	call   3567 <fork>
    if(pid < 0)
    2a78:	85 c0                	test   %eax,%eax
    2a7a:	79 ec                	jns    2a68 <forktest+0x1c>
  for(; n > 0; n--){
    2a7c:	85 db                	test   %ebx,%ebx
    2a7e:	74 0c                	je     2a8c <forktest+0x40>
    if(wait() < 0){
    2a80:	e8 f2 0a 00 00       	call   3577 <wait>
    2a85:	85 c0                	test   %eax,%eax
    2a87:	78 24                	js     2aad <forktest+0x61>
  for(; n > 0; n--){
    2a89:	4b                   	dec    %ebx
    2a8a:	75 f4                	jne    2a80 <forktest+0x34>
  if(wait() != -1){
    2a8c:	e8 e6 0a 00 00       	call   3577 <wait>
    2a91:	40                   	inc    %eax
    2a92:	75 2d                	jne    2ac1 <forktest+0x75>
  printf(1, "fork test OK\n");
    2a94:	83 ec 08             	sub    $0x8,%esp
    2a97:	68 5e 47 00 00       	push   $0x475e
    2a9c:	6a 01                	push   $0x1
    2a9e:	e8 f5 0b 00 00       	call   3698 <printf>
}
    2aa3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2aa6:	c9                   	leave  
    2aa7:	c3                   	ret    
      exit();
    2aa8:	e8 c2 0a 00 00       	call   356f <exit>
      printf(1, "wait stopped early\n");
    2aad:	83 ec 08             	sub    $0x8,%esp
    2ab0:	68 37 47 00 00       	push   $0x4737
    2ab5:	6a 01                	push   $0x1
    2ab7:	e8 dc 0b 00 00       	call   3698 <printf>
      exit();
    2abc:	e8 ae 0a 00 00       	call   356f <exit>
    printf(1, "wait got too many\n");
    2ac1:	52                   	push   %edx
    2ac2:	52                   	push   %edx
    2ac3:	68 4b 47 00 00       	push   $0x474b
    2ac8:	6a 01                	push   $0x1
    2aca:	e8 c9 0b 00 00       	call   3698 <printf>
    exit();
    2acf:	e8 9b 0a 00 00       	call   356f <exit>
    printf(1, "fork claimed to work 1000 times!\n");
    2ad4:	50                   	push   %eax
    2ad5:	50                   	push   %eax
    2ad6:	68 cc 4e 00 00       	push   $0x4ecc
    2adb:	6a 01                	push   $0x1
    2add:	e8 b6 0b 00 00       	call   3698 <printf>
    exit();
    2ae2:	e8 88 0a 00 00       	call   356f <exit>
    2ae7:	90                   	nop

00002ae8 <sbrktest>:
{
    2ae8:	55                   	push   %ebp
    2ae9:	89 e5                	mov    %esp,%ebp
    2aeb:	57                   	push   %edi
    2aec:	56                   	push   %esi
    2aed:	53                   	push   %ebx
    2aee:	83 ec 64             	sub    $0x64,%esp
  printf(stdout, "sbrk test\n");
    2af1:	68 6c 47 00 00       	push   $0x476c
    2af6:	ff 35 9c 51 00 00    	push   0x519c
    2afc:	e8 97 0b 00 00       	call   3698 <printf>
  oldbrk = sbrk(0);
    2b01:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b08:	e8 ea 0a 00 00       	call   35f7 <sbrk>
    2b0d:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  a = sbrk(0);
    2b10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b17:	e8 db 0a 00 00       	call   35f7 <sbrk>
    2b1c:	89 c3                	mov    %eax,%ebx
    2b1e:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 5000; i++){
    2b21:	31 f6                	xor    %esi,%esi
    2b23:	eb 05                	jmp    2b2a <sbrktest+0x42>
    2b25:	8d 76 00             	lea    0x0(%esi),%esi
    a = b + 1;
    2b28:	89 c3                	mov    %eax,%ebx
    b = sbrk(1);
    2b2a:	83 ec 0c             	sub    $0xc,%esp
    2b2d:	6a 01                	push   $0x1
    2b2f:	e8 c3 0a 00 00       	call   35f7 <sbrk>
    if(b != a){
    2b34:	83 c4 10             	add    $0x10,%esp
    2b37:	39 d8                	cmp    %ebx,%eax
    2b39:	0f 85 7f 02 00 00    	jne    2dbe <sbrktest+0x2d6>
    *b = 1;
    2b3f:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    2b42:	8d 43 01             	lea    0x1(%ebx),%eax
  for(i = 0; i < 5000; i++){
    2b45:	46                   	inc    %esi
    2b46:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    2b4c:	75 da                	jne    2b28 <sbrktest+0x40>
  pid = fork();
    2b4e:	e8 14 0a 00 00       	call   3567 <fork>
    2b53:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    2b55:	85 c0                	test   %eax,%eax
    2b57:	0f 88 e7 02 00 00    	js     2e44 <sbrktest+0x35c>
  c = sbrk(1);
    2b5d:	83 ec 0c             	sub    $0xc,%esp
    2b60:	6a 01                	push   $0x1
    2b62:	e8 90 0a 00 00       	call   35f7 <sbrk>
  c = sbrk(1);
    2b67:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b6e:	e8 84 0a 00 00       	call   35f7 <sbrk>
  if(c != a + 1){
    2b73:	83 c3 02             	add    $0x2,%ebx
    2b76:	83 c4 10             	add    $0x10,%esp
    2b79:	39 c3                	cmp    %eax,%ebx
    2b7b:	0f 85 20 03 00 00    	jne    2ea1 <sbrktest+0x3b9>
  if(pid == 0)
    2b81:	85 f6                	test   %esi,%esi
    2b83:	0f 84 13 03 00 00    	je     2e9c <sbrktest+0x3b4>
  wait();
    2b89:	e8 e9 09 00 00       	call   3577 <wait>
  a = sbrk(0);
    2b8e:	83 ec 0c             	sub    $0xc,%esp
    2b91:	6a 00                	push   $0x0
    2b93:	e8 5f 0a 00 00       	call   35f7 <sbrk>
    2b98:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    2b9a:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2b9f:	29 d8                	sub    %ebx,%eax
  p = sbrk(amt);
    2ba1:	89 04 24             	mov    %eax,(%esp)
    2ba4:	e8 4e 0a 00 00       	call   35f7 <sbrk>
  if (p != a) {
    2ba9:	83 c4 10             	add    $0x10,%esp
    2bac:	39 c3                	cmp    %eax,%ebx
    2bae:	0f 85 79 02 00 00    	jne    2e2d <sbrktest+0x345>
  *lastaddr = 99;
    2bb4:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
  a = sbrk(0);
    2bbb:	83 ec 0c             	sub    $0xc,%esp
    2bbe:	6a 00                	push   $0x0
    2bc0:	e8 32 0a 00 00       	call   35f7 <sbrk>
    2bc5:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2bc7:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2bce:	e8 24 0a 00 00       	call   35f7 <sbrk>
  if(c == (char*)0xffffffff){
    2bd3:	83 c4 10             	add    $0x10,%esp
    2bd6:	40                   	inc    %eax
    2bd7:	0f 84 09 03 00 00    	je     2ee6 <sbrktest+0x3fe>
  c = sbrk(0);
    2bdd:	83 ec 0c             	sub    $0xc,%esp
    2be0:	6a 00                	push   $0x0
    2be2:	e8 10 0a 00 00       	call   35f7 <sbrk>
  if(c != a - 4096){
    2be7:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2bed:	83 c4 10             	add    $0x10,%esp
    2bf0:	39 d0                	cmp    %edx,%eax
    2bf2:	0f 85 d7 02 00 00    	jne    2ecf <sbrktest+0x3e7>
  a = sbrk(0);
    2bf8:	83 ec 0c             	sub    $0xc,%esp
    2bfb:	6a 00                	push   $0x0
    2bfd:	e8 f5 09 00 00       	call   35f7 <sbrk>
    2c02:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    2c04:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2c0b:	e8 e7 09 00 00       	call   35f7 <sbrk>
    2c10:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    2c12:	83 c4 10             	add    $0x10,%esp
    2c15:	39 c3                	cmp    %eax,%ebx
    2c17:	0f 85 9b 02 00 00    	jne    2eb8 <sbrktest+0x3d0>
    2c1d:	83 ec 0c             	sub    $0xc,%esp
    2c20:	6a 00                	push   $0x0
    2c22:	e8 d0 09 00 00       	call   35f7 <sbrk>
    2c27:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2c2d:	83 c4 10             	add    $0x10,%esp
    2c30:	39 c2                	cmp    %eax,%edx
    2c32:	0f 85 80 02 00 00    	jne    2eb8 <sbrktest+0x3d0>
  if(*lastaddr == 99){
    2c38:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2c3f:	0f 84 16 02 00 00    	je     2e5b <sbrktest+0x373>
  a = sbrk(0);
    2c45:	83 ec 0c             	sub    $0xc,%esp
    2c48:	6a 00                	push   $0x0
    2c4a:	e8 a8 09 00 00       	call   35f7 <sbrk>
    2c4f:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    2c51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c58:	e8 9a 09 00 00       	call   35f7 <sbrk>
    2c5d:	8b 55 a4             	mov    -0x5c(%ebp),%edx
    2c60:	29 c2                	sub    %eax,%edx
    2c62:	89 14 24             	mov    %edx,(%esp)
    2c65:	e8 8d 09 00 00       	call   35f7 <sbrk>
  if(c != a){
    2c6a:	83 c4 10             	add    $0x10,%esp
    2c6d:	39 c3                	cmp    %eax,%ebx
    2c6f:	0f 85 a1 01 00 00    	jne    2e16 <sbrktest+0x32e>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2c75:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    2c7a:	66 90                	xchg   %ax,%ax
    ppid = getpid();
    2c7c:	e8 6e 09 00 00       	call   35ef <getpid>
    2c81:	89 c6                	mov    %eax,%esi
    pid = fork();
    2c83:	e8 df 08 00 00       	call   3567 <fork>
    if(pid < 0){
    2c88:	85 c0                	test   %eax,%eax
    2c8a:	0f 88 4c 01 00 00    	js     2ddc <sbrktest+0x2f4>
    if(pid == 0){
    2c90:	0f 84 5e 01 00 00    	je     2df4 <sbrktest+0x30c>
    wait();
    2c96:	e8 dc 08 00 00       	call   3577 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2c9b:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    2ca1:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2ca7:	75 d3                	jne    2c7c <sbrktest+0x194>
  if(pipe(fds) != 0){
    2ca9:	83 ec 0c             	sub    $0xc,%esp
    2cac:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2caf:	50                   	push   %eax
    2cb0:	e8 ca 08 00 00       	call   357f <pipe>
    2cb5:	83 c4 10             	add    $0x10,%esp
    2cb8:	85 c0                	test   %eax,%eax
    2cba:	0f 85 c9 01 00 00    	jne    2e89 <sbrktest+0x3a1>
    2cc0:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    2cc3:	8d 7d e8             	lea    -0x18(%ebp),%edi
    2cc6:	89 de                	mov    %ebx,%esi
    if((pids[i] = fork()) == 0){
    2cc8:	e8 9a 08 00 00       	call   3567 <fork>
    2ccd:	89 06                	mov    %eax,(%esi)
    2ccf:	85 c0                	test   %eax,%eax
    2cd1:	0f 84 87 00 00 00    	je     2d5e <sbrktest+0x276>
    if(pids[i] != -1)
    2cd7:	40                   	inc    %eax
    2cd8:	74 12                	je     2cec <sbrktest+0x204>
      read(fds[0], &scratch, 1);
    2cda:	52                   	push   %edx
    2cdb:	6a 01                	push   $0x1
    2cdd:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2ce0:	50                   	push   %eax
    2ce1:	ff 75 b8             	push   -0x48(%ebp)
    2ce4:	e8 9e 08 00 00       	call   3587 <read>
    2ce9:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2cec:	83 c6 04             	add    $0x4,%esi
    2cef:	39 fe                	cmp    %edi,%esi
    2cf1:	75 d5                	jne    2cc8 <sbrktest+0x1e0>
  c = sbrk(4096);
    2cf3:	83 ec 0c             	sub    $0xc,%esp
    2cf6:	68 00 10 00 00       	push   $0x1000
    2cfb:	e8 f7 08 00 00       	call   35f7 <sbrk>
    2d00:	89 c6                	mov    %eax,%esi
    2d02:	83 c4 10             	add    $0x10,%esp
    2d05:	8d 76 00             	lea    0x0(%esi),%esi
    if(pids[i] == -1)
    2d08:	8b 03                	mov    (%ebx),%eax
    2d0a:	83 f8 ff             	cmp    $0xffffffff,%eax
    2d0d:	74 11                	je     2d20 <sbrktest+0x238>
    kill(pids[i]);
    2d0f:	83 ec 0c             	sub    $0xc,%esp
    2d12:	50                   	push   %eax
    2d13:	e8 87 08 00 00       	call   359f <kill>
    wait();
    2d18:	e8 5a 08 00 00       	call   3577 <wait>
    2d1d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2d20:	83 c3 04             	add    $0x4,%ebx
    2d23:	39 df                	cmp    %ebx,%edi
    2d25:	75 e1                	jne    2d08 <sbrktest+0x220>
  if(c == (char*)0xffffffff){
    2d27:	46                   	inc    %esi
    2d28:	0f 84 44 01 00 00    	je     2e72 <sbrktest+0x38a>
  if(sbrk(0) > oldbrk)
    2d2e:	83 ec 0c             	sub    $0xc,%esp
    2d31:	6a 00                	push   $0x0
    2d33:	e8 bf 08 00 00       	call   35f7 <sbrk>
    2d38:	83 c4 10             	add    $0x10,%esp
    2d3b:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    2d3e:	72 62                	jb     2da2 <sbrktest+0x2ba>
  printf(stdout, "sbrk test OK\n");
    2d40:	83 ec 08             	sub    $0x8,%esp
    2d43:	68 14 48 00 00       	push   $0x4814
    2d48:	ff 35 9c 51 00 00    	push   0x519c
    2d4e:	e8 45 09 00 00       	call   3698 <printf>
}
    2d53:	83 c4 10             	add    $0x10,%esp
    2d56:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2d59:	5b                   	pop    %ebx
    2d5a:	5e                   	pop    %esi
    2d5b:	5f                   	pop    %edi
    2d5c:	5d                   	pop    %ebp
    2d5d:	c3                   	ret    
      sbrk(BIG - (uint)sbrk(0));
    2d5e:	83 ec 0c             	sub    $0xc,%esp
    2d61:	6a 00                	push   $0x0
    2d63:	e8 8f 08 00 00       	call   35f7 <sbrk>
    2d68:	89 c2                	mov    %eax,%edx
    2d6a:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2d6f:	29 d0                	sub    %edx,%eax
    2d71:	89 04 24             	mov    %eax,(%esp)
    2d74:	e8 7e 08 00 00       	call   35f7 <sbrk>
      write(fds[1], "x", 1);
    2d79:	83 c4 0c             	add    $0xc,%esp
    2d7c:	6a 01                	push   $0x1
    2d7e:	68 d5 42 00 00       	push   $0x42d5
    2d83:	ff 75 bc             	push   -0x44(%ebp)
    2d86:	e8 04 08 00 00       	call   358f <write>
    2d8b:	83 c4 10             	add    $0x10,%esp
    2d8e:	66 90                	xchg   %ax,%ax
      for(;;) sleep(1000);
    2d90:	83 ec 0c             	sub    $0xc,%esp
    2d93:	68 e8 03 00 00       	push   $0x3e8
    2d98:	e8 62 08 00 00       	call   35ff <sleep>
    2d9d:	83 c4 10             	add    $0x10,%esp
    2da0:	eb ee                	jmp    2d90 <sbrktest+0x2a8>
    sbrk(-(sbrk(0) - oldbrk));
    2da2:	83 ec 0c             	sub    $0xc,%esp
    2da5:	6a 00                	push   $0x0
    2da7:	e8 4b 08 00 00       	call   35f7 <sbrk>
    2dac:	8b 55 a4             	mov    -0x5c(%ebp),%edx
    2daf:	29 c2                	sub    %eax,%edx
    2db1:	89 14 24             	mov    %edx,(%esp)
    2db4:	e8 3e 08 00 00       	call   35f7 <sbrk>
    2db9:	83 c4 10             	add    $0x10,%esp
    2dbc:	eb 82                	jmp    2d40 <sbrktest+0x258>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2dbe:	83 ec 0c             	sub    $0xc,%esp
    2dc1:	50                   	push   %eax
    2dc2:	53                   	push   %ebx
    2dc3:	56                   	push   %esi
    2dc4:	68 77 47 00 00       	push   $0x4777
    2dc9:	ff 35 9c 51 00 00    	push   0x519c
    2dcf:	e8 c4 08 00 00       	call   3698 <printf>
      exit();
    2dd4:	83 c4 20             	add    $0x20,%esp
    2dd7:	e8 93 07 00 00       	call   356f <exit>
      printf(stdout, "fork failed\n");
    2ddc:	83 ec 08             	sub    $0x8,%esp
    2ddf:	68 bd 48 00 00       	push   $0x48bd
    2de4:	ff 35 9c 51 00 00    	push   0x519c
    2dea:	e8 a9 08 00 00       	call   3698 <printf>
      exit();
    2def:	e8 7b 07 00 00       	call   356f <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    2df4:	0f be 03             	movsbl (%ebx),%eax
    2df7:	50                   	push   %eax
    2df8:	53                   	push   %ebx
    2df9:	68 e0 47 00 00       	push   $0x47e0
    2dfe:	ff 35 9c 51 00 00    	push   0x519c
    2e04:	e8 8f 08 00 00       	call   3698 <printf>
      kill(ppid);
    2e09:	89 34 24             	mov    %esi,(%esp)
    2e0c:	e8 8e 07 00 00       	call   359f <kill>
      exit();
    2e11:	e8 59 07 00 00       	call   356f <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    2e16:	50                   	push   %eax
    2e17:	53                   	push   %ebx
    2e18:	68 c0 4f 00 00       	push   $0x4fc0
    2e1d:	ff 35 9c 51 00 00    	push   0x519c
    2e23:	e8 70 08 00 00       	call   3698 <printf>
    exit();
    2e28:	e8 42 07 00 00       	call   356f <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    2e2d:	57                   	push   %edi
    2e2e:	57                   	push   %edi
    2e2f:	68 f0 4e 00 00       	push   $0x4ef0
    2e34:	ff 35 9c 51 00 00    	push   0x519c
    2e3a:	e8 59 08 00 00       	call   3698 <printf>
    exit();
    2e3f:	e8 2b 07 00 00       	call   356f <exit>
    printf(stdout, "sbrk test fork failed\n");
    2e44:	50                   	push   %eax
    2e45:	50                   	push   %eax
    2e46:	68 92 47 00 00       	push   $0x4792
    2e4b:	ff 35 9c 51 00 00    	push   0x519c
    2e51:	e8 42 08 00 00       	call   3698 <printf>
    exit();
    2e56:	e8 14 07 00 00       	call   356f <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    2e5b:	53                   	push   %ebx
    2e5c:	53                   	push   %ebx
    2e5d:	68 90 4f 00 00       	push   $0x4f90
    2e62:	ff 35 9c 51 00 00    	push   0x519c
    2e68:	e8 2b 08 00 00       	call   3698 <printf>
    exit();
    2e6d:	e8 fd 06 00 00       	call   356f <exit>
    printf(stdout, "failed sbrk leaked memory\n");
    2e72:	50                   	push   %eax
    2e73:	50                   	push   %eax
    2e74:	68 f9 47 00 00       	push   $0x47f9
    2e79:	ff 35 9c 51 00 00    	push   0x519c
    2e7f:	e8 14 08 00 00       	call   3698 <printf>
    exit();
    2e84:	e8 e6 06 00 00       	call   356f <exit>
    printf(1, "pipe() failed\n");
    2e89:	51                   	push   %ecx
    2e8a:	51                   	push   %ecx
    2e8b:	68 b5 3c 00 00       	push   $0x3cb5
    2e90:	6a 01                	push   $0x1
    2e92:	e8 01 08 00 00       	call   3698 <printf>
    exit();
    2e97:	e8 d3 06 00 00       	call   356f <exit>
    exit();
    2e9c:	e8 ce 06 00 00       	call   356f <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    2ea1:	50                   	push   %eax
    2ea2:	50                   	push   %eax
    2ea3:	68 a9 47 00 00       	push   $0x47a9
    2ea8:	ff 35 9c 51 00 00    	push   0x519c
    2eae:	e8 e5 07 00 00       	call   3698 <printf>
    exit();
    2eb3:	e8 b7 06 00 00       	call   356f <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    2eb8:	56                   	push   %esi
    2eb9:	53                   	push   %ebx
    2eba:	68 68 4f 00 00       	push   $0x4f68
    2ebf:	ff 35 9c 51 00 00    	push   0x519c
    2ec5:	e8 ce 07 00 00       	call   3698 <printf>
    exit();
    2eca:	e8 a0 06 00 00       	call   356f <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    2ecf:	50                   	push   %eax
    2ed0:	53                   	push   %ebx
    2ed1:	68 30 4f 00 00       	push   $0x4f30
    2ed6:	ff 35 9c 51 00 00    	push   0x519c
    2edc:	e8 b7 07 00 00       	call   3698 <printf>
    exit();
    2ee1:	e8 89 06 00 00       	call   356f <exit>
    printf(stdout, "sbrk could not deallocate\n");
    2ee6:	56                   	push   %esi
    2ee7:	56                   	push   %esi
    2ee8:	68 c5 47 00 00       	push   $0x47c5
    2eed:	ff 35 9c 51 00 00    	push   0x519c
    2ef3:	e8 a0 07 00 00       	call   3698 <printf>
    exit();
    2ef8:	e8 72 06 00 00       	call   356f <exit>
    2efd:	8d 76 00             	lea    0x0(%esi),%esi

00002f00 <validateint>:
}
    2f00:	c3                   	ret    
    2f01:	8d 76 00             	lea    0x0(%esi),%esi

00002f04 <validatetest>:
{
    2f04:	55                   	push   %ebp
    2f05:	89 e5                	mov    %esp,%ebp
    2f07:	56                   	push   %esi
    2f08:	53                   	push   %ebx
  printf(stdout, "validate test\n");
    2f09:	83 ec 08             	sub    $0x8,%esp
    2f0c:	68 22 48 00 00       	push   $0x4822
    2f11:	ff 35 9c 51 00 00    	push   0x519c
    2f17:	e8 7c 07 00 00       	call   3698 <printf>
    2f1c:	83 c4 10             	add    $0x10,%esp
  for(p = 0; p <= (uint)hi; p += 4096){
    2f1f:	31 f6                	xor    %esi,%esi
    2f21:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    2f24:	e8 3e 06 00 00       	call   3567 <fork>
    2f29:	89 c3                	mov    %eax,%ebx
    2f2b:	85 c0                	test   %eax,%eax
    2f2d:	74 61                	je     2f90 <validatetest+0x8c>
    sleep(0);
    2f2f:	83 ec 0c             	sub    $0xc,%esp
    2f32:	6a 00                	push   $0x0
    2f34:	e8 c6 06 00 00       	call   35ff <sleep>
    sleep(0);
    2f39:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f40:	e8 ba 06 00 00       	call   35ff <sleep>
    kill(pid);
    2f45:	89 1c 24             	mov    %ebx,(%esp)
    2f48:	e8 52 06 00 00       	call   359f <kill>
    wait();
    2f4d:	e8 25 06 00 00       	call   3577 <wait>
    if(link("nosuchfile", (char*)p) != -1){
    2f52:	58                   	pop    %eax
    2f53:	5a                   	pop    %edx
    2f54:	56                   	push   %esi
    2f55:	68 31 48 00 00       	push   $0x4831
    2f5a:	e8 70 06 00 00       	call   35cf <link>
    2f5f:	83 c4 10             	add    $0x10,%esp
    2f62:	40                   	inc    %eax
    2f63:	75 30                	jne    2f95 <validatetest+0x91>
  for(p = 0; p <= (uint)hi; p += 4096){
    2f65:	81 c6 00 10 00 00    	add    $0x1000,%esi
    2f6b:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
    2f71:	75 b1                	jne    2f24 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    2f73:	83 ec 08             	sub    $0x8,%esp
    2f76:	68 55 48 00 00       	push   $0x4855
    2f7b:	ff 35 9c 51 00 00    	push   0x519c
    2f81:	e8 12 07 00 00       	call   3698 <printf>
}
    2f86:	83 c4 10             	add    $0x10,%esp
    2f89:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2f8c:	5b                   	pop    %ebx
    2f8d:	5e                   	pop    %esi
    2f8e:	5d                   	pop    %ebp
    2f8f:	c3                   	ret    
      exit();
    2f90:	e8 da 05 00 00       	call   356f <exit>
      printf(stdout, "link should not succeed\n");
    2f95:	83 ec 08             	sub    $0x8,%esp
    2f98:	68 3c 48 00 00       	push   $0x483c
    2f9d:	ff 35 9c 51 00 00    	push   0x519c
    2fa3:	e8 f0 06 00 00       	call   3698 <printf>
      exit();
    2fa8:	e8 c2 05 00 00       	call   356f <exit>
    2fad:	8d 76 00             	lea    0x0(%esi),%esi

00002fb0 <bsstest>:
{
    2fb0:	55                   	push   %ebp
    2fb1:	89 e5                	mov    %esp,%ebp
    2fb3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
    2fb6:	68 62 48 00 00       	push   $0x4862
    2fbb:	ff 35 9c 51 00 00    	push   0x519c
    2fc1:	e8 d2 06 00 00       	call   3698 <printf>
    2fc6:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    2fc9:	31 c0                	xor    %eax,%eax
    2fcb:	90                   	nop
    if(uninit[i] != '\0'){
    2fcc:	80 b8 c0 51 00 00 00 	cmpb   $0x0,0x51c0(%eax)
    2fd3:	75 20                	jne    2ff5 <bsstest+0x45>
  for(i = 0; i < sizeof(uninit); i++){
    2fd5:	40                   	inc    %eax
    2fd6:	3d 10 27 00 00       	cmp    $0x2710,%eax
    2fdb:	75 ef                	jne    2fcc <bsstest+0x1c>
  printf(stdout, "bss test ok\n");
    2fdd:	83 ec 08             	sub    $0x8,%esp
    2fe0:	68 7d 48 00 00       	push   $0x487d
    2fe5:	ff 35 9c 51 00 00    	push   0x519c
    2feb:	e8 a8 06 00 00       	call   3698 <printf>
}
    2ff0:	83 c4 10             	add    $0x10,%esp
    2ff3:	c9                   	leave  
    2ff4:	c3                   	ret    
      printf(stdout, "bss test failed\n");
    2ff5:	83 ec 08             	sub    $0x8,%esp
    2ff8:	68 6c 48 00 00       	push   $0x486c
    2ffd:	ff 35 9c 51 00 00    	push   0x519c
    3003:	e8 90 06 00 00       	call   3698 <printf>
      exit();
    3008:	e8 62 05 00 00       	call   356f <exit>
    300d:	8d 76 00             	lea    0x0(%esi),%esi

00003010 <bigargtest>:
{
    3010:	55                   	push   %ebp
    3011:	89 e5                	mov    %esp,%ebp
    3013:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
    3016:	68 8a 48 00 00       	push   $0x488a
    301b:	e8 9f 05 00 00       	call   35bf <unlink>
  pid = fork();
    3020:	e8 42 05 00 00       	call   3567 <fork>
  if(pid == 0){
    3025:	83 c4 10             	add    $0x10,%esp
    3028:	85 c0                	test   %eax,%eax
    302a:	74 40                	je     306c <bigargtest+0x5c>
  } else if(pid < 0){
    302c:	0f 88 bf 00 00 00    	js     30f1 <bigargtest+0xe1>
  wait();
    3032:	e8 40 05 00 00       	call   3577 <wait>
  fd = open("bigarg-ok", 0);
    3037:	83 ec 08             	sub    $0x8,%esp
    303a:	6a 00                	push   $0x0
    303c:	68 8a 48 00 00       	push   $0x488a
    3041:	e8 69 05 00 00       	call   35af <open>
  if(fd < 0){
    3046:	83 c4 10             	add    $0x10,%esp
    3049:	85 c0                	test   %eax,%eax
    304b:	0f 88 89 00 00 00    	js     30da <bigargtest+0xca>
  close(fd);
    3051:	83 ec 0c             	sub    $0xc,%esp
    3054:	50                   	push   %eax
    3055:	e8 3d 05 00 00       	call   3597 <close>
  unlink("bigarg-ok");
    305a:	c7 04 24 8a 48 00 00 	movl   $0x488a,(%esp)
    3061:	e8 59 05 00 00       	call   35bf <unlink>
}
    3066:	83 c4 10             	add    $0x10,%esp
    3069:	c9                   	leave  
    306a:	c3                   	ret    
    306b:	90                   	nop
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    306c:	c7 04 85 e0 98 00 00 	movl   $0x4fe4,0x98e0(,%eax,4)
    3073:	e4 4f 00 00 
    for(i = 0; i < MAXARG-1; i++)
    3077:	40                   	inc    %eax
    3078:	83 f8 1f             	cmp    $0x1f,%eax
    307b:	75 ef                	jne    306c <bigargtest+0x5c>
    args[MAXARG-1] = 0;
    307d:	c7 05 5c 99 00 00 00 	movl   $0x0,0x995c
    3084:	00 00 00 
    printf(stdout, "bigarg test\n");
    3087:	51                   	push   %ecx
    3088:	51                   	push   %ecx
    3089:	68 94 48 00 00       	push   $0x4894
    308e:	ff 35 9c 51 00 00    	push   0x519c
    3094:	e8 ff 05 00 00       	call   3698 <printf>
    exec("echo", args);
    3099:	58                   	pop    %eax
    309a:	5a                   	pop    %edx
    309b:	68 e0 98 00 00       	push   $0x98e0
    30a0:	68 61 3a 00 00       	push   $0x3a61
    30a5:	e8 fd 04 00 00       	call   35a7 <exec>
    printf(stdout, "bigarg test ok\n");
    30aa:	59                   	pop    %ecx
    30ab:	58                   	pop    %eax
    30ac:	68 a1 48 00 00       	push   $0x48a1
    30b1:	ff 35 9c 51 00 00    	push   0x519c
    30b7:	e8 dc 05 00 00       	call   3698 <printf>
    fd = open("bigarg-ok", O_CREATE);
    30bc:	58                   	pop    %eax
    30bd:	5a                   	pop    %edx
    30be:	68 00 02 00 00       	push   $0x200
    30c3:	68 8a 48 00 00       	push   $0x488a
    30c8:	e8 e2 04 00 00       	call   35af <open>
    close(fd);
    30cd:	89 04 24             	mov    %eax,(%esp)
    30d0:	e8 c2 04 00 00       	call   3597 <close>
    exit();
    30d5:	e8 95 04 00 00       	call   356f <exit>
    printf(stdout, "bigarg test failed!\n");
    30da:	50                   	push   %eax
    30db:	50                   	push   %eax
    30dc:	68 ca 48 00 00       	push   $0x48ca
    30e1:	ff 35 9c 51 00 00    	push   0x519c
    30e7:	e8 ac 05 00 00       	call   3698 <printf>
    exit();
    30ec:	e8 7e 04 00 00       	call   356f <exit>
    printf(stdout, "bigargtest: fork failed\n");
    30f1:	52                   	push   %edx
    30f2:	52                   	push   %edx
    30f3:	68 b1 48 00 00       	push   $0x48b1
    30f8:	ff 35 9c 51 00 00    	push   0x519c
    30fe:	e8 95 05 00 00       	call   3698 <printf>
    exit();
    3103:	e8 67 04 00 00       	call   356f <exit>

00003108 <fsfull>:
{
    3108:	55                   	push   %ebp
    3109:	89 e5                	mov    %esp,%ebp
    310b:	57                   	push   %edi
    310c:	56                   	push   %esi
    310d:	53                   	push   %ebx
    310e:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
    3111:	68 df 48 00 00       	push   $0x48df
    3116:	6a 01                	push   $0x1
    3118:	e8 7b 05 00 00       	call   3698 <printf>
    311d:	83 c4 10             	add    $0x10,%esp
  for(nfiles = 0; ; nfiles++){
    3120:	31 f6                	xor    %esi,%esi
    3122:	66 90                	xchg   %ax,%ax
    name[0] = 'f';
    3124:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3128:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    312d:	f7 e6                	mul    %esi
    312f:	c1 ea 06             	shr    $0x6,%edx
    3132:	83 c2 30             	add    $0x30,%edx
    3135:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3138:	89 f0                	mov    %esi,%eax
    313a:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
    313f:	99                   	cltd   
    3140:	f7 f9                	idiv   %ecx
    3142:	b9 1f 85 eb 51       	mov    $0x51eb851f,%ecx
    3147:	89 d0                	mov    %edx,%eax
    3149:	f7 e1                	mul    %ecx
    314b:	c1 ea 05             	shr    $0x5,%edx
    314e:	83 c2 30             	add    $0x30,%edx
    3151:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3154:	b9 64 00 00 00       	mov    $0x64,%ecx
    3159:	89 f0                	mov    %esi,%eax
    315b:	99                   	cltd   
    315c:	f7 f9                	idiv   %ecx
    315e:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    3163:	89 d0                	mov    %edx,%eax
    3165:	f7 e1                	mul    %ecx
    3167:	c1 ea 03             	shr    $0x3,%edx
    316a:	83 c2 30             	add    $0x30,%edx
    316d:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3170:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3175:	89 f0                	mov    %esi,%eax
    3177:	99                   	cltd   
    3178:	f7 f9                	idiv   %ecx
    317a:	83 c2 30             	add    $0x30,%edx
    317d:	88 55 ac             	mov    %dl,-0x54(%ebp)
    name[5] = '\0';
    3180:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    printf(1, "writing %s\n", name);
    3184:	53                   	push   %ebx
    3185:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3188:	50                   	push   %eax
    3189:	68 ec 48 00 00       	push   $0x48ec
    318e:	6a 01                	push   $0x1
    3190:	e8 03 05 00 00       	call   3698 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3195:	5f                   	pop    %edi
    3196:	58                   	pop    %eax
    3197:	68 02 02 00 00       	push   $0x202
    319c:	8d 45 a8             	lea    -0x58(%ebp),%eax
    319f:	50                   	push   %eax
    31a0:	e8 0a 04 00 00       	call   35af <open>
    31a5:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    31a7:	83 c4 10             	add    $0x10,%esp
    31aa:	85 c0                	test   %eax,%eax
    31ac:	78 46                	js     31f4 <fsfull+0xec>
    int total = 0;
    31ae:	31 db                	xor    %ebx,%ebx
    31b0:	eb 04                	jmp    31b6 <fsfull+0xae>
    31b2:	66 90                	xchg   %ax,%ax
      total += cc;
    31b4:	01 c3                	add    %eax,%ebx
      int cc = write(fd, buf, 512);
    31b6:	52                   	push   %edx
    31b7:	68 00 02 00 00       	push   $0x200
    31bc:	68 e0 78 00 00       	push   $0x78e0
    31c1:	57                   	push   %edi
    31c2:	e8 c8 03 00 00       	call   358f <write>
      if(cc < 512)
    31c7:	83 c4 10             	add    $0x10,%esp
    31ca:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    31cf:	7f e3                	jg     31b4 <fsfull+0xac>
    printf(1, "wrote %d bytes\n", total);
    31d1:	50                   	push   %eax
    31d2:	53                   	push   %ebx
    31d3:	68 08 49 00 00       	push   $0x4908
    31d8:	6a 01                	push   $0x1
    31da:	e8 b9 04 00 00       	call   3698 <printf>
    close(fd);
    31df:	89 3c 24             	mov    %edi,(%esp)
    31e2:	e8 b0 03 00 00       	call   3597 <close>
    if(total == 0)
    31e7:	83 c4 10             	add    $0x10,%esp
    31ea:	85 db                	test   %ebx,%ebx
    31ec:	74 1a                	je     3208 <fsfull+0x100>
  for(nfiles = 0; ; nfiles++){
    31ee:	46                   	inc    %esi
    31ef:	e9 30 ff ff ff       	jmp    3124 <fsfull+0x1c>
      printf(1, "open %s failed\n", name);
    31f4:	51                   	push   %ecx
    31f5:	8d 45 a8             	lea    -0x58(%ebp),%eax
    31f8:	50                   	push   %eax
    31f9:	68 f8 48 00 00       	push   $0x48f8
    31fe:	6a 01                	push   $0x1
    3200:	e8 93 04 00 00       	call   3698 <printf>
      break;
    3205:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    3208:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    320d:	bb e8 03 00 00       	mov    $0x3e8,%ebx
    3212:	66 90                	xchg   %ax,%ax
    name[0] = 'f';
    3214:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3218:	89 f0                	mov    %esi,%eax
    321a:	f7 e7                	mul    %edi
    321c:	c1 ea 06             	shr    $0x6,%edx
    321f:	83 c2 30             	add    $0x30,%edx
    3222:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3225:	89 f0                	mov    %esi,%eax
    3227:	99                   	cltd   
    3228:	f7 fb                	idiv   %ebx
    322a:	b9 1f 85 eb 51       	mov    $0x51eb851f,%ecx
    322f:	89 d0                	mov    %edx,%eax
    3231:	f7 e1                	mul    %ecx
    3233:	c1 ea 05             	shr    $0x5,%edx
    3236:	83 c2 30             	add    $0x30,%edx
    3239:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    323c:	b9 64 00 00 00       	mov    $0x64,%ecx
    3241:	89 f0                	mov    %esi,%eax
    3243:	99                   	cltd   
    3244:	f7 f9                	idiv   %ecx
    3246:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    324b:	89 d0                	mov    %edx,%eax
    324d:	f7 e1                	mul    %ecx
    324f:	c1 ea 03             	shr    $0x3,%edx
    3252:	83 c2 30             	add    $0x30,%edx
    3255:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3258:	b9 0a 00 00 00       	mov    $0xa,%ecx
    325d:	89 f0                	mov    %esi,%eax
    325f:	99                   	cltd   
    3260:	f7 f9                	idiv   %ecx
    3262:	83 c2 30             	add    $0x30,%edx
    3265:	88 55 ac             	mov    %dl,-0x54(%ebp)
    name[5] = '\0';
    3268:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    unlink(name);
    326c:	83 ec 0c             	sub    $0xc,%esp
    326f:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3272:	50                   	push   %eax
    3273:	e8 47 03 00 00       	call   35bf <unlink>
    nfiles--;
    3278:	4e                   	dec    %esi
  while(nfiles >= 0){
    3279:	83 c4 10             	add    $0x10,%esp
    327c:	83 fe ff             	cmp    $0xffffffff,%esi
    327f:	75 93                	jne    3214 <fsfull+0x10c>
  printf(1, "fsfull test finished\n");
    3281:	83 ec 08             	sub    $0x8,%esp
    3284:	68 18 49 00 00       	push   $0x4918
    3289:	6a 01                	push   $0x1
    328b:	e8 08 04 00 00       	call   3698 <printf>
}
    3290:	83 c4 10             	add    $0x10,%esp
    3293:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3296:	5b                   	pop    %ebx
    3297:	5e                   	pop    %esi
    3298:	5f                   	pop    %edi
    3299:	5d                   	pop    %ebp
    329a:	c3                   	ret    
    329b:	90                   	nop

0000329c <uio>:
{
    329c:	55                   	push   %ebp
    329d:	89 e5                	mov    %esp,%ebp
    329f:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
    32a2:	68 2e 49 00 00       	push   $0x492e
    32a7:	6a 01                	push   $0x1
    32a9:	e8 ea 03 00 00       	call   3698 <printf>
  pid = fork();
    32ae:	e8 b4 02 00 00       	call   3567 <fork>
  if(pid == 0){
    32b3:	83 c4 10             	add    $0x10,%esp
    32b6:	85 c0                	test   %eax,%eax
    32b8:	74 1b                	je     32d5 <uio+0x39>
  } else if(pid < 0){
    32ba:	78 3a                	js     32f6 <uio+0x5a>
  wait();
    32bc:	e8 b6 02 00 00       	call   3577 <wait>
  printf(1, "uio test done\n");
    32c1:	83 ec 08             	sub    $0x8,%esp
    32c4:	68 38 49 00 00       	push   $0x4938
    32c9:	6a 01                	push   $0x1
    32cb:	e8 c8 03 00 00       	call   3698 <printf>
}
    32d0:	83 c4 10             	add    $0x10,%esp
    32d3:	c9                   	leave  
    32d4:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    32d5:	b0 09                	mov    $0x9,%al
    32d7:	ba 70 00 00 00       	mov    $0x70,%edx
    32dc:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    32dd:	ba 71 00 00 00       	mov    $0x71,%edx
    32e2:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    32e3:	52                   	push   %edx
    32e4:	52                   	push   %edx
    32e5:	68 c4 50 00 00       	push   $0x50c4
    32ea:	6a 01                	push   $0x1
    32ec:	e8 a7 03 00 00       	call   3698 <printf>
    exit();
    32f1:	e8 79 02 00 00       	call   356f <exit>
    printf (1, "fork failed\n");
    32f6:	50                   	push   %eax
    32f7:	50                   	push   %eax
    32f8:	68 bd 48 00 00       	push   $0x48bd
    32fd:	6a 01                	push   $0x1
    32ff:	e8 94 03 00 00       	call   3698 <printf>
    exit();
    3304:	e8 66 02 00 00       	call   356f <exit>
    3309:	8d 76 00             	lea    0x0(%esi),%esi

0000330c <argptest>:
{
    330c:	55                   	push   %ebp
    330d:	89 e5                	mov    %esp,%ebp
    330f:	53                   	push   %ebx
    3310:	83 ec 0c             	sub    $0xc,%esp
  fd = open("init", O_RDONLY);
    3313:	6a 00                	push   $0x0
    3315:	68 47 49 00 00       	push   $0x4947
    331a:	e8 90 02 00 00       	call   35af <open>
  if (fd < 0) {
    331f:	83 c4 10             	add    $0x10,%esp
    3322:	85 c0                	test   %eax,%eax
    3324:	78 37                	js     335d <argptest+0x51>
    3326:	89 c3                	mov    %eax,%ebx
  read(fd, sbrk(0) - 1, -1);
    3328:	83 ec 0c             	sub    $0xc,%esp
    332b:	6a 00                	push   $0x0
    332d:	e8 c5 02 00 00       	call   35f7 <sbrk>
    3332:	83 c4 0c             	add    $0xc,%esp
    3335:	6a ff                	push   $0xffffffff
    3337:	48                   	dec    %eax
    3338:	50                   	push   %eax
    3339:	53                   	push   %ebx
    333a:	e8 48 02 00 00       	call   3587 <read>
  close(fd);
    333f:	89 1c 24             	mov    %ebx,(%esp)
    3342:	e8 50 02 00 00       	call   3597 <close>
  printf(1, "arg test passed\n");
    3347:	58                   	pop    %eax
    3348:	5a                   	pop    %edx
    3349:	68 59 49 00 00       	push   $0x4959
    334e:	6a 01                	push   $0x1
    3350:	e8 43 03 00 00       	call   3698 <printf>
}
    3355:	83 c4 10             	add    $0x10,%esp
    3358:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    335b:	c9                   	leave  
    335c:	c3                   	ret    
    printf(2, "open failed\n");
    335d:	51                   	push   %ecx
    335e:	51                   	push   %ecx
    335f:	68 4c 49 00 00       	push   $0x494c
    3364:	6a 02                	push   $0x2
    3366:	e8 2d 03 00 00       	call   3698 <printf>
    exit();
    336b:	e8 ff 01 00 00       	call   356f <exit>

00003370 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    3370:	a1 98 51 00 00       	mov    0x5198,%eax
    3375:	8d 14 00             	lea    (%eax,%eax,1),%edx
    3378:	01 c2                	add    %eax,%edx
    337a:	8d 14 90             	lea    (%eax,%edx,4),%edx
    337d:	c1 e2 08             	shl    $0x8,%edx
    3380:	01 c2                	add    %eax,%edx
    3382:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3385:	8d 04 90             	lea    (%eax,%edx,4),%eax
    3388:	8d 04 80             	lea    (%eax,%eax,4),%eax
    338b:	8d 84 80 5f f3 6e 3c 	lea    0x3c6ef35f(%eax,%eax,4),%eax
    3392:	a3 98 51 00 00       	mov    %eax,0x5198
}
    3397:	c3                   	ret    

00003398 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3398:	55                   	push   %ebp
    3399:	89 e5                	mov    %esp,%ebp
    339b:	53                   	push   %ebx
    339c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    339f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    33a2:	31 c0                	xor    %eax,%eax
    33a4:	8a 14 03             	mov    (%ebx,%eax,1),%dl
    33a7:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    33aa:	40                   	inc    %eax
    33ab:	84 d2                	test   %dl,%dl
    33ad:	75 f5                	jne    33a4 <strcpy+0xc>
    ;
  return os;
}
    33af:	89 c8                	mov    %ecx,%eax
    33b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    33b4:	c9                   	leave  
    33b5:	c3                   	ret    
    33b6:	66 90                	xchg   %ax,%ax

000033b8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    33b8:	55                   	push   %ebp
    33b9:	89 e5                	mov    %esp,%ebp
    33bb:	53                   	push   %ebx
    33bc:	8b 55 08             	mov    0x8(%ebp),%edx
    33bf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
    33c2:	0f b6 02             	movzbl (%edx),%eax
    33c5:	84 c0                	test   %al,%al
    33c7:	75 10                	jne    33d9 <strcmp+0x21>
    33c9:	eb 2a                	jmp    33f5 <strcmp+0x3d>
    33cb:	90                   	nop
    p++, q++;
    33cc:	42                   	inc    %edx
    33cd:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
    33d0:	0f b6 02             	movzbl (%edx),%eax
    33d3:	84 c0                	test   %al,%al
    33d5:	74 11                	je     33e8 <strcmp+0x30>
    p++, q++;
    33d7:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
    33d9:	0f b6 0b             	movzbl (%ebx),%ecx
    33dc:	38 c1                	cmp    %al,%cl
    33de:	74 ec                	je     33cc <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
    33e0:	29 c8                	sub    %ecx,%eax
}
    33e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    33e5:	c9                   	leave  
    33e6:	c3                   	ret    
    33e7:	90                   	nop
  return (uchar)*p - (uchar)*q;
    33e8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
    33ec:	31 c0                	xor    %eax,%eax
    33ee:	29 c8                	sub    %ecx,%eax
}
    33f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    33f3:	c9                   	leave  
    33f4:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    33f5:	0f b6 0b             	movzbl (%ebx),%ecx
    33f8:	31 c0                	xor    %eax,%eax
    33fa:	eb e4                	jmp    33e0 <strcmp+0x28>

000033fc <strlen>:

uint
strlen(const char *s)
{
    33fc:	55                   	push   %ebp
    33fd:	89 e5                	mov    %esp,%ebp
    33ff:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3402:	80 3a 00             	cmpb   $0x0,(%edx)
    3405:	74 15                	je     341c <strlen+0x20>
    3407:	31 c0                	xor    %eax,%eax
    3409:	8d 76 00             	lea    0x0(%esi),%esi
    340c:	40                   	inc    %eax
    340d:	89 c1                	mov    %eax,%ecx
    340f:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3413:	75 f7                	jne    340c <strlen+0x10>
    ;
  return n;
}
    3415:	89 c8                	mov    %ecx,%eax
    3417:	5d                   	pop    %ebp
    3418:	c3                   	ret    
    3419:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    341c:	31 c9                	xor    %ecx,%ecx
}
    341e:	89 c8                	mov    %ecx,%eax
    3420:	5d                   	pop    %ebp
    3421:	c3                   	ret    
    3422:	66 90                	xchg   %ax,%ax

00003424 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3424:	55                   	push   %ebp
    3425:	89 e5                	mov    %esp,%ebp
    3427:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3428:	8b 7d 08             	mov    0x8(%ebp),%edi
    342b:	8b 4d 10             	mov    0x10(%ebp),%ecx
    342e:	8b 45 0c             	mov    0xc(%ebp),%eax
    3431:	fc                   	cld    
    3432:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3434:	8b 45 08             	mov    0x8(%ebp),%eax
    3437:	8b 7d fc             	mov    -0x4(%ebp),%edi
    343a:	c9                   	leave  
    343b:	c3                   	ret    

0000343c <strchr>:

char*
strchr(const char *s, char c)
{
    343c:	55                   	push   %ebp
    343d:	89 e5                	mov    %esp,%ebp
    343f:	8b 45 08             	mov    0x8(%ebp),%eax
    3442:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
    3445:	8a 10                	mov    (%eax),%dl
    3447:	84 d2                	test   %dl,%dl
    3449:	75 0c                	jne    3457 <strchr+0x1b>
    344b:	eb 13                	jmp    3460 <strchr+0x24>
    344d:	8d 76 00             	lea    0x0(%esi),%esi
    3450:	40                   	inc    %eax
    3451:	8a 10                	mov    (%eax),%dl
    3453:	84 d2                	test   %dl,%dl
    3455:	74 09                	je     3460 <strchr+0x24>
    if(*s == c)
    3457:	38 d1                	cmp    %dl,%cl
    3459:	75 f5                	jne    3450 <strchr+0x14>
      return (char*)s;
  return 0;
}
    345b:	5d                   	pop    %ebp
    345c:	c3                   	ret    
    345d:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
    3460:	31 c0                	xor    %eax,%eax
}
    3462:	5d                   	pop    %ebp
    3463:	c3                   	ret    

00003464 <gets>:

char*
gets(char *buf, int max)
{
    3464:	55                   	push   %ebp
    3465:	89 e5                	mov    %esp,%ebp
    3467:	57                   	push   %edi
    3468:	56                   	push   %esi
    3469:	53                   	push   %ebx
    346a:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    346d:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
    346f:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
    3472:	eb 24                	jmp    3498 <gets+0x34>
    cc = read(0, &c, 1);
    3474:	50                   	push   %eax
    3475:	6a 01                	push   $0x1
    3477:	57                   	push   %edi
    3478:	6a 00                	push   $0x0
    347a:	e8 08 01 00 00       	call   3587 <read>
    if(cc < 1)
    347f:	83 c4 10             	add    $0x10,%esp
    3482:	85 c0                	test   %eax,%eax
    3484:	7e 1c                	jle    34a2 <gets+0x3e>
      break;
    buf[i++] = c;
    3486:	8a 45 e7             	mov    -0x19(%ebp),%al
    3489:	8b 55 08             	mov    0x8(%ebp),%edx
    348c:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    3490:	3c 0a                	cmp    $0xa,%al
    3492:	74 20                	je     34b4 <gets+0x50>
    3494:	3c 0d                	cmp    $0xd,%al
    3496:	74 1c                	je     34b4 <gets+0x50>
  for(i=0; i+1 < max; ){
    3498:	89 de                	mov    %ebx,%esi
    349a:	8d 5b 01             	lea    0x1(%ebx),%ebx
    349d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    34a0:	7c d2                	jl     3474 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    34a2:	8b 45 08             	mov    0x8(%ebp),%eax
    34a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    34a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    34ac:	5b                   	pop    %ebx
    34ad:	5e                   	pop    %esi
    34ae:	5f                   	pop    %edi
    34af:	5d                   	pop    %ebp
    34b0:	c3                   	ret    
    34b1:	8d 76 00             	lea    0x0(%esi),%esi
    34b4:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
    34b6:	8b 45 08             	mov    0x8(%ebp),%eax
    34b9:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    34bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    34c0:	5b                   	pop    %ebx
    34c1:	5e                   	pop    %esi
    34c2:	5f                   	pop    %edi
    34c3:	5d                   	pop    %ebp
    34c4:	c3                   	ret    
    34c5:	8d 76 00             	lea    0x0(%esi),%esi

000034c8 <stat>:

int
stat(const char *n, struct stat *st)
{
    34c8:	55                   	push   %ebp
    34c9:	89 e5                	mov    %esp,%ebp
    34cb:	56                   	push   %esi
    34cc:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    34cd:	83 ec 08             	sub    $0x8,%esp
    34d0:	6a 00                	push   $0x0
    34d2:	ff 75 08             	push   0x8(%ebp)
    34d5:	e8 d5 00 00 00       	call   35af <open>
  if(fd < 0)
    34da:	83 c4 10             	add    $0x10,%esp
    34dd:	85 c0                	test   %eax,%eax
    34df:	78 27                	js     3508 <stat+0x40>
    34e1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    34e3:	83 ec 08             	sub    $0x8,%esp
    34e6:	ff 75 0c             	push   0xc(%ebp)
    34e9:	50                   	push   %eax
    34ea:	e8 d8 00 00 00       	call   35c7 <fstat>
    34ef:	89 c6                	mov    %eax,%esi
  close(fd);
    34f1:	89 1c 24             	mov    %ebx,(%esp)
    34f4:	e8 9e 00 00 00       	call   3597 <close>
  return r;
    34f9:	83 c4 10             	add    $0x10,%esp
}
    34fc:	89 f0                	mov    %esi,%eax
    34fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3501:	5b                   	pop    %ebx
    3502:	5e                   	pop    %esi
    3503:	5d                   	pop    %ebp
    3504:	c3                   	ret    
    3505:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3508:	be ff ff ff ff       	mov    $0xffffffff,%esi
    350d:	eb ed                	jmp    34fc <stat+0x34>
    350f:	90                   	nop

00003510 <atoi>:

int
atoi(const char *s)
{
    3510:	55                   	push   %ebp
    3511:	89 e5                	mov    %esp,%ebp
    3513:	53                   	push   %ebx
    3514:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3517:	0f be 01             	movsbl (%ecx),%eax
    351a:	8d 50 d0             	lea    -0x30(%eax),%edx
    351d:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
    3520:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    3525:	77 16                	ja     353d <atoi+0x2d>
    3527:	90                   	nop
    n = n*10 + *s++ - '0';
    3528:	41                   	inc    %ecx
    3529:	8d 14 92             	lea    (%edx,%edx,4),%edx
    352c:	01 d2                	add    %edx,%edx
    352e:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
    3532:	0f be 01             	movsbl (%ecx),%eax
    3535:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3538:	80 fb 09             	cmp    $0x9,%bl
    353b:	76 eb                	jbe    3528 <atoi+0x18>
  return n;
}
    353d:	89 d0                	mov    %edx,%eax
    353f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3542:	c9                   	leave  
    3543:	c3                   	ret    

00003544 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3544:	55                   	push   %ebp
    3545:	89 e5                	mov    %esp,%ebp
    3547:	57                   	push   %edi
    3548:	56                   	push   %esi
    3549:	8b 55 08             	mov    0x8(%ebp),%edx
    354c:	8b 75 0c             	mov    0xc(%ebp),%esi
    354f:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3552:	85 c0                	test   %eax,%eax
    3554:	7e 0b                	jle    3561 <memmove+0x1d>
    3556:	01 d0                	add    %edx,%eax
  dst = vdst;
    3558:	89 d7                	mov    %edx,%edi
    355a:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
    355c:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    355d:	39 f8                	cmp    %edi,%eax
    355f:	75 fb                	jne    355c <memmove+0x18>
  return vdst;
}
    3561:	89 d0                	mov    %edx,%eax
    3563:	5e                   	pop    %esi
    3564:	5f                   	pop    %edi
    3565:	5d                   	pop    %ebp
    3566:	c3                   	ret    

00003567 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3567:	b8 01 00 00 00       	mov    $0x1,%eax
    356c:	cd 40                	int    $0x40
    356e:	c3                   	ret    

0000356f <exit>:
SYSCALL(exit)
    356f:	b8 02 00 00 00       	mov    $0x2,%eax
    3574:	cd 40                	int    $0x40
    3576:	c3                   	ret    

00003577 <wait>:
SYSCALL(wait)
    3577:	b8 03 00 00 00       	mov    $0x3,%eax
    357c:	cd 40                	int    $0x40
    357e:	c3                   	ret    

0000357f <pipe>:
SYSCALL(pipe)
    357f:	b8 04 00 00 00       	mov    $0x4,%eax
    3584:	cd 40                	int    $0x40
    3586:	c3                   	ret    

00003587 <read>:
SYSCALL(read)
    3587:	b8 05 00 00 00       	mov    $0x5,%eax
    358c:	cd 40                	int    $0x40
    358e:	c3                   	ret    

0000358f <write>:
SYSCALL(write)
    358f:	b8 10 00 00 00       	mov    $0x10,%eax
    3594:	cd 40                	int    $0x40
    3596:	c3                   	ret    

00003597 <close>:
SYSCALL(close)
    3597:	b8 15 00 00 00       	mov    $0x15,%eax
    359c:	cd 40                	int    $0x40
    359e:	c3                   	ret    

0000359f <kill>:
SYSCALL(kill)
    359f:	b8 06 00 00 00       	mov    $0x6,%eax
    35a4:	cd 40                	int    $0x40
    35a6:	c3                   	ret    

000035a7 <exec>:
SYSCALL(exec)
    35a7:	b8 07 00 00 00       	mov    $0x7,%eax
    35ac:	cd 40                	int    $0x40
    35ae:	c3                   	ret    

000035af <open>:
SYSCALL(open)
    35af:	b8 0f 00 00 00       	mov    $0xf,%eax
    35b4:	cd 40                	int    $0x40
    35b6:	c3                   	ret    

000035b7 <mknod>:
SYSCALL(mknod)
    35b7:	b8 11 00 00 00       	mov    $0x11,%eax
    35bc:	cd 40                	int    $0x40
    35be:	c3                   	ret    

000035bf <unlink>:
SYSCALL(unlink)
    35bf:	b8 12 00 00 00       	mov    $0x12,%eax
    35c4:	cd 40                	int    $0x40
    35c6:	c3                   	ret    

000035c7 <fstat>:
SYSCALL(fstat)
    35c7:	b8 08 00 00 00       	mov    $0x8,%eax
    35cc:	cd 40                	int    $0x40
    35ce:	c3                   	ret    

000035cf <link>:
SYSCALL(link)
    35cf:	b8 13 00 00 00       	mov    $0x13,%eax
    35d4:	cd 40                	int    $0x40
    35d6:	c3                   	ret    

000035d7 <mkdir>:
SYSCALL(mkdir)
    35d7:	b8 14 00 00 00       	mov    $0x14,%eax
    35dc:	cd 40                	int    $0x40
    35de:	c3                   	ret    

000035df <chdir>:
SYSCALL(chdir)
    35df:	b8 09 00 00 00       	mov    $0x9,%eax
    35e4:	cd 40                	int    $0x40
    35e6:	c3                   	ret    

000035e7 <dup>:
SYSCALL(dup)
    35e7:	b8 0a 00 00 00       	mov    $0xa,%eax
    35ec:	cd 40                	int    $0x40
    35ee:	c3                   	ret    

000035ef <getpid>:
SYSCALL(getpid)
    35ef:	b8 0b 00 00 00       	mov    $0xb,%eax
    35f4:	cd 40                	int    $0x40
    35f6:	c3                   	ret    

000035f7 <sbrk>:
SYSCALL(sbrk)
    35f7:	b8 0c 00 00 00       	mov    $0xc,%eax
    35fc:	cd 40                	int    $0x40
    35fe:	c3                   	ret    

000035ff <sleep>:
SYSCALL(sleep)
    35ff:	b8 0d 00 00 00       	mov    $0xd,%eax
    3604:	cd 40                	int    $0x40
    3606:	c3                   	ret    

00003607 <uptime>:
SYSCALL(uptime)
    3607:	b8 0e 00 00 00       	mov    $0xe,%eax
    360c:	cd 40                	int    $0x40
    360e:	c3                   	ret    
    360f:	90                   	nop

00003610 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3610:	55                   	push   %ebp
    3611:	89 e5                	mov    %esp,%ebp
    3613:	57                   	push   %edi
    3614:	56                   	push   %esi
    3615:	53                   	push   %ebx
    3616:	83 ec 3c             	sub    $0x3c,%esp
    3619:	89 45 bc             	mov    %eax,-0x44(%ebp)
    361c:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    361f:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
    3621:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3624:	85 db                	test   %ebx,%ebx
    3626:	74 04                	je     362c <printint+0x1c>
    3628:	85 d2                	test   %edx,%edx
    362a:	78 68                	js     3694 <printint+0x84>
  neg = 0;
    362c:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    3633:	31 ff                	xor    %edi,%edi
    3635:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
    3638:	89 c8                	mov    %ecx,%eax
    363a:	31 d2                	xor    %edx,%edx
    363c:	f7 75 c4             	divl   -0x3c(%ebp)
    363f:	89 fb                	mov    %edi,%ebx
    3641:	8d 7f 01             	lea    0x1(%edi),%edi
    3644:	8a 92 84 51 00 00    	mov    0x5184(%edx),%dl
    364a:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
    364e:	89 4d c0             	mov    %ecx,-0x40(%ebp)
    3651:	89 c1                	mov    %eax,%ecx
    3653:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    3656:	3b 45 c0             	cmp    -0x40(%ebp),%eax
    3659:	76 dd                	jbe    3638 <printint+0x28>
  if(neg)
    365b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    365e:	85 c9                	test   %ecx,%ecx
    3660:	74 09                	je     366b <printint+0x5b>
    buf[i++] = '-';
    3662:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
    3667:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
    3669:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
    366b:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
    366f:	8b 7d bc             	mov    -0x44(%ebp),%edi
    3672:	eb 03                	jmp    3677 <printint+0x67>
    putc(fd, buf[i]);
    3674:	8a 13                	mov    (%ebx),%dl
    3676:	4b                   	dec    %ebx
    3677:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
    367a:	50                   	push   %eax
    367b:	6a 01                	push   $0x1
    367d:	56                   	push   %esi
    367e:	57                   	push   %edi
    367f:	e8 0b ff ff ff       	call   358f <write>
  while(--i >= 0)
    3684:	83 c4 10             	add    $0x10,%esp
    3687:	39 de                	cmp    %ebx,%esi
    3689:	75 e9                	jne    3674 <printint+0x64>
}
    368b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    368e:	5b                   	pop    %ebx
    368f:	5e                   	pop    %esi
    3690:	5f                   	pop    %edi
    3691:	5d                   	pop    %ebp
    3692:	c3                   	ret    
    3693:	90                   	nop
    x = -xx;
    3694:	f7 d9                	neg    %ecx
    3696:	eb 9b                	jmp    3633 <printint+0x23>

00003698 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3698:	55                   	push   %ebp
    3699:	89 e5                	mov    %esp,%ebp
    369b:	57                   	push   %edi
    369c:	56                   	push   %esi
    369d:	53                   	push   %ebx
    369e:	83 ec 2c             	sub    $0x2c,%esp
    36a1:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    36a4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    36a7:	8a 13                	mov    (%ebx),%dl
    36a9:	84 d2                	test   %dl,%dl
    36ab:	74 64                	je     3711 <printf+0x79>
    36ad:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
    36ae:	8d 45 10             	lea    0x10(%ebp),%eax
    36b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
    36b4:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
    36b6:	8d 7d e7             	lea    -0x19(%ebp),%edi
    36b9:	eb 24                	jmp    36df <printf+0x47>
    36bb:	90                   	nop
    36bc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    36bf:	83 f8 25             	cmp    $0x25,%eax
    36c2:	74 40                	je     3704 <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
    36c4:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    36c7:	50                   	push   %eax
    36c8:	6a 01                	push   $0x1
    36ca:	57                   	push   %edi
    36cb:	56                   	push   %esi
    36cc:	e8 be fe ff ff       	call   358f <write>
        putc(fd, c);
    36d1:	83 c4 10             	add    $0x10,%esp
    36d4:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
    36d7:	43                   	inc    %ebx
    36d8:	8a 53 ff             	mov    -0x1(%ebx),%dl
    36db:	84 d2                	test   %dl,%dl
    36dd:	74 32                	je     3711 <printf+0x79>
    c = fmt[i] & 0xff;
    36df:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    36e2:	85 c9                	test   %ecx,%ecx
    36e4:	74 d6                	je     36bc <printf+0x24>
      }
    } else if(state == '%'){
    36e6:	83 f9 25             	cmp    $0x25,%ecx
    36e9:	75 ec                	jne    36d7 <printf+0x3f>
      if(c == 'd'){
    36eb:	83 f8 25             	cmp    $0x25,%eax
    36ee:	0f 84 e4 00 00 00    	je     37d8 <printf+0x140>
    36f4:	83 e8 63             	sub    $0x63,%eax
    36f7:	83 f8 15             	cmp    $0x15,%eax
    36fa:	77 20                	ja     371c <printf+0x84>
    36fc:	ff 24 85 2c 51 00 00 	jmp    *0x512c(,%eax,4)
    3703:	90                   	nop
        state = '%';
    3704:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
    3709:	43                   	inc    %ebx
    370a:	8a 53 ff             	mov    -0x1(%ebx),%dl
    370d:	84 d2                	test   %dl,%dl
    370f:	75 ce                	jne    36df <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3711:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3714:	5b                   	pop    %ebx
    3715:	5e                   	pop    %esi
    3716:	5f                   	pop    %edi
    3717:	5d                   	pop    %ebp
    3718:	c3                   	ret    
    3719:	8d 76 00             	lea    0x0(%esi),%esi
    371c:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
    371f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
    3723:	50                   	push   %eax
    3724:	6a 01                	push   $0x1
    3726:	57                   	push   %edi
    3727:	56                   	push   %esi
    3728:	e8 62 fe ff ff       	call   358f <write>
        putc(fd, c);
    372d:	8a 55 d4             	mov    -0x2c(%ebp),%dl
    3730:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    3733:	83 c4 0c             	add    $0xc,%esp
    3736:	6a 01                	push   $0x1
    3738:	57                   	push   %edi
    3739:	56                   	push   %esi
    373a:	e8 50 fe ff ff       	call   358f <write>
        putc(fd, c);
    373f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3742:	31 c9                	xor    %ecx,%ecx
    3744:	eb 91                	jmp    36d7 <printf+0x3f>
    3746:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    3748:	83 ec 0c             	sub    $0xc,%esp
    374b:	6a 00                	push   $0x0
    374d:	b9 10 00 00 00       	mov    $0x10,%ecx
    3752:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3755:	8b 10                	mov    (%eax),%edx
    3757:	89 f0                	mov    %esi,%eax
    3759:	e8 b2 fe ff ff       	call   3610 <printint>
        ap++;
    375e:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3762:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3765:	31 c9                	xor    %ecx,%ecx
        ap++;
    3767:	e9 6b ff ff ff       	jmp    36d7 <printf+0x3f>
        s = (char*)*ap;
    376c:	8b 45 d0             	mov    -0x30(%ebp),%eax
    376f:	8b 10                	mov    (%eax),%edx
        ap++;
    3771:	83 c0 04             	add    $0x4,%eax
    3774:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3777:	85 d2                	test   %edx,%edx
    3779:	74 69                	je     37e4 <printf+0x14c>
        while(*s != 0){
    377b:	8a 02                	mov    (%edx),%al
    377d:	84 c0                	test   %al,%al
    377f:	74 71                	je     37f2 <printf+0x15a>
    3781:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3784:	89 d3                	mov    %edx,%ebx
    3786:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
    3788:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    378b:	50                   	push   %eax
    378c:	6a 01                	push   $0x1
    378e:	57                   	push   %edi
    378f:	56                   	push   %esi
    3790:	e8 fa fd ff ff       	call   358f <write>
          s++;
    3795:	43                   	inc    %ebx
        while(*s != 0){
    3796:	8a 03                	mov    (%ebx),%al
    3798:	83 c4 10             	add    $0x10,%esp
    379b:	84 c0                	test   %al,%al
    379d:	75 e9                	jne    3788 <printf+0xf0>
      state = 0;
    379f:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    37a2:	31 c9                	xor    %ecx,%ecx
    37a4:	e9 2e ff ff ff       	jmp    36d7 <printf+0x3f>
    37a9:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    37ac:	83 ec 0c             	sub    $0xc,%esp
    37af:	6a 01                	push   $0x1
    37b1:	b9 0a 00 00 00       	mov    $0xa,%ecx
    37b6:	eb 9a                	jmp    3752 <printf+0xba>
        putc(fd, *ap);
    37b8:	8b 45 d0             	mov    -0x30(%ebp),%eax
    37bb:	8b 00                	mov    (%eax),%eax
    37bd:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    37c0:	51                   	push   %ecx
    37c1:	6a 01                	push   $0x1
    37c3:	57                   	push   %edi
    37c4:	56                   	push   %esi
    37c5:	e8 c5 fd ff ff       	call   358f <write>
        ap++;
    37ca:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    37ce:	83 c4 10             	add    $0x10,%esp
      state = 0;
    37d1:	31 c9                	xor    %ecx,%ecx
    37d3:	e9 ff fe ff ff       	jmp    36d7 <printf+0x3f>
        putc(fd, c);
    37d8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    37db:	52                   	push   %edx
    37dc:	e9 55 ff ff ff       	jmp    3736 <printf+0x9e>
    37e1:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
    37e4:	ba 24 51 00 00       	mov    $0x5124,%edx
        while(*s != 0){
    37e9:	b0 28                	mov    $0x28,%al
    37eb:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    37ee:	89 d3                	mov    %edx,%ebx
    37f0:	eb 96                	jmp    3788 <printf+0xf0>
      state = 0;
    37f2:	31 c9                	xor    %ecx,%ecx
    37f4:	e9 de fe ff ff       	jmp    36d7 <printf+0x3f>
    37f9:	66 90                	xchg   %ax,%ax
    37fb:	90                   	nop

000037fc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    37fc:	55                   	push   %ebp
    37fd:	89 e5                	mov    %esp,%ebp
    37ff:	57                   	push   %edi
    3800:	56                   	push   %esi
    3801:	53                   	push   %ebx
    3802:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3805:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3808:	a1 60 99 00 00       	mov    0x9960,%eax
    380d:	8d 76 00             	lea    0x0(%esi),%esi
    3810:	89 c2                	mov    %eax,%edx
    3812:	8b 00                	mov    (%eax),%eax
    3814:	39 ca                	cmp    %ecx,%edx
    3816:	73 2c                	jae    3844 <free+0x48>
    3818:	39 c1                	cmp    %eax,%ecx
    381a:	72 04                	jb     3820 <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    381c:	39 c2                	cmp    %eax,%edx
    381e:	72 f0                	jb     3810 <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3820:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3823:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3826:	39 f8                	cmp    %edi,%eax
    3828:	74 2c                	je     3856 <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    382a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    382d:	8b 42 04             	mov    0x4(%edx),%eax
    3830:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3833:	39 f1                	cmp    %esi,%ecx
    3835:	74 36                	je     386d <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    3837:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
    3839:	89 15 60 99 00 00    	mov    %edx,0x9960
}
    383f:	5b                   	pop    %ebx
    3840:	5e                   	pop    %esi
    3841:	5f                   	pop    %edi
    3842:	5d                   	pop    %ebp
    3843:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3844:	39 c2                	cmp    %eax,%edx
    3846:	72 c8                	jb     3810 <free+0x14>
    3848:	39 c1                	cmp    %eax,%ecx
    384a:	73 c4                	jae    3810 <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
    384c:	8b 73 fc             	mov    -0x4(%ebx),%esi
    384f:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3852:	39 f8                	cmp    %edi,%eax
    3854:	75 d4                	jne    382a <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
    3856:	03 70 04             	add    0x4(%eax),%esi
    3859:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    385c:	8b 02                	mov    (%edx),%eax
    385e:	8b 00                	mov    (%eax),%eax
    3860:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    3863:	8b 42 04             	mov    0x4(%edx),%eax
    3866:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3869:	39 f1                	cmp    %esi,%ecx
    386b:	75 ca                	jne    3837 <free+0x3b>
    p->s.size += bp->s.size;
    386d:	03 43 fc             	add    -0x4(%ebx),%eax
    3870:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3873:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3876:	89 0a                	mov    %ecx,(%edx)
  freep = p;
    3878:	89 15 60 99 00 00    	mov    %edx,0x9960
}
    387e:	5b                   	pop    %ebx
    387f:	5e                   	pop    %esi
    3880:	5f                   	pop    %edi
    3881:	5d                   	pop    %ebp
    3882:	c3                   	ret    
    3883:	90                   	nop

00003884 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3884:	55                   	push   %ebp
    3885:	89 e5                	mov    %esp,%ebp
    3887:	57                   	push   %edi
    3888:	56                   	push   %esi
    3889:	53                   	push   %ebx
    388a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    388d:	8b 45 08             	mov    0x8(%ebp),%eax
    3890:	8d 70 07             	lea    0x7(%eax),%esi
    3893:	c1 ee 03             	shr    $0x3,%esi
    3896:	46                   	inc    %esi
  if((prevp = freep) == 0){
    3897:	8b 3d 60 99 00 00    	mov    0x9960,%edi
    389d:	85 ff                	test   %edi,%edi
    389f:	0f 84 a3 00 00 00    	je     3948 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38a5:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    38a7:	8b 4a 04             	mov    0x4(%edx),%ecx
    38aa:	39 f1                	cmp    %esi,%ecx
    38ac:	73 68                	jae    3916 <malloc+0x92>
    38ae:	89 f3                	mov    %esi,%ebx
    38b0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    38b6:	0f 82 80 00 00 00    	jb     393c <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
    38bc:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    38c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    38c6:	eb 11                	jmp    38d9 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    38ca:	8b 48 04             	mov    0x4(%eax),%ecx
    38cd:	39 f1                	cmp    %esi,%ecx
    38cf:	73 4b                	jae    391c <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    38d1:	8b 3d 60 99 00 00    	mov    0x9960,%edi
    38d7:	89 c2                	mov    %eax,%edx
    38d9:	39 d7                	cmp    %edx,%edi
    38db:	75 eb                	jne    38c8 <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
    38dd:	83 ec 0c             	sub    $0xc,%esp
    38e0:	ff 75 e4             	push   -0x1c(%ebp)
    38e3:	e8 0f fd ff ff       	call   35f7 <sbrk>
  if(p == (char*)-1)
    38e8:	83 c4 10             	add    $0x10,%esp
    38eb:	83 f8 ff             	cmp    $0xffffffff,%eax
    38ee:	74 1c                	je     390c <malloc+0x88>
  hp->s.size = nu;
    38f0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    38f3:	83 ec 0c             	sub    $0xc,%esp
    38f6:	83 c0 08             	add    $0x8,%eax
    38f9:	50                   	push   %eax
    38fa:	e8 fd fe ff ff       	call   37fc <free>
  return freep;
    38ff:	8b 15 60 99 00 00    	mov    0x9960,%edx
      if((p = morecore(nunits)) == 0)
    3905:	83 c4 10             	add    $0x10,%esp
    3908:	85 d2                	test   %edx,%edx
    390a:	75 bc                	jne    38c8 <malloc+0x44>
        return 0;
    390c:	31 c0                	xor    %eax,%eax
  }
}
    390e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3911:	5b                   	pop    %ebx
    3912:	5e                   	pop    %esi
    3913:	5f                   	pop    %edi
    3914:	5d                   	pop    %ebp
    3915:	c3                   	ret    
    if(p->s.size >= nunits){
    3916:	89 d0                	mov    %edx,%eax
    3918:	89 fa                	mov    %edi,%edx
    391a:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
    391c:	39 ce                	cmp    %ecx,%esi
    391e:	74 54                	je     3974 <malloc+0xf0>
        p->s.size -= nunits;
    3920:	29 f1                	sub    %esi,%ecx
    3922:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3925:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3928:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    392b:	89 15 60 99 00 00    	mov    %edx,0x9960
      return (void*)(p + 1);
    3931:	83 c0 08             	add    $0x8,%eax
}
    3934:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3937:	5b                   	pop    %ebx
    3938:	5e                   	pop    %esi
    3939:	5f                   	pop    %edi
    393a:	5d                   	pop    %ebp
    393b:	c3                   	ret    
    393c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3941:	e9 76 ff ff ff       	jmp    38bc <malloc+0x38>
    3946:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    3948:	c7 05 60 99 00 00 64 	movl   $0x9964,0x9960
    394f:	99 00 00 
    3952:	c7 05 64 99 00 00 64 	movl   $0x9964,0x9964
    3959:	99 00 00 
    base.s.size = 0;
    395c:	c7 05 68 99 00 00 00 	movl   $0x0,0x9968
    3963:	00 00 00 
    3966:	bf 64 99 00 00       	mov    $0x9964,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    396b:	89 fa                	mov    %edi,%edx
    396d:	e9 3c ff ff ff       	jmp    38ae <malloc+0x2a>
    3972:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
    3974:	8b 08                	mov    (%eax),%ecx
    3976:	89 0a                	mov    %ecx,(%edx)
    3978:	eb b1                	jmp    392b <malloc+0xa7>
