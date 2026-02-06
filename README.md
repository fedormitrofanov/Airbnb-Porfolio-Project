# Airbnb Toronto Market Analysis

## Project Overview
This project analyzes **Airbnb listings and reviews in Toronto** using **SQL Server** and **Power BI** to uncover pricing patterns, revenue drivers, neighborhood trends, and the impact of guest sentiment on host performance.

The project demonstrates **end-to-end data analytics skills**, including:

➜ Initial data transformation using Microsoft Excel  
➜ Data exploration and transformation using SQL  
➜ Creation of reusable SQL views  
➜ Import of SQL views into Power BI  
➜ Interactive dashboard development using a custom Power BI theme


---

## Business Questions Answered
This analysis focuses on answering practical, market-relevant questions such as:

- What Airbnb listings generate the **highest projected monthly revenue**?
    -  Listings titled *"Executive Home in Toronto"* and *"Spectacular Stay with CN Tower View"* have the highest projected monthly revenue (Dashboard1.png)
- How do **review scores** influence listing prices?
    - Highest review score listings are generally priced higher (Dashboard2.png)
- Which **property types** command premium pricing?
    - Entire cottage, entire home and entire townhouse listings are priced the highest (Dashboard2.png)
- Does guest sentiment (e.g., *“clean”* or *“noisy”* reviews) impact revenue?
    - Listings where the reviews mention *“noisy”* have lower average monthly projected revenue than those that do not mention *“noisy”* (Dashboard1.png)
    - The keyword *“clean”* in reviews does not have a significant impact on monthly projected revenue (Dashboard1.png)
- Which **neighborhoods** have the most Airbnb listings?
    - Waterfront Communities - The Island is the neighbourhood with the most number of listings (Dashboard2.png)
- What is the **average listing price** for short-term rentals in Toronto?
      - $197.12 per night (Dashboard2.png)
- Does the number of **bedrooms** impact the listing price?
      - Listings with more bedrooms are priced higher than listings with less bedrooms (Dashboard2.png)
---

## Tools & Technologies
- **SQL Server** – data querying, aggregation, and view creation  
- **Power BI** – dashboard development and visualization  
- **Microsoft Excel** – listings and reviews data  

---

## Dataset Description

- Data was obtained from the website insideairbnb.com
- Data is scraped from the Airbnb Website from November 11th, 2025

  
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
- Monthly projected revenue = price * (30 - availability_30)

---

## Limitations
Limitations of the analysis: 
- Listing price and data can change over time and could have changed since November 2025
- Monthly projected revenue is estimated, not actual revenue, and is calculated using availability over the next 30 days

---

## Author
**Fedor Mitrofanov**  
Data Analyst | SQL | Power BI | Business Analytics


