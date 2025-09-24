# VSD-FPGA-Based-RISC-V-Maze-Solver
---

## VSDSquadron FM: Hardware Summary

![VSD Image](https://github.com/eceelango/VSD-FPGA-Based-RISC-V-Maze-Solver/blob/a8eadaca49bd8b435456cc564fe6d5cd75bb72e5/Pictures/VSD.jpg)

### Key Specifications

| Feature                   | Specification                        |
|---------------------------|------------------------------------|
| **FPGA Chip**             | Lattice UltraPlus ICE40UP5K         |
| **Logic Cells**           | 5,280                              |
| **SPRAM**                 | 1 Mb                              |
| **GPIO Pins**             | 32 accessible FPGA GPIOs            |
| **Memory**                | 4 MB SPI Flash                     |
| **LED Indicators**        | RGB LED                           |
| **Power Regulation**      | Onboard 3.3V regulators             |
| **Dimensions (L × W)**    | 57 mm × 29 mm                     |
| **Max Operating Frequency** | 133 MHz                          |
| **Supported Development Tools** | Project IceStorm, Yosys, NextPNR |


## FPGA-Based RISC-V Maze Solver (C Implementation)

### 📌 Introduction – VSD Squadron FPGA Mini
The **VSD Squadron FPGA Mini** is a compact, low-power FPGA development board designed for experimenting with digital logic design, RISC-V processor implementation, and embedded systems applications. It features:
- **FPGA Device**: Lattice iCE40 series
- **Clock Frequency**: 12 MHz
- **Interfaces**: GPIO, UART, PWM, SPI, and I²C
- **Ideal For**: FPGA beginners, RISC-V architecture learners, robotics and embedded system projects.

This board is used in this project to implement a **RISC-V based maze solver** that uses ultrasonic sensors for wall detection and navigation logic.

---

### 🎯 Project Objective
The key objective of this project is to develop a **microarchitecture (RISC-V controller)** so that the micromouse maze solver bot can find a path from a designated **start point** to an **end point** within a maze, **efficiently and accurately**.

This involves:
- Navigating through a **complex network** of paths and walls.
- Avoiding **dead ends**.
- Using **algorithms** and strategies to explore and solve the maze.
- Adapting to **various maze configurations**.
- Overcoming challenges such as **loops**, **multiple paths**, and **dynamic changes** within the maze environment.

---
### 🔍 Block Diagram
![Block Diagram](https://github.com/eceelango/VSD-FPGA-Based-RISC-V-Maze-Solver/blob/7c9de58f762a67be2234396bfa26f937107c8c38/Pictures/Block_Diagram.jpg) 

---

### 🔄 Flowchart
![Flowchart](https://github.com/eceelango/VSD-FPGA-Based-RISC-V-Maze-Solver/blob/bef5d258d01a38be110739ca44e61dc86f425696/Pictures/Flow_Chart.jpg) 

---

## 📂 Project Structure and Versions

### 🚀Version 1 – Modular Implementation
- Files:
  - `main.c` – Main control logic.
  - `UltrasonicSensor.c` – Ultrasonic sensor reading and processing.
  - `UltrasonicSensor.h` – Header file with sensor declarations.
- Features:
  - Sensor and control logic separated for better maintainability.
  - Easier to debug and extend.
- Compile and run:
Absolutely! Here's a clear explanation of the **Compile and Run** section for your README:

---

## main.c
```bash
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

```
---

## UltrasonicSensor.c

```bash
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
```
---

## UltrasonicSensor.h

```bash

#ifndef ULTRASONICSENSOR_H
#define ULTRASONICSENSOR_H

// Sensor signals: 0 = blocked (low), 1 = clear (high)
extern int Sensor1;  // Left
extern int Sensor2;  // Front
extern int Sensor3;  // Right

// Function to read sensor distances and convert to high/low signals
void readAndProcessSensors();

#endif // ULTRASONICSENSOR_H

```
---
### Compile and Run


**🧱Step 1: Compile the code**

Use the following command to compile `main.c` and `UltrasonicSensor.c` together into a single executable file named `main`:

```bash
gcc main.c UltrasonicSensor.c -o main
```

* `gcc` is the GNU Compiler Collection command for compiling C programs.
* `main.c UltrasonicSensor.c` are the source files being compiled.
* `-o main` specifies the output executable file name (`main`).

If the compilation is successful, no errors will appear, and an executable file named `main` (or `main.exe` on Windows) will be created in your current directory.

---

**▶️Step 2: Run the program**

  ```bash
 .\main.exe
  ```
---

## 📺Sample Output
![Output](https://github.com/eceelango/VSD-FPGA-Based-RISC-V-Maze-Solver/blob/e5a02f091402c9872f392c2ba31b3f96e1d3e0df/Pictures/Output_1.png)

### 🚀 Version 2 – Single-File Implementation

- **File:**  
  - `full_code.c` – Contains the complete sensor reading, processing, and motor control logic in a single file.

- **Features:**  
  - All code consolidated into one file for simplicity.  
  - Easy to modify and understand as a standalone program.
 
## full_code.c

```bash

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

```

- ### **Compile and run:**

  **🛠️Step 1: Compile the code**

  ```bash
  gcc full_code.c -o full_code
  ```
---
  
## 📺Sample Output
![Output](https://github.com/eceelango/VSD-FPGA-Based-RISC-V-Maze-Solver/blob/42e16cd91dbaf2d358ac0b996f6f0042a1c673ad/Pictures/Output_2.png)
## Register architecture of x30 for GPIOs

+ Input Signals - Sensor1, Sensor2, Sensor3;
+ Output Signals -  Motor1A, Motor1B, Motor2A, Motor2B;
+ Number of Register bits Required - 28
+ Register bits allocations are given below

+ x30 [23:0] is Sensor -  Sensor 1 - x30[7:0]; Sensor 2 - x30[15:8]; Sensor 3 - x30[23:16];   // Input - Read
+ x30 [25:24] is e1 & e2 - e1 x30 [24] ; e2 x30 [25] ;  // Output Write  Motor1A = 2^24 =167777216  Motor1B = 2^25 = 33554432
+ x30 [27:26] is d1 & d2 - d1 x30 [26] ; d2 x30 [27] ;  // Output Write  Motor2A = 2^26 =67108864  Motor2B = 2^27 =134217728

+ Here Threshold is fixed now. In next iteration, we will get the threshold as a input 

| Movement | Motor1A | Motor1B | Motor2A | Motor2B |
| -------- | ------- | ------- | ------- | ------- |
| Forward  | 1       | 0       | 1       | 0       |
| Backward | 0       | 1       | 0       | 1       |
| Left     | 0       | 1       | 1       | 0       |
| Right    | 1       | 0       | 0       | 1       |
| Stop     | 0       | 0       | 0       | 0       |

# **Assembly In line Code for Maze Controller**

## C Code with inline Assembly
```

#include <stdio.h>

// ---------------------- Sensor Module ----------------------
// Sensor signals: 0 = low (blocked), 1 = high (clear)
int Sensor1 = 0;  // Left Sensor
int Sensor2 = 0;  // Front Sensor
int Sensor3 = 0;  // Right Sensor
 int dist1, dist2, dist3;

#define THRESHOLD 10  // Threshold in cm

// ---------------------- Motor Control ----------------------
int Motor1A=0, Motor1B=0, Motor2A=0, Motor2B=0;

void moveForward();
void turnRight();
void turnLeft();
void goBack();
void delay(long iterations);
void readSensors(int *dist1, int *dist2, int *dist3);


// ---------------------- Main Logic ----------------------
int main() {
    while(1) {
  // Get distance readings from user input
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

        if(Sensor3 == 1) {
            // Right clear → turn right immediately
            printf("Turning Right...\n");
            turnRight();
     
        }
        else {
            // Right blocked, check front and left
            if(Sensor2 == 1) {
            printf("Moving Forward...\n");
            moveForward();
 
            } 
            else if(Sensor1 == 1) {
           printf("Turning Left...\n");
           turnLeft();
            } 
            else {
           printf("Going Back...\n");
                goBack();
            }
        }
    }
    return 0;
}


// Function to read sensor values using inline assembly
void readSensors(int *dist1, int *dist2, int *dist3)
{
    int d1, d2, d3;
    int clear_mask = 0x0FFFFFFF;

    asm volatile(
        "andi t0, x30, %3\n\t"        // clear unwanted bits into t0
        "andi %0, t0, 0xFF\n\t"       // dist1 = t0[7:0]
        "srli t1, t0, 8\n\t"          // shift >> 8
        "andi %1, t1, 0xFF\n\t"       // dist2 = t0[15:8]
        "srli t2, t0, 16\n\t"         // shift >> 16
        "andi %2, t2, 0xFF\n\t"       // dist3 = t0[23:16]
        : "=r"(d1), "=r"(d2), "=r"(d3)
        : "r"(clear_mask)
        : "t0", "t1", "t2"
    );

    *dist1 = d1;
    *dist2 = d2;
    *dist3 = d3;

    printf("dist 1: %2x, dist 2: %2x, dist 3: %2x\n", *dist1, *dist2, *dist3);
}
 

// ---------------------- Movement Functions ----------------------

// Forward
void moveForward() {
// Debug print motor values
     asm volatile(
        "li t0, 0x0FFFFFFF\n\t"        // mask to clear bits [27:24]
        "and x30, x30, t0\n\t"
        "li t1, (1 << 24) | (1 << 26)\n\t"   // Motor1A + Motor2A
        "or x30, x30, t1\n\t"

        "andi %0, x30, (1 << 24)\n\t"
        "andi %1, x30, (1 << 25)\n\t"
        "andi %2, x30, (1 << 26)\n\t"
        "andi %3, x30, (1 << 27)\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "x30"
    );
 printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);
    delay(700);
}

// Backward
void goBack() {
 // Debug print motor values
       asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"
        "li t1, (1 << 25) | (1 << 27)\n\t"   // Motor1B + Motor2B
        "or x30, x30, t1\n\t"

        "andi %0, x30, (1 << 24)\n\t"
        "andi %1, x30, (1 << 25)\n\t"
        "andi %2, x30, (1 << 26)\n\t"
        "andi %3, x30, (1 << 27)\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "x30"
    );
    // Debug print motor values
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);
    delay(1400);
}

// Left
void turnLeft() {
 
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"
        "li t1, (1 << 25) | (1 << 26)\n\t"   // Motor1B + Motor2A
        "or x30, x30, t1\n\t"

        "andi %0, x30, (1 << 24)\n\t"
        "andi %1, x30, (1 << 25)\n\t"
        "andi %2, x30, (1 << 26)\n\t"
        "andi %3, x30, (1 << 27)\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "x30"
    );
    // Debug print motor values
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);
    delay(700);
}

// Right
void moveRight() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"
        "li t1, (1 << 24) | (1 << 27)\n\t"   // Motor1A + Motor2B
        "or x30, x30, t1\n\t"

        "andi %0, x30, (1 << 24)\n\t"
        "andi %1, x30, (1 << 25)\n\t"
        "andi %2, x30, (1 << 26)\n\t"
        "andi %3, x30, (1 << 27)\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "x30"
    );
    // Debug print motor values
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);
    delay(1400);
}

// Stop
void stopMovement() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"          // clear all motor bits

        "andi %0, x30, (1 << 24)\n\t"
        "andi %1, x30, (1 << 25)\n\t"
        "andi %2, x30, (1 << 26)\n\t"
        "andi %3, x30, (1 << 27)\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "x30"
    );
    // Debug print motor values
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);
    delay(1400);
}


void delay(long iterations) {
    for(long i = 0; i < iterations; i++) {
        // empty loop for delay simulation
    }
}
  
```
## C Code with inline Assembly Final Version
```
#include <stdio.h>

// ---------------------- Sensor Module ----------------------
// Sensor signals: 0 = low (blocked), 1 = high (clear)
int Sensor1 = 0;  // Left Sensor
int Sensor2 = 0;  // Front Sensor
int Sensor3 = 0;  // Right Sensor
int dist1, dist2, dist3;

#define THRESHOLD 10  // Threshold in cm

// ---------------------- Motor Control ----------------------
int Motor1A = 0, Motor1B = 0, Motor2A = 0, Motor2B = 0;
uint32_t x30 = 0;  // Simulate x30 register

void moveForward();
void turnRight();
void turnLeft();
void goBack();
void stopMovement();
void delay(long iterations);
void readSensors(int *dist1, int *dist2, int *dist3);

// ---------------------- Main Logic ----------------------
int main() {
    while(1) {
        // Get distance readings from user input
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

        if (Sensor3 == 1) {
            printf("Turning Right...\n");
            turnRight();
        } else {
            if (Sensor2 == 1) {
                printf("Moving Forward...\n");
                moveForward();
            } else if (Sensor1 == 1) {
                printf("Turning Left...\n");
                turnLeft();
            } else {
                printf("Going Back...\n");
                goBack();
            }
        }
    }
    return 0;
}

void readSensors(int *dist1, int *dist2, int *dist3)
{
    int d1, d2, d3;
    int clear_mask = 0x0FFFFFFF;

    asm volatile(
        "mv t3, %3\n\t"
        "and t0, x30, t3\n\t"
        "li t4, 0xFF\n\t"
        "and %0, t0, t4\n\t"
        "srli t1, t0, 8\n\t"
        "and %1, t1, t4\n\t"
        "srli t2, t0, 16\n\t"
        "and %2, t2, t4\n\t"
        : "=r"(d1), "=r"(d2), "=r"(d3)
        : "r"(clear_mask)
        : "t0", "t1", "t2", "t3", "t4"
    );

    *dist1 = d1;
    *dist2 = d2;
    *dist3 = d3;

    printf("dist 1: %2x, dist 2: %2x, dist 3: %2x\n", *dist1, *dist2, *dist3);
}

void moveForward() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"
        "li t1, (1 << 24) | (1 << 26)\n\t"
        "or x30, x30, t1\n\t"

        "li t3, (1 << 24)\n\t"
        "and %0, x30, t3\n\t"
        "li t3, (1 << 25)\n\t"
        "and %1, x30, t3\n\t"
        "li t3, (1 << 26)\n\t"
        "and %2, x30, t3\n\t"
        "li t3, (1 << 27)\n\t"
        "and %3, x30, t3\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "t3", "x30"
    );
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n",
           Motor1A, Motor1B, Motor2A, Motor2B);
    delay(700);
}

void goBack() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"
        "li t1, (1 << 25) | (1 << 27)\n\t"
        "or x30, x30, t1\n\t"

        "li t3, (1 << 24)\n\t"
        "and %0, x30, t3\n\t"
        "li t3, (1 << 25)\n\t"
        "and %1, x30, t3\n\t"
        "li t3, (1 << 26)\n\t"
        "and %2, x30, t3\n\t"
        "li t3, (1 << 27)\n\t"
        "and %3, x30, t3\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "t3", "x30"
    );
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n",
           Motor1A, Motor1B, Motor2A, Motor2B);
    delay(1400);
}

void turnLeft() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"
        "li t1, (1 << 25) | (1 << 26)\n\t"
        "or x30, x30, t1\n\t"

        "li t3, (1 << 24)\n\t"
        "and %0, x30, t3\n\t"
        "li t3, (1 << 25)\n\t"
        "and %1, x30, t3\n\t"
        "li t3, (1 << 26)\n\t"
        "and %2, x30, t3\n\t"
        "li t3, (1 << 27)\n\t"
        "and %3, x30, t3\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "t3", "x30"
    );
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n",
           Motor1A, Motor1B, Motor2A, Motor2B);
    delay(700);
}

void turnRight() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"
        "li t1, (1 << 24) | (1 << 27)\n\t"
        "or x30, x30, t1\n\t"

        "li t3, (1 << 24)\n\t"
        "and %0, x30, t3\n\t"
        "li t3, (1 << 25)\n\t"
        "and %1, x30, t3\n\t"
        "li t3, (1 << 26)\n\t"
        "and %2, x30, t3\n\t"
        "li t3, (1 << 27)\n\t"
        "and %3, x30, t3\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "t3", "x30"
    );
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n",
           Motor1A, Motor1B, Motor2A, Motor2B);
    delay(1400);
}

void stopMovement() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"

        "li t3, (1 << 24)\n\t"
        "and %0, x30, t3\n\t"
        "li t3, (1 << 25)\n\t"
        "and %1, x30, t3\n\t"
        "li t3, (1 << 26)\n\t"
        "and %2, x30, t3\n\t"
        "li t3, (1 << 27)\n\t"
        "and %3, x30, t3\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t3", "x30"
    );
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n",
           Motor1A, Motor1B, Motor2A, Motor2B);
    delay(1400);
}

void delay(long iterations) {
    for (long i = 0; i < iterations; i++) {
        // empty loop for delay simulation
    }
}

```
- ### **Inline Assembly Code Compile and run:**

```
riscv64-unknown-elf-gcc -march=rv64i -mabi=lp64 -ffreestanding -o ./maze.o maze.c
spike pk maze.o
```
<img width="629" height="385" alt="Inlineassembly simulation" src="https://github.com/user-attachments/assets/23c52270-e023-4303-a578-1ad4aff2b07e" />

## Assembly Code generation
**
Make Sure Comment all the lib, printf and Scanf functions. Code should starts with int main ()**

```
//#include <stdio.h>

// ---------------------- Sensor Module ----------------------
// Sensor signals: 0 = low (blocked), 1 = high (clear)
int Sensor1 = 0;  // Left Sensor
int Sensor2 = 0;  // Front Sensor
int Sensor3 = 0;  // Right Sensor
int dist1, dist2, dist3;

#define THRESHOLD 10  // Threshold in cm

// ---------------------- Motor Control ----------------------
int Motor1A = 0, Motor1B = 0, Motor2A = 0, Motor2B = 0;
unsigned int x30 = 0; // Simulate x30 register

void moveForward();
void turnRight();
void turnLeft();
void goBack();
void stopMovement();
void delay(long iterations);
void readSensors(int *dist1, int *dist2, int *dist3);

// ---------------------- Main Logic ----------------------
int main() {
    while(1) {
        // Get distance readings from user input
       // printf("\nEnter distance for Sensor3 (Right): ");
        //scanf("%d", &dist3);
        //printf("Enter distance for Sensor2 (Front): ");
        //scanf("%d", &dist2);
        //printf("Enter distance for Sensor1 (Left): ");
        //scanf("%d", &dist1);

        // Distance > THRESHOLD means path is clear (1), else blocked (0)
        Sensor3 = (dist3 > THRESHOLD) ? 1 : 0;
        Sensor2 = (dist2 > THRESHOLD) ? 1 : 0;
        Sensor1 = (dist1 > THRESHOLD) ? 1 : 0;

       // printf("\nProcessed Signals => Right: %d, Front: %d, Left: %d\n",
         //      Sensor3, Sensor2, Sensor1);

        if (Sensor3 == 1) {
            //printf("Turning Right...\n");
            turnRight();
        } else {
            if (Sensor2 == 1) {
               // printf("Moving Forward...\n");
                moveForward();
            } else if (Sensor1 == 1) {
               // printf("Turning Left...\n");
                turnLeft();
            } else {
               // printf("Going Back...\n");
                goBack();
            }
        }
    }
    return 0;
}

void readSensors(int *dist1, int *dist2, int *dist3)
{
    int d1, d2, d3;
    int clear_mask = 0x0FFFFFFF;

    asm volatile(
        "mv t3, %3\n\t"
        "and t0, x30, t3\n\t"
        "li t4, 0xFF\n\t"
        "and %0, t0, t4\n\t"
        "srli t1, t0, 8\n\t"
        "and %1, t1, t4\n\t"
        "srli t2, t0, 16\n\t"
        "and %2, t2, t4\n\t"
        : "=r"(d1), "=r"(d2), "=r"(d3)
        : "r"(clear_mask)
        : "t0", "t1", "t2", "t3", "t4"
    );

    *dist1 = d1;
    *dist2 = d2;
    *dist3 = d3;

//    printf("dist 1: %2x, dist 2: %2x, dist 3: %2x\n", *dist1, *dist2, *dist3);
}

void moveForward() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"
        "li t1, (1 << 24) | (1 << 26)\n\t"
        "or x30, x30, t1\n\t"

        "li t3, (1 << 24)\n\t"
        "and %0, x30, t3\n\t"
        "li t3, (1 << 25)\n\t"
        "and %1, x30, t3\n\t"
        "li t3, (1 << 26)\n\t"
        "and %2, x30, t3\n\t"
        "li t3, (1 << 27)\n\t"
        "and %3, x30, t3\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "t3", "x30"
    );
//    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n",
  //         Motor1A, Motor1B, Motor2A, Motor2B);
    delay(700);
}

void goBack() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"
        "li t1, (1 << 25) | (1 << 27)\n\t"
        "or x30, x30, t1\n\t"

        "li t3, (1 << 24)\n\t"
        "and %0, x30, t3\n\t"
        "li t3, (1 << 25)\n\t"
        "and %1, x30, t3\n\t"
        "li t3, (1 << 26)\n\t"
        "and %2, x30, t3\n\t"
        "li t3, (1 << 27)\n\t"
        "and %3, x30, t3\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "t3", "x30"
    );
 //   printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n",
   //        Motor1A, Motor1B, Motor2A, Motor2B);
    delay(1400);
}

void turnLeft() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"
        "li t1, (1 << 25) | (1 << 26)\n\t"
        "or x30, x30, t1\n\t"

        "li t3, (1 << 24)\n\t"
        "and %0, x30, t3\n\t"
        "li t3, (1 << 25)\n\t"
        "and %1, x30, t3\n\t"
        "li t3, (1 << 26)\n\t"
        "and %2, x30, t3\n\t"
        "li t3, (1 << 27)\n\t"
        "and %3, x30, t3\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "t3", "x30"
    );
 //   printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n",
   //        Motor1A, Motor1B, Motor2A, Motor2B);
    delay(700);
}

void turnRight() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"
        "li t1, (1 << 24) | (1 << 27)\n\t"
        "or x30, x30, t1\n\t"

        "li t3, (1 << 24)\n\t"
        "and %0, x30, t3\n\t"
        "li t3, (1 << 25)\n\t"
        "and %1, x30, t3\n\t"
        "li t3, (1 << 26)\n\t"
        "and %2, x30, t3\n\t"
        "li t3, (1 << 27)\n\t"
        "and %3, x30, t3\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t1", "t3", "x30"
    );
//    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n",
//           Motor1A, Motor1B, Motor2A, Motor2B);
    delay(1400);
}

void stopMovement() {
    asm volatile(
        "li t0, 0x0FFFFFFF\n\t"
        "and x30, x30, t0\n\t"

        "li t3, (1 << 24)\n\t"
        "and %0, x30, t3\n\t"
        "li t3, (1 << 25)\n\t"
        "and %1, x30, t3\n\t"
        "li t3, (1 << 26)\n\t"
        "and %2, x30, t3\n\t"
        "li t3, (1 << 27)\n\t"
        "and %3, x30, t3\n\t"

        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "t0", "t3", "x30"
    );
  //  printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n",
  //         Motor1A, Motor1B, Motor2A, Motor2B);
    delay(1400);
}

void delay(long iterations) {
    for (long i = 0; i < iterations; i++) {
        // empty loop for delay simulation
    }
}

```
 ```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o maze.o maze.c
riscv64-unknown-elf-objdump -d maze.o | less
```
<img width="751" height="852" alt="Screenshot from 2025-09-15 22-42-39" src="https://github.com/user-attachments/assets/b7ccf409-33dd-4c87-9880-e218c9ba0690" />

## Assembly.txt file generation
```
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -o out maze.c
riscv64-unknown-elf-objdump -d  -r out > maze1.txt
```
```

out:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <main>:
   10074:	ff010113          	addi	sp,sp,-16
   10078:	00112623          	sw	ra,12(sp)
   1007c:	00812423          	sw	s0,8(sp)
   10080:	01010413          	addi	s0,sp,16
   10084:	8201a783          	lw	a5,-2016(gp) # 11430 <dist3>
   10088:	00b7a793          	slti	a5,a5,11
   1008c:	0017c793          	xori	a5,a5,1
   10090:	0ff7f793          	andi	a5,a5,255
   10094:	00078713          	mv	a4,a5
   10098:	80e1a423          	sw	a4,-2040(gp) # 11418 <Sensor3>
   1009c:	8241a783          	lw	a5,-2012(gp) # 11434 <dist2>
   100a0:	00b7a793          	slti	a5,a5,11
   100a4:	0017c793          	xori	a5,a5,1
   100a8:	0ff7f793          	andi	a5,a5,255
   100ac:	00078713          	mv	a4,a5
   100b0:	000117b7          	lui	a5,0x11
   100b4:	40e7aa23          	sw	a4,1044(a5) # 11414 <Sensor2>
   100b8:	8281a783          	lw	a5,-2008(gp) # 11438 <dist1>
   100bc:	00b7a793          	slti	a5,a5,11
   100c0:	0017c793          	xori	a5,a5,1
   100c4:	0ff7f793          	andi	a5,a5,255
   100c8:	00078713          	mv	a4,a5
   100cc:	000117b7          	lui	a5,0x11
   100d0:	40e7a823          	sw	a4,1040(a5) # 11410 <__DATA_BEGIN__>
   100d4:	8081a703          	lw	a4,-2040(gp) # 11418 <Sensor3>
   100d8:	00100793          	li	a5,1
   100dc:	00f71663          	bne	a4,a5,100e8 <main+0x74>
   100e0:	218000ef          	jal	ra,102f8 <turnRight>
   100e4:	fa1ff06f          	j	10084 <main+0x10>
   100e8:	000117b7          	lui	a5,0x11
   100ec:	4147a703          	lw	a4,1044(a5) # 11414 <Sensor2>
   100f0:	00100793          	li	a5,1
   100f4:	00f71663          	bne	a4,a5,10100 <main+0x8c>
   100f8:	0b0000ef          	jal	ra,101a8 <moveForward>
   100fc:	f89ff06f          	j	10084 <main+0x10>
   10100:	000117b7          	lui	a5,0x11
   10104:	4107a703          	lw	a4,1040(a5) # 11410 <__DATA_BEGIN__>
   10108:	00100793          	li	a5,1
   1010c:	00f71663          	bne	a4,a5,10118 <main+0xa4>
   10110:	178000ef          	jal	ra,10288 <turnLeft>
   10114:	f71ff06f          	j	10084 <main+0x10>
   10118:	100000ef          	jal	ra,10218 <goBack>
   1011c:	f69ff06f          	j	10084 <main+0x10>

00010120 <readSensors>:
   10120:	fd010113          	addi	sp,sp,-48
   10124:	02812623          	sw	s0,44(sp)
   10128:	03010413          	addi	s0,sp,48
   1012c:	fca42e23          	sw	a0,-36(s0)
   10130:	fcb42c23          	sw	a1,-40(s0)
   10134:	fcc42a23          	sw	a2,-44(s0)
   10138:	100007b7          	lui	a5,0x10000
   1013c:	fff78793          	addi	a5,a5,-1 # fffffff <__global_pointer$+0xffee3ef>
   10140:	fef42623          	sw	a5,-20(s0)
   10144:	fec42783          	lw	a5,-20(s0)
   10148:	00078e13          	mv	t3,a5
   1014c:	01cf72b3          	and	t0,t5,t3
   10150:	0ff00e93          	li	t4,255
   10154:	01d2f6b3          	and	a3,t0,t4
   10158:	0082d313          	srli	t1,t0,0x8
   1015c:	01d37733          	and	a4,t1,t4
   10160:	0102d393          	srli	t2,t0,0x10
   10164:	01d3f7b3          	and	a5,t2,t4
   10168:	fed42423          	sw	a3,-24(s0)
   1016c:	fee42223          	sw	a4,-28(s0)
   10170:	fef42023          	sw	a5,-32(s0)
   10174:	fdc42783          	lw	a5,-36(s0)
   10178:	fe842703          	lw	a4,-24(s0)
   1017c:	00e7a023          	sw	a4,0(a5)
   10180:	fd842783          	lw	a5,-40(s0)
   10184:	fe442703          	lw	a4,-28(s0)
   10188:	00e7a023          	sw	a4,0(a5)
   1018c:	fd442783          	lw	a5,-44(s0)
   10190:	fe042703          	lw	a4,-32(s0)
   10194:	00e7a023          	sw	a4,0(a5)
   10198:	00000013          	nop
   1019c:	02c12403          	lw	s0,44(sp)
   101a0:	03010113          	addi	sp,sp,48
   101a4:	00008067          	ret

000101a8 <moveForward>:
   101a8:	ff010113          	addi	sp,sp,-16
   101ac:	00112623          	sw	ra,12(sp)
   101b0:	00812423          	sw	s0,8(sp)
   101b4:	01010413          	addi	s0,sp,16
   101b8:	100002b7          	lui	t0,0x10000
   101bc:	fff28293          	addi	t0,t0,-1 # fffffff <__global_pointer$+0xffee3ef>
   101c0:	005f7f33          	and	t5,t5,t0
   101c4:	05000337          	lui	t1,0x5000
   101c8:	006f6f33          	or	t5,t5,t1
   101cc:	01000e37          	lui	t3,0x1000
   101d0:	01cf75b3          	and	a1,t5,t3
   101d4:	02000e37          	lui	t3,0x2000
   101d8:	01cf7633          	and	a2,t5,t3
   101dc:	04000e37          	lui	t3,0x4000
   101e0:	01cf76b3          	and	a3,t5,t3
   101e4:	08000e37          	lui	t3,0x8000
   101e8:	01cf7733          	and	a4,t5,t3
   101ec:	80b1a623          	sw	a1,-2036(gp) # 1141c <Motor1A>
   101f0:	80c1a823          	sw	a2,-2032(gp) # 11420 <Motor1B>
   101f4:	80d1aa23          	sw	a3,-2028(gp) # 11424 <Motor2A>
   101f8:	80e1ac23          	sw	a4,-2024(gp) # 11428 <Motor2B>
   101fc:	2bc00513          	li	a0,700
   10200:	1d0000ef          	jal	ra,103d0 <delay>
   10204:	00000013          	nop
   10208:	00c12083          	lw	ra,12(sp)
   1020c:	00812403          	lw	s0,8(sp)
   10210:	01010113          	addi	sp,sp,16
   10214:	00008067          	ret

00010218 <goBack>:
   10218:	ff010113          	addi	sp,sp,-16
   1021c:	00112623          	sw	ra,12(sp)
   10220:	00812423          	sw	s0,8(sp)
   10224:	01010413          	addi	s0,sp,16
   10228:	100002b7          	lui	t0,0x10000
   1022c:	fff28293          	addi	t0,t0,-1 # fffffff <__global_pointer$+0xffee3ef>
   10230:	005f7f33          	and	t5,t5,t0
   10234:	0a000337          	lui	t1,0xa000
   10238:	006f6f33          	or	t5,t5,t1
   1023c:	01000e37          	lui	t3,0x1000
   10240:	01cf75b3          	and	a1,t5,t3
   10244:	02000e37          	lui	t3,0x2000
   10248:	01cf7633          	and	a2,t5,t3
   1024c:	04000e37          	lui	t3,0x4000
   10250:	01cf76b3          	and	a3,t5,t3
   10254:	08000e37          	lui	t3,0x8000
   10258:	01cf7733          	and	a4,t5,t3
   1025c:	80b1a623          	sw	a1,-2036(gp) # 1141c <Motor1A>
   10260:	80c1a823          	sw	a2,-2032(gp) # 11420 <Motor1B>
   10264:	80d1aa23          	sw	a3,-2028(gp) # 11424 <Motor2A>
   10268:	80e1ac23          	sw	a4,-2024(gp) # 11428 <Motor2B>
   1026c:	57800513          	li	a0,1400
   10270:	160000ef          	jal	ra,103d0 <delay>
   10274:	00000013          	nop
   10278:	00c12083          	lw	ra,12(sp)
   1027c:	00812403          	lw	s0,8(sp)
   10280:	01010113          	addi	sp,sp,16
   10284:	00008067          	ret

00010288 <turnLeft>:
   10288:	ff010113          	addi	sp,sp,-16
   1028c:	00112623          	sw	ra,12(sp)
   10290:	00812423          	sw	s0,8(sp)
   10294:	01010413          	addi	s0,sp,16
   10298:	100002b7          	lui	t0,0x10000
   1029c:	fff28293          	addi	t0,t0,-1 # fffffff <__global_pointer$+0xffee3ef>
   102a0:	005f7f33          	and	t5,t5,t0
   102a4:	06000337          	lui	t1,0x6000
   102a8:	006f6f33          	or	t5,t5,t1
   102ac:	01000e37          	lui	t3,0x1000
   102b0:	01cf75b3          	and	a1,t5,t3
   102b4:	02000e37          	lui	t3,0x2000
   102b8:	01cf7633          	and	a2,t5,t3
   102bc:	04000e37          	lui	t3,0x4000
   102c0:	01cf76b3          	and	a3,t5,t3
   102c4:	08000e37          	lui	t3,0x8000
   102c8:	01cf7733          	and	a4,t5,t3
   102cc:	80b1a623          	sw	a1,-2036(gp) # 1141c <Motor1A>
   102d0:	80c1a823          	sw	a2,-2032(gp) # 11420 <Motor1B>
   102d4:	80d1aa23          	sw	a3,-2028(gp) # 11424 <Motor2A>
   102d8:	80e1ac23          	sw	a4,-2024(gp) # 11428 <Motor2B>
   102dc:	2bc00513          	li	a0,700
   102e0:	0f0000ef          	jal	ra,103d0 <delay>
   102e4:	00000013          	nop
   102e8:	00c12083          	lw	ra,12(sp)
   102ec:	00812403          	lw	s0,8(sp)
   102f0:	01010113          	addi	sp,sp,16
   102f4:	00008067          	ret

000102f8 <turnRight>:
   102f8:	ff010113          	addi	sp,sp,-16
   102fc:	00112623          	sw	ra,12(sp)
   10300:	00812423          	sw	s0,8(sp)
   10304:	01010413          	addi	s0,sp,16
   10308:	100002b7          	lui	t0,0x10000
   1030c:	fff28293          	addi	t0,t0,-1 # fffffff <__global_pointer$+0xffee3ef>
   10310:	005f7f33          	and	t5,t5,t0
   10314:	09000337          	lui	t1,0x9000
   10318:	006f6f33          	or	t5,t5,t1
   1031c:	01000e37          	lui	t3,0x1000
   10320:	01cf75b3          	and	a1,t5,t3
   10324:	02000e37          	lui	t3,0x2000
   10328:	01cf7633          	and	a2,t5,t3
   1032c:	04000e37          	lui	t3,0x4000
   10330:	01cf76b3          	and	a3,t5,t3
   10334:	08000e37          	lui	t3,0x8000
   10338:	01cf7733          	and	a4,t5,t3
   1033c:	80b1a623          	sw	a1,-2036(gp) # 1141c <Motor1A>
   10340:	80c1a823          	sw	a2,-2032(gp) # 11420 <Motor1B>
   10344:	80d1aa23          	sw	a3,-2028(gp) # 11424 <Motor2A>
   10348:	80e1ac23          	sw	a4,-2024(gp) # 11428 <Motor2B>
   1034c:	57800513          	li	a0,1400
   10350:	080000ef          	jal	ra,103d0 <delay>
   10354:	00000013          	nop
   10358:	00c12083          	lw	ra,12(sp)
   1035c:	00812403          	lw	s0,8(sp)
   10360:	01010113          	addi	sp,sp,16
   10364:	00008067          	ret

00010368 <stopMovement>:
   10368:	ff010113          	addi	sp,sp,-16
   1036c:	00112623          	sw	ra,12(sp)
   10370:	00812423          	sw	s0,8(sp)
   10374:	01010413          	addi	s0,sp,16
   10378:	100002b7          	lui	t0,0x10000
   1037c:	fff28293          	addi	t0,t0,-1 # fffffff <__global_pointer$+0xffee3ef>
   10380:	005f7f33          	and	t5,t5,t0
   10384:	01000e37          	lui	t3,0x1000
   10388:	01cf75b3          	and	a1,t5,t3
   1038c:	02000e37          	lui	t3,0x2000
   10390:	01cf7633          	and	a2,t5,t3
   10394:	04000e37          	lui	t3,0x4000
   10398:	01cf76b3          	and	a3,t5,t3
   1039c:	08000e37          	lui	t3,0x8000
   103a0:	01cf7733          	and	a4,t5,t3
   103a4:	80b1a623          	sw	a1,-2036(gp) # 1141c <Motor1A>
   103a8:	80c1a823          	sw	a2,-2032(gp) # 11420 <Motor1B>
   103ac:	80d1aa23          	sw	a3,-2028(gp) # 11424 <Motor2A>
   103b0:	80e1ac23          	sw	a4,-2024(gp) # 11428 <Motor2B>
   103b4:	57800513          	li	a0,1400
   103b8:	018000ef          	jal	ra,103d0 <delay>
   103bc:	00000013          	nop
   103c0:	00c12083          	lw	ra,12(sp)
   103c4:	00812403          	lw	s0,8(sp)
   103c8:	01010113          	addi	sp,sp,16
   103cc:	00008067          	ret

000103d0 <delay>:
   103d0:	fd010113          	addi	sp,sp,-48
   103d4:	02812623          	sw	s0,44(sp)
   103d8:	03010413          	addi	s0,sp,48
   103dc:	fca42e23          	sw	a0,-36(s0)
   103e0:	fe042623          	sw	zero,-20(s0)
   103e4:	0100006f          	j	103f4 <delay+0x24>
   103e8:	fec42783          	lw	a5,-20(s0)
   103ec:	00178793          	addi	a5,a5,1
   103f0:	fef42623          	sw	a5,-20(s0)
   103f4:	fec42703          	lw	a4,-20(s0)
   103f8:	fdc42783          	lw	a5,-36(s0)
   103fc:	fef746e3          	blt	a4,a5,103e8 <delay+0x18>
   10400:	00000013          	nop
   10404:	02c12403          	lw	s0,44(sp)
   10408:	03010113          	addi	sp,sp,48
   1040c:	00008067          	ret
```

```
# Creating Custom VSD FPGA based RISC-V Processor for Autonomous Navigation System
## Unique Instruction
I have run the python scripts in terminal to get the unique instruction (Reference:https://github.com/BhattSoham/RISCV-HDP/blob/main/week3/script.py). Note the .txt should on the same the folder where youa re running the script
+ python script.py (if its not supported use the below command)
+ python3 script.py
+ Number of different instructions:**     **
+ List of unique instructions:
```
```
```
### Pesudo Instruction Equivalent Command
```
li, mv = ADDI 
j, ret = JAL 
beqz = beq  
bnez = bne

```
### RISC V Custom Core Configuration (.json)
```
```
### RISCV RTL Core and Testbench Generation
Refer the GITHUB to installl the toolchain
https://github.com/Chipcron-Pvt-Ltd/Chipcron-toolchain/tree/main

![WhatsApp Image 2025-09-23 at 8 40 50 PM](https://github.com/user-attachments/assets/0bb303bb-e61f-494d-82c5-32f1ee21db09)


## GPIO Configuration
### Register architecture of x30 for GPIOs

+ Input Signals - Sensor1, Sensor2, Sensor3;
+ Output Signals -  Motor1A, Motor1B, Motor2A, Motor2B;
+ Number of Register bits Required - 28
+ Register bits allocations are given below

+ x30 [23:0] is Sensor -  Sensor 1 - x30[7:0]; Sensor 2 - x30[15:8]; Sensor 3 - x30[23:16];   // Input - Read
+ x30 [25:24] is e1 & e2 - e1 x30 [24] ; e2 x30 [25] ;  // Output Write  Motor1A = 2^24 =167777216  Motor1B = 2^25 = 33554432
+ x30 [27:26] is d1 & d2 - d1 x30 [26] ; d2 x30 [27] ;  // Output Write  Motor2A = 2^26 =67108864  Motor2B = 2^27 =134217728

 #### GPIO Configuration in Verilog File
```
    module wrapper(clk,resetn,uart_rxd,uart_rx_en,uart_rx_break,uart_rx_valid,uart_rx_data, Motor1A,Motor1B,Motor2A,Motor2B, Sensors, write_done, instructions);
    input wire [23:0] Sensors;
    output reg Motor1A,Motor1B,Motor2A,Motor2B;


    output_pins = {22'b0,top_gpio_pins[27:26],top_gpio_pins[25:24],Sensors} ; 
    Motor1A= top_gpio_pins[24]; 
    Motor1B= top_gpio_pins[25]; 
    Motor2A= top_gpio_pins[26]; 
    Motor2B= top_gpio_pins[27];
```
### Do the necessary changes in the Testbench file. 
I have given 8 possible input sensor combination.    

## iverilog Simulation

```
iverilog -o maze_v testbench.v processor.v
vvp maze_v
or
./maze_v
```
![UART Verification and VCD File generation](https://github.com/eceelango/RISC-V_HDP/assets/65966247/a96bd709-9168-4845-bbce-5593b4c728ae)

It will generate the VCD file (30.6 GB) in the folder. Click the file GTK wave window will open and drag and drop the signal you may see the output

# UART Bypass
+ In Testbench file comment all the @(posedge slow_clk);write_instruction(32'h00000000). Because, the instruction is already written in the memory when we give ASIC "false" in .json file. It is generated for FPGA platform.
+ Make sure in Processor.v under wrapper module -  **writing_inst_done=1;**
+ If we bypass UART, it will generate the VCD file is with memory of 100 MB

  ## Commands to do iverilog Simulation
```
iverilog -o maze1_v testbench1.v processor1.v
vvp maze1_v
or
./maze1_v
```
![VCD_Uartbyepass](https://github.com/eceelango/RISC-V_HDP/assets/65966247/27d7249f-79ed-4399-9ee3-69ab2fa84f7e)

+ Click on generated VCD file GTKwave will open and select the DUT and corresponding Signals to view the output

  ![GTKwave](https://github.com/eceelango/RISC-V_HDP/assets/65966247/3a3871f9-51a4-4e78-916c-096ea77a78ff)
