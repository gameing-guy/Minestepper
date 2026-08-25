#include <gb/gb.h>
#include <stdint.h>
#include "robot.h"
#include "../res/minestepperTiles.h"

struct Robot robot;

uint8_t joy = 0, oldJoy;

#define SPRSIZE 16
#define PIECESIZE 8

void initializeRobot(void) {
    robot.x = 80;
    robot.y = 130;
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

void move(struct Robot* robot, uint8_t x, uint8_t y) {
    move_sprite(robot->spriteids[0], x, y);
    move_sprite(robot->spriteids[1], x, y + PIECESIZE);
    move_sprite(robot->spriteids[2], x + PIECESIZE, y);
    move_sprite(robot->spriteids[3], x + PIECESIZE, y + PIECESIZE);
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
    set_sprite_data(0, 16, minestepperTiles);
    initializeRobot();

    SHOW_SPRITES;
    DISPLAY_ON;

    move(&robot, robot.x, robot.y);

    // Loop forever
    while(1) {
        grabInput();
		// Game main loop processing goes here
        if (keyPressed(J_LEFT)) {
            robot.x -= SPRSIZE;
            move(&robot, robot.x, robot.y);
        }

        if (keyPressed(J_RIGHT)) {
            robot.x += SPRSIZE;
            move(&robot, robot.x, robot.y);
        }

        if (keyPressed(J_UP)) {
            robot.y -= SPRSIZE;
            move(&robot, robot.x, robot.y);
        }

        if (keyPressed(J_DOWN)) {
            robot.y += SPRSIZE;
            move(&robot, robot.x, robot.y);
        }


		// Done processing, yield CPU and wait for start of next frame
        vsync();
    }
}
