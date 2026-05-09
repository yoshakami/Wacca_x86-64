; ================== (1) - asm source code =======================
; v6 at 140498d10 in dissassembly => assemble

mov qword [rsp+0x58], rdi
mov qword [rsp+0x60], r14
mov qword [rsp+0x30], r15
db 0x0f, 0x29, 0x74, 0x24, 0x20 ; movaps xmmword [rsp+0x20], xmm6
mov rax, qword [rbx+0x28]
mov     r15d, 0x1
cmp byte [rax+0xc3], 0x0   ; if song.beginnerRecommended == 0 
je skipBeginner  ; skip call
db 0x45,0x8D,0x4F,0xFE   ; lea r9d,[r15-2] ; set  r9d to 0xffffffff which means all diffs together
mov r8, rbx
xor edx, edx
mov rcx, rsi
db 0xE8, 0x48, 0x72, 0x00, 0x00 ; call putChartInBin
mov rax, qword [rbx+0x28]
skipBeginner:
cmp dword [rax+0x08], 3999
jg SkipCall                         ; If ID > 3999 (0xF9F), jump to SkipCall
db 0x45,0x8D,0x4F,0xFE   ; lea r9d,[r15-2] ; set  r9d to 0xffffffff which means all diffs together
mov r8,rbx
mov edx, 0x2
mov rcx,rsi
db 0xE8, 0x27, 0x72, 0x00, 0x00 ; call putChartInBin
mov     rax, qword [rbx+0x28]
SkipCall:
movzx   edx, byte [rax+0xCA]   ; get second column of TrainingLevel
mov     [rbx+0x50], edx        ; 0 = mission for all diff, 1 = starting from hard, 2 = expert, 
movzx   edx, byte [rax+0xC8]   ; get second column of bCollaboration
mov     [rbx+0x54], edx ; put that in SugorokuBonus. 0 = disabled, 1, 2, 3 are the 3 levels
cmp byte [rax+0xbf],0  ; check bValidCulture_h_Hans_CN_GeneralMember <= if true, set song to new, if false, jump
db 0x74,0x25             ; je +0x25
db 0x45,0x8D,0x4F,0xFE   ; lea r9d,[r15-2]
mov r8,rbx
mov edx,r15d
mov rcx,rsi
db 0xE8, 0xF4, 0x71, 0x00, 0x00 ; call putChartInBin
mov ebp,r15d   ; set song to new
mov [rbx+0x44],r15b  ; set song to new
mov dword [rbx+0x45],0x01010101
mov     rax, qword [rbx+0x28]
times 11 db 0x90