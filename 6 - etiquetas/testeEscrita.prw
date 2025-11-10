#include "protheus.ch"

User Function escrita()
    LOCAL nNum1 := 10
    LOCAL nNum2 := 20
    LOCAL cNomeArquivo := "log_atribu_" + Alltrim(StrTran(Time(), ":", "")) + ".txt"
    LOCAL cCaminho := GetTempPath() + cNomeArquivo 
    LOCAL cMensagem := ""

    nNum1 += nNum2 
    
    cMensagem += "O resultado da soma (10 + 20) é: " + cValToChar(nNum1) + CRLF

    Alert("O resultado da soma é: " + cValToChar(nNum1) + CRLF + CRLF + ;
          "Tentando gravar no caminho: " + cCaminho)

    IF MemoWrite(cCaminho, cMensagem)
        Alert("SUCESSO! O arquivo foi criado no diretório temporário do AppServer:" + CRLF + cCaminho)
    ELSE
        Alert("ERRO FATAL! Houve falha ao gravar o arquivo." + CRLF + ;
              "Código FError: " + cValToChar(FError()) + CRLF + ;
              "Verifique se o AppServer tem permissão para a pasta TEMP.")
    ENDIF
Return
