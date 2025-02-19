CREATE OR REPLACE VIEW account_info AS
SELECT subq.id,subq.website,subq.email_add,subq.username,p.password
FROM
 (SELECT oa.id,website,e.email_add,username,oa.password_id
 FROM online_account AS oa
 LEFT OUTER JOIN email AS e
 ON oa.email_id=e.id) AS subq
JOIN password AS p
ON subq.password_id=p.id
;