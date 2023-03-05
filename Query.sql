-- Question.1 = Montly income report

SELECT
    EXTRACT(Year_month FROM date) AS years_months,
    SUM(total_price) AS Total_Income
FROM payments
GROUP BY years_months;

-- Question.2 = Product stock availability & sales report in barber shop

SELECT
    EXTRACT(year_month from appointment.date) AS years_months, 
    products.name, 
    products.price, 
    SUM(products.price) AS total_income, 
    COUNT(products.id) AS sold_product_amount, 
    (products.remaining_amount - COUNT(products.id)) AS remaining_stock_amount 
FROM appointment 
    LEFT OUTER JOIN appointment_has_products 
    on appointment.id = appointment_has_products.appointment_id 
    LEFT OUTER JOIN products 
    on appointment_has_products.products_id = products.id 
GROUP BY years_months, products.id;
					
-- Question.3 = The provided service in barbershop on monthly basis.

SELECT
    EXTRACT(year_month FROM appointment.date) AS years_months, 
    services.service_type AS service_type, 
    COUNT(services.id) AS counter 
FROM appointment 
    LEFT OUTER JOIN appointment_has_services 
    on appointment.id = appointment_has_services.appointment_id 
    LEFT OUTER JOIN services 
	on appointment_has_services.services_id = services.id 
    GROUP BY years_months, month(appointment.date), services.id;

-- Question.4 = How many days did the barbers work on average per month? (descending)

SELECT
    EXTRACT(year_month from a.date) as years_months, 
	barbers.first_name, 
	barbers.last_name, 
	COUNT(barbers.id) as total_working_days 
FROM barbers 
	JOIN appointment a on barbers.id = a.barbers_id 
	GROUP BY years_months, month(a.date), barbers.id 
	ORDER BY years_months, month(a.date), total_working_days DESC;

-- Question-5 = Average reviews score of barbers

SELECT
    EXTRACT(year_month from a.date) AS years_months, 
    barbers.first_name, 
    barbers.last_name, 
    AVG(r.attitude_rating) AS avg_attitude_rating, 
    AVG(r.waitingtime_rating) AS avg_waitingtime_rating, 
    AVG(r.overall_rating) AS avg_overall_rating 
FROM barbers 
    JOIN appointment a on barbers.id = a.barbers_id 
    JOIN reviews r on a.reviews_id = r.id 
    GROUP BY years_months, month (a.date), barbers.id 
    ORDER BY years_months, month (a.date), barbers.id
		
