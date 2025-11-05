#include "protheus.ch"

user function JOGOADV()
    local nNum := Randomize(1,100)
    local nDig := 0
    local nTentativas := 0

    while (nDig != nNum)
        nTentativas++
        nDig := Val(FWinputBox("Escolha um número de 1 a 100", ""))
        if( nDig == nNum)
            MsgInfo("<b>Você Acertou!" + Chr(13) + Chr(10) + " Num de tentativas: " + cValToChar(nTentativas) + "</b>", "Fim de jogo")
        elseif (nDig > nNum)
            MsgInfo("<b>O numero escolhido deve ser menor que " + cValToChar(nDig) + "</b>", "Tente novamente")
        else
            MsgInfo("<b>O numero escolhido deve ser maior que " + cValToChar(nDig) + "</b>", "Tente novamente")
        endif
    end

return
