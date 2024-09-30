-- Find all bank accounts that have a subscription ID an no LID
SELECT ba.vhost, count(*)
FROM property_bank_accounts ba
LEFT JOIN property_online_payments_base_bank_account_credentials bac
    ON bac.bank_account_id = ba.id
    AND bac.vhost = ba.vhost
WHERE ba.profitstars_inbound_location_id is null
    AND ba.cybersource_subscription_id is not null
GROUP BY ba.vhost

SELECT count(*)
FROM property_bank_accounts ba
-- LEFT JOIN property_online_payments_base_bank_account_credentials bac
--     ON bac.bank_account_id = ba.id
--     AND bac.vhost = ba.vhost
WHERE ba.profitstars_inbound_location_id is null
    AND ba.cybersource_subscription_id is not null
