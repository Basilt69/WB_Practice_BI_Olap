insert into direct_log.shk_measurement_buf (shk_id, dt, length, width, hight) values
( 81231, '2024-01-01 12:10:10', 3, 3, 3),
( 81232, '2024-01-01 12:10:20',  3, 4, 5),
( 81233, '2024-01-01 12:10:30',  3, 6, 7),
( 81234, '2024-01-01 12:10:40',  3, 8, 9);

select * from stg.shk_measurement;

select * from history.shk_measurement;

select * from current.shk_measurement;