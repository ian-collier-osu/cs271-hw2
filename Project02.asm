TITLE Fibonacci Calculator    (Project02.asm)

; Author: Ian Collier
; Course / Project ID:   CS271 / Project #2             Date: 01/20/2019
; Description: An iterative Fibonacci number calculator

INCLUDE Irvine32.inc

; Constants

; Limits
UPPER_FIB_LIMIT = 47
LOWER_FIB_LIMIT = 1

.data

; Variables

; Text
intro1		BYTE	"Welcome to Fibonacci Calculator (made by Ian Collier).",0
greet1		BYTE	"Give me your name: ",0
greet2		BYTE	"Hello ",0
intro2		BYTE	"You will enter the amount of Fibonacci terms to show (between 1-46).",0
prompt1		BYTE	"How many Fibonacci numbers?: ",0
err1		BYTE	"Number must be between 1 and 46.",0
bye1		BYTE	"Goodbye ",0

; Input variables
userName	BYTE	33 DUP(0)	; User name string
fibAmount	DWORD	?			; Amount of Fib nums to calc


.code
main PROC

; introduction
	; Print title of program
	mov		edx,OFFSET intro1
	call	WriteString
	call	Crlf
	call	Crlf

	; Print the name prompt
	mov		edx,OFFSET greet1
	call	WriteString

	; Get the name prompt input
	mov		edx, OFFSET userName
	mov		ecx, 32
	call	 ReadString

	; Print the greeting and name user entered
	mov		edx,OFFSET greet2
	call	WriteString
	mov		edx,OFFSET userName
	call	WriteString
	call	Crlf
	call	Crlf

; userInstructions
	; Print the instructions
	mov		edx,OFFSET intro2
	call	WriteString
	call	Crlf
	call	Crlf

; getUserData

	; Loop while getting input until input is valid
	getUserDataLoop:

		; Print the number prompt
		mov		edx,OFFSET prompt1
		call	WriteString

		; Get the number prompt input
		call	ReadInt
		mov		fibAmount, eax
		call	Crlf

		; If < low limit go to error
		mov		eax, fibAmount
		cmp		eax, LOWER_FIB_LIMIT
		jl		getUserDataErr

		; If > upper limit go to error
		mov		eax, fibAmount
		cmp		eax, UPPER_FIB_LIMIT
		jg		getUserDataErr

		; Else break loop
		jmp displayFibs

		; Print error and jump back
		getUserDataErr:
		mov		edx,OFFSET err1
		call	WriteString
		call	Crlf
		jmp getUserDataLoop

; displayFibs

	displayFibs:
	
	mov		ecx,fibAmount	; Set loop counter
	mov		eax,0			; Sum (printed)
	mov		ebx,0			; First num
	mov		edx,1			; Second num

	; Calculation loop
	fibLoop:
		mov		eax, ebx	; Add both numbers together
		add		eax, edx	
		mov		ebx, edx	; Move the first number to the second number spot
		mov		edx, eax	; Move the sum to the second number spot
		call	WriteDec
		call	Crlf
		loop	fibLoop


; farewell
	; Print the goodbye and user name
	call	Crlf
	mov		edx,OFFSET bye1
	call	WriteString
	mov		edx,OFFSET userName
	call	WriteString
	call	Crlf

	; Exit to OS
	exit
main ENDP

END main
