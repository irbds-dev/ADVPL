#include 'protheus.ch'
#include 'parmtype.ch'

user function MBRW01()
    Local cAlias := "SB1"
    Private cTitulo := "Cadastro Produtos MBRWSE"
    Private aRotina := {}

    Alert("teste1","aviso")
    AADD(aRotina, {"Pesquisa",   "AxPesqui", 0, 1})
    AADD(aRotina, {"Visualiza",  "AxVisual", 0, 2})
    AADD(aRotina, {"Incluir",    "AxInclui", 0, 3})
    AADD(aRotina, {"Trocar",     "AxAltera", 0, 4})
    AADD(aRotina, {"Excluir",    "AxDeleta", 0, 5})
    AADD(aRotina, {"JOGOADV",    "u_JOGOADV", 0, 6})
    Alert("teste2","aviso")

    dbSelectArea(cAlias)
    dbSetOrder(1)
    Alert("teste3","aviso")
    mBrowse(,,,,cAlias)

return Nil
