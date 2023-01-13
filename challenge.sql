--1. Filter the data and create a new DataFrame or table to retrieve all the rows
--where the total_votes count is equal to or greater than 20 to pick reviews that
--are more likely to be helpful and to avoid having division by zero errors later on.
SELECT *
INTO reviews_min_twenty
FROM vine_table
WHERE total_votes >= 20;

--2. Filter the new DataFrame or table created in Step 1 and create a new DataFrame
--or table to retrieve all the rows where the number of helpful_votes divided by
--total_votes is equal to or greater than 50%.
--If you use the SQL option below, you’ll need to cast your columns as floats using
--WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5.
SELECT *
INTO reviews_helpful
FROM reviews_min_twenty
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5;

--3. Filter the DataFrame or table created in Step 2, and create a new DataFrame or
--table that retrieves all the rows where a review was written as part of the Vine
--program (paid), vine == 'Y'.
SELECT *
INTO reviews_vine
FROM reviews_helpful
WHERE vine = 'Y';

--4. Repeat Step 3, but this time retrieve all the rows where the review was not part
--of the Vine program (unpaid), vine == 'N'.
SELECT *
INTO reviews_not_vine
FROM reviews_helpful
WHERE vine = 'N';

--5. Determine the total number of reviews, the number of 5-star reviews, and the
--percentage of 5-star reviews for the two types of review (paid vs unpaid).
--paid reviews
SELECT COUNT(review_id) AS "Total Number of Reviews"
FROM reviews_vine;
SELECT COUNT(review_id) AS "Number of 5-Star Reviews"
FROM reviews_vine
WHERE star_rating = 5;
SELECT COUNT(review_id) * 100 / (SELECT COUNT(review_id) FROM reviews_vine)
AS "Percentage of 5-Star Reviews"
FROM reviews_vine
WHERE star_rating = 5;
--unpaid reviews
SELECT COUNT(review_id) AS "Total Number of Reviews"
FROM reviews_not_vine;
SELECT COUNT(review_id) AS "Number of 5-Star Reviews"
FROM reviews_not_vine
WHERE star_rating = 5;
SELECT COUNT(review_id) * 100 / (SELECT COUNT(review_id) FROM reviews_not_vine)
AS "Percentage of 5-Star Reviews"
FROM reviews_not_vine
WHERE star_rating = 5;