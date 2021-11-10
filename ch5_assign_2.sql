-- 1
select users.id, users.name, tickets.seat_number from tickets, users where tickets.id=users.id and tickets.train=11 order by seat_number asc;

-- 2
select users.id, users.name, count(trains.distance), sum(trains.distance) as sums
    from tickets,users,trains 
    where tickets.user=users.id and tickets.train=trains.id
    group by users.id
    order by sums desc limit 6;

-- 3
select 
    trains.id,
    (select types.name from types where types.id=trains.type) as type,
    (select stations.name from stations where stations.id=trains.source) as src_stn,
    (select stations.name from stations where stations.id=trains.destination) as dst_stn,
    Timediff(arrival, departure) as travel_time
from trains
order by travel_time desc limit 6;

-- 4
select 
    (select types.name from types where types.id=trains.type) as type,
    (select stations.name from stations where stations.id=trains.source) as src_stn,
    (select stations.name from stations where stations.id=trains.destination) as dst_stn,
    trains.departure,
    trains.arrival,
    round(((select types.fare_rate from types where types.id=trains.type)/1000)*
    trains.distance, -2) as fare
from trains
order by trains.departure asc ;

--5
select 
    trains.id as id,
    (select types.name from types where types.id=trains.type) as type,
    (select stations.name from stations where stations.id=trains.source) as src_stn,
    (select stations.name from stations where stations.id=trains.destination) as dst_stn,
    (select count(seat_number) from tickets where tickets.train=trains.id) as occupied,
    (select max_seats from types where types.id=trains.type) as maximum
from trains
having occupied>0
order by id asc;

--6
select 
    trains.id as id,
    (select types.name from types where types.id=trains.type) as type,
    (select stations.name from stations where stations.id=trains.source) as src_stn,
    (select stations.name from stations where stations.id=trains.destination) as dst_stn,
    (select count(seat_number) from tickets where tickets.train=trains.id) as occupied,
    (select max_seats from types where types.id=trains.type) as maximum
from trains
order by id asc;