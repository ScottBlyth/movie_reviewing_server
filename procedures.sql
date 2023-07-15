
use movies;

-- plan

-- procedure to create user 
DELIMITER //
CREATE PROCEDURE createuser (IN user_name VARCHAR (200), IN user_email VARCHAR (320), IN user_phone VARCHAR (15), OUT p_output VARCHAR (200) )

BEGIN
	DECLARE p_user_exists INT DEFAULT 0;
  
	SELECT 
		COUNT(*)
	INTO p_user_exists FROM
		user u
	WHERE
		u.user_name = user_name; 
  
  IF p_user_exists = 0 THEN
      INSERT INTO USER (user_name, user_email, user_phone) VALUES ( user_name, user_email, user_phone ); 
      COMMIT;
      SET p_output := CONCAT('Created ' , user_name , ' user successfully');
   ELSE 
	   SET p_output := CONCAT(user_name , ' already exists');
   END IF;
END
//

-- procedure to add review 

-- DROP PROCEDURE addreview;

DELIMITER //
CREATE PROCEDURE addreview (IN p_user_name VARCHAR (200), IN p_movie_id INT, IN p_review DECIMAL (2,1), IN p_review_description VARCHAR (300), OUT p_output VARCHAR (200) )
BEGIN 
  DECLARE curr_date Date; 
  DECLARE p_exists INT DEFAULT 0; 
  DECLARE p_review_val DECIMAL (2,1);
  
  SELECT curdate() INTO curr_date; 

  SELECT COUNT(*) INTO p_exists 
  FROM review
  WHERE movie_id = p_movie_id AND
     user_name = p_user_name AND
     DATE_FORMAT(review_date, '%d-%m-%Y')=DATE_FORMAT(curr_date, '%d-%m-%Y'); 
	
     
  IF p_exists = 0 THEN
	INSERT INTO REVIEW (user_name, movie_id, review_date, review_rating, review_description)
    VALUES (p_user_name, p_movie_id, curr_date, p_review, p_review_description);
    COMMIT;
    SET p_output := CONCAT('Review for ', (SELECT movie_name FROM MOVIE WHERE movie_id=p_movie_id));
   ELSE 
	 SET p_output := 'Review for this date has alreadys exists';
   END IF; 
END//


-- procedure to add movie

-- DROP PROCEDURE addmovie1;

DELIMITER // 
CREATE PROCEDURE addmovie1 (IN p_movie_name VARCHAR (500), IN p_release_date CHAR (10), OUT p_output VARCHAR (200) )
BEGIN
	DECLARE p_movie_count INT DEFAULT 0; 
    
    SELECT COUNT(*) INTO p_movie_count
    FROM movie
    WHERE movie_name = p_movie_name
		AND release_date = str_to_date(p_release_date, '%d/%m/%Y'); 
        
	IF p_movie_count = 0 THEN
		INSERT INTO MOVIE (movie_name, release_date) VALUES (p_movie_name, str_to_date(p_release_date, '%d/%m/%Y'));
        COMMIT;
        SET p_output := CONCAT('Added movie ', p_movie_name);
    ELSE 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Movie with same name and release date already exists. You may have added it already. Provide directors';
    END IF;
END//


-- DROP PROCEDURE updatebudget;

DELIMITER //
CREATE PROCEDURE updatebudget (IN p_movie_id INT, IN p_movie_budget INT)
BEGIN 
	DECLARE p_movie_count INT DEFAULT 0; 
    SELECT COUNT(*) INTO p_movie_count 
    FROM movie
    WHERE movie_id = p_movie_id;
    
    IF p_movie_count = 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'could not find movie';
    ELSE
		UPDATE movie
        SET movie_budget = p_movie_budget 
        WHERE movie_id = p_movie_id;
        COMMIT; 
    END IF;
END//



-- procedure to get movie

-- DROP PROCEDURE getmovie;

DELIMITER // 
CREATE PROCEDURE getmovie (IN p_movie_name VARCHAR (500)) 
BEGIN 
	SELECT movie_id,
    movie_name, 
	date_format(release_date, '%d/%m/%Y'), 
    coalesce(movie_budget, 'N/A')
    FROM MOVIE
    WHERE upper(movie_name) = upper(p_movie_name);
END//


-- procedure to get all reviews for movie

-- procedure to get all movies by director

-- procedure to get all reviews by a particular user



-- user privileges 

-- give execute privileges to user 

-- GRANT EXECUTE ON movies.* TO 'scott'@'localhost';



