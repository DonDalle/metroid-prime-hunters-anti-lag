/*************Metroid Prime Hunters Anti Lag CodeImpementation by Dalle************//*********AddressesplayerId = baseHP 			= base + 0xB36DD Duration = base + 0xF0CCoil Strength = base + 0xE98EU Base = 0x020da558JP Base = 0x020dbb78US Base = 0x020d9cb8*******/.global main.func mainmain:	push {r0-r12}	/* setup offset */	ldr r8, playerOffset		@r8 = player offset	ldr r9, playerData			@r9 = base address	ldr r11, [r9]				@r11 = player number	mul r10, r8, r11	add r10,  r10, r9 			@r10 = base address + player number *  offsetloadHP:	/* load current hp and temp hp */	ldr r1, =0xB36	add r1, r10, r1	ldrh r5, [r1] 				@ r5 = currentHp	ldrh r4, tempHP 			@ r4 =tmpHpcheckSC:	ldr r1, =0xE98	add r1, r1, r9	mov r0, #0	SCLoop:		cmp r0, r11		beq skipSCLoop		ldr r2, [r1]		cmp r2, #0		bgt applyEffect	skipSCLoop:		add r1, r1, r8		add r0, #1		cmp r0, #4		blt SCLoopcompareHP:	/* currentHp < tmpHp? */	cmp r5, r4	bge end

checkThreshold:
	/* skip if dmg is <= than threshold */
	ldr r2, threshold
	sub r1, r4, r5
	cmp r1, r2
	ble end
applyEffect:	ldr r1, =0xF0C	add r1, r1, r10	ldr r2, ddDurarion	strh r2, [r1]restoreHP:	cmp r5, #0	beq end	ldr r1, =0xF0C	add r1, r1, r9	mov r0, #0	hpRestoreLoop:		cmp r0, r11		beq skipHpRestoreLoop		ldr r2, [r1]		cmp r2, #0		bgt doHpRestore	skipHpRestoreLoop:		add r1, r1, r8		add r0, #1		cmp r0, #4		blt hpRestoreLoop	b enddoHpRestore:	sub r1, r4, r5 @temphp-currenthp	add r0, r5, r1, lsr #1	ldr r1, =0xB36	add r1, r1, r10	strh r0, [r1]end:	strh r5, tempHP			@tempHP = currentHp
	@debug
	/*ldr r0, deathsAddress
	ldr r1, =0x20DB464
	ldrh r5, [r1]
	strh r5, [r0]*/

	pop {r0-r12}	bx r14tempHP:	.long 0x0
playerData:	.long 0x020da558ddDurarion:	.long 0xAplayerOffset:
	.long 0xF30threshold:	.long 0x5/* for debuggingdeathsAddress:	.long 0x20e855c*/