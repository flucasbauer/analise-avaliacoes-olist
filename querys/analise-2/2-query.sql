with geo_customer as (
    select
        geolocation_zip_code_prefix,
        avg(geolocation_lat) as avg_lat_customer,
        avg(geolocation_lng) as avg_lng_customer
    from tb_geolocation
    group by geolocation_zip_code_prefix
),

geo_seller as (
    select
        geolocation_zip_code_prefix,
        avg(geolocation_lat) as avg_lat_seller,
        avg(geolocation_lng) as avg_lng_seller
    from tb_geolocation
    group by geolocation_zip_code_prefix
)

select
    t1.order_id,
    case 
        when t2.review_score in (1, 2, 3) then 1
        else 0
        end as flag_customers,
    case
        when julianday(t6.order_delivered_customer_date) - julianday(t6.order_estimated_delivery_date) > 0 then 1
        else 0
        end as flag_entrega,
    t4.product_photos_qty,
    sum(t1.price) as valor_venda,
    sum(t1.freight_value) as valor_frete,
    t4.product_weight_g,
    (t4.product_length_cm * t4.product_height_cm * t4.product_width_cm) as volume_product,
    (t5.seller_city || '-' || t5.seller_state) as geo_seller,
    t5.seller_state as uf_seller,
    gs.avg_lat_seller as geolocation_lat_seller,
    gs.avg_lng_seller as geolocation_lng_seller,
    (t7.customer_city || '-' || t7.customer_state) as geo_customer,
    t7.customer_state as uf_customers,
    gc.avg_lat_customer as geolocation_lat_customer,
    gc.avg_lng_customer as geolocation_lng_customer

from tb_order_items as t1

left join tb_order_reviews as t2
    on t1.order_id = t2.order_id

left join tb_order_payments as t3
    on t1.order_id = t3.order_id

left join tb_products as t4
    on t1.product_id = t4.product_id

left join tb_sellers as t5
    on t1.seller_id = t5.seller_id

left join tb_orders as t6
    on t1.order_id = t6.order_id

left join tb_customers as t7
    on t6.customer_id = t7.customer_id

left join geo_customer as gc
    on t7.customer_zip_code_prefix = gc.geolocation_zip_code_prefix

left join geo_seller as gs
    on t5.seller_zip_code_prefix = gs.geolocation_zip_code_prefix

where t6.order_status = 'delivered'

group by t1.order_id;