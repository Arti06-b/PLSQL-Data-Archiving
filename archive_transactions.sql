CREATE OR REPLACE PROCEDURE archive_transactions IS
    -- Declare a cursor to select the transactions that need to be archived
    CURSOR c_transactions IS
        SELECT transaction_id, transaction_date, customer_id, amount, status
        FROM transactions
        WHERE transaction_date < TRUNC(SYSDATE, 'MM'); -- Archive transactions older than the current month

    -- Declare variables to store data fetched from the cursor
    v_transaction_id transactions.transaction_id%TYPE;
    v_transaction_date transactions.transaction_date%TYPE;
    v_customer_id transactions.customer_id%TYPE;
    v_amount transactions.amount%TYPE;
    v_status transactions.status%TYPE;
    v_archive_date DATE := SYSDATE;  -- Archive date is the current date

    -- Exception handling variables
    v_error_message VARCHAR2(4000);
BEGIN
    -- Open the cursor
    OPEN c_transactions;

    -- Loop through each record in the cursor
    LOOP
        -- Fetch data from the cursor
        FETCH c_transactions INTO v_transaction_id, v_transaction_date, v_customer_id, v_amount, v_status;

        -- Exit the loop when no more rows are found
        EXIT WHEN c_transactions%NOTFOUND;

        BEGIN
            -- Insert into the archive table
            INSERT INTO transactions_archive (transaction_id, transaction_date, customer_id, amount, status, archive_date)
            VALUES (v_transaction_id, v_transaction_date, v_customer_id, v_amount, v_status, v_archive_date);

            -- Delete the archived transaction from the live table
            DELETE FROM transactions WHERE transaction_id = v_transaction_id;

            -- Log the successful archiving (optional)
            DBMS_OUTPUT.PUT_LINE('Transaction ' || v_transaction_id || ' archived successfully.');

        EXCEPTION
            WHEN OTHERS THEN
                -- Handle errors during individual transaction archiving
                v_error_message := 'Error archiving transaction ID ' || v_transaction_id || ': ' || SQLERRM;
                DBMS_OUTPUT.PUT_LINE(v_error_message);

                -- Log the error to an error table if needed
                -- INSERT INTO error_log (error_message, error_date) VALUES (v_error_message, SYSDATE);
        END;
    END LOOP;

    -- Close the cursor after processing all records
    CLOSE c_transactions;

    -- Commit changes after successful archiving
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Monthly archiving completed.');
EXCEPTION
    WHEN OTHERS THEN
        -- Handle errors outside the loop
        v_error_message := 'General error during archiving: ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(v_error_message);

        -- Rollback changes in case of a general error
        ROLLBACK;
END archive_transactions;
/
