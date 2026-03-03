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
            when review_score in (1, 2, 3) then 'Detratores'
            when review_score in (4, 5) then 'Promotores'
        end as status_nota
    from saldo
),

nps as (
    select
        count(*) as total,
        sum(case when status_nota = 'Promotores' then 1 else 0 end) as promotores,
        sum(case when status_nota = 'Detratores' then 1 else 0 end) as detratores
    from categoria
    where saldo_entrega >= 0  -- filtra apenas entregas dentro do prazo
)

select
    total,
    promotores,
    detratores,
    round(
        (cast(promotores as float) / cast(total as float)), 2) as per_promotores,
    round(
        (cast(detratores as float) / cast(total as float)), 2) as per_detratores,
    round(
        (cast(promotores as float) - cast(detratores as float)) / cast(total as float)
    , 2) as nps
from nps;