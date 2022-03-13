format ELF64
public _start

section '.bss' writable
	bss_char rb 1

section '.data' writable
	new_line equ 0xA
	end_line equ 0
	msg db "hello, world!", new_line, end_line

section '.text' executable
_start:
	mov rax, 500
	call print_int
	;call print_char
	call exit

section '.print_int' executable
print_int:
	
	push rax
	push rbx
	push rcx
	push rdx

	xor rcx, rcx

	.iter:
		cmp rax, 0
		je .print_iter
		mov rbx, 10
		xor rdx, rdx
		div rbx
		add rdx, 48
		push rdx

		inc rcx
		jmp .iter

	.print_iter:
		cmp rcx, 0
		je .close
		pop rax
		call print_char

		dec rcx
		jmp .print_iter

	.close:
		pop rdx
		pop rcx
		pop rbx
		pop rax
		ret

	ret  

section '.print_char' executable
print_char:
	push rax

	mov [bss_char], al

	mov rax, 1
	mov rdi, 1
	mov rsi, bss_char
	mov rdx, 1
	syscall

	pop rax
	ret

section '.exit' executable
exit:
	mov rax, 1
	xor rbx, rbx
	int 0x80