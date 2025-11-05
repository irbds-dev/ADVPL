#include "protheus.ch"
#include "parmtype.ch"

static cStatic := ''

user function escopo1()
    local nVar0 := 1
    local nVar1 := 20

    Private cPri := 'private!'

    Public __cPublic := 'RCTI'

    TesteEscopo(nVar0, @nVar1)

return

Static function TesteEscopo(nValor1, nValor2)
    local __cPublic := 'Alterei'
    Default nValor1  := 0

    nValor2 := 10

    Alert("Private " + cPri)
    Alert("Publica " + __cPublic)

    MsgAlert(nValor2, "Mensagem")
    Alert("Variavel Static: " + cStatic)

return
