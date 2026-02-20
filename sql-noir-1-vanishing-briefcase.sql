-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?




--SQL Queries: 
-- Case #001: The Vanishing Briefcase
-- Goal: Use the crime scene clue, narrow suspects, confirm via interview transcript.

-- 1) Get the crime scene details (the key clue)
SELECT *
FROM crime_scene
WHERE location = 'Blue Note Lounge'
  AND type = 'theft';

-- Insight:
-- Witness saw a man wearing a trench coat with a scar on his left cheek.

-- 2) Find suspects matching the witness description
SELECT *
FROM suspects
WHERE attire LIKE '%trench%'
  AND scar LIKE '%left cheek%';

-- Found two matches: Frankie Lombardi (id 3) and Vincent Malone (id 183)

-- 3) Verify using interview transcripts
SELECT s.id, s.name, i.transcript
FROM suspects s
JOIN interviews i ON i.suspect_id = s.id
WHERE s.id IN (3, 183);

-- Vincent Malone confessed: "I wasn’t going to steal it, but I did."

-- Final conclusion:
-- Vincent Malone (id 183) stole the briefcase.