# Moving Block Program

A small interactive program for a 6502 breadboard computer that uses interrupts and LCD output to visually move a block character across the screen. The block shifts one position to the left each time a button is pressed, creating a simple but effective demonstration of interrupt-driven input and direct hardware control.

## 🎬 Program Behavior
- Displays the static message: `"moving block:"` on the first line of a 16x2 character LCD.
- A full-block character (`0xFF`) appears on the second line.
- Each button press moves the block one position to the left.
- When the block reaches position 0, it wraps back to position 15.

<video src="./demonstration-video.mp4" controls autoplay loop style="max-width: 100%; height: auto;"></video>

## 🔍 Program Logic Breakdown
- **Initialization:**
  - Configures the VIA to trigger an interrupt on button press.
  - Initializes the LCD with a standard 8-bit, 2-line mode.
  - Sets the block's initial position to the rightmost character (15).

- **Main Loop:**
  - Waits 100 ms using a software delay.
  - Clears the second line.
  - Sets the LCD cursor to the current block position.
  - Prints the block character (`0xFF`).

- **Interrupt Routine:**
  - On button press, decreases the block position.
  - If it reaches 0, wraps it back to 15.

## 🧾 File Contents
- `main.asm` – 6502 Assembly source code.
- `main.bin` – Assembled binary for EEPROM flashing.
- `demonstration_video.mp4` – Demo of the program on real hardware.

## 🔧 Hardware Overview
- **CPU:** WDC 65C02  
- **I/O:** 65C22 VIA  
- **LCD:** 16x2 character display  
- **Clock:** 1 MHz fixed-frequency module  
- **Button Input:** Connected to VIA CA1 (interrupt line)

## 📍 Memory Map
- `PORTA = $6001` – LCD Control Lines (RS, RW, E)  
- `PORTB = $6000` – LCD Data Lines  
- `DDRA  = $6003`, `DDRB = $6002` – Data Direction Registers  
- `PCR   = $600C` – VIA edge trigger setup  
- `IFR   = $600D`, `IER = $600E` – VIA interrupt flags/control  
- `box_index = $0216` – Tracks current block position

## 💾 Flashing to EEPROM
1. Assemble using `vasm`:
   ```bash
   vasm6502_oldstyle -Fbin -dotdir -o main.bin main.asm
   ```
2. Write `main.bin` to a 28C256 EEPROM using a programmer (e.g. TL866II+).
3. Insert EEPROM into the 6502 system and power it up.

## 🧠 Notes
- The program runs from address `$8000` with vectors defined at `$FFFA–$FFFF`.
- Delay loop timing may vary slightly depending on component tolerances.

## 🙌 Contributions
Improvements and experiments are welcome. Feel free to fork and build on this!

