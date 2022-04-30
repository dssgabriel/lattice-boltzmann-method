address;source_location;insn;indent
0x11e0;:0;LEA	0x8(%RSP),%R10;
0x11e5;:0;AND	$-0x20,%RSP;
0x11e9;:0;PUSHQ	-0x8(%R10);
0x11ed;:0;MOV	$0x3,%EDX;
0x11f2;:0;PUSH	%RBP;
0x11f3;:0;MOV	%RSP,%RBP;
0x11f6;:0;PUSH	%R15;
0x11f8;:0;LEA	-0x8f4(%RBP),%RCX;
0x11ff;:0;PUSH	%R14;
0x1201;:0;PUSH	%R13;
0x1203;:0;PUSH	%R12;
0x1205;:0;PUSH	%R10;
0x1207;:0;PUSH	%RBX;
0x1208;:0;LEA	-0x870(%RBP),%RBX;
0x120f;:0;VMOVQ	%RBX,%XMM5;
0x1214;:0;SUB	$0x960,%RSP;
0x121b;:0;MOV	%EDI,-0x904(%RBP);
0x1221;:0;MOV	%RSI,-0x910(%RBP);
0x1228;:0;LEA	-0x904(%RBP),%RDI;
0x122f;:0;LEA	-0x910(%RBP),%RSI;
0x1236;:0;MOV	%FS:0x28,%RAX;
0x123f;:0;MOV	%RAX,-0x38(%RBP);
0x1243;:0;XOR	%EAX,%EAX;
0x1245;:0;LEA	-0x880(%RBP),%RAX;
0x124c;:0;VMOVQ	%RAX,%XMM1;
0x1251;:0;VPINSRQ	$0x1,%RAX,%XMM5,%XMM0;
0x1257;:0;VPINSRQ	$0x1,%RBX,%XMM1,%XMM4;
0x125d;:0;VMOVDQA	%XMM0,-0x940(%RBP);
0x1265;:0;VMOVDQA	%XMM4,-0x950(%RBP);
0x126d;:0;MOV	%RAX,-0x970(%RBP);
0x1274;:0;MOV	%RBX,-0x960(%RBP);
0x127b;:0;CALL	1040 <MPI_Init_thread@plt>;
0x1280;:0;LEA	-0x8f8(%RBP),%RSI;
0x1287;:0;MOV	$0x44000000,%EDI;
0x128c;:0;CALL	1150 <MPI_Comm_rank@plt>;
0x1291;:0;LEA	-0x8fc(%RBP),%RSI;
0x1298;:0;MOV	$0x44000000,%EDI;
0x129d;:0;CALL	1100 <MPI_Comm_size@plt>;
0x12a2;:0;LEA	0x3da5(%RIP),%RDX;
0x12a9;:0;CMPL	$0x1,-0x904(%RBP);
0x12b0;:0;MOV	%RDX,-0x920(%RBP);
0x12b7;:0;JLE	12cb <main+0xeb>;
0x12b9;:0;MOV	-0x910(%RBP),%RCX;
0x12c0;:0;MOV	0x8(%RCX),%RSI;
0x12c4;:0;MOV	%RSI,-0x920(%RBP);
0x12cb;:0;MOV	-0x920(%RBP),%RDI;
0x12d2;:0;LEA	0x3ee1(%RIP),%RSI;
0x12d9;:0;CALL	1110 <fopen@plt>;
0x12de;:0;MOV	%RAX,%R14;
0x12e1;:0;TEST	%RAX,%RAX;
0x12e4;:0;JE	2803 <main+0x1623>;
0x12ea;:0;VMOVAPD	0x43ee(%RIP),%YMM2;
0x12f2;:0;MOV	0x43a7(%RIP),%R8;
0x12f9;:0;MOV	$0x32000002710,%RDI;
0x1303;:0;XOR	%R13D,%R13D;
0x1306;:0;LEA	-0x840(%RBP),%R12;
0x130d;:0;LEA	0x3d45(%RIP),%RBX;
0x1314;:0;MOV	%RDI,0x5e05(%RIP);
0x131b;:0;MOVL	$0x64,0x5e03(%RIP);
0x1325;:0;MOV	%R8,0x5e24(%RIP);
0x132c;:0;MOVQ	$0,0x5e31(%RIP);
0x1337;:0;MOVL	$0x32,0x5e2f(%RIP);
0x1341;:0;VMOVUPD	%YMM2,0x5de7(%RIP);
0x1349;:0;VZEROUPPER;
0x134c;:0;NOPL	(%RAX);
0x1350;:0;MOV	%R14,%RDX;(6) 
0x1353;:0;MOV	$0x400,%ESI;(6) 
0x1358;:0;MOV	%R12,%RDI;(6) 
0x135b;:0;CALL	1190 <fgets@plt>;(6) 
0x1360;:0;TEST	%RAX,%RAX;(6) 
0x1363;:0;JE	1467 <main+0x287>;(6) 
0x1369;:0;INC	%R13D;(6) 
0x136c;:0;CMPB	$0x23,-0x840(%RBP);(6) 
0x1373;:0;JE	1350 <main+0x170>;(6) 
0x1375;:0;LEA	-0x890(%RBP),%R15;(6) 
0x137c;:0;XOR	%EAX,%EAX;(6) 
0x137e;:0;MOV	%R15,%RDX;(6) 
0x1381;:0;MOV	%RBX,%RSI;(6) 
0x1384;:0;MOV	%R12,%RDI;(6) 
0x1387;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x138c;:0;CMP	$0x1,%EAX;(6) 
0x138f;:0;JNE	139f <main+0x1bf>;(6) 
0x1391;:0;MOV	-0x890(%RBP),%ESI;(6) 
0x1397;:0;MOV	%ESI,0x5d83(%RIP);(6) 
0x139d;:0;JMP	1350 <main+0x170>;(6) 
0x139f;:0;XOR	%EAX,%EAX;(6) 
0x13a1;:0;MOV	%R15,%RDX;(6) 
0x13a4;:0;LEA	0x3cbf(%RIP),%RSI;(6) 
0x13ab;:0;MOV	%R12,%RDI;(6) 
0x13ae;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x13b3;:0;CMP	$0x1,%EAX;(6) 
0x13b6;:0;JNE	13fe <main+0x21e>;(6) 
0x13b8;:0;VXORPD	%XMM5,%XMM5,%XMM5;(6) 
0x13bc;:0;VCOMISD	0x5d6c(%RIP),%XMM5;(6) 
0x13c4;:0;MOV	-0x890(%RBP),%EAX;(6) 
0x13ca;:0;MOV	%EAX,0x5d54(%RIP);(6) 
0x13d0;:0;JNE	1350 <main+0x170>;(6) 
0x13d6;:0;VXORPD	%XMM1,%XMM1,%XMM1;(6) 
0x13da;:0;VCVTUSI2SD	%EAX,%XMM1,%XMM7;(6) 
0x13e0;:0;VMOVSD	0x4330(%RIP),%XMM14;(6) 
0x13e8;:0;VFMADD132SD	0x42b7(%RIP),%XMM14,%XMM7;(6) 
0x13f1;:0;VMOVSD	%XMM7,0x5d37(%RIP);(6) 
0x13f9;:0;JMP	1350 <main+0x170>;(6) 
0x13fe;:0;XOR	%EAX,%EAX;(6) 
0x1400;:0;MOV	%R15,%RDX;(6) 
0x1403;:0;LEA	0x3c6c(%RIP),%RSI;(6) 
0x140a;:0;MOV	%R12,%RDI;(6) 
0x140d;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x1412;:0;CMP	$0x1,%EAX;(6) 
0x1415;:0;JNE	2331 <main+0x1151>;(6) 
0x141b;:0;VXORPD	%XMM11,%XMM11,%XMM11;(6) 
0x1420;:0;VCOMISD	0x5d10(%RIP),%XMM11;(6) 
0x1428;:0;MOV	-0x890(%RBP),%ECX;(6) 
0x142e;:0;MOV	%ECX,0x5cf4(%RIP);(6) 
0x1434;:0;JNE	1350 <main+0x170>;(6) 
0x143a;:0;VXORPD	%XMM12,%XMM12,%XMM12;(6) 
0x143f;:0;VCVTUSI2SD	%ECX,%XMM12,%XMM3;(6) 
0x1445;:0;VMOVAPD	0x42c3(%RIP),%XMM4;(6) 
0x144d;:0;VMOVDDUP	%XMM3,%XMM0;(6) 
0x1451;:0;VFMADD132PD	0x42a6(%RIP),%XMM4,%XMM0;(6) 
0x145a;:0;VMOVUPD	%XMM0,0x5cd6(%RIP);(6) 
0x1462;:0;JMP	1350 <main+0x170>;(6) 
0x1467;:0;MOV	%R14,%RDI;
0x146a;:0;MOV	%RAX,-0x930(%RBP);
0x1471;:0;CALL	1180 <feof@plt>;
0x1476;:0;TEST	%EAX,%EAX;
0x1478;:0;JE	2803 <main+0x1623>;
0x147e;:0;VMOVSD	0x5cc2(%RIP),%XMM4;
0x1486;:0;VMOVSD	0x5cb2(%RIP),%XMM2;
0x148e;:0;VMOVSD	0x5cba(%RIP),%XMM3;
0x1496;:0;VMULSD	%XMM2,%XMM4,%XMM6;
0x149a;:0;VMOVSD	0x425e(%RIP),%XMM8;
0x14a2;:0;VMOVSD	0x426e(%RIP),%XMM10;
0x14aa;:0;MOV	-0x8f8(%RBP),%R8D;
0x14b1;:0;VADDSD	%XMM6,%XMM6,%XMM7;
0x14b5;:0;VDIVSD	%XMM3,%XMM7,%XMM5;
0x14b9;:0;VMOVSD	%XMM5,%XMM5,%XMM9;
0x14bd;:0;VFMADD132SD	0x424a(%RIP),%XMM8,%XMM9;
0x14c6;:0;VDIVSD	%XMM9,%XMM10,%XMM6;
0x14cb;:0;VUNPCKLPD	%XMM6,%XMM5,%XMM11;
0x14cf;:0;VMOVUPD	%XMM11,0x5c81(%RIP);
0x14d7;:0;TEST	%R8D,%R8D;
0x14da;:0;JE	24a0 <main+0x12c0>;
0x14e0;:0;MOV	0x5c41(%RIP),%R9D;
0x14e7;:0;MOV	0x5c37(%RIP),%ESI;
0x14ed;:0;MOV	-0x8fc(%RBP),%R11D;
0x14f4;:0;MOV	%ESI,-0x918(%RBP);
0x14fa;:0;MOV	%R9D,%EDX;
0x14fd;:0;TEST	%R9D,%R9D;
0x1500;:0;JE	26a9 <main+0x14c9>;
0x1506;:0;MOV	%R11D,%EAX;
0x1509;:0;MOVSXD	%EDX,%RSI;(5) 
0x150c;:0;MOV	%EDX,%R12D;(5) 
0x150f;:0;CLTD;(5) 
0x1510;:0;IDIV	%R12D;(5) 
0x1513;:0;MOV	%ESI,%EAX;(5) 
0x1515;:0;TEST	%EDX,%EDX;(5) 
0x1517;:0;JNE	1509 <main+0x329>;(5) 
0x1519;:0;MOV	%R11D,%EAX;
0x151c;:0;CLTD;
0x151d;:0;IDIV	%ESI;
0x151f;:0;MOV	%EAX,%R14D;
0x1522;:0;IMUL	%ESI,%R14D;
0x1526;:0;MOV	%EAX,%EDI;
0x1528;:0;CMP	%R14D,%R11D;
0x152b;:0;JNE	27d3 <main+0x15f3>;
0x1531;:0;VMOVD	%ESI,%XMM13;
0x1535;:0;MOV	%EAX,-0x928(%RBP);
0x153b;:0;VPINSRD	$0x1,%EAX,%XMM13,%XMM12;
0x1541;:0;XOR	%EDX,%EDX;
0x1543;:0;MOV	%R9D,%EAX;
0x1546;:0;DIV	%EDI;
0x1548;:0;TEST	%EDX,%EDX;
0x154a;:0;JNE	247c <main+0x129c>;
0x1550;:0;MOV	%R8D,%EAX;
0x1553;:0;CLTD;
0x1554;:0;IDIV	%ESI;
0x1556;:0;MOV	-0x928(%RBP),%EBX;
0x155c;:0;VMOVQ	%XMM12,-0x430(%RBP);
0x1564;:0;MOV	%EAX,%R8D;
0x1567;:0;MOV	-0x918(%RBP),%EAX;
0x156d;:0;MOV	%EDX,%ECX;
0x156f;:0;XOR	%EDX,%EDX;
0x1571;:0;DIV	%ESI;
0x1573;:0;XOR	%EDX,%EDX;
0x1575;:0;LEA	-0x1(%RCX),%R11D;
0x1579;:0;LEA	0x2(%RAX),%R10D;
0x157d;:0;MOV	%EAX,-0x908(%RBP);
0x1583;:0;MOV	%R9D,%EAX;
0x1586;:0;DIV	%EBX;
0x1588;:0;MOV	%R10D,-0x958(%RBP);
0x158f;:0;XOR	%EDX,%EDX;
0x1591;:0;IMUL	%R8D,%R9D;
0x1595;:0;VMOVD	%R10D,%XMM14;
0x159a;:0;MOV	%R11D,%R10D;
0x159d;:0;SHR	$0x1f,%R10D;
0x15a1;:0;LEA	0x2(%RAX),%R12D;
0x15a5;:0;MOV	-0x918(%RBP),%EAX;
0x15ab;:0;VPINSRD	$0x1,%R12D,%XMM14,%XMM15;
0x15b1;:0;IMUL	%ECX,%EAX;
0x15b4;:0;DIV	%ESI;
0x15b6;:0;XOR	%EDX,%EDX;
0x15b8;:0;MOV	%EAX,-0x968(%RBP);
0x15be;:0;MOV	%R9D,%EAX;
0x15c1;:0;DIV	%EBX;
0x15c3;:0;VMOVD	-0x968(%RBP),%XMM5;
0x15cb;:0;LEA	0x1(%RCX),%EBX;
0x15ce;:0;CMP	%ESI,%R11D;
0x15d1;:0;MOV	%EBX,%R14D;
0x15d4;:0;SETGE	%R9B;
0x15d8;:0;SHR	$0x1f,%R14D;
0x15dc;:0;CMP	%EBX,%ESI;
0x15de;:0;SETLE	%R13B;
0x15e2;:0;OR	%R14D,%R13D;
0x15e5;:0;VPINSRD	$0x1,%EAX,%XMM5,%XMM0;
0x15eb;:0;VPUNPCKLQDQ	%XMM15,%XMM0,%XMM1;
0x15f0;:0;MOV	%EAX,-0x974(%RBP);
0x15f6;:0;VMOVDQA	%XMM1,-0x440(%RBP);
0x15fe;:0;OR	%R9B,%R10B;
0x1601;:0;JNE	28b3 <main+0x16d3>;
0x1607;:0;TEST	%R8D,%R8D;
0x160a;:0;JS	298b <main+0x17ab>;
0x1610;:0;CMP	%EDI,%R8D;
0x1613;:0;JGE	298b <main+0x17ab>;
0x1619;:0;MOV	%R8D,%R14D;
0x161c;:0;IMUL	%ESI,%R14D;
0x1620;:0;ADD	%R11D,%R14D;
0x1623;:0;MOV	%R14D,-0x424(%RBP);
0x162a;:0;TEST	%R13B,%R13B;
0x162d;:0;JNE	2999 <main+0x17b9>;
0x1633;:0;MOV	%R8D,%R15D;(0) 
0x1636;:0;IMUL	%ESI,%R15D;(0) 
0x163a;:0;LEA	-0x1(%R8),%EDX;(0) 
0x163e;:0;LEA	0x1(%R8),%EAX;(0) 
0x1642;:0;ADD	%EBX,%R15D;(0) 
0x1645;:0;TEST	%ECX,%ECX;(0) 
0x1647;:0;JS	29dc <main+0x17fc>;(0) 
0x164d;:0;CMP	%ESI,%ECX;(0) 
0x164f;:0;JGE	29dc <main+0x17fc>;(0) 
0x1655;:0;TEST	%EDX,%EDX;(0) 
0x1657;:0;JS	27a5 <main+0x15c5>;(0) 
0x165d;:0;CMP	%EDX,%EDI;(0) 
0x165f;:0;JLE	27a5 <main+0x15c5>;(0) 
0x1665;:0;MOV	%ESI,%R8D;(0) 
0x1668;:0;IMUL	%EDX,%R8D;(0) 
0x166c;:0;LEA	(%R8,%RCX,1),%R9D;(0) 
0x1670;:0;MOV	%R9D,-0x920(%RBP);(0) 
0x1677;:0;TEST	%EAX,%EAX;(0) 
0x1679;:0;JS	286a <main+0x168a>;(0) 
0x167f;:0;CMP	%EDI,%EAX;(0) 
0x1681;:0;JGE	286a <main+0x168a>;(0) 
0x1687;:0;MOV	%EAX,%R9D;(0) 
0x168a;:0;IMUL	%ESI,%R9D;(0) 
0x168e;:0;ADD	%ECX,%R9D;(0) 
0x1691;:0;VMOVD	-0x920(%RBP),%XMM4;(0) 
0x1699;:0;MOV	%R15D,-0x428(%RBP);(0) 
0x16a0;:0;VPINSRD	$0x1,%R9D,%XMM4,%XMM2;(0) 
0x16a6;:0;VMOVQ	%XMM2,-0x420(%RBP);(0) 
0x16ae;:0;TEST	%R10B,%R10B;(0) 
0x16b1;:0;JNE	2842 <main+0x1662>;(0) 
0x16b7;:0;TEST	%EDX,%EDX;(0) 
0x16b9;:0;JS	2892 <main+0x16b2>;(0) 
0x16bf;:0;CMP	%EDX,%EDI;(0) 
0x16c1;:0;JLE	2892 <main+0x16b2>;(0) 
0x16c7;:0;MOV	%ESI,%ECX;(0) 
0x16c9;:0;IMUL	%EDX,%ECX;(0) 
0x16cc;:0;LEA	(%RCX,%R11,1),%R8D;(0) 
0x16d0;:0;MOV	%R8D,-0x418(%RBP);(0) 
0x16d7;:0;TEST	%R13B,%R13B;(0) 
0x16da;:0;JNE	2772 <main+0x1592>;(0) 
0x16e0;:0;CMP	%EDX,%EDI;(0) 
0x16e2;:0;JLE	274f <main+0x156f>;(0) 
0x16e8;:0;TEST	%EDX,%EDX;(0) 
0x16ea;:0;JS	274f <main+0x156f>;(0) 
0x16f0;:0;IMUL	%ESI,%EDX;(0) 
0x16f3;:0;LEA	(%RDX,%RBX,1),%R13D;(0) 
0x16f7;:0;MOV	%R13D,-0x414(%RBP);(0) 
0x16fe;:0;TEST	%R10B,%R10B;(0) 
0x1701;:0;JNE	2734 <main+0x1554>;(0) 
0x1707;:0;TEST	%EAX,%EAX;(0) 
0x1709;:0;JS	270c <main+0x152c>;(0) 
0x170f;:0;CMP	%EAX,%EDI;(0) 
0x1711;:0;JLE	270c <main+0x152c>;(0) 
0x1717;:0;MOV	%ESI,%EDX;(0) 
0x1719;:0;IMUL	%EAX,%EDX;(0) 
0x171c;:0;ADD	%EDX,%R11D;(0) 
0x171f;:0;MOV	%R11D,-0x410(%RBP);(0) 
0x1726;:0;IMUL	%ESI,%EAX;(0) 
0x1729;:0;ADD	%EAX,%EBX;(0) 
0x172b;:0;MOV	%EBX,-0x40c(%RBP);(0) 
0x1731;:0;XOR	%EAX,%EAX;(0) 
0x1733;:0;CMP	$0x1,%EDI;(0) 
0x1736;:0;JG	23f3 <main+0x1213>;(0) 
0x173c;:0;LEA	-0x860(%RBP),%RSI;(0) 
0x1743;:0;MOV	$0x44000000,%EDI;(0) 
0x1748;:0;MOV	%R11D,-0x980(%RBP);(0) 
0x174f;:0;MOV	%R9D,-0x97c(%RBP);(0) 
0x1756;:0;MOV	%R8D,-0x978(%RBP);(0) 
0x175d;:0;MOV	%RSI,-0x918(%RBP);(0) 
0x1764;:0;MOV	%RAX,-0x388(%RBP);(0) 
0x176b;:0;CALL	1150 <MPI_Comm_rank@plt>;(0) 
0x1770;:0;PUSH	%R12;(0) 
0x1772;:0;MOV	-0x958(%RBP),%ECX;(0) 
0x1778;:0;MOV	-0x974(%RBP),%R8D;(0) 
0x177f;:0;PUSH	%RCX;(0) 
0x1780;:0;MOV	-0x968(%RBP),%R10D;(0) 
0x1787;:0;MOV	-0x978(%RBP),%R11D;(0) 
0x178e;:0;PUSH	%R8;(0) 
0x1790;:0;MOV	-0x97c(%RBP),%R9D;(0) 
0x1797;:0;MOV	-0x920(%RBP),%R8D;(0) 
0x179e;:0;PUSH	%R10;(0) 
0x17a0;:0;MOV	-0x860(%RBP),%ESI;(0) 
0x17a6;:0;MOV	%R15D,%ECX;(0) 
0x17a9;:0;PUSH	%RBX;(0) 
0x17aa;:0;MOV	-0x980(%RBP),%EBX;(0) 
0x17b0;:0;MOV	%R14D,%EDX;(0) 
0x17b3;:0;PUSH	%RBX;(0) 
0x17b4;:0;LEA	0x3c05(%RIP),%RDI;(0) 
0x17bb;:0;XOR	%EAX,%EAX;(0) 
0x17bd;:0;PUSH	%R13;(0) 
0x17bf;:0;PUSH	%R11;(0) 
0x17c1;:0;CALL	1030 <printf@plt>;(0) 
0x17c6;:0;MOV	-0x958(%RBP),%R15D;(0) 
0x17cd;:0;MOV	-0x960(%RBP),%RDI;(0) 
0x17d4;:0;ADD	$0x40,%RSP;(0) 
0x17d8;:0;MOV	%R12D,%EDX;(0) 
0x17db;:0;MOV	%R15D,%ESI;(0) 
0x17de;:0;CALL	3ea0 <Mesh_init>;(0) 
0x17e3;:0;MOV	-0x970(%RBP),%RDI;(0) 
0x17ea;:0;MOV	%R12D,%EDX;(0) 
0x17ed;:0;MOV	%R15D,%ESI;(0) 
0x17f0;:0;CALL	3ea0 <Mesh_init>;(0) 
0x17f5;:0;LEA	-0x890(%RBP),%RDI;(0) 
0x17fc;:0;MOV	%R12D,%EDX;(0) 
0x17ff;:0;MOV	%R15D,%ESI;(0) 
0x1802;:0;MOV	%RDI,-0x968(%RBP);(0) 
0x1809;:0;CALL	3ea0 <Mesh_init>;(0) 
0x180e;:0;MOV	-0x908(%RBP),%EDI;(0) 
0x1814;:0;MOV	%R15D,-0x898(%RBP);(0) 
0x181b;:0;ADD	$0x4,%EDI;(0) 
0x181e;:0;IMUL	%R12D,%EDI;(0) 
0x1822;:0;MOV	%R12D,-0x894(%RBP);(0) 
0x1829;:0;SAL	$0x2,%RDI;(0) 
0x182d;:0;CALL	1140 <malloc@plt>;(0) 
0x1832;:0;MOV	%RAX,-0x8a0(%RBP);(0) 
0x1839;:0;TEST	%RAX,%RAX;(0) 
0x183c;:0;JE	27f2 <main+0x1612>;(0) 
0x1842;:0;MOV	-0x8f8(%RBP),%R12D;(0) 
0x1849;:0;TEST	%R12D,%R12D;(0) 
0x184c;:0;JE	237c <main+0x119c>;(0) 
0x1852;:0;MOV	-0x960(%RBP),%RBX;(0) 
0x1859;:0;LEA	-0x440(%RBP),%R15;(0) 
0x1860;:0;LEA	-0x8a0(%RBP),%R12;(0) 
0x1867;:0;MOV	%R15,%RDX;(0) 
0x186a;:0;MOV	%R12,%RSI;(0) 
0x186d;:0;MOV	%RBX,%RDI;(0) 
0x1870;:0;CALL	2b80 <setup_init_state>;(0) 
0x1875;:0;MOV	-0x970(%RBP),%RDI;(0) 
0x187c;:0;MOV	%R15,%RDX;(0) 
0x187f;:0;MOV	%R12,%RSI;(0) 
0x1882;:0;CALL	2b80 <setup_init_state>;(0) 
0x1887;:0;CMPQ	$0,0x58d9(%RIP);(0) 
0x188f;:0;JE	18a7 <main+0x6c7>;(0) 
0x1891;:0;MOV	-0x968(%RBP),%RDX;(0) 
0x1898;:0;MOV	-0x930(%RBP),%RDI;(0) 
0x189f;:0;MOV	%RBX,%RSI;(0) 
0x18a2;:0;CALL	4110 <save_frame_all_domain>;(0) 
0x18a7;:0;MOV	0x5873(%RIP),%EDI;(0) 
0x18ad;:0;MOV	%RDI,%R13;(0) 
0x18b0;:0;SAL	$0x3,%RDI;(0) 
0x18b4;:0;CALL	1140 <malloc@plt>;(0) 
0x18b9;:0;LEA	-0x8b0(%RBP),%RSI;(0) 
0x18c0;:0;MOV	$0x4,%EDI;(0) 
0x18c5;:0;MOV	%RAX,-0x928(%RBP);(0) 
0x18cc;:0;CALL	10c0 <clock_gettime@plt>;(0) 
0x18d1;:0;LEA	-0x8c0(%RBP),%R9;(0) 
0x18d8;:0;MOVQ	$0x1,-0x920(%RBP);(0) 
0x18e3;:0;MOV	%R9,-0x958(%RBP);(0) 
0x18ea;:0;CMP	$0x1,%R13D;(0) 
0x18ee;:0;JBE	268d <main+0x14ad>;(0) 
0x18f4;:0;MOV	-0x958(%RBP),%RSI;  (2) 
0x18fb;:0;MOV	$0x4,%EDI;  (2) 
0x1900;:0;CALL	10c0 <clock_gettime@plt>;  (2) 
0x1905;:0;MOV	-0x868(%RBP),%R13D;  (2) 
0x190c;:0;MOV	0x3ded(%RIP),%RDI;  (2) 
0x1913;:0;LEA	-0x1(%R13),%R11D;  (2) 
0x1917;:0;CMP	$0x1,%R11;  (2) 
0x191b;:0;VMOVQ	%RDI,%XMM7;  (2) 
0x1920;:0;JBE	1b79 <main+0x999>;  (2) 
0x1926;:0;MOV	-0x864(%RBP),%EAX;  (2) 
0x192c;:0;LEA	-0x1(%RAX),%EDI;  (2) 
0x192f;:0;CMP	$0x1,%RDI;  (2) 
0x1933;:0;JBE	1b79 <main+0x999>;  (2) 
0x1939;:0;LEA	(%RAX,%RAX,8),%EBX;  (2) 
0x193c;:0;VXORPD	%XMM6,%XMM6,%XMM6;  (2) 
0x1940;:0;DEC	%RAX;  (2) 
0x1943;:0;VCVTUSI2SD	%RAX,%XMM6,%XMM3;  (2) 
0x1949;:0;VMOVSD	0x3d1f(%RIP),%XMM9;  (2) 
0x1951;:0;MOV	-0x8a0(%RBP),%RSI;  (2) 
0x1958;:0;MOV	-0x894(%RBP),%R12D;  (2) 
0x195f;:0;VMULSD	%XMM3,%XMM3,%XMM8;  (2) 
0x1963;:0;VMOVSD	0x3d55(%RIP),%XMM5;  (2) 
0x196b;:0;LEA	0x9(%RBX),%R10D;  (2) 
0x196f;:0;MOV	$0x1,%R9D;  (2) 
0x1975;:0;VDIVSD	%XMM8,%XMM9,%XMM4;  (2) 
0x197a;:0;NOPW	(%RAX,%RAX,1);  (2) 
0x1980;:0;MOV	%R12D,%R8D;    (3) 
0x1983;:0;IMUL	%R9D,%R8D;    (3) 
0x1987;:0;MOV	%R10D,%EDX;    (3) 
0x198a;:0;MOV	$0x1,%EAX;    (3) 
0x198f;:0;TEST	$0x1,%DIL;    (3) 
0x1993;:0;JNE	1a15 <main+0x835>;    (3) 
0x1999;:0;LEA	0x1(%R8),%EDX;    (3) 
0x199d;:0;MOV	(%RSI,%RDX,4),%ECX;    (3) 
0x19a0;:0;CMP	$0x2,%ECX;    (3) 
0x19a3;:0;JE	228f <main+0x10af>;    (3) 
0x19a9;:0;CMP	$0x3,%ECX;    (3) 
0x19ac;:0;JE	2239 <main+0x1059>;    (3) 
0x19b2;:0;CMP	$0x1,%ECX;    (3) 
0x19b5;:0;JE	220d <main+0x102d>;    (3) 
0x19bb;:0;MOV	$0x2,%EAX;    (3) 
0x19c0;:0;LEA	0x9(%R10),%EDX;    (3) 
0x19c4;:0;CMP	%RDI,%RAX;    (3) 
0x19c7;:0;JNE	1a15 <main+0x835>;    (3) 
0x19c9;:0;JMP	1b67 <main+0x987>;    (3) 
0x19ce;:0;XCHG	%AX,%AX;
0x19d0;:0;CMP	$0x1,%R15D;      (4) 
0x19d4;:0;JE	21e0 <main+0x1000>;      (4) 
0x19da;:0;INC	%RAX;      (4) 
0x19dd;:0;LEA	(%R8,%RAX,1),%ECX;      (4) 
0x19e1;:0;MOV	(%RSI,%RCX,4),%R14D;      (4) 
0x19e5;:0;ADD	$0x9,%EDX;      (4) 
0x19e8;:0;CMP	$0x2,%R14D;      (4) 
0x19ec;:0;JE	2130 <main+0xf50>;      (4) 
0x19f2;:0;CMP	$0x3,%R14D;      (4) 
0x19f6;:0;JE	20d8 <main+0xef8>;      (4) 
0x19fc;:0;CMP	$0x1,%R14D;      (4) 
0x1a00;:0;JE	1b30 <main+0x950>;      (4) 
0x1a06;:0;INC	%RAX;      (4) 
0x1a09;:0;ADD	$0x9,%EDX;      (4) 
0x1a0c;:0;CMP	%RDI,%RAX;      (4) 
0x1a0f;:0;JE	1b67 <main+0x987>;      (4) 
0x1a15;:0;LEA	(%R8,%RAX,1),%R14D;      (4) 
0x1a19;:0;MOV	(%RSI,%R14,4),%R15D;      (4) 
0x1a1d;:0;CMP	$0x2,%R15D;      (4) 
0x1a21;:0;JE	1a80 <main+0x8a0>;      (4) 
0x1a23;:0;CMP	$0x3,%R15D;      (4) 
0x1a27;:0;JNE	19d0 <main+0x7f0>;      (4) 
0x1a29;:0;MOV	-0x870(%RBP),%RCX;      (4) 
0x1a30;:0;MOV	%EDX,%R15D;      (4) 
0x1a33;:0;LEA	(%RCX,%R15,8),%R14;      (4) 
0x1a37;:0;VMOVSD	0x20(%R14),%XMM9;      (4) 
0x1a3d;:0;VMOVUPD	0x38(%R14),%XMM10;      (4) 
0x1a43;:0;VSUBSD	0x10(%R14),%XMM9,%XMM2;      (4) 
0x1a49;:0;VSHUFPD	$0x1,0x28(%R14),%XMM10,%XMM15;      (4) 
0x1a50;:0;VMOVSD	0x8(%R14),%XMM1;      (4) 
0x1a56;:0;VMULSD	%XMM7,%XMM2,%XMM11;      (4) 
0x1a5a;:0;VMOVSD	%XMM1,0x18(%R14);      (4) 
0x1a60;:0;VMOVDDUP	%XMM11,%XMM0;      (4) 
0x1a65;:0;VADDPD	%XMM15,%XMM0,%XMM8;      (4) 
0x1a6a;:0;VSUBPD	%XMM0,%XMM15,%XMM6;      (4) 
0x1a6e;:0;VMOVSD	%XMM8,%XMM6,%XMM12;      (4) 
0x1a73;:0;VMOVUPD	%XMM12,0x30(%R14);      (4) 
0x1a79;:0;JMP	19da <main+0x7fa>;      (4) 
0x1a7e;:0;XCHG	%AX,%AX;
0x1a80;:0;MOV	-0x870(%RBP),%R14;      (4) 
0x1a87;:0;MOV	%EDX,%ECX;      (4) 
0x1a89;:0;LEA	(%R14,%RCX,8),%R15;      (4) 
0x1a8d;:0;MOV	-0x43c(%RBP),%ECX;      (4) 
0x1a93;:0;VXORPD	%XMM0,%XMM0,%XMM0;      (4) 
0x1a97;:0;LEA	-0x1(%RAX,%RCX,1),%R14;      (4) 
0x1a9c;:0;VCVTSI2SD	%R14,%XMM0,%XMM9;      (4) 
0x1aa1;:0;VMOVSD	0x18(%R15),%XMM10;      (4) 
0x1aa7;:0;VMOVSD	0x30(%R15),%XMM15;      (4) 
0x1aad;:0;VMOVSD	0x20(%R15),%XMM1;      (4) 
0x1ab3;:0;VADDSD	%XMM15,%XMM10,%XMM2;      (4) 
0x1ab8;:0;VMULSD	%XMM4,%XMM9,%XMM6;      (4) 
0x1abc;:0;VSUBSD	%XMM9,%XMM3,%XMM8;      (4) 
0x1ac1;:0;VMOVSD	0x38(%R15),%XMM9;      (4) 
0x1ac7;:0;VMOVSD	0x10(%R15),%XMM14;      (4) 
0x1acd;:0;VADDSD	%XMM9,%XMM2,%XMM11;      (4) 
0x1ad2;:0;VMULSD	%XMM6,%XMM8,%XMM13;      (4) 
0x1ad6;:0;VADDSD	(%R15),%XMM14,%XMM12;      (4) 
0x1adb;:0;VFMADD132SD	0x3bd4(%RIP),%XMM1,%XMM11;      (4) 
0x1ae4;:0;VMOVSD	0x3c2c(%RIP),%XMM8;      (4) 
0x1aec;:0;VSUBSD	%XMM14,%XMM1,%XMM14;      (4) 
0x1af1;:0;VSUBSD	%XMM13,%XMM8,%XMM6;      (4) 
0x1af6;:0;VMULSD	%XMM5,%XMM13,%XMM13;      (4) 
0x1afa;:0;VADDSD	%XMM12,%XMM11,%XMM0;      (4) 
0x1aff;:0;VFMADD231SD	%XMM7,%XMM14,%XMM9;      (4) 
0x1b04;:0;VFNMADD132SD	%XMM7,%XMM15,%XMM14;      (4) 
0x1b09;:0;VDIVSD	%XMM6,%XMM0,%XMM12;      (4) 
0x1b0d;:0;VMOVSD	%XMM10,0x8(%R15);      (4) 
0x1b13;:0;VFMADD231SD	%XMM13,%XMM12,%XMM9;      (4) 
0x1b18;:0;VFMADD132SD	%XMM13,%XMM14,%XMM12;      (4) 
0x1b1d;:0;VMOVSD	%XMM9,0x28(%R15);      (4) 
0x1b23;:0;VMOVSD	%XMM12,0x40(%R15);      (4) 
0x1b29;:0;JMP	19da <main+0x7fa>;      (4) 
0x1b2e;:0;XCHG	%AX,%AX;
0x1b30;:0;MOV	-0x870(%RBP),%R14;      (4) 
0x1b37;:0;MOV	%EDX,%ECX;      (4) 
0x1b39;:0;LEA	(%R14,%RCX,8),%R15;      (4) 
0x1b3d;:0;VPERMPD	$0x4e,0x8(%R14,%RCX,8),%YMM12;      (4) 
0x1b45;:0;VPERMPD	$0x4e,0x28(%R15),%YMM0;      (4) 
0x1b4c;:0;INC	%RAX;      (4) 
0x1b4f;:0;VMOVUPD	%YMM12,0x8(%R15);      (4) 
0x1b55;:0;VMOVUPD	%YMM0,0x28(%R15);      (4) 
0x1b5b;:0;ADD	$0x9,%EDX;      (4) 
0x1b5e;:0;CMP	%RDI,%RAX;      (4) 
0x1b61;:0;JNE	1a15 <main+0x835>;      (4) 
0x1b67;:0;INC	%R9;    (3) 
0x1b6a;:0;ADD	%EBX,%R10D;    (3) 
0x1b6d;:0;CMP	%R11,%R9;    (3) 
0x1b70;:0;JNE	1980 <main+0x7a0>;    (3) 
0x1b76;:0;VZEROUPPER;  (2) 
0x1b79;:0;CMP	%R13D,-0x878(%RBP);  (2) 
0x1b80;:0;JNE	27b4 <main+0x15d4>;  (2) 
0x1b86;:0;MOV	-0x874(%RBP),%R8D;  (2) 
0x1b8d;:0;CMP	%R8D,-0x864(%RBP);  (2) 
0x1b94;:0;JNE	26ed <main+0x150d>;  (2) 
0x1b9a;:0;VMOVDQA	-0x950(%RBP),%XMM14;  (2) 
0x1ba2;:0;MOV	-0x918(%RBP),%RSI;  (2) 
0x1ba9;:0;XOR	%ECX,%ECX;  (2) 
0x1bab;:0;XOR	%EDX,%EDX;  (2) 
0x1bad;:0;LEA	0x1eac(%RIP),%RDI;  (2) 
0x1bb4;:0;LEA	-0x8d8(%RBP),%R15;  (2) 
0x1bbb;:0;VMOVDQA	%XMM14,-0x860(%RBP);  (2) 
0x1bc3;:0;CALL	1170 <GOMP_parallel@plt>;  (2) 
0x1bc8;:0;MOV	%R15,%RSI;  (2) 
0x1bcb;:0;MOV	$0x44000000,%EDI;  (2) 
0x1bd0;:0;CALL	1150 <MPI_Comm_rank@plt>;  (2) 
0x1bd5;:0;MOV	-0x438(%RBP),%EBX;  (2) 
0x1bdb;:0;MOV	-0x428(%RBP),%R12D;  (2) 
0x1be2;:0;LEA	-0x2(%RBX),%EAX;  (2) 
0x1be5;:0;CMP	$-0x1,%R12D;  (2) 
0x1be9;:0;JE	1c1d <main+0xa3d>;  (2) 
0x1beb;:0;MOV	-0x874(%RBP),%EDX;  (2) 
0x1bf1;:0;MOV	-0x880(%RBP),%R14;  (2) 
0x1bf8;:0;IMUL	%EDX,%EAX;  (2) 
0x1bfb;:0;LEA	-0x12(%RDX,%RDX,8),%ESI;  (2) 
0x1bff;:0;MOV	$0x44000000,%R9D;  (2) 
0x1c05;:0;LEA	0x9(%RAX,%RAX,8),%ECX;  (2) 
0x1c09;:0;LEA	(%R14,%RCX,8),%RDI;  (2) 
0x1c0d;:0;XOR	%R8D,%R8D;  (2) 
0x1c10;:0;MOV	%R12D,%ECX;  (2) 
0x1c13;:0;MOV	$0x4c00080b,%EDX;  (2) 
0x1c18;:0;CALL	1050 <MPI_Send@plt>;  (2) 
0x1c1d;:0;MOV	-0x424(%RBP),%R13D;  (2) 
0x1c24;:0;CMP	$-0x1,%R13D;  (2) 
0x1c28;:0;JE	1c97 <main+0xab7>;  (2) 
0x1c2a;:0;SUB	$0x8,%RSP;  (2) 
0x1c2e;:0;PUSHQ	-0x918(%RBP);  (2) 
0x1c34;:0;MOV	-0x874(%RBP),%ESI;  (2) 
0x1c3a;:0;MOV	-0x880(%RBP),%RDI;  (2) 
0x1c41;:0;LEA	-0x12(%RSI,%RSI,8),%ESI;  (2) 
0x1c45;:0;LEA	0x48(%RDI),%RDI;  (2) 
0x1c49;:0;MOV	$0x44000000,%R9D;  (2) 
0x1c4f;:0;XOR	%R8D,%R8D;  (2) 
0x1c52;:0;MOV	%R13D,%ECX;  (2) 
0x1c55;:0;MOV	$0x4c00080b,%EDX;  (2) 
0x1c5a;:0;CALL	10a0 <MPI_Recv@plt>;  (2) 
0x1c5f;:0;MOV	-0x874(%RBP),%R9D;  (2) 
0x1c66;:0;MOV	-0x880(%RBP),%R8;  (2) 
0x1c6d;:0;LEA	(%R9,%R9,8),%R10D;  (2) 
0x1c71;:0;LEA	0x9(%R10),%R11D;  (2) 
0x1c75;:0;LEA	(%R8,%R11,8),%RDI;  (2) 
0x1c79;:0;MOV	$0x44000000,%R9D;  (2) 
0x1c7f;:0;XOR	%R8D,%R8D;  (2) 
0x1c82;:0;LEA	-0x12(%R10),%ESI;  (2) 
0x1c86;:0;MOV	%R13D,%ECX;  (2) 
0x1c89;:0;MOV	$0x4c00080b,%EDX;  (2) 
0x1c8e;:0;CALL	1050 <MPI_Send@plt>;  (2) 
0x1c93;:0;POP	%R8;  (2) 
0x1c95;:0;POP	%R9;  (2) 
0x1c97;:0;DEC	%EBX;  (2) 
0x1c99;:0;CMP	$-0x1,%R12D;  (2) 
0x1c9d;:0;JE	1cdd <main+0xafd>;  (2) 
0x1c9f;:0;MOV	-0x874(%RBP),%EAX;  (2) 
0x1ca5;:0;SUB	$0x8,%RSP;  (2) 
0x1ca9;:0;IMUL	%EAX,%EBX;  (2) 
0x1cac;:0;PUSHQ	-0x918(%RBP);  (2) 
0x1cb2;:0;MOV	-0x880(%RBP),%RDX;  (2) 
0x1cb9;:0;LEA	0x9(%RBX,%RBX,8),%EBX;  (2) 
0x1cbd;:0;LEA	(%RDX,%RBX,8),%RDI;  (2) 
0x1cc1;:0;LEA	-0x12(%RAX,%RAX,8),%ESI;  (2) 
0x1cc5;:0;MOV	$0x44000000,%R9D;  (2) 
0x1ccb;:0;XOR	%R8D,%R8D;  (2) 
0x1cce;:0;MOV	%R12D,%ECX;  (2) 
0x1cd1;:0;MOV	$0x4c00080b,%EDX;  (2) 
0x1cd6;:0;CALL	10a0 <MPI_Recv@plt>;  (2) 
0x1cdb;:0;POP	%RSI;  (2) 
0x1cdc;:0;POP	%RDI;  (2) 
0x1cdd;:0;VMOVDQA	-0x940(%RBP),%XMM1;  (2) 
0x1ce5;:0;MOV	-0x918(%RBP),%RSI;  (2) 
0x1cec;:0;XOR	%EDX,%EDX;  (2) 
0x1cee;:0;XOR	%ECX,%ECX;  (2) 
0x1cf0;:0;LEA	0x17b9(%RIP),%RDI;  (2) 
0x1cf7;:0;VMOVDQA	%XMM1,-0x860(%RBP);  (2) 
0x1cff;:0;CALL	1170 <GOMP_parallel@plt>;  (2) 
0x1d04;:0;MOV	-0x920(%RBP),%RAX;  (2) 
0x1d0b;:0;MOV	0x545e(%RIP),%R12D;  (2) 
0x1d12;:0;CQTO;  (2) 
0x1d14;:0;IDIV	%R12;  (2) 
0x1d17;:0;TEST	%RDX,%RDX;  (2) 
0x1d1a;:0;JNE	1d40 <main+0xb60>;  (2) 
0x1d1c;:0;CMPQ	$0,0x5444(%RIP);  (2) 
0x1d24;:0;JE	1d40 <main+0xb60>;  (2) 
0x1d26;:0;MOV	-0x968(%RBP),%RDX;  (2) 
0x1d2d;:0;MOV	-0x960(%RBP),%RSI;  (2) 
0x1d34;:0;MOV	-0x930(%RBP),%RDI;  (2) 
0x1d3b;:0;CALL	4110 <save_frame_all_domain>;  (2) 
0x1d40;:0;MOV	$0x4,%EDI;  (2) 
0x1d45;:0;LEA	-0x8d0(%RBP),%RSI;  (2) 
0x1d4c;:0;CALL	10c0 <clock_gettime@plt>;  (2) 
0x1d51;:0;MOV	-0x8c8(%RBP),%RCX;  (2) 
0x1d58;:0;MOV	-0x8d0(%RBP),%R14;  (2) 
0x1d5f;:0;VXORPD	%XMM8,%XMM8,%XMM8;  (2) 
0x1d64;:0;SUB	-0x8b8(%RBP),%RCX;  (2) 
0x1d6b;:0;SUB	-0x8c0(%RBP),%R14;  (2) 
0x1d72;:0;VCVTSI2SD	%RCX,%XMM8,%XMM6;  (2) 
0x1d77;:0;VCVTSI2SD	%R14,%XMM8,%XMM13;  (2) 
0x1d7c;:0;VMOVSD	0x392c(%RIP),%XMM2;  (2) 
0x1d84;:0;MOV	-0x920(%RBP),%RBX;  (2) 
0x1d8b;:0;MOV	-0x928(%RBP),%R13;  (2) 
0x1d92;:0;VFMADD132SD	%XMM2,%XMM13,%XMM6;  (2) 
0x1d97;:0;MOV	0x5383(%RIP),%EDI;  (2) 
0x1d9d;:0;VMOVSD	%XMM6,(%R13,%RBX,8);  (2) 
0x1da4;:0;INC	%RBX;  (2) 
0x1da7;:0;MOV	%RBX,-0x920(%RBP);  (2) 
0x1dae;:0;CMP	%RBX,%RDI;  (2) 
0x1db1;:0;JG	18f4 <main+0x714>;  (2) 
0x1db7;:0;MOV	-0x918(%RBP),%RSI;(0) 
0x1dbe;:0;MOV	$0x4,%EDI;(0) 
0x1dc3;:0;VMOVSD	%XMM2,-0x920(%RBP);(0) 
0x1dcb;:0;CALL	10c0 <clock_gettime@plt>;(0) 
0x1dd0;:0;MOV	-0x858(%RBP),%R9;(0) 
0x1dd7;:0;MOV	-0x860(%RBP),%R10;(0) 
0x1dde;:0;VXORPD	%XMM10,%XMM10,%XMM10;(0) 
0x1de3;:0;SUB	-0x8a8(%RBP),%R9;(0) 
0x1dea;:0;SUB	-0x8b0(%RBP),%R10;(0) 
0x1df1;:0;VCVTSI2SD	%R9,%XMM10,%XMM15;(0) 
0x1df6;:0;VCVTSI2SD	%R10,%XMM10,%XMM9;(0) 
0x1dfb;:0;VMOVSD	-0x920(%RBP),%XMM11;(0) 
0x1e03;:0;MOV	$0x44000000,%EDI;(0) 
0x1e08;:0;VFMADD132SD	%XMM11,%XMM9,%XMM15;(0) 
0x1e0d;:0;VMOVSD	%XMM15,-0x8d8(%RBP);(0) 
0x1e15;:0;CALL	1080 <MPI_Barrier@plt>;(0) 
0x1e1a;:0;MOV	0x52ff(%RIP),%R11D;(0) 
0x1e21;:0;MOVQ	$0,-0x8e0(%RBP);(0) 
0x1e2c;:0;MOV	%R11,%R8;(0) 
0x1e2f;:0;TEST	%R11,%R11;(0) 
0x1e32;:0;JE	26a1 <main+0x14c1>;(0) 
0x1e38;:0;LEA	-0x1(%R11),%R12;(0) 
0x1e3c;:0;CMP	$0x2,%R12;(0) 
0x1e40;:0;JBE	26d0 <main+0x14f0>;(0) 
0x1e46;:0;MOV	%R11,%RDX;(0) 
0x1e49;:0;MOV	-0x928(%RBP),%RCX;(0) 
0x1e50;:0;SHR	$0x2,%RDX;(0) 
0x1e54;:0;SAL	$0x5,%RDX;(0) 
0x1e58;:0;LEA	(%RDX,%RCX,1),%R14;(0) 
0x1e5c;:0;SUB	$0x20,%RDX;(0) 
0x1e60;:0;SHR	$0x5,%RDX;(0) 
0x1e64;:0;INC	%RDX;(0) 
0x1e67;:0;MOV	%RCX,%RAX;(0) 
0x1e6a;:0;VXORPD	%XMM12,%XMM12,%XMM12;(0) 
0x1e6f;:0;AND	$0x7,%EDX;(0) 
0x1e72;:0;JE	1edc <main+0xcfc>;(0) 
0x1e74;:0;CMP	$0x1,%RDX;(0) 
0x1e78;:0;JE	1ecf <main+0xcef>;(0) 
0x1e7a;:0;CMP	$0x2,%RDX;(0) 
0x1e7e;:0;JE	1ec7 <main+0xce7>;(0) 
0x1e80;:0;CMP	$0x3,%RDX;(0) 
0x1e84;:0;JE	1ebf <main+0xcdf>;(0) 
0x1e86;:0;CMP	$0x4,%RDX;(0) 
0x1e8a;:0;JE	1eb7 <main+0xcd7>;(0) 
0x1e8c;:0;CMP	$0x5,%RDX;(0) 
0x1e90;:0;JE	1eaf <main+0xccf>;(0) 
0x1e92;:0;CMP	$0x6,%RDX;(0) 
0x1e96;:0;JE	1ea7 <main+0xcc7>;(0) 
0x1e98;:0;MOV	-0x928(%RBP),%RAX;(0) 
0x1e9f;:0;VMOVUPD	(%RAX),%YMM12;(0) 
0x1ea3;:0;ADD	$0x20,%RAX;(0) 
0x1ea7;:0;VADDPD	(%RAX),%YMM12,%YMM12;(0) 
0x1eab;:0;ADD	$0x20,%RAX;(0) 
0x1eaf;:0;VADDPD	(%RAX),%YMM12,%YMM12;(0) 
0x1eb3;:0;ADD	$0x20,%RAX;(0) 
0x1eb7;:0;VADDPD	(%RAX),%YMM12,%YMM12;(0) 
0x1ebb;:0;ADD	$0x20,%RAX;(0) 
0x1ebf;:0;VADDPD	(%RAX),%YMM12,%YMM12;(0) 
0x1ec3;:0;ADD	$0x20,%RAX;(0) 
0x1ec7;:0;VADDPD	(%RAX),%YMM12,%YMM12;(0) 
0x1ecb;:0;ADD	$0x20,%RAX;(0) 
0x1ecf;:0;VADDPD	(%RAX),%YMM12,%YMM12;(0) 
0x1ed3;:0;ADD	$0x20,%RAX;(0) 
0x1ed7;:0;CMP	%RAX,%R14;(0) 
0x1eda;:0;JE	1f17 <main+0xd37>;(0) 
0x1edc;:0;VADDPD	(%RAX),%YMM12,%YMM0;  (1) 
0x1ee0;:0;ADD	$0x100,%RAX;  (1) 
0x1ee6;:0;VADDPD	-0xe0(%RAX),%YMM0,%YMM3;  (1) 
0x1eee;:0;VADDPD	-0xc0(%RAX),%YMM3,%YMM4;  (1) 
0x1ef6;:0;VADDPD	-0xa0(%RAX),%YMM4,%YMM5;  (1) 
0x1efe;:0;VADDPD	-0x80(%RAX),%YMM5,%YMM7;  (1) 
0x1f03;:0;VADDPD	-0x60(%RAX),%YMM7,%YMM14;  (1) 
0x1f08;:0;VADDPD	-0x40(%RAX),%YMM14,%YMM1;  (1) 
0x1f0d;:0;VADDPD	-0x20(%RAX),%YMM1,%YMM12;  (1) 
0x1f12;:0;CMP	%RAX,%R14;  (1) 
0x1f15;:0;JNE	1edc <main+0xcfc>;  (1) 
0x1f17;:0;VEXTRACTF64X2	$0x1,%YMM12,%XMM8;(0) 
0x1f1e;:0;VADDPD	%XMM12,%XMM8,%XMM6;(0) 
0x1f23;:0;MOV	%R11,%R13;(0) 
0x1f26;:0;AND	$-0x4,%R13;(0) 
0x1f2a;:0;VUNPCKHPD	%XMM6,%XMM6,%XMM13;(0) 
0x1f2e;:0;VADDPD	%XMM6,%XMM13,%XMM0;(0) 
0x1f32;:0;CMP	%R13,%R11;(0) 
0x1f35;:0;JE	2650 <main+0x1470>;(0) 
0x1f3b;:0;VZEROUPPER;(0) 
0x1f3e;:0;MOV	-0x928(%RBP),%RBX;(0) 
0x1f45;:0;LEA	0x1(%R13),%RDI;(0) 
0x1f49;:0;VADDSD	(%RBX,%R13,8),%XMM0,%XMM0;(0) 
0x1f4f;:0;LEA	(,%R13,8),%RSI;(0) 
0x1f57;:0;CMP	%RDI,%R11;(0) 
0x1f5a;:0;JBE	1f71 <main+0xd91>;(0) 
0x1f5c;:0;ADD	$0x2,%R13;(0) 
0x1f60;:0;VADDSD	0x8(%RBX,%RSI,1),%XMM0,%XMM0;(0) 
0x1f66;:0;CMP	%R13,%R11;(0) 
0x1f69;:0;JBE	1f71 <main+0xd91>;(0) 
0x1f6b;:0;VADDSD	0x10(%RBX,%RSI,1),%XMM0,%XMM0;(0) 
0x1f71;:0;VMOVSD	%XMM0,-0x8e0(%RBP);(0) 
0x1f79;:0;VXORPD	%XMM2,%XMM2,%XMM2;(0) 
0x1f7d;:0;VCVTUSI2SD	%R8D,%XMM2,%XMM1;(0) 
0x1f83;:0;VMOVSD	-0x8e0(%RBP),%XMM15;(0) 
0x1f8b;:0;PUSH	%RAX;(0) 
0x1f8c;:0;XOR	%R9D,%R9D;(0) 
0x1f8f;:0;VDIVSD	%XMM1,%XMM15,%XMM9;(0) 
0x1f93;:0;PUSH	$0x44000000;(0) 
0x1f98;:0;LEA	-0x8e8(%RBP),%RSI;(0) 
0x1f9f;:0;LEA	-0x8e0(%RBP),%RDI;(0) 
0x1fa6;:0;MOV	$0x58000003,%R8D;(0) 
0x1fac;:0;MOV	$0x4c00080b,%ECX;(0) 
0x1fb1;:0;MOV	$0x1,%EDX;(0) 
0x1fb6;:0;VMOVSD	%XMM9,-0x8e0(%RBP);(0) 
0x1fbe;:0;CALL	1130 <MPI_Reduce@plt>;(0) 
0x1fc3;:0;XOR	%R9D,%R9D;(0) 
0x1fc6;:0;MOV	$0x4c00080b,%ECX;(0) 
0x1fcb;:0;MOV	$0x1,%EDX;(0) 
0x1fd0;:0;MOV	$0x58000003,%R8D;(0) 
0x1fd6;:0;LEA	-0x8f0(%RBP),%RSI;(0) 
0x1fdd;:0;MOV	%R15,%RDI;(0) 
0x1fe0;:0;MOVL	$0x44000000,(%RSP);(0) 
0x1fe7;:0;CALL	1130 <MPI_Reduce@plt>;(0) 
0x1fec;:0;VMOVSD	0x36d4(%RIP),%XMM11;(0) 
0x1ff4;:0;MOV	-0x8f8(%RBP),%ESI;(0) 
0x1ffa;:0;VMULSD	-0x8e0(%RBP),%XMM11,%XMM0;(0) 
0x2002;:0;LEA	0x3487(%RIP),%RDI;(0) 
0x2009;:0;MOV	$0x1,%EAX;(0) 
0x200e;:0;CALL	1030 <printf@plt>;(0) 
0x2013;:0;VMOVSD	-0x8d8(%RBP),%XMM0;(0) 
0x201b;:0;MOV	-0x8f8(%RBP),%ESI;(0) 
0x2021;:0;LEA	0x34b0(%RIP),%RDI;(0) 
0x2028;:0;MOV	$0x1,%EAX;(0) 
0x202d;:0;CALL	1030 <printf@plt>;(0) 
0x2032;:0;POP	%RDX;(0) 
0x2033;:0;CMPL	$0,-0x8f8(%RBP);(0) 
0x203a;:0;POP	%RCX;(0) 
0x203b;:0;JE	259a <main+0x13ba>;(0) 
0x2041;:0;MOV	-0x928(%RBP),%RDI;(0) 
0x2048;:0;CALL	1120 <free@plt>;(0) 
0x204d;:0;MOV	-0x388(%RBP),%RDI;(0) 
0x2054;:0;TEST	%RDI,%RDI;(0) 
0x2057;:0;JE	205e <main+0xe7e>;(0) 
0x2059;:0;CALL	1120 <free@plt>;(0) 
0x205e;:0;MOV	-0x870(%RBP),%RDI;(0) 
0x2065;:0;MOVQ	$0,-0x868(%RBP);(0) 
0x2070;:0;CALL	1120 <free@plt>;(0) 
0x2075;:0;MOV	-0x880(%RBP),%RDI;(0) 
0x207c;:0;MOVQ	$0,-0x878(%RBP);(0) 
0x2087;:0;CALL	1120 <free@plt>;(0) 
0x208c;:0;MOV	-0x890(%RBP),%RDI;(0) 
0x2093;:0;CALL	1120 <free@plt>;(0) 
0x2098;:0;MOV	-0x8a0(%RBP),%RDI;(0) 
0x209f;:0;CALL	1120 <free@plt>;(0) 
0x20a4;:0;CALL	1090 <MPI_Finalize@plt>;(0) 
0x20a9;:0;MOV	-0x38(%RBP),%RAX;(0) 
0x20ad;:0;SUB	%FS:0x28,%RAX;(0) 
0x20b6;:0;JNE	28ae <main+0x16ce>;(0) 
0x20bc;:0;LEA	-0x30(%RBP),%RSP;
0x20c0;:0;POP	%RBX;
0x20c1;:0;POP	%R9;
0x20c3;:0;POP	%R12;
0x20c5;:0;POP	%R13;
0x20c7;:0;POP	%R14;
0x20c9;:0;POP	%R15;
0x20cb;:0;XOR	%EAX,%EAX;
0x20cd;:0;POP	%RBP;
0x20ce;:0;LEA	-0x8(%R9),%RSP;
0x20d2;:0;RET;
0x20d3;:0;NOPL	(%RAX,%RAX,1);
0x20d8;:0;MOV	-0x870(%RBP),%R14;      (4) 
0x20df;:0;MOV	%EDX,%R15D;      (4) 
0x20e2;:0;LEA	(%R14,%R15,8),%RCX;      (4) 
0x20e6;:0;VMOVSD	0x20(%RCX),%XMM6;      (4) 
0x20eb;:0;VMOVUPD	0x38(%RCX),%XMM1;      (4) 
0x20f0;:0;VSUBSD	0x10(%RCX),%XMM6,%XMM2;      (4) 
0x20f5;:0;VSHUFPD	$0x1,0x28(%RCX),%XMM1,%XMM8;      (4) 
0x20fb;:0;VMOVSD	0x8(%RCX),%XMM14;      (4) 
0x2100;:0;VMULSD	%XMM7,%XMM2,%XMM13;      (4) 
0x2104;:0;VMOVSD	%XMM14,0x18(%RCX);      (4) 
0x2109;:0;VMOVDDUP	%XMM13,%XMM10;      (4) 
0x210e;:0;VADDPD	%XMM8,%XMM10,%XMM15;      (4) 
0x2113;:0;VSUBPD	%XMM10,%XMM8,%XMM9;      (4) 
0x2118;:0;VMOVSD	%XMM15,%XMM9,%XMM11;      (4) 
0x211d;:0;VMOVUPD	%XMM11,0x30(%RCX);      (4) 
0x2122;:0;JMP	1a06 <main+0x826>;      (4) 
0x2127;:0;NOPW	(%RAX,%RAX,1);
0x2130;:0;MOV	-0x43c(%RBP),%R14D;      (4) 
0x2137;:0;MOV	-0x870(%RBP),%RCX;      (4) 
0x213e;:0;MOV	%EDX,%R15D;      (4) 
0x2141;:0;LEA	(%RCX,%R15,8),%R15;      (4) 
0x2145;:0;VXORPD	%XMM1,%XMM1,%XMM1;      (4) 
0x2149;:0;LEA	-0x1(%RAX,%R14,1),%RCX;      (4) 
0x214e;:0;VCVTSI2SD	%RCX,%XMM1,%XMM10;      (4) 
0x2153;:0;VMOVSD	0x30(%R15),%XMM8;      (4) 
0x2159;:0;VMOVSD	0x18(%R15),%XMM1;      (4) 
0x215f;:0;VMOVSD	0x38(%R15),%XMM6;      (4) 
0x2165;:0;VADDSD	%XMM8,%XMM1,%XMM2;      (4) 
0x216a;:0;VMULSD	%XMM4,%XMM10,%XMM9;      (4) 
0x216e;:0;VSUBSD	%XMM10,%XMM3,%XMM15;      (4) 
0x2173;:0;VADDSD	%XMM6,%XMM2,%XMM13;      (4) 
0x2177;:0;VMOVSD	0x20(%R15),%XMM14;      (4) 
0x217d;:0;VMOVSD	0x10(%R15),%XMM12;      (4) 
0x2183;:0;VMULSD	%XMM9,%XMM15,%XMM0;      (4) 
0x2188;:0;VFMADD132SD	0x3527(%RIP),%XMM14,%XMM13;      (4) 
0x2191;:0;VADDSD	(%R15),%XMM12,%XMM11;      (4) 
0x2196;:0;VMOVSD	0x357a(%RIP),%XMM15;      (4) 
0x219e;:0;VSUBSD	%XMM12,%XMM14,%XMM12;      (4) 
0x21a3;:0;VSUBSD	%XMM0,%XMM15,%XMM9;      (4) 
0x21a7;:0;VADDSD	%XMM11,%XMM13,%XMM10;      (4) 
0x21ac;:0;VFMADD231SD	%XMM7,%XMM12,%XMM6;      (4) 
0x21b1;:0;VMULSD	%XMM5,%XMM0,%XMM0;      (4) 
0x21b5;:0;VDIVSD	%XMM9,%XMM10,%XMM11;      (4) 
0x21ba;:0;VFNMADD132SD	%XMM7,%XMM8,%XMM12;      (4) 
0x21bf;:0;VMOVSD	%XMM1,0x8(%R15);      (4) 
0x21c5;:0;VFMADD231SD	%XMM0,%XMM11,%XMM6;      (4) 
0x21ca;:0;VFMADD132SD	%XMM0,%XMM12,%XMM11;      (4) 
0x21cf;:0;VMOVSD	%XMM6,0x28(%R15);      (4) 
0x21d5;:0;VMOVSD	%XMM11,0x40(%R15);      (4) 
0x21db;:0;JMP	1a06 <main+0x826>;      (4) 
0x21e0;:0;MOV	-0x870(%RBP),%R14;      (4) 
0x21e7;:0;MOV	%EDX,%ECX;      (4) 
0x21e9;:0;LEA	(%R14,%RCX,8),%R15;      (4) 
0x21ed;:0;VPERMPD	$0x4e,0x8(%R14,%RCX,8),%YMM14;      (4) 
0x21f5;:0;VPERMPD	$0x4e,0x28(%R15),%YMM13;      (4) 
0x21fc;:0;VMOVUPD	%YMM14,0x8(%R15);      (4) 
0x2202;:0;VMOVUPD	%YMM13,0x28(%R15);      (4) 
0x2208;:0;JMP	19da <main+0x7fa>;      (4) 
0x220d;:0;MOV	-0x870(%RBP),%RCX;    (3) 
0x2214;:0;MOV	%R10D,%EAX;    (3) 
0x2217;:0;LEA	(%RCX,%RAX,8),%RDX;    (3) 
0x221b;:0;VPERMPD	$0x4e,0x8(%RCX,%RAX,8),%YMM1;    (3) 
0x2223;:0;VPERMPD	$0x4e,0x28(%RDX),%YMM15;    (3) 
0x222a;:0;VMOVUPD	%YMM1,0x8(%RDX);    (3) 
0x222f;:0;VMOVUPD	%YMM15,0x28(%RDX);    (3) 
0x2234;:0;JMP	19bb <main+0x7db>;    (3) 
0x2239;:0;MOV	-0x870(%RBP),%R14;    (3) 
0x2240;:0;MOV	%R10D,%ECX;    (3) 
0x2243;:0;LEA	(%R14,%RCX,8),%R15;    (3) 
0x2247;:0;VMOVSD	0x20(%R15),%XMM6;    (3) 
0x224d;:0;VMOVUPD	0x38(%R15),%XMM9;    (3) 
0x2253;:0;VSUBSD	0x10(%R15),%XMM6,%XMM2;    (3) 
0x2259;:0;VSHUFPD	$0x1,0x28(%R15),%XMM9,%XMM8;    (3) 
0x2260;:0;VMOVSD	0x8(%R15),%XMM0;    (3) 
0x2266;:0;VMULSD	%XMM7,%XMM2,%XMM10;    (3) 
0x226a;:0;VMOVSD	%XMM0,0x18(%R15);    (3) 
0x2270;:0;VMOVDDUP	%XMM10,%XMM12;    (3) 
0x2275;:0;VADDPD	%XMM8,%XMM12,%XMM11;    (3) 
0x227a;:0;VSUBPD	%XMM12,%XMM8,%XMM13;    (3) 
0x227f;:0;VMOVSD	%XMM11,%XMM13,%XMM14;    (3) 
0x2284;:0;VMOVUPD	%XMM14,0x30(%R15);    (3) 
0x228a;:0;JMP	19bb <main+0x7db>;    (3) 
0x228f;:0;MOV	-0x43c(%RBP),%EDX;    (3) 
0x2295;:0;MOV	-0x870(%RBP),%R15;    (3) 
0x229c;:0;VXORPD	%XMM10,%XMM10,%XMM10;    (3) 
0x22a1;:0;MOV	%R10D,%R14D;    (3) 
0x22a4;:0;LEA	(%R15,%R14,8),%RAX;    (3) 
0x22a8;:0;VCVTSI2SD	%RDX,%XMM10,%XMM11;    (3) 
0x22ad;:0;VMOVSD	0x18(%RAX),%XMM9;    (3) 
0x22b2;:0;VMOVSD	0x30(%RAX),%XMM8;    (3) 
0x22b7;:0;VMOVSD	0x38(%RAX),%XMM6;    (3) 
0x22bc;:0;VADDSD	%XMM8,%XMM9,%XMM2;    (3) 
0x22c1;:0;VMULSD	%XMM4,%XMM11,%XMM13;    (3) 
0x22c5;:0;VSUBSD	%XMM11,%XMM3,%XMM12;    (3) 
0x22ca;:0;VADDSD	%XMM6,%XMM2,%XMM10;    (3) 
0x22ce;:0;VMOVSD	0x20(%RAX),%XMM1;    (3) 
0x22d3;:0;VMOVSD	0x10(%RAX),%XMM0;    (3) 
0x22d8;:0;VMULSD	%XMM13,%XMM12,%XMM15;    (3) 
0x22dd;:0;VFMADD132SD	0x33d2(%RIP),%XMM1,%XMM10;    (3) 
0x22e6;:0;VADDSD	(%RAX),%XMM0,%XMM14;    (3) 
0x22ea;:0;VMOVSD	0x3426(%RIP),%XMM11;    (3) 
0x22f2;:0;VSUBSD	%XMM0,%XMM1,%XMM1;    (3) 
0x22f6;:0;VSUBSD	%XMM15,%XMM11,%XMM13;    (3) 
0x22fb;:0;VADDSD	%XMM14,%XMM10,%XMM12;    (3) 
0x2300;:0;VFMADD231SD	%XMM7,%XMM1,%XMM6;    (3) 
0x2305;:0;VMULSD	%XMM5,%XMM15,%XMM15;    (3) 
0x2309;:0;VDIVSD	%XMM13,%XMM12,%XMM14;    (3) 
0x230e;:0;VFNMADD132SD	%XMM7,%XMM8,%XMM1;    (3) 
0x2313;:0;VMOVSD	%XMM9,0x8(%RAX);    (3) 
0x2318;:0;VFMADD231SD	%XMM15,%XMM14,%XMM6;    (3) 
0x231d;:0;VFMADD132SD	%XMM15,%XMM1,%XMM14;    (3) 
0x2322;:0;VMOVSD	%XMM6,0x28(%RAX);    (3) 
0x2327;:0;VMOVSD	%XMM14,0x40(%RAX);    (3) 
0x232c;:0;JMP	19bb <main+0x7db>;    (3) 
0x2331;:0;LEA	-0x860(%RBP),%RDX;(6) 
0x2338;:0;XOR	%EAX,%EAX;(6) 
0x233a;:0;LEA	0x2d42(%RIP),%RSI;(6) 
0x2341;:0;MOV	%R12,%RDI;(6) 
0x2344;:0;MOV	%RDX,-0x918(%RBP);(6) 
0x234b;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x2350;:0;CMP	$0x1,%EAX;(6) 
0x2353;:0;JNE	2439 <main+0x1259>;(6) 
0x2359;:0;VMOVSD	-0x860(%RBP),%XMM9;(6) 
0x2361;:0;VCOMISD	0x3377(%RIP),%XMM9;(6) 
0x2369;:0;JE	1350 <main+0x170>;(6) 
0x236f;:0;VMOVSD	%XMM9,0x4db9(%RIP);(6) 
0x2377;:0;JMP	1350 <main+0x170>;(6) 
0x237c;:0;MOV	0x4de5(%RIP),%RDI;(0) 
0x2383;:0;MOV	%RDI,-0x930(%RBP);(0) 
0x238a;:0;TEST	%RDI,%RDI;(0) 
0x238d;:0;JE	23ab <main+0x11cb>;(0) 
0x238f;:0;LEA	0x2e92(%RIP),%RSI;(0) 
0x2396;:0;CALL	1110 <fopen@plt>;(0) 
0x239b;:0;MOV	%RAX,-0x930(%RBP);(0) 
0x23a2;:0;TEST	%RAX,%RAX;(0) 
0x23a5;:0;JE	26dc <main+0x14fc>;(0) 
0x23ab;:0;MOV	0x4d72(%RIP),%R13;(0) 
0x23b2;:0;MOV	-0x928(%RBP),%R14D;(0) 
0x23b9;:0;MOV	-0x930(%RBP),%RCX;(0) 
0x23c0;:0;MOV	-0x918(%RBP),%RDI;(0) 
0x23c7;:0;MOV	$0x1,%EDX;(0) 
0x23cc;:0;MOV	$0x10,%ESI;(0) 
0x23d1;:0;MOVL	$0x12345,-0x860(%RBP);(0) 
0x23db;:0;MOV	%R13,-0x85c(%RBP);(0) 
0x23e2;:0;MOV	%R14D,-0x854(%RBP);(0) 
0x23e9;:0;CALL	11d0 <fwrite@plt>;(0) 
0x23ee;:0;JMP	1852 <main+0x672>;(0) 
0x23f3;:0;MOV	-0x918(%RBP),%EDI;(0) 
0x23f9;:0;XOR	%EDX,%EDX;(0) 
0x23fb;:0;IMUL	$0x48,%RDI,%RAX;(0) 
0x23ff;:0;MOV	%R11D,-0x980(%RBP);(0) 
0x2406;:0;MOV	%R9D,-0x97c(%RBP);(0) 
0x240d;:0;DIV	%RSI;(0) 
0x2410;:0;MOV	%R8D,-0x978(%RBP);(0) 
0x2417;:0;MOV	%RAX,%RDI;(0) 
0x241a;:0;CALL	1140 <malloc@plt>;(0) 
0x241f;:0;MOV	-0x980(%RBP),%R11D;(0) 
0x2426;:0;MOV	-0x97c(%RBP),%R9D;(0) 
0x242d;:0;MOV	-0x978(%RBP),%R8D;(0) 
0x2434;:0;JMP	173c <main+0x55c>;(0) 
0x2439;:0;MOV	-0x918(%RBP),%RDX;(6) 
0x2440;:0;XOR	%EAX,%EAX;(6) 
0x2442;:0;LEA	0x2c4c(%RIP),%RSI;(6) 
0x2449;:0;MOV	%R12,%RDI;(6) 
0x244c;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x2451;:0;DEC	%EAX;(6) 
0x2453;:0;JNE	2557 <main+0x1377>;(6) 
0x2459;:0;VMOVSD	-0x860(%RBP),%XMM15;(6) 
0x2461;:0;VCOMISD	0x3277(%RIP),%XMM15;(6) 
0x2469;:0;JE	1350 <main+0x170>;(6) 
0x246f;:0;VMOVSD	%XMM15,0x4cc1(%RIP);(6) 
0x2477;:0;JMP	1350 <main+0x170>;(6) 
0x247c;:0;MOV	0x4b5d(%RIP),%R10;
0x2483;:0;LEA	0x2eee(%RIP),%RDX;
0x248a;:0;MOV	(%R10),%RDI;
0x248d;:0;LEA	0x2d82(%RIP),%RSI;
0x2494;:0;XOR	%EAX,%EAX;
0x2496;:0;CALL	1160 <fprintf@plt>;
0x249b;:0;CALL	1060 <abort@plt>;
0x24a0;:0;LEA	0x2cb0(%RIP),%R9;
0x24a7;:0;PUSH	%R9;
0x24a9;:0;LEA	0x2cb7(%RIP),%R11;
0x24b0;:0;MOV	0x4cb9(%RIP),%R12D;
0x24b7;:0;PUSH	%R11;
0x24b9;:0;LEA	0x2cb9(%RIP),%R13;
0x24c0;:0;LEA	0x2cc1(%RIP),%R14;
0x24c7;:0;PUSH	%R12;
0x24c9;:0;LEA	0x2cc8(%RIP),%R15;
0x24d0;:0;LEA	0x2cd5(%RIP),%R10;
0x24d7;:0;PUSH	%R13;
0x24d9;:0;LEA	0x2cdc(%RIP),%RAX;
0x24e0;:0;LEA	0x2ce5(%RIP),%RBX;
0x24e7;:0;PUSHQ	0x4c7b(%RIP);
0x24ed;:0;LEA	0x2ce9(%RIP),%RDX;
0x24f4;:0;MOV	0x4c2e(%RIP),%ECX;
0x24fa;:0;PUSH	%R14;
0x24fc;:0;MOV	0x4c21(%RIP),%R8D;
0x2503;:0;VMOVSD	0x4c2d(%RIP),%XMM1;
0x250b;:0;PUSH	%R15;
0x250d;:0;VMOVSD	0x4c1b(%RIP),%XMM0;
0x2515;:0;LEA	0x2c23(%RIP),%R9;
0x251c;:0;PUSH	%R10;
0x251e;:0;LEA	0x2c27(%RIP),%RSI;
0x2525;:0;LEA	0x2d2c(%RIP),%RDI;
0x252c;:0;PUSH	%RAX;
0x252d;:0;MOV	$0x7,%EAX;
0x2532;:0;PUSH	%RBX;
0x2533;:0;PUSH	%RDX;
0x2534;:0;MOV	0x4be6(%RIP),%EDX;
0x253a;:0;PUSH	%RCX;
0x253b;:0;LEA	0x2c04(%RIP),%RCX;
0x2542;:0;CALL	1030 <printf@plt>;
0x2547;:0;MOV	-0x8f8(%RBP),%R8D;
0x254e;:0;ADD	$0x60,%RSP;
0x2552;:0;JMP	14e0 <main+0x300>;
0x2557;:0;MOV	-0x918(%RBP),%RDX;(6) 
0x255e;:0;XOR	%EAX,%EAX;(6) 
0x2560;:0;LEA	0x2b40(%RIP),%RSI;(6) 
0x2567;:0;MOV	%R12,%RDI;(6) 
0x256a;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x256f;:0;DEC	%EAX;(6) 
0x2571;:0;JNE	261f <main+0x143f>;(6) 
0x2577;:0;VMOVSD	-0x860(%RBP),%XMM10;(6) 
0x257f;:0;VCOMISD	0x3159(%RIP),%XMM10;(6) 
0x2587;:0;JE	1350 <main+0x170>;(6) 
0x258d;:0;VMOVSD	%XMM10,0x4bab(%RIP);(6) 
0x2595;:0;JMP	1350 <main+0x170>;(6) 
0x259a;:0;VXORPD	%XMM12,%XMM12,%XMM12;(0) 
0x259f;:0;VCVTSI2SDL	-0x8fc(%RBP),%XMM12,%XMM1;(0) 
0x25a7;:0;VMOVSD	-0x8e8(%RBP),%XMM0;(0) 
0x25af;:0;LEA	0x2f6a(%RIP),%RDI;(0) 
0x25b6;:0;MOV	$0x1,%EAX;(0) 
0x25bb;:0;VDIVSD	%XMM1,%XMM0,%XMM4;(0) 
0x25bf;:0;VMULSD	0x3101(%RIP),%XMM4,%XMM0;(0) 
0x25c7;:0;CALL	1030 <printf@plt>;(0) 
0x25cc;:0;VXORPD	%XMM5,%XMM5,%XMM5;(0) 
0x25d0;:0;VCVTSI2SDL	-0x8fc(%RBP),%XMM5,%XMM1;(0) 
0x25d8;:0;VMOVSD	-0x8f0(%RBP),%XMM14;(0) 
0x25e0;:0;LEA	0x2f69(%RIP),%RDI;(0) 
0x25e7;:0;MOV	$0x1,%EAX;(0) 
0x25ec;:0;VDIVSD	%XMM1,%XMM14,%XMM0;(0) 
0x25f0;:0;CALL	1030 <printf@plt>;(0) 
0x25f5;:0;CMPL	$0,-0x8f8(%RBP);(0) 
0x25fc;:0;JNE	2041 <main+0xe61>;(0) 
0x2602;:0;MOV	-0x930(%RBP),%R15;(0) 
0x2609;:0;TEST	%R15,%R15;(0) 
0x260c;:0;JE	2041 <main+0xe61>;(0) 
0x2612;:0;MOV	%R15,%RDI;(0) 
0x2615;:0;CALL	10e0 <fclose@plt>;(0) 
0x261a;:0;JMP	2041 <main+0xe61>;(0) 
0x261f;:0;MOV	-0x918(%RBP),%RDX;(6) 
0x2626;:0;XOR	%EAX,%EAX;(6) 
0x2628;:0;LEA	0x2a8a(%RIP),%RSI;(6) 
0x262f;:0;MOV	%R12,%RDI;(6) 
0x2632;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x2637;:0;DEC	%EAX;(6) 
0x2639;:0;JNE	2658 <main+0x1478>;(6) 
0x263b;:0;VMOVSD	-0x860(%RBP),%XMM2;(6) 
0x2643;:0;VMOVSD	%XMM2,0x4afd(%RIP);(6) 
0x264b;:0;JMP	1350 <main+0x170>;(6) 
0x2650;:0;VZEROUPPER;(0) 
0x2653;:0;JMP	1f71 <main+0xd91>;(0) 
0x2658;:0;MOV	-0x918(%RBP),%RDX;(6) 
0x265f;:0;XOR	%EAX,%EAX;(6) 
0x2661;:0;LEA	0x2a6c(%RIP),%RSI;(6) 
0x2668;:0;MOV	%R12,%RDI;(6) 
0x266b;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x2670;:0;DEC	%EAX;(6) 
0x2672;:0;JNE	28d5 <main+0x16f5>;(6) 
0x2678;:0;VMOVSD	-0x860(%RBP),%XMM13;(6) 
0x2680;:0;VMOVSD	%XMM13,0x4ac8(%RIP);(6) 
0x2688;:0;JMP	1350 <main+0x170>;(6) 
0x268d;:0;VMOVSD	0x301b(%RIP),%XMM2;(0) 
0x2695;:0;LEA	-0x8d8(%RBP),%R15;(0) 
0x269c;:0;JMP	1db7 <main+0xbd7>;(0) 
0x26a1;:0;XOR	%R8D,%R8D;(0) 
0x26a4;:0;JMP	1f79 <main+0xd99>;(0) 
0x26a9;:0;MOV	$0x1,%EDI;
0x26ae;:0;VMOVD	%R11D,%XMM3;
0x26b3;:0;VPINSRD	$0x1,%EDI,%XMM3,%XMM12;
0x26b9;:0;MOVL	$0x1,-0x928(%RBP);
0x26c3;:0;MOVSXD	%R11D,%RSI;
0x26c6;:0;MOV	$0x1,%EDI;
0x26cb;:0;JMP	1550 <main+0x370>;
0x26d0;:0;VXORPD	%XMM0,%XMM0,%XMM0;(0) 
0x26d4;:0;XOR	%R13D,%R13D;(0) 
0x26d7;:0;JMP	1f3e <main+0xd5e>;(0) 
0x26dc;:0;MOV	0x4a85(%RIP),%RDI;
0x26e3;:0;CALL	10b0 <perror@plt>;
0x26e8;:0;CALL	1060 <abort@plt>;
0x26ed;:0;LEA	0x2e9c(%RIP),%RCX;
0x26f4;:0;MOV	$0xcd,%EDX;
0x26f9;:0;LEA	0x2904(%RIP),%RSI;
0x2700;:0;LEA	0x2d61(%RIP),%RDI;
0x2707;:0;CALL	1070 <__assert_fail@plt>;
0x270c;:0;MOVL	$-0x1,-0x410(%RBP);(0) 
0x2716;:0;OR	$-0x1,%R11D;(0) 
0x271a;:0;OR	$-0x1,%EBX;(0) 
0x271d;:0;JMP	172b <main+0x54b>;(0) 
0x2722;:0;MOVL	$-0x1,-0x414(%RBP);(0) 
0x272c;:0;OR	$-0x1,%R13D;(0) 
0x2730;:0;OR	$-0x1,%R8D;(0) 
0x2734;:0;MOVL	$-0x1,-0x410(%RBP);(0) 
0x273e;:0;TEST	%EAX,%EAX;(0) 
0x2740;:0;JS	2716 <main+0x1536>;(0) 
0x2742;:0;CMP	%EAX,%EDI;(0) 
0x2744;:0;JLE	2716 <main+0x1536>;(0) 
0x2746;:0;OR	$-0x1,%R11D;(0) 
0x274a;:0;JMP	1726 <main+0x546>;(0) 
0x274f;:0;MOVL	$-0x1,-0x414(%RBP);(0) 
0x2759;:0;TEST	%EAX,%EAX;(0) 
0x275b;:0;JS	289b <main+0x16bb>;(0) 
0x2761;:0;CMP	%EAX,%EDI;(0) 
0x2763;:0;JLE	289b <main+0x16bb>;(0) 
0x2769;:0;OR	$-0x1,%R13D;(0) 
0x276d;:0;JMP	1717 <main+0x537>;(0) 
0x2772;:0;MOVL	$-0x1,-0x414(%RBP);(0) 
0x277c;:0;CMP	%EAX,%EDI;(0) 
0x277e;:0;JLE	29ef <main+0x180f>;(0) 
0x2784;:0;TEST	%EAX,%EAX;(0) 
0x2786;:0;JS	29ef <main+0x180f>;(0) 
0x278c;:0;IMUL	%ESI,%EAX;(0) 
0x278f;:0;OR	$-0x1,%R13D;(0) 
0x2793;:0;OR	$-0x1,%EBX;(0) 
0x2796;:0;ADD	%EAX,%R11D;(0) 
0x2799;:0;MOV	%R11D,-0x410(%RBP);(0) 
0x27a0;:0;JMP	172b <main+0x54b>;(0) 
0x27a5;:0;MOVL	$-0x1,-0x920(%RBP);(0) 
0x27af;:0;JMP	1677 <main+0x497>;(0) 
0x27b4;:0;LEA	0x2dd5(%RIP),%RCX;
0x27bb;:0;MOV	$0xcc,%EDX;
0x27c0;:0;LEA	0x283d(%RIP),%RSI;
0x27c7;:0;LEA	0x2c72(%RIP),%RDI;
0x27ce;:0;CALL	1070 <__assert_fail@plt>;
0x27d3;:0;LEA	0x2da6(%RIP),%RCX;
0x27da;:0;MOV	$0x46,%EDX;
0x27df;:0;LEA	0x2a08(%RIP),%RSI;
0x27e6;:0;LEA	0x2a10(%RIP),%RDI;
0x27ed;:0;CALL	1070 <__assert_fail@plt>;
0x27f2;:0;LEA	0x2827(%RIP),%RDI;
0x27f9;:0;CALL	10b0 <perror@plt>;
0x27fe;:0;CALL	1060 <abort@plt>;
0x2803;:0;MOV	-0x920(%RBP),%RDI;
0x280a;:0;CALL	10b0 <perror@plt>;
0x280f;:0;CALL	1060 <abort@plt>;
0x2814;:0;MOV	0x2eb5(%RIP),%R14;(0) 
0x281b;:0;MOVL	$-0x1,-0x428(%RBP);(0) 
0x2825;:0;MOVL	$-0x1,-0x920(%RBP);(0) 
0x282f;:0;MOV	%R14,-0x420(%RBP);(0) 
0x2836;:0;OR	$-0x1,%R9D;(0) 
0x283a;:0;OR	$-0x1,%R14D;(0) 
0x283e;:0;OR	$-0x1,%R15D;(0) 
0x2842;:0;MOVL	$-0x1,-0x418(%RBP);(0) 
0x284c;:0;TEST	%R13B,%R13B;(0) 
0x284f;:0;JNE	2873 <main+0x1693>;(0) 
0x2851;:0;TEST	%EDX,%EDX;(0) 
0x2853;:0;JS	2722 <main+0x1542>;(0) 
0x2859;:0;CMP	%EDX,%EDI;(0) 
0x285b;:0;JLE	2722 <main+0x1542>;(0) 
0x2861;:0;OR	$-0x1,%R8D;(0) 
0x2865;:0;JMP	16f0 <main+0x510>;(0) 
0x286a;:0;OR	$-0x1,%R9D;(0) 
0x286e;:0;JMP	1691 <main+0x4b1>;(0) 
0x2873;:0;MOVQ	$-0x1,-0x414(%RBP);(0) 
0x287e;:0;OR	$-0x1,%R8D;(0) 
0x2882;:0;OR	$-0x1,%R11D;(0) 
0x2886;:0;OR	$-0x1,%R13D;(0) 
0x288a;:0;OR	$-0x1,%EBX;(0) 
0x288d;:0;JMP	172b <main+0x54b>;(0) 
0x2892;:0;OR	$-0x1,%R8D;(0) 
0x2896;:0;JMP	16d0 <main+0x4f0>;(0) 
0x289b;:0;MOVL	$-0x1,-0x410(%RBP);(0) 
0x28a5;:0;OR	$-0x1,%R13D;(0) 
0x28a9;:0;JMP	2716 <main+0x1536>;(0) 
0x28ae;:0;CALL	10f0 <__stack_chk_fail@plt>;(0) 
0x28b3;:0;MOVL	$-0x1,-0x424(%RBP);(0) 
0x28bd;:0;TEST	%R13B,%R13B;(0) 
0x28c0;:0;JNE	2906 <main+0x1726>;(0) 
0x28c2;:0;TEST	%R8D,%R8D;(0) 
0x28c5;:0;JS	2906 <main+0x1726>;(0) 
0x28c7;:0;CMP	%EDI,%R8D;(0) 
0x28ca;:0;JGE	2906 <main+0x1726>;(0) 
0x28cc;:0;OR	$-0x1,%R14D;(0) 
0x28d0;:0;JMP	1633 <main+0x453>;(0) 
0x28d5;:0;MOV	-0x918(%RBP),%RDX;(6) 
0x28dc;:0;XOR	%EAX,%EAX;(6) 
0x28de;:0;LEA	0x27ff(%RIP),%RSI;(6) 
0x28e5;:0;MOV	%R12,%RDI;(6) 
0x28e8;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x28ed;:0;DEC	%EAX;(6) 
0x28ef;:0;JNE	292b <main+0x174b>;(6) 
0x28f1;:0;VMOVSD	-0x860(%RBP),%XMM6;(6) 
0x28f9;:0;VMOVSD	%XMM6,0x4857(%RIP);(6) 
0x2901;:0;JMP	1350 <main+0x170>;(6) 
0x2906;:0;LEA	-0x1(%R8),%EDX;(0) 
0x290a;:0;LEA	0x1(%R8),%EAX;(0) 
0x290e;:0;CMP	%ESI,%ECX;(0) 
0x2910;:0;JGE	2814 <main+0x1634>;(0) 
0x2916;:0;TEST	%ECX,%ECX;(0) 
0x2918;:0;JS	2814 <main+0x1634>;(0) 
0x291e;:0;OR	$-0x1,%R14D;(0) 
0x2922;:0;OR	$-0x1,%R15D;(0) 
0x2926;:0;JMP	1655 <main+0x475>;(0) 
0x292b;:0;MOV	-0x918(%RBP),%RDX;(6) 
0x2932;:0;XOR	%EAX,%EAX;(6) 
0x2934;:0;LEA	0x27c2(%RIP),%RSI;(6) 
0x293b;:0;MOV	%R12,%RDI;(6) 
0x293e;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x2943;:0;DEC	%EAX;(6) 
0x2945;:0;JNE	295c <main+0x177c>;(6) 
0x2947;:0;VMOVSD	-0x860(%RBP),%XMM8;(6) 
0x294f;:0;VMOVSD	%XMM8,0x4809(%RIP);(6) 
0x2957;:0;JMP	1350 <main+0x170>;(6) 
0x295c;:0;XOR	%EAX,%EAX;(6) 
0x295e;:0;MOV	%R15,%RDX;(6) 
0x2961;:0;LEA	0x27ac(%RIP),%RSI;(6) 
0x2968;:0;MOV	%R12,%RDI;(6) 
0x296b;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x2970;:0;DEC	%EAX;(6) 
0x2972;:0;JNE	2a09 <main+0x1829>;(6) 
0x2978;:0;MOV	-0x890(%RBP),%R8D;(6) 
0x297f;:0;MOV	%R8D,0x47ea(%RIP);(6) 
0x2986;:0;JMP	1350 <main+0x170>;(6) 
0x298b;:0;MOVL	$-0x1,-0x424(%RBP);
0x2995;:0;OR	$-0x1,%R14D;
0x2999;:0;LEA	-0x1(%R8),%EDX;
0x299d;:0;LEA	0x1(%R8),%EAX;
0x29a1;:0;CMP	%ESI,%ECX;
0x29a3;:0;JGE	29ad <main+0x17cd>;
0x29a5;:0;TEST	%ECX,%ECX;
0x29a7;:0;JNS	2922 <main+0x1742>;
0x29ad;:0;MOV	0x2d1c(%RIP),%R15;
0x29b4;:0;MOVL	$-0x1,-0x428(%RBP);
0x29be;:0;MOV	%R15,-0x420(%RBP);
0x29c5;:0;MOVL	$-0x1,-0x920(%RBP);
0x29cf;:0;OR	$-0x1,%R9D;
0x29d3;:0;OR	$-0x1,%R15D;
0x29d7;:0;JMP	16b7 <main+0x4d7>;
0x29dc;:0;MOVL	$-0x1,-0x920(%RBP);(0) 
0x29e6;:0;OR	$-0x1,%R9D;(0) 
0x29ea;:0;JMP	1691 <main+0x4b1>;(0) 
0x29ef;:0;MOVL	$-0x1,-0x410(%RBP);(0) 
0x29f9;:0;OR	$-0x1,%R11D;(0) 
0x29fd;:0;OR	$-0x1,%R13D;(0) 
0x2a01;:0;OR	$-0x1,%EBX;(0) 
0x2a04;:0;JMP	172b <main+0x54b>;(0) 
0x2a09;:0;LEA	-0x440(%RBP),%R15;(6) 
0x2a10;:0;XOR	%EAX,%EAX;(6) 
0x2a12;:0;MOV	%R15,%RDX;(6) 
0x2a15;:0;LEA	0x270d(%RIP),%RSI;(6) 
0x2a1c;:0;MOV	%R12,%RDI;(6) 
0x2a1f;:0;CALL	10d0 <__isoc99_sscanf@plt>;(6) 
0x2a24;:0;DEC	%EAX;(6) 
0x2a26;:0;JNE	2a3c <main+0x185c>;(6) 
0x2a28;:0;MOV	%R15,%RDI;(6) 
0x2a2b;:0;CALL	11b0 <strdup@plt>;(6) 
0x2a30;:0;MOV	%RAX,0x4731(%RIP);(6) 
0x2a37;:0;JMP	1350 <main+0x170>;(6) 
0x2a3c;:0;MOV	0x459d(%RIP),%R11;
0x2a43;:0;MOV	%R12,%RCX;
0x2a46;:0;MOV	(%R11),%RDI;
0x2a49;:0;MOV	%R13D,%EDX;
0x2a4c;:0;LEA	0x27dd(%RIP),%RSI;
0x2a53;:0;XOR	%EAX,%EAX;
0x2a55;:0;CALL	1160 <fprintf@plt>;
0x2a5a;:0;CALL	1060 <abort@plt>;
0x2a5f;:0;NOP;
