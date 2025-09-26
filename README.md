# Music SQL Project 🎵

A comprehensive SQL project analyzing a music database with customer purchase patterns, artist performance, and music genre insights.

## 📋 Project Overview

This project contains SQL queries that analyze a music store database to answer business questions ranging from basic employee information to complex customer spending patterns. The queries are organized by difficulty level and provide insights into sales performance, customer behavior, and music preferences.

## 🗄️ Database Schema

The project works with the following main tables:
- **employee** - Employee information and hierarchy
- **customer** - Customer details
- **invoice** - Purchase transactions
- **invoice_line** - Individual items in each purchase
- **track** - Music track information
- **album** - Album details
- **artist** - Artist information
- **genre** - Music genre categories

## 📊 Query Categories

### Basic Level Queries
1. **Senior Employee Analysis** - Find the most senior employee by job level
2. **Country Invoice Distribution** - Countries with the most invoices
3. **Top Invoice Values** - Highest value transactions
4. **Best Customer City** - City generating the most revenue
5. **Top Customer** - Customer with highest total spending

### Moderate Level Queries
1. **Rock Music Listeners** - Email list of Rock genre customers
2. **Top Rock Artists** - Artists with most rock tracks (Top 10)
3. **Above Average Tracks** - Songs longer than average duration

### Advanced Level Queries
1. **Customer Artist Spending** - Detailed spending analysis per customer per artist
2. **Best Selling Artist Analysis** - Using Common Table Expressions (CTE)

## 🚀 Key Features

- **Multiple Solution Methods** - Many queries include alternative approaches
- **Performance Optimization** - Efficient JOIN operations and indexing considerations
- **Business Intelligence** - Practical queries for music store analytics
- **Advanced SQL Techniques** - CTEs, subqueries, and complex aggregations

## 📈 Sample Insights

- Identify top-performing cities for promotional events
- Track customer loyalty and spending patterns  
- Analyze genre popularity and artist success
- Optimize inventory based on track length preferences

## 🛠️ Technologies Used

- **SQL Server** - Primary database platform
- **T-SQL** - Query language with SQL Server specific syntax
- **SQL Server Management Studio** - Development environment

## 📝 Query Highlights

### Most Complex Query: Customer-Artist Spending Analysis
```sql
-- Advanced analysis using CTE
WITH best_selling_artist AS (
    SELECT TOP 1 
        artist.artist_id, 
        artist.name AS artist_name, 
        SUM(invoice_line.unit_price * invoice_line.quantity) AS total_sales
    FROM invoice_line
    JOIN track ON track.track_id = invoice_line.track_id
    JOIN album ON album.album_id = track.album_id
    JOIN artist ON artist.artist_id = album.artist_id
    GROUP BY artist.artist_id, artist.name
    ORDER BY total_sales DESC
)
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    bsa.artist_name, 
    SUM(il.unit_price * il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, bsa.artist_name
ORDER BY amount_spent DESC;
```

## 🎯 Business Applications

- **Marketing Strategy** - Identify target cities and customer segments
- **Inventory Management** - Stock popular genres and artists
- **Customer Retention** - Reward high-value customers
- **Artist Partnerships** - Focus on successful rock artists
- **Promotional Planning** - Data-driven festival location selection

## 📁 File Structure

```
MusicSqlProject/
├── SQLFile1.sql          # All project queries
└── README.md            # This file
```

## 🔧 How to Use

1. **Setup Database** - Import the music store database schema
2. **Run Queries** - Execute queries in SQL Server Management Studio
3. **Analyze Results** - Use outputs for business decision making
4. **Modify as Needed** - Adapt queries for different business questions

## 💡 Learning Outcomes

- Complex JOIN operations across multiple tables
- Aggregate functions and GROUP BY clauses
- Subqueries and Common Table Expressions (CTEs)
- Data analysis for business intelligence
- Query optimization techniques
- Real-world database problem solving

## 🤝 Contributing

Feel free to:
- Add new business questions and queries
- Optimize existing queries
- Add data visualization components
- Expand database schema analysis

## 📞 Contact

**Hassan Iqbal**
- GitHub: [@Hasssaan514](https://github.com/Hasssaan514)

---

*This project demonstrates practical SQL skills for music industry data analysis and business intelligence.*
