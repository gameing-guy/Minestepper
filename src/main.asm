;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _move
	.globl _initializeRobot
	.globl _set_sprite_data
	.globl _vsync
	.globl _joypad
	.globl _joy
	.globl _oldJoy
	.globl _robot
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_robot::
	.ds 8
_oldJoy::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_joy::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:13: void initializeRobot(void) {
;	---------------------------------
; Function initializeRobot
; ---------------------------------
_initializeRobot::
;main.c:14: robot.x = 80;
	ld	hl, #_robot + 4
	ld	(hl), #0x50
;main.c:15: robot.y = 130;
	ld	hl, #_robot + 5
	ld	(hl), #0x82
;main.c:16: robot.width = SPRSIZE;
	ld	hl, #_robot + 6
	ld	(hl), #0x10
;main.c:17: robot.height = SPRSIZE;
	ld	hl, #_robot + 7
	ld	(hl), #0x10
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;main.c:20: robot.spriteids[0] = 0;
	ld	hl, #_robot
	ld	(hl), #0x00
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
;main.c:22: robot.spriteids[1] = 1;
	ld	hl, #_robot + 1
	ld	(hl), #0x01
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x02
;main.c:24: robot.spriteids[2] = 2;
	ld	hl, #_robot + 2
	ld	(hl), #0x02
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x03
;main.c:26: robot.spriteids[3] = 3;
	ld	hl, #_robot + 3
	ld	(hl), #0x03
;main.c:27: }
	ret
;main.c:29: void move(struct Robot* robot, uint8_t x, uint8_t y) {
;	---------------------------------
; Function move
; ---------------------------------
_move::
	add	sp, #-3
	ldhl	sp,	#2
	ld	(hl), a
;main.c:30: move_sprite(robot->spriteids[0], x, y);
	ld	a, (de)
	ld	c, a
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
;main.c:31: move_sprite(robot->spriteids[1], x, y + PIECESIZE);
	ldhl	sp,	#5
	ld	a, (hl)
	add	a, #0x08
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ld	l, e
	ld	h, d
	inc	hl
	ld	c, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:32: move_sprite(robot->spriteids[2], x + PIECESIZE, y);
	ld	a, (hl-)
	add	a, #0x08
	ld	(hl), a
	ld	c, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	b, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#7
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	ld	(hl), c
;main.c:33: move_sprite(robot->spriteids[3], x + PIECESIZE, y + PIECESIZE);
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	e, a
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	ld	l, e
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:33: move_sprite(robot->spriteids[3], x + PIECESIZE, y + PIECESIZE);
;main.c:34: }
	add	sp, #3
	pop	hl
	inc	sp
	jp	(hl)
;main.c:44: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:47: set_sprite_data(0, 16, minestepperTiles);
	ld	de, #_minestepperTiles
	push	de
	ld	hl, #0x1000
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:48: initializeRobot();
	call	_initializeRobot
;main.c:50: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:51: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:53: move(&robot, robot.x, robot.y);
	ld	hl, #(_robot + 5)
	ld	b, (hl)
	ld	a, (#(_robot + 4) + 0)
	push	bc
	inc	sp
	ld	de, #_robot
	call	_move
;main.c:56: while(1) {
00110$:
;main.c:37: oldJoy = joy, joy = joypad();
	ld	a, (#_joy)
	ld	(#_oldJoy),a
	call	_joypad
	ld	(#_joy),a
;main.c:41: return ((joy & ~oldJoy) & key);
	ld	a, (#_oldJoy)
	cpl
	ld	hl, #_joy
	and	a, (hl)
	bit	1, a
	jr	Z, 00102$
;main.c:59: if (keyPressed(J_LEFT)) {
;main.c:60: robot.x -= SPRSIZE;
	ld	a, (#(_robot + 4) + 0)
	add	a, #0xf0
	ld	(#(_robot + 4)),a
;main.c:61: move(&robot, robot.x, robot.y);
	ld	hl, #(_robot + 5)
	ld	b, (hl)
	ld	a, (#(_robot + 4) + 0)
	push	bc
	inc	sp
	ld	de, #_robot
	call	_move
00102$:
;main.c:41: return ((joy & ~oldJoy) & key);
	ld	a, (#_oldJoy)
	cpl
	ld	hl, #_joy
	and	a, (hl)
	rrca
	jr	NC, 00104$
;main.c:64: if (keyPressed(J_RIGHT)) {
;main.c:65: robot.x += SPRSIZE;
	ld	a, (#(_robot + 4) + 0)
	add	a, #0x10
	ld	(#(_robot + 4)),a
;main.c:66: move(&robot, robot.x, robot.y);
	ld	hl, #(_robot + 5)
	ld	b, (hl)
	ld	a, (#(_robot + 4) + 0)
	push	bc
	inc	sp
	ld	de, #_robot
	call	_move
00104$:
;main.c:41: return ((joy & ~oldJoy) & key);
	ld	a, (#_oldJoy)
	cpl
	ld	hl, #_joy
	and	a, (hl)
	bit	2, a
	jr	Z, 00106$
;main.c:69: if (keyPressed(J_UP)) {
;main.c:70: robot.y -= SPRSIZE;
	ld	a, (#(_robot + 5) + 0)
	add	a, #0xf0
	ld	(#(_robot + 5)),a
;main.c:71: move(&robot, robot.x, robot.y);
	ld	hl, #(_robot + 5)
	ld	b, (hl)
	ld	a, (#(_robot + 4) + 0)
	push	bc
	inc	sp
	ld	de, #_robot
	call	_move
00106$:
;main.c:41: return ((joy & ~oldJoy) & key);
	ld	a, (#_oldJoy)
	cpl
	ld	hl, #_joy
	and	a, (hl)
	bit	3, a
	jr	Z, 00108$
;main.c:74: if (keyPressed(J_DOWN)) {
;main.c:75: robot.y += SPRSIZE;
	ld	a, (#(_robot + 5) + 0)
	add	a, #0x10
	ld	(#(_robot + 5)),a
;main.c:76: move(&robot, robot.x, robot.y);
	ld	hl, #(_robot + 5)
	ld	b, (hl)
	ld	a, (#(_robot + 4) + 0)
	push	bc
	inc	sp
	ld	de, #_robot
	call	_move
00108$:
;main.c:81: vsync();
	call	_vsync
;main.c:83: }
	jp	00110$
	.area _CODE
	.area _INITIALIZER
__xinit__joy:
	.db #0x00	; 0
	.area _CABS (ABS)
