use ExcelR;
 select count(*) from credit_and_debit;
 select * from credit_and_debit;

 --Total Credit Amount
SELECT SUM(Amount) AS total_credit_amount
FROM credit_and_debit
WHERE [Transaction_Type] = 'Credit';

--Total Debit Amount
SELECT SUM(Amount) AS total_debit_amount
FROM credit_and_debit
WHERE [Transaction_Type] = 'Debit';

--Credit to Debit Ratio
SELECT 
    CAST(SUM(CASE WHEN [Transaction_Type] = 'Credit' THEN Amount ELSE 0 END) AS FLOAT) /
    NULLIF(SUM(CASE WHEN [Transaction_Type] = 'Debit' THEN Amount ELSE 0 END), 0) AS credit_debit_ratio
FROM credit_and_debit;

--Net Transaction Amount
SELECT 
    SUM(CASE WHEN [Transaction_Type] = 'Credit' THEN Amount ELSE 0 END) -
    SUM(CASE WHEN [Transaction_Type] = 'Debit' THEN Amount ELSE 0 END) AS net_transaction_amount
FROM credit_and_debit;

SELECT 
    [Bank_Name], 
    [Branch], 
    ROUND(SUM([Amount]), 2) AS Total_Transaction_Amount
FROM 
    credit_and_debit
GROUP BY 
    [Bank_Name], 
    [Branch]
ORDER BY 
    [Bank_Name], 
    [Branch];



CREATE PROCEDURE Get_transactions_dates
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT *
    FROM credit_and_debit
    WHERE [Transaction_Date] BETWEEN @StartDate AND @EndDate;
END;

EXEC Get_transactions_dates '2024-01-01', '2024-12-31';

drop procedure Show_bank_transactions;
--Transactions for a particular Bank
CREATE PROCEDURE Show_bank_transactions
    @BankName NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM credit_and_debit
    WHERE [Bank_Name] = @BankName;
END;
EXEC Show_bank_transactions 'HDFC Bank';

drop procedure Show_customer_data;
--Displaying transactions of a particular customer
CREATE PROCEDURE Show_customer_data
    @CustomerName NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM credit_and_debit
    WHERE [Customer_Name] = @CustomerName;
END;
EXEC Show_customer_data 'John Ford';

drop view Branch_Transaction;
--View for branch wise transcations
CREATE VIEW Branch_Transaction AS
SELECT 
    Branch,
    SUM(Amount) AS Total_Transaction_Amount,
    COUNT(*) AS Transaction_Count
FROM credit_and_debit
GROUP BY Branch;

SELECT * FROM Branch_Transaction;

