/* MySQL4_Airport.sql */
-- Example_01: List departing airport name, city and country for Italy 
-- Airlines flights departing and arriving on 8/15/2015 using Type I 
-- subqueries, orted by airport name. (27 rows)
SELECT ap1.name, apg1.city, apg1.country
FROM airport ap1 JOIN airport_geo apg1 USING(airport_id)
WHERE ap1.airport_id IN (
 SELECT f2.from_id
 FROM flight f2 JOIN airline al2 USING(airline_id)
 WHERE al2.airlinename LIKE '%Italy%'
   AND DATE(f2.departure) = '2015-08-15'
   AND DATE(f2.arrival) = '2015-08-15'
 )
ORDER BY ap1.name

-- **********************************************************************

-- Example_02: Summarize Italy Airlines inventory by airplane type. List 
-- the airplane type identifier, the number of airplanes on inventory and
-- the total capacity, sorted by the total capacity descending. (12 rows)
SELECT ant.identifier, COUNT(an.airline_id) AS num_IT_planes, 
	SUM(an.capacity) AS tot_IT_cap
FROM airline al INNER JOIN airplane an 
  ON al.airline_id = an.airline_id 
    INNER JOIN airplane_type ant 
	  ON an.type_id = ant.type_id
WHERE al.airlinename LIKE '%Italy%'
GROUP BY ant.identifier
ORDER BY tot_IT_cap DESC

-- Example_03: Find the number of flights and the total capacity of Italy
-- Airlines airplanes by the departure airport and month of the departure. 
-- Show only those airports with 25 or more flights and sort descending on  
-- the total flight capacity. (17 rows)
SELECT ap.name AS departure_airport, 
	month(f.departure) AS departure_month, 
	count(flight_id) AS num_flights, 
	SUM(an.capacity) AS tot_IT_cap
FROM flight f INNER JOIN airport ap 
  ON f.from_id = ap.airport_id 
    INNER JOIN airline al 
	  ON al.airline_id = f.airline_id 
	    INNER JOIN airplane an 
		  ON f.airplane_id = an.airplane_id 
WHERE al.airlinename LIKE '%Italy%'
GROUP BY f.from_id, month(f.departure)
HAVING num_flights >= 25
ORDER BY tot_IT_cap DESC

-- Example_04: Find the number of bookings for Italy Airlines by the 
-- departure country and airport for flights departing on 8/15/2015. Show 
-- only those rows with more than 100 bookings, sorted by the country, 
-- airport, and the number of bookings in descending order. (22 rows)
SELECT apg.country, ap.name, COUNT(booking_id) AS NumBookings
FROM flight f INNER JOIN airport ap  
  ON f.from_id = ap.airport_id 
    INNER JOIN airport_geo apg ON 
	  ap.airport_id = apg.airport_id 
		INNER JOIN airline al 
		  ON al.airline_id = f.airline_id 
			INNER JOIN booking b 
			  ON f.flight_id = b.flight_id
WHERE al.airlinename = 'Italy Airlines' AND 
  DATE(f.departure) = '2015-08-15'
GROUP BY apg.country, ap.name
HAVING NumBookings > 100
ORDER BY apg.country, ap.name, NumBookings DESC

-- Example_05: List the flight number, departing and arriving airport, as  
-- well as the average booking price (rounded to 2 decimals) for Italy 
-- Airlines flights departing on 8/15/2015, but only for those flights whose 
-- average booking price exceeds the average booking price of all Italy 
-- Airlines flights, sorted on the average booking price descending. (27 rows)
SELECT f1.flightno, 
	ap11.name AS depart_airport, 
	ap12.name AS arrive_airport, 
	ROUND(AVG(b1.price),2) AS AvgBookPrice
FROM booking b1 JOIN flight f1 USING(flight_id)
  INNER JOIN airport ap11 ON f1.from_id = ap11.airport_id 
  INNER JOIN airport ap12 ON f1.to_id = ap12.airport_id 
  JOIN airline al1 USING(airline_id)
WHERE DATE(f1.departure) = '2015-08-15' AND 
  al1.airlinename = 'Italy Airlines'
GROUP BY f1.flightno
HAVING AvgBookPrice > 
  (SELECT AVG(b2.price)
   FROM booking b2 JOIN flight f2 USING(flight_id)
   INNER JOIN airline al2 USING (airline_id)
   WHERE al2.airlinename = 'Italy Airlines')
ORDER BY AvgBookPrice DESC
