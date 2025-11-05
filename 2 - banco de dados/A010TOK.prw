#include "protheus.ch"
#include "parmtype.ch"

user function A010TOK()
    local lExecuta := .T.
    local cTipo := AllTrim(M->B1_TIPO)
    local cConta := AllTrim(M->B1_CONTA)

    IF( cTipo == "PA" .AND. cConta == "001")
        Alert("A conta <b>" + cConta + "</b> não pode estar associada a um produto do tipo <b>" + cTipo)
        lExecuta := .F.
    ENDIF

RETURN(lExecuta)
