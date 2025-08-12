#include <stdio.h>
#include "UltrasonicSensor.h"

int Sensor1 = 0;  // Left Sensor signal
int Sensor2 = 0;  // Front Sensor signal
int Sensor3 = 0;  // Right Sensor signal

#define THRESHOLD 10  // in cm

void readAndProcessSensors() {
    int dist1, dist2, dist3;

    printf("\nEnter distance for Sensor3 (Right): ");
    scanf("%d", &dist3);
    printf("Enter distance for Sensor2 (Front): ");
    scanf("%d", &dist2);
    printf("Enter distance for Sensor1 (Left): ");
    scanf("%d", &dist1);

    // Distance > THRESHOLD → path clear (1), else blocked (0)
    Sensor3 = (dist3 > THRESHOLD) ? 1 : 0;
    Sensor2 = (dist2 > THRESHOLD) ? 1 : 0;
    Sensor1 = (dist1 > THRESHOLD) ? 1 : 0;

    printf("\nProcessed Signals => Right: %d, Front: %d, Left: %d\n", Sensor3, Sensor2, Sensor1);
}
