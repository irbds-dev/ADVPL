#include 'protheus.ch'

User Function Relat0()
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
    Local oSection3
    Local cTitulo := 'Pedidos por Cliente'

    oReport := TReport():New('Relato', cTitulo, cPerg, {|oReport| PrintReport(oReport)})
    oReport:SetLandScape()

    oSection1 := TRSection():New(oReport, 'Cliente')
    TRCell():New(oSection1, 'A1_COD', , 'Cod.Cliente:' , '', TamSX3('A1_COD')[1])
    TRCell():New(oSection1, 'A1_LOJA', , 'Loja:' , '', TamSX3('A1_LOJA')[1])
    TRCell():New(oSection1, 'A1_NOME', , 'Nome:' , '', TamSX3('A1_NOME')[1])

    oSection2 := TRSection():New(oReport, 'Pedidos')
    TRCell():New(oSection2, 'C5_NUM', , 'Pedido:' , '', TamSX3('C5_NUM')[1])

    oSection3 := TRSection():New(oReport, 'Cliente')
    TRCell():New(oSection1, 'C6_PRODUTO', , 'Produto:' , '', TamSX3('C6_PRODUTO')[1])
    TRCell():New(oSection1, 'DESC_PRD', , 'Descrição:' , '', TamSX3('B1_DESC')[1])
    TRCell():New(oSection1, 'C6_QTDVEN', , 'Quantidade:' , '', TamSX3('C6_QTDVEN')[1])
    TRCell():New(oSection1, 'C6_VALOR', , 'Vlr Total:' , '', TamSX3('C6_VALOR')[1])
return oReport

Static Function PrintReport(oReport)
    Local oSection1 := oReport:Section(1)
    Local oSection2 := oReport:Section(2)
    Local oSection3 := oReport:Section(3)
    Local cAliasCl := GetNextAlias()
    Local cAliasPd := GetNextAlias()
    Local cAliasPr := GetNextAlias()
    Local nRegs := 0

    BeginSql Alias cAliasCl 
        SELECT 
            SA1.A1_COD,
            SA1.A1_LOJA,
            SA1.A1_NOME
        FROM 
            %Table:SA1% AS SA1
        WHERE 1=1
            AND SA1.%NotDel%
            AND A1_FILIAL = %xFilial:SA1%
            AND A1_COD BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR03%
            AND A1_LOJA BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR04%
    EndSql

    Count To nRegs

    if(nRegs > 0)
        (cAliasCl) -> (DbGoTop())
        while(cALiasCl) -> (!EoF())
            oSection1:Init()

            oSection1:Cell('A1_COD'):SetValue(Alltrim((cAliasCl) -> A1_COD))
            oSection1:Cell('A1_LOJA'):SetValue(Alltrim((cAliasCl) -> A1_LOJA))
            oSection1:Cell('A1_NOME'):SetValue(Alltrim((cAliasCl) -> A1_NOME))

            oSection1:PrintLine()
            oReport:ThinLine()

            BeginSql Alias cAliasPd
                SELECT  
                    SC5.C5_NUM
                FROM
                    %Table:SC5% AS SC5
                WHERE 1=1
                    AND SC5.C5_CLIENTE = %Exp:(cALiasCl) -> A1_COD%
                    AND SC5.C5_LOJACLI = %Exp:(cALiasCl) -> A1_LOJA%
            EndSql

            nRegs := 0

            Count To nRegs

            if(nRegs > 0)
                (cAliasPd) -> (DbGoTop())
                
                while(cALiasPd) -> (!EoF())
                    oSection2:Init()
                    oSection2:Cell('C5_NUM'):SetValue(Alltrim((cALiasPd) -> C5_NUM))

                    oSection2:PrintLine()

                    BeginSql Alias cAliasPr
                        SELECT
                            SC6.C6_PRODUTO,
                            SC6.C6_QTDVEN,
                            C6_VALOR
                        FROM
                            %Table:SC6% AS SC6
                        WHERE 1=1
                            AND SC6.%NotDel%
                            AND SC6.C6_NUM = %Exp:(cALiasPd) -> C5_NUM%
                    EndSql

                    nRegs := 0

                    Count To nRegs

                    if(nRegs > 0)
                        (cAliasPr) -> (DbGoTop())
                        while((cAliasPr) -> (!EoF()))

                            oSection3:Init()
                            oSection3:Cell('C6_PRODUTO'):SetValue(Alltrim((cAliasPr) -> C6_PRODUTO))
                            oSection3:Cell('DESC_PRO'):SetValue(Alltrim((Posicione('SB1', 1, cFilifal('SB1') + (cAliasPr) -> C6_Produto, 'B1_DESC')) -> C6_PRODUTO))
                            oSection3:Cell('C6_QTDVEN'):SetValue((cAliasPr) -> C6_QTDVEN)
                            oSection3:Cell('C6_VALOR'):SetValue((cAliasPr) -> C6_VALOR)

                            oSection3:PrintLine()

                            (cALiasPr) -> (DbSkip())
                        EndDo

                        oSection3:Finish()
                        oReport:SkipLine(1)
                    endif

                    oSection2:Finish()
                    (cAliasPr) -> (DbCloseArea())
                    (cAliasPd) -> (DbSkip())
                enddo
            endif

            (cAliasPd) -> (DbCloseArea())
            (cAliasC1) -> (DbSkip())

            oReport:SkipLine(2)
            oSection1:Finish()
        enddo
    endif

    (cAliasCl) -> (DbCloseArea())
return
