#include "protheus.ch"

User function Relato()
    Local oReport
    Local cPerg := 'RELATO'
    
    Pergunte(cPerg, .T.)

    oReport := ReportDef(cPerg)
    oReport:PrintDialog()
return

Static Function ReportDef(cPerg)
    Local oReport
    Local oSection1
    Local oSection2
    Local cTitulo := 'Pedidos por Cliente'

    oReport := TReport():New('Relato', cTitulo, cPerg, {|oReport| PrintReport(oReport)})
    oReport:SetLandScape()

    oSection1 := TRSection():New(oReport, 'Armazens')
    TRCell():New(oSection1, 'NNR_CODIGO', , 'Cod. Armazem', '', TamSX3('NNR_CODIGO')[1])
    TRCell():New(oSection1, 'NNR_DESCRI', , 'Desc. Armazem', '', TamSX3('NNR_DESCRI')[1])

    oSection2 := TRSection():New(oReport, 'Produtos')
    TRCell():New(oSection2, 'B1_COD', , 'Cod. Produto', '', TamSX3('B1_COD')[1])
    TRCell():New(oSection2, 'B1_DESC', , 'Desc. Produto', '', TamSX3('B1_DESC')[1])
    TRCell():New(oSection2, 'B1_UM', , 'Unidade de Medida', '', TamSX3('B1_UM')[1])
return oReport

Static Function PrintReport(oReport)
    Local oSection1 := oReport:Section(1)
    Local oSection2 := oReport:Section(2)
    Local cAliasSB := GetNextAlias()
    Local cAliasNR := GetNextAlias()
    Local nRegs := 0

    BEGINSQL ALIAS cAliasNR
        SELECT
            NNR.NNR_CODIGO,
            NNR.NNR_DESCRI
        FROM
            %Table:NNR% AS NNR
        WHERE 1=1
            AND NNR.%NotDel%
            AND NNR_CODIGO BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
    ENDSQL

    Count TO nRegs

    if(nRegs > 0)
        (cAliasNR) -> (DbGoTop())
        while ((cAliasNR) -> (!EoF()))
            oSection1:Init()

            oSection1:Cell('NNR_CODIGO'):SetValue((cAliasNR) -> NNR_CODIGO)
            oSection1:Cell('NNR_DESCRI'):SetValue((cAliasNR) -> NNR_DESCRI)

            oSection1:PrintLine()
            oReport:ThinLine()

            nRegs := 0

            BEGINSQL ALIAS cAliasSB
                SELECT 
                    SB1.B1_COD,
                    SB1.B1_DESC,
                    SB1.B1_UM
                FROM
                    %Table:SB1% AS SB1
                WHERE 1=1
                    AND B1_LOCPAD = %Exp:(cAliasNR) -> NNR_CODIGO%
            ENDSQL
            
            Count TO nRegs

            if(nRegs > 0)
                (cAliasSB) -> (DbGoTop())
                while ((cAliasSB) -> (!EoF()))
                    oSection2:Init()

                    oSection2:Cell('B1_COD'):SetValue((cAliasSB) -> B1_COD)
                    oSection2:Cell('B1_DESC'):SetValue(AllTrim((cAliasSB) -> B1_DESC))
                    oSection2:Cell('B1_UM'):SetValue(AllTrim((cAliasSB) -> B1_UM))

                    oSection2:PrintLine()

                    (cAliasSB) -> (DbSkip())
                enddo
            
                oSection2:Finish()
                (cAliasSB) -> (DbCloseArea())
            endif

            oReport:ThinLine()
            oReport:SkipLine(3)
            (cAliasNR) -> (DbSkip())
        enddo

        oSection1:Finish()
        (cAliasNR) -> (DbCloseArea())
    endif
return
