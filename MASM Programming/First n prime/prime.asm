
;PROGRAM TO FIND FIRT N PRIME NUMBERS
;====================================

.model small
.stack 100H
.data
msg1 db 'enter the limit   : $'
newline db 10,13, '$'
num dw ?
limit dw ?

.code
.startup   

	MOV DX,offset msg1  ; Enter the limit
	CALL printmsg
	CALL readnum
	MOV limit,AX
	
	MOV CX,0
	MOV num,1
	CALL nprime


.exit
nprime PROC near
loop3:	INC num
	CALL isprime
	CMP BL,0
	JE loop3
	MOV AX,num
	CALL displayAX
	MOV DX,offset newline 
	CALL printmsg 
	INC CX
	CMP CX,limit
	JNE loop3
RET
nprime ENDP

isprime PROC near uses CX
MOV BL,1
CMP num,2
JE prime
MOV CL,2
MOV CH,0
l1:	MOV AX,num
	DIV CL
	CMP AH,0
	JE notprime
	INC CL
	CMP CX,num
	JL l1
prime:	RET
notprime:MOV BL,0
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
	
;displayAX procedure displays AX in decimal
	displayAX PROC near
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX        ; Save registers

	MOV CX,0	;count <--0
	MOV BX,10

	Back2:
		MOV DX,0
		DIV BX      ; digit = num%10 
		PUSH DX	  ; num=num/10 push digit 
		INC CX    ; count = count+1
		CMP AX,0  ; if num>0 goto back2
		JNE Back2
	Back3:
		POP DX		;pop digit
		ADD DL,30H    ; convert to ascii
		MOV AH,02H    ; display
		INT 21H
		loop Back3


		POP DX  ; Restore registers
		POP CX
		POP BX
		POP AX


	RET
	displayAX ENDP

END
