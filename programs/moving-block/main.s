PORTB = $6000 
PORTA = $6001 
DDRB = $6002 ; Data Direction Register for Port B
DDRA = $6003 ; Data Direction Register for Port A
PCR = $600c ; Peripheral Control Register
IFR = $600d ; Interrupt Flag Register
IER = $600e ; Interrupt Enable Register

box_index = $0216 ; 1 byte

E  = %10000000
RW = %01000000
RS = %00100000

    .org $8000

reset:
    ldx #$ff ; Point stack pointer at the end of the stack
    txs

    cli ; Enable interrupts (clear interrupt disable flag)

    lda #$82
    sta IER ; Enable interrupts
    lda #$00
    sta PCR ; Clear Peripheral Control Register

    lda #%11111111 ; Set all pins on port B to output
    sta DDRB

    lda #%11100000 ; Set top 3 bits of port A to output
    sta DDRA

    lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
    jsr lcd_instruction

    lda #%00001110 ; Display on; cursor on; blink on
    jsr lcd_instruction

    lda #%00000110 ; Increment and shift cursor; don't shift display
    jsr lcd_instruction

    lda #%00000001 ; Clear display
    jsr lcd_instruction

    lda #15 ; reset the box index
    sta box_index

loop:    
    jsr delay_100ms ; Wait for 100 ms

    lda #%00000010 ; Set cursor to home position
    jsr lcd_instruction

    ldx #0
print_ln1:
    lda text, x
    beq print_ln2
    jsr print_char
    inx
    jmp print_ln1

print_ln2:
    lda #$C0 ; Start of second line
    jsr clear_ln
    
    lda box_index ; Set cursor position to second line
    ora #$C0 
    jsr lcd_instruction

    lda #$ff ; Print the box character
    jsr print_char 
    jmp loop
    
clear_ln:
    tay             ; Copy starting cursor position to Y
    ldx #16         ; 16 characters per line
clear_loop:
    tya
    jsr lcd_instruction
    lda #$20        ; ASCII space
    jsr print_char
    iny             ; Next position
    dex
    bne clear_loop
    rts

text: .asciiz "moving block:" ; Text to be displayed on the first line

lcd_wait: ; Wait for the LCD to be ready
    pha
    lda #%00000000 ; set all pins of port B to input
    sta DDRB
lcd_busy:
    lda #RW
    sta PORTA
    lda #(RW | E)
    sta PORTA
    lda PORTB
    and #%10000000
    bne lcd_busy

    lda #RW
    sta PORTA
    lda #%11111111 ; set all pins of port B back to output
    sta DDRB
    pla
    rts

lcd_instruction: ; Send an instruction to the LCD
    jsr lcd_wait
    sta PORTB

    lda #0         ; Clear RS/RW/E bits
    sta PORTA

    lda #E         ; Set Enable pin to send instruction
    sta PORTA

    lda #0         ; Clear RS/RW/E bits
    sta PORTA
    rts

print_char: ; Send a character to the LCD
    jsr lcd_wait
    sta PORTB

    lda #RS
    sta PORTA

    lda #(RS | E)
    sta PORTA

    lda #RS
    sta PORTA
    rts

; start of DELAY routines

delay_50ms:
    ldy #$81
    ldx #$81
delay_loop:
    dex
    bne delay_loop
    dey
    bne delay_loop
    rts

delay_100ms:
    jsr delay_50ms
    jsr delay_50ms
    rts

; end of DELAY routines

nmi:
irq:
    pha 
    tya
    pha 
    txa
    pha

    lda box_index
    cmp #0
    beq reset_box_index
    dec box_index
    jmp exit_interrupt

reset_box_index:
    lda #15
    sta box_index 
exit_interrupt:
    jsr delay_100ms
    bit PORTA
    pla 
    tax
    pla
    tay
    pla
    rti

    .org $fffa
    .word nmi
    .word reset
    .word irq

