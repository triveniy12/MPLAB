MODEL SMALL

DISPLAY1 MACRO MSG
        LEA DX, MSG
        MOV AH, 09H
        INT 21H
ENDM



.DATA

LIST DB 0H, 3H, 4H, 5H, 7H, 8H
NUMBER EQU ($-LIST)                 ;#define NUMBER 6

KEY DB 7H

MSG1 DB 0DH, 0AH, "ELEMENTFOUND IN LIST...$"
MSG2 DB 0DH, 0AH, "SEARCH FAILED !!$"

.CODE

START : MOV AX, @DATA
        MOV DS, AX


        MOV CH, NUMBER-1
        MOV CL, 00H


AGAIN:  MOV SI, OFFSET LIST
        XOR AX, AX
        CMP CL, CH
        JE NEXT
        JNC FAILED


NEXT:   MOV AL, CL
        ADD AL, CH
        SHR AL, 01H
        MOV BL, AL
        XOR AH, AH
        MOV BP, AX
        MOV AL, DS:[BP][SI]
        CMP AL, KEY
        JE SUCCESS
        JC INCLOW

        MOV CH, BL
        DEC CH
        JMP AGAIN

INCLOW: MOV CL, BL
        INC CL
        JMP AGAIN


SUCCESS:MOV AL, KEY
        ADD AL, 30H

        MOV DL, AL
        MOV AH, 02H
        INT 21H

        DISPLAY1 MSG1
        JMP FINAL

FAILED: MOV AL, KEY
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 02H
        INT 21H

        DISPLAY1 MSG2

FINAL:  MOV AH, 01H
        INT 21H

        MOV AH, 4CH
        INT 21H

END START
