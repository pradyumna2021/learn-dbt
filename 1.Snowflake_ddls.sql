use role sysadmin;

create or replace database DBT_FUN_DB;
use database dbt_fun_db;
create or replace schema DBT_FUN_DB.DBT_SH;
CREATE WAREHOUSE IF NOT EXISTS DBT_WH;

--create a dbt use for snowfalke 

USE ROLE ACCOUNTADMIN;

CREATE or replace USER pradyumnadbt
  PASSWORD='Welcome2dbt'
  LOGIN_NAME='pradyumnadbt'
  MUST_CHANGE_PASSWORD=FALSE
  DEFAULT_WAREHOUSE='DBT_WH'
  COMMENT='DBT user used for data transformation';


GRANT ROLE SYSADMIN TO USER pradyumnadbt;

------------------------------------------
--Encountered an error: Runtime Error Database Error in sql_operation inline_query
--(from remote system.sql) 001003 (42000): SQL compilation error: syntax error line 1 at position 0 unexpected 'limit'.


CREATE ROLE IF NOT EXISTS DBT_TRANSFORM_ROLE;
--GRANT ROLE DBT_TRANSFORM_ROLE TO ROLE ACCOUNTADMIN;

--ALTER USER pradyumnadbt SET TYPE = LEGACY_SERVICE;
GRANT ROLE DBT_TRANSFORM_ROLE TO USER pradyumnadbt;


-- Grant permissions to the `transform` role
GRANT ALL ON WAREHOUSE DBT_WH TO ROLE DBT_TRANSFORM_ROLE;

GRANT ALL ON DATABASE RAW TO ROLE DBT_TRANSFORM_ROLE;
GRANT ALL ON DATABASE DBT_FUN_DB TO ROLE DBT_TRANSFORM_ROLE;

GRANT ALL ON ALL SCHEMAS IN DATABASE RAW TO ROLE DBT_TRANSFORM_ROLE;

GRANT ALL ON FUTURE SCHEMAS IN DATABASE RAW TO ROLE DBT_TRANSFORM_ROLE;

GRANT ALL ON ALL TABLES IN SCHEMA RAW.JAFFLE_SHOP TO ROLE DBT_TRANSFORM_ROLE;

GRANT ALL ON FUTURE TABLES IN SCHEMA MOVIELENS.RAW TO ROLE DBT_TRANSFORM_ROLE;

--DBT QUICKSTART
grant all on database raw to role DBT_TRANSFORM_ROLE;

grant all on schema raw.jaffle_shop to role DBT_TRANSFORM_ROLE;
grant all on schema raw.stripe to role DBT_TRANSFORM_ROLE;

grant all on all tables in database raw to role DBT_TRANSFORM_ROLE;
grant all on future tables in database raw to role DBT_TRANSFORM_ROLE;
