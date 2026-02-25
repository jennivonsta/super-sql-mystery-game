-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?

-- Case #?: Fontainebleau Hotel — “Heart of Atlantis” Necklace Theft
-- Crime Scene ID: 48
-- Date: 19870520
-- Location: Fontainebleau Hotel
-- Goal: Identify who stole the necklace.

-- 1) Read the crime scene report
SELECT *
FROM crime_scene
WHERE id = 48;

-- Notes:
-- Two valuable witnesses:
-- - A really famous actor
-- - A woman consultant whose first name ends with "an"

-- 2) Find the two witnesses from witness_statements
-- (Search results show Clint Eastwood (Actor) and Vivian Nair (Consultant))
SELECT g.id, g.name, g.occupation, w.clue
FROM witness_statements w
JOIN guest g ON g.id = w.guest_id;

-- Notes from the two key clues:
-- Clint Eastwood: "Meet me at the marina, dock 3."
-- Vivian Nair: suspect had an invitation ending with "-R", wore a navy suit and white tie.

-- 3) Check marina rentals for dock 3 on the theft date (19870520)
SELECT mr.*, g.name, g.occupation
FROM marina_rentals mr
JOIN guest g ON g.id = mr.renter_guest_id
WHERE mr.dock_number = 3
  AND mr.rental_date = 19870520;

-- 4) Find guests wearing "navy suit" and "white tie"
SELECT g.id, g.name, g.occupation, g.invitation_code, a.note
FROM attire_registry a
JOIN guest g ON g.id = a.guest_id
WHERE a.note LIKE '%navy suit%'
  AND a.note LIKE '%white tie%';

-- Note:
-- The invitation code clue says it ends with "-R" => VIP-R

-- 5) Narrow to the navy suit + white tie guest with invitation ending "-R"
-- Result: Mike Manning (id 105) with VIP-R
SELECT g.id, g.name, g.invitation_code, a.note
FROM attire_registry a
JOIN guest g ON g.id = a.guest_id
WHERE a.note LIKE '%navy suit%'
  AND a.note LIKE '%white tie%'
  AND g.invitation_code LIKE '%-R';

-- 6) Confirm Mike Manning rented dock 3 on the theft date
SELECT mr.*, g.name, g.invitation_code
FROM marina_rentals mr
JOIN guest g ON g.id = mr.renter_guest_id
WHERE g.id = 105
  AND mr.rental_date = 19870520;

-- Final Conclusion:
-- Mike Manning (id 105) stole the Heart of Atlantis necklace.