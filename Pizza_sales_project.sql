Create database Pizzahut;
Use Pizzahut;
Go
Select * from Orders;
Select * from pizza_types;
Select * from Order_details;
Select * from pizzas;	
Go
-----------------------------------------------------------------------------------------------------------------------------
--Question 1> Retrieve the total number of orders place?

Select Count(order_id) as Total_orders
From orders;

-----------------------------------------------------------------------------------------------------------------------------
--Question 2> Calculate the total revenue generated from pizza sales?

Select Round(SUM(od.quantity*p.price),2) as Total_sales
From order_details OD Inner Join pizzas p 
ON p.pizza_id = OD.pizza_id;

-----------------------------------------------------------------------------------------------------------------------------
--Questions 3> Identify the highest-priced pizza?

Select Top 1 PT.name , P.price
From pizza_types PT Inner Join pizzas P
ON PT.pizza_type_id=P.pizza_type_id
Order By P.price Desc;

-----------------------------------------------------------------------------------------------------------------------------
--Question 4> Identify the most common pizza size ordered?

Select P.size, COUNT(OD.Order_details_id) as Common_Pizza
From pizzas P Inner Join order_details OD 
ON P.pizza_id=OD.pizza_id
Group By P.size
Order By Common_Pizza Desc;

-----------------------------------------------------------------------------------------------------------------------------
--Question 5> List the top 5 most ordered pizza types along with their quantities?

Select Top 5 PT.name, sum(OD.quantity) as Quantity
From pizza_types PT Inner Join pizzas P
ON PT.pizza_type_id=P.pizza_type_id Inner Join order_details OD
ON OD.pizza_id=P.pizza_id
Group By PT.name
Order by Quantity Desc;

-----------------------------------------------------------------------------------------------------------------------------
--Question 6> Join the necessary tables to find the total quantity of each pizza category ordered?

Select PT.category, SUM(od.quantity) as TotalQuantity
From pizza_types PT Inner join pizzas P
ON PT.pizza_type_id=P.pizza_type_id Inner join order_details OD 
ON OD.pizza_id=P.pizza_id
Group BY PT.category
Order By TotalQuantity Desc;

-----------------------------------------------------------------------------------------------------------------------------
--Question 7> Join relevant tables to find the category-wise distribution of pizzas?   

Select category, COUNT(name) as Categorywisepizzas
From pizza_types
Group By category;

-----------------------------------------------------------------------------------------------------------------------------
--Question 8> Group the orders by date and calculate the average number of pizzas ordered per day?

Select Round(AVG(Quantity_pizzas),0)as Average_ordered_pizzas From (
Select O.date, SUM(OD.quantity) as Quantity_pizzas
From orders O Inner Join order_details OD 
ON O.order_id=OD.order_id
Group By O.date
) as Ordered_Quantity;

-----------------------------------------------------------------------------------------------------------------------------
--Question 9> Determine the top 3 most ordered pizza types based on revenue?


Select Top 3 PT.name, Sum(OD.Quantity*P.Price) as Revenue
From order_details OD Inner Join pizzas P
ON OD.pizza_id=P.pizza_id Inner Join pizza_types PT
ON PT.pizza_type_id=P.pizza_type_id
Group By PT.name
Order By Revenue Desc;

-----------------------------------------------------------------------------------------------------------------------------
--Question 10> Analyze the cumulative revenue generated over time?

Select time , Sum(Revenue) over(Order by time) as Cum_revenue
From
(Select O.time, Sum(OD.Quantity*P.Price) as Revenue
From order_details OD Inner join pizzas P 
ON OD.pizza_id=P.pizza_id Inner join orders O 
ON O.order_id=OD.order_id
Group by O.time) as Sales;

-----------------------------------------------------------------------------------------------------------------------------

