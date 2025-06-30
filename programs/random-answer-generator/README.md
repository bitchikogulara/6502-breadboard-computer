# Random Answer Generator

This program runs on a 6502 breadboard computer and generates a stream of random boolean answers ("true" or "false") displayed on an LCD. It also includes an incrementing counter to demonstrate pseudo-random number generation and basic formatted output in 6502 assembly.

## 🎬 Program Behavior
- Increments and displays a 16-bit counter value.
- Displays a randomly selected answer: `"true"` or `"false"` next to the counter.
- Updates every 500 milliseconds continuously.
- Randomness is based on a simple linear feedback shift register (LFSR) seeded at startup.

<video src="https://github.com/user-attachments/assets/f94e536d-e639-4f13-84b2-596dc40401b0" controls autoplay loop style="max-width: 100%; height: auto;"></video>

## 🔍 Program Logic Breakdown

- **Counter:**  
  A 16-bit counter increments each cycle and is converted into ASCII for display using a binary-to-decimal conversion routine.
  
- **Random Generator:**  
  A simple 8-bit LFSR algorithm using an XOR mask (`$B8`) generates pseudo-random bits. Each loop, a new bit is used to decide between `"true"` or `"false"`.

- **Display Logic:**  
  - The LCD is cleared each loop.
  - The current counter value is printed.
  - A space is inserted.
  - The randomly selected word is printed using pre-defined `.asciiz` strings.

## 🧾 File Contents

- `main.s` – 6502 Assembly source code.
- `main.bin` – Compiled binary for EEPROM.

## 🔧 Hardware Overview

- **CPU:** WDC 65C02  
- **I/O:** 65C22 VIA  
- **LCD:** 16x2 character display  
- **Clock:** 1 MHz fixed module

## 📍 Memory Map

- `PORTA = $6001` – LCD Control (RS, RW, E)  
- `PORTB = $6000` – LCD Data  
- `DDRA  = $6003`, `DDRB = $6002` – Data Direction Registers  
- `rand_seed = $0213` – Current seed for LFSR  
- `counter = $0200` – 16-bit counter (low/high)  
- `message = $0202` – Output buffer  
- `ascii_buffer = $0214` – Working space for conversion  
- `remainder = $021B` – Temporary modulo storage for conversion

## 💾 Flashing to EEPROM

See the [EEPROM Programming Guide](../../eeprom/how_to_program.md) for instructions on assembling and flashing programs using your EEPROM programmer.

## 🧠 Notes

- Program runs from `$8000`, with vectors at `$FFFA–$FFFF`.
- Delay is implemented with software loops, approximating 500 ms.
- You can change the random seed (`$AC` by default) for different sequences.

## 🙌 Contributions

This is a self-contained demo of randomness and text formatting on a 6502 machine. Feel free to fork and explore new ideas!
