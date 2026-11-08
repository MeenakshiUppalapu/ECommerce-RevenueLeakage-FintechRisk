import pandas as pd
# import numpy as np

# 1. LOAD THE DATASETS
# (Ensure these match the exact filenames from your Kaggle downloads)
ecom_orders = pd.read_csv('olist_order_items_dataset.csv')
ecom_customers = pd.read_csv('olist_orders_dataset.csv')
credit_data = pd.read_csv('Loan_default.csv')

# 2. AGGREGATE E-COMMERCE SPEND PER CUSTOMER
# Calculate exactly how much each order cost total
order_spend = ecom_orders.groupby('order_id')['price'].sum().reset_index()
# Map those orders back to unique customer IDs
customer_map = pd.merge(ecom_customers[['order_id', 'customer_id']], order_spend, on='order_id')
customer_profiles = customer_map.groupby('customer_id')['price'].sum().reset_index()

# Sort customers from lowest spend to highest spend
customer_profiles = customer_profiles.sort_values(by='price').reset_index(drop=True)

# 3. PREPARE THE FINTECH RISK DATA
# Grab the exact columns from Nikhil1e9's dataset, sorting by income
risk_profiles = credit_data[['LoanID', 'Income', 'Default']].copy()
risk_profiles = risk_profiles.sort_values(by='Income').reset_index(drop=True)

# 4. EQUALIZE DATASET SIZES
# The Olist dataset has ~96k unique customers, while the loan dataset has ~255k rows.
# We truncate the larger one so they line up perfectly 1:1.
min_rows = min(len(customer_profiles), len(risk_profiles))
customer_profiles = customer_profiles.head(min_rows)
risk_profiles = risk_profiles.head(min_rows)

# 5. THE FINTECH SIDE-BY-SIDE CONCATENATION
# Using axis=1 joins them horizontally by row position instead of requiring a shared key.
embedded_finance_dataset = pd.concat([customer_profiles, risk_profiles], axis=1)

# Drop redundant system identifiers to keep the portfolio data clean
embedded_finance_dataset = embedded_finance_dataset.drop(columns=['LoanID'])

# Rename columns to fit a professional corporate environment
embedded_finance_dataset.columns = [
    'customer_unique_id', 'total_ecom_spend', 'annual_income', 'bnpl_default_status'
]

# Save your integrated master file for SQL, Tableau, or Power BI analysis
embedded_finance_dataset.to_csv('embedded_finance_risk_matrix.csv', index=False)
print(f"Master Dataset Formed! {min_rows} rows mapped successfully.")
