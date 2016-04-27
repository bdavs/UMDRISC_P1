;initialize a few registers
ADDI  R0, 2    ; ADDI R0<-2             R0=2
ADDI  R1, 1    ; ADDI R1<-1             R1=1
ADDI  R2, 5    ; ADDI R2<-4             R2=4
ADDI  R3, 3    ; ADDI R3<-3             R3=3

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;test add
ADD   R0, R1   ; ADD  R0<-R0 + R1       R0=3

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;test sub
SUB R2, R1  ;r2=4

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;test and
AND   R3, R1   ; AND  R3<-R3 & R1       R3=1

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;test or
OR    R0, R2   ; OR   R0<-R0 or R2      R0=6

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;test move
MOV   R10, R3   ; R10 <- R3              R10=1

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;test addi
ADDI  R3, 3    ; ADDI R3<-3             R3=3

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;test andi
ANDI  R0, 5    ; ANDI R0<-R0 & 5        R0=4

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;shift left
SL    R10, 3   ; R10<-R10[15:3&000]      R10=8

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;shift right
SR    R10, 1   ; R10 [0& 14:0]          R10=4

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;store word
SW    R1, $0F  ; DataMem[0F] <- [R1]    DM[0F]=1

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;load word
LW    R5, $0F  ; R5 <- DataMem[0F]      R5=1

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;load word vector
LWV		R0,	S0,	255	; B000FF


;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;store word vector
SWV		R1,	S1,	256	; C14100

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;jump
JAL   R0, 06 

;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
;delay
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1
ADDI  R4, 0    ; ADDI R1<-1             R1=1

;return

RTL   R0, 0  ;E000 : leave R0 and 0 for it to assemble properly

;branch

