#include "protheus.ch"
#include "parmtype.ch"
#include "topconn.ch"

user function BANCO003()
    local aArea := SB1->(GetArea())
    local cQuery := ""
    local aDados := {}
    local nCount := 0

    cQuery := " SELECT "
    cQuery += " B1_CODE AS CODE,  "
    cQuery += " B1_DESC AS DESCRICAO,  "
    cQuery := " FROM "
    cQuery := " " + RetSQLName("SB1") + "SB1"
    cQuery := " WHERE "
    cQuery := " B1_MSBLQL != '1' "

    TCQUERY cQuery New Alias "TMP"

    while ! TMP->(EoF())
        AADD(aDados, TMP->CODIGO)
        AADD(aDados, TMP->DESCRICAO)
        TMP->(DbSkip())
    ENDDO

    Alert(Len(aDados))

        FOR nCount := 1 TO Len(aDados)
            MsgInfo(aDados[nCount])
        NEXT nCount

        TMP->(DbCloseArea())
        RestArea(aArea)
return
