#include "protheus.ch"
#include "parmtype.ch"

user function BANCO004()
    Local aArea := SB1->(GetArea())
    
    DbSelectArea('SB1')
    SB1->(DbSetOrder(1))
    SB1->(DbGoTop())

    Begin Transaction
        MsgInfo("A Descrição do produto sera alterada", "Atenção")

    if( SB1->(Dbseek(FWxFilial('SB1') + '000002')))
        RecLock('SB1', .F.)
        Replace B1_DESC With "MONITOR DELL 42PL"
        SB1->(MsUnlock())
    EndIf

        MsgAlert("Alteração efetada!", "Atenção")
    End Transaction
    RestArea(aArea)
return
