-- Cashier transactions the 207 (Issuer Unavailable)
SELECT t.order_number,
       count(*),
       max(t.status),
       max(t.created_at),
       max(subscription_id)
FROM cashier_transactions t
LEFT JOIN cashier_cybersource_events ce ON ce.transaction_id = t.id
AND ce.vhost = t.vhost
WHERE ce.reason_code = '207'
GROUP BY t.order_number

SELECT *
FROM cashier_transactions t
LEFT JOIN cashier_cybersource_events ce ON ce.transaction_id = t.id
AND ce.vhost = t.vhost
WHERE t.order_number = '2C64D8E056E2013C9F726264321B8883'

-- All payment instruments without network tokens (2,177,865)
SELECT COUNT(*)
FROM cashier_payment_instruments pi
LEFT JOIN cashier_network_tokens nt ON pi.network_token_id = nt.id
WHERE nt.id IS NULL

-- All payment instruments without card infos (2,177,865)
SELECT COUNT(*)
FROM cashier_payment_instruments pi
LEFT JOIN cashier_card_infos ci ON pi.card_info_id = ci.id
WHERE ci.id IS NULL

-- All network tokens that lack the tokenex token (3,723,881)
SELECT COUNT(*)
FROM cashier_network_tokens nt
WHERE nt.tokenex_token IS NULL
