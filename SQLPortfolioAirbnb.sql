SELECT * 
FROM AirbnbPortfolioProject..listings
ORDER BY id DESC

SELECT * 
FROM AirbnbPortfolioProject..reviews
ORDER BY listing_id DESC

SELECT * 
FROM AirbnbPortfolioProject..listings
WHERE id = 54400117

SELECT * 
FROM AirbnbPortfolioProject..reviews
WHERE listing_id = 54400117

--Top performing AirBnB's

SELECT id, name, listing_url, price, minimum_nights, has_availability, availability_30, availability_60, availability_90, availability_365
, price*(30 - availability_30) AS monthly_proj_revenue
FROM AirbnbPortfolioProject..listings
WHERE price IS NOT NULL 
AND availability_365 > 0 
AND availability_30 < 30
AND minimum_nights < 7
AND price < 4000
ORDER BY monthly_proj_revenue DESC

--Review score vs Price

SELECT 
 CASE
        WHEN review_scores_rating >= 4.5 THEN '4.5-5'
        WHEN review_scores_rating >= 3.5 AND review_scores_rating < 4.5 THEN '3.5–4.5'
        WHEN review_scores_rating >= 2 AND review_scores_rating < 3.5 THEN '2–3.5'
        ELSE '<2'
    END AS rating_bucket,
COUNT(*) AS listings,
AVG(price) AS avg_price
FROM AirbnbPortfolioProject..listings
WHERE price IS NOT NULL 
AND availability_365 > 0 
AND number_of_reviews > 1
AND minimum_nights < 7
AND price < 4000

GROUP BY
 CASE
        WHEN review_scores_rating >= 4.5 THEN '4.5-5'
        WHEN review_scores_rating >= 3.5 AND review_scores_rating < 4.5 THEN '3.5–4.5'
        WHEN review_scores_rating >= 2 AND review_scores_rating < 3.5 THEN '2–3.5'
        ELSE '<2'
    END 
ORDER BY rating_bucket

-- Average price and rating per Neighbourhood

SELECT
    neighbourhood_cleansed,
    AVG(review_scores_rating) AS avg_rating,
    AVG(price) AS avg_price,
    COUNT(*) as listings
FROM AirbnbPortfolioProject..listings
WHERE review_scores_rating IS NOT NULL
AND price IS NOT NULL
AND neighbourhood_cleansed IS NOT NULL
AND availability_365 > 0 
AND number_of_reviews > 1
AND minimum_nights < 7
AND price < 4000
AND number_of_reviews IS NOT NULL
GROUP BY neighbourhood_cleansed
ORDER BY neighbourhood_cleansed

--Average price and rating per property type 

SELECT
    property_type,
    AVG(review_scores_rating) AS avg_rating,
    AVG(price) AS avg_price,
    COUNT(*) as listings
FROM AirbnbPortfolioProject..listings
WHERE review_scores_rating IS NOT NULL
AND price IS NOT NULL
AND property_type IS NOT NULL
AND availability_365 > 0 
AND number_of_reviews > 1
AND minimum_nights < 7
AND price < 4000
AND number_of_reviews IS NOT NULL
GROUP BY property_type
ORDER BY avg_price DESC

--Average price and rating per amount of bedrooms 


SELECT
    bedrooms,
    AVG(review_scores_rating) AS avg_rating,
    AVG(price) AS avg_price,
    COUNT(*) as listings
FROM AirbnbPortfolioProject..listings
WHERE review_scores_rating IS NOT NULL
AND price IS NOT NULL
AND bedrooms IS NOT NULL
AND availability_365 > 0 
AND number_of_reviews > 1
AND minimum_nights < 7
AND price < 4000
AND number_of_reviews IS NOT NULL
GROUP BY bedrooms
ORDER BY bedrooms DESC

-- Impact of keywords like noisy, clean on average projected revenue 


SELECT
    CASE
        WHEN comments LIKE '%noisy%' THEN 'Mentions noisy'
        ELSE 'Does not mention noisy'
    END AS Noisy_reviews,
    AVG(price*(30 - availability_30)) AS monthly_proj_revenue,
    COUNT(DISTINCT listings.id) AS listing_count
FROM AirbnbPortfolioProject..reviews 
JOIN AirbnbPortfolioProject..listings 
ON AirbnbPortfolioProject..listings.id = AirbnbPortfolioProject..reviews.listing_id 
WHERE price IS NOT NULL 
AND availability_365 > 0 
AND availability_30 < 30
AND minimum_nights < 7
AND price < 4000
GROUP BY
    CASE
        WHEN comments LIKE '%noisy%' THEN 'Mentions noisy'
        ELSE 'Does not mention noisy'
    END;

SELECT
    CASE
        WHEN comments LIKE '%clean%' THEN 'Mentions clean'
        ELSE 'Does not mention clean'
    END AS Clean_reviews,
    AVG(price*(30 - availability_30)) AS monthly_proj_revenue,
    COUNT(DISTINCT listings.id) AS listing_count
FROM AirbnbPortfolioProject..reviews 
JOIN AirbnbPortfolioProject..listings 
ON AirbnbPortfolioProject..listings.id = AirbnbPortfolioProject..reviews.listing_id 
WHERE price IS NOT NULL 
AND availability_365 > 0 
AND availability_30 < 30
AND minimum_nights < 7
AND price < 4000
GROUP BY
    CASE
        WHEN comments LIKE '%clean%' THEN 'Mentions clean'
        ELSE 'Does not mention clean'
    END;

-- Highest monthly projected revenue AirBnBs and their reviews mentioning Noisy

    SELECT
    l.id AS listing_id,
    l.name,
    COUNT(*) AS noisy_review_count,
    price*(30 - availability_30) AS monthly_proj_revenue,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS noisy_rank
FROM AirbnbPortfolioProject..listings l 
JOIN AirbnbPortfolioProject..reviews r
    ON l.id = r.listing_id
WHERE comments LIKE '%noisy%' 
AND l.price * (30 - l.availability_30) IS NOT NULL 
AND l.availability_365 > 0 
AND l.availability_30 < 30
AND l.minimum_nights < 7
AND l.price < 4000
AND l.price IS NOT NULL
GROUP BY
    l.price * (30 - l.availability_30),
    l.id,
    l.name   
ORDER BY
    l.price * (30 - l.availability_30) DESC;
    
    -- Most Airnb's with reviews mentioning Noisy 
    
    SELECT
    l.id AS listing_id,
    l.name,
    COUNT(*) AS noisy_review_count,
    price*(30 - availability_30) AS monthly_proj_revenue,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS noisy_rank
FROM AirbnbPortfolioProject..listings l 
JOIN AirbnbPortfolioProject..reviews r
    ON l.id = r.listing_id
WHERE comments LIKE '%noisy%' 
AND l.price * (30 - l.availability_30) IS NOT NULL 
AND l.availability_365 > 0 
AND l.availability_30 < 30
AND l.minimum_nights < 7
AND l.price < 4000
AND l.price IS NOT NULL
GROUP BY
    l.price * (30 - l.availability_30),
    l.id,
    l.name   
ORDER BY
    noisy_review_count DESC;
    
    -- Highest monthly projected revenue AirBnBs and their reviews mentioning Clean

    SELECT
    l.id AS listing_id,
    l.name,
    COUNT(*) AS clean_review_count,
    price*(30 - availability_30) AS monthly_proj_revenue,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS clean_rank
FROM AirbnbPortfolioProject..listings l 
JOIN AirbnbPortfolioProject..reviews r
    ON l.id = r.listing_id
WHERE comments LIKE '%clean%' 
AND l.price * (30 - l.availability_30) IS NOT NULL 
AND l.availability_365 > 0 
AND l.availability_30 < 30
AND l.minimum_nights < 7
AND l.price < 4000
AND l.price IS NOT NULL
GROUP BY
    l.price * (30 - l.availability_30),
    l.id,
    l.name   
ORDER BY
    l.price * (30 - l.availability_30) DESC;

     -- Most Airnb's with reviews mentioning Clean  

 SELECT
    l.id AS listing_id,
    l.name,
    COUNT(*) AS clean_review_count,
    price*(30 - availability_30) AS monthly_proj_revenue,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS clean_rank
FROM AirbnbPortfolioProject..listings l 
JOIN AirbnbPortfolioProject..reviews r
    ON l.id = r.listing_id
WHERE (comments) LIKE '%clean%' 
    AND l.price * (30 - l.availability_30) IS NOT NULL 
    AND l.availability_365 > 0 
    AND l.availability_30 < 30
    AND l.minimum_nights < 7
    AND l.price < 4000
    AND l.price IS NOT NULL
GROUP BY
    l.price * (30 - l.availability_30),
    l.id,
    l.name   
ORDER BY
    clean_review_count DESC;  

   -- Most noisy neighbourhoods
   
SELECT
    l.neighbourhood_cleansed AS neighbourhood,
    COUNT(*) AS noisy_review_count,
     AVG(l.price*(30 - availability_30)) AS AVG_monthly_proj_revenue
FROM AirbnbPortfolioProject..listings l 
    JOIN AirbnbPortfolioProject..reviews r
ON l.id = r.listing_id
WHERE r.comments LIKE '%noisy%'
    AND l.price*(30 - availability_30) IS NOT NULL
GROUP BY l.neighbourhood_cleansed
ORDER BY noisy_review_count DESC;


--Create Views for Power BI Visualization 
CREATE VIEW top_performing_airbnb_v
  AS
SELECT id, name, listing_url, price, minimum_nights, has_availability, availability_30, availability_60, availability_90, availability_365
, price*(30 - availability_30) AS monthly_proj_revenue
FROM AirbnbPortfolioProject..listings
WHERE price IS NOT NULL 
AND availability_365 > 0 
AND availability_30 < 30
AND minimum_nights < 7
AND price < 4000;

CREATE VIEW review_vs_price_v
  AS SELECT 
 CASE
        WHEN review_scores_rating >= 4.5 THEN '4.5-5'
        WHEN review_scores_rating >= 3.5 AND review_scores_rating < 4.5 THEN '3.5–4.5'
        WHEN review_scores_rating >= 2 AND review_scores_rating < 3.5 THEN '2–3.5'
        ELSE '<2'
    END AS rating_bucket,
COUNT(*) AS listings,
AVG(price) AS avg_price
FROM AirbnbPortfolioProject..listings
WHERE price IS NOT NULL 
AND availability_365 > 0 
AND number_of_reviews > 1
AND minimum_nights < 7
AND price < 4000

GROUP BY
 CASE
        WHEN review_scores_rating >= 4.5 THEN '4.5-5'
        WHEN review_scores_rating >= 3.5 AND review_scores_rating < 4.5 THEN '3.5–4.5'
        WHEN review_scores_rating >= 2 AND review_scores_rating < 3.5 THEN '2–3.5'
        ELSE '<2'
    END;

CREATE VIEW neighbourhood_data_v
  AS
SELECT
    neighbourhood_cleansed,
    AVG(review_scores_rating) AS avg_rating,
    AVG(price) AS avg_price,
    COUNT(*) as listings
FROM AirbnbPortfolioProject..listings
WHERE review_scores_rating IS NOT NULL
AND price IS NOT NULL
AND neighbourhood_cleansed IS NOT NULL
AND availability_365 > 0 
AND number_of_reviews > 1
AND minimum_nights < 7
AND price < 4000
AND number_of_reviews IS NOT NULL
GROUP BY neighbourhood_cleansed;

CREATE VIEW property_type_data_v
  AS
  SELECT
    property_type,
    AVG(review_scores_rating) AS avg_rating,
    AVG(price) AS avg_price,
    COUNT(*) as listings
FROM AirbnbPortfolioProject..listings
WHERE review_scores_rating IS NOT NULL
AND price IS NOT NULL
AND property_type IS NOT NULL
AND availability_365 > 0 
AND number_of_reviews > 1
AND minimum_nights < 7
AND price < 4000
AND number_of_reviews IS NOT NULL
GROUP BY property_type;

CREATE VIEW bedrooms_data_v
  AS
SELECT
    bedrooms,
    AVG(review_scores_rating) AS avg_rating,
    AVG(price) AS avg_price,
    COUNT(*) as listings
FROM AirbnbPortfolioProject..listings
WHERE review_scores_rating IS NOT NULL
AND price IS NOT NULL
AND bedrooms IS NOT NULL
AND availability_365 > 0 
AND number_of_reviews > 1
AND minimum_nights < 7
AND price < 4000
AND number_of_reviews IS NOT NULL
GROUP BY bedrooms;

CREATE VIEW noisy_reviews_v
  AS
SELECT
    CASE
        WHEN comments LIKE '%noisy%' THEN 'Mentions noisy'
        ELSE 'Does not mention noisy'
    END AS Noisy_reviews,
    AVG(price*(30 - availability_30)) AS monthly_proj_revenue,
    COUNT(DISTINCT listings.id) AS listing_count
FROM AirbnbPortfolioProject..reviews 
JOIN AirbnbPortfolioProject..listings 
ON AirbnbPortfolioProject..listings.id = AirbnbPortfolioProject..reviews.listing_id 
WHERE price IS NOT NULL 
AND availability_365 > 0 
AND availability_30 < 30
AND minimum_nights < 7
AND price < 4000
GROUP BY
    CASE
        WHEN comments LIKE '%noisy%' THEN 'Mentions noisy'
        ELSE 'Does not mention noisy'
    END;

    CREATE VIEW clean_reviews_v
  AS 
  SELECT
    CASE
        WHEN comments LIKE '%clean%' THEN 'Mentions clean'
        ELSE 'Does not mention clean'
    END AS Clean_reviews,
    AVG(price*(30 - availability_30)) AS monthly_proj_revenue,
    COUNT(DISTINCT listings.id) AS listing_count
FROM AirbnbPortfolioProject..reviews 
JOIN AirbnbPortfolioProject..listings 
ON AirbnbPortfolioProject..listings.id = AirbnbPortfolioProject..reviews.listing_id 
WHERE price IS NOT NULL 
AND availability_365 > 0 
AND availability_30 < 30
AND minimum_nights < 7
AND price < 4000
GROUP BY
    CASE
        WHEN comments LIKE '%clean%' THEN 'Mentions clean'
        ELSE 'Does not mention clean'
    END;


  CREATE VIEW noisy_neighbourhood_v 
  AS SELECT
    l.neighbourhood_cleansed AS neighbourhood,
    COUNT(*) AS noisy_review_count,
     AVG(l.price*(30 - availability_30)) AS AVG_monthly_proj_revenue
FROM AirbnbPortfolioProject..listings l 
JOIN AirbnbPortfolioProject..reviews r
ON l.id = r.listing_id
WHERE r.comments LIKE '%noisy%'
AND l.price*(30 - availability_30) IS NOT NULL
GROUP BY l.neighbourhood_cleansed;

SELECT *
FROM AirbnbPortfolioProject..bedrooms_data_v;