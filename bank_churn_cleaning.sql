SELECT*
FROM account_info;

SELECT*
FROM customer_info;

SELECT*
FROM bank_churn;

SELECT*
FROM bank_churn_data_dictionary;

--- Account_info
SELECT*
FROM account_info;

CREATE TABLE account_info2
LIKE account_info;

SELECT*
FROM account_info2;

INSERT INTO account_info2
SELECT*
FROM account_info;

ALTER TABLE account_info2
RENAME COLUMN CustomerId TO customer_id,
RENAME COLUMN Balance TO balance,
RENAME COLUMN NumOfProducts TO num_of_product,
RENAME COLUMN HasCrCard TO has_credit_card,
RENAME COLUMN Tenure TO tenure_years,
RENAME COLUMN IsActiveMember TO is_active_member,
RENAME COLUMN Exited TO exited;

SELECT*,
ROW_NUMBER() OVER(PARTITION BY customer_id,balance, num_of_product, 
has_credit_card,tenure_years, is_active_member,exited) row_num
FROM account_info2;

WITH duplicate_cte AS
(
SELECT*,
ROW_NUMBER() OVER(PARTITION BY customer_id,balance, num_of_product, 
has_credit_card,tenure_years, is_active_member,exited) row_num
FROM account_info2
)
SELECT*
FROM duplicate_cte
WHERE row_num > 1;

SELECT COUNT(*)
FROM account_info2;

SELECT COUNT(DISTINCT customer_id)
FROM account_info2;

CREATE TABLE account_info3
LIKE account_info2;

ALTER TABLE account_info3
ADD  row_num INT;

INSERT INTO account_info3
SELECT*,
ROW_NUMBER() OVER(PARTITION BY customer_id,balance, num_of_product, 
has_credit_card,tenure_years, is_active_member,exited) row_num
FROM account_info2;

SELECT*
FROM account_info3
WHERE row_num > 1;

DELETE 
FROM account_info3
WHERE row_num > 1;

---
SELECT*
FROM account_info3;

SELECT COUNT(DISTINCT customer_id)
FROM account_info3;

UPDATE account_info3
SET balance = REPLACE(balance, '€', '');

UPDATE account_info3
SET balance = REPLACE(balance, ',', '');

UPDATE account_info3
SET balance = LTRIM(balance);

ALTER TABLE account_info3
DROP COLUMN row_num;

SELECT*
FROM account_info3;

--- Customer info
SELECT*
FROM customer_info;

CREATE TABLE customer_info2
LIKE customer_info;

SELECT*
FROM customer_info2;

INSERT INTO customer_info2
SELECT*
FROM customer_info;


ALTER TABLE customer_info2
DROP COLUMN `MyUnknownColumn`,
DROP COLUMN `MyUnknownColumn_[0]`,
DROP COLUMN `MyUnknownColumn_[1]`,
DROP COLUMN `MyUnknownColumn_[2]`,
DROP COLUMN `MyUnknownColumn_[3]`,
DROP COLUMN `MyUnknownColumn_[4]`;

SELECT*
FROM customer_info2;

ALTER TABLE customer_info2
RENAME COLUMN CustomerId TO customer_id,
RENAME COLUMN Surname TO last_name,
RENAME COLUMN CreditScore TO credit_score,
RENAME COLUMN Geography TO geography,
RENAME COLUMN Gender TO gender,
RENAME COLUMN Age TO age,
RENAME COLUMN Tenure TO tenure_years,
RENAME COLUMN EstimatedSalary TO estimated_salary;

SELECT*,
ROW_NUMBER() OVER(PARTITION BY customer_id, last_name, credit_score, geography, 
age, tenure_years, estimated_salary ) row_num
FROM customer_info2;

WITH duplicate_id AS
(
SELECT*,
ROW_NUMBER() OVER(PARTITION BY customer_id, last_name, credit_score, geography, 
age, tenure_years, estimated_salary ) row_num
FROM customer_info2
)
SELECT*
FROM duplicate_id
WHERE row_num > 1;

CREATE TABLE customer_info3
LIKE customer_info2;

SELECT*
FROM customer_info3;

ALTER TABLE customer_info3
ADD  row_num INT;

INSERT INTO customer_info3
SELECT*,
ROW_NUMBER() OVER(PARTITION BY customer_id, last_name, credit_score, geography, 
age, tenure_years, estimated_salary ) row_num
FROM customer_info2;

SELECT*
FROM customer_info3
WHERE row_num > 1;

DELETE
FROM customer_info3
WHERE row_num > 1;

SELECT*
FROM customer_info3;

ALTER TABLE customer_info3
DROP COLUMN row_num;

---
SELECT*
FROM customer_info3
WHERE customer_id IS NULL
AND tenure_years IS NULL;

SELECT*
FROM customer_info3
WHERE geography LIKE 'FR%';

UPDATE customer_info3
SET geography = 'France'
WHERE geography IN ('FRA', 'French');

UPDATE customer_info3
SET geography = 'Germany'
WHERE geography IN ('GER', 'Germany');

UPDATE customer_info3
SET geography = 'Spain'
WHERE geography IN ('ESP', 'Spain');

UPDATE customer_info3
SET estimated_salary = REPLACE(estimated_salary, '€', '');

ALTER TABLE customer_info3
MODIFY estimated_salary DECIMAL(12,2);

SELECT*
FROM customer_info3;

--- bank churn cleaning
SELECT*
FROM bank_churn;

CREATE TABLE bank_churn2
LIKE bank_churn;

SELECT*
FROM bank_churn2;

INSERT INTO bank_churn2
SELECT*
FROM bank_churn;

ALTER TABLE bank_churn2
RENAME COLUMN CustomerId TO customer_id,
RENAME COLUMN Surname TO last_name,
RENAME COLUMN CreditScore TO credit_score,
RENAME COLUMN Geography TO geography,
RENAME COLUMN Gender TO gender,
RENAME COLUMN Age TO age,
RENAME COLUMN Tenure TO tenure_years,
RENAME COLUMN Balance TO balance,
RENAME COLUMN NumOfProducts TO num_of_product,
RENAME COLUMN HasCrCard TO has_credit_card,
RENAME COLUMN IsActiveMember TO is_active_member,
RENAME COLUMN EstimatedSalary TO estimated_salary,
RENAME COLUMN Exited TO exited;

SELECT*
FROM bank_churn2;

SELECT*,
ROW_NUMBER() OVER(PARTITION BY customer_id,last_name, credit_score, 
geography, gender, age, tenure_years,balance, num_of_product, 
has_credit_card, is_active_member, estimated_salary, 
exited) roww_num
FROM bank_churn2;

WITH duplicate_churn AS
(
SELECT*,
ROW_NUMBER() OVER(PARTITION BY customer_id,last_name, credit_score, 
geography, gender, age, tenure_years,balance, num_of_product,
 has_credit_card, is_active_member, estimated_salary, 
exited) roww_num
FROM bank_churn2)
SELECT *
FROM duplicate_churn
WHERE roww_num > 1;

SELECT*
FROM bank_churn2;

ALTER TABLE bank_churn2
MODIFY balance DECIMAL(12,2);

ALTER TABLE bank_churn2
MODIFY estimated_salary DECIMAL(12,2);

