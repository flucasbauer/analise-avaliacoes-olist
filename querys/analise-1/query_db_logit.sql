-- categorizando clientes e entregas do pedido para aplicar modelo logit

with avaliacoes as (
        select
            t1.order_id,
            t2.review_id,
            t2.review_score,
            date(t1.order_delivered_customer_date) as data_entrega,
            date(t1.order_estimated_delivery_date) as data_estimada
        from tb_orders as t1
        left join tb_order_reviews as t2
        on t1.order_id = t2.order_id
        where t1.order_status = 'delivered'
),

saldo as (
        select
            *,
            julianday(data_entrega) - julianday(data_estimada) as saldo_entrega
        from avaliacoes
),

categoria as (
        select
            *,
            case 
                when review_score in (1, 2, 3) then '1'
                when review_score in (4, 5) then '0'
                end as status_nps,
            case
                when saldo_entrega >= 0 then '1'
                when saldo_entrega <= 0 then '0'
                end as status_entrega
        from saldo
)

select * 
from categoria;