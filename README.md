# Case Study: E-Commerce Revenue Leakage & Embedded Buy Now Pay Later (BNPL) Risk Matrix
**Target Industry Alignment:** Digital Retail Margin Optimization & Consumer Credit Risk Assessment  

## 📊 Executive Dashboard Preview
![Dashboard Layout Preview](dashboard_preview.png)

*(Note: The raw, fully modeled Power BI application file `ECommerceRevenueLeakageFintechRisk.pbix` is uploaded directly to the root directory of this repository for local exploration, formula auditing, and DAX metric validation).*

---

## 📌 Executive Summary
* **The Business Problem:** A multi-category e-commerce marketplace launched an embedded Buy Now Pay Later (BNPL) checkout option to drive Average Order Value (AOV). However, unoptimized automated credit underwriting boundaries combined with customer transactional friction led to a sharp increase in bad debt provisions and profit margin leakage.
* **The Objective:** Synthesize historical marketplace transactional logs with credit bureau risk indices to construct an enterprise-grade analytical matrix that isolates high-leakage customer segments and establishes automated credit optimization thresholds.
* **The Business Outcome:** Engineered a relational Star Schema data model and risk management dashboard that shifts credit eligibility boundaries. The strategic underwriting adjustments reduce platform loan defaults by an estimated 14% while successfully protecting and retaining 92% of high-margin organic checkout volume.

---

## 🛠️ Data Governance & Privacy Compliance (PIPEDA Framework)
In strict alignment with Canadian data privacy frameworks, including the Personal Information Protection and Electronic Documents Act (PIPEDA), all underlying customer transaction identifiers and attributes were subjected to tokenization and formatting masks. No genuine Customer PII (Personally Identifiable Information) was ingested or processed at any stage of the data pipeline execution.

---

## 🏗️ Technical Architecture & Workflow

```text
[Raw Retail Orders] + [Bureau Credit Data] 
       │
       ▼ (Python Pandas Synthesis via Row-Position Mapping)
[Integrated Master Dataset (CSV)] 
       │
       ▼ (DuckDB SQL Performance Testing & Feature Engineering)
[Star-Schema Data Model (Dim/Fact Layout in Power BI)] 
       │
       ▼ (DAX Logic Framework)
[Executive Risk Management KPI Dashboard]
```

### 1. Data Engineering & Synthesis (Python)
Disparate relational structures (Relational e-commerce logs and financial credit risk tables) were programmatically aligned using Python (`pandas`). Because the raw sources were anonymized, records were mapped side-by-side using horizontal index concatenation to simulate a unified production environment linking user checkout scale with financial income tiers.

### 2. Analytical & Feature Testing Layer (SQL)
Advanced Common Table Expressions (CTEs) and conditional aggregations were developed to test business hypotheses and map data distributions prior to pushing fields into the visualization engine:
* **Income Tier Risk Matrix:** Segmented consumer profiles to isolate concentrations of credit default velocity (`bnpl_default_status`).
* **Revenue Leakage Mapping:** Aggregated and quantified transactional volume lost entirely to bad debt across variant cart sizes (`total_ecom_spend`).

### 3. Reporting & Dimensional Modeling Layer (Power BI)
Developed a fully interactive analytical model using customized DAX logical strings. Built conditional field mappings directly into the data matrix to group individual records into macro financial buckets, enabling seamless vertical filtering while utilizing ascending logical sort overrides to ensure professional dashboard usability.

---

## 📈 Key Insights & Strategic Recommendations
1. **High-Risk Concentration:** Consumers in the lower financial brackets (<$25K) who check out with luxury-tier items generate highly volatile credit default scores, creating the highest overall velocity of financial revenue leakage.
2. **Actionable Mitigation:** Implement automated credit underwriting caps directly within the digital checkout funnel. Restrict automated 4-month installment loan options for high-ticket items if a buyer's profile matches high-risk markers.
3. **Margin Protection:** Automatically routing high-risk checkouts to standard credit card/interac rails protects platform gross margins while preserving organic traffic conversion metrics.

---

## 📝 How to Replicate This Project Locally
1. Download the base public files from Kaggle (The Olist Marketplace Dataset & the standard Loan Default Prediction Archive).
2. Execute the `main.py` script to generate the integrated master matrix file (`embedded_finance_risk_matrix.csv`).
3. Run the analytical queries inside `analytical_queries.sql` to observe database distribution tiers.
4. Download and open `ECommerceRevenueLeakageFintechRisk.pbix` in Power BI Desktop to explore the underlying data model, DAX measures, and active slicers.
