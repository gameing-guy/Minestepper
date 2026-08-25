;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _initializeRobot
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
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
;main.c:28: void initializeRobot(void) {
;	---------------------------------
; Function initializeRobot
; ---------------------------------
_initializeRobot::
;main.c:29: robot.x = 0;
	ld	hl, #_robot + 4
	ld	(hl), #0x00
;main.c:30: robot.y = 0;
	ld	hl, #_robot + 5
	ld	(hl), #0x00
;main.c:31: robot.width = SPRSIZE;
	ld	hl, #_robot + 6
	ld	(hl), #0x10
;main.c:32: robot.height = SPRSIZE;
	ld	hl, #_robot + 7
	ld	(hl), #0x10
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;main.c:35: robot.spriteids[0] = 0;
	ld	hl, #_robot
	ld	(hl), #0x00
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
;main.c:37: robot.spriteids[1] = 1;
	ld	hl, #_robot + 1
	ld	(hl), #0x01
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x02
;main.c:39: robot.spriteids[2] = 2;
	ld	hl, #_robot + 2
	ld	(hl), #0x02
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x03
;main.c:41: robot.spriteids[3] = 3;
	ld	hl, #_robot + 3
	ld	(hl), #0x03
;main.c:42: }
	ret
;main.c:52: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-3
;main.c:55: set_sprite_data(0, 17, minestepperTiles);
	ld	bc, #_minestepperTiles+0
	push	bc
	ld	hl, #0x1100
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:56: set_bkg_data(0, 17, minestepperTiles);
	push	bc
	ld	hl, #0x1100
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:58: set_bkg_tiles(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, minestepperField);
	ld	de, #_minestepperField
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:59: initializeRobot();
	call	_initializeRobot
;main.c:61: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:62: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:63: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:65: move(&robot, robot.x, robot.y);
	ld	hl, #(_robot + 5)
	ld	b, (hl)
	ld	a, (#(_robot + 4) + 0)
;main.c:20: uint8_t tempX = calcPos(x);
	swap	a
	and	a, #0xf0
	add	a, #0x18
	ld	c, a
;main.c:21: uint8_t tempY = calcPos(y);
	ld	a, b
	swap	a
	and	a, #0xf0
	add	a, #0x18
	ldhl	sp,	#0
	ld	(hl), a
;main.c:22: move_sprite(robot->spriteids[0], tempX, tempY);
	ld	hl, #_robot
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#2
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	ld	(hl), c
;main.c:23: move_sprite(robot->spriteids[1], tempX, tempY + PIECESIZE);
	ldhl	sp,	#0
	ld	a, (hl+)
	add	a, #0x08
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ld	hl, #_robot + 1
	ld	e, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#4
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	ld	(hl), c
;main.c:24: move_sprite(robot->spriteids[2], tempX + PIECESIZE, tempY);
	ld	a, c
	add	a, #0x08
	ld	c, a
	ldhl	sp,	#2
	ld	(hl), c
	ld	hl, #_robot + 2
	ld	e, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:25: move_sprite(robot->spriteids[3], tempX + PIECESIZE, tempY + PIECESIZE);
	ld	hl, #_robot + 3
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#3
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	ld	(hl), c
;main.c:68: while(1) {
00118$:
;main.c:45: oldJoy = joy, joy = joypad();
	ld	a, (#_joy)
	ld	(#_oldJoy),a
	call	_joypad
	ld	(#_joy),a
;main.c:49: return ((joy & ~oldJoy) & key);
	ld	a, (#_oldJoy)
	cpl
	ld	hl, #_joy
	and	a, (hl)
	bit	1, a
	jr	Z, 00104$
;main.c:71: if (keyPressed(J_LEFT)) {
;main.c:72: if (robot.x != 0) robot.x--;
	ld	a, (#(_robot + 4) + 0)
	or	a, a
	jr	Z, 00102$
	dec	a
	ld	(#(_robot + 4)),a
00102$:
;main.c:73: move(&robot, robot.x, robot.y);
	ld	hl, #(_robot + 5)
	ld	b, (hl)
	ld	a, (#(_robot + 4) + 0)
	ld	hl, #_robot
;main.c:20: uint8_t tempX = calcPos(x);
	swap	a
	and	a, #0xf0
	add	a, #0x18
	ld	c, a
;main.c:21: uint8_t tempY = calcPos(y);
	ld	a, b
	swap	a
	and	a, #0xf0
	add	a, #0x18
	ld	b, a
;main.c:22: move_sprite(robot->spriteids[0], tempX, tempY);
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:23: move_sprite(robot->spriteids[1], tempX, tempY + PIECESIZE);
	ld	a, b
	add	a, #0x08
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ld	hl, #_robot + 1
	ld	e, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;main.c:24: move_sprite(robot->spriteids[2], tempX + PIECESIZE, tempY);
	ld	a, c
	add	a, #0x08
	ld	(hl), a
	ld	c, (hl)
	ld	hl, #_robot + 2
	ld	e, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:25: move_sprite(robot->spriteids[3], tempX + PIECESIZE, tempY + PIECESIZE);
	ld	hl, #_robot + 3
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	bc, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
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
;main.c:73: move(&robot, robot.x, robot.y);
00104$:
;main.c:49: return ((joy & ~oldJoy) & key);
	ld	a, (#_oldJoy)
	cpl
	ld	hl, #_joy
	and	a, (hl)
	rrca
	jp	NC, 00108$
;main.c:76: if (keyPressed(J_RIGHT)) {
;main.c:77: if (robot.x < 7) robot.x++;
	ld	a, (#(_robot + 4) + 0)
	cp	a, #0x07
	jr	NC, 00106$
	inc	a
	ld	(#(_robot + 4)),a
00106$:
;main.c:78: move(&robot, robot.x, robot.y);
	ld	hl, #(_robot + 5)
	ld	c, (hl)
	ld	a, (#(_robot + 4) + 0)
;main.c:20: uint8_t tempX = calcPos(x);
	swap	a
	and	a, #0xf0
	add	a, #0x18
	ldhl	sp,	#2
;main.c:21: uint8_t tempY = calcPos(y);
	ld	(hl-), a
	dec	hl
	ld	a, c
	swap	a
	and	a, #0xf0
	add	a, #0x18
	ld	(hl), a
;main.c:22: move_sprite(robot->spriteids[0], tempX, tempY);
	ld	hl, #_robot
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	c, l
	ld	b, h
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl+)
	inc	hl
	ld	(bc), a
	inc	bc
;main.c:23: move_sprite(robot->spriteids[1], tempX, tempY + PIECESIZE);
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	ld	a, (hl+)
	add	a, #0x08
	ld	(hl), a
	ld	c, (hl)
	ld	hl, #_robot + 1
	ld	e, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
;main.c:24: move_sprite(robot->spriteids[2], tempX + PIECESIZE, tempY);
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
	ld	c, (hl)
	ld	hl, #_robot + 2
	ld	e, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;main.c:25: move_sprite(robot->spriteids[3], tempX + PIECESIZE, tempY + PIECESIZE);
	ld	hl, #_robot + 3
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	bc, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
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
;main.c:78: move(&robot, robot.x, robot.y);
00108$:
;main.c:49: return ((joy & ~oldJoy) & key);
	ld	a, (#_oldJoy)
	cpl
	ld	hl, #_joy
	and	a, (hl)
	bit	2, a
	jr	Z, 00112$
;main.c:81: if (keyPressed(J_UP)) {
;main.c:82: if (robot.y != 0) robot.y--;
	ld	a, (#(_robot + 5) + 0)
	or	a, a
	jr	Z, 00110$
	dec	a
	ld	(#(_robot + 5)),a
00110$:
;main.c:83: move(&robot, robot.x, robot.y);
	ld	hl, #(_robot + 5)
	ld	b, (hl)
	ld	a, (#(_robot + 4) + 0)
	ld	hl, #_robot
;main.c:20: uint8_t tempX = calcPos(x);
	swap	a
	and	a, #0xf0
	add	a, #0x18
	ld	c, a
;main.c:21: uint8_t tempY = calcPos(y);
	ld	a, b
	swap	a
	and	a, #0xf0
	add	a, #0x18
	ld	b, a
;main.c:22: move_sprite(robot->spriteids[0], tempX, tempY);
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:23: move_sprite(robot->spriteids[1], tempX, tempY + PIECESIZE);
	ld	a, b
	add	a, #0x08
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ld	hl, #_robot + 1
	ld	e, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;main.c:24: move_sprite(robot->spriteids[2], tempX + PIECESIZE, tempY);
	ld	a, c
	add	a, #0x08
	ld	(hl), a
	ld	c, (hl)
	ld	hl, #_robot + 2
	ld	e, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:25: move_sprite(robot->spriteids[3], tempX + PIECESIZE, tempY + PIECESIZE);
	ld	hl, #_robot + 3
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	bc, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
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
;main.c:83: move(&robot, robot.x, robot.y);
00112$:
;main.c:49: return ((joy & ~oldJoy) & key);
	ld	a, (#_oldJoy)
	cpl
	ld	hl, #_joy
	and	a, (hl)
	bit	3, a
	jp	Z, 00116$
;main.c:86: if (keyPressed(J_DOWN)) {
;main.c:87: if (robot.y < 7) robot.y++;
	ld	a, (#(_robot + 5) + 0)
	cp	a, #0x07
	jr	NC, 00114$
	inc	a
	ld	(#(_robot + 5)),a
00114$:
;main.c:88: move(&robot, robot.x, robot.y);
	ld	hl, #(_robot + 5)
	ld	c, (hl)
	ld	a, (#(_robot + 4) + 0)
;main.c:20: uint8_t tempX = calcPos(x);
	swap	a
	and	a, #0xf0
	add	a, #0x18
	ldhl	sp,	#0
;main.c:21: uint8_t tempY = calcPos(y);
	ld	(hl+), a
	ld	a, c
	swap	a
	and	a, #0xf0
	add	a, #0x18
	ld	(hl), a
;main.c:22: move_sprite(robot->spriteids[0], tempX, tempY);
	ld	hl, #_robot
	ld	c, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	c, l
	ld	b, h
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#1
	ld	a, (hl-)
	ld	(bc), a
	inc	bc
;main.c:23: move_sprite(robot->spriteids[1], tempX, tempY + PIECESIZE);
	ld	a, (hl+)
	ld	(bc), a
	ld	a, (hl+)
	add	a, #0x08
	ld	c, a
	ld	(hl), c
	ld	hl, #(_robot + 1)
	ld	b, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	e, l
	ld	d, h
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#2
	ld	a, (hl-)
	dec	hl
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:24: move_sprite(robot->spriteids[2], tempX + PIECESIZE, tempY);
	ld	a, (hl+)
	inc	hl
	add	a, #0x08
	ld	b, a
	ld	(hl), b
	ld	hl, #_robot + 2
	ld	e, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_shadow_OAM)
	ld	e, a
	ld	a, h
	adc	a, #>(_shadow_OAM)
	ld	d, a
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:25: move_sprite(robot->spriteids[3], tempX + PIECESIZE, tempY + PIECESIZE);
	ld	hl, #_robot + 3
	ld	e, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:88: move(&robot, robot.x, robot.y);
00116$:
;main.c:93: vsync();
	call	_vsync
	jp	00118$
;main.c:95: }
	add	sp, #3
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__joy:
	.db #0x00	; 0
	.area _CABS (ABS)
