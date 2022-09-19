CREATE TABLE Users (
    user_id INTEGER NOT NULL PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    year_of_birth INTEGER,
    month_of_birth INTEGER,
    day_of_birth INTEGER,
    gender VARCHAR2(100)
);

CREATE TABLE Friends (
    user1_id INTEGER NOT NULL,
    user2_id INTEGER NOT NULL,
    PRIMARY KEY (user1_id, user2_id),
    CHECK (user1_id != user2_id)
);

CREATE TABLE Cities (
    city_id INTEGER NOT NULL PRIMARY KEY,
    city_name VARCHAR2(100) NOT NULL,
    state_name VARCHAR2(100) NOT NULL,
    country_name VARCHAR2(100) NOT NULL
);

CREATE TABLE User_Current_Cities (
    user_id INTEGER NOT NULL,
    current_city_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, current_city_id)
);

CREATE TABLE User_Hometown_Cities (
    user_id INTEGER NOT NULL,
    current_city_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, current_city_id)
);

CREATE TABLE Messages (
    message_id INTEGER NOT NULL PRIMARY KEY,
    sender_id INTEGER NOT NULL,
    receiver_id INTEGER NOT NULL,
    message_content VARCHAR2(2000) NOT NULL,
    sent_time TIMESTAMP NOT NULL
);

CREATE TABLE Programs (
    program_id INTEGER NOT NULL PRIMARY KEY,
    institution VARCHAR2(100) NOT NULL,
    concentration VARCHAR2(100) NOT NULL,
    degree VARCHAR2(100) NOT NULL
);

CREATE TABLE Education (
    user_id INTEGER NOT NULL,
    program_id INTEGER NOT NULL,
    program_year INTEGER NOT NULL,
    PRIMARY KEY (user_id, program_id)
);

CREATE TABLE User_Events (
    event_id INTEGER NOT NULL UNIQUE,
    event_creator_id INTEGER NOT NULL,
    event_name VARCHAR2(100) NOT NULL,
    event_tagline VARCHAR2(100),
    event_description VARCHAR2(100),
    event_type VARCHAR2(100),
    event_subtype VARCHAR2(100),
    event_address VARCHAR2(2000),
    event_city_id INTEGER NOT NULL,
    event_start_time TIMESTAMP,
    event_end_time TIMESTAMP,
    PRIMARY KEY (event_id, event_creator_id, event_city_id)
);

CREATE TABLE Participants (
    event_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    confirmation VARCHAR2(100) NOT NULL,
    PRIMARY KEY (event_id, user_id),
    CHECK (confirmation IN ('ATTENDING', 'UNSURE', 'DECLINES', 'NOT_REPLIED'))
);


CREATE TABLE Albums (
    album_id INTEGER NOT NULL PRIMARY KEY,
    album_owner_id INTEGER NOT NULL,
    album_name VARCHAR2(100) NOT NULL,
    album_created_time TIMESTAMP NOT NULL,
    album_modified_time TIMESTAMP,
    album_link VARCHAR2(100) NOT NULL,
    album_visibility VARCHAR2(100) NOT NULL,
    cover_photo_id INTEGER NOT NULL,
    CHECK (album_visibility IN ('EVERYONE', 'FRIENDS', 'FRIENDS_OF_FRIENDS', 'MYSELF'))
);

CREATE TABLE Photos (
    photo_id INTEGER NOT NULL PRIMARY KEY,
    album_id INTEGER NOT NULL,
    photo_caption VARCHAR2(2000),
    photo_created_time TIMESTAMP NOT NULL,
    photo_modified_time TIMESTAMP,
    photo_link VARCHAR2(2000) NOT NULL
);

CREATE TABLE Tags (
    tag_photo_id INTEGER NOT NULL,
    tag_subject_id INTEGER NOT NULL,
    tag_created_time TIMESTAMP NOT NULL,
    tag_x INTEGER NOT NULL,
    tag_y INTEGER NOT NULL,
    PRIMARY KEY (tag_photo_id, tag_subject_id)
);

ALTER TABLE Friends
ADD CONSTRAINT user1_exists FOREIGN KEY (user1_id) REFERENCES Users (user_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Friends
ADD CONSTRAINT user2_exists FOREIGN KEY (user2_id) REFERENCES Users (user_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE User_Current_Cities
ADD CONSTRAINT ucc_user_exists FOREIGN KEY (user_id) REFERENCES Users (user_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE User_Hometown_Cities
ADD CONSTRAINT uhc_user_exists FOREIGN KEY (user_id) REFERENCES Users (user_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Messages
ADD CONSTRAINT sender_exists FOREIGN KEY (sender_id) REFERENCES Users (user_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Messages
ADD CONSTRAINT receiver_exists FOREIGN KEY (receiver_id) REFERENCES Users (user_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Education
ADD CONSTRAINT edu_user_exists FOREIGN KEY (user_id) REFERENCES Users (user_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Education
ADD CONSTRAINT program_exists FOREIGN KEY (program_id) REFERENCES Programs (program_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE User_Events
ADD CONSTRAINT creator_exists FOREIGN KEY (event_creator_id) REFERENCES Users (user_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Participants
ADD CONSTRAINT event_exists FOREIGN KEY (event_id) REFERENCES User_Events (event_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Participants
ADD CONSTRAINT p_user_exists FOREIGN KEY (user_id) REFERENCES Users (user_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Albums
ADD CONSTRAINT alb_user_exists FOREIGN KEY (album_owner_id) REFERENCES Users (user_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Albums
ADD CONSTRAINT photo_exists FOREIGN KEY (cover_photo_id) REFERENCES Photos (photo_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Photos
ADD CONSTRAINT album_exists FOREIGN KEY (album_id) REFERENCES Albums (album_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Tags
ADD CONSTRAINT tag_user_exists FOREIGN KEY (tag_subject_id) REFERENCES Users (user_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Tags
ADD CONSTRAINT tag_photo_exists FOREIGN KEY (tag_photo_id) REFERENCES Photos (photo_id)
ON DELETE CASCADE
INITIALLY DEFERRED DEFERRABLE;
