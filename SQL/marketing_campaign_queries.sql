-- Create a database 'marketing_campaign_analysis':
CREATE DATABASE marketing_campaign_analysis;

-- Use database marketing_campaign_analysis:
USE marketing_campaign_analysis;

-- Create a table into a database marketing_campaign_analysis:
CREATE TABLE marketing_campaign(
ID INT,
Year_Birth INT,
Education VARCHAR(50),
Marital_Status VARCHAR(50),
Income INT,
Kid_Home INT,
Teen_Home INT,
Dt_Customer DATE,
Recency INT,
MntWines INT,
MntFruits INT,
MntMeatProducts INT,
MntFishProducts INT,
MntSweetProducts INT,
MntGoldProds INT,
NumDealsPurchases INT,
NumWebPurchases INT,
NumCatalogPurchases INT,
NumStoresPurchases INT,
NumWebVisitedMonth INT,
AcceptedCmp3 INT,
AcceptedCmp4 INT,
AcceptedCmp5 INT,
AcceptedCmp1 INT,
AcceptedCmp2 INT,
Complain INT,
Z_CostContact INT,
Z_Revenue INT,
Response INT,
Age INT,
Total_Spending INT,
Total_Purchases INT,
Total_Children INT,
maritalstatus VARCHAR(50),
Income_Category VARCHAR(50)
);

-- Drop the Marital_status, kid_home, teen_home From the marketing campaign:
ALTER TABLE marketing_campaign
DROP Marital_Status,
DROP kid_Home,
DROP Teen_Home;

-- Ques 1. What are the Total_Customers?
SELECT COUNT(*) AS total_customers 
FROM marketing_campaign;

-- Ques 2. What is the Average Income?
SELECT AVG(Income) AS average_income
FROM marketing_campaign;

-- Ques 3. What is the Total Revenue?
SELECT SUM(Total_Spending) AS total_revenue
FROM marketing_campaign;

-- Ques 4. What is the Product Revenue?
SELECT SUM(MntWines) AS mnt_wines,
	   SUM(MntFruits) AS mnt_fruits,
	   SUM(MntMeatProducts) AS mnt_meat,
	   SUM(MntFishProducts) AS mnt_fish,
	   SUM(MntSweetProducts) AS mnt_sweet,
	   SUM(MntGoldProds) AS mnt_gold 
FROM marketing_campaign;

-- Ques 5. What is the total spending by education?
SELECT Education, SUM(Total_Spending) AS total_spending
FROM marketing_campaign
GROUP BY Education
ORDER BY Total_Spending DESC;

-- Ques 6. What is the total spending by Marital Status?
SELECT maritalstatus, SUM(Total_Spending) AS total_spending
FROM marketing_campaign
GROUP BY maritalstatus
ORDER BY Total_Spending DESC;

-- Ques 7. What are the high value customers?
SELECT ID,
	Income,
    Total_Spending
FROM marketing_campaign
ORDER BY Total_Spending DESC
LIMIT 10;

-- Ques 8. What a customer is spent on the basis of Income?
SELECT
CASE
	WHEN Income < 30000 THEN 'Low income'
    WHEN Income BETWEEN 30000 AND 70000 THEN 'Middle Income'
    ELSE 'Hign Income'
END AS income_group,
SUM(Total_Spending) AS total_spending
FROM marketing_campaign
GROUP BY income_group;

-- Ques 9: What is the total spending by total children?
SELECT Total_Children, SUM(Total_Spending) AS total_spending
FROM marketing_campaign
GROUP BY Total_Children
ORDER BY Total_Spending DESC;

-- Ques 10: What is the total spending by Recency?
SELECT Recency, SUM(Total_Spending) AS total_spending
FROM marketing_campaign
GROUP BY Recency
ORDER BY Total_Spending DESC;

-- Ques 11: Do couple By more wine?
SELECT maritalstatus, SUM(mntWines) AS mnt_wines
FROM marketing_campaign
GROUP BY maritalstatus
ORDER BY mnt_wines DESC;

-- Ques 12: Segment customers on the basis of spending level?
SELECT ID,
Total_Spending,
CASE 
	WHEN Total_Spending > 1000 THEN 'Higher Spender'
    WHEN Total_Spending BETWEEN 500 AND 1000 THEN 'Medium Spender'
    ELSE 'LOWER SPENDER'
END AS spending_segment
FROM marketing_campaign;

-- Ques 13: Segment customers on the basis of Purchase level?
SELECT
CASE
	WHEN NumWebPurchases > NumStoresPurchases
		AND NumWebPurchases > NumCatalogPurchases THEN 'Web Shoppers'
	WHEN NumStoresPurchases > NumWebPurchases
		AND NumStoresPurchases > NumCatalogPurchases THEN 'Store Shoppers'
	ELSE 'Catalog Shoppers'
END AS preferred_channel,
COUNT(*) AS total_customers
FROM marketing_campaign
GROUP BY preferred_channel;

-- Ques 14: High Income vs High Spending customers
SELECT 
ID,
Income,
Total_Spending
FROM marketing_campaign
WHERE Income > 70000
ORDER BY Total_Spending DESC
LIMIT 10;

-- Ques 15. How many customers who respond the campaigns?
SELECT Education,
COUNT(*) AS accepted_campaign
FROM marketing_campaign
WHERE response = 1
GROUP BY Education
ORDER BY accepted_campaign DESC;

-- Ques 16. How many customers are loyal using recency?
SELECT
CASE
	WHEN Recency <= 30 THEN 'Highly Active'
    WHEN Recency BETWEEN 31 AND 60 THEN 'Moderately Active'
    ELSE 'Inactive'
END AS customer_activity,
COUNT(*) AS Total_customers
FROM marketing_campaign
GROUP BY customer_activity;
    