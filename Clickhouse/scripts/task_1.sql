create user clickhouse_admin identified with sha256_password by 'clickhouse_admin123';

grant all on *.* to clickhouse_admin with grant option;
-- grant current grants on *.* to clickhouse_admin with grant option;