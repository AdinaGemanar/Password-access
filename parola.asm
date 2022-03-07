
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

jmp start

text DB 1000 DUP(?)  
pwd DB 'parola', '$'
message DB 'Introduceti parola', 0dh, 0ah, '$'
message2 DB 'Parola gresita!', 0dh, 0ah, '$'  
message3 DB 'Parola corecta!', 0dh, 0ah, '$'

printf MACRO str                   ;citim sirul din macro ;inputing a string 
    mov dx, offset str
    mov ah, 9                ;afisare caracter
    int 21h
printf ENDM


start:
printf message
mov si, offset text 
mov cx, 6 

et:
mov ah, 0                    ;read a key
int 16h                    ; in acest moment codul citit este in al
cmp al, 0dh                  ;compara cu enter
jz et2
mov [si], al          ;muta in sirul gol ce este la al

inc si
mov ah, 0eh            ;face automat mutarea
                    ;contorizam nr de caractere
int 10h                  ;call the video service
jmp et
et2: 
xor al,al                     ;fac 0 registrul
mov si, offset text 
mov di, offset pwd
mov al, [si]
cmp al, [di] 
jnz incorect
inc si
inc di
dec cx
cmp cx, 0
jz corect
jnz et2 
   
incorect: 
mov ah, 2 
mov dh, 3 ;linie noua 
int 10h
printf message2   
jmp stop  

corect:
mov ah, 2 
mov dh, 3 ;linie noua 
int 10h
printf message3 
jmp stop  
   
   
   stop:
ret




