#include "protheus.ch"

/*/{Protheus.doc} className
    (long_description)
    @igor.briano
    @since 24/10/2025
    @version version
    /*/
Class zPessoa
    Data cNome
    Data nIdade
    Data dNascimento

    Method New() CONSTRUCTOR

    Method MostraIdade()
EndClass

    Method New(cNome, dNascimento) class zPessoa
        ::cNome := cNome
        ::dNascimento := dNascimento
        ::nIdade := fCalculoIdade(dNascimento)
    return self

    Method MostraIdade() class zPessoa
        Local cMsg := ""

        cMsg := "Nome: " + ::cNome + "</br>" +;
        "Idade: " + cValToChar(::nIdade)

        MSGINFO(cMsg, "Informações")
    return

    Static Function fCalculoIdade(dNascimento)
        Local nIdade
        Local dHoje := Date()

        nIdade := dateDiffYear(dHoje, dNascimento)
    Return nIdade
