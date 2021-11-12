.386

.model flat, stdcall

includelib msvcrt.lib
extern exit: proc
extern scanf: proc
extern sscanf: proc
extern printf: proc
extern gets: proc 

.data
    expresie DB 200 dup(0)
	m_expresie db "Introduce an expression: ", 0
	;sir_nr dd 100 dup(0)
	;sir_op db 100 dup(0)
	x dd 0
	y dd 0
	operator1 dd 0 ;+(43), -(45),  =(61)
	operator2 dd 0 
	rezultat dd 0
	format_expr db "%d%c%d%c", 0 	
	format_rezultat db "%d", 10, 0
   
	format DB "%d", 0
	format_o db "%c", 0
	sir db "exit"
 
.code
suma proc 
	push EBP  ;base pointer for the current stack frame; push-add operands on the stack
	mov EBP, ESP    ;transfers data between two registers
	
	mov EAX, [EBP+8] ;moves the address 8 bytes.
	add EAX, [EBP+12]
	
	mov ESP, EBP
	pop ebp      ;restoring whatever is on top of the stack into a register
	ret 8    ;transfers control to the return address located on the stack
suma endp

diferenta proc 
	push EBP    
	mov EBP, ESP   ;esp addresses the stack 
	
	mov EAX, [EBP+8]    ;eax keeps one operand and afterwards the result
	sub EAX, [EBP+12]
	
	mov ESP, EBP
	pop ebp
	ret 8
diferenta endp



	start:

	
	push offset m_expresie 
	call printf 
	add esp, 4
	
	
	introducere_expr:
	push offset operator2 
	push offset y
	push offset operator1
	push offset x
	push offset format_expr
	call scanf
	add esp, 20
	
operatii:
     cmp operator1, 43  ;compare the two operands; operator +
	 jz adun        ;jump if zero
	 
	 cmp operator1, 45    ;operator -
	 jz scad
	 
	 
 

adun:	
	push y
	push x
	call suma
	cmp operator2, 61      ;operator = 
    je afisare_rezultat   ;if and only if equal


scad:	
	push y
	push x
	call diferenta
	
	cmp operator2, 61
    je afisare_rezultat
	


afisare_rezultat:
     push EAX
	 push offset format_rezultat
	 call printf
	 ADD ESP, 8 
     jmp sf 	 
	
	sf:
	push 0
	call exit
	end start