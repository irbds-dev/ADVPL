#include "protheus.ch"
#include "parmtype.ch"

user function BANCO002()
    local aArea := SB1->(GetArea())
    local cMsg := ''

    dbSelectArea("SB1")
    SB1->(dbSetOrder(1))
    SB1->(dbGoTop())

    cMsg := Posicione("SB1", 1, FWXfillial("SB1") + "000002", "B1_DESC")

    Alert("Descrição Produto: " + cMsg, "AVISO")

    RestArea(aArea)
return
