CREATE OR REPLACE FUNCTION get_email_id(emailaddr varchar(32))
RETURNS smallint
LANGUAGE plpgsql
AS
$$
DECLARE r smallint :=0;
BEGIN
	SELECT id FROM email WHERE email_add=emailaddr INTO r;
	RETURN r;
END;
$$;

CREATE OR REPLACE FUNCTION get_password_id(passwordid varchar(16))
RETURNS smallint
LANGUAGE plpgsql
AS
$$
DECLARE r smallint :=0;
BEGIN
	SELECT id FROM password WHERE password=passwordid INTO r;
	RETURN r;
END;
$$;