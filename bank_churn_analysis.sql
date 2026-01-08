SELECT*
FROM account_info3;

SELECT*
FROM customer_info3;


SELECT*
FROM customer_info3 c
JOIN account_info3 a
ON c.customer_id = a.customer_id;

WITH master_info AS
(
SELECT
c.customer_id,
c.last_name,
c.credit_score,
c.geography,
c.gender,
c.age,
c.tenure_years,
c.estimated_salary,
a.balance,
a.num_of_product,
a.has_credit_card,
a.is_active_member,
a.exited
FROM customer_info3 c
JOIN account_info3 a
ON c.customer_id = a.customer_id
)
SELECT*
FROM master_info;

--- churn rate
SELECT 
	COUNT(*) total_customers,
	SUM(exited) total_churned,
	ROUND(CAST(SUM(exited) AS FLOAT) / COUNT(*) *100, 2) churn_rate_percent
FROM bank_churn2;

--- churn_by_geography_and_gender

WITH master_info AS
(
SELECT
c.customer_id,
c.last_name,
c.credit_score,
c.geography,
c.gender,
c.age,
c.tenure_years,
c.estimated_salary,
a.balance,
a.num_of_product,
a.has_credit_card,
a.is_active_member,
a.exited
FROM customer_info3 c
JOIN account_info3 a
ON c.customer_id = a.customer_id
)
SELECT
geography,
gender,
COUNT(*) total_customers,
SUM(exited) total_churned,
ROUND(CAST(AVG(exited) AS FLOAT) *100, 2) churn_rate
FROM master_info
GROUP BY geography, gender
ORDER BY churn_rate DESC;

SELECT
  CASE
	WHEN age < 30 THEN 'Young Adult(18-29)'
	WHEN age BETWEEN 30 AND 45 THEN 'Adult(30-45)'
    WHEN age BETWEEN 45 AND 60 THEN 'Middle Age(45-60)'
    ELSE 'Old(60+)'
END AS age_bracket,
COUNT(*) total_customers,
SUM(exited) total_churned,
ROUND(CAST(AVG(exited) AS FLOAT) *100, 2) churn_rate
FROM bank_churn2
GROUP BY age_bracket
ORDER BY churn_rate DESC;


--- Products, activity_status an_d churn_rate relationship
SELECT
num_of_product,
is_active_member,
COUNT(*) Total_customer,
SUM(exited) Total_exited,
ROUND(AVG(CAST(exited AS FLOAT)) *100, 2) Churn_rate,
ROUND(AVG(balance)) Avg_balance
FROM master_info
GROUP BY num_of_product, is_active_member
ORDER BY num_of_product DESC, is_active_member;


SELECT*
FROM bank_churn_data_dictionary;





