#include <gb/gb.h>
#include <stdint.h>

struct Robot {
    uint8_t spriteids[4];
    uint8_t x;
    uint8_t y;
    uint8_t width;
    uint8_t height;
};