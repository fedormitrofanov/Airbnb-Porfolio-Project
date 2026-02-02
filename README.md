# Airbnb Toronto Market Analysis

## Project Overview
This project analyzes **Airbnb listings and reviews in Toronto** using **SQL Server** and **Power BI** to uncover pricing patterns, revenue drivers, neighborhood trends, and the impact of guest sentiment on host performance.

The project demonstrates **end-to-end data analytics skills**, including:
- Data exploration and transformation using SQL
- Business-driven metric creation
- Review text analysis using keyword signals
- Creation of reusable SQL views
- Interactive dashboard development in Power BI

---

## Business Questions Answered
This analysis focuses on answering practical, market-relevant questions such as:

- What Airbnb listings generate the **highest projected monthly revenue**?
- How do **review scores** influence listing prices?
- Which **neighborhoods** and **property types** command premium pricing?
- Does guest sentiment (e.g., *“clean”* or *“noisy”* reviews) impact revenue?
- What characteristics define **top-performing listings**?

---

## Tools & Technologies
- **SQL Server** – data querying, aggregation, and view creation  
- **Power BI** – dashboard development and visualization  
- **Microsoft Excel** – listings and reviews data  

---

## Dataset Description

### `listings`
Contains structured Airbnb listing information, including:
- Nightly price
- Property type
- Number of bedrooms
- Availability (30 / 60 / 90 / 365 days)
- Minimum nights
- Review scores
- Neighborhood

### `reviews`
Contains unstructured guest review text linked by `listing_id`, enabling sentiment-based analysis.

---

## Data Preparation & Assumptions
To ensure realistic and comparable results, listings were filtered to include:
- Active listings (`availability_365 > 0`)
- Reasonable nightly pricing (`price < 4000`)
- Short-term rentals (`minimum_nights < 7`)
- Listings with demand (`availability_30 < 30`)
- Listings with more than one review (for sentiment analysis)

monthly_projected_revenue = price * (30 - availability_30)

