# 6502 Breadboard Computer

This is a fully functional 8-bit computer built on a breadboard using the WDC 65C02 microprocessor. The architecture is based on the educational project by [Ben Eater](https://eater.net/6502), with several modifications to component placement and minor hardware differences. The system includes key components such as RAM, EEPROM, a 65C22 VIA for I/O and interrupts, and a character LCD display.

All software is written manually in 6502 assembly language. Two programs are currently implemented on the machine:

## ▶️ Programs

### 1. Moving Block (Interrupt-Driven)
- Uses hardware interrupts triggered by a button press.  
- Displays a block character on the LCD that moves each time the button is pressed.  
- Demonstrates the use of the VIA chip for handling interrupts and memory-mapped I/O.

### 2. Random Answer Generator
- Implements a pseudo-random number generator using a manual seed.  
- Outputs randomly generated boolean answers ("TRUE" or "FALSE") to the LCD one by one.  
- Runs continuously, showing a new result at each iteration.

## 🔧 Hardware Overview
- **CPU:** WDC 65C02  
- **RAM:** 62256 (32KB SRAM)  
- **EEPROM:** 28C256  
- **I/O:** 65C22 VIA (connected to buttons and LCD)  
- **Display:** 16x2 Character LCD  
- **Clock:** 1 MHz fixed-frequency clock module  
- **Other:** Standard reset circuit and address decoding logic

## 📚 Reference
The core design and learning path for this project are based on [Ben Eater’s 6502 computer series](https://eater.net/6502), with custom programs and minor hardware adjustments.

## 🚧 Project Status

This project is **actively under development**. More features and programs — including games — are planned for future updates.  
Contributions, suggestions, and collaborations are welcome! Feel free to open an issue or pull request if you'd like to participate.
