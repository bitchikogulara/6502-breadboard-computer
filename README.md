# 6502 Breadboard Computer

This is a fully functional 8-bit computer built on a breadboard using the WDC 65C02 microprocessor. The architecture is based on the educational project by [Ben Eater](https://eater.net/6502), with several modifications to component placement and minor hardware differences. The system includes key components such as RAM, EEPROM, a 65C22 VIA for I/O and interrupts, and a character LCD display.

All software is written manually in 6502 assembly language. Two demonstration programs are currently implemented.

### Computer Preview

![demonstration-photo](https://github.com/user-attachments/assets/787cb8e2-7d50-4fe1-a5c3-96663480793b)

## ▶️ Programs

### [Moving Block (Interrupt-Driven)](./programs/moving-block/README.md)
- Displays the message `"moving block:"` on the first line of the LCD.
- A block character (`0xFF`) is displayed on the second line.
- Each button press triggers an interrupt that moves the block to the left.
- Demonstrates interrupt handling, VIA configuration, and real-time display updates.

### [Random Answer Generator](./programs/random-answer-generator/README.md)
- Displays a 16-bit counter that increments continuously.
- Generates and displays random "true" or "false" values based on a pseudo-random LFSR algorithm.
- Updates every 500 ms, showcasing text formatting and control logic.

## 📁 Project Structure
```
6502-breadboard-computer/
├── README.md                       # Main project overview
├── SETUP.md                        # Hardware setup and wiring guide
├── eeprom/                         # EEPROM programming instructions
│   └── how_to_program.md
└── programs/
    ├── moving-block/
    │   ├── main.s
    │   ├── main.bin
    │   └── README.md
    └── random-answer-generator/
        ├── main.s
        ├── main.bin
        └── README.md
```

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
