#Include "Protheus.ch"

user function variaveis()
    local nNum := 21
    local lLogic := .T.
    local cCarac := "String"
    local dData := DATE()
    local aArray := {"Nome1", "Nome2", "nome3"}
    local bBloco := {|| nValor := 2, MsgAlert("O numero é: " + cValToChar(nValor), "mensagem")}

    Alert(nNum)
    Alert(lLogic)
    Alert(cValToChar(cCarac))
    Alert(aArray[1])
    Alert(dData)
    Eval(bBloco)

return
