
;PROGRAM TO FIND IF THE GIVEN NUMBER IS PRIME OR NOT
;===================================================

.model small
.stack 100H
.data
msg1 db 'enter the number   : $'

msg2 db 'Not a prime $'
msg3 db 'Is a prime $'
newline db 10,13, '$'
num dw ?

.code
.startup   


	MOV DX,offset newline 
	CALL printmsg 
	MOV DX,offset msg1  ; Enter the numbers
	CALL printmsg
	CALL readnum
	MOV num,AX
	CALL isprime
.exit


isprime PROC near
MOV BL,1
CMP num,2
JE output2
MOV CL,2
MOV CH,0
l1:	MOV AX,num
	DIV CL
	CMP AH,0
	JE output1
	INC CL
	CMP CX,num
	JL l1
output2:MOV DX,offset msg3
	CALL printmsg
	RET
output1:MOV BL,0
	MOV DX,offset msg2
	CALL printmsg
	RET
isprime ENDP

;this will display a message pointed by DX register
printmsg PROC near
PUSH AX
MOV AH,09H
INT 21H
POP AX
RET
printmsg ENDP

;readnum reads a decimal number from the keyboard
;and returns it through AX


	readnum PROC near
	PUSH BX
	PUSH CX         ; Save registers
	MOV BX,0        ; NUM <--0
	MOV CX,10

	Back1:
		MOV AH,01H  ; read a single character
		INT 21H
		CMP AL,'0'
		JB last1
		CMP AL,'9'
		JA last1
		SUB AL,30H   ; convert to digit
		PUSH AX       
		MOV AX,BX
		MUL CX       
		MOV BX,AX    ; NUM <-- NUM x 10
		POP AX
		MOV AH,0
		ADD BX,AX    ; NUM <-- NUM + digit
		JMP Back1

	last1:
		MOV AX,BX
		POP CX      ; Restore registers
		POP BX
		RET
	readnum ENDP
END













