use ExcelR;
select COUNT(*) from bank_data;
select * from bank_data;
--Total Loan Amount and Funded Amount
SELECT 
    SUM([Loan_Amount]) AS total_loan_requested,
    SUM([Funded_Amount]) AS total_funded_amount
FROM bank_data;

--Total Loans
SELECT COUNT(*) AS total_loans FROM bank_data;

--Total Collection and Revenue
SELECT 
    SUM([Total_Collection]) AS total_collected,
    SUM([Total_Revenue]) AS total_revenue
FROM bank_data;

--Branch-Wise Revenue
SELECT 
    [Branch_Name], 
    SUM([Total_Revenue]) AS revenue
FROM bank_data
GROUP BY [Branch_Name]
ORDER BY revenue DESC;

--State-Wise Loan Count
SELECT 
    [State_Name], 
    COUNT(*) AS total_loans
FROM bank_data	
GROUP BY [State_Name]
ORDER BY total_loans DESC;

--Religion-Wise Loan Distribution
SELECT 
    Religion, 
    COUNT(*) AS loan_count
FROM bank_data
GROUP BY Religion;

--Loan Status Breakdown
SELECT 
    [Loan_Status], 
    COUNT(*) AS loan_count
FROM bank_data
GROUP BY [Loan_Status];

--Product Group-wise Loan Distribution
SELECT [Product_Id], COUNT(*) AS loan_count
FROM bank_data
GROUP BY [Product_Id]
ORDER BY loan_count DESC;

--Disbursement Trend
SELECT YEAR([Disbursement_Date]) AS disbursed_year, COUNT(*) AS loan_count
FROM bank_data
WHERE [Disbursement_Date] IS NOT NULL
GROUP BY YEAR([Disbursement_Date])
ORDER BY disbursed_year;

--Grade-Wise Loan
SELECT Grade, COUNT(*) AS loan_count FROM bank_data GROUP BY Grade;

--Count of Default Loans
SELECT COUNT(*) AS default_loan_count FROM bank_data WHERE [Is_Default_Loan] = '1';

--Count of Delinquent Clients
SELECT COUNT(DISTINCT [Client_id]) AS delinquent_clients FROM bank_data WHERE [Is_Delinquent_Loan]= '1';

--Loan Status-Wise Loan
SELECT [Loan_Status], COUNT(*) AS loan_count FROM bank_data GROUP BY [Loan_Status];

--No Verified Loan
SELECT COUNT(*) AS no_verified_loans FROM bank_data WHERE [Verification_Status] = 'Verified';

--Loan Maturity
SELECT Term AS loan_term_months, COUNT(*) AS loan_count FROM bank_data GROUP BY Term ORDER BY loan_term_months;


