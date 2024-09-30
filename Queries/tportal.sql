-- All recent tokens with no tokenex token
SELECT *
FROM tportal_payment_tokens pt
WHERE updated_at >= '2023-06-09'
AND pt.card_number_token IS NULL
AND pt.internal_token IS NULL
AND pt.token_v2 IS NOT NULL
LIMIT 10

SELECT vhost, COUNT(*)
FROM tportal_payment_tokens pt
WHERE updated_at >= '2023-06-09 23:12:56.216049'
AND pt.card_number_token IS NULL
AND pt.internal_token IS NULL
AND pt.token_v2 IS NOT NULL
GROUP BY vhost

SELECT count(*)
FROM tportal_payment_tokens pt
WHERE updated_at >= '2023-06-09 23:12:56.216049'
AND pt.card_number_token IS NULL
AND pt.internal_token IS NULL
AND pt.token_v2 IS NOT NULL

SELECT *
FROM tportal_payment_tokens pt
WHERE internal_token is NULL
AND token_v2 is not NULL
LIMIT 100

SELECT *
FROM tportal_payment_tokens pt
WHERE internal_token is not NULL
LIMIT 100

-- Tportal payment_tokens count where user has saved payment tokens without internal tokens (6,088,426)
SELECT COUNT(*)
FROM tportal_payment_tokens pt
INNER JOIN tportal_users tu
    ON tu.cc_payment_token_id = pt.id
    AND tu.vhost = pt.vhost
WHERE pt.internal_token IS NULL
    AND tu.deleted_at IS NULL
    AND pt.token_v2 IS NOT NULL

-- Tportal users with saved payment tokens without internal tokens, and no payment_instrument record in cashier (3,175,766)
SELECT COUNT(*)
FROM tportal_users tu
INNER JOIN tportal_payment_tokens pt
    ON tu.cc_payment_token_id = pt.id
    AND tu.vhost = pt.vhost
LEFT JOIN cashier_payment_instruments pi
    on pi.cybersource_token = pt.token_v2
WHERE tu.deleted_at IS NULL
    AND pt.internal_token IS NULL
    AND pt.token_v2 IS NOT NULL
    AND pi.id IS NULL

-- Users with saved payment tokens without internal tokens, and no tokenex token within 6 months
SELECT COUNT(*)
FROM tportal_users tu
INNER JOIN tportal_payment_tokens pt
    ON tu.cc_payment_token_id = pt.id
    AND tu.vhost = pt.vhost
WHERE tu.deleted_at IS NULL
    AND pt.internal_token IS NULL
    AND pt.token_v2 IS NOT NULL
    AND updated_at >= '2023-06-09 23:12:56.216049'

-- Autopay tokens without internal tokens and with token_v2 (283,915)
SELECT COUNT(*)
FROM tportal_payment_tokens pt
INNER JOIN tportal_auto_payments ap
  ON ap.deleted_at IS NULL
  AND ap.payment_token_id = pt.id
  and pt.vhost = ap.vhost
WHERE pt.internal_token IS NULL
  AND pt.token_v2 IS NOT NULL
  AND ap.deleted_at IS NULL

-- Saved tokens without internal tokens and with token_v2 (6,137,009)
SELECT COUNT(*)
FROM tportal_payment_tokens pt
INNER JOIN tportal_users tu
    ON tu.cc_payment_token_id = pt.id
    AND tu.vhost = pt.vhost
WHERE pt.internal_token IS NULL
    AND pt.token_v2 IS NOT NULL
    AND tu.deleted_at IS NULL

-- Scheduled tokens without internal tokens and with token_v2 (1,883)
SELECT COUNT(*)
FROM tportal_payment_tokens pt
INNER JOIN tportal_payments p
  ON p.payment_token_id = pt.id
  AND P.vhost = pt.vhost
WHERE pt.internal_token IS NULL
  AND pt.token_v2 IS NOT NULL
  AND p.paid_on IS NULL
  AND p.type = 'ScheduledPayment'
  AND p.state = 'complete'

-- Recently used tokens (within 6mos) without internal tokens and with token_v2 (9,034,012)
SELECT COUNT(*)
FROM tportal_payment_tokens pt
INNER JOIN tportal_payments p
  ON p.payment_token_id = pt.id
  AND P.vhost = pt.vhost
WHERE pt.internal_token IS NULL
  AND pt.token_v2 IS NOT NULL
  AND (p.paid_on >= '2023-08-15')

-- Saved Payment tokens per vhost without internal tokens ~ 14.5k
SELECT pt.vhost, count(*) AS countvar
FROM tportal_payment_tokens pt
JOIN tportal_users tu
  ON tu.cc_payment_token_id = pt.id
  AND tu.vhost = pt.vhost
WHERE pt.internal_token IS NULL
  AND pt.token_v2 IS NOT NULL
  AND tu.deleted_at IS NULL
GROUP BY pt.vhost
ORDER BY countvar DESC
LIMIT 20

-- Scheduled Payment tokens per vhost without internal tokens ~ 35
SELECT pt.vhost, count(*) AS countvar
FROM tportal_payment_tokens pt
JOIN tportal_payments p
  ON p.payment_token_id = pt.id
  AND P.vhost = pt.vhost
WHERE pt.internal_token IS NULL
  AND pt.token_v2 IS NOT NULL
  AND p.paid_on IS NULL
  AND p.type = 'ScheduledPayment'
  AND p.state = 'complete'
GROUP BY pt.vhost
ORDER BY countvar DESC
LIMIT 20

-- Autopay Payment tokens per vhost without internal tokens ~ 1K
SELECT pt.vhost, count(*) AS countvar
FROM tportal_payment_tokens pt
INNER JOIN tportal_auto_payments ap
  ON ap.deleted_at IS NULL
  AND ap.payment_token_id = pt.id
  AND pt.vhost = ap.vhost
WHERE pt.internal_token IS NULL
  AND pt.token_v2 IS NOT NULL
  AND ap.deleted_at IS NULL
GROUP BY pt.vhost
ORDER BY countvar DESC
LIMIT 20

-- Recent Payment tokens per vhost without internal tokens ~ 1K
SELECT pt.vhost, count(*) AS countvar
FROM tportal_payment_tokens pt
INNER JOIN tportal_payments p
  ON p.payment_token_id = pt.id
  AND P.vhost = pt.vhost
WHERE pt.card_number_token IS NULL
  AND pt.token_v2 IS NOT NULL
  AND (p.paid_on >= '2023-08-15')
GROUP BY pt.vhost
ORDER BY countvar DESC
LIMIT 20

select tpt.vhost, count(*) as countvar from tportal_payment_tokens tpt
JOIN tportal_companies tc on tc.vhost = tpt.vhost
where tpt.internal_token is null
group by tpt.vhost
order by countvar desc
limit 100

-- Saved Payment tokens per vhost without card_number_token
SELECT pt.vhost, count(*) AS countvar
FROM tportal_payment_tokens pt
INNER JOIN tportal_payments p
  ON p.payment_token_id = pt.id
  AND P.vhost = pt.vhost
INNER JOIN tportal_users tu
  ON tu.cc_payment_token_id = pt.id
  AND tu.vhost = pt.vhost
WHERE pt.card_number_token IS NULL
  AND pt.token_v2 IS NOT NULL
  AND (p.paid_on >= '2023-08-15')
GROUP BY pt.vhost
ORDER BY countvar DESC
LIMIT 20


-- TODO:
select au.* from adep_vhosts av
join adep_vhost_names avn on avn.id = av.vhost_name_id and avn.vhost = av.vhost
left join adep_tasks at on at.vhost_id = av.id and at.vhost = av.vhost
left join adep_users au on au.id = at.created_by_id and au.vhost = at.vhost
where avn.name = 'testworldpaymidsanitization'
and at.type = 'CreateVhostTask'


-- PaymentToken with extension, no digital wallet, and no token_v2 (339,605)
SELECT COUNT(*)
FROM tportal_payment_tokens pt
LEFT JOIN tportal_payment_token_extensions pte
    ON pte.payment_token_id = pt.id
    AND pte.vhost = pt.vhost
WHERE pt.token_v2 IS NULL
AND pt.updated_at >= '2024-01-09'

-- Digital wallet types
SELECT digital_wallet_type, COUNT(*)
FROM tportal_payment_token_extensions pte
WHERE pte.updated_at >= '2024-01-09'
GROUP BY digital_wallet_type

-- PaymentToken with extension, apple_pay, and has token_v2 (4,062)
SELECT COUNT(*)
FROM tportal_payment_tokens pt
LEFT JOIN tportal_payment_token_extensions pte
    ON pte.payment_token_id = pt.id
    AND pte.vhost = pt.vhost
WHERE pt.token_v2 IS NOT NULL
AND pt.updated_at >= '2024-01-09'
AND pte.digital_wallet_type = 'apple_pay'

-- PaymentToken with extension (includes apple_pay), and has token_v2 (1,217,531)
SELECT COUNT(*)
FROM tportal_payment_tokens pt
LEFT JOIN tportal_payment_token_extensions pte
    ON pte.payment_token_id = pt.id
    AND pte.vhost = pt.vhost
WHERE pt.token_v2 IS NOT NULL
AND pt.updated_at >= '2024-01-09'
