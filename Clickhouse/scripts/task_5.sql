create materialized view mv_shk_measurement_to_history to history.shk_measurement as
select *
from stg.shk_measurement;

create materialized view mv_shk_measurement_to_current to current.shk_measurement as
select *
from stg.shk_measurement;