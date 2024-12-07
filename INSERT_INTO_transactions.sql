-- Inserting sample data into transactions table
INSERT INTO transactions (transaction_id, transaction_date, customer_id, amount, status)
VALUES (1, TO_DATE('2024-10-15', 'YYYY-MM-DD'), 101, 1000, 'Completed');

INSERT INTO transactions (transaction_id, transaction_date, customer_id, amount, status)
VALUES (2, TO_DATE('2024-10-16', 'YYYY-MM-DD'), 102, 2000, 'Pending');

INSERT INTO transactions (transaction_id, transaction_date, customer_id, amount, status)
VALUES (3, TO_DATE('2024-10-17', 'YYYY-MM-DD'), 103, 1500, 'Completed');

INSERT INTO transactions (transaction_id, transaction_date, customer_id, amount, status)
VALUES (4, TO_DATE('2024-10-20', 'YYYY-MM-DD'), 104, 2500, 'Completed');

INSERT INTO transactions (transaction_id, transaction_date, customer_id, amount, status)
VALUES (5, TO_DATE('2024-11-01', 'YYYY-MM-DD'), 105, 3000, 'Pending');
