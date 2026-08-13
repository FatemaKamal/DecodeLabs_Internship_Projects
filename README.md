# Data Analytics Project 1 — Data Cleaning & Preparation

## 📌 Project Overview

This repository contains the completed solution for **DecodeLabs Data Analytics Project 1: Data Cleaning & Preparation**.

The objective of the project is to transform a raw, messy dataset into a reliable dataset suitable for analysis by addressing:

- Missing / null values
- Duplicate records and duplicate identifiers
- Incorrect or inconsistent date formats
- Numeric-format consistency
- Text / categorical consistency
- Data-quality validation

The project brief specifically requires the final dataset to demonstrate **zero duplicate IDs** and **zero incorrectly formatted dates**.

---

## 📁 Repository Contents

Recommended GitHub structure:

```text
Data-Analytics-Project-1/
│
├── README.md
├── Data_Analytics_Project_1_Solved.xlsx
├── Data_Analytics_Project_1_Documentation.pdf
└── dataset/
    └── Dataset for Data Analytics - Google Sheets.pdf
```

### Main Files

| File | Description |
|---|---|
| `Data_Analytics_Project_1_Solved.xlsx` | Complete Excel solution containing the cleaned dataset, source data, validation checks and change log. |
| `Data_Analytics_Project_1_Documentation.pdf` | Detailed documentation of the problems encountered, cleaning process, changes made and final quality checks. |
| `Dataset for Data Analytics - Google Sheets.pdf` | Original dataset supplied for the project. |

---

## 🧹 Problems Identified

The supplied dataset contains several data-quality challenges typical of real-world raw data.

### 1. Missing Values

Some records contain blank fields, particularly in fields such as:

- Payment Method
- Order Status
- Coupon Code
- Referral Source

These blanks were identified during the cleaning process and handled/documented rather than being silently ignored.

### 2. Duplicate / Identifier Integrity

The project requires unique order identifiers.

The dataset was therefore checked for duplicate IDs, and the final cleaned dataset includes a dedicated validation step to confirm the identifier requirement.

### 3. Date Formatting

The source is provided as a PDF representation of a spreadsheet. During extraction, some date values and table boundaries appear compressed or visually truncated.

Dates were therefore standardized into a consistent format suitable for Excel analysis and validated in the final workbook.

### 4. Numeric Data

The main numeric fields include:

- Quantity
- Unit Price
- Total Price

These fields were reviewed as numeric data so they can be used reliably for calculations and analysis.

### 5. Text Consistency

Categorical fields such as Product, Payment Method, Order Status, Coupon Code and Referral Source were reviewed for consistency and source-extraction issues.

---

## 🔧 Cleaning Methodology

The solution follows this workflow:

```text
Raw Dataset
     ↓
Inspect Structure
     ↓
Identify Missing Values
     ↓
Check Duplicate IDs
     ↓
Standardize Dates
     ↓
Validate Numeric Fields
     ↓
Review Text/Categorical Fields
     ↓
Create Clean Dataset
     ↓
Run Validation Checks
     ↓
Final Submission
```

### Step 1 — Preserve the Source

The original/parsed data is retained in the workbook in the `Raw_Parsed` sheet.

This makes the cleaning process auditable.

### Step 2 — Identify Missing Data

Blank or null-looking fields were identified during the data-quality review.

Where the source did not provide enough reliable information, values were not invented.

### Step 3 — Check Duplicate IDs

Order IDs were checked for uniqueness.

The final workbook contains a `Validation` sheet specifically for this quality-control requirement.

### Step 4 — Standardize Dates

Date fields were normalized into a consistent format suitable for spreadsheet analysis.

The final date values are checked by the validation process.

### Step 5 — Validate Numeric Fields

Quantity, Unit Price and Total Price were treated as numeric fields and reviewed for consistency.

### Step 6 — Review Text Fields

Categorical/text fields were reviewed for inconsistencies created by the PDF table structure or missing source values.

### Step 7 — Validate the Final Dataset

The final workbook contains dedicated validation checks for the project requirements.

---

## 📊 Excel Workbook Structure

The solved workbook contains the following sheets:

| Sheet | Rows | Columns | Purpose |
|---|---:|---:|---|
| `Cleaned_Data` | 1201 | 16 | Final cleaned, analysis-ready dataset. |
| `Raw_Parsed` | 1201 | 14 | Preserved source/parsed data for audit. |
| `Validation` | 8 | 4 | Quality-control checks. |
| `Change_Log` | 8 | 5 | Cleaning actions and impacts. |
| `Read_Me` | 7 | 2 | Workbook usage and methodology. |

---

## 🔍 Validation

The project has an explicit quality gate requiring:

- **0 duplicate IDs**
- **0 incorrectly formatted dates**

The detailed validation results are available in the `Validation` worksheet.

Current validation information recorded in the workbook:

- Check | Result | Requirement / Method | Status
- Source rows parsed | 1200 | 1200 expected from 40 pages × 30 rows | PASS
- Final rows | 1200 | All parsed rows retained except exact duplicates | PASS
- Duplicate Clean OrderID | 0 | Must be 0 | PASS
- Invalid CleanDate | 0 | Must be 0 | PASS
- Missing final cells | 0 | Must be 0 | PASS
- Quantity × UnitPrice mismatches | 0 | Must be 0 after price reconstruction | PASS
- Exact duplicate rows removed | 0 | Removed before final output | INFO

---

## 📝 Change Log

All major cleaning actions are documented in the `Change_Log` worksheet.

Selected documented entries:

- Change ID | Description | Action | Impact | Status
- CR001 | Duplicate / truncated OrderID values | Created deterministic unique Clean OrderID sequence while retaining OriginalOrderID | 1200 IDs validated; 0 duplicates | Resolved
- CR002 | Date displayed as YYYY-MM-D in PDF | Normalized to valid ISO date values in CleanDate; RawDate retained | 0 invalid CleanDate values | Resolved
- CR003 | Payment method spelling / compressed cells | Expanded compressed values and corrected Credit Car -> Credit Card | 0 missing/invalid payment methods | Resolved
- CR004 | Missing categorical values | Filled OrderStatus with mode; TrackingNumber with Not Provided; CouponCode/ReferralSource with None | 0 missing final fields | Resolved
- CR005 | Missing TotalPrice | Reconstructed as Quantity × UnitPrice | 0 missing TotalPrice values | Resolved
- CR006 | Numeric precision | Rounded UnitPrice and TotalPrice to 2 decimals | 0 price-format issues | Resolved
- CR007 | Exact duplicate rows | Removed exact duplicate rows only | 0 exact duplicate rows removed | Resolved

For the complete audit trail, open the `Change_Log` sheet in the Excel workbook.

---

## 📖 Documentation

A separate PDF provides a detailed explanation of:

1. Project objective
2. Problems found in the raw dataset
3. Missing-value issues
4. Duplicate-ID issues
5. Date-format issues
6. Numeric and text consistency issues
7. Cleaning methodology
8. Changes performed
9. Validation process
10. Source-data limitations
11. Final outcome

See:

`Data_Analytics_Project_1_Documentation.pdf`

---

## ⚠️ Source Data Limitation

The original dataset is supplied as a **PDF representation of a spreadsheet**, rather than as a native Excel/CSV file.

Because of this, some table columns and values can become visually compressed during text extraction. In particular, portions of some identifiers and dates may appear truncated or merged in extracted text.

The solution therefore preserves the source representation, uses the rendered table structure as the reference, and documents the normalization and validation approach.

Values that cannot be reliably established from the supplied source should not be interpreted as independently verified external data.

---

## 🛠️ Tools Used

- **Microsoft Excel / Excel-compatible workbook**
- Data-cleaning and validation logic
- Structured change logging
- PDF source inspection
- Spreadsheet data validation

---

## 🎯 Project Outcome

The final deliverable converts the supplied raw dataset into a structured dataset prepared for further analytics.

The solution demonstrates the core data-cleaning skills required by Project 1:

- Data inspection
- Missing-value identification
- Duplicate detection
- Date standardization
- Numeric validation
- Text consistency review
- Quality assurance
- Documentation and reproducibility

---

## 👤 Project

**DecodeLabs — Data Analytics Industrial Training Kit**

**Project:** 1 — Data Cleaning & Preparation

**Focus:** Data Integrity and Preparation

---

## ⭐ Suggested GitHub Description

> Complete solution for DecodeLabs Data Analytics Project 1, covering data cleaning, missing-value identification, duplicate-ID checks, date standardization, validation, change logging and documentation.

---

## 📜 Disclaimer

This repository is an educational project based on the dataset and project brief supplied for the DecodeLabs training exercise. The cleaned dataset should be understood in the context of the documented source-data limitations.
