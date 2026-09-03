# Data Analytics — Project 3: SQL Data Analysis

Industrial Training Kit · Batch 2026 · DecodeLabs

Use SQL to extract insights from a raw e-commerce orders dataset — filtering, sorting, grouping, and aggregating 1,200 records into actionable business intelligence.

## 📁 Contents

| File | Description |
|---|---|
| `solution.sql` | Full SQL solution — 32 queries across 6 sections (SELECT, WHERE, ORDER BY, GROUP BY, HAVING, advanced analysis) |
| `orders.db` | SQLite database built from the source dataset (table: `orders`) |
| `Dataset_for_Data_Analytics.xlsx` | Original raw dataset (1,200 rows, 14 columns) |
| `Project3_SQL_Results.xlsx` | Output of every query, one sheet per query, plus an Index sheet |
| `Project3_Documentation.pdf` | Full write-up: methodology, query breakdown, and key findings |

## 🗂️ Dataset Schema

Table `orders` — 1,200 rows

| Column | Type | Description |
|---|---|---|
| OrderID | TEXT | Unique order identifier |
| Date | DATE | Order date (2023-01-01 to 2025-06-30) |
| CustomerID | TEXT | Unique customer identifier |
| Product | TEXT | Monitor, Phone, Tablet, Chair, Printer, Laptop, Desk |
| Quantity | INTEGER | Units ordered |
| UnitPrice | REAL | Price per unit |
| ShippingAddress | TEXT | Delivery address |
| PaymentMethod | TEXT | Debit Card, Online, Credit Card, Gift Card, Cash |
| OrderStatus | TEXT | Shipped, Cancelled, Returned, Delivered, Pending |
| TrackingNumber | TEXT | Shipment tracking ID |
| ItemsInCart | INTEGER | Number of items in the cart |
| CouponCode | TEXT | SAVE10, FREESHIP, WINTER15, or NULL (no coupon) |
| ReferralSource | TEXT | Instagram, Referral, Email, Facebook, Google |
| TotalPrice | REAL | Final order value |

## 🛠️ How to Run

### Option A — SQLite (no setup required)
```bash
sqlite3 orders.db
.read solution.sql
```

### Option B — Rebuild the database from the raw Excel file
```bash
pip install pandas openpyxl
python3 - << 'EOF'
import pandas as pd, sqlite3
df = pd.read_excel("Dataset_for_Data_Analytics.xlsx")
df["Date"] = pd.to_datetime(df["Date"]).dt.strftime("%Y-%m-%d")
conn = sqlite3.connect("orders.db")
df.to_sql("orders", conn, if_exists="replace", index=False)
EOF
sqlite3 orders.db < solution.sql
```

### Option C — Any other RDBMS (MySQL / PostgreSQL / SQL Server)
Import `Dataset_for_Data_Analytics.xlsx` into a table named `orders` with the schema above, then run `solution.sql`. Only the `strftime()` date function in Section 4.7 is SQLite-specific — swap it for `DATE_FORMAT()` (MySQL) or `TO_CHAR()` (PostgreSQL) if needed.

## 🔍 What's Covered

- **Basic SELECT** — column selection, aliasing, `DISTINCT`
- **WHERE filtering** — equality, comparison, `AND`/`OR`, `LIKE`, `IS NULL`, `BETWEEN`, `IN`
- **ORDER BY** — single/multi-column sort, sorting by a computed alias
- **GROUP BY + aggregation** — `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, monthly trends
- **HAVING** — filtering aggregated groups (e.g. products above a revenue threshold)
- **Advanced analysis** — percentage-of-total contribution, coupon impact, top customers, cancellation/return risk by product, referral-source conversion rate

## 📊 Key Findings

- **Total revenue:** $1,264,761.96 across 1,200 orders (avg. order value $1,053.97)
- **Top revenue product:** Chair — $195,620.11 (15.47% of total revenue)
- **Order health:** only ~19% of orders are `Delivered`; combined `Cancelled` + `Returned` rate is ~41%
- **Highest-risk products:** Monitor, Tablet, and Laptop have the highest cancellation/return rates (~43%)
- **Best-converting referral source:** Email (24.0% delivery-completion rate)
- **Coupon impact:** average order value is consistent (within ~3%) across all coupon groups

Full breakdown and methodology in `Project3_Documentation.pdf`.

## 🎯 Skills Demonstrated

SQL fundamentals · query execution order (`FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY`) · data filtering and grouping · aggregate functions · business-insight extraction

---
*Part of the DecodeLabs Industrial Training Kit, Batch 2026.*
