#ifndef ULTRASONICSENSOR_H
#define ULTRASONICSENSOR_H

// Sensor signals: 0 = blocked (low), 1 = clear (high)
extern int Sensor1;  // Left
extern int Sensor2;  // Front
extern int Sensor3;  // Right

// Function to read sensor distances and convert to high/low signals
void readAndProcessSensors();

#endif // ULTRASONICSENSOR_H
