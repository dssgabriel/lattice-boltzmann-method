address;source_location;insn;indent
0x3ee0;:0;PUSH	%R15;
0x3ee2;:0;PUSH	%R14;
0x3ee4;:0;PUSH	%R13;
0x3ee6;:0;PUSH	%R12;
0x3ee8;:0;PUSH	%RBP;
0x3ee9;:0;PUSH	%RBX;
0x3eea;:0;SUB	$0x8018,%RSP;
0x3ef1;:0;MOV	%FS:0x28,%RAX;
0x3efa;:0;MOV	%RAX,0x8008(%RSP);
0x3f02;:0;MOV	0x8(%RSI),%EAX;
0x3f05;:0;DEC	%EAX;
0x3f07;:0;CMP	$0x1,%EAX;
0x3f0a;:0;JBE	4090 <save_frame+0x1b0>;
0x3f10;:0;MOV	0xc(%RSI),%R9D;
0x3f14;:0;MOV	%RDI,%R12;
0x3f17;:0;MOV	%RSI,%R13;
0x3f1a;:0;MOV	$0x1,%EBX;
0x3f1f;:0;XOR	%EDX,%EDX;
0x3f21;:0;LEA	-0x1(%R9),%ECX;
0x3f25;:0;MOV	%RSP,%R15;
0x3f28;:0;CMP	$0x1,%ECX;(17) 
0x3f2b;:0;JBE	408b <save_frame+0x1ab>;(17) 
0x3f31;:0;MOV	%R9D,%ESI;(17) 
0x3f34;:0;IMUL	%EBX,%ESI;(17) 
0x3f37;:0;MOV	(%R13),%RBP;(17) 
0x3f3b;:0;MOV	%EBX,%R14D;(17) 
0x3f3e;:0;LEA	0x9(%RSI,%RSI,8),%EDI;(17) 
0x3f42;:0;LEA	(%RBP,%RDI,8),%R8;(17) 
0x3f47;:0;TEST	%R8,%R8;(17) 
0x3f4a;:0;JE	40e6 <save_frame+0x206>;(17) 
0x3f50;:0;MOV	$0x1,%EBP;(17) 
0x3f55;:0;JMP	3f8c <save_frame+0xac>;(17) 
0x3f57;:0;NOPW	(%RAX,%RAX,1);
0x3f60;:0;INC	%RBP;  (18) 
0x3f63;:0;MOV	%ECX,%R10D;  (18) 
0x3f66;:0;CMP	%RBP,%R10;  (18) 
0x3f69;:0;JBE	4078 <save_frame+0x198>;  (18) 
0x3f6f;:0;MOV	%R9D,%EAX;  (18) 
0x3f72;:0;IMUL	%R14D,%EAX;  (18) 
0x3f76;:0;MOV	(%R13),%RSI;  (18) 
0x3f7a;:0;ADD	%EBP,%EAX;  (18) 
0x3f7c;:0;LEA	(%RAX,%RAX,8),%EDI;  (18) 
0x3f7f;:0;LEA	(%RSI,%RDI,8),%R8;  (18) 
0x3f83;:0;TEST	%R8,%R8;  (18) 
0x3f86;:0;JE	40e6 <save_frame+0x206>;  (18) 
0x3f8c;:0;VMOVSD	0x28(%R8),%XMM8;  (18) 
0x3f92;:0;VMOVSD	0x8(%R8),%XMM1;  (18) 
0x3f98;:0;VMOVSD	0x10(%R8),%XMM2;  (18) 
0x3f9e;:0;VMOVSD	0x18(%R8),%XMM5;  (18) 
0x3fa4;:0;VMOVSD	0x20(%R8),%XMM4;  (18) 
0x3faa;:0;VADDSD	(%R8),%XMM1,%XMM0;  (18) 
0x3faf;:0;VADDSD	%XMM5,%XMM2,%XMM9;  (18) 
0x3fb3;:0;VADDSD	%XMM8,%XMM4,%XMM11;  (18) 
0x3fb8;:0;VMOVSD	0x38(%R8),%XMM7;  (18) 
0x3fbe;:0;VMOVSD	0x30(%R8),%XMM3;  (18) 
0x3fc4;:0;VADDSD	%XMM9,%XMM0,%XMM10;  (18) 
0x3fc9;:0;VADDSD	%XMM3,%XMM11,%XMM12;  (18) 
0x3fcd;:0;VADDSD	%XMM7,%XMM4,%XMM4;  (18) 
0x3fd1;:0;VADDSD	%XMM8,%XMM2,%XMM2;  (18) 
0x3fd6;:0;VMOVSD	0x40(%R8),%XMM6;  (18) 
0x3fdc;:0;VADDSD	%XMM12,%XMM10,%XMM13;  (18) 
0x3fe1;:0;VADDSD	%XMM6,%XMM7,%XMM14;  (18) 
0x3fe5;:0;VADDSD	%XMM8,%XMM1,%XMM1;  (18) 
0x3fea;:0;VADDSD	%XMM3,%XMM5,%XMM5;  (18) 
0x3fee;:0;VSUBSD	%XMM4,%XMM2,%XMM8;  (18) 
0x3ff2;:0;VSUBSD	%XMM6,%XMM3,%XMM3;  (18) 
0x3ff6;:0;VADDSD	%XMM14,%XMM13,%XMM15;  (18) 
0x3ffb;:0;VSUBSD	%XMM7,%XMM6,%XMM9;  (18) 
0x3fff;:0;VADDSD	%XMM3,%XMM8,%XMM7;  (18) 
0x4003;:0;VSUBSD	%XMM5,%XMM1,%XMM0;  (18) 
0x4007;:0;VDIVSD	%XMM15,%XMM7,%XMM6;  (18) 
0x400c;:0;VADDSD	%XMM9,%XMM0,%XMM10;  (18) 
0x4011;:0;VDIVSD	%XMM15,%XMM10,%XMM11;  (18) 
0x4016;:0;VMULSD	%XMM6,%XMM6,%XMM12;  (18) 
0x401a;:0;VFMADD132SD	%XMM11,%XMM12,%XMM11;  (18) 
0x401f;:0;VSQRTSD	%XMM11,%XMM11,%XMM11;  (18) 
0x4024;:0;VUNPCKLPD	%XMM15,%XMM11,%XMM13;  (18) 
0x4029;:0;VCVTPD2PS	%XMM13,%XMM14;  (18) 
0x402e;:0;VMOVLPS	%XMM14,(%R15,%RDX,8);  (18) 
0x4034;:0;INC	%RDX;  (18) 
0x4037;:0;CMP	$0x1000,%RDX;  (18) 
0x403e;:0;JA	40c7 <save_frame+0x1e7>;  (18) 
0x4044;:0;JNE	3f60 <save_frame+0x80>;  (18) 
0x404a;:0;MOV	%R12,%RCX;  (18) 
0x404d;:0;MOV	$0x1000,%EDX;  (18) 
0x4052;:0;MOV	$0x8,%ESI;  (18) 
0x4057;:0;MOV	%R15,%RDI;  (18) 
0x405a;:0;CALL	11d0 <fwrite@plt>;  (18) 
0x405f;:0;MOV	0xc(%R13),%R9D;  (18) 
0x4063;:0;INC	%RBP;  (18) 
0x4066;:0;LEA	-0x1(%R9),%ECX;  (18) 
0x406a;:0;MOV	%ECX,%R10D;  (18) 
0x406d;:0;XOR	%EDX,%EDX;  (18) 
0x406f;:0;CMP	%RBP,%R10;  (18) 
0x4072;:0;JA	3f6f <save_frame+0x8f>;  (18) 
0x4078;:0;MOV	0x8(%R13),%R11D;(17) 
0x407c;:0;INC	%RBX;(17) 
0x407f;:0;DEC	%R11D;(17) 
0x4082;:0;CMP	%R11,%RBX;(17) 
0x4085;:0;JB	3f28 <save_frame+0x48>;(17) 
0x408b;:0;TEST	%RDX,%RDX;
0x408e;:0;JNE	40b5 <save_frame+0x1d5>;
0x4090;:0;MOV	0x8008(%RSP),%RAX;
0x4098;:0;SUB	%FS:0x28,%RAX;
0x40a1;:0;JNE	4105 <save_frame+0x225>;
0x40a3;:0;ADD	$0x8018,%RSP;
0x40aa;:0;POP	%RBX;
0x40ab;:0;POP	%RBP;
0x40ac;:0;POP	%R12;
0x40ae;:0;POP	%R13;
0x40b0;:0;POP	%R14;
0x40b2;:0;POP	%R15;
0x40b4;:0;RET;
0x40b5;:0;MOV	%RSP,%RDI;
0x40b8;:0;MOV	%R12,%RCX;
0x40bb;:0;MOV	$0x8,%ESI;
0x40c0;:0;CALL	11d0 <fwrite@plt>;
0x40c5;:0;JMP	4090 <save_frame+0x1b0>;
0x40c7;:0;LEA	0x14d2(%RIP),%RCX;
0x40ce;:0;MOV	$0x5f,%EDX;
0x40d3;:0;LEA	0xf4d(%RIP),%RSI;
0x40da;:0;LEA	0xf51(%RIP),%RDI;
0x40e1;:0;CALL	1070 <__assert_fail@plt>;
0x40e6;:0;LEA	0x14c3(%RIP),%RCX;
0x40ed;:0;MOV	$0x33,%EDX;
0x40f2;:0;LEA	0xf0b(%RIP),%RSI;
0x40f9;:0;LEA	0xf13(%RIP),%RDI;
0x4100;:0;CALL	1070 <__assert_fail@plt>;
0x4105;:0;CALL	10f0 <__stack_chk_fail@plt>;
0x410a;:0;NOPW	(%RAX,%RAX,1);
