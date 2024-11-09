DLOOP_5 = 0
DLOOP_4 = 0
DLOOP_3 = 0
DLOOP_2 = 0
DLOOP_TOP = 100


    MACRO DLOOP_PUSH
DLOOP_5 = DLOOP_4
DLOOP_4 = DLOOP_3
DLOOP_3 = DLOOP_2
DLOOP_2 = DLOOP_TOP
DLOOP_TOP = DLOOP_2+2
    ENDM

    MACRO DLOOP_POP

DLOOP_TOP = DLOOP_2
DLOOP_2 = DLOOP_3
DLOOP_3 = DLOOP_4
DLOOP_4 = DLOOP_5
DLOOP_5 =  100

    ENDM

    MACRO _do
        DLOOP_PUSH

    IF DLOOP_TOP = 102
102
    ENDIF
    IF DLOOP_TOP = 104
104
    ENDIF

    IF DLOOP_TOP = 106
106
    ENDIF
    
    IF DLOOP_TOP = 108
108
    ENDIF
    
    IF DLOOP_TOP = 110
110
    ENDIF
    


    ENDM

    MACRO _while flag

    IF DLOOP_TOP = 102
        jr flag, 102B
103
    ENDIF

    IF DLOOP_TOP = 104
        jr flag, 104B
105
    ENDIF

    IF DLOOP_TOP = 106
        jr flag, 106B
107
    ENDIF

    IF DLOOP_TOP = 108
        jr flag, 108B
109
    ENDIF

    IF DLOOP_TOP = 110
        jr flag, 110B
111
    ENDIF

 


        DLOOP_POP
    ENDM

    MACRO _while_true


    IF DLOOP_TOP = 102
        jr 102B
103
    ENDIF

    IF DLOOP_TOP = 104
        jr 104B
105
    ENDIF

    IF DLOOP_TOP = 106
        jr 106B
107
    ENDIF

    IF DLOOP_TOP = 108
        jr 108B
109
    ENDIF

    IF DLOOP_TOP = 110
        jr 110B
111
    ENDIF
        DLOOP_POP
    ENDM




   MACRO _break_if flag

 

    IF DLOOP_TOP = 102
        jr flag, 103F
    ENDIF

    IF DLOOP_TOP = 104
        jr flag, 105F
    ENDIF

    IF DLOOP_TOP = 106
        jr flag, 107F
    ENDIF

    IF DLOOP_TOP = 108
        jr flag, 109F
    ENDIF

    IF DLOOP_TOP = 110
        jr flag, 111F
    ENDIF



    ENDM



    MACRO _break

        IF DLOOP_TOP = 102
            jr 103F
        ENDIF

        IF DLOOP_TOP = 104
            jr 105F
        ENDIF

        IF DLOOP_TOP = 106
            jr 107F
        ENDIF

        IF DLOOP_TOP = 108
            jr 109F
        ENDIF

        IF DLOOP_TOP = 110
            jr 111F
        ENDIF

    ENDM






    MACRO _continue_if flag

 

    IF DLOOP_TOP = 102
        jr flag, 102B
    ENDIF

    IF DLOOP_TOP = 104
        jr flag, 104B
    ENDIF

    IF DLOOP_TOP = 106
        jr flag, 106B
    ENDIF

    IF DLOOP_TOP = 108
        jr flag, 108B
    ENDIF

    IF DLOOP_TOP = 110
        jr flag, 110B
    ENDIF



    ENDM

    MACRO _continue


        IF DLOOP_TOP = 102
            jr 102B
        ENDIF

        IF DLOOP_TOP = 104
            jr 104B
        ENDIF

        IF DLOOP_TOP = 106
            jr 106B
        ENDIF

        IF DLOOP_TOP = 108
            jr 108B
        ENDIF

        IF DLOOP_TOP = 110
            jr 110B
        ENDIF
    ENDM


    MACRO _djnz


        IF DLOOP_TOP = 102
            djnz 102B
103            
        ENDIF

        IF DLOOP_TOP = 104
            djnz 104B
105        
        ENDIF

        IF DLOOP_TOP = 106
            djnz 106B
107            
        ENDIF

        IF DLOOP_TOP = 108
            djnz 108B
109            
        ENDIF

        IF DLOOP_TOP = 110
            djnz 110B
111            
        ENDIF



        DLOOP_POP
    ENDM




;;;;;;;;;;;;;;;;;;;;;;;;;; 
; IF 
;;;;;;;;;;;;;;;;;;;;;;;;;;

IF_7 = 0
IF_6 = 0
IF_5 = 0
IF_4 =  0
IF_3 =  0
IF_2 =  0
IF_TOP = 0


ELSE_USED_7 = 0
ELSE_USED_6 = 0
ELSE_USED_5 = 0
ELSE_USED_4 =  0
ELSE_USED_3 =  0
ELSE_USED_2 =  0
ELSE_USED_TOP = 0




    MACRO IF_PUSH 

IF_7 = IF_6
IF_6 = IF_5
IF_5 = IF_4
IF_4 = IF_3
IF_3 = IF_2
IF_2 = IF_TOP
IF_TOP = IF_2 + 2


ELSE_USED_7 = ELSE_USED_6
ELSE_USED_6 = ELSE_USED_5
ELSE_USED_5 = ELSE_USED_4
ELSE_USED_4 = ELSE_USED_3
ELSE_USED_3 = ELSE_USED_2
ELSE_USED_2 = ELSE_USED_TOP
ELSE_USED_TOP = 0

    ENDM

    MACRO IF_POP

IF_TOP = IF_2
IF_2 = IF_3
IF_3 = IF_4
IF_4 = IF_5
IF_5 = IF_6
IF_6 = IF_7
IF_7 = 0


ELSE_USED_TOP = ELSE_USED_2
ELSE_USED_2 = ELSE_USED_3
ELSE_USED_3 = ELSE_USED_4
ELSE_USED_4 = ELSE_USED_5
ELSE_USED_5 = ELSE_USED_6
ELSE_USED_6 = ELSE_USED_7
ELSE_USED_7 = 0

    ENDM



 
 

    MACRO _if_not arg

    IF_PUSH 

    IF IF_TOP = 2 
        jr arg, 2F
    ENDIF

    IF IF_TOP = 4
        jr arg, 4F
    ENDIF

    IF IF_TOP = 6
        jr arg, 6F
    ENDIF

    IF IF_TOP = 8
        jr arg, 8F
    ENDIF

    IF IF_TOP = 10 
        jr arg, 10F
    ENDIF

    IF IF_TOP = 12 
        jr arg, 12F
    ENDIF

    IF IF_TOP = 14
        jr arg, 14F
    ENDIF


    ENDM





    MACRO _else
   
ELSE_USED_TOP = 1


    IF IF_TOP = 2 
        jr  3F
2        
    ENDIF

    IF IF_TOP = 4
        jr  5F
4
    ENDIF

    IF IF_TOP = 6
        jr  7F
6
    ENDIF

    IF IF_TOP = 8
        jr  9F
8        
    ENDIF

    IF IF_TOP = 10 
        jr  11F
10        
    ENDIF

    IF IF_TOP = 12 

        jr  13F
12        
    ENDIF

    IF IF_TOP = 14
        jr  15F
14        
    ENDIF


    ENDM






    MACRO _end_if

    IF ELSE_USED_TOP = 1

        IF IF_TOP = 2 
3
        ENDIF
        

        IF IF_TOP = 4
5
        ENDIF

        IF IF_TOP = 6
7
        ENDIF

        IF IF_TOP = 8
9
        ENDIF

        IF IF_TOP = 10
11
        ENDIF

    ENDIF

    IF ELSE_USED_TOP = 0

        IF IF_TOP = 2 
2
        ENDIF

        IF IF_TOP = 4
4
        ENDIF
        IF IF_TOP = 6
6
        ENDIF

        IF IF_TOP = 8
8
        ENDIF

        IF IF_TOP = 10
10
        ENDIF

 

    ENDIF

        IF_POP
    ENDM


