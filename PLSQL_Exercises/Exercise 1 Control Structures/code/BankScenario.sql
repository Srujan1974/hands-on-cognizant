SET SERVEROUTPUT ON;

------------------------------------------------------------
-- Create Customers Table
------------------------------------------------------------

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    Age NUMBER,
    Balance NUMBER,
    IsVIP VARCHAR2(5)
);

------------------------------------------------------------
-- Create Loans Table
------------------------------------------------------------

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    InterestRate NUMBER,
    DueDate DATE,
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);

------------------------------------------------------------
-- Insert Sample Data into Customers
------------------------------------------------------------

INSERT INTO Customers VALUES (101,'John',65,12000,'FALSE');
INSERT INTO Customers VALUES (102,'Alice',45,8000,'FALSE');
INSERT INTO Customers VALUES (103,'David',70,15000,'FALSE');
INSERT INTO Customers VALUES (104,'Emma',35,5000,'FALSE');

COMMIT;

------------------------------------------------------------
-- Insert Sample Data into Loans
------------------------------------------------------------

INSERT INTO Loans VALUES (201,101,9,DATE '2026-07-15');
INSERT INTO Loans VALUES (202,102,10,DATE '2026-09-10');
INSERT INTO Loans VALUES (203,103,8,DATE '2026-07-20');
INSERT INTO Loans VALUES (204,104,11,DATE '2026-10-05');

COMMIT;

------------------------------------------------------------
-- Display Initial Data
------------------------------------------------------------

SELECT * FROM Customers;

SELECT * FROM Loans;

------------------------------------------------------------
-- Scenario 1
-- Apply 1% Discount to Loan Interest Rates
-- for Customers Above 60 Years
------------------------------------------------------------

BEGIN

    FOR cust IN (
        SELECT CustomerID, Age
        FROM Customers
    ) LOOP

        IF cust.Age > 60 THEN

            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = cust.CustomerID;

            DBMS_OUTPUT.PUT_LINE(
                'Discount applied for Customer ID: '
                || cust.CustomerID
            );

        END IF;

    END LOOP;

    COMMIT;

END;
/

------------------------------------------------------------
-- Verify Scenario 1
------------------------------------------------------------

SELECT * FROM Loans;

------------------------------------------------------------
-- Scenario 2
-- Promote Customers to VIP
------------------------------------------------------------

BEGIN

    FOR cust IN (
        SELECT CustomerID, Balance
        FROM Customers
    ) LOOP

        IF cust.Balance > 10000 THEN

            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = cust.CustomerID;

            DBMS_OUTPUT.PUT_LINE(
                'Customer ID '
                || cust.CustomerID
                || ' promoted to VIP.'
            );

        END IF;

    END LOOP;

    COMMIT;

END;
/

------------------------------------------------------------
-- Verify Scenario 2
------------------------------------------------------------

SELECT * FROM Customers;

------------------------------------------------------------
-- Scenario 3
-- Loan Reminder for Loans Due
-- Within the Next 30 Days
------------------------------------------------------------

BEGIN

    FOR loan_rec IN (

        SELECT c.CustomerID,
               c.Name,
               l.LoanID,
               l.DueDate

        FROM Customers c
        JOIN Loans l
        ON c.CustomerID = l.CustomerID

        WHERE l.DueDate
        BETWEEN SYSDATE
        AND SYSDATE + 30

    ) LOOP

        DBMS_OUTPUT.PUT_LINE(

            'Reminder: Dear '
            || loan_rec.Name
            || ', your Loan ID '
            || loan_rec.LoanID
            || ' is due on '
            || TO_CHAR(loan_rec.DueDate,'DD-MON-YYYY')

        );

    END LOOP;

END;
/

------------------------------------------------------------
-- End of Program
------------------------------------------------------------