#include "protheus.ch"

user function INFCHANF()
    local cChaveNF := 0

        cChaveNF := Val(FWinputBox("Informe a Chave da NF:", ""))
        if (Empty(cChaveNF))
            MsgAlert("Operação cancelada ou Chave não informada.", "Atencao")
        else
            MsgInfo("Operacao finalizada com sucesso", "Sucesso")
        endif

return
