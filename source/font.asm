font:
	defb $00,$00,$00,$00,$00,$00,$00,$00 ;  
	defb $18,$10,$10,$10,$18,$00,$18,$00 ; !
	defb $6c,$48,$00,$00,$00,$00,$00,$00 ; "
	defb $24,$24,$7e,$24,$7e,$24,$24,$00 ; #
	defb $00,$10,$7c,$40,$7e,$02,$7e,$10 ; $
	defb $c2,$a4,$e8,$10,$2c,$4a,$8e,$00 ; %
	defb $7c,$44,$48,$36,$24,$44,$7e,$00 ; $
	defb $18,$10,$00,$00,$00,$00,$00,$00 ; '
	defb $1c,$10,$20,$20,$20,$10,$1c,$00 ; (
	defb $38,$08,$04,$04,$04,$08,$38,$00 ; )
	defb $10,$10,$7c,$38,$28,$00,$00,$00 ; *
	defb $00,$10,$10,$7c,$10,$10,$00,$00 ; +
	defb $00,$00,$00,$00,$00,$00,$10,$30 ; ,
	defb $00,$00,$00,$7e,$00,$00,$00,$00 ; -
	defb $00,$00,$00,$00,$00,$00,$18,$00 ; .
	defb $02,$04,$08,$10,$20,$40,$80,$00 ; /
	defb $fa,$84,$8a,$92,$a2,$82,$fe,$00 ; 0
	defb $30,$10,$10,$10,$10,$10,$38,$00 ; 1
	defb $fe,$82,$06,$18,$60,$80,$fe,$00 ; 2
	defb $fc,$84,$08,$14,$02,$02,$fe,$00 ; 3
	defb $0e,$12,$22,$42,$7a,$02,$06,$00 ; 4
	defb $fe,$42,$30,$08,$44,$82,$fe,$00 ; 5
	defb $08,$10,$20,$58,$84,$82,$fe,$00 ; 6
	defb $7e,$42,$02,$04,$08,$10,$20,$00 ; 7
	defb $7c,$44,$48,$34,$22,$42,$7e,$00 ; 8
	defb $fe,$82,$42,$34,$08,$10,$20,$00 ; 9
	defb $00,$00,$00,$18,$00,$00,$18,$00 ; :
	defb $00,$00,$00,$18,$00,$00,$08,$18 ; ;
	defb $04,$08,$10,$60,$10,$08,$04,$00 ; <
	defb $00,$00,$7e,$00,$7e,$00,$00,$00 ; =
	defb $40,$20,$10,$0c,$10,$20,$40,$00 ; >
	defb $7e,$42,$4e,$10,$18,$00,$18,$00 ; ?
	defb $1e,$22,$4a,$9a,$aa,$be,$80,$fe ; @
	defb $3c,$24,$24,$2c,$52,$62,$e7,$00 ; A
	defb $fc,$44,$48,$54,$62,$42,$fe,$00 ; B
	defb $fc,$44,$40,$40,$40,$42,$fe,$00 ; C
	defb $f0,$48,$44,$42,$42,$42,$fe,$00 ; D
	defb $fc,$44,$40,$50,$62,$42,$fe,$00 ; E
	defb $fc,$44,$40,$50,$60,$40,$e0,$00 ; F
	defb $fc,$44,$40,$46,$42,$42,$fe,$00 ; G
	defb $c2,$82,$82,$fe,$82,$82,$86,$00 ; H
	defb $38,$10,$10,$10,$10,$10,$38,$00 ; I
	defb $0e,$04,$04,$c4,$84,$84,$fe,$00 ; J
	defb $c4,$84,$8c,$f0,$8e,$82,$c6,$00 ; K
	defb $e0,$40,$40,$46,$42,$42,$fe,$00 ; L
	defb $fe,$92,$92,$92,$92,$82,$c6,$00 ; M
	defb $fe,$82,$82,$82,$82,$82,$c6,$00 ; N
	defb $fa,$82,$82,$92,$82,$82,$fe,$00 ; O
	defb $fc,$44,$48,$50,$60,$40,$e0,$00 ; P
	defb $fe,$82,$82,$92,$9a,$84,$fe,$00 ; Q
	defb $fc,$44,$48,$50,$68,$44,$ee,$00 ; R
	defb $fe,$44,$20,$10,$48,$84,$fe,$00 ; S
	defb $fe,$92,$10,$10,$20,$40,$80,$00 ; T
	defb $c6,$82,$82,$82,$82,$82,$fe,$00 ; U
	defb $63,$42,$44,$44,$28,$28,$10,$00 ; V
	defb $c6,$82,$92,$92,$92,$92,$fe,$00 ; W
	defb $c6,$82,$44,$38,$44,$82,$c6,$00 ; X
	defb $c6,$82,$82,$fa,$02,$84,$f8,$00 ; Y
	defb $fe,$82,$0c,$10,$60,$82,$fe,$00 ; Z
	defb $7c,$40,$40,$40,$40,$40,$7c,$00 ; [
	defb $80,$40,$20,$10,$08,$04,$02,$00 ; \
	defb $7c,$04,$04,$04,$04,$04,$7c,$00 ; ]
	defb $18,$24,$42,$66,$00,$00,$00,$00 ; ^
	defb $00,$00,$00,$00,$00,$00,$00,$ff ; _
	defb $7c,$44,$40,$f0,$46,$42,$fe,$00 ; £
	defb $00,$00,$f8,$08,$f8,$8a,$fe,$00 ; a
	defb $60,$40,$5e,$52,$42,$42,$7e,$00 ; b
	defb $00,$00,$7c,$44,$40,$42,$7e,$00 ; c
	defb $06,$02,$7a,$4a,$42,$42,$7e,$00 ; d
	defb $00,$00,$f8,$88,$b8,$82,$fe,$00 ; e
	defb $3e,$22,$20,$30,$20,$20,$60,$00 ; f
	defb $00,$00,$fe,$82,$8a,$fa,$02,$7e ; g
	defb $60,$40,$7e,$42,$42,$42,$66,$00 ; h
	defb $10,$00,$70,$10,$10,$10,$1c,$00 ; i
	defb $02,$00,$06,$02,$62,$42,$7e,$00 ; j
	defb $60,$40,$4c,$70,$4e,$42,$66,$00 ; k
	defb $70,$10,$10,$10,$10,$10,$1c,$00 ; l
	defb $00,$00,$fe,$92,$92,$92,$c6,$00 ; m
	defb $00,$00,$7e,$42,$42,$42,$66,$00 ; n
	defb $00,$00,$7a,$42,$52,$42,$7e,$00 ; o
	defb $00,$00,$7e,$42,$52,$5e,$40,$60 ; p
	defb $00,$00,$7e,$42,$4a,$7a,$02,$06 ; q
	defb $00,$00,$7e,$42,$40,$40,$60,$00 ; r
	defb $00,$00,$7c,$40,$7e,$02,$7e,$00 ; s
	defb $30,$20,$38,$20,$20,$22,$3e,$00 ; t
	defb $00,$00,$66,$42,$42,$42,$7e,$00 ; u
	defb $00,$00,$c6,$82,$44,$28,$10,$00 ; v
	defb $00,$00,$c6,$92,$92,$92,$fe,$00 ; w
	defb $00,$00,$82,$c6,$38,$44,$82,$00 ; x
	defb $00,$00,$c6,$82,$8a,$fa,$02,$7e ; y
	defb $00,$00,$7e,$44,$18,$22,$7e,$00 ; z
	defb $0e,$08,$10,$70,$10,$08,$0e,$00 ; {
	defb $10,$10,$10,$10,$10,$10,$10,$00 ; |
	defb $70,$10,$08,$0e,$08,$10,$70,$00 ; }
	defb $74,$54,$5c,$00,$00,$00,$00,$00 ; ~
	defb $1f,$21,$4d,$95,$a1,$bd,$81,$ff ; ©
