



CREATE DATABASE MOVIES;

USE MOVIES;


CREATE TABLE GENRE (
    genre_id INT NOT NULL AUTO_INCREMENT,
    genre_name VARCHAR(100) NOT NULL,
    genre_description VARCHAR(300),
    PRIMARY KEY (genre_id),
    UNIQUE (genre_name)
)  AUTO_INCREMENT=1;


CREATE TABLE SAGA (saga_id INT NOT NULL AUTO_INCREMENT, 
saga_name VARCHAR (200) NOT NULL,
PRIMARY KEY (saga_id)
) AUTO_INCREMENT=1;

CREATE TABLE MOVIE (
    movie_id INT NOT NULL AUTO_INCREMENT,
    movie_name VARCHAR(500) NOT NULL,
    release_date DATE NOT NULL,
    movie_budget INT,
    saga_id INT,
    PRIMARY KEY (movie_id),
    CHECK (movie_budget >= 0)
)  AUTO_INCREMENT=1;

-- foreign keys
ALTER TABLE MOVIE ADD CONSTRAINT movie_saga_fk FOREIGN KEY (saga_id) REFERENCES SAGA (saga_id);


CREATE TABLE MOVIE_GENRES (
    genre_id INT NOT NULL,
    movie_id INT,
    PRIMARY KEY (genre_id , movie_id)
);

-- foriegn keys 

ALTER TABLE MOVIE_GENRES ADD CONSTRAINT genre_m_fk FOREIGN KEY (genre_id) REFERENCES GENRE (genre_id);
ALTER TABLE MOVIE_GENRES ADD CONSTRAINT movie_g_fk FOREIGN KEY (movie_id) REFERENCES MOVIE (movie_id);


CREATE TABLE DIRECTOR (
	director_id INT NOT NULL AUTO_INCREMENT,
    director_name VARCHAR (150) NOT NULL, 
    director_country VARCHAR (60),
    PRIMARY KEY (director_id)
)
AUTO_INCREMENT=1;


CREATE TABLE MOVIE_DIRECTORS(movie_id INT, 
director_id INT,
debut CHAR (1),
PRIMARY KEY (movie_id,director_id),
CHECK (debut in ('F', 'T'))
);

-- foreign keys 
ALTER TABLE MOVIE_DIRECTORS ADD CONSTRAINT movie_dir_movie FOREIGN KEY (movie_id) REFERENCES MOVIE (movie_id);
ALTER TABLE MOVIE_DIRECTORS ADD CONSTRAINT movie_dir_director FOREIGN KEY (director_id) REFERENCES DIRECTOR (director_id);


CREATE TABLE COMPANY (
 company_id INT NOT NULL AUTO_INCREMENT, 
 company_name VARCHAR (75) NOT NULL, 
 company_parent INT, 
 PRIMARY KEY (company_id)
)
AUTO_INCREMENT=1;

-- foreign keys
ALTER TABLE COMPANY ADD CONSTRAINT company_company_fk FOREIGN KEY (company_parent) REFERENCES COMPANY (company_id);


CREATE TABLE MOVIE_COMPANY (
    movie_id INT,
    company_id INT,
    PRIMARY KEY (movie_id, company_id)
);

-- foreign keys
ALTER TABLE MOVIE_COMPANY ADD CONSTRAINT movie_comp_movie_fk FOREIGN KEY (movie_id) REFERENCES MOVIE (movie_id); 
ALTER TABLE MOVIE_COMPANY ADD CONSTRAINT movie_comp_company_fk FOREIGN KEY (company_id) REFERENCES COMPANY (company_id);


CREATE TABLE USER (
    user_name VARCHAR(200) NOT NULL,
    user_email VARCHAR(320),
    user_phone VARCHAR(15),
    PRIMARY KEY (user_name)
);

CREATE TABLE REVIEW (
	review_id INT NOT NULL AUTO_INCREMENT, 
    user_name VARCHAR (200) NOT NULL, 
    movie_id INT NOT NULL,
    review_date DATE NOT NULL,
    review_rating DECIMAL (2,1) NOT NULL,
    review_description VARCHAR (300), 
    PRIMARY KEY (review_id),
    UNIQUE (user_name, movie_id, review_date),
    CHECK (review_rating >= 0 and review_rating <= 5)
)AUTO_INCREMENT=1;

-- foreign keys
ALTER TABLE REVIEW ADD CONSTRAINT review_movie_fk FOREIGN KEY (movie_id) REFERENCES MOVIE (movie_id); 
ALTER TABLE REVIEW ADD CONSTRAINT review_user_fk FOREIGN KEY (user_name) REFERENCES USER (user_name);



