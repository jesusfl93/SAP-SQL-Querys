select T0.DocNum,T0.DocEntry,T0.CardCode,T0.DocTotal,T0.PaidToDate,T0.DocTotal-T0.PaidToDate as Saldo,T0.DocDate,T0.DocDueDate,DATEDIFF(day,T0.DocDueDate,GETDATE()) as DiasMora,T0.SlpCode
from oinv T0 
where DocStatus='O' 
union all
select T0.DocNum,T0.DocEntry,T0.CardCode,T0.DocTotal,T0.PaidToDate,(T0.DocTotal-T0.PaidToDate)*-1 as Saldo,T0.DocDate,T0.DocDueDate,DATEDIFF(day,T0.DocDueDate,GETDATE()) as DiasMora,T0.SlpCode
from ORIN T0 
where DocStatus='O' 
