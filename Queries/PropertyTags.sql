SELECT vhost
FROM CDC_DEID_VIEWS.property_tags t
WHERE LOWER(name) like '2005 red dodge%'
GROUP BY vhost
ORDER BY vhost asc

SELECT *
FROM (
    SELECT LOWER(name) as amenity, COUNT(*) as amenitycount
    FROM DBT.REALMX.stg_property_taggings ts
    INNER JOIN DBT.REALMX.stg_property_tags tg
        ON ts.tag_id = tg.id
        -- AND ts.kafka_key_vhost = tg.kafka_key_vhost
    WHERE context = 'amenities'
    GROUP BY amenity
)
WHERE amenitycount > 2000
ORDER BY amenitycount desc
LIMIT 30
