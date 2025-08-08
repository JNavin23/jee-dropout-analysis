-- JEE Aspirants Analysis : success or dropout

CREATE DATABASE IF NOT EXISTS jee_student_analysis;
USE jee_student_analysis;

-- Insights 

-- Top Scorers Who Still Dropped Out
SELECT COUNT(*) AS insecure_high_scorers
FROM jee_dropout_data
WHERE mock_test_score_avg >= 80 AND dropout =1;

-- Coaching Centers with High Mock but Poor Advanced Scores
SELECT coaching_institute, COUNT(*) AS suspicious_count
FROM jee_dropout_data
WHERE mock_test_score_avg > 70 AND jee_advanced_score < 30
GROUP BY coaching_institute
ORDER BY suspicious_count DESC;

-- Do More Attempts Help?
SELECT attempt_count,
   COUNT(*) AS total,
   SUM(CASE WHEN admission_taken = 'Yes' THEN 1 ELSE 0 END) AS admitted,
   ROUND(SUM(CASE WHEN admission_taken = 'Yes' THEN 1 ELSE 0 END)* 100.0/COUNT(*), 2) AS success_rate
FROM jee_dropout_data
GROUP BY attempt_count;

-- Peer Pressure Victims (High Pressure Students)
SELECT COUNT(*) AS survivors
FROM jee_dropout_data
WHERE peer_pressure_level = 'High';

-- Dropout vs Study Time
SELECT daily_study_hours, COUNT(*) AS dropout_count
FROM jee_dropout_data
WHERE dropout = 1
GROUP BY daily_study_hours
ORDER BY dropout_count DESC
LIMIT 5;

-- Middle Class Fighters
SELECT family_income,
      ROUND(AVG(jee_main_score), 2) AS avg_main,
      ROUND(AVG(dropout), 2) AS dropout_rate
FROM jee_dropout_data
WHERE peer_pressure_level = 'High'
GROUP BY family_income;

-- Best School Boards
SELECT school_board ,COUNT(*) AS successful_first_attempts
FROM jee_dropout_data
WHERE attempt_count = 1 AND admission_taken= 'Yes'
GROUP BY school_board
ORDER BY successful_first_attempts DESC;
