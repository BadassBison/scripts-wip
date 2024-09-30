-- Count Records in paymentsmerchant_clients for current import vhosts
SELECT COUNT(*)
FROM paymentsmerchant_clients
WHERE uuid in (
    SELECT guid
    FROM ops_vhosts
    WHERE domain = 'import.appfolio.com'
)

-- Count Records in paymentsmerchant_clients for current appfolio vhosts
SELECT COUNT(*)
FROM paymentsmerchant_clients
WHERE vhost in (
    SELECT name
    FROM ops_vhosts
    WHERE domain = 'appfolio.com'
)

SELECT COUNT(*)
FROM paymentsmerchant_bank_accounts ba
LEFT JOIN paymentsmerchant_clients c ON c.id = ba.client_id

-- No empty bank accounts
SELECT COUNT(*)
FROM paymentsmerchant_bank_accounts ba
LEFT JOIN paymentsmerchant_clients c on c.id = ba.client_id
WHERE c.uuid like 'i-%'

-- 61
SELECT COUNT(*)
FROM paymentsmerchant_bank_accounts ba
FULL OUTER JOIN paymentsmerchant_clients c on c.id = ba.client_id
WHERE c.uuid like 'i-%'

-- 61
SELECT COUNT(*)
FROM paymentsmerchant_clients c
WHERE uuid like 'i-%'

-- 62
SELECT COUNT(*)
FROM paymentsmerchant_client_data cd
FULL OUTER JOIN paymentsmerchant_clients c on c.id = cd.client_id
WHERE c.uuid like 'i-%'

SELECT vhost, uuid
FROM paymentsmerchant_clients c
WHERE uuid like 'i-%'

-- Count of clients that do not have WP mids
SELECT vhost_name
FROM paymentsmerchant_client_data cd
FULL OUTER JOIN paymentsmerchant_clients c on c.id = cd.client_id
WHERE cd.worldpay_mid IS null
AND cd.deleted_at IS null
ORDER BY vhost_name ASC
