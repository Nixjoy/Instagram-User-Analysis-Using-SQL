USE ig_clone;


-- Loyal User
SELECT * FROM users;  
DESCRIBE users;
SELECT *
FROM users
ORDER BY created_at
LIMIT 5;


-- Inactive user

SELECT u.id,u.username,COUNT(p.user_id) AS "Post_count"
FROM photos P
RIGHT JOIN users u
ON u.id = p.user_id
GROUP BY u.id
HAVING COUNT(p.user_id) = 0;

-- contest Winner
-- SELECT u.username,COUNT(l.photo_id) AS "Total_Like"
-- FROM users u 
-- INNER JOIN photos
-- ON u.id = p.user_id
-- INNER JOIN likes l
-- ON p.id = l.photo_id
-- WHERE COUNT(l.photo_id) = (SELECT MAX(COUNT(photo_id)) FROM likes);

SELECT id,username
FROM users
WHERE id = (SELECT user_id
         FROM photos
         WHERE id = (SELECT photo_id
         FROM likes
         GROUP BY photo_id
         ORDER BY COUNT(photo_id) DESC
         LIMIT 1));
         
         SELECT 
         username,photos.image_url,count(likes.user_id) as "totallike"
         FROM photos
         INNER JOIN likes
         ON likes.photo_id = photos.id
         INNER JOIN users
         ON photos.user_id = users.id
         GROUP BY photos.id
         ORDER BY totallike DESC
         LIMIT 1;

-- Most Hashtage

SELECT tags.tag_name,COUNT(photo_tags.tag_id) "Frequency"
FROM tags
INNER JOIN 
photo_tags
ON tags.id  = photo_tags.tag_id
GROUP BY tags.tag_name
ORDER BY Frequency DESC
LIMIT 5;



SELECT DAYNAME(created_at) "Days",COUNT(DAYNAME(created_at)) "Frequency"
FROM users
GROUP BY Days
ORDER BY Frequency DESC
LIMIT 2;

-- user engagement

SELECT (SELECT Count(id)
        FROM   photos) / (SELECT Count(DISTINCT user_id)
                          FROM   photos) AS Average_posts_per_User,
       (SELECT Count(id)
        FROM   photos) / (SELECT Count(id)
                          FROM   users)  AS Ratio_of_Total_Posts_to_Total_Users; 
 
 
 SELECT user_id,COUNT(*) AS num_like
 FROM likes 
 GROUP BY user_id
 HAVING num_like = (SELECT COUNT(*) FROM photos);
 
 SELECT COUNT(image_url) AS "Total_post" FROM photos; 
 
 SELECT u.username,COUNT(*) AS num_like
 FROM users u
 JOIN likes l
 ON u.id = l.user_id
 GROUP BY u.id
 HAVING num_like = (SELECT COUNT(*) FROM photos);
 