-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?

-- Case #003: Coral Bay Marina Murder (1986-08-14)
-- Goal: Identify who killed the unidentified man found near the docks.

-- 1) Read the crime scene report
SELECT *
FROM crime_scene
WHERE id = 43;

-- Clue: Two people were seen nearby:
--  - Someone living on "300ish Ocean Drive"
--  - Someone whose first name ends with "ul" and last name ends with "ez"

-- 2) Find the "300ish Ocean Drive" person
SELECT *
FROM person
WHERE address LIKE '3% Ocean Drive%';

-- 3) Find the person whose first name ends with "ul" and last name ends with "ez"
SELECT *
FROM person
WHERE name LIKE '%ul%'
  AND name LIKE '%ez';

-- 4) Get their interviews (hotel clue)
SELECT p.id, p.name, i.transcript
FROM person p
LEFT JOIN interviews i ON i.person_id = p.id
WHERE p.id IN (101, 102);

-- Carlos: Someone checked into a hotel on August 13 and looked nervous.
-- Raul: The hotel name had "Sunset" in it.

-- 5) Find everyone who checked into a "Sunset" hotel on Aug 13, 1986
SELECT hc.id AS checkin_id, hc.hotel_name, hc.check_in_date, p.id AS person_id, p.name
FROM hotel_checkins hc
JOIN person p ON p.id = hc.person_id
WHERE hc.check_in_date = 19860813
  AND hc.hotel_name LIKE '%Sunset%';

-- 6) Find the actual murderer by searching confessions for the marina killing
SELECT p.id, p.name, c.confession
FROM confessions c
JOIN person p ON p.id = c.person_id
WHERE c.confession LIKE '%marina%'
   OR c.confession LIKE '%dock%'
   OR c.confession LIKE '%1986%';

-- Result: Thomas Brown (id 8) confessed:
-- "Alright! I did it. I was paid to make sure he never left the marina alive."

-- Final Conclusion:
-- Thomas Brown (id 8) is the murderer.