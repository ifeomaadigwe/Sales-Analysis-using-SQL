--A Supermarket has a dataset to be analysed and information retrieved using SQL. 
--the columns are branch, city, customer type (member / normal), gender, product line, 
-- unit price, quantity, tax 5%, gross margin %, shopping time, shopping date, 
--payment method (credit, e-wallet etc), gross income, customer rating.


SELECT *
FROM Supermarket1

--- 1.	What is the total revenue generated by each branch?
SELECT branch, SUM(grossincome) as total_revenue
FROM Supermarket1
GROUP BY branch


---2.  Which branch has the highest gross income
SELECT branch, SUM(grossincome) as total_revenue, 
  AVG(grossmarginpercentage) as avg_gross_margin, 
  AVG(quantity) as avg_quantity_sold, 
  AVG(unit_price) as avg_unit_price
FROM Supermarket1
GROUP BY branch
ORDER BY total_revenue DESC
LIMIT 1


--- 3. What is the total quantity of products sold per branch and per product line?
SELECT branch, productline, SUM(quantity) as total_quantity_sold
FROM Supermarket1
GROUP BY branch, productline


---4. What is the average gross margin percentage per product line?
SELECT productline, AVG(grossmarginpercentage) as avg_gross_margin
FROM Supermarket1
GROUP BY productline


---5. What is the percentage of sales made by members versus non-members?
SELECT customertype, SUM(grossincome) as total_income, 
  SUM(grossincome) / 
  (SELECT SUM(grossincome) FROM Supermarket1) * 100 as percentage_of_sales
FROM Supermarket1
GROUP BY customertype

--- 6.  What is the average customer rating for each product line?
SELECT productline, AVG(rating) as avg_customer_rating
FROM Supermarket1
GROUP BY productline


---7. What is the distribution of payment methods used by customers?
SELECT payment, COUNT(*) as payment_method_count, 
  COUNT(*) / (SELECT COUNT(*) FROM Supermarket1) * 100 as payment_method_percentage
FROM Supermarket1
GROUP BY payment


---8. What is the average shopping time per branch and per product line?
SELECT branch, productline, AVG(time) as avg_shopping_time
FROM Supermarket1
GROUP BY branch, productline


---9. What is the total tax revenue collected per branch and per product line?
SELECT branch, productline, SUM(tax5%) as total_tax_revenue
FROM Supermarket1
GROUP BY branch, productline


---10. What is the gender distribution of customers per branch and per product line?
SELECT branch, productline, gender, COUNT(*) as gender_count,
  COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY branch, productline) * 100 as gender_percentage
FROM Supermarket1
GROUP BY branch, productline, gender


---11. What is the most popular product line in each branch?
SELECT branch, productline, COUNT(*) as product_count
FROM Supermarket1
GROUP BY branch, productline
ORDER BY branch, product_count DESC


---12. What is the average unit price for each product line?
SELECT productline, AVG(unitprice) as avg_unit_price
FROM Supermarket1
GROUP BY productline


---13.  What is the total quantity of products sold per customer type and per payment method?
SELECT customertype, payment, SUM(quantity) as total_quantity
FROM Supermarket1
GROUP BY customertype, payment


---14. What is the average gross income per customer type and per payment method?
SELECT customertype, payment, AVG(grossincome) as avg_gross_income
FROM Supermarket1
GROUP BY customertype, payment


---15. What is the relationship between shopping date and sales revenue?
SELECT date, SUM(grossincome) as total_gross_income
FROM Supermarket1
GROUP BY date


---16. What is the relationship between shopping time and customer rating?
SELECT time, AVG(rating) as avg_customer_rating
FROM Supermarket1
GROUP BY time


---17. What is the relationship between gender and customer rating?
SELECT gender, AVG(rating) as avg_customer_rating
FROM Supermarket1
GROUP BY gender


---18. What is the relationship between product line and customer rating?
SELECT productline, AVG(rating) as avg_customer_rating
FROM Supermarket1
GROUP BY productline


---19. What is the relationship between payment method and customer rating?
SELECT payment, AVG(rating) as avg_customer_rating
FROM Supermarket1
GROUP BY payment


---- 20. What are the most common complaints or issues raised by customers in 
-- their rating comments?
SELECT rating, COUNT(*) as comment_count
FROM Supermarket1
WHERE rating <= 3
GROUP BY rating
ORDER BY comment_count DESC
LIMIT 10






