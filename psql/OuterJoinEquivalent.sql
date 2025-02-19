-- Get equal of one-sided outer joins
SELECT e.id,email_add,website
FROM email AS e
LEFT OUTER JOIN online_account
ON e.id=email_id
;

SELECT t.id,t.email_add,NULL AS website
FROM (
	SELECT e.id,email_add
	FROM email e WHERE NOT EXISTS (
		SELECT email_id FROM online_account WHERE e.id=email_id
	)
) t
UNION
SELECT email_id,email_add,website
FROM online_account,email
WHERE email.id=email_id
;