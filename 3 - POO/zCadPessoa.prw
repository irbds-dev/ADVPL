#include "protheus.ch"

User Function zCadPessoa()
    local oPessoa
    Local cNome := "Maria"
    Local dNascimento := sTod("19980409")

    oPessoa := zPessoa():New(cNome, dNascimento)

    oPessoa:MostraIdade()

    MSGINFO(oPessoa:cNome, "nome")
return
