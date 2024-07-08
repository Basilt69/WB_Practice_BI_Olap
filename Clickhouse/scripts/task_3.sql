create role readonly_clh;
create role stg_writer;

grant select on *.* to readonly_clh;
grant create, insert on stg.* to stg_writer;

create user clh_readonly identified with sha256_password by 'clh_readonly123';
create user clh_writer identified with sha256_password by 'clh_writer123';

grant readonly_clh to clh_readonly;
grant stg_writer to clh_writer;