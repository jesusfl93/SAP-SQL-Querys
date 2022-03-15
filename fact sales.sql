SELECT 
					   'Ventas' AS Doc,
					    t1.DocSubType,
						
						T1.DocNum,
						T1.docdate, 
						 T0.BaseCard,
						 T1.CardName,
						  T0.ItemCode,
						  ISNULL(T9.Name,T0.ItemCode) as CodigoM,
						  T0.Dscription, ABS(T11.Quantity) as Quantity,
						  
							  CASE WHEN T0.Currency = 'LPS' THEN T0.Price ELSE abs(T0.Price * T0.Rate) END AS Price,
							  CASE WHEN T0.Currency = 'LPS' THEN T0.PriceBefDi  ELSE abs(T0.PriceBefDi* T0.Rate) END AS PriceBefDi,  
							  CASE WHEN T0.Currency = 'LPS' THEN PriceBefDi *(isnull(nullif(ABS(T11.Quantity),0),1)) ELSE (PriceBefDi *(isnull(nullif(ABS(T11.Quantity),0),1)))*t0.Rate END AS TotalBruto, 
							  CASE WHEN T0.Currency = 'LPS' THEN abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1)) ELSE (abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1)))*t0.Rate END AS BonoBande,
							  CASE WHEN T0.Currency = 'LPS' THEN Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100) ELSE (Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100))*t0.Rate END AS PMPM,
							  CASE WHEN T0.Currency = 'LPS' THEN abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1)) + Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100) ELSE (abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1)) + Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100))*t0.Rate END AS DTG,
						  
						T0.GrossBuyPr AS CostoU,
						T0.GrossBuyPr*ABS(T11.Quantity) AS CostoL,  
						T0.GrssProfit AS GananciaTotal0, 
						T2.PymntGroup AS CondicionPago,
						T0.SlpCode AS Vendedor,
						case when t1.DocSubType = 'DN' Then 'Financiera' else '-' END as CategoriaDoc
						,T13.DistNumber as BatchNum
						,

						case 
								when T0.SlpCode='38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Estado'
								when T0.SlpCode='38' and T6.Name <>'MRP / HOSPITALARIO' Then 'Medicamento Estado'
								when T0.SlpCode<>'38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Privado'
								Else 'Medicamento Privado' end as CategoriaVenta



FROM            INV1  T0  LEFT JOIN
                         OINV T1 ON T0.DocEntry = T1.DocEntry LEFT JOIN
                         OCTG T2 ON T1.GroupNum = T2.GroupNum LEFT JOIN
                         OSLP T4 ON T1.SlpCode = T4.SlpCode LEFT JOIN
                         OITM T5 ON T0.ItemCode = T5.Itemcode LEFT JOIN
                         [@DIVISION] T6 ON T5.U_DIVISION = T6.Code LEFT JOIN
                         [@LINEA] T7 ON T5.U_LINEA = T7.Code LEFT JOIN
                         [@PRESENTACION] T8 ON T5.U_PRESENTACION = T8.Code left join
						 [@MASTER] T9 on T9.Code=T5.U_CodigoM left join
						OITL T10 on T0.ItemCode=T10.ItemCode and T0.BaseRef=T10.DocEntry and  T0.BaseType=T10.DocType
						inner JOIN ITL1 T11 on T10.LogEntry=t11.LogEntry  and T0.BaseLine = T10.ApplyLine and T10.StockEff='1'
						inner join OBTN T13 on T11.SysNumber=T13.SysNumber and T0.ItemCode=T13.ItemCode
						WHERE T1.DocSubType='--'

union all--Agregar Facturas que no tienen la entrega



SELECT 
					   'Ventas' AS Doc,
					    t1.DocSubType,
						
						T1.DocNum,
						T1.docdate, 
						 T0.BaseCard,
						 T1.CardName,
						  T0.ItemCode,
						  ISNULL(T9.Name,T0.ItemCode) as CodigoM,
						  T0.Dscription, ABS(T11.Quantity) as Quantity,
						  
							  CASE WHEN T0.Currency = 'LPS' THEN T0.Price ELSE abs(T0.Price * T0.Rate) END AS Price,
							  CASE WHEN T0.Currency = 'LPS' THEN T0.PriceBefDi  ELSE abs(T0.PriceBefDi* T0.Rate) END AS PriceBefDi,  
							  CASE WHEN T0.Currency = 'LPS' THEN PriceBefDi *(isnull(nullif(ABS(T11.Quantity),0),1)) ELSE (PriceBefDi *(isnull(nullif(ABS(T11.Quantity),0),1)))*t0.Rate END AS TotalBruto, 
							  CASE WHEN T0.Currency = 'LPS' THEN abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1)) ELSE (abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1)))*t0.Rate END AS BonoBande,
							  CASE WHEN T0.Currency = 'LPS' THEN Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100) ELSE (Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100))*t0.Rate END AS PMPM,
							  CASE WHEN T0.Currency = 'LPS' THEN abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1)) + Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100) ELSE (abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1)) + Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100))*t0.Rate END AS DTG,
						  
						T0.GrossBuyPr AS CostoU,
						T0.GrossBuyPr*ABS(T11.Quantity) AS CostoL,  
						T0.GrssProfit AS GananciaTotal0, 
						T2.PymntGroup AS CondicionPago,
						T0.SlpCode AS Vendedor,
						case when t1.DocSubType = 'DN' Then 'Financiera' else '-' END as CategoriaDoc
						,T13.DistNumber as BatchNum
						,

						case 
								when T0.SlpCode='38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Estado'
								when T0.SlpCode='38' and T6.Name <>'MRP / HOSPITALARIO' Then 'Medicamento Estado'
								when T0.SlpCode<>'38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Privado'
								Else 'Medicamento Privado' end as CategoriaVenta



FROM            INV1  T0  LEFT JOIN
                         OINV T1 ON T0.DocEntry = T1.DocEntry LEFT JOIN
                         OCTG T2 ON T1.GroupNum = T2.GroupNum LEFT JOIN
                         OSLP T4 ON T1.SlpCode = T4.SlpCode LEFT JOIN
                         OITM T5 ON T0.ItemCode = T5.Itemcode LEFT JOIN
                         [@DIVISION] T6 ON T5.U_DIVISION = T6.Code LEFT JOIN
                         [@LINEA] T7 ON T5.U_LINEA = T7.Code LEFT JOIN
                         [@PRESENTACION] T8 ON T5.U_PRESENTACION = T8.Code left join
						 [@MASTER] T9 on T9.Code=T5.U_CodigoM left join
						OITL T10 on T0.ItemCode=T10.ItemCode and T1.DocEntry=T10.DocEntry and  T0.BaseType=T10.BaseType
						inner JOIN ITL1 T11 on T10.LogEntry=t11.LogEntry  and T0.LineNum = T10.DocLine
						INNER join OBTN T13 on T11.SysNumber=T13.SysNumber and T0.ItemCode=T13.ItemCode
						WHERE T1.DocSubType='--'


UNION ALL --AGREGAR NOTAS DE DEBIDO DE ARTICULOS

SELECT  
					   'Ventas' AS Doc,
					    t1.DocSubType,
						
						T1.DocNum,
						T1.docdate, 
						 T0.BaseCard,
						 T1.CardName,
						  T0.ItemCode,
						  ISNULL(T9.Name,T0.ItemCode) as CodigoM,
						  T0.Dscription, T0.Quantity,
						  
							  CASE WHEN T0.Currency = 'LPS' THEN T0.Price ELSE abs(T0.Price * T0.Rate) END AS Price,
							  CASE WHEN T0.Currency = 'LPS' THEN T0.PriceBefDi  ELSE abs(T0.PriceBefDi* T0.Rate) END AS PriceBefDi,  
							  CASE WHEN T0.Currency = 'LPS' THEN PriceBefDi *(isnull(nullif(T0.Quantity,0),1)) ELSE (PriceBefDi *(isnull(nullif(T0.Quantity,0),1)))*t0.Rate END AS TotalBruto, 
							  CASE WHEN T0.Currency = 'LPS' THEN abs(price-PriceBefDi)*(isnull(nullif(T0.Quantity,0),1)) ELSE (abs(price-PriceBefDi)*(isnull(nullif(T0.Quantity,0),1)))*t0.Rate END AS BonoBande,
							  CASE WHEN T0.Currency = 'LPS' THEN Price*(isnull(nullif(T0.Quantity,0),1))*(T1.DiscPrcnt/100) ELSE (Price*(isnull(nullif(T0.Quantity,0),1))*(T1.DiscPrcnt/100))*t0.Rate END AS PMPM,
							  CASE WHEN T0.Currency = 'LPS' THEN abs(price-PriceBefDi)*(isnull(nullif(T0.Quantity,0),1)) + Price*(isnull(nullif(T0.Quantity,0),1))*(T1.DiscPrcnt/100) ELSE (abs(price-PriceBefDi)*(isnull(nullif(T0.Quantity,0),1)) + Price*(isnull(nullif(T0.Quantity,0),1))*(T1.DiscPrcnt/100))*t0.Rate END AS DTG,
						  
						T0.GrossBuyPr AS CostoU,
						T0.GrossBuyPr*T0.Quantity AS CostoL,  
						T0.GrssProfit AS GananciaTotal0, 
						T2.PymntGroup AS CondicionPago,
						T0.SlpCode AS Vendedor,
						case when t1.DocSubType = 'DN' Then 'Financiera' else '-' END as CategoriaDoc
						,null,
												case 
								when T0.SlpCode='38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Estado'
								when T0.SlpCode='38' and T6.Name <>'MRP / HOSPITALARIO' Then 'Medicamento Estado'
								when T0.SlpCode<>'38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Privado'
								Else 'Medicamento Privado' end as CategoriaVenta
FROM            INV1 T0 LEFT JOIN
                         OINV T1 ON T0.DocEntry = T1.DocEntry LEFT JOIN
                         OCTG T2 ON T1.GroupNum = T2.GroupNum LEFT JOIN
                         OSLP T4 ON T1.SlpCode = T4.SlpCode LEFT JOIN
                         OITM T5 ON T0.ItemCode = T5.Itemcode LEFT JOIN
                         [@DIVISION] T6 ON T5.U_DIVISION = T6.Code LEFT JOIN
                         [@LINEA] T7 ON T5.U_LINEA = T7.Code LEFT JOIN
                         [@PRESENTACION] T8 ON T5.U_PRESENTACION = T8.Code left join
						 [@MASTER] T9 on T9.Code=T5.U_CodigoM
						 
WHERE T1.DocSubType='DN' and T1.DocType = 'I'

UNION ALL --AGREGAR NOTAS DE DEBITO POR SERVICIOS

SELECT  
					   'Ventas' AS Doc,
					    t1.DocSubType,
						
						T1.DocNum,
						T1.docdate, 
						 T0.BaseCard,
						 T1.CardName,
						  T0.ItemCode,
						  ISNULL(T9.Name,T0.ItemCode) as CodigoM,
						  T0.Dscription, T0.Quantity,
						  
							  CASE WHEN T0.Currency = 'LPS' THEN T0.Price *-1 ELSE abs(T0.Price * T0.Rate)*-1 END AS Price,
						  CASE WHEN T0.Currency = 'LPS' THEN T0.PriceBefDi *-1 ELSE abs(T0.PriceBefDi* T0.Rate) *-1 END AS PriceBefDi,  
						 T0.LineTotal AS TotalBruto, 
						  CASE WHEN T0.Currency = 'LPS' THEN 0 ELSE 0 END AS BonoBande,
						  CASE WHEN T0.Currency = 'LPS' THEN 0 ELSE 0 END AS PMPM,
						  CASE WHEN T0.Currency = 'LPS' THEN 0 ELSE 0 END AS DTG,


						T0.GrossBuyPr AS CostoU,
						T0.GrossBuyPr*T0.Quantity AS CostoL,  
						T0.GrssProfit AS GananciaTotal0, 
						T2.PymntGroup AS CondicionPago,
						T0.SlpCode AS Vendedor,
						case when t1.DocSubType = 'DN' Then 'Financiera' else '-' END as CategoriaDoc
						,null,
												case 
								when T0.SlpCode='38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Estado'
								when T0.SlpCode='38' and T6.Name <>'MRP / HOSPITALARIO' Then 'Medicamento Estado'
								when T0.SlpCode<>'38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Privado'
								Else 'Medicamento Privado' end as CategoriaVenta
FROM            INV1 T0 LEFT JOIN
                         OINV T1 ON T0.DocEntry = T1.DocEntry LEFT JOIN
                         OCTG T2 ON T1.GroupNum = T2.GroupNum LEFT JOIN
                         OSLP T4 ON T1.SlpCode = T4.SlpCode LEFT JOIN
                         OITM T5 ON T0.ItemCode = T5.Itemcode LEFT JOIN
                         [@DIVISION] T6 ON T5.U_DIVISION = T6.Code LEFT JOIN
                         [@LINEA] T7 ON T5.U_LINEA = T7.Code LEFT JOIN
                         [@PRESENTACION] T8 ON T5.U_PRESENTACION = T8.Code left join
						 [@MASTER] T9 on T9.Code=T5.U_CodigoM
						 
WHERE T1.DocSubType='DN' and T1.DocType = 'S'

UNION ALL --AGREGAR NC Articulos
SELECT  
					   'Notas Credito' AS Doc, null,
						
						T1.DocNum,
						T1.docdate,
						  
						 T0.BaseCard,
						 T1.CardName,
						  T0.ItemCode,
						  ISNULL(T9.Name,T0.ItemCode) as CodigoM,
						  T0.Dscription, 
						   ISNULL((ABS(T11.Quantity))*-1,1) as Quantity,
						  CASE WHEN T0.Currency = 'LPS' THEN T0.Price *-1 ELSE abs(T0.Price * T0.Rate)*-1 END AS Price,
						  CASE WHEN T0.Currency = 'LPS' THEN T0.PriceBefDi *-1 ELSE abs(T0.PriceBefDi* T0.Rate) *-1 END AS PriceBefDi,  
						  CASE WHEN T0.Currency = 'LPS' THEN PriceBefDi *(isnull(nullif(ABS(T11.Quantity),0),1))*-1 ELSE (PriceBefDi *(isnull(nullif(ABS(T11.Quantity),0),1)))*t0.Rate*-1 END AS TotalBruto, 
						  CASE WHEN T0.Currency = 'LPS' THEN abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1))*-1 ELSE (abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1)))*t0.Rate*-1 END AS BonoBande,
						  CASE WHEN T0.Currency = 'LPS' THEN isnull(Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100)*-1,0) ELSE ISNULL((Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100))*t0.Rate*-1,0) END AS PMPM,
						  CASE WHEN T0.Currency = 'LPS' THEN ISNULL(abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1))*-1 + Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100)*-1,0) ELSE ISNULL((abs(price-PriceBefDi)*(isnull(nullif(ABS(T11.Quantity),0),1)) + Price*(isnull(nullif(ABS(T11.Quantity),0),1))*(T1.DiscPrcnt/100))*t0.Rate*-1,0) END AS DTG,
						  						case when t1.DocType='I' then T0.GrossBuyPr else 
						(select top 1 TSS.Debit from JDT1 TSS where TSS.TransId=T1.TransId order by TSS.Line_ID DESC ) 
						end as CostoU,

						case when t1.DocType='I' then T0.GrossBuyPr*ABS(T11.Quantity)*-1 else 
						(select top 1 TSS.Debit*-1 from JDT1 TSS where TSS.TransId=T1.TransId order by TSS.Line_ID DESC ) 
						end as CostoL,
						T0.GrssProfit*-1 AS GananciaTotal0, 
						T2.PymntGroup AS CondicionPago,
						T0.SlpCode AS Vendedor,
						case	when T1.Comments like '%Basado%' or comments like '%Based%' then 'Anulacion' 
								when T1.Comments like '%Vencido%' then 'Producto Vencido'
								when T1.Comments like '%Vencer%' then 'Proximo a Vencer'
								when T1.Comments like '%Buen Estado%' then 'Buen Estado'
								when T1.Comments like '%Ajuste de Precios%' then 'Ajuste de Precios'
								when T1.Comments like '%Multa%' then 'Multa'
								when T1.Comments like '%Dañado%' then 'Producto Dañado'
								when T1.Comments like '%DESCUENTO%' then 'Descuentos'
								when T1.Comments like '%PUSH MONEY%' then 'Canje de Bonos'
								else 'Financiera'
								end as CategoriaDoc
								,T13.DistNumber
								,case 
								when T0.SlpCode='38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Estado'
								when T0.SlpCode='38' and T6.Name <>'MRP / HOSPITALARIO' Then 'Medicamento Estado'
								when T0.SlpCode<>'38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Privado'
								Else 'Medicamento Privado' end as CategoriaVenta

								FROM            RIN1 T0 left JOIN
                         ORIN T1 ON T0.DocEntry = T1.DocEntry LEFT JOIN
                         OCTG T2 ON T1.GroupNum = T2.GroupNum LEFT JOIN
                         OSLP T4 ON T1.SlpCode = T4.SlpCode LEFT JOIN
                         OITM T5 ON T0.ItemCode = T5.Itemcode LEFT JOIN
                         [@DIVISION] T6 ON T5.U_DIVISION = T6.Code LEFT JOIN
                         [@LINEA] T7 ON T5.U_LINEA = T7.Code LEFT JOIN
                         [@PRESENTACION] T8 ON T5.U_PRESENTACION = T8.Code left join
						 [@MASTER] T9 on T9.Code=T5.U_CodigoM 
						 left join OITL T10 on  T1.DocEntry=T10.DocEntry and  T1.ObjType=T10.DocType  and T0.ItemCode=T10.ItemCode 
						 inner	 JOIN ITL1 T11 on T10.LogEntry=t11.LogEntry and T11.ItemCode=T0.ItemCode and T0.LineNum = T10.DocLine
						 left join OBTN T13 on T11.SysNumber=T13.SysNumber and T10.ItemCode=T13.ItemCode
						 where T1.DocType = 'I'


UNION ALL --AGREGAR NC Servicios


SELECT  distinct
					   'Notas Credito' AS Doc, null,
						
						T1.DocNum,
						T1.docdate,
						  
						 T0.BaseCard,
						 T1.CardName,
						  T0.ItemCode,
						  ISNULL(T9.Name,T0.ItemCode) as CodigoM,
						  T0.Dscription, 
						  
						  ISNULL((ABS(T0.Quantity))*-1,1) as Quantity,
						  
						  CASE WHEN T0.Currency = 'LPS' THEN T0.Price *-1 ELSE abs(T0.Price * T0.Rate)*-1 END AS Price,
						  CASE WHEN T0.Currency = 'LPS' THEN T0.PriceBefDi *-1 ELSE abs(T0.PriceBefDi* T0.Rate) *-1 END AS PriceBefDi,  
						 T0.LineTotal*-1 AS TotalBruto, 
						  CASE WHEN T0.Currency = 'LPS' THEN 0 ELSE 0 END AS BonoBande,
						  CASE WHEN T0.Currency = 'LPS' THEN 0 ELSE 0 END AS PMPM,
						  CASE WHEN T0.Currency = 'LPS' THEN 0 ELSE 0 END AS DTG,

						  
						case when t1.DocType='I' then T0.GrossBuyPr else 
						(select top 1 TSS.Debit from JDT1 TSS where TSS.TransId=T1.TransId order by TSS.Line_ID DESC ) 
						end as CostoU,

						case when t1.DocType='I' then T0.GrossBuyPr*ABS(T0.Quantity)*-1 else 
						(select top 1 TSS.Debit*-1 from JDT1 TSS where TSS.TransId=T1.TransId order by TSS.Line_ID DESC ) 
						end as CostoL,



						T0.GrssProfit*-1 AS GananciaTotal0, 
						T2.PymntGroup AS CondicionPago,
						T0.SlpCode AS Vendedor,
						case	when T1.Comments like '%Basado%' or comments like '%Based%' then 'Anulacion' 
								when T1.Comments like '%Vencido%' then 'Producto Vencido'
								when T1.Comments like '%Vencer%' then 'Proximo a Vencer'
								when T1.Comments like '%Buen Estado%' then 'Buen Estado'
								when T1.Comments like '%Ajuste de Precios%' then 'Ajuste de Precios'
								when T1.Comments like '%Multa%' then 'Multa'
								when T1.Comments like '%Dañado%' then 'Producto Dañado'
								when T1.Comments like '%DESCUENTO%' then 'Descuentos'
								when T1.Comments like '%PUSH MONEY%' then 'Canje de Bonos'
								else 'Financiera'
								end as CategoriaDoc
								,null
								,case 
								when T0.SlpCode='38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Estado'
								when T0.SlpCode='38' and T6.Name <>'MRP / HOSPITALARIO' Then 'Medicamento Estado'
								when T0.SlpCode<>'38' and T6.Name ='MRP / HOSPITALARIO' Then 'Insumo Privado'
								Else 'Medicamento Privado' end as CategoriaVenta

								FROM            RIN1 T0 left JOIN
                         ORIN T1 ON T0.DocEntry = T1.DocEntry LEFT JOIN
                         OCTG T2 ON T1.GroupNum = T2.GroupNum LEFT JOIN
                         OSLP T4 ON T1.SlpCode = T4.SlpCode LEFT JOIN
                         OITM T5 ON T0.ItemCode = T5.Itemcode LEFT JOIN
                         [@DIVISION] T6 ON T5.U_DIVISION = T6.Code LEFT JOIN
                         [@LINEA] T7 ON T5.U_LINEA = T7.Code LEFT JOIN
                         [@PRESENTACION] T8 ON T5.U_PRESENTACION = T8.Code left join
						 [@MASTER] T9 on T9.Code=T5.U_CodigoM 
						 where T1.DocType = 'S'
