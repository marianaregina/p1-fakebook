INSERT INTO USERS (USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER)
SELECT DISTINCT USER_ID
FROM project1.PUBLIC_USER_INFORMATION;

INSERT INTO CITIES (CITY_NAME, STATE_NAME, COUNTRY_NAME)
SELECT DISTINCT CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY
FROM project1.PUBLIC_USER_INFORMATION;

INSERT INTO CITIES (CITY_NAME, STATE_NAME, COUNTRY_NAME)
SELECT DISTINCT HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY
FROM project1.PUBLIC_USER_INFORMATION;

INSERT INTO USER_CURRENT_CITIES (USER_ID, CURRENT_CITY_ID)
SELECT USER_ID, CITY_ID
FROM project1.PUBLIC_USER_INFORMATION A
INNER JOIN CITIES B
ON ((A.CURRENT_CITY = B.CITY_NAME)
    AND (A.CURRENT_STATE = B.STATE_NAME)
    AND (A.CURRENT_COUNTRY = B.COUNTRY_NAME));

INSERT INTO USER_HOMETOWN_CITIES (USER_ID, CURRENT_CITY_ID)
SELECT USER_ID, HOMETOWN_CITY_ID
FROM project1.PUBLIC_USER_INFORMATION A
INNER JOIN CITIES B
ON ((A.HOMETOWN_CITY = B.CITY_NAME)
    AND (A.HOMETOWN_STATE = B.STATE_NAME)
    AND (A.HOMETOWN_COUNTRY = B.COUNTRY_NAME)); 

INSERT INTO FRIENDS (USER1_ID, USER2_ID)
SELECT DISTINCT USER1_ID, USER2_ID
FROM project1.PUBLIC_ARE_FRIENDS;

INSERT INTO PROGRAMS (INSTITUTION, CONCENTRATION, DEGREE)
SELECT DISTINCT INSTITUTION, CONCENTRATION, DEGREE
FROM project1.PUBLIC_USER_INFORMATION;

INSERT INTO EDUCATION (USER_ID, PROGRAM_ID, PROGRAM_YEAR)
SELECT DISTINCT USER_ID
FROM project1.PUBLIC_USER_INFORMATION;

INSERT INTO USER_EVENTS (EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_ADDRESS, EVENT_CITY_ID, EVENT_START_TIME, EVENT_END_TIME)
SELECT DISTINCT EVENT_CREATOR_ID, EVENT_CITY_ID
FROM project1.PUBLIC_EVENT_INFORMATION;

INSERT INTO PARTICIPANTS (EVENT_ID, USER_ID, CONFIRMATION)
SELECT DISTINCT EVENT_ID, USER_ID
FROM project1.PUBLIC_EVENT_INFORMATION;

-- Needed because Albums and Photos have circular dependency
SET AUTOCOMMIT OFF;

INSERT INTO ALBUMS (ALBUM_ID, ALBUM_OWNER_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY, COVER_PHOTO_ID)
SELECT DISTINCT ALBUM_ID
FROM project1.PUBLIC_PHOTO_INFORMATION;

INSERT INTO PHOTOS (PHOTO_ID, ALBUM_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK)
SELECT DISTINCT PHOTO_ID
FROM project1.PUBLIC_PHOTO_INFORMATION;

COMMIT;
SET AUTOCOMMIT ON;

INSERT INTO TAGS (TAG_PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE)
SELECT DISTINCT TAG_PHOTO_ID, TAG_SUBJECT_ID
FROM project1.PUBLIC_TAG_INFORMATION;

