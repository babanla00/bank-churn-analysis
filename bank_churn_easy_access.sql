CREATE VIEW master_info AS
SELECT
c.customer_id, c.last_name, c.credit_score,
c.geography, c.gender, c.age, c.tenure_years, c.estimated_salary,
a.balance, a.num_of_product, a.has_credit_card, a.is_active_member, a.exited
FROM customer_info3 c
JOIN account_info3 a
ON c.customer_id = a.customer_id;

DELIMITER $$
CREATE PROCEDURE regional_churn_report (geography VARCHAR(50))
BEGIN
    SELECT 
        Gender,
        COUNT(*) AS Total_customer,
        ROUND(AVG(CAST(exited AS FLOAT)) * 100, 2) AS Churn_rate
    FROM master_info
    GROUP BY Gender;
END $$
DELIMITER $$


CALL regional_churn_report ('Spain')





