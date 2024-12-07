# PL/SQL Data Archiving Procedure

## Overview

This project contains a PL/SQL procedure to automate monthly data archiving from a live transactions table (`transactions`) to an archive table (`transactions_archive`). The procedure ensures transaction safety using cursors and exception handling.

### Key Features
- Uses a cursor to fetch transactions for archiving.
- Performs bulk operations for efficient data management.
- Includes robust exception handling to log and manage errors gracefully.
- Deletes archived records from the live table.

## Table Schema

1. **`transactions` (Live Table)**:
   - `transaction_id`: Primary Key
   - `transaction_date`: Date of transaction
   - `customer_id`: Customer ID
   - `amount`: Transaction amount
   - `status`: Transaction status (e.g., Completed, Pending)

2. **`transactions_archive` (Archive Table)**:
   - Same columns as `transactions`, with an additional `archive_date`.

## How to Use

1. Run `sample_data.sql` to create the schema and populate sample data.
2. Execute the `archive_transactions.sql` procedure to perform archiving.
3. Verify:
   - Archived data is inserted into `transactions_archive`.
   - Data is removed from the `transactions` table.

## Example Output

### Sample DBMS Output

