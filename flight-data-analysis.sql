--Q1. Find the busiest airport by the number of flights take off
--Q2. Find the total number of tickets sold per airline
--Q3. List all flights operated by 'IndiGo' with airport names (origin and destination)
--Q4. For each airport, show the top airline by number of flights departing from there
--Q5. For each flight, show time taken in hours and categorize it as Short (<2h), Medium (2-5h), or Long (>5h)
--Q6. Show each passenger's first and last flight dates and number of flights
--Q7. Find flights with the highest price ticket sold for each route (origin destination)
--Q8. Find the highest-spending passenger in each Frequent Flyer Status group


--Q1. Find the busiest airport by the number of flights take off
select 
	a.name,
	count(*) as Total_Flights 
from flights as f 
inner join airports as a on a.airportid = f.origin
group by a.name
order by Total_Flights desc

--Q2. Find the total number of tickets sold per airline
select 
	a.name,
	count(*) as Ticket_sold
from tickets as t 
inner join flights as f on f.flightid = t.flightid
inner join airlines as a on f.airlineid = a.airlineid
group by a.name
order by Ticket_sold desc

--Q3. List all flights operated by 'IndiGo' with airport names (origin and destination)
select
	al.name,
	f.flightid,
	a1.name as origin_airport,
	a2.name as destination_airport,
	f.departuretime,
	f.arrivaltime
from airlines as al
inner join flights as f on al.airlineid = f.airlineid
inner join airports as a1 on f.origin = a1.airportid
inner join airports as a2 on f.destination = a2.airportid
where al.name = 'IndiGo'

--Q4. For each airport, show the top airline by number of flights departing from there
with flight_counts as(
select 
	f.origin,
	f.airlineid,
	count(*) as flightcount
from flights as f
group by f.origin,f.airlineid
order by f.origin
),
ranked_airlines as(
select
	*,
	row_number() over(partition by origin order by flightcount desc) as rn
from flight_counts	
)
select 
	a.name as airpoername,
	al.name as airlinename,
	r.flightcount
from ranked_airlines as r
inner join airports as a on r.origin = a.airportid
inner join airlines as al on r.airlineid = al.airlineid
where rn = 1

--Q5. For each flight, show time taken in hours and categorize it as Short (<2h), Medium (2-5h), or Long (>5h)
Select
	flightid,
	departuretime,
	arrivaltime,
    (ArrivalTime - DepartureTime) AS duration_Hours,
	case
		when (EXTRACT(EPOCH FROM (ArrivalTime - DepartureTime)) / 60) < 120 then 'short'
		when (EXTRACT(EPOCH FROM (ArrivalTime - DepartureTime)) / 60) <= 300 then 'medium'
	else
		'long'
	end as flight_category
FROM Flights;

--Q6. Show each passenger's first and last flight dates and number of flights
with ranked_tickets as(
select
	passengerid,
	min(f.departuretime) as first_flight,
	max(f.departuretime) as last_flight,
	count(*) as total_flight
from tickets t
inner join flights f on t.flightid = f.flightid
group by passengerid
)
select
	p.name,
	r.first_flight,
	r.last_flight,
	r.total_flight
from ranked_tickets r
inner join passengers p on r.passengerid = p.passengerid

--Q7. Find flights with the highest price ticket sold for each route (origin destination)
with route_ticket as(
select 
	t.ticketid,
	f.origin,
	f.destination,
	t.price,
	rank() over(partition by f.origin,f.destination order by t.price) as rn
from tickets t
inner join flights f on f.flightid = t.flightid
)
select 
	a.name as origin,
	a1.name as destination,
	rt.price,
	rt.ticketid
from route_ticket rt
inner join airports a on rt.origin = a.airportid
inner join airports a1 on rt.destination = a1.airportid
where rn = 1

--Q8. Find the highest-spending passenger in each Frequent Flyer Status group
with spending_by_passenger as(
select 
	p.passengerid,
	p.name,
	p.frequentflyerstatus,
	sum(t.price) as total_spent
from passengers p 
inner join tickets t on p.passengerid = t.passengerid
group by p.passengerid,p.name,p.frequentflyerstatus
),
spending_rank as(
select
	*,
	rank() over(partition by frequentflyerstatus order by total_spent desc) as rn
from spending_by_passenger
)
select 
	name,
	frequentflyerstatus,
	total_spent
from spending_rank
where rn = 1









select *from airlines
select *from airports
select *from flights
select *from passengers
select *from tickets