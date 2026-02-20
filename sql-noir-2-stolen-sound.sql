-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?


-- Case #002: The Stolen Sound
-- Goal: Identify who stole the vinyl record from West Hollywood Records on July 15, 1983.

-- 1) Retrieve the crime scene report
SELECT *
FROM crime_scene
WHERE date = 19830715
  AND location = 'West Hollywood Records';

-- Crime scene id = 65

-- 2) Retrieve witness clues
SELECT *
FROM witnesses
WHERE crime_scene_id = 65;

-- Clues:
-- - Man wearing a red bandana
-- - Had a gold watch

-- 3) Find suspects matching those clues
SELECT *
FROM suspects
WHERE bandana_color = 'red'
  AND accessory LIKE '%gold watch%';

-- Found suspects: Tony Ramirez (35), Mickey Rivera (44), Rico Delgado (97)

-- 4) Verify with interview transcripts
SELECT s.id, s.name, i.transcript
FROM suspects s
JOIN interviews i ON i.suspect_id = s.id
WHERE s.id IN (35, 44, 97);

-- Rico Delgado confessed: "I snapped and took the record."

-- Final conclusion:
-- Rico Delgado (id 97) stole the vinyl record.