
;PROGRAM TO FIND FIRT N FIBANACCI SERIES NUMBERS
;===============================================

.model small
.stack 100H
.data
msg1 db 'enter the number of number to print : $'


newline db 10,13, '$'

limit dw ?

.code
.startup   

	MOV DX,offset msg1  	
	CALL printmsg			
	CALL readnum
	MOV limit,AX
	
	CALL fiba					


.exit
fiba PROC near
MOV AX,0
MOV BX,1
MOV CX,0
loop3:				
	CALL displayAX
	MOV DX,offset newline
	CALL printmsg
	DEC limit
	MOV CX,BX
	ADD BX,AX
	MOV AX,CX					
	CMP limit,0					
	JNE loop3
		
RET
fiba ENDP



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













