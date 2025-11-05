#include "protheus.ch"
#include "parmtype.ch"

user function BANCO006()

    Local aArea := GetArea()
    Local aDados := {}
    Private lMSErroAuto := .F.

    aDados := {;
                {"B1_COD",      "111111",           Nil},;
                {"B1_DESC",     "PRODUTO TESTE",    Nil},;
                {"B1_TIPO",     "AI",               Nil},;
                {"B1_UM",       "CX",               Nil},;
                {"B1_LOCPAD",   "88",               Nil},;
                {"B1_PICM",     0,                  Nil},;
                {"B1_IPI",      0,                  Nil},;
                {"B1_CONTRAT",  "N",                Nil},;
                {"B1_LOCALIZ",  "N",                Nil};
            }

    Alert("a Transaction inicia apos o ok", "")
    Begin Transaction
    MSExecAuto({|x,y|Mata010(x,y)},aDados,3)

    if (lMSErroAuto)
        Alert("Ocorreram erros durante a operação", "")
        MostraErro()

        DisarmTransaction()
    else
        MsgInfo("Operação finalizada", "Sucesso!")
    ENDIF
    END Transaction

    RestArea(aArea)
return
