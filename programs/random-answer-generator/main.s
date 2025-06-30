PORTB = $6000 
PORTA = $6001 
DDRB = $6002
DDRA = $6003
PCR = $600c
IFR = $600d
IER = $600e

counter       = $0200  ; 2 bytes
message       = $0202  ; 16 bytes (output buffer)
rand_seed     = $0213  ; 1 byte
ascii_buffer  = $0214  ; 2 bytes
remainder     = $021B  ; 1 byte

E  = %10000000
RW = %01000000
RS = %00100000

    .org $8000

reset:
    ldx #$ff
    txs

    cli

    lda #$82
    sta IER
    lda #$00
    sta PCR

    lda #%11111111
    sta DDRB

    lda #%11100000
    sta DDRA

    lda #%00111000
    jsr lcd_instruction

    lda #%00001110
    jsr lcd_instruction

    lda #%00000110
    jsr lcd_instruction

    lda #%00000001
    jsr lcd_instruction

    lda #$AC
    sta rand_seed

    lda #0
    sta counter
    sta counter + 1

loop:    
    jsr delay_500ms

    lda #%00000001
    jsr lcd_instruction

    jsr increment_counter
    jsr convert

    ldx #0
print_counter_loop:
    lda message,x
    beq counter_done
    jsr print_char
    inx
    jmp print_counter_loop
counter_done:

    lda #%00100000
    jsr print_char

    jsr generate_random_bit
    cmp #1
    beq print_true
    jmp print_false

    jmp loop

increment_counter:
    lda counter
    clc
    adc #1
    sta counter
    lda counter + 1
    adc #0
    sta counter + 1
    rts

print_true:
    ldx #0
print_true_loop:
    lda true,x
    beq end_print
    jsr print_char
    inx
    jmp print_true_loop

print_false:
    ldx #0
print_false_loop:
    lda false,x
    beq end_print
    jsr print_char
    inx
    jmp print_false_loop

end_print:
    jmp loop

true: .asciiz "true"
false: .asciiz "false"

convert:
    lda #0
    sta message

    lda counter
    sta ascii_buffer
    lda counter+1
    sta ascii_buffer+1

convert_next_digit:
    lda #0
    sta remainder
    sta remainder+1

    ldx #16
convert_divloop:
    rol ascii_buffer
    rol ascii_buffer+1
    rol remainder

    sec
    lda remainder
    sbc #10
    tay
    lda remainder+1
    sbc #0
    bcc convert_skip_subtract

    sty remainder
    sta remainder+1

convert_skip_subtract:
    dex
    bne convert_divloop

    rol ascii_buffer
    rol ascii_buffer+1

    lda remainder
    clc
    adc #'0'
    jsr push_char

    lda ascii_buffer
    ora ascii_buffer+1
    bne convert_next_digit

    rts

push_char:
    pha
    ldy #0
char_loop:
    lda message,y
    tax
    pla
    sta message,y
    iny
    txa
    pha
    bne char_loop

    pla
    sta message,y
    rts

lcd_wait:
    pha
    lda #%00000000
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
    lda #%11111111
    sta DDRB
    pla
    rts

lcd_instruction:
    jsr lcd_wait
    sta PORTB

    lda #0
    sta PORTA

    lda #E
    sta PORTA

    lda #0
    sta PORTA
    rts

print_char:
    jsr lcd_wait
    sta PORTB

    lda #RS
    sta PORTA

    lda #(RS | E)
    sta PORTA

    lda #RS
    sta PORTA
    rts

generate_random_bit:
    lda rand_seed
    lsr
    bcc no_xor
    eor #$B8
no_xor:
    sta rand_seed
    and #$01
    rts

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

delay_200ms:
    jsr delay_100ms
    jsr delay_100ms
    rts

delay_500ms:
    jsr delay_200ms
    jsr delay_200ms
    jsr delay_100ms
    rts

    .org $fffa
    .word 0
    .word reset
    .word 0

