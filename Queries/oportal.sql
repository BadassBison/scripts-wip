SELECT oai.vhost, COUNT(*) AS countvar
FROM oportal_account_informations oai
WHERE oai.account_number_token IS NOT NULL
GROUP BY oai.vhost
ORDER BY countvar DESC
LIMIT 20
