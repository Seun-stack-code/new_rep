SELECT 
    flights.year, flights.month, flights.day, flights.dep_time, flights.sched_dep_time, flights.dep_delay, flights.arr_time, flights.sched_arr_time, flights.arr_delay, 
    flights.carrier, airlines.name AS airline_name, 
    flights.flight, flights.tailnum, planes.manufacturer, planes.model, planes.engines, planes.seats, planes.speed, planes.engine, 
    flights.origin, origin_airport.name AS origin_airport_name, flights.dest, dest_airport.name AS dest_airport_name, 
    flights.air_time, flights.distance, flights.hour, flights.minute, flights.time_hour, 
    weather.temp, weather.dewp, weather.humid, weather.wind_dir, weather.wind_speed, weather.wind_gust, weather.precip, weather.pressure, weather.visib, weather.time_hour AS weather_time_hour
FROM 
    flights
JOIN 
    airlines ON flights.carrier = airlines.carrier
JOIN 
    airports AS origin_airport ON flights.origin = origin_airport.faa
JOIN 
    airports AS dest_airport ON flights.dest = dest_airport.faa
JOIN 
    planes ON flights.tailnum = planes.tailnum
JOIN 
    weather ON flights.origin = weather.origin AND flights.year = weather.year AND flights.month = weather.month AND flights.day = weather.day AND flights.hour = weather.hour;
