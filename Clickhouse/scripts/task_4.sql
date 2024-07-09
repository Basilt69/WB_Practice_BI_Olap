create table if not exists stg.shk_measurement
(
    shk_id    UInt64                       comment 'Идентификатор товара'
    , dt      DateTime                     comment 'Дата и время обмера'
    , length  UInt64                       comment 'Длина товара'
    , width   UInt64                       comment 'Ширина товара'
    , hight   UInt64                       comment 'Высота товара'
    , dt_load DateTime materialized now()  comment 'Дата загрузки'
) engine=MergeTree()
partition by toYYYYMMDD(dt)
order by(shk_id, dt)
ttl toStartOfDay(dt) + interval 5 day
settings ttl_only_drop_parts=1, index_granularity = 8192;

create table if not exists current.shk_measurement
(
   shk_id    UInt64                       comment 'Идентификатор товара'
    , dt      DateTime                     comment 'Дата и время обмера'
    , length  UInt64                       comment 'Длина товара'
    , width   UInt64                       comment 'Ширина товара'
    , hight   UInt64                       comment 'Высота товара'
    , dt_load DateTime materialized now()  comment 'Дата загрузки'
) engine=ReplacingMergeTree()
order by (shk_id, dt)
settings index_granularity=8192;

create table if not exists history.shk_measurement
(
    shk_id    UInt64                       comment 'Идентификатор товара'
    , dt      DateTime                     comment 'Дата и время обмера'
    , length  UInt64                       comment 'Длина товара'
    , width   UInt64                       comment 'Ширина товара'
    , hight   UInt64                       comment 'Высота товара'
    , dt_load DateTime materialized now()  comment 'Дата загрузки'
) engine=MergeTree()
partition by toYYYYMMDD(dt)
order by(shk_id, dt)
ttl toStartOfDay(dt) + interval 50 day
settings ttl_only_drop_parts=1, index_granularity = 8192;

create table if not exists direct_log.shk_measurement_buf
(
    shk_id    UInt64                       comment 'Идентификатор товара'
    , dt      DateTime                     comment 'Дата и время обмера'
    , length  UInt64                       comment 'Длина товара'
    , width   UInt64                       comment 'Ширина товара'
    , hight   UInt64                       comment 'Высота товара'
) engine=Buffer('stg', 'shk_measurement', 16, 10, 100, 10000, 1000000, 10000000, 100000000);

