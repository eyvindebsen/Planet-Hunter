!-https://www.atarimagazines.com/compute/issue72/random_numbers.php
*=$c000
        ;init
        lda #$ff  ; maximum frequency value
        sta $d40e ; voice 3 frequency low byte
        sta $d40f ; voice 3 frequency high byte
        lda #$80  ; noise waveform, gate bit off
        sta $d412 ; voice 3 control register
        rts

        ;fill a screen       
        ldx #0
lop1
        lda $d41b
        and #15
        cmp #15
        beq lop1        ; discard false data
        tay
        lda sdata,y
m1      sta $0400,x
        inc m1+2
        lda m1+2
        cmp #08
        bne lop1
        lda #04         ;set routine back to screen start
        sta m1+2
        inx
        bne lop1
        rts

sdata byte "ijku ijku ijku "
