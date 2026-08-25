#include <gb/gb.h>
#include <stdint.h>
#include "robot.h"
#include "../res/minestepperTiles.h"
#include "../res/minestepperField.h"

struct Robot robot;

uint8_t joy = 0, oldJoy;

#define SPRSIZE 16
#define PIECESIZE 8
#define INITPOS 24

inline uint8_t calcPos(uint8_t x) {
    return INITPOS + x * SPRSIZE;
}

inline void move(struct Robot* robot, uint8_t x, uint8_t y) {
    uint8_t tempX = calcPos(x);
    uint8_t tempY = calcPos(y);
    move_sprite(robot->spriteids[0], tempX, tempY);
    move_sprite(robot->spriteids[1], tempX, tempY + PIECESIZE);
    move_sprite(robot->spriteids[2], tempX + PIECESIZE, tempY);
    move_sprite(robot->spriteids[3], tempX + PIECESIZE, tempY + PIECESIZE);
}

void initializeRobot(void) {
    robot.x = 0;
    robot.y = 0;
    robot.width = SPRSIZE;
    robot.height = SPRSIZE;

    set_sprite_tile(0, 0);
    robot.spriteids[0] = 0;
    set_sprite_tile(1, 1);
    robot.spriteids[1] = 1;
    set_sprite_tile(2, 2);
    robot.spriteids[2] = 2;
    set_sprite_tile(3, 3);
    robot.spriteids[3] = 3;
}

inline void grabInput(void) {
    oldJoy = joy, joy = joypad();
}

inline uint8_t keyPressed(uint8_t key) {
    return ((joy & ~oldJoy) & key);
}

void main(void)
{
    // Initialize
    set_sprite_data(0, 17, minestepperTiles);
    set_bkg_data(0, 17, minestepperTiles);
    
    set_bkg_tiles(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, minestepperField);
    initializeRobot();

    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;

    move(&robot, robot.x, robot.y);

    // Loop forever
    while(1) {
        grabInput();
		// Game main loop processing goes here
        if (keyPressed(J_LEFT)) {
            if (robot.x != 0) robot.x--;
            move(&robot, robot.x, robot.y);
        }

        if (keyPressed(J_RIGHT)) {
            if (robot.x < 7) robot.x++;
            move(&robot, robot.x, robot.y);
        }

        if (keyPressed(J_UP)) {
            if (robot.y != 0) robot.y--;
            move(&robot, robot.x, robot.y);
        }

        if (keyPressed(J_DOWN)) {
            if (robot.y < 7) robot.y++;
            move(&robot, robot.x, robot.y);
        }


		// Done processing, yield CPU and wait for start of next frame
        vsync();
    }
}
