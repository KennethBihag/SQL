-- ALTER TABLE IF EXISTS online_account RENAME password TO password_id;

-- ALTER TABLE IF EXISTS online_account RENAME email TO email_id;

/* ALTER TABLE online_account
 DROP CONSTRAINT online_account_email_fkey,
 DROP CONSTRAINT online_account_password_fkey; */

-- ALTER TABLE IF EXISTS online_account ALTER COLUMN email_id TYPE smallint
-- 	USING get_email_id(email_id);
ALTER TABLE IF EXISTS online_account ALTER COLUMN password_id TYPE smallint
	USING get_password_id(password_id);

ALTER TABLE
    IF EXISTS online_account
ADD CONSTRAINT online_account_emid_fk FOREIGN KEY(email_id) REFERENCES email(id),
ADD CONSTRAINT online_account_pwid_fk FOREIGN KEY(password_id) REFERENCES password(id);
