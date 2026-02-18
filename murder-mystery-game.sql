-- Record your SQL detective process here!  Write down: 
--   1. The SQL queries you ran
--   2. Any notes or insights as SQL comments
--   3. Your final conclusion: who did it? Jeremy Bowers

-- Using these SQL clauses will help you solve the mystery: 
--    SELECT, FROM, WHERE, AND, OR, ORDER BY, LIMIT, LIKE, DISTINCT, BETWEEN, AS

-- writing a comment like this

-- selecting all columns from the crime scene report
-- 1) Find the murder report for Jan 15, 2018 in SQL City
SELECT *
FROM crime_scene_report
WHERE date = 20180115
  AND city = 'SQL City'
  AND type = 'murder';

-- 2) Witness 1: last house on Northwestern Dr (highest address number)
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

-- 3) Witness 2: Annabel on Franklin Ave
SELECT *
FROM person
WHERE name LIKE 'Annabel%'
  AND address_street_name = 'Franklin Ave';

-- 4) Get both witness interviews
SELECT *
FROM interview
WHERE person_id IN (14887, 16371);

-- 5) Find gold gym members whose membership ID starts with 48Z
SELECT *
FROM get_fit_now_member
WHERE membership_status = 'gold'
  AND id LIKE '48Z%';

-- 6) Confirm who checked in on Jan 9, 2018 (Annabel saw them that day)
SELECT *
FROM get_fit_now_check_in
WHERE membership_id LIKE '48Z%'
  AND check_in_date = 20180109;

-- 7) Match the license plate clue (contains H42W)
SELECT p.*, dl.*
FROM person p
JOIN get_fit_now_member g ON p.id = g.person_id
JOIN drivers_license dl ON p.license_id = dl.id
WHERE g.membership_status = 'gold'
  AND g.id LIKE '48Z%'
  AND dl.plate_number LIKE '%H42W%';

-- Conclusion (murderer): Jeremy Bowers
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
SELECT value FROM solution;

-- 8) Interview Jeremy to learn who hired him (mastermind clue)
SELECT *
FROM interview
WHERE person_id = 67318;

-- Find wealthy red-haired woman with Tesla Model S, height 65-67
SELECT p.id, p.name, dl.*
FROM person p
JOIN drivers_license dl ON p.license_id = dl.id
WHERE dl.gender = 'female'
  AND dl.hair_color = 'red'
  AND dl.height BETWEEN 65 AND 67
  AND dl.car_make = 'Tesla'
  AND dl.car_model = 'Model S';

-- Find who attended SQL Symphony Concert 3 times in Dec 2017
SELECT person_id, COUNT(*) AS checkins
FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert'
  AND date LIKE '201712%'
GROUP BY person_id
HAVING COUNT(*) = 3;

-- Miranda Priestly is the person who hired Jeremy 
SELECT p.id, p.name
FROM person p
JOIN drivers_license dl ON dl.id = p.license_id
JOIN facebook_event_checkin f ON f.person_id = p.id
WHERE dl.gender = 'female'
  AND dl.hair_color = 'red'
  AND dl.height BETWEEN 65 AND 67
  AND dl.car_make = 'Tesla'
  AND dl.car_model = 'Model S'
  AND f.event_name = 'SQL Symphony Concert'
  AND f.date LIKE '201712%'
GROUP BY p.id
HAVING COUNT(*) = 3;


