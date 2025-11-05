#include "protheus.ch"
#include "parmtype.ch"

user function MODELO01()
    Local cAlias := "SB1"
    Local cTitulo := "Cadastro - AxCadastro"
    Local cVldExc := ".T."
    Local cVlDalt := ".T."

    AxCadastro(cAlias, cTitulo, cVldExc, cVlDalt)
return Nil
