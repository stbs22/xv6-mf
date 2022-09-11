
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

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
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       f:	eb 0c                	jmp    1d <main+0x1d>
      11:	8d 76 00             	lea    0x0(%esi),%esi
    if(fd >= 3){
      14:	83 f8 02             	cmp    $0x2,%eax
      17:	0f 8f 8b 00 00 00    	jg     a8 <main+0xa8>
  while((fd = open("console", O_RDWR)) >= 0){
      1d:	83 ec 08             	sub    $0x8,%esp
      20:	6a 02                	push   $0x2
      22:	68 75 11 00 00       	push   $0x1175
      27:	e8 d3 0c 00 00       	call   cff <open>
      2c:	83 c4 10             	add    $0x10,%esp
      2f:	85 c0                	test   %eax,%eax
      31:	79 e1                	jns    14 <main+0x14>
      33:	eb 2a                	jmp    5f <main+0x5f>
      35:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d 42 12 00 00 20 	cmpb   $0x20,0x1242
      3f:	0f 84 86 00 00 00    	je     cb <main+0xcb>
      45:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      48:	e8 6a 0c 00 00       	call   cb7 <fork>
  if(pid == -1)
      4d:	83 f8 ff             	cmp    $0xffffffff,%eax
      50:	0f 84 bf 00 00 00    	je     115 <main+0x115>
    if(fork1() == 0)
      56:	85 c0                	test   %eax,%eax
      58:	74 5c                	je     b6 <main+0xb6>
    wait();
      5a:	e8 68 0c 00 00       	call   cc7 <wait>
  printf(2, "$ ");
      5f:	83 ec 08             	sub    $0x8,%esp
      62:	68 d4 10 00 00       	push   $0x10d4
      67:	6a 02                	push   $0x2
      69:	e8 82 0d 00 00       	call   df0 <printf>
  memset(buf, 0, nbuf);
      6e:	83 c4 0c             	add    $0xc,%esp
      71:	6a 64                	push   $0x64
      73:	6a 00                	push   $0x0
      75:	68 40 12 00 00       	push   $0x1240
      7a:	e8 f5 0a 00 00       	call   b74 <memset>
  gets(buf, nbuf);
      7f:	58                   	pop    %eax
      80:	5a                   	pop    %edx
      81:	6a 64                	push   $0x64
      83:	68 40 12 00 00       	push   $0x1240
      88:	e8 27 0b 00 00       	call   bb4 <gets>
  if(buf[0] == 0) // EOF
      8d:	a0 40 12 00 00       	mov    0x1240,%al
      92:	83 c4 10             	add    $0x10,%esp
      95:	84 c0                	test   %al,%al
      97:	74 77                	je     110 <main+0x110>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      99:	3c 63                	cmp    $0x63,%al
      9b:	75 ab                	jne    48 <main+0x48>
      9d:	80 3d 41 12 00 00 64 	cmpb   $0x64,0x1241
      a4:	75 a2                	jne    48 <main+0x48>
      a6:	eb 90                	jmp    38 <main+0x38>
      close(fd);
      a8:	83 ec 0c             	sub    $0xc,%esp
      ab:	50                   	push   %eax
      ac:	e8 36 0c 00 00       	call   ce7 <close>
      break;
      b1:	83 c4 10             	add    $0x10,%esp
      b4:	eb a9                	jmp    5f <main+0x5f>
      runcmd(parsecmd(buf));
      b6:	83 ec 0c             	sub    $0xc,%esp
      b9:	68 40 12 00 00       	push   $0x1240
      be:	e8 bd 09 00 00       	call   a80 <parsecmd>
      c3:	89 04 24             	mov    %eax,(%esp)
      c6:	e8 d5 00 00 00       	call   1a0 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      cb:	83 ec 0c             	sub    $0xc,%esp
      ce:	68 40 12 00 00       	push   $0x1240
      d3:	e8 74 0a 00 00       	call   b4c <strlen>
      d8:	c6 80 3f 12 00 00 00 	movb   $0x0,0x123f(%eax)
      if(chdir(buf+3) < 0)
      df:	c7 04 24 43 12 00 00 	movl   $0x1243,(%esp)
      e6:	e8 44 0c 00 00       	call   d2f <chdir>
      eb:	83 c4 10             	add    $0x10,%esp
      ee:	85 c0                	test   %eax,%eax
      f0:	0f 89 69 ff ff ff    	jns    5f <main+0x5f>
        printf(2, "cannot cd %s\n", buf+3);
      f6:	51                   	push   %ecx
      f7:	68 43 12 00 00       	push   $0x1243
      fc:	68 7d 11 00 00       	push   $0x117d
     101:	6a 02                	push   $0x2
     103:	e8 e8 0c 00 00       	call   df0 <printf>
     108:	83 c4 10             	add    $0x10,%esp
     10b:	e9 4f ff ff ff       	jmp    5f <main+0x5f>
  exit();
     110:	e8 aa 0b 00 00       	call   cbf <exit>
    panic("fork");
     115:	83 ec 0c             	sub    $0xc,%esp
     118:	68 d7 10 00 00       	push   $0x10d7
     11d:	e8 42 00 00 00       	call   164 <panic>
     122:	66 90                	xchg   %ax,%ax

00000124 <getcmd>:
{
     124:	55                   	push   %ebp
     125:	89 e5                	mov    %esp,%ebp
     127:	56                   	push   %esi
     128:	53                   	push   %ebx
     129:	8b 5d 08             	mov    0x8(%ebp),%ebx
     12c:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     12f:	83 ec 08             	sub    $0x8,%esp
     132:	68 d4 10 00 00       	push   $0x10d4
     137:	6a 02                	push   $0x2
     139:	e8 b2 0c 00 00       	call   df0 <printf>
  memset(buf, 0, nbuf);
     13e:	83 c4 0c             	add    $0xc,%esp
     141:	56                   	push   %esi
     142:	6a 00                	push   $0x0
     144:	53                   	push   %ebx
     145:	e8 2a 0a 00 00       	call   b74 <memset>
  gets(buf, nbuf);
     14a:	58                   	pop    %eax
     14b:	5a                   	pop    %edx
     14c:	56                   	push   %esi
     14d:	53                   	push   %ebx
     14e:	e8 61 0a 00 00       	call   bb4 <gets>
  if(buf[0] == 0) // EOF
     153:	83 c4 10             	add    $0x10,%esp
     156:	80 3b 01             	cmpb   $0x1,(%ebx)
     159:	19 c0                	sbb    %eax,%eax
}
     15b:	8d 65 f8             	lea    -0x8(%ebp),%esp
     15e:	5b                   	pop    %ebx
     15f:	5e                   	pop    %esi
     160:	5d                   	pop    %ebp
     161:	c3                   	ret    
     162:	66 90                	xchg   %ax,%ax

00000164 <panic>:
{
     164:	55                   	push   %ebp
     165:	89 e5                	mov    %esp,%ebp
     167:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     16a:	ff 75 08             	push   0x8(%ebp)
     16d:	68 71 11 00 00       	push   $0x1171
     172:	6a 02                	push   $0x2
     174:	e8 77 0c 00 00       	call   df0 <printf>
  exit();
     179:	e8 41 0b 00 00       	call   cbf <exit>
     17e:	66 90                	xchg   %ax,%ax

00000180 <fork1>:
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     186:	e8 2c 0b 00 00       	call   cb7 <fork>
  if(pid == -1)
     18b:	83 f8 ff             	cmp    $0xffffffff,%eax
     18e:	74 02                	je     192 <fork1+0x12>
  return pid;
}
     190:	c9                   	leave  
     191:	c3                   	ret    
    panic("fork");
     192:	83 ec 0c             	sub    $0xc,%esp
     195:	68 d7 10 00 00       	push   $0x10d7
     19a:	e8 c5 ff ff ff       	call   164 <panic>
     19f:	90                   	nop

000001a0 <runcmd>:
{
     1a0:	55                   	push   %ebp
     1a1:	89 e5                	mov    %esp,%ebp
     1a3:	53                   	push   %ebx
     1a4:	83 ec 14             	sub    $0x14,%esp
     1a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1aa:	85 db                	test   %ebx,%ebx
     1ac:	74 3a                	je     1e8 <runcmd+0x48>
  switch(cmd->type){
     1ae:	83 3b 05             	cmpl   $0x5,(%ebx)
     1b1:	0f 87 db 00 00 00    	ja     292 <runcmd+0xf2>
     1b7:	8b 03                	mov    (%ebx),%eax
     1b9:	ff 24 85 8c 11 00 00 	jmp    *0x118c(,%eax,4)
    if(ecmd->argv[0] == 0)
     1c0:	8b 43 04             	mov    0x4(%ebx),%eax
     1c3:	85 c0                	test   %eax,%eax
     1c5:	74 21                	je     1e8 <runcmd+0x48>
    exec(ecmd->argv[0], ecmd->argv);
     1c7:	51                   	push   %ecx
     1c8:	51                   	push   %ecx
     1c9:	8d 53 04             	lea    0x4(%ebx),%edx
     1cc:	52                   	push   %edx
     1cd:	50                   	push   %eax
     1ce:	e8 24 0b 00 00       	call   cf7 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     1d3:	83 c4 0c             	add    $0xc,%esp
     1d6:	ff 73 04             	push   0x4(%ebx)
     1d9:	68 e3 10 00 00       	push   $0x10e3
     1de:	6a 02                	push   $0x2
     1e0:	e8 0b 0c 00 00       	call   df0 <printf>
    break;
     1e5:	83 c4 10             	add    $0x10,%esp
    exit();
     1e8:	e8 d2 0a 00 00       	call   cbf <exit>
    if(fork1() == 0)
     1ed:	e8 8e ff ff ff       	call   180 <fork1>
     1f2:	85 c0                	test   %eax,%eax
     1f4:	75 f2                	jne    1e8 <runcmd+0x48>
     1f6:	e9 8c 00 00 00       	jmp    287 <runcmd+0xe7>
    if(pipe(p) < 0)
     1fb:	83 ec 0c             	sub    $0xc,%esp
     1fe:	8d 45 f0             	lea    -0x10(%ebp),%eax
     201:	50                   	push   %eax
     202:	e8 c8 0a 00 00       	call   ccf <pipe>
     207:	83 c4 10             	add    $0x10,%esp
     20a:	85 c0                	test   %eax,%eax
     20c:	0f 88 a2 00 00 00    	js     2b4 <runcmd+0x114>
    if(fork1() == 0){
     212:	e8 69 ff ff ff       	call   180 <fork1>
     217:	85 c0                	test   %eax,%eax
     219:	0f 84 a2 00 00 00    	je     2c1 <runcmd+0x121>
    if(fork1() == 0){
     21f:	e8 5c ff ff ff       	call   180 <fork1>
     224:	85 c0                	test   %eax,%eax
     226:	0f 84 c3 00 00 00    	je     2ef <runcmd+0x14f>
    close(p[0]);
     22c:	83 ec 0c             	sub    $0xc,%esp
     22f:	ff 75 f0             	push   -0x10(%ebp)
     232:	e8 b0 0a 00 00       	call   ce7 <close>
    close(p[1]);
     237:	58                   	pop    %eax
     238:	ff 75 f4             	push   -0xc(%ebp)
     23b:	e8 a7 0a 00 00       	call   ce7 <close>
    wait();
     240:	e8 82 0a 00 00       	call   cc7 <wait>
    wait();
     245:	e8 7d 0a 00 00       	call   cc7 <wait>
    break;
     24a:	83 c4 10             	add    $0x10,%esp
     24d:	eb 99                	jmp    1e8 <runcmd+0x48>
    if(fork1() == 0)
     24f:	e8 2c ff ff ff       	call   180 <fork1>
     254:	85 c0                	test   %eax,%eax
     256:	74 2f                	je     287 <runcmd+0xe7>
    wait();
     258:	e8 6a 0a 00 00       	call   cc7 <wait>
    runcmd(lcmd->right);
     25d:	83 ec 0c             	sub    $0xc,%esp
     260:	ff 73 08             	push   0x8(%ebx)
     263:	e8 38 ff ff ff       	call   1a0 <runcmd>
    close(rcmd->fd);
     268:	83 ec 0c             	sub    $0xc,%esp
     26b:	ff 73 14             	push   0x14(%ebx)
     26e:	e8 74 0a 00 00       	call   ce7 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     273:	58                   	pop    %eax
     274:	5a                   	pop    %edx
     275:	ff 73 10             	push   0x10(%ebx)
     278:	ff 73 08             	push   0x8(%ebx)
     27b:	e8 7f 0a 00 00       	call   cff <open>
     280:	83 c4 10             	add    $0x10,%esp
     283:	85 c0                	test   %eax,%eax
     285:	78 18                	js     29f <runcmd+0xff>
      runcmd(bcmd->cmd);
     287:	83 ec 0c             	sub    $0xc,%esp
     28a:	ff 73 04             	push   0x4(%ebx)
     28d:	e8 0e ff ff ff       	call   1a0 <runcmd>
    panic("runcmd");
     292:	83 ec 0c             	sub    $0xc,%esp
     295:	68 dc 10 00 00       	push   $0x10dc
     29a:	e8 c5 fe ff ff       	call   164 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     29f:	51                   	push   %ecx
     2a0:	ff 73 08             	push   0x8(%ebx)
     2a3:	68 f3 10 00 00       	push   $0x10f3
     2a8:	6a 02                	push   $0x2
     2aa:	e8 41 0b 00 00       	call   df0 <printf>
      exit();
     2af:	e8 0b 0a 00 00       	call   cbf <exit>
      panic("pipe");
     2b4:	83 ec 0c             	sub    $0xc,%esp
     2b7:	68 03 11 00 00       	push   $0x1103
     2bc:	e8 a3 fe ff ff       	call   164 <panic>
      close(1);
     2c1:	83 ec 0c             	sub    $0xc,%esp
     2c4:	6a 01                	push   $0x1
     2c6:	e8 1c 0a 00 00       	call   ce7 <close>
      dup(p[1]);
     2cb:	58                   	pop    %eax
     2cc:	ff 75 f4             	push   -0xc(%ebp)
     2cf:	e8 63 0a 00 00       	call   d37 <dup>
      close(p[0]);
     2d4:	58                   	pop    %eax
     2d5:	ff 75 f0             	push   -0x10(%ebp)
     2d8:	e8 0a 0a 00 00       	call   ce7 <close>
      close(p[1]);
     2dd:	58                   	pop    %eax
     2de:	ff 75 f4             	push   -0xc(%ebp)
     2e1:	e8 01 0a 00 00       	call   ce7 <close>
      runcmd(pcmd->left);
     2e6:	5a                   	pop    %edx
     2e7:	ff 73 04             	push   0x4(%ebx)
     2ea:	e8 b1 fe ff ff       	call   1a0 <runcmd>
      close(0);
     2ef:	83 ec 0c             	sub    $0xc,%esp
     2f2:	6a 00                	push   $0x0
     2f4:	e8 ee 09 00 00       	call   ce7 <close>
      dup(p[0]);
     2f9:	5a                   	pop    %edx
     2fa:	ff 75 f0             	push   -0x10(%ebp)
     2fd:	e8 35 0a 00 00       	call   d37 <dup>
      close(p[0]);
     302:	59                   	pop    %ecx
     303:	ff 75 f0             	push   -0x10(%ebp)
     306:	e8 dc 09 00 00       	call   ce7 <close>
      close(p[1]);
     30b:	58                   	pop    %eax
     30c:	ff 75 f4             	push   -0xc(%ebp)
     30f:	e8 d3 09 00 00       	call   ce7 <close>
      runcmd(pcmd->right);
     314:	58                   	pop    %eax
     315:	ff 73 08             	push   0x8(%ebx)
     318:	e8 83 fe ff ff       	call   1a0 <runcmd>
     31d:	8d 76 00             	lea    0x0(%esi),%esi

00000320 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     320:	55                   	push   %ebp
     321:	89 e5                	mov    %esp,%ebp
     323:	53                   	push   %ebx
     324:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     327:	6a 54                	push   $0x54
     329:	e8 ae 0c 00 00       	call   fdc <malloc>
     32e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     330:	83 c4 0c             	add    $0xc,%esp
     333:	6a 54                	push   $0x54
     335:	6a 00                	push   $0x0
     337:	50                   	push   %eax
     338:	e8 37 08 00 00       	call   b74 <memset>
  cmd->type = EXEC;
     33d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     343:	89 d8                	mov    %ebx,%eax
     345:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     348:	c9                   	leave  
     349:	c3                   	ret    
     34a:	66 90                	xchg   %ax,%ax

0000034c <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     34c:	55                   	push   %ebp
     34d:	89 e5                	mov    %esp,%ebp
     34f:	53                   	push   %ebx
     350:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     353:	6a 18                	push   $0x18
     355:	e8 82 0c 00 00       	call   fdc <malloc>
     35a:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     35c:	83 c4 0c             	add    $0xc,%esp
     35f:	6a 18                	push   $0x18
     361:	6a 00                	push   $0x0
     363:	50                   	push   %eax
     364:	e8 0b 08 00 00       	call   b74 <memset>
  cmd->type = REDIR;
     369:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     36f:	8b 45 08             	mov    0x8(%ebp),%eax
     372:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     375:	8b 45 0c             	mov    0xc(%ebp),%eax
     378:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     37b:	8b 45 10             	mov    0x10(%ebp),%eax
     37e:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     381:	8b 45 14             	mov    0x14(%ebp),%eax
     384:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     387:	8b 45 18             	mov    0x18(%ebp),%eax
     38a:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     38d:	89 d8                	mov    %ebx,%eax
     38f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     392:	c9                   	leave  
     393:	c3                   	ret    

00000394 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     394:	55                   	push   %ebp
     395:	89 e5                	mov    %esp,%ebp
     397:	53                   	push   %ebx
     398:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     39b:	6a 0c                	push   $0xc
     39d:	e8 3a 0c 00 00       	call   fdc <malloc>
     3a2:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3a4:	83 c4 0c             	add    $0xc,%esp
     3a7:	6a 0c                	push   $0xc
     3a9:	6a 00                	push   $0x0
     3ab:	50                   	push   %eax
     3ac:	e8 c3 07 00 00       	call   b74 <memset>
  cmd->type = PIPE;
     3b1:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3b7:	8b 45 08             	mov    0x8(%ebp),%eax
     3ba:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3bd:	8b 45 0c             	mov    0xc(%ebp),%eax
     3c0:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3c3:	89 d8                	mov    %ebx,%eax
     3c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3c8:	c9                   	leave  
     3c9:	c3                   	ret    
     3ca:	66 90                	xchg   %ax,%ax

000003cc <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     3cc:	55                   	push   %ebp
     3cd:	89 e5                	mov    %esp,%ebp
     3cf:	53                   	push   %ebx
     3d0:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d3:	6a 0c                	push   $0xc
     3d5:	e8 02 0c 00 00       	call   fdc <malloc>
     3da:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3dc:	83 c4 0c             	add    $0xc,%esp
     3df:	6a 0c                	push   $0xc
     3e1:	6a 00                	push   $0x0
     3e3:	50                   	push   %eax
     3e4:	e8 8b 07 00 00       	call   b74 <memset>
  cmd->type = LIST;
     3e9:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     3ef:	8b 45 08             	mov    0x8(%ebp),%eax
     3f2:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3f5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f8:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3fb:	89 d8                	mov    %ebx,%eax
     3fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     400:	c9                   	leave  
     401:	c3                   	ret    
     402:	66 90                	xchg   %ax,%ax

00000404 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     404:	55                   	push   %ebp
     405:	89 e5                	mov    %esp,%ebp
     407:	53                   	push   %ebx
     408:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     40b:	6a 08                	push   $0x8
     40d:	e8 ca 0b 00 00       	call   fdc <malloc>
     412:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     414:	83 c4 0c             	add    $0xc,%esp
     417:	6a 08                	push   $0x8
     419:	6a 00                	push   $0x0
     41b:	50                   	push   %eax
     41c:	e8 53 07 00 00       	call   b74 <memset>
  cmd->type = BACK;
     421:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     427:	8b 45 08             	mov    0x8(%ebp),%eax
     42a:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     42d:	89 d8                	mov    %ebx,%eax
     42f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     432:	c9                   	leave  
     433:	c3                   	ret    

00000434 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     434:	55                   	push   %ebp
     435:	89 e5                	mov    %esp,%ebp
     437:	57                   	push   %edi
     438:	56                   	push   %esi
     439:	53                   	push   %ebx
     43a:	83 ec 0c             	sub    $0xc,%esp
     43d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     440:	8b 75 10             	mov    0x10(%ebp),%esi
  char *s;
  int ret;

  s = *ps;
     443:	8b 45 08             	mov    0x8(%ebp),%eax
     446:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     448:	39 df                	cmp    %ebx,%edi
     44a:	72 09                	jb     455 <gettoken+0x21>
     44c:	eb 1f                	jmp    46d <gettoken+0x39>
     44e:	66 90                	xchg   %ax,%ax
    s++;
     450:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     451:	39 fb                	cmp    %edi,%ebx
     453:	74 18                	je     46d <gettoken+0x39>
     455:	83 ec 08             	sub    $0x8,%esp
     458:	0f be 07             	movsbl (%edi),%eax
     45b:	50                   	push   %eax
     45c:	68 38 12 00 00       	push   $0x1238
     461:	e8 26 07 00 00       	call   b8c <strchr>
     466:	83 c4 10             	add    $0x10,%esp
     469:	85 c0                	test   %eax,%eax
     46b:	75 e3                	jne    450 <gettoken+0x1c>
  if(q)
     46d:	85 f6                	test   %esi,%esi
     46f:	74 02                	je     473 <gettoken+0x3f>
    *q = s;
     471:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     473:	0f be 07             	movsbl (%edi),%eax
  switch(*s){
     476:	3c 3c                	cmp    $0x3c,%al
     478:	0f 8f ba 00 00 00    	jg     538 <gettoken+0x104>
     47e:	3c 3a                	cmp    $0x3a,%al
     480:	0f 8f a6 00 00 00    	jg     52c <gettoken+0xf8>
     486:	84 c0                	test   %al,%al
     488:	75 42                	jne    4cc <gettoken+0x98>
     48a:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     48c:	8b 55 14             	mov    0x14(%ebp),%edx
     48f:	85 d2                	test   %edx,%edx
     491:	74 05                	je     498 <gettoken+0x64>
    *eq = s;
     493:	8b 45 14             	mov    0x14(%ebp),%eax
     496:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     498:	39 df                	cmp    %ebx,%edi
     49a:	72 09                	jb     4a5 <gettoken+0x71>
     49c:	eb 1f                	jmp    4bd <gettoken+0x89>
     49e:	66 90                	xchg   %ax,%ax
    s++;
     4a0:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     4a1:	39 fb                	cmp    %edi,%ebx
     4a3:	74 18                	je     4bd <gettoken+0x89>
     4a5:	83 ec 08             	sub    $0x8,%esp
     4a8:	0f be 07             	movsbl (%edi),%eax
     4ab:	50                   	push   %eax
     4ac:	68 38 12 00 00       	push   $0x1238
     4b1:	e8 d6 06 00 00       	call   b8c <strchr>
     4b6:	83 c4 10             	add    $0x10,%esp
     4b9:	85 c0                	test   %eax,%eax
     4bb:	75 e3                	jne    4a0 <gettoken+0x6c>
  *ps = s;
     4bd:	8b 45 08             	mov    0x8(%ebp),%eax
     4c0:	89 38                	mov    %edi,(%eax)
  return ret;
}
     4c2:	89 f0                	mov    %esi,%eax
     4c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4c7:	5b                   	pop    %ebx
     4c8:	5e                   	pop    %esi
     4c9:	5f                   	pop    %edi
     4ca:	5d                   	pop    %ebp
     4cb:	c3                   	ret    
  switch(*s){
     4cc:	79 52                	jns    520 <gettoken+0xec>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4ce:	39 fb                	cmp    %edi,%ebx
     4d0:	77 2e                	ja     500 <gettoken+0xcc>
  if(eq)
     4d2:	be 61 00 00 00       	mov    $0x61,%esi
     4d7:	8b 45 14             	mov    0x14(%ebp),%eax
     4da:	85 c0                	test   %eax,%eax
     4dc:	75 b5                	jne    493 <gettoken+0x5f>
     4de:	eb dd                	jmp    4bd <gettoken+0x89>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4e0:	83 ec 08             	sub    $0x8,%esp
     4e3:	0f be 07             	movsbl (%edi),%eax
     4e6:	50                   	push   %eax
     4e7:	68 30 12 00 00       	push   $0x1230
     4ec:	e8 9b 06 00 00       	call   b8c <strchr>
     4f1:	83 c4 10             	add    $0x10,%esp
     4f4:	85 c0                	test   %eax,%eax
     4f6:	75 1d                	jne    515 <gettoken+0xe1>
      s++;
     4f8:	47                   	inc    %edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4f9:	39 fb                	cmp    %edi,%ebx
     4fb:	74 d5                	je     4d2 <gettoken+0x9e>
     4fd:	0f be 07             	movsbl (%edi),%eax
     500:	83 ec 08             	sub    $0x8,%esp
     503:	50                   	push   %eax
     504:	68 38 12 00 00       	push   $0x1238
     509:	e8 7e 06 00 00       	call   b8c <strchr>
     50e:	83 c4 10             	add    $0x10,%esp
     511:	85 c0                	test   %eax,%eax
     513:	74 cb                	je     4e0 <gettoken+0xac>
    ret = 'a';
     515:	be 61 00 00 00       	mov    $0x61,%esi
     51a:	e9 6d ff ff ff       	jmp    48c <gettoken+0x58>
     51f:	90                   	nop
  switch(*s){
     520:	3c 26                	cmp    $0x26,%al
     522:	74 08                	je     52c <gettoken+0xf8>
     524:	8d 48 d8             	lea    -0x28(%eax),%ecx
     527:	80 f9 01             	cmp    $0x1,%cl
     52a:	77 a2                	ja     4ce <gettoken+0x9a>
  ret = *s;
     52c:	0f be f0             	movsbl %al,%esi
    s++;
     52f:	47                   	inc    %edi
    break;
     530:	e9 57 ff ff ff       	jmp    48c <gettoken+0x58>
     535:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     538:	3c 3e                	cmp    $0x3e,%al
     53a:	75 18                	jne    554 <gettoken+0x120>
    s++;
     53c:	8d 47 01             	lea    0x1(%edi),%eax
    if(*s == '>'){
     53f:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     543:	74 18                	je     55d <gettoken+0x129>
    s++;
     545:	89 c7                	mov    %eax,%edi
     547:	be 3e 00 00 00       	mov    $0x3e,%esi
     54c:	e9 3b ff ff ff       	jmp    48c <gettoken+0x58>
     551:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     554:	3c 7c                	cmp    $0x7c,%al
     556:	74 d4                	je     52c <gettoken+0xf8>
     558:	e9 71 ff ff ff       	jmp    4ce <gettoken+0x9a>
      s++;
     55d:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     560:	be 2b 00 00 00       	mov    $0x2b,%esi
     565:	e9 22 ff ff ff       	jmp    48c <gettoken+0x58>
     56a:	66 90                	xchg   %ax,%ax

0000056c <peek>:

int
peek(char **ps, char *es, char *toks)
{
     56c:	55                   	push   %ebp
     56d:	89 e5                	mov    %esp,%ebp
     56f:	57                   	push   %edi
     570:	56                   	push   %esi
     571:	53                   	push   %ebx
     572:	83 ec 0c             	sub    $0xc,%esp
     575:	8b 7d 08             	mov    0x8(%ebp),%edi
     578:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     57b:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     57d:	39 f3                	cmp    %esi,%ebx
     57f:	72 08                	jb     589 <peek+0x1d>
     581:	eb 1e                	jmp    5a1 <peek+0x35>
     583:	90                   	nop
    s++;
     584:	43                   	inc    %ebx
  while(s < es && strchr(whitespace, *s))
     585:	39 de                	cmp    %ebx,%esi
     587:	74 18                	je     5a1 <peek+0x35>
     589:	83 ec 08             	sub    $0x8,%esp
     58c:	0f be 03             	movsbl (%ebx),%eax
     58f:	50                   	push   %eax
     590:	68 38 12 00 00       	push   $0x1238
     595:	e8 f2 05 00 00       	call   b8c <strchr>
     59a:	83 c4 10             	add    $0x10,%esp
     59d:	85 c0                	test   %eax,%eax
     59f:	75 e3                	jne    584 <peek+0x18>
  *ps = s;
     5a1:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     5a3:	0f be 03             	movsbl (%ebx),%eax
     5a6:	84 c0                	test   %al,%al
     5a8:	75 0a                	jne    5b4 <peek+0x48>
     5aa:	31 c0                	xor    %eax,%eax
}
     5ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5af:	5b                   	pop    %ebx
     5b0:	5e                   	pop    %esi
     5b1:	5f                   	pop    %edi
     5b2:	5d                   	pop    %ebp
     5b3:	c3                   	ret    
  return *s && strchr(toks, *s);
     5b4:	83 ec 08             	sub    $0x8,%esp
     5b7:	50                   	push   %eax
     5b8:	ff 75 10             	push   0x10(%ebp)
     5bb:	e8 cc 05 00 00       	call   b8c <strchr>
     5c0:	83 c4 10             	add    $0x10,%esp
     5c3:	85 c0                	test   %eax,%eax
     5c5:	0f 95 c0             	setne  %al
     5c8:	0f b6 c0             	movzbl %al,%eax
}
     5cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5ce:	5b                   	pop    %ebx
     5cf:	5e                   	pop    %esi
     5d0:	5f                   	pop    %edi
     5d1:	5d                   	pop    %ebp
     5d2:	c3                   	ret    
     5d3:	90                   	nop

000005d4 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     5d4:	55                   	push   %ebp
     5d5:	89 e5                	mov    %esp,%ebp
     5d7:	57                   	push   %edi
     5d8:	56                   	push   %esi
     5d9:	53                   	push   %ebx
     5da:	83 ec 2c             	sub    $0x2c,%esp
     5dd:	8b 75 0c             	mov    0xc(%ebp),%esi
     5e0:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5e3:	90                   	nop
     5e4:	50                   	push   %eax
     5e5:	68 25 11 00 00       	push   $0x1125
     5ea:	53                   	push   %ebx
     5eb:	56                   	push   %esi
     5ec:	e8 7b ff ff ff       	call   56c <peek>
     5f1:	83 c4 10             	add    $0x10,%esp
     5f4:	85 c0                	test   %eax,%eax
     5f6:	0f 84 e8 00 00 00    	je     6e4 <parseredirs+0x110>
    tok = gettoken(ps, es, 0, 0);
     5fc:	6a 00                	push   $0x0
     5fe:	6a 00                	push   $0x0
     600:	53                   	push   %ebx
     601:	56                   	push   %esi
     602:	e8 2d fe ff ff       	call   434 <gettoken>
     607:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     609:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     60c:	50                   	push   %eax
     60d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     610:	50                   	push   %eax
     611:	53                   	push   %ebx
     612:	56                   	push   %esi
     613:	e8 1c fe ff ff       	call   434 <gettoken>
     618:	83 c4 20             	add    $0x20,%esp
     61b:	83 f8 61             	cmp    $0x61,%eax
     61e:	0f 85 cb 00 00 00    	jne    6ef <parseredirs+0x11b>
      panic("missing file for redirection");
    switch(tok){
     624:	83 ff 3c             	cmp    $0x3c,%edi
     627:	74 63                	je     68c <parseredirs+0xb8>
     629:	83 ff 3e             	cmp    $0x3e,%edi
     62c:	74 05                	je     633 <parseredirs+0x5f>
     62e:	83 ff 2b             	cmp    $0x2b,%edi
     631:	75 b1                	jne    5e4 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     633:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     636:	89 55 d0             	mov    %edx,-0x30(%ebp)
     639:	8b 4d e0             	mov    -0x20(%ebp),%ecx
     63c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     63f:	83 ec 0c             	sub    $0xc,%esp
     642:	6a 18                	push   $0x18
     644:	e8 93 09 00 00       	call   fdc <malloc>
     649:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     64b:	83 c4 0c             	add    $0xc,%esp
     64e:	6a 18                	push   $0x18
     650:	6a 00                	push   $0x0
     652:	50                   	push   %eax
     653:	e8 1c 05 00 00       	call   b74 <memset>
  cmd->type = REDIR;
     658:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     65e:	8b 45 08             	mov    0x8(%ebp),%eax
     661:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     664:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     667:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     66a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     66d:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     670:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->fd = fd;
     677:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      break;
     67e:	83 c4 10             	add    $0x10,%esp
     681:	89 7d 08             	mov    %edi,0x8(%ebp)
     684:	e9 5b ff ff ff       	jmp    5e4 <parseredirs+0x10>
     689:	8d 76 00             	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     68c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     68f:	89 55 d0             	mov    %edx,-0x30(%ebp)
     692:	8b 4d e0             	mov    -0x20(%ebp),%ecx
     695:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     698:	83 ec 0c             	sub    $0xc,%esp
     69b:	6a 18                	push   $0x18
     69d:	e8 3a 09 00 00       	call   fdc <malloc>
     6a2:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     6a4:	83 c4 0c             	add    $0xc,%esp
     6a7:	6a 18                	push   $0x18
     6a9:	6a 00                	push   $0x0
     6ab:	50                   	push   %eax
     6ac:	e8 c3 04 00 00       	call   b74 <memset>
  cmd->type = REDIR;
     6b1:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     6b7:	8b 45 08             	mov    0x8(%ebp),%eax
     6ba:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     6bd:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     6c0:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     6c3:	8b 55 d0             	mov    -0x30(%ebp),%edx
     6c6:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     6c9:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     6d0:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      break;
     6d7:	83 c4 10             	add    $0x10,%esp
     6da:	89 7d 08             	mov    %edi,0x8(%ebp)
     6dd:	e9 02 ff ff ff       	jmp    5e4 <parseredirs+0x10>
     6e2:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     6e4:	8b 45 08             	mov    0x8(%ebp),%eax
     6e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6ea:	5b                   	pop    %ebx
     6eb:	5e                   	pop    %esi
     6ec:	5f                   	pop    %edi
     6ed:	5d                   	pop    %ebp
     6ee:	c3                   	ret    
      panic("missing file for redirection");
     6ef:	83 ec 0c             	sub    $0xc,%esp
     6f2:	68 08 11 00 00       	push   $0x1108
     6f7:	e8 68 fa ff ff       	call   164 <panic>

000006fc <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     6fc:	55                   	push   %ebp
     6fd:	89 e5                	mov    %esp,%ebp
     6ff:	57                   	push   %edi
     700:	56                   	push   %esi
     701:	53                   	push   %ebx
     702:	83 ec 30             	sub    $0x30,%esp
     705:	8b 75 08             	mov    0x8(%ebp),%esi
     708:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     70b:	68 28 11 00 00       	push   $0x1128
     710:	57                   	push   %edi
     711:	56                   	push   %esi
     712:	e8 55 fe ff ff       	call   56c <peek>
     717:	83 c4 10             	add    $0x10,%esp
     71a:	85 c0                	test   %eax,%eax
     71c:	0f 85 9e 00 00 00    	jne    7c0 <parseexec+0xc4>
     722:	89 c3                	mov    %eax,%ebx
  cmd = malloc(sizeof(*cmd));
     724:	83 ec 0c             	sub    $0xc,%esp
     727:	6a 54                	push   $0x54
     729:	e8 ae 08 00 00       	call   fdc <malloc>
  memset(cmd, 0, sizeof(*cmd));
     72e:	83 c4 0c             	add    $0xc,%esp
     731:	6a 54                	push   $0x54
     733:	6a 00                	push   $0x0
     735:	89 45 d0             	mov    %eax,-0x30(%ebp)
     738:	50                   	push   %eax
     739:	e8 36 04 00 00       	call   b74 <memset>
  cmd->type = EXEC;
     73e:	8b 45 d0             	mov    -0x30(%ebp),%eax
     741:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     747:	83 c4 0c             	add    $0xc,%esp
     74a:	57                   	push   %edi
     74b:	56                   	push   %esi
     74c:	50                   	push   %eax
     74d:	e8 82 fe ff ff       	call   5d4 <parseredirs>
     752:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     755:	83 c4 10             	add    $0x10,%esp
     758:	eb 13                	jmp    76d <parseexec+0x71>
     75a:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     75c:	52                   	push   %edx
     75d:	57                   	push   %edi
     75e:	56                   	push   %esi
     75f:	ff 75 d4             	push   -0x2c(%ebp)
     762:	e8 6d fe ff ff       	call   5d4 <parseredirs>
     767:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     76a:	83 c4 10             	add    $0x10,%esp
  while(!peek(ps, es, "|)&;")){
     76d:	50                   	push   %eax
     76e:	68 3f 11 00 00       	push   $0x113f
     773:	57                   	push   %edi
     774:	56                   	push   %esi
     775:	e8 f2 fd ff ff       	call   56c <peek>
     77a:	83 c4 10             	add    $0x10,%esp
     77d:	85 c0                	test   %eax,%eax
     77f:	75 53                	jne    7d4 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     781:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     784:	50                   	push   %eax
     785:	8d 45 e0             	lea    -0x20(%ebp),%eax
     788:	50                   	push   %eax
     789:	57                   	push   %edi
     78a:	56                   	push   %esi
     78b:	e8 a4 fc ff ff       	call   434 <gettoken>
     790:	83 c4 10             	add    $0x10,%esp
     793:	85 c0                	test   %eax,%eax
     795:	74 3d                	je     7d4 <parseexec+0xd8>
    if(tok != 'a')
     797:	83 f8 61             	cmp    $0x61,%eax
     79a:	75 56                	jne    7f2 <parseexec+0xf6>
    cmd->argv[argc] = q;
     79c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     79f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     7a2:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     7a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7a9:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     7ad:	43                   	inc    %ebx
    if(argc >= MAXARGS)
     7ae:	83 fb 0a             	cmp    $0xa,%ebx
     7b1:	75 a9                	jne    75c <parseexec+0x60>
      panic("too many args");
     7b3:	83 ec 0c             	sub    $0xc,%esp
     7b6:	68 31 11 00 00       	push   $0x1131
     7bb:	e8 a4 f9 ff ff       	call   164 <panic>
    return parseblock(ps, es);
     7c0:	89 7d 0c             	mov    %edi,0xc(%ebp)
     7c3:	89 75 08             	mov    %esi,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7c9:	5b                   	pop    %ebx
     7ca:	5e                   	pop    %esi
     7cb:	5f                   	pop    %edi
     7cc:	5d                   	pop    %ebp
    return parseblock(ps, es);
     7cd:	e9 8a 01 00 00       	jmp    95c <parseblock>
     7d2:	66 90                	xchg   %ax,%ax
  cmd->argv[argc] = 0;
     7d4:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7d7:	c7 44 98 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,4)
     7de:	00 
  cmd->eargv[argc] = 0;
     7df:	c7 44 98 2c 00 00 00 	movl   $0x0,0x2c(%eax,%ebx,4)
     7e6:	00 
}
     7e7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7ed:	5b                   	pop    %ebx
     7ee:	5e                   	pop    %esi
     7ef:	5f                   	pop    %edi
     7f0:	5d                   	pop    %ebp
     7f1:	c3                   	ret    
      panic("syntax");
     7f2:	83 ec 0c             	sub    $0xc,%esp
     7f5:	68 2a 11 00 00       	push   $0x112a
     7fa:	e8 65 f9 ff ff       	call   164 <panic>
     7ff:	90                   	nop

00000800 <parsepipe>:
{
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	57                   	push   %edi
     804:	56                   	push   %esi
     805:	53                   	push   %ebx
     806:	83 ec 14             	sub    $0x14,%esp
     809:	8b 75 08             	mov    0x8(%ebp),%esi
     80c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     80f:	57                   	push   %edi
     810:	56                   	push   %esi
     811:	e8 e6 fe ff ff       	call   6fc <parseexec>
     816:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     818:	83 c4 0c             	add    $0xc,%esp
     81b:	68 44 11 00 00       	push   $0x1144
     820:	57                   	push   %edi
     821:	56                   	push   %esi
     822:	e8 45 fd ff ff       	call   56c <peek>
     827:	83 c4 10             	add    $0x10,%esp
     82a:	85 c0                	test   %eax,%eax
     82c:	75 0a                	jne    838 <parsepipe+0x38>
}
     82e:	89 d8                	mov    %ebx,%eax
     830:	8d 65 f4             	lea    -0xc(%ebp),%esp
     833:	5b                   	pop    %ebx
     834:	5e                   	pop    %esi
     835:	5f                   	pop    %edi
     836:	5d                   	pop    %ebp
     837:	c3                   	ret    
    gettoken(ps, es, 0, 0);
     838:	6a 00                	push   $0x0
     83a:	6a 00                	push   $0x0
     83c:	57                   	push   %edi
     83d:	56                   	push   %esi
     83e:	e8 f1 fb ff ff       	call   434 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     843:	58                   	pop    %eax
     844:	5a                   	pop    %edx
     845:	57                   	push   %edi
     846:	56                   	push   %esi
     847:	e8 b4 ff ff ff       	call   800 <parsepipe>
     84c:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     84e:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     855:	e8 82 07 00 00       	call   fdc <malloc>
     85a:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     85c:	83 c4 0c             	add    $0xc,%esp
     85f:	6a 0c                	push   $0xc
     861:	6a 00                	push   $0x0
     863:	50                   	push   %eax
     864:	e8 0b 03 00 00       	call   b74 <memset>
  cmd->type = PIPE;
     869:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
  cmd->left = left;
     86f:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     872:	89 7e 08             	mov    %edi,0x8(%esi)
     875:	83 c4 10             	add    $0x10,%esp
     878:	89 f3                	mov    %esi,%ebx
}
     87a:	89 d8                	mov    %ebx,%eax
     87c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     87f:	5b                   	pop    %ebx
     880:	5e                   	pop    %esi
     881:	5f                   	pop    %edi
     882:	5d                   	pop    %ebp
     883:	c3                   	ret    

00000884 <parseline>:
{
     884:	55                   	push   %ebp
     885:	89 e5                	mov    %esp,%ebp
     887:	57                   	push   %edi
     888:	56                   	push   %esi
     889:	53                   	push   %ebx
     88a:	83 ec 24             	sub    $0x24,%esp
     88d:	8b 75 08             	mov    0x8(%ebp),%esi
     890:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     893:	57                   	push   %edi
     894:	56                   	push   %esi
     895:	e8 66 ff ff ff       	call   800 <parsepipe>
     89a:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     89c:	83 c4 10             	add    $0x10,%esp
     89f:	eb 3b                	jmp    8dc <parseline+0x58>
     8a1:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     8a4:	6a 00                	push   $0x0
     8a6:	6a 00                	push   $0x0
     8a8:	57                   	push   %edi
     8a9:	56                   	push   %esi
     8aa:	e8 85 fb ff ff       	call   434 <gettoken>
  cmd = malloc(sizeof(*cmd));
     8af:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     8b6:	e8 21 07 00 00       	call   fdc <malloc>
  memset(cmd, 0, sizeof(*cmd));
     8bb:	83 c4 0c             	add    $0xc,%esp
     8be:	6a 08                	push   $0x8
     8c0:	6a 00                	push   $0x0
     8c2:	50                   	push   %eax
     8c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     8c6:	e8 a9 02 00 00       	call   b74 <memset>
  cmd->type = BACK;
     8cb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     8ce:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     8d4:	89 5a 04             	mov    %ebx,0x4(%edx)
     8d7:	83 c4 10             	add    $0x10,%esp
     8da:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     8dc:	50                   	push   %eax
     8dd:	68 46 11 00 00       	push   $0x1146
     8e2:	57                   	push   %edi
     8e3:	56                   	push   %esi
     8e4:	e8 83 fc ff ff       	call   56c <peek>
     8e9:	83 c4 10             	add    $0x10,%esp
     8ec:	85 c0                	test   %eax,%eax
     8ee:	75 b4                	jne    8a4 <parseline+0x20>
  if(peek(ps, es, ";")){
     8f0:	51                   	push   %ecx
     8f1:	68 42 11 00 00       	push   $0x1142
     8f6:	57                   	push   %edi
     8f7:	56                   	push   %esi
     8f8:	e8 6f fc ff ff       	call   56c <peek>
     8fd:	83 c4 10             	add    $0x10,%esp
     900:	85 c0                	test   %eax,%eax
     902:	75 0c                	jne    910 <parseline+0x8c>
}
     904:	89 d8                	mov    %ebx,%eax
     906:	8d 65 f4             	lea    -0xc(%ebp),%esp
     909:	5b                   	pop    %ebx
     90a:	5e                   	pop    %esi
     90b:	5f                   	pop    %edi
     90c:	5d                   	pop    %ebp
     90d:	c3                   	ret    
     90e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     910:	6a 00                	push   $0x0
     912:	6a 00                	push   $0x0
     914:	57                   	push   %edi
     915:	56                   	push   %esi
     916:	e8 19 fb ff ff       	call   434 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     91b:	58                   	pop    %eax
     91c:	5a                   	pop    %edx
     91d:	57                   	push   %edi
     91e:	56                   	push   %esi
     91f:	e8 60 ff ff ff       	call   884 <parseline>
     924:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     926:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     92d:	e8 aa 06 00 00       	call   fdc <malloc>
     932:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     934:	83 c4 0c             	add    $0xc,%esp
     937:	6a 0c                	push   $0xc
     939:	6a 00                	push   $0x0
     93b:	50                   	push   %eax
     93c:	e8 33 02 00 00       	call   b74 <memset>
  cmd->type = LIST;
     941:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
  cmd->left = left;
     947:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     94a:	89 7e 08             	mov    %edi,0x8(%esi)
     94d:	83 c4 10             	add    $0x10,%esp
     950:	89 f3                	mov    %esi,%ebx
}
     952:	89 d8                	mov    %ebx,%eax
     954:	8d 65 f4             	lea    -0xc(%ebp),%esp
     957:	5b                   	pop    %ebx
     958:	5e                   	pop    %esi
     959:	5f                   	pop    %edi
     95a:	5d                   	pop    %ebp
     95b:	c3                   	ret    

0000095c <parseblock>:
{
     95c:	55                   	push   %ebp
     95d:	89 e5                	mov    %esp,%ebp
     95f:	57                   	push   %edi
     960:	56                   	push   %esi
     961:	53                   	push   %ebx
     962:	83 ec 10             	sub    $0x10,%esp
     965:	8b 5d 08             	mov    0x8(%ebp),%ebx
     968:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     96b:	68 28 11 00 00       	push   $0x1128
     970:	56                   	push   %esi
     971:	53                   	push   %ebx
     972:	e8 f5 fb ff ff       	call   56c <peek>
     977:	83 c4 10             	add    $0x10,%esp
     97a:	85 c0                	test   %eax,%eax
     97c:	74 4a                	je     9c8 <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     97e:	6a 00                	push   $0x0
     980:	6a 00                	push   $0x0
     982:	56                   	push   %esi
     983:	53                   	push   %ebx
     984:	e8 ab fa ff ff       	call   434 <gettoken>
  cmd = parseline(ps, es);
     989:	58                   	pop    %eax
     98a:	5a                   	pop    %edx
     98b:	56                   	push   %esi
     98c:	53                   	push   %ebx
     98d:	e8 f2 fe ff ff       	call   884 <parseline>
     992:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     994:	83 c4 0c             	add    $0xc,%esp
     997:	68 64 11 00 00       	push   $0x1164
     99c:	56                   	push   %esi
     99d:	53                   	push   %ebx
     99e:	e8 c9 fb ff ff       	call   56c <peek>
     9a3:	83 c4 10             	add    $0x10,%esp
     9a6:	85 c0                	test   %eax,%eax
     9a8:	74 2b                	je     9d5 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     9aa:	6a 00                	push   $0x0
     9ac:	6a 00                	push   $0x0
     9ae:	56                   	push   %esi
     9af:	53                   	push   %ebx
     9b0:	e8 7f fa ff ff       	call   434 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     9b5:	83 c4 0c             	add    $0xc,%esp
     9b8:	56                   	push   %esi
     9b9:	53                   	push   %ebx
     9ba:	57                   	push   %edi
     9bb:	e8 14 fc ff ff       	call   5d4 <parseredirs>
}
     9c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9c3:	5b                   	pop    %ebx
     9c4:	5e                   	pop    %esi
     9c5:	5f                   	pop    %edi
     9c6:	5d                   	pop    %ebp
     9c7:	c3                   	ret    
    panic("parseblock");
     9c8:	83 ec 0c             	sub    $0xc,%esp
     9cb:	68 48 11 00 00       	push   $0x1148
     9d0:	e8 8f f7 ff ff       	call   164 <panic>
    panic("syntax - missing )");
     9d5:	83 ec 0c             	sub    $0xc,%esp
     9d8:	68 53 11 00 00       	push   $0x1153
     9dd:	e8 82 f7 ff ff       	call   164 <panic>
     9e2:	66 90                	xchg   %ax,%ax

000009e4 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9e4:	55                   	push   %ebp
     9e5:	89 e5                	mov    %esp,%ebp
     9e7:	53                   	push   %ebx
     9e8:	53                   	push   %ebx
     9e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9ec:	85 db                	test   %ebx,%ebx
     9ee:	0f 84 88 00 00 00    	je     a7c <nulterminate+0x98>
    return 0;

  switch(cmd->type){
     9f4:	83 3b 05             	cmpl   $0x5,(%ebx)
     9f7:	77 5f                	ja     a58 <nulterminate+0x74>
     9f9:	8b 03                	mov    (%ebx),%eax
     9fb:	ff 24 85 a4 11 00 00 	jmp    *0x11a4(,%eax,4)
     a02:	66 90                	xchg   %ax,%ax
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     a04:	83 ec 0c             	sub    $0xc,%esp
     a07:	ff 73 04             	push   0x4(%ebx)
     a0a:	e8 d5 ff ff ff       	call   9e4 <nulterminate>
    nulterminate(lcmd->right);
     a0f:	58                   	pop    %eax
     a10:	ff 73 08             	push   0x8(%ebx)
     a13:	e8 cc ff ff ff       	call   9e4 <nulterminate>
    break;
     a18:	83 c4 10             	add    $0x10,%esp
     a1b:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a1d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a20:	c9                   	leave  
     a21:	c3                   	ret    
     a22:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     a24:	83 ec 0c             	sub    $0xc,%esp
     a27:	ff 73 04             	push   0x4(%ebx)
     a2a:	e8 b5 ff ff ff       	call   9e4 <nulterminate>
    break;
     a2f:	83 c4 10             	add    $0x10,%esp
     a32:	89 d8                	mov    %ebx,%eax
}
     a34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a37:	c9                   	leave  
     a38:	c3                   	ret    
     a39:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     a3c:	8d 43 08             	lea    0x8(%ebx),%eax
     a3f:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a42:	85 c9                	test   %ecx,%ecx
     a44:	74 12                	je     a58 <nulterminate+0x74>
     a46:	66 90                	xchg   %ax,%ax
      *ecmd->eargv[i] = 0;
     a48:	8b 50 24             	mov    0x24(%eax),%edx
     a4b:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a4e:	83 c0 04             	add    $0x4,%eax
     a51:	8b 50 fc             	mov    -0x4(%eax),%edx
     a54:	85 d2                	test   %edx,%edx
     a56:	75 f0                	jne    a48 <nulterminate+0x64>
  switch(cmd->type){
     a58:	89 d8                	mov    %ebx,%eax
}
     a5a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a5d:	c9                   	leave  
     a5e:	c3                   	ret    
     a5f:	90                   	nop
    nulterminate(rcmd->cmd);
     a60:	83 ec 0c             	sub    $0xc,%esp
     a63:	ff 73 04             	push   0x4(%ebx)
     a66:	e8 79 ff ff ff       	call   9e4 <nulterminate>
    *rcmd->efile = 0;
     a6b:	8b 43 0c             	mov    0xc(%ebx),%eax
     a6e:	c6 00 00             	movb   $0x0,(%eax)
    break;
     a71:	83 c4 10             	add    $0x10,%esp
     a74:	89 d8                	mov    %ebx,%eax
}
     a76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a79:	c9                   	leave  
     a7a:	c3                   	ret    
     a7b:	90                   	nop
    return 0;
     a7c:	31 c0                	xor    %eax,%eax
     a7e:	eb 9d                	jmp    a1d <nulterminate+0x39>

00000a80 <parsecmd>:
{
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
     a83:	57                   	push   %edi
     a84:	56                   	push   %esi
     a85:	53                   	push   %ebx
     a86:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     a89:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a8c:	53                   	push   %ebx
     a8d:	e8 ba 00 00 00       	call   b4c <strlen>
     a92:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a94:	59                   	pop    %ecx
     a95:	5e                   	pop    %esi
     a96:	53                   	push   %ebx
     a97:	8d 7d 08             	lea    0x8(%ebp),%edi
     a9a:	57                   	push   %edi
     a9b:	e8 e4 fd ff ff       	call   884 <parseline>
     aa0:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     aa2:	83 c4 0c             	add    $0xc,%esp
     aa5:	68 f2 10 00 00       	push   $0x10f2
     aaa:	53                   	push   %ebx
     aab:	57                   	push   %edi
     aac:	e8 bb fa ff ff       	call   56c <peek>
  if(s != es){
     ab1:	8b 45 08             	mov    0x8(%ebp),%eax
     ab4:	83 c4 10             	add    $0x10,%esp
     ab7:	39 d8                	cmp    %ebx,%eax
     ab9:	75 13                	jne    ace <parsecmd+0x4e>
  nulterminate(cmd);
     abb:	83 ec 0c             	sub    $0xc,%esp
     abe:	56                   	push   %esi
     abf:	e8 20 ff ff ff       	call   9e4 <nulterminate>
}
     ac4:	89 f0                	mov    %esi,%eax
     ac6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ac9:	5b                   	pop    %ebx
     aca:	5e                   	pop    %esi
     acb:	5f                   	pop    %edi
     acc:	5d                   	pop    %ebp
     acd:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     ace:	52                   	push   %edx
     acf:	50                   	push   %eax
     ad0:	68 66 11 00 00       	push   $0x1166
     ad5:	6a 02                	push   $0x2
     ad7:	e8 14 03 00 00       	call   df0 <printf>
    panic("syntax");
     adc:	c7 04 24 2a 11 00 00 	movl   $0x112a,(%esp)
     ae3:	e8 7c f6 ff ff       	call   164 <panic>

00000ae8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     ae8:	55                   	push   %ebp
     ae9:	89 e5                	mov    %esp,%ebp
     aeb:	53                   	push   %ebx
     aec:	8b 4d 08             	mov    0x8(%ebp),%ecx
     aef:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     af2:	31 c0                	xor    %eax,%eax
     af4:	8a 14 03             	mov    (%ebx,%eax,1),%dl
     af7:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     afa:	40                   	inc    %eax
     afb:	84 d2                	test   %dl,%dl
     afd:	75 f5                	jne    af4 <strcpy+0xc>
    ;
  return os;
}
     aff:	89 c8                	mov    %ecx,%eax
     b01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b04:	c9                   	leave  
     b05:	c3                   	ret    
     b06:	66 90                	xchg   %ax,%ax

00000b08 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b08:	55                   	push   %ebp
     b09:	89 e5                	mov    %esp,%ebp
     b0b:	53                   	push   %ebx
     b0c:	8b 55 08             	mov    0x8(%ebp),%edx
     b0f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     b12:	0f b6 02             	movzbl (%edx),%eax
     b15:	84 c0                	test   %al,%al
     b17:	75 10                	jne    b29 <strcmp+0x21>
     b19:	eb 2a                	jmp    b45 <strcmp+0x3d>
     b1b:	90                   	nop
    p++, q++;
     b1c:	42                   	inc    %edx
     b1d:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
     b20:	0f b6 02             	movzbl (%edx),%eax
     b23:	84 c0                	test   %al,%al
     b25:	74 11                	je     b38 <strcmp+0x30>
    p++, q++;
     b27:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
     b29:	0f b6 0b             	movzbl (%ebx),%ecx
     b2c:	38 c1                	cmp    %al,%cl
     b2e:	74 ec                	je     b1c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
     b30:	29 c8                	sub    %ecx,%eax
}
     b32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b35:	c9                   	leave  
     b36:	c3                   	ret    
     b37:	90                   	nop
  return (uchar)*p - (uchar)*q;
     b38:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
     b3c:	31 c0                	xor    %eax,%eax
     b3e:	29 c8                	sub    %ecx,%eax
}
     b40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b43:	c9                   	leave  
     b44:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
     b45:	0f b6 0b             	movzbl (%ebx),%ecx
     b48:	31 c0                	xor    %eax,%eax
     b4a:	eb e4                	jmp    b30 <strcmp+0x28>

00000b4c <strlen>:

uint
strlen(const char *s)
{
     b4c:	55                   	push   %ebp
     b4d:	89 e5                	mov    %esp,%ebp
     b4f:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     b52:	80 3a 00             	cmpb   $0x0,(%edx)
     b55:	74 15                	je     b6c <strlen+0x20>
     b57:	31 c0                	xor    %eax,%eax
     b59:	8d 76 00             	lea    0x0(%esi),%esi
     b5c:	40                   	inc    %eax
     b5d:	89 c1                	mov    %eax,%ecx
     b5f:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     b63:	75 f7                	jne    b5c <strlen+0x10>
    ;
  return n;
}
     b65:	89 c8                	mov    %ecx,%eax
     b67:	5d                   	pop    %ebp
     b68:	c3                   	ret    
     b69:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     b6c:	31 c9                	xor    %ecx,%ecx
}
     b6e:	89 c8                	mov    %ecx,%eax
     b70:	5d                   	pop    %ebp
     b71:	c3                   	ret    
     b72:	66 90                	xchg   %ax,%ax

00000b74 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b74:	55                   	push   %ebp
     b75:	89 e5                	mov    %esp,%ebp
     b77:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b78:	8b 7d 08             	mov    0x8(%ebp),%edi
     b7b:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b7e:	8b 45 0c             	mov    0xc(%ebp),%eax
     b81:	fc                   	cld    
     b82:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b84:	8b 45 08             	mov    0x8(%ebp),%eax
     b87:	8b 7d fc             	mov    -0x4(%ebp),%edi
     b8a:	c9                   	leave  
     b8b:	c3                   	ret    

00000b8c <strchr>:

char*
strchr(const char *s, char c)
{
     b8c:	55                   	push   %ebp
     b8d:	89 e5                	mov    %esp,%ebp
     b8f:	8b 45 08             	mov    0x8(%ebp),%eax
     b92:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
     b95:	8a 10                	mov    (%eax),%dl
     b97:	84 d2                	test   %dl,%dl
     b99:	75 0c                	jne    ba7 <strchr+0x1b>
     b9b:	eb 13                	jmp    bb0 <strchr+0x24>
     b9d:	8d 76 00             	lea    0x0(%esi),%esi
     ba0:	40                   	inc    %eax
     ba1:	8a 10                	mov    (%eax),%dl
     ba3:	84 d2                	test   %dl,%dl
     ba5:	74 09                	je     bb0 <strchr+0x24>
    if(*s == c)
     ba7:	38 d1                	cmp    %dl,%cl
     ba9:	75 f5                	jne    ba0 <strchr+0x14>
      return (char*)s;
  return 0;
}
     bab:	5d                   	pop    %ebp
     bac:	c3                   	ret    
     bad:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
     bb0:	31 c0                	xor    %eax,%eax
}
     bb2:	5d                   	pop    %ebp
     bb3:	c3                   	ret    

00000bb4 <gets>:

char*
gets(char *buf, int max)
{
     bb4:	55                   	push   %ebp
     bb5:	89 e5                	mov    %esp,%ebp
     bb7:	57                   	push   %edi
     bb8:	56                   	push   %esi
     bb9:	53                   	push   %ebx
     bba:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bbd:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
     bbf:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     bc2:	eb 24                	jmp    be8 <gets+0x34>
    cc = read(0, &c, 1);
     bc4:	50                   	push   %eax
     bc5:	6a 01                	push   $0x1
     bc7:	57                   	push   %edi
     bc8:	6a 00                	push   $0x0
     bca:	e8 08 01 00 00       	call   cd7 <read>
    if(cc < 1)
     bcf:	83 c4 10             	add    $0x10,%esp
     bd2:	85 c0                	test   %eax,%eax
     bd4:	7e 1c                	jle    bf2 <gets+0x3e>
      break;
    buf[i++] = c;
     bd6:	8a 45 e7             	mov    -0x19(%ebp),%al
     bd9:	8b 55 08             	mov    0x8(%ebp),%edx
     bdc:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     be0:	3c 0a                	cmp    $0xa,%al
     be2:	74 20                	je     c04 <gets+0x50>
     be4:	3c 0d                	cmp    $0xd,%al
     be6:	74 1c                	je     c04 <gets+0x50>
  for(i=0; i+1 < max; ){
     be8:	89 de                	mov    %ebx,%esi
     bea:	8d 5b 01             	lea    0x1(%ebx),%ebx
     bed:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     bf0:	7c d2                	jl     bc4 <gets+0x10>
      break;
  }
  buf[i] = '\0';
     bf2:	8b 45 08             	mov    0x8(%ebp),%eax
     bf5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     bf9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bfc:	5b                   	pop    %ebx
     bfd:	5e                   	pop    %esi
     bfe:	5f                   	pop    %edi
     bff:	5d                   	pop    %ebp
     c00:	c3                   	ret    
     c01:	8d 76 00             	lea    0x0(%esi),%esi
     c04:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
     c06:	8b 45 08             	mov    0x8(%ebp),%eax
     c09:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
     c0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c10:	5b                   	pop    %ebx
     c11:	5e                   	pop    %esi
     c12:	5f                   	pop    %edi
     c13:	5d                   	pop    %ebp
     c14:	c3                   	ret    
     c15:	8d 76 00             	lea    0x0(%esi),%esi

00000c18 <stat>:

int
stat(const char *n, struct stat *st)
{
     c18:	55                   	push   %ebp
     c19:	89 e5                	mov    %esp,%ebp
     c1b:	56                   	push   %esi
     c1c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c1d:	83 ec 08             	sub    $0x8,%esp
     c20:	6a 00                	push   $0x0
     c22:	ff 75 08             	push   0x8(%ebp)
     c25:	e8 d5 00 00 00       	call   cff <open>
  if(fd < 0)
     c2a:	83 c4 10             	add    $0x10,%esp
     c2d:	85 c0                	test   %eax,%eax
     c2f:	78 27                	js     c58 <stat+0x40>
     c31:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
     c33:	83 ec 08             	sub    $0x8,%esp
     c36:	ff 75 0c             	push   0xc(%ebp)
     c39:	50                   	push   %eax
     c3a:	e8 d8 00 00 00       	call   d17 <fstat>
     c3f:	89 c6                	mov    %eax,%esi
  close(fd);
     c41:	89 1c 24             	mov    %ebx,(%esp)
     c44:	e8 9e 00 00 00       	call   ce7 <close>
  return r;
     c49:	83 c4 10             	add    $0x10,%esp
}
     c4c:	89 f0                	mov    %esi,%eax
     c4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c51:	5b                   	pop    %ebx
     c52:	5e                   	pop    %esi
     c53:	5d                   	pop    %ebp
     c54:	c3                   	ret    
     c55:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     c58:	be ff ff ff ff       	mov    $0xffffffff,%esi
     c5d:	eb ed                	jmp    c4c <stat+0x34>
     c5f:	90                   	nop

00000c60 <atoi>:

int
atoi(const char *s)
{
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	53                   	push   %ebx
     c64:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c67:	0f be 01             	movsbl (%ecx),%eax
     c6a:	8d 50 d0             	lea    -0x30(%eax),%edx
     c6d:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
     c70:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
     c75:	77 16                	ja     c8d <atoi+0x2d>
     c77:	90                   	nop
    n = n*10 + *s++ - '0';
     c78:	41                   	inc    %ecx
     c79:	8d 14 92             	lea    (%edx,%edx,4),%edx
     c7c:	01 d2                	add    %edx,%edx
     c7e:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
     c82:	0f be 01             	movsbl (%ecx),%eax
     c85:	8d 58 d0             	lea    -0x30(%eax),%ebx
     c88:	80 fb 09             	cmp    $0x9,%bl
     c8b:	76 eb                	jbe    c78 <atoi+0x18>
  return n;
}
     c8d:	89 d0                	mov    %edx,%eax
     c8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c92:	c9                   	leave  
     c93:	c3                   	ret    

00000c94 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     c94:	55                   	push   %ebp
     c95:	89 e5                	mov    %esp,%ebp
     c97:	57                   	push   %edi
     c98:	56                   	push   %esi
     c99:	8b 55 08             	mov    0x8(%ebp),%edx
     c9c:	8b 75 0c             	mov    0xc(%ebp),%esi
     c9f:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     ca2:	85 c0                	test   %eax,%eax
     ca4:	7e 0b                	jle    cb1 <memmove+0x1d>
     ca6:	01 d0                	add    %edx,%eax
  dst = vdst;
     ca8:	89 d7                	mov    %edx,%edi
     caa:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
     cac:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     cad:	39 f8                	cmp    %edi,%eax
     caf:	75 fb                	jne    cac <memmove+0x18>
  return vdst;
}
     cb1:	89 d0                	mov    %edx,%eax
     cb3:	5e                   	pop    %esi
     cb4:	5f                   	pop    %edi
     cb5:	5d                   	pop    %ebp
     cb6:	c3                   	ret    

00000cb7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     cb7:	b8 01 00 00 00       	mov    $0x1,%eax
     cbc:	cd 40                	int    $0x40
     cbe:	c3                   	ret    

00000cbf <exit>:
SYSCALL(exit)
     cbf:	b8 02 00 00 00       	mov    $0x2,%eax
     cc4:	cd 40                	int    $0x40
     cc6:	c3                   	ret    

00000cc7 <wait>:
SYSCALL(wait)
     cc7:	b8 03 00 00 00       	mov    $0x3,%eax
     ccc:	cd 40                	int    $0x40
     cce:	c3                   	ret    

00000ccf <pipe>:
SYSCALL(pipe)
     ccf:	b8 04 00 00 00       	mov    $0x4,%eax
     cd4:	cd 40                	int    $0x40
     cd6:	c3                   	ret    

00000cd7 <read>:
SYSCALL(read)
     cd7:	b8 05 00 00 00       	mov    $0x5,%eax
     cdc:	cd 40                	int    $0x40
     cde:	c3                   	ret    

00000cdf <write>:
SYSCALL(write)
     cdf:	b8 10 00 00 00       	mov    $0x10,%eax
     ce4:	cd 40                	int    $0x40
     ce6:	c3                   	ret    

00000ce7 <close>:
SYSCALL(close)
     ce7:	b8 15 00 00 00       	mov    $0x15,%eax
     cec:	cd 40                	int    $0x40
     cee:	c3                   	ret    

00000cef <kill>:
SYSCALL(kill)
     cef:	b8 06 00 00 00       	mov    $0x6,%eax
     cf4:	cd 40                	int    $0x40
     cf6:	c3                   	ret    

00000cf7 <exec>:
SYSCALL(exec)
     cf7:	b8 07 00 00 00       	mov    $0x7,%eax
     cfc:	cd 40                	int    $0x40
     cfe:	c3                   	ret    

00000cff <open>:
SYSCALL(open)
     cff:	b8 0f 00 00 00       	mov    $0xf,%eax
     d04:	cd 40                	int    $0x40
     d06:	c3                   	ret    

00000d07 <mknod>:
SYSCALL(mknod)
     d07:	b8 11 00 00 00       	mov    $0x11,%eax
     d0c:	cd 40                	int    $0x40
     d0e:	c3                   	ret    

00000d0f <unlink>:
SYSCALL(unlink)
     d0f:	b8 12 00 00 00       	mov    $0x12,%eax
     d14:	cd 40                	int    $0x40
     d16:	c3                   	ret    

00000d17 <fstat>:
SYSCALL(fstat)
     d17:	b8 08 00 00 00       	mov    $0x8,%eax
     d1c:	cd 40                	int    $0x40
     d1e:	c3                   	ret    

00000d1f <link>:
SYSCALL(link)
     d1f:	b8 13 00 00 00       	mov    $0x13,%eax
     d24:	cd 40                	int    $0x40
     d26:	c3                   	ret    

00000d27 <mkdir>:
SYSCALL(mkdir)
     d27:	b8 14 00 00 00       	mov    $0x14,%eax
     d2c:	cd 40                	int    $0x40
     d2e:	c3                   	ret    

00000d2f <chdir>:
SYSCALL(chdir)
     d2f:	b8 09 00 00 00       	mov    $0x9,%eax
     d34:	cd 40                	int    $0x40
     d36:	c3                   	ret    

00000d37 <dup>:
SYSCALL(dup)
     d37:	b8 0a 00 00 00       	mov    $0xa,%eax
     d3c:	cd 40                	int    $0x40
     d3e:	c3                   	ret    

00000d3f <getpid>:
SYSCALL(getpid)
     d3f:	b8 0b 00 00 00       	mov    $0xb,%eax
     d44:	cd 40                	int    $0x40
     d46:	c3                   	ret    

00000d47 <sbrk>:
SYSCALL(sbrk)
     d47:	b8 0c 00 00 00       	mov    $0xc,%eax
     d4c:	cd 40                	int    $0x40
     d4e:	c3                   	ret    

00000d4f <sleep>:
SYSCALL(sleep)
     d4f:	b8 0d 00 00 00       	mov    $0xd,%eax
     d54:	cd 40                	int    $0x40
     d56:	c3                   	ret    

00000d57 <uptime>:
SYSCALL(uptime)
     d57:	b8 0e 00 00 00       	mov    $0xe,%eax
     d5c:	cd 40                	int    $0x40
     d5e:	c3                   	ret    

00000d5f <getprocs>:
SYSCALL(getprocs)
     d5f:	b8 16 00 00 00       	mov    $0x16,%eax
     d64:	cd 40                	int    $0x40
     d66:	c3                   	ret    
     d67:	90                   	nop

00000d68 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     d68:	55                   	push   %ebp
     d69:	89 e5                	mov    %esp,%ebp
     d6b:	57                   	push   %edi
     d6c:	56                   	push   %esi
     d6d:	53                   	push   %ebx
     d6e:	83 ec 3c             	sub    $0x3c,%esp
     d71:	89 45 bc             	mov    %eax,-0x44(%ebp)
     d74:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     d77:	89 d1                	mov    %edx,%ecx
  if(sgn && xx < 0){
     d79:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d7c:	85 db                	test   %ebx,%ebx
     d7e:	74 04                	je     d84 <printint+0x1c>
     d80:	85 d2                	test   %edx,%edx
     d82:	78 68                	js     dec <printint+0x84>
  neg = 0;
     d84:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     d8b:	31 ff                	xor    %edi,%edi
     d8d:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
     d90:	89 c8                	mov    %ecx,%eax
     d92:	31 d2                	xor    %edx,%edx
     d94:	f7 75 c4             	divl   -0x3c(%ebp)
     d97:	89 fb                	mov    %edi,%ebx
     d99:	8d 7f 01             	lea    0x1(%edi),%edi
     d9c:	8a 92 1c 12 00 00    	mov    0x121c(%edx),%dl
     da2:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
     da6:	89 4d c0             	mov    %ecx,-0x40(%ebp)
     da9:	89 c1                	mov    %eax,%ecx
     dab:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     dae:	3b 45 c0             	cmp    -0x40(%ebp),%eax
     db1:	76 dd                	jbe    d90 <printint+0x28>
  if(neg)
     db3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     db6:	85 c9                	test   %ecx,%ecx
     db8:	74 09                	je     dc3 <printint+0x5b>
    buf[i++] = '-';
     dba:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    buf[i++] = digits[x % base];
     dbf:	89 fb                	mov    %edi,%ebx
    buf[i++] = '-';
     dc1:	b2 2d                	mov    $0x2d,%dl

  while(--i >= 0)
     dc3:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
     dc7:	8b 7d bc             	mov    -0x44(%ebp),%edi
     dca:	eb 03                	jmp    dcf <printint+0x67>
    putc(fd, buf[i]);
     dcc:	8a 13                	mov    (%ebx),%dl
     dce:	4b                   	dec    %ebx
     dcf:	88 55 d7             	mov    %dl,-0x29(%ebp)
  write(fd, &c, 1);
     dd2:	50                   	push   %eax
     dd3:	6a 01                	push   $0x1
     dd5:	56                   	push   %esi
     dd6:	57                   	push   %edi
     dd7:	e8 03 ff ff ff       	call   cdf <write>
  while(--i >= 0)
     ddc:	83 c4 10             	add    $0x10,%esp
     ddf:	39 de                	cmp    %ebx,%esi
     de1:	75 e9                	jne    dcc <printint+0x64>
}
     de3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     de6:	5b                   	pop    %ebx
     de7:	5e                   	pop    %esi
     de8:	5f                   	pop    %edi
     de9:	5d                   	pop    %ebp
     dea:	c3                   	ret    
     deb:	90                   	nop
    x = -xx;
     dec:	f7 d9                	neg    %ecx
     dee:	eb 9b                	jmp    d8b <printint+0x23>

00000df0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     df0:	55                   	push   %ebp
     df1:	89 e5                	mov    %esp,%ebp
     df3:	57                   	push   %edi
     df4:	56                   	push   %esi
     df5:	53                   	push   %ebx
     df6:	83 ec 2c             	sub    $0x2c,%esp
     df9:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     dfc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     dff:	8a 13                	mov    (%ebx),%dl
     e01:	84 d2                	test   %dl,%dl
     e03:	74 64                	je     e69 <printf+0x79>
     e05:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
     e06:	8d 45 10             	lea    0x10(%ebp),%eax
     e09:	89 45 d0             	mov    %eax,-0x30(%ebp)
  state = 0;
     e0c:	31 c9                	xor    %ecx,%ecx
  write(fd, &c, 1);
     e0e:	8d 7d e7             	lea    -0x19(%ebp),%edi
     e11:	eb 24                	jmp    e37 <printf+0x47>
     e13:	90                   	nop
     e14:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e17:	83 f8 25             	cmp    $0x25,%eax
     e1a:	74 40                	je     e5c <printf+0x6c>
        state = '%';
      } else {
        putc(fd, c);
     e1c:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
     e1f:	50                   	push   %eax
     e20:	6a 01                	push   $0x1
     e22:	57                   	push   %edi
     e23:	56                   	push   %esi
     e24:	e8 b6 fe ff ff       	call   cdf <write>
        putc(fd, c);
     e29:	83 c4 10             	add    $0x10,%esp
     e2c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(i = 0; fmt[i]; i++){
     e2f:	43                   	inc    %ebx
     e30:	8a 53 ff             	mov    -0x1(%ebx),%dl
     e33:	84 d2                	test   %dl,%dl
     e35:	74 32                	je     e69 <printf+0x79>
    c = fmt[i] & 0xff;
     e37:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
     e3a:	85 c9                	test   %ecx,%ecx
     e3c:	74 d6                	je     e14 <printf+0x24>
      }
    } else if(state == '%'){
     e3e:	83 f9 25             	cmp    $0x25,%ecx
     e41:	75 ec                	jne    e2f <printf+0x3f>
      if(c == 'd'){
     e43:	83 f8 25             	cmp    $0x25,%eax
     e46:	0f 84 e4 00 00 00    	je     f30 <printf+0x140>
     e4c:	83 e8 63             	sub    $0x63,%eax
     e4f:	83 f8 15             	cmp    $0x15,%eax
     e52:	77 20                	ja     e74 <printf+0x84>
     e54:	ff 24 85 c4 11 00 00 	jmp    *0x11c4(,%eax,4)
     e5b:	90                   	nop
        state = '%';
     e5c:	b9 25 00 00 00       	mov    $0x25,%ecx
  for(i = 0; fmt[i]; i++){
     e61:	43                   	inc    %ebx
     e62:	8a 53 ff             	mov    -0x1(%ebx),%dl
     e65:	84 d2                	test   %dl,%dl
     e67:	75 ce                	jne    e37 <printf+0x47>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     e69:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e6c:	5b                   	pop    %ebx
     e6d:	5e                   	pop    %esi
     e6e:	5f                   	pop    %edi
     e6f:	5d                   	pop    %ebp
     e70:	c3                   	ret    
     e71:	8d 76 00             	lea    0x0(%esi),%esi
     e74:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        putc(fd, '%');
     e77:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
     e7b:	50                   	push   %eax
     e7c:	6a 01                	push   $0x1
     e7e:	57                   	push   %edi
     e7f:	56                   	push   %esi
     e80:	e8 5a fe ff ff       	call   cdf <write>
        putc(fd, c);
     e85:	8a 55 d4             	mov    -0x2c(%ebp),%dl
     e88:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
     e8b:	83 c4 0c             	add    $0xc,%esp
     e8e:	6a 01                	push   $0x1
     e90:	57                   	push   %edi
     e91:	56                   	push   %esi
     e92:	e8 48 fe ff ff       	call   cdf <write>
        putc(fd, c);
     e97:	83 c4 10             	add    $0x10,%esp
      state = 0;
     e9a:	31 c9                	xor    %ecx,%ecx
     e9c:	eb 91                	jmp    e2f <printf+0x3f>
     e9e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
     ea0:	83 ec 0c             	sub    $0xc,%esp
     ea3:	6a 00                	push   $0x0
     ea5:	b9 10 00 00 00       	mov    $0x10,%ecx
     eaa:	8b 45 d0             	mov    -0x30(%ebp),%eax
     ead:	8b 10                	mov    (%eax),%edx
     eaf:	89 f0                	mov    %esi,%eax
     eb1:	e8 b2 fe ff ff       	call   d68 <printint>
        ap++;
     eb6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
     eba:	83 c4 10             	add    $0x10,%esp
      state = 0;
     ebd:	31 c9                	xor    %ecx,%ecx
        ap++;
     ebf:	e9 6b ff ff ff       	jmp    e2f <printf+0x3f>
        s = (char*)*ap;
     ec4:	8b 45 d0             	mov    -0x30(%ebp),%eax
     ec7:	8b 10                	mov    (%eax),%edx
        ap++;
     ec9:	83 c0 04             	add    $0x4,%eax
     ecc:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
     ecf:	85 d2                	test   %edx,%edx
     ed1:	74 69                	je     f3c <printf+0x14c>
        while(*s != 0){
     ed3:	8a 02                	mov    (%edx),%al
     ed5:	84 c0                	test   %al,%al
     ed7:	74 71                	je     f4a <printf+0x15a>
     ed9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     edc:	89 d3                	mov    %edx,%ebx
     ede:	66 90                	xchg   %ax,%ax
          putc(fd, *s);
     ee0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
     ee3:	50                   	push   %eax
     ee4:	6a 01                	push   $0x1
     ee6:	57                   	push   %edi
     ee7:	56                   	push   %esi
     ee8:	e8 f2 fd ff ff       	call   cdf <write>
          s++;
     eed:	43                   	inc    %ebx
        while(*s != 0){
     eee:	8a 03                	mov    (%ebx),%al
     ef0:	83 c4 10             	add    $0x10,%esp
     ef3:	84 c0                	test   %al,%al
     ef5:	75 e9                	jne    ee0 <printf+0xf0>
      state = 0;
     ef7:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
     efa:	31 c9                	xor    %ecx,%ecx
     efc:	e9 2e ff ff ff       	jmp    e2f <printf+0x3f>
     f01:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
     f04:	83 ec 0c             	sub    $0xc,%esp
     f07:	6a 01                	push   $0x1
     f09:	b9 0a 00 00 00       	mov    $0xa,%ecx
     f0e:	eb 9a                	jmp    eaa <printf+0xba>
        putc(fd, *ap);
     f10:	8b 45 d0             	mov    -0x30(%ebp),%eax
     f13:	8b 00                	mov    (%eax),%eax
     f15:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
     f18:	51                   	push   %ecx
     f19:	6a 01                	push   $0x1
     f1b:	57                   	push   %edi
     f1c:	56                   	push   %esi
     f1d:	e8 bd fd ff ff       	call   cdf <write>
        ap++;
     f22:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
     f26:	83 c4 10             	add    $0x10,%esp
      state = 0;
     f29:	31 c9                	xor    %ecx,%ecx
     f2b:	e9 ff fe ff ff       	jmp    e2f <printf+0x3f>
        putc(fd, c);
     f30:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
     f33:	52                   	push   %edx
     f34:	e9 55 ff ff ff       	jmp    e8e <printf+0x9e>
     f39:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
     f3c:	ba bc 11 00 00       	mov    $0x11bc,%edx
        while(*s != 0){
     f41:	b0 28                	mov    $0x28,%al
     f43:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     f46:	89 d3                	mov    %edx,%ebx
     f48:	eb 96                	jmp    ee0 <printf+0xf0>
      state = 0;
     f4a:	31 c9                	xor    %ecx,%ecx
     f4c:	e9 de fe ff ff       	jmp    e2f <printf+0x3f>
     f51:	66 90                	xchg   %ax,%ax
     f53:	90                   	nop

00000f54 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     f54:	55                   	push   %ebp
     f55:	89 e5                	mov    %esp,%ebp
     f57:	57                   	push   %edi
     f58:	56                   	push   %esi
     f59:	53                   	push   %ebx
     f5a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
     f5d:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f60:	a1 a4 12 00 00       	mov    0x12a4,%eax
     f65:	8d 76 00             	lea    0x0(%esi),%esi
     f68:	89 c2                	mov    %eax,%edx
     f6a:	8b 00                	mov    (%eax),%eax
     f6c:	39 ca                	cmp    %ecx,%edx
     f6e:	73 2c                	jae    f9c <free+0x48>
     f70:	39 c1                	cmp    %eax,%ecx
     f72:	72 04                	jb     f78 <free+0x24>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f74:	39 c2                	cmp    %eax,%edx
     f76:	72 f0                	jb     f68 <free+0x14>
      break;
  if(bp + bp->s.size == p->s.ptr){
     f78:	8b 73 fc             	mov    -0x4(%ebx),%esi
     f7b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     f7e:	39 f8                	cmp    %edi,%eax
     f80:	74 2c                	je     fae <free+0x5a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
     f82:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
     f85:	8b 42 04             	mov    0x4(%edx),%eax
     f88:	8d 34 c2             	lea    (%edx,%eax,8),%esi
     f8b:	39 f1                	cmp    %esi,%ecx
     f8d:	74 36                	je     fc5 <free+0x71>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
     f8f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
     f91:	89 15 a4 12 00 00    	mov    %edx,0x12a4
}
     f97:	5b                   	pop    %ebx
     f98:	5e                   	pop    %esi
     f99:	5f                   	pop    %edi
     f9a:	5d                   	pop    %ebp
     f9b:	c3                   	ret    
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f9c:	39 c2                	cmp    %eax,%edx
     f9e:	72 c8                	jb     f68 <free+0x14>
     fa0:	39 c1                	cmp    %eax,%ecx
     fa2:	73 c4                	jae    f68 <free+0x14>
  if(bp + bp->s.size == p->s.ptr){
     fa4:	8b 73 fc             	mov    -0x4(%ebx),%esi
     fa7:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     faa:	39 f8                	cmp    %edi,%eax
     fac:	75 d4                	jne    f82 <free+0x2e>
    bp->s.size += p->s.ptr->s.size;
     fae:	03 70 04             	add    0x4(%eax),%esi
     fb1:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
     fb4:	8b 02                	mov    (%edx),%eax
     fb6:	8b 00                	mov    (%eax),%eax
     fb8:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
     fbb:	8b 42 04             	mov    0x4(%edx),%eax
     fbe:	8d 34 c2             	lea    (%edx,%eax,8),%esi
     fc1:	39 f1                	cmp    %esi,%ecx
     fc3:	75 ca                	jne    f8f <free+0x3b>
    p->s.size += bp->s.size;
     fc5:	03 43 fc             	add    -0x4(%ebx),%eax
     fc8:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
     fcb:	8b 4b f8             	mov    -0x8(%ebx),%ecx
     fce:	89 0a                	mov    %ecx,(%edx)
  freep = p;
     fd0:	89 15 a4 12 00 00    	mov    %edx,0x12a4
}
     fd6:	5b                   	pop    %ebx
     fd7:	5e                   	pop    %esi
     fd8:	5f                   	pop    %edi
     fd9:	5d                   	pop    %ebp
     fda:	c3                   	ret    
     fdb:	90                   	nop

00000fdc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
     fdc:	55                   	push   %ebp
     fdd:	89 e5                	mov    %esp,%ebp
     fdf:	57                   	push   %edi
     fe0:	56                   	push   %esi
     fe1:	53                   	push   %ebx
     fe2:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fe5:	8b 45 08             	mov    0x8(%ebp),%eax
     fe8:	8d 70 07             	lea    0x7(%eax),%esi
     feb:	c1 ee 03             	shr    $0x3,%esi
     fee:	46                   	inc    %esi
  if((prevp = freep) == 0){
     fef:	8b 3d a4 12 00 00    	mov    0x12a4,%edi
     ff5:	85 ff                	test   %edi,%edi
     ff7:	0f 84 a3 00 00 00    	je     10a0 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ffd:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
     fff:	8b 4a 04             	mov    0x4(%edx),%ecx
    1002:	39 f1                	cmp    %esi,%ecx
    1004:	73 68                	jae    106e <malloc+0x92>
    1006:	89 f3                	mov    %esi,%ebx
    1008:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    100e:	0f 82 80 00 00 00    	jb     1094 <malloc+0xb8>
  p = sbrk(nu * sizeof(Header));
    1014:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    101b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    101e:	eb 11                	jmp    1031 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1020:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1022:	8b 48 04             	mov    0x4(%eax),%ecx
    1025:	39 f1                	cmp    %esi,%ecx
    1027:	73 4b                	jae    1074 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1029:	8b 3d a4 12 00 00    	mov    0x12a4,%edi
    102f:	89 c2                	mov    %eax,%edx
    1031:	39 d7                	cmp    %edx,%edi
    1033:	75 eb                	jne    1020 <malloc+0x44>
  p = sbrk(nu * sizeof(Header));
    1035:	83 ec 0c             	sub    $0xc,%esp
    1038:	ff 75 e4             	push   -0x1c(%ebp)
    103b:	e8 07 fd ff ff       	call   d47 <sbrk>
  if(p == (char*)-1)
    1040:	83 c4 10             	add    $0x10,%esp
    1043:	83 f8 ff             	cmp    $0xffffffff,%eax
    1046:	74 1c                	je     1064 <malloc+0x88>
  hp->s.size = nu;
    1048:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    104b:	83 ec 0c             	sub    $0xc,%esp
    104e:	83 c0 08             	add    $0x8,%eax
    1051:	50                   	push   %eax
    1052:	e8 fd fe ff ff       	call   f54 <free>
  return freep;
    1057:	8b 15 a4 12 00 00    	mov    0x12a4,%edx
      if((p = morecore(nunits)) == 0)
    105d:	83 c4 10             	add    $0x10,%esp
    1060:	85 d2                	test   %edx,%edx
    1062:	75 bc                	jne    1020 <malloc+0x44>
        return 0;
    1064:	31 c0                	xor    %eax,%eax
  }
}
    1066:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1069:	5b                   	pop    %ebx
    106a:	5e                   	pop    %esi
    106b:	5f                   	pop    %edi
    106c:	5d                   	pop    %ebp
    106d:	c3                   	ret    
    if(p->s.size >= nunits){
    106e:	89 d0                	mov    %edx,%eax
    1070:	89 fa                	mov    %edi,%edx
    1072:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
    1074:	39 ce                	cmp    %ecx,%esi
    1076:	74 54                	je     10cc <malloc+0xf0>
        p->s.size -= nunits;
    1078:	29 f1                	sub    %esi,%ecx
    107a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    107d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1080:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    1083:	89 15 a4 12 00 00    	mov    %edx,0x12a4
      return (void*)(p + 1);
    1089:	83 c0 08             	add    $0x8,%eax
}
    108c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    108f:	5b                   	pop    %ebx
    1090:	5e                   	pop    %esi
    1091:	5f                   	pop    %edi
    1092:	5d                   	pop    %ebp
    1093:	c3                   	ret    
    1094:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1099:	e9 76 ff ff ff       	jmp    1014 <malloc+0x38>
    109e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    10a0:	c7 05 a4 12 00 00 a8 	movl   $0x12a8,0x12a4
    10a7:	12 00 00 
    10aa:	c7 05 a8 12 00 00 a8 	movl   $0x12a8,0x12a8
    10b1:	12 00 00 
    base.s.size = 0;
    10b4:	c7 05 ac 12 00 00 00 	movl   $0x0,0x12ac
    10bb:	00 00 00 
    10be:	bf a8 12 00 00       	mov    $0x12a8,%edi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10c3:	89 fa                	mov    %edi,%edx
    10c5:	e9 3c ff ff ff       	jmp    1006 <malloc+0x2a>
    10ca:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
    10cc:	8b 08                	mov    (%eax),%ecx
    10ce:	89 0a                	mov    %ecx,(%edx)
    10d0:	eb b1                	jmp    1083 <malloc+0xa7>
