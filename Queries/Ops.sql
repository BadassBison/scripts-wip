-- OPS QUERIES ------------------------------------------------------------------------------------
SELECT COUNT(*)
FROM ops_vhosts
WHERE domain = 'import.appfolio.com'

-- Import GUID all start with 'i-'
SELECT name, guid, domain
FROM ops_vhosts
WHERE name IN ('covenanthoa', 'greenoakpropertymanagement', 'merge2nextlevel')

-- i-3cfcfdedd85b8cf75cd48a792af23a6cd3c2262f
SELECT name, guid, domain
FROM ops_vhosts
WHERE guid = 'i-3cfcfdedd85b8cf75cd48a792af23a6cd3c2262f'

-- commercialpropsolutions
SELECT name, guid, domain
FROM ops_vhosts
WHERE name = 'commercialpropsolutions'
