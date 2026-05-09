; ============================ (2) - asm source code ==========================
; at 140498fb0 until 0x140499164 (do not touch xxx164)

movzx   edx, byte [rax+0xc9]   ; edx = bWaccaOriginal
test    edx, edx               ; set flags based on edx
je      skipCall               ; jump if zero (ZF=1)
cmp edx, 61
ja  skipCall   ; jump if greater than 61
mov     r9d, 0xffffffff
mov     r8,  rbx
mov     rcx, rsi
    call    0x14049FF90       ; call PutChartInBin?
skipCall:
mov     rax, qword [rbx+0x28]
movzx   edx, byte [rax+0x174]   ; edx = bingo6
test    edx, edx               ; set flags based on edx
je      skipCall2               ; jump if zero (ZF=1)
cmp edx, 61
ja  skipCall2   ; jump if greater than 61
mov     r9d, 0x00
mov     r8,  rbx
mov     rcx, rsi
    call    0x14049FF90       ; call PutChartInBin?
skipCall2:
mov     rax, qword [rbx+0x28]
movzx   edx, byte [rax+0x178]   ; edx = bingo7
test    edx, edx               ; set flags based on edx
je      skipCall3               ; jump if zero (ZF=1)
cmp edx, 61
ja  skipCall3   ; jump if greater than 61
mov     r9d, 0x01
mov     r8,  rbx
mov     rcx, rsi
    call    0x14049FF90       ; call PutChartInBin?
skipCall3:
mov     rax, qword [rbx+0x28]
movzx   edx, byte [rax+0x17c]   ; edx = bingo8
test    edx, edx               ; set flags based on edx
je      skipCall4               ; jump if zero (ZF=1)
cmp edx, 61
ja  skipCall4   ; jump if greater than 61
mov     r9d, 0x02
mov     r8,  rbx
mov     rcx, rsi
    call    0x14049FF90       ; call PutChartInBin?
skipCall4:
mov     rax, qword [rbx+0x28]
movzx   edx, byte [rax+0x180]   ; edx = bingo9
test    edx, edx               ; set flags based on edx
je      skipCall5               ; jump if zero (ZF=1)
cmp edx, 61
ja  skipCall5   ; jump if greater than 61
mov     r9d, 0x03
mov     r8,  rbx
mov     rcx, rsi
    call    0x14049FF90       ; call PutChartInBin?
skipCall5:
mov     rax, qword [rbx+0x28]
mov rcx, [rax+0x30]   ; RCX = FString.Data - CopyrightMessage
test rcx, rcx
je skipCall6
xor eax, eax           ; result = 0
.copyright_loop:
    movzx edx, word [rcx]  ; UTF-16 char
    test edx, edx
    jz .copy_done
    sub edx, '0'
    cmp edx, 9
    ja .copy_done
    imul eax, eax, 10
    add eax, edx
    add rcx, 2
    jmp .copyright_loop
.copy_done:
mov edx, eax
test    edx, edx               ; set flags based on edx
je      skipCall6               ; jump if zero (ZF=1)
cmp edx, 61
ja  skipCall6   ; jump if greater than 61
mov     r9d, 0xffffffff
mov r8, rbx
mov rcx, rsi
    call    0x14049FF90       ; call PutChartInBin?
skipCall6:
mov     rax, qword [rbx+0x28]
mov rcx, [rax+0xe0]   ; RCX = FString.Data  - HashTag
test rcx, rcx
je skipCall7
xor eax, eax           ; result = 0
.parse_loop:
    movzx edx, word [rcx]  ; UTF-16 char
    test edx, edx
    jz .done
    sub edx, '0'
    cmp edx, 9
    ja .done
    imul eax, eax, 10
    add eax, edx
    add rcx, 2
    jmp .parse_loop
.done:
mov edx, eax
test    edx, edx               ; set flags based on edx
je      skipCall7               ; jump if zero (ZF=1)
cmp edx, 61
ja  skipCall7   ; jump if greater than 61
mov r9d, 0xffffffff
mov r8, rbx
mov rcx, rsi
    call    0x14049FF90       ; call PutChartInBin?
skipCall7:
mov     rax, qword [rbx+0x28]
movzx   edx, byte [rax+0x188]   ; edx = WorkBuffer
test    edx, edx               ; set flags based on edx
je      skipCall8               ; jump if zero (ZF=1)
cmp edx, 61
ja  skipCall8   ; jump if greater than 61
mov     r9d, 0xffffffff
mov     r8,  rbx
mov     rcx, rsi
    call    0x14049FF90       ; call PutChartInBin?
skipCall8:
; --- 1. FILTER CHECK (Check UniqueID once) ---
mov rax, qword [rbx+0x28] ; rax = Parameters
test rax, rax             ; Safety check
jz skipSong                ; If null, skip to epilogue
cmp dword [rax+0x8], 0xf9f
jg skipSong                ; If ID > 0xf9f, skip to epilogue

; --- 2. LOOP INIT ---
xor ebp, ebp              ; difficulty = 0
xor edi, edi              ; index = 0

; --- 3. LOOP START ---
loopStart:
mov rax, qword [rbx+0xa8] ; rax = BestClearType.buf
mov ecx, dword [rdi+rax]  ; ecx = Clear Type value

; --- 4. MAP CATEGORY (The optimized switch) ---
cmp ecx, 0x4
ja default_cat            ; If > 4, goto default (0x37)
lea edx, [rcx+0x38]       ; edx = ecx + 0x38 (Handles 0,1,2,3,4)
jmp setup_call

default_cat:
mov edx, 0x37             ; Clear_NotPlay

setup_call:
; --- 5. EXECUTE CALL ---
mov r9d, ebp              ; Arg 4: difficulty
mov r8, rbx               ; Arg 3: song
mov rcx, rsi              ; Arg 1: scene
                                                          ; Arg 2 (edx) is already set!
sub rsp, 0x20             ; Shadow space! (Stack is already aligned)
    call    0x14049FF90       ; call PutChartInBin?
add rsp, 0x20             ; Clean up shadow space

; --- 6. LOOP INCREMENT & CHECK ---
inc ebp                   ; difficulty += 1
add rdi, 0x4              ; index += 4
cmp rdi, 0xc
jle loopStart           ; Loop back if <= 12

; --- 7. CLEANUP (PAD WITH NOPs to 1C7) ---
times 2 nop
skipSong:
