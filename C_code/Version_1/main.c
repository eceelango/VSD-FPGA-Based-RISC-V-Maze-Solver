#include <stdio.h>
#include "UltrasonicSensor.h"

// Motor control variables (simulate motor pins)
int Motor1A=0, Motor1B=0, Motor2A=0, Motor2B=0;

// Function declarations
void moveForward();
void turnRight();
void turnLeft();
void goBack();
void delay(long iterations);

int main() {
    while(1) {
        readAndProcessSensors();

        if(Sensor3 == 1) {
            turnRight();
        }
        else {
            if(Sensor2 == 1) {
                moveForward();
            }
            else if(Sensor1 == 1) {
                turnLeft();
            }
            else {
                goBack();
            }
        }
    }
    return 0;
}

// Movement functions implementation
void moveForward() {
    printf("\n----------------------------------------------");
    printf("\n\tMoving forward");
    Motor1A=1; Motor1B=0;
    Motor2A=1; Motor2B=0;
    printf("\nMotor1A=1, Motor1B=0, Motor2A=1, Motor2B=0");
    printf("\n----------------------------------------------\n");
}

void turnRight() {
    printf("\n----------------------------------------------");
    printf("\n\tTurning right");
    Motor1A=1; Motor1B=0;
    Motor2A=0; Motor2B=1;
    printf("\nMotor1A=1, Motor1B=0, Motor2A=0, Motor2B=1");
    printf("\n----------------------------------------------\n");
    delay(700);
}

void turnLeft() {
    printf("\n----------------------------------------------");
    printf("\n\tTurning left");
    Motor1A=0; Motor1B=1;
    Motor2A=1; Motor2B=0;
    printf("\nMotor1A=0, Motor1B=1, Motor2A=1, Motor2B=0");
    printf("\n----------------------------------------------\n");
    delay(700);
}

void goBack() {
    printf("\n----------------------------------------------");
    printf("\n\tU Turn");
    Motor1A=1; Motor1B=0;
    Motor2A=1; Motor2B=0;
    printf("\nMotor1A=1, Motor1B=0, Motor2A=1, Motor2B=0");
    printf("\n----------------------------------------------\n");
    delay(1400);
}

void delay(long iterations) {
    for(long i = 0; i < iterations; i++) {
        // Empty delay loop for simulation
    }
}
