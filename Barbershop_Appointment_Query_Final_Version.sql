-- Question.1 = Montly income report

select
extract(YEAR_MONTH FROM date) as years_months,
sum(total_price) AS Total_Income
from payments
group by years_months

-- Question.2 = Product stock availability & sales report in barber shop

select
    extract(year_month from appointment.date) as years_months, 
    products.name, 
    products.price, 
    sum(products.price) as total_income, 
    count(products.id) as sold_product_amount, 
    (products.remaining_amount - count(products.id)) as remaining_stock_amount 
from appointment 
    left outer JOIN appointment_has_products 
    on appointment.id = appointment_has_products.appointment_id 
    left outer JOIN products 
    on appointment_has_products.products_id = products.id 
group by years_months, products.id;
					
-- Question.3 = The provided service in barbershop on monthly basis.

    select
    extract(year_month from appointment.date) as years_months, 
           services.service_type as service_type, 
           count(services.id)      as counter 
    from appointment 
             left outer JOIN appointment_has_services 
                             on appointment.id = appointment_has_services.appointment_id 
             left outer JOIN services 
                             on appointment_has_services.services_id = services.id 
    group by years_months, month(appointment.date), services.id 

-- Question.4 = How many days did the barbers work on average per month? (descending)

select
extract(year_month from a.date) as years_months, 
       barbers.first_name, 
       barbers.last_name, 
       count(barbers.id) as total_working_days 
from barbers 
join appointment a on barbers.id = a.barbers_id 
group by years_months, month(a.date), barbers.id 
order by years_months, month(a.date), total_working_days desc



-- Question-5 = Average reviews score of barbers

select 
extract(year_month from a.date) as years_months, 
       barbers.first_name, 
       barbers.last_name, 
       avg(r.attitude_rating) as avg_attitude_rating, 
       avg(r.waitingtime_rating) as avg_waitingtime_rating, 
       avg(r.overall_rating) as avg_overall_rating 
from barbers 
join appointment a on barbers.id = a.barbers_id 
join reviews r on a.reviews_id = r.id 
group by years_months, month (a.date), barbers.id 
order by years_months, month (a.date), barbers.id
		
