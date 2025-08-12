#include <stdio.h>

// ---------------------- Sensor Module ----------------------
// Sensor signals: 0 = low (blocked), 1 = high (clear)
int Sensor1 = 0;  // Left Sensor
int Sensor2 = 0;  // Front Sensor
int Sensor3 = 0;  // Right Sensor

#define THRESHOLD 10  // Threshold in cm

void readAndProcessSensors() {
    int dist1, dist2, dist3;

    printf("\nEnter distance for Sensor3 (Right): ");
    scanf("%d", &dist3);
    printf("Enter distance for Sensor2 (Front): ");
    scanf("%d", &dist2);
    printf("Enter distance for Sensor1 (Left): ");
    scanf("%d", &dist1);

    // Distance > THRESHOLD means path is clear (1), else blocked (0)
    Sensor3 = (dist3 > THRESHOLD) ? 1 : 0;
    Sensor2 = (dist2 > THRESHOLD) ? 1 : 0;
    Sensor1 = (dist1 > THRESHOLD) ? 1 : 0;

    printf("\nProcessed Signals => Right: %d, Front: %d, Left: %d\n",
           Sensor3, Sensor2, Sensor1);
}

// ---------------------- Motor Control ----------------------
int Motor1A=0, Motor1B=0, Motor2A=0, Motor2B=0;

void moveForward();
void turnRight();
void turnLeft();
void goBack();
void delay(long iterations);

// ---------------------- Main Logic ----------------------
int main() {
    while(1) {
        readAndProcessSensors();

        if(Sensor3 == 1) {
            // Right clear → turn right immediately
            turnRight();
        }
        else {
            // Right blocked, check front and left
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

// ---------------------- Movement Functions ----------------------
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
        // empty loop for delay simulation
    }
}
