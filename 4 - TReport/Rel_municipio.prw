#include "protheus.ch"

User Function RELMUNI()
    Local oReport
    Local cPerg := 'RELMUNI'

    Pergunte(cPerg, .T.)

    oReport := ReportDef(cPerg)
    oReport:PrintDialog()
return

Static Function ReportDef(cPerg)
    Local oReport
    Local oSection1
    Local oSection2
    Local cTitulo := 'Perguntas'

    oReport := TReport():New('RELMUNI', cTitulo, cPerg, {|oReport| PrintReport(oReport)})
    oReport:SetLandScape()

    oSection1 := TRSection():New(oReport, 'Estado')
    TRCell():New(oSection1, 'Indice', , 'Indice', '', 5, , , "CENTER")
    TRCell():New(oSection1, 'CC2_EST', , 'Cod. Estado', '', TamSX3('CC2_EST')[1], , , "CENTER")

    oSection2 := TRSection():New(oReport, 'Municipio')
    TRCell():New(oSection2, 'Indice', , 'Indice', '', 5, , , "CENTER")
    TRCell():New(oSection2, 'CC2_CODMUN', , 'Cod. municipio', '', TamSX3('CC2_CODMUN')[1], , , "CENTER")
    TRCell():New(oSection2, 'CC2_MUN', , 'Nome municipio', '', TamSX3('CC2_MUN')[1])
return oReport

Static Function PrintReport(oReport) 
    Local oSection1 := oReport:Section(1)
    Local oSection2 := oReport:Section(2)
    Local cAliasCC1 := GetNextAlias()
    Local cAliasCC2 := GetNextAlias()
    Local nRegs := 0
    Local cRegiao := ''
    Local nIndice1 := 0
    Local nIndice2 := 0

    do case 
        case MV_PAR01 ==  1
            cRegiao := "AC', 'AP', 'AM', 'PA', 'RO', 'RR', 'TO"
        case MV_PAR01 ==  2
            cRegiao := "AL', 'BA', 'CE', 'MA', 'PB', 'PE', 'PI', 'RN', 'SE"
        case MV_PAR01 ==  3
            cRegiao := "PR', 'RS', 'SC"
        case MV_PAR01 ==  4
            cRegiao := "ES', 'MG', 'RJ', 'SP"
        case MV_PAR01 ==  5
            cRegiao := "GO', 'MT', 'MS', 'DF"
    ENDcase

    BeginSql Alias cAliasCC1
        SELECT
            CC2_EST
        FROM
            %Table:CC2% AS CC2
        WHERE 1=1
            and CC2_EST IN (%Exp:cRegiao%)
        GROUP BY CC2_EST
        ORDER BY CC2_EST
    EndSql

    Count To nRegs

    if(nRegs > 0)
        (cAliasCC1) -> (DbGoTop())
        while((cAliasCC1) -> (!EoF()))
            oSection1:Init()
            oSection1:Cell('Indice'):SetValue(nIndice1)
            oSection1:Cell('CC2_EST'):SetValue((cAliasCC1) -> CC2_EST)
            oSection1:PrintLine()

            nRegs := 0

            BeginSql Alias cAliasCC2
                SELECT
                    CC2.CC2_CODMUN,
                    CC2.CC2_MUN
                FROM
                    %Table:CC2% AS CC2
                WHERE 1=1
                    and CC2_EST = %Exp:(cAliasCC1) -> CC2_EST%
                ORDER BY CC2_CODMUN
            EndSql

            Count To nRegs

            if(nRegs > 0)
                (cAliasCC2) -> (DbGoTop())
                while((cAliasCC2) -> (!EoF()))
                    oSection2:Init()
                    oSection2:Cell('Indice'):SetValue(cValToChar(nIndice1) + '.' + cValToChar(nIndice2))
                    oSection2:Cell('CC2_CODMUN'):SetValue((cAliasCC2) -> CC2_CODMUN)
                    oSection2:Cell('CC2_MUN'):SetValue((cAliasCC2) -> CC2_MUN)
                    oSection2:PrintLine()

                    nIndice2 += 1
                    (cAliasCC2) -> (DbSkip())
                enddo
                oSection2:Finish()
                oReport:ThinLine()
                oReport:SkipLine(2)
            endif
            (cAliasCC2) -> (DbCloseArea())

            nIndice2 := 0
            nIndice1 += 1

            (cAliasCC1) -> (DbSkip())
        enddo
        oSection1:Finish()
    endif
    (cAliasCC1) -> (DbCloseArea())
return
