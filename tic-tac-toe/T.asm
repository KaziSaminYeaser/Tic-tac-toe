.Model Small

print macro x, y, attrib, sdat
LOCAL   s_dcl, skip_dcl, s_dcl_end
    push ax
    push bx
    push cx
    push dx
    mov dx, cs
    mov es, dx
    mov ah, 13h
    mov al, 1
    mov bh, 0
    mov bl, attrib
    mov cx, offset s_dcl_end - offset s_dcl
    mov dl, x
    mov dh, y
    mov bp, offset s_dcl
    int 10h
    pop dx
    pop cx
    pop bx
    pop ax
    jmp skip_dcl
    s_dcl DB sdat
    s_dcl_end DB 0
    skip_dcl:    
endm

draw_row Macro x,y,z
    Local l1
; draws a line in row x from col 10 to col 300
    MOV AH, 0CH
    MOV AL, 1
    MOV CX, y
    MOV DX, x
L1: INT 10h
    INC CX
    CMP CX, z
    JL L1
    EndM
    
    
    
draw_col Macro x1,y1,z1
    Local l2
; draws a line col y from row 10 to row 189
    MOV AH, 0CH
    MOV AL, 1
    MOV CX, x1
    MOV DX, y1
L2: INT 10h
    INC DX
    CMP DX, z1
    JL L2
    EndM
    
draw_cross1 Macro x,y,z
    Local L2
    MOV AH, 0CH
    MOV AL, 1
    MOV CX, y
    MOV DX, x
L2: INT 10h
    INC DX
    add CX,1
    CMP DX, z
    JL L2
    int 10h
    EndM
    
    
draw_cross2 Macro x,y,z
    Local L2
    MOV AH, 0CH
    MOV AL, 1
    MOV CX, y
    MOV DX, x
L2: INT 10h
    DEC DX
    INC CX
    CMP DX, z
    JG L2
    int 10h
    EndM

    
clear_screen macro
    Local l3
    ; pusha
 L3:
    mov ax, 0600h
    mov bh, 00001111b
    mov cx, 0
    mov dh, 24
    mov dl, 79
    int 10h 
    mov ah,2
    
    ; popa
    ENDM
    

    
print_ax Macro x
local print_ax_r,pn_done
    mov ax,x
    mov ax,0
    jne print_ax_r
    push ax
    mov al, '0'
    mov ah, 0eh
    int 10h
    pop ax
    ret 
print_ax_r:
    mov dx, 0
    cmp ax, 0
    je pn_done
    mov bx, 10
    div bx    
    call print_ax_r
    mov ax, dx
    add al, 30h
    mov ah, 0eh
    int 10h    
    jmp pn_done
pn_done:
    ret  
endm


 

.Stack 100h

.Data
    a dw 0
    b dw 0
    c dw 0
    d dw 0
    e dw 0
    x dw ?
    y dw ?
    z dw ?
    Saad dw 0
    Pranto dw 0
    a1 dw 0
    a2 dw 0
    a3 dw 0
    b1 dw 0
    b2 dw 0
    b3 dw 0
    c1 dw 0
    c2 dw 0
    c3 dw 0
    crossx dw ?
    crossy dw ?
    crosstemp dw ?
    curx dw 0
    cury dw 0
    curb dw 0
    sum dw 0
    flag dw 0
.Code

initializer proc
    mov a,0
    mov b,0
    mov c,0
    mov d,0
    mov e,0
    mov x,0
    mov y,0
    mov z,0
    mov a1,0
    mov a2,0
    mov a3,0
    mov b1,0
    mov b2,0
    mov b3,0
    mov c1,0
    mov c2,0
    mov c3,0
    mov crossx,0
    mov crossy,0
    mov crosstemp,0
    mov curx,0
    mov cury,0
    mov curb,0
    mov sum,0
    mov flag,0
    
initializer endp


tictact proc

    push ax
    push bx
    push cx
    push dx

form1:
    mov bx,a1
    cmp bx,0
    je form4
    cmp a2,bx
    je case1
form2:
    cmp bx,b1
    je case2
form3:
    cmp bx,b2
    je case7
form4:
    mov bx,b2
    cmp bx,0
    je form7
    cmp bx,b1
    je case3
form5:
    cmp bx,a2
    je case4 
form6:
    cmp bx,a3
    je case8
form7:
    mov bx,c3
    cmp bx,0
    je false
    cmp bx,c2
    je case5
form8:
    cmp bx,b3
    je case6
    jmp false
case1:
    cmp a3,bx
    je final
    jmp form2
case2:
    cmp c1,bx
    je final
    jmp form3
case3:
    cmp b3,bx
    je final
    jmp form5
case4:
    cmp c2,bx
    je final
    jmp form6
case5:
    cmp bx,c1
    je final
    jmp form8
case6:
    cmp bx,a3
    je final
    jmp false
case7:               
    cmp bx,c3
    je final
    jmp form4
case8:
    cmp bx,c1
    je final
    jmp form7
final:
    ;cmp bx,0
    ;je false
    mov flag,bx
    jmp sht
false:
    mov flag,0
sht:
    mov ax,flag
    ;  call print_axx
    pop dx
    pop cx
    pop bx
    pop ax
    ret
endp tictact

cheacker proc

    push ax
    push bx
    push cx
    push dx
    
    call find_point
    mov ax,z
    ; call print_axx
    cmp z,1
    jE la1
    cmp z,2
    jE la2
    cmp z,3
    jE la3111
    cmp z,4
    jE lb1111
    cmp z,5
    jE lb2111
    cmp z,6
    jE lb3111
    cmp z,7
    jE lc1111
    cmp z,8
    jE lc2111
    cmp z,9
    jE lbbbbb
        
la1:
    cmp a1,0
    JNE TTT
    inc sum
    push ax
    mov ax,sum
    and ax,1
    cmp ax,1
    ;pop ax
   jne la111
   pop ax
    mov a1,1
    JMP lbbbb 
la111:
   pop ax
    mov a1,2
   jmp lbbbb
la3111:
    jmp la3 
lb1111:
    jmp lb1
lb2111:
    jmp lb2
lb3111:
    jmp lb3
lc1111:
    jmp lc1
lc2111:
    jmp lc2 
lbbbbb:
    JMP lc3 
la2:
    cmp a2,0
TTT:
    JNE lbbbb
    inc sum
    push ax
    mov ax,sum
    and ax,1
    cmp ax,1
    jne la211
    pop ax
    mov a2,1
    JMP lbbbb
la211:
    pop ax
    mov a2,2
    jmp lbbbb
la3:
    cmp a3,0
    JNE lbbbb
    inc sum
    push ax
    mov ax,sum
    and ax,1
    cmp ax,1
    jne la311
    pop ax
    mov a3,1
    JMP lbbbb
lbbbb:
    JMP abc
la311:
    pop ax
    mov a3,2
    jmp lbbbb
lb1:
    cmp b1,0
    JNE tempppp
    inc sum
    push ax
    mov ax,sum
    and ax,1
    cmp ax,1
    jne lb111
    pop ax
    mov b1,1
    JMP abc

lb111:
   pop ax
    mov b1,2
    jmp abc

lc3111:


lb2:
    cmp b2,0
    JNE tempppp
    inc sum
    push ax
    mov ax,sum
    and ax,1
    cmp ax,1
    jne lb211
    pop ax
    mov b2,1
    JMP abc
lb211:
    pop ax
    mov b2,2
    jmp abc
lb3:
    cmp b3,0
    JNE tempppp
    inc sum
    push ax
    mov ax,sum
    and ax,1
    cmp ax,1
    jne lb311
    pop ax
    mov b3,1
    JMP abc
lb311:
    pop ax
    mov b3,2
tempppp:
    jmp abc
lc1:
    cmp c1,0
    JNE abc
    inc sum
    push ax
    mov ax,sum
    and ax,1
    cmp ax,1
    jne lc111
    pop ax
    mov c1,1
    JMP abc
lc111:
    pop ax
    mov c1,2
    jmp abc
lc2:
    cmp c2,0
    JNE abc
    inc sum
    push ax
    mov ax,sum
    and ax,1
    cmp ax,1
    jne lc211
    pop ax
    mov c2,1
    JMP abc
lc211:
    pop ax
    mov c2,2
    jmp abc
lc3:
    cmp c3,0
    JNE abc
    inc sum
    push ax
    mov ax,sum
    and ax,1
    cmp ax,1
    jne lc311
    pop ax    
    mov c3,1
    JMP abc
lc311:
    pop ax
    mov c3,2
    jmp abc
abc:
   ; mov ax,a1
   ; call print_axx
   ; mov ax,a2
   ; call print_axx
   ; mov ax,a3
   ; call print_axx    
   ; mov ax,b1
   ; call print_axx    
   ; mov ax,b2
   ; call print_axx    
   ; mov ax,b3
   ; call print_axx
   ; mov ax,c1
   ; call print_axx
   ; mov ax,c2
   ; call print_axx
   ; mov ax,c3
   ; call  


    pop dx
    pop cx
    pop bx
    pop ax
    ret
cheacker endp



find_point proc
    push ax
    push bx
    push cx
    push dx
    mov ax,crossx
    mov y,ax
    mov ax,crossy
    mov x,ax
    
    cmp x,70
    jl row1
    cmp x,110
    jl row2
    jmp row3
row1:
    cmp y,83
    jl room1
    cmp y,116
    jl room2
    jmp room3
row2:
    cmp y,83
    jl room4
    cmp y,116
    jl room5
    jmp room6
row3:
    cmp y,83
    jl room7
    cmp y,116
    jl room8
    jmp room9
room1:
    mov z,1
    jmp fff
    ;ret
room2:
    mov z,2
    jmp fff
    ;ret
room3:
    mov z,3
    jmp fff
    ;ret
room4:
    mov z,4
    jmp fff
    ;ret
room5:
    mov z,5
    jmp fff
    ;ret
room6:
    mov z,6
    jmp fff
    ;ret
room7:
    mov z,7
    jmp fff
    ;ret
room8:
    mov z,8
    jmp fff
    ;ret
room9:
    mov z,9
    jmp fff
fff:
    ;mov ax,z
    ; call print_axx
    pop dx
    pop cx
    pop bx
    pop ax
    ret
find_point endp




draw_circle proc
    push ax
    push bx
    push cx
    push dx
    
  mov ax,crossy
  mov bx,crossx
  mov a,ax
  mov b,bx
  add ax,4
  add bx,13
  mov d,ax
  mov c,bx
    
    dec a
    inc b
    dec c
    ;dec c
    draw_col a,b,c
    dec a
    inc b
    ;dec c
    dec c
    draw_col a,b,c
    dec a
    inc b
    ; dec c
    dec c
    draw_col a,b,c
    add c,3
    sub b,3
    add a,3
    
    
    
this1:   
    draw_col a,b,c
    inc a
    mov bx,a
    cmp d,bx
    jge this1
    draw_col a,b,c
    inc a
    inc b
    dec c
    ;dec c
    draw_col a,b,c
    inc a
    inc b
    ;dec c
    dec c
    draw_col a,b,c
    inc a
    inc b
    ; dec c
    dec c
    draw_col a,b,c
    add c,3
    add b,3
    sub a,3
    
    
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
draw_circle endp





print_axx proc
cmp ax, 0
jne print_axx_r
    push ax
    mov al,'0'
    mov ah, 0eh
    int 10h
    pop ax
    ret 
print_axx_r:
    push ax
    push bx
    push cx
    push dx
    mov dx, 0
    cmp ax, 0
    je pnn_done
    mov bx, 10
    div bx    
    call print_axx_r
    mov ax, dx
    add al, 30h
    mov ah, 0eh
    int 10h    
    jmp pnn_done
pnn_done:

    pop dx
    pop cx
    pop bx
    pop ax  
    ret  
print_axx endp




draw_cross Proc
  ;  mov ax,crossx
  ;  mov bx,crossy
  push ax
  push bx
  push cx
  push dx

  ;CALL draw_circle
    mov cx,crossx
   sub crossx,5
   sub crossy,5
   add cx,6
   mov crosstemp,cx
   ;mov ax,crossx
   ;call print_axx
    
    ;mov ax,crossy
    ;call print_axx
  ;  mov ax,crossx
  ; mov crosstemp,ax
  ; inc crosstemp
  ;draw_row crossx,crossy,crossx
   draw_cross1 crossx,crossy,crosstemp
   draw_cross2 crosstemp,crossy,crossx
    ;call bal
   pop dx
   pop cx
   pop bx
   pop ax
    ret
draw_cross endp

    

set_display_mode Proc
   ; mov dx,a
; sets display mode and draws boundary
   ; MOV AH, 0
   ; MOV AL, 04h; 320x200 4 color
   ; INT 10h
; select palette    
   ; MOV AH, 0BH
   ;  MOV BH, 3
   ; MOV BL, 3
   ;    INT 10h
; set bgd color
    MOV BH, 0
    MOV BL, 16; cyan
    INT 10h
    print 5,2,00101011b," TIC TAC TOE "
    print 21,6,00101011b,"PRANTO "
    cmp pranto,0
    JNe p00
    print 28,6,00101010b,"0"
    jmp p01    
p00:    
    mov ax,PRANTO
    Call print_Axx
p01:
    print 29,6,00101011b,":"
    cmp saad,0
    JNE S00
    print 30,6,00101010b,"0"
    jmp s01
s00:
    mov ax,SAAD    
    Call print_Axx
s01:
    print 31,6,00101011b," SAAD"
    
     mov ax,sum
     ;call print_axx
    ; mov ax,e
    ; call print_axx
    
     ;mov ax,crossy
     ;call print_axx
     ;call bal
  ;   call cheacker
     mov ax,crossx
     mov cx,crossx
    mov ax,a1
    ;call print_axx
    mov ax,a2
    ; call print_axx
    mov ax,a3
    ; call print_axx    
    mov ax,b1
    ; call print_axx    
    mov ax,b2
    ; call print_axx    
    mov ax,b3
    ;call print_axx
    mov ax,c1
    ;call print_axx
    mov ax,c2
    ;call print_axx
    mov ax,c3
    ;call print_axx
    
    
    cmp a1,0
    je la11
    mov crossy,51
    mov crossx,64
    cmp a1,1
    jne na11
    call draw_cross
    jmp la11
na11:
    mov crossy,48
    mov crossx,59
    call draw_circle 
la11:
    cmp a2,0
    je la21
    mov crossy,51
    mov crossx,99
    cmp a2,1
    jne na21
    call draw_cross
    jmp la21
na21:
    mov crossy,48
    mov crossx,94
    call draw_circle  
la21:
    cmp a3,0
    je la31
    mov crossy,51
    mov crossx,133
    cmp a3,1
    jne na31
    call draw_cross
    jmp la31
na31:
    mov crossy,48
    mov crossx,128
    call draw_circle 
la31:
    cmp b1,0
    je lb11
    mov crossy,90
    mov crossx,64
    cmp b1,1
    jne nb11
    call draw_cross
    jmp lb11
nb11:
    mov crossy,87
    mov crossx,59
    call draw_circle 
lb11:
    cmp b2,0
    je lb21
    mov crossy,90
    mov crossx,99
    cmp b2,1
    jne nb21
    call draw_cross 
    jmp lb21
nb21:
    mov crossy,87
    mov crossx,94
    call draw_circle 
lb21:
    cmp b3,0
    je lb31
    mov crossy,90
    mov crossx,133
    cmp b3,1
    jne nb31
    call draw_cross
    jmp lb31
nb31:
    mov crossy,87
    mov crossx,128
    call draw_circle 
lb31:
    cmp c1,0
    je lc11
    mov crossy,126
    mov crossx,64
    cmp c1,1
    jne nc11
    call draw_cross
    jmp lc11
nc11:
    mov crossy,123
    mov crossx,59
    call draw_circle 
lc11:
    cmp c2,0
    je lc21
    mov crossy,126
    mov crossx,99
    cmp c2,1
    jne nc21
    call draw_cross
    jmp lc21
nc21:
    mov crossy,123
    mov crossx,94
    call draw_circle 
lc21:
    cmp c3,0
    je lc31
    mov crossy,126
    mov crossx,133
    cmp c3,1
    jne nc31
    call draw_cross
    jmp lc31
nc31:
    mov crossy,123
    mov crossx,128
    call draw_circle 
lc31:
    call tictact
    
nnn:
    mov crossx,ax
    mov crossy,bx
    draw_row 10,10,310
    draw_row 189,10,310
    draw_col 10,10,189
    draw_col 310,10,189
    draw_row 83,35,145
    draw_row 116,35,145
    draw_col 70,50,150
    draw_col 110,50,150
    ; draw_cross1 103,96 ,115
    ; draw_cross2 115,96 ,103
    ;draw_cross 100,100
    mov ax,crossy
    mov crossy,ax
    ; call print_axx
    mov ax,crossx
    ;call print_axx
    


    RET
set_display_mode EndP


set_display_mode2 Proc
   ; mov dx,a
; sets display mode and draws boundary
    MOV AH, 0
    MOV AL, 04h; 320x200 4 color
    INT 10h
; select palette    
    MOV AH, 0BH
    MOV BH, 3
    MOV BL, 3
    INT 10h
    RET
set_display_mode2 EndP

set_display_mode3 Proc
   ; mov dx,a
; sets display mode and draws boundary
    MOV AH, 0
    MOV AL, 04h; 320x200 4 color
    INT 10h
; select palette    
    MOV AH, 0BH
    MOV BH, 3
    MOV BL, 3
    INT 10h
    MOV BH, 0
    MOV BL, 16; cyan
    INT 10h
    print 12,7,00101001b,"Arigato :) :)"
    RET
set_display_mode3 EndP



decider proc
   push ax
   push bx
   push cx
   push dx
   cmp flag,1
   JE P1
   cmp flag,2
   JE P2
   cmp sum,9
   JE P1P2
   JMP MMMM
P1:
    Call player1win
    jmp mmmm
P2:
    Call player2win
    jmp mmmm
P1P2:
    call itsadraw
    jmp mmmm
MMMM:

   pop dx
   pop cx
   pop bx
   pop ax
   ret
decider endp 

player1win proc
    inc PRANTO
  ;  mov ax,pranto
  ;  call print_axx
    push ax
    push bx
    push cx
    push dx
    
    ;MOV AH, 0
    ; MOV AL, 04h; 320x200 4 color
    ; INT 10h
; select palette
;okk:    
  ;  MOV AH, 0BH
  ;  MOV BH, 3
  ;  MOV BL, 3
  ;     INT 10h
; set bgd color
  ;  MOV BH, 0
  ;  MOV BL, 16; cyan
  ;  INT 10h


    mov ax, 0
    int 33h


;clear_screen
    ; CALL set_display_mode2
okk:
   ; CALL set_display_mode
   print 15,21,01101011b,"Right click to continue "
   jmp i21
i22:
    jmp okk
i21:
   print 15,19,1101011b,"click Both to exit"
    jmp bkk
akk:
    jmp i22
bkk:
    print 20,10,00101111b,"Pranto got lucky"
    mov ax, 1
    int 33h  
    ;   clear_screen
;okk:
    mov ax, 3
    int 33h
    mov ax,bx
    ;call print_axx
    cmp bx,2
    je jj
    cmp bx,3
    jne akk
    ;clear_screen
    call set_display_mode3
    mov ah,4ch
    int 21h
    
jj:
    pop dx
    pop cx
    pop bx
    pop ax
    
    ret
player1win endp


player2win proc
    inc SAAD
    push ax
    push bx
    push cx
    push dx
    
    ; MOV AH, 0
    ; MOV AL, 04h; 320x200 4 color
    ; INT 10h
; select palette
;okk:    
  ;  MOV AH, 0BH
  ;   MOV BH, 3
  ;  MOV BL, 3
  ;    INT 10h
; set bgd color
  ;  MOV BH, 0
    ;  MOV BL, 16; cyan
    ; INT 10h


    mov ax, 0
    int 33h


;clear_screen
okkkkk:
    ;CALL set_display_mode
    print 15,21,01101011b,"Right click to continue "
    jmp ck9
ck99:
    jmp okkkkk
ck9:
    print 15,19,1101011b,"click Both to exit"
    jmp ckk
bkkk:
    jmp ck99
ckk:
    print  20,10,00110011b,"!!Winner!! Saad"
    mov ax, 1
    int 33h  
    ;   clear_screen
;okk:
    mov ax, 3
    int 33h
    mov ax,bx
    ;call print_axx
    cmp bx,2
    je i1
    cmp bx,3
    jne bkkk
    ;clear_screen
    call set_display_mode3
    mov ah,4ch
    int 21h
i1:
    pop dx
    pop cx
    pop bx
    pop ax
    
    ret
player2win endp

itsadraw proc
    push ax
    push bx
    push cx
    push dx
    
    ; MOV AH, 0
    ; MOV AL, 04h; 320x200 4 color
    ;INT 10h
; select palette
;okk:    
   ; MOV AH, 0BH
   ; MOV BH, 3
   ; MOV BL, 3
   ;   INT 10h
; set bgd color
   ; MOV BH, 0
   ; MOV BL, 16; cyan
   ; INT 10h


    mov ax, 0
    int 33h


;clear_screen
okkkk:
    ;CALL set_display_mode
   print 15,21,01101011b,"Click both to exit"
   jmp adfff
aaaaa:
    jmp okkkk
adfff:
print 15,19,01101011b,"Right click to continue"
   jmp asdf
asd:
    jmp aaaaa
asdf:
print 20,10,00110011b,"Ohh!! It's a draw"
    mov ax, 1
    int 33h  
    ;   clear_screen
;okk:
    mov ax,3
    int 33h
    mov ax,bx
    ;call print_axx
    cmp bx,2
    je ll
    cmp bx,3
    jne asd
   ; clear_screen
   call set_display_mode3
    mov ah,4ch
    int 21h
ll:
    pop dx
    pop cx
    pop bx
    pop ax
    
    ret
itsadraw endp

firstpage2 proc
    MOV AH, 0
    MOV AL, 04h; 320x200 4 color
    INT 10h
; select palette
;okk:    
    MOV AH, 0BH
    MOV BH, 3
    MOV BL, 3
       INT 10h
; set bgd color
    MOV BH, 0
    MOV BL, 16; cyan
    INT 10h


    mov ax, 0
    int 33h


;clear_screen
okkk:
    print 7,7,00101011b,"Right click to play"
    mov ax, 1
    int 33h  
    ;   clear_screen
;okk:
    mov ax, 3
    int 33h
   ; mov ax,bx
    ;call print_axx
    cmp bx,2
    jne okkk
    ret
firstpage2 endp

firstpage proc
    MOV AH, 0
    MOV AL, 04h; 320x200 4 color
    INT 10h
; select palette
;okk:    
    MOV AH, 0BH
    MOV BH, 3
    MOV BL, 3
    INT 10h
; set bgd color
    MOV BH, 0
    MOV BL, 16; cyan
    INT 10h


    mov ax, 0
    int 33h


;clear_screen
okkk1:
    ;print 7,7,00101011b," Right click to play "
    mov ax, 1
    int 33h  
    ;   clear_screen
    print 12,6,00101101b, "TIC TAC TOE"
    jmp line3
line2:
    jmp okkk1
line3:
    print 15,10,00101101b, "Play"
    jmp line5
line4:
    jmp line2
line5:
    print 8,17,00101011b, "(Right click to play)"
    mov ax, 3
    int 33h
    ;mov ax,dx
    ;call print_axx
    cmp bx,2
    je exit2
    cmp bx,3
    jne line4
    ;call print_axx
    cmp dx,96
    jg exit
    
exit:
    mov ah,4ch
    int 21h
exit2:
    ret
firstpage endp


main Proc
    MOV AX, @data
    MOV DS, AX
    ;  mov ax,500
    ;print_ax ax
; set graphics display mode & draw border
lbl:

    Call firstpage
    CALL set_display_mode2
    CALL set_display_mode
chk:
  ;  mov ax, 1003h ; disable blinking.  
  ;  mov bx, 0        
  ;  int 10h
  ;  mov ch, 32
  ;  mov ah, 1
  ;  int 10h;

  ;mov ax, 0
  ; int 33h


;clear_screen
ok:
    mov ax, 1
    int 33h  
    ;   clear_screen
;ok:
     mov ax, 3
     int 33h
     
    mov curB,bx
    mov curx,dx
    push ax
    push bx
    push cx
    push dx
    mov ax,cx
    mov dx,0
    mov bx,2
    idiv bx
    
    mov cury,ax
    pop dx
    pop cx
    pop bx
    pop ax
    


    cmp curb, 1  ; both buttons
    je  print_xy
    jmp ok

print_xy:
    push ax
    push bx
    push cx
    push dx
    mov ax,crossx
    mov cx,crossy
    cmp ax,curx
    JNE nn
    cmp cx,cury
    jNE nn
    je ok
 nn:
    mov ax,curx
    mov cx, cury
    mov crossx,ax
    mov crossy,cx

    Call cheacker
    Call set_display_mode2
    CALL set_display_mode
    CALL decider
    cmp flag,0
    jne Done
    cmp sum,9
    jE Done
    jmp ok
Done:
    call initializer
    clear_screen
    jmp lbl
    
    

    main EndP
End main
    
    