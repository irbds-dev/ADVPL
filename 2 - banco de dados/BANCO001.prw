#include "protheus.ch"
#include "parmtype.ch"

user function BANCO007()
    local aArea := SB1->(GetArea())

    DbSelectArea("SB1")
    SB1->(DBsetorder(1)) //posiciona no indice 1
    SB1->(DbGoTop())
    
    //busco o produto de codigo 000002
    if(SB1->(dbSeek(FWXFilial("SB1")+ "000002")))
        Alert(SB1->B1_DESC)
    ENDIF

    RestArea(aArea)

return
