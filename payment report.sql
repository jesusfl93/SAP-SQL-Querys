SELECT        t0.DocNum AS Factura, CONVERT(Date, t0.DocDate) AS Fecha, t0.CardCode AS Codigo, t0.CardName AS Nombre, t1.CntctPrsn AS RTN, t2.Price, t2.Dscription, t3.AcctName,t3.AcctCode
FROM            dbo.OPCH AS t0 INNER JOIN
dbo.OCRD AS t1 ON t0.CardCode = t1.CardCode INNER JOIN
dbo.PCH1 AS t2 ON t0.DocEntry = t2.DocEntry INNER JOIN
dbo.OACT AS t3 ON t2.AcctCode = t3.AcctCode
WHERE        (DATEPART(YEAR, t0.DocDate) >= 2017)