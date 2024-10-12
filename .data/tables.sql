CREATE TABLE IF NOT EXISTS users (
    user_id int NOT NULL UNIQUE,
    fname varchar(50) NOT NULL,
    lname varchar(50) NOT NULL,
    username varchar(50) NOT NULL,
    email varchar(255) NOT NULL,
    fit_goal varchar(255) NOT NULL,
    exp_level varchar(50) NOT NULL,
    created_at datetime NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS workout_plans (
    plan_id int NOT NULL UNIQUE,
    user_id int NOT NULL,
    plan_name varchar(255) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    active bool NOT NULL,
    PRIMARY KEY (plan_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
); 

CREATE TABLE IF NOT EXISTS workouts (
    workout_id int NOT NULL UNIQUE,
    plan_id int NOT NULL,
    wk_date date NOT NULL,
    cals int NOT NULL,
    type varchar(50) NOT NULL,
    intensity varchar(50) NOT NULL,
    duration int NOT NULL,
    PRIMARY KEY (workout_id),
    FOREIGN KEY (plan_id) REFERENCES workout_plans(plan_id) ON DELETE CASCADE
);  

CREATE TABLE IF NOT EXISTS exercises (
    exercise_id int NOT NULL UNIQUE,
    workout_id int NOT NULL,
    api_id int NOT NULL,
    plan_sets int NOT NULL,
    plan_reps int NOT NULL,
    plan_weight decimal NOT NULL,
    rest_time int NOT NULL,
    exercise_name varchar(255) NOT NULL, 
    PRIMARY KEY (exercise_id),
    FOREIGN KEY (workout_id) REFERENCES workouts(workout_id) ON DELETE CASCADE
);  
CREATE TABLE IF NOT EXISTS workout_performance (
    perf_id int NOT NULL,
    exercise_id int NOT NULL,
    actual_sets int NOT NULL,
    actual_reps int NOT NULL,
    actual_weight decimal NOT NULL,
    perf_date datetime NOT NULL,
    PRIMARY KEY (perf_id),
    FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id) ON DELETE CASCADE
);  
CREATE TABLE IF NOT EXISTS feedback (
    feedback_id int NOT NULL UNIQUE,
    exercise_id int NOT NULL,
    user_id int NOT NULL,
    rating int NOT NULL,
    PRIMARY KEY (feedback_id),
    FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id) ON DELETE CASCADE ,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);  

CREATE TABLE IF NOT EXISTS user_preferences (
    preference_id int NOT NULL UNIQUE,
    user_id int NOT NULL,
    preferred_types varchar(255),
    preferred_intensity varchar(50),
    preferred_duration int,
    preferred_exercise varchar(255),
    PRIMARY KEY (preference_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);




CREATE TABLE IF NOT EXISTS user_feedback (
    user_id INT,
    workout_id INT,
    rating INT,
    calories_burned INT,
    PRIMARY KEY (user_id, workout_id)
);






INSERT INTO `users` (`user_id`, `fname`, `lname`, `username`, `email`, `fit_goal`, `exp_level`, `created_at`)
VALUES
  (7572, "Ursa", "Moses", "Joseph F. Dudley", "vulputate.dui.nec@icloud.ca", "Strength", "Advanced", "2025-01-09 01:16:10"),
  (9014, "Nora", "Anthony", "Nadine L. Harrison", "nunc.sed@aol.com", "Endurance", "Beginner", "2024-11-09 01:16:10"),
  (2710, "Lucius", "Puckett", "Benedict Y. Meadows", "cras.sed@yahoo.net", "Hypertrophy", "Intermediate", "2015-01-09 01:16:10"),
  (3601, "Connor", "Hurst", "Chaim D. Guy", "vel.arcu@aol.net", "Strength", "Advanced", "2024-01-09 01:16:10"),
  (2624, "Lila", "Henry", "Bryar Y. Richards", "egestas.urna@icloud.net", "Endurance", "Beginner", "2020-01-09 01:16:10");

INSERT INTO `workout_plans` (`plan_id`, `user_id`, `plan_name`, `start_date`, `end_date`, `active`)
VALUES
  (84179, 7572, "plan1", "2025-01-09", "2025-05-26", TRUE),
  (18873, 9014, "plan2", "2024-11-09", "2024-12-25", FALSE),
  (80156, 2710, "plan3", "2015-01-09", "2025-07-22", TRUE),
  (23446, 3601, "plan4", "2024-01-09", "2025-07-21", FALSE),
  (47699, 2624, "plan5", "2020-01-09", "2024-09-21", FALSE);

INSERT INTO `workouts` (`workout_id`, `plan_id`, `wk_date`, `cals`, `type`, `intensity`, `duration`)
VALUES
  (48867, 84179, "2024-10-14", 772, "Strength", "Advanced", 30),
  (39681, 18873, "2025-01-27", 965, "Endurance", "Beginner", 25),
  (94137, 80156, "2024-08-14", 353, "Hypertrophy", "Intermediate", 20),
  (83779, 23446, "2025-06-16", 147, "Strength", "Advanced", 15),
  (65927, 47699, "2025-05-05", 533, "Endurance", "Beginner", 10);

INSERT INTO `workout_performance` (`perf_id`, `exercise_id`, `actual_sets`, `actual_reps`, `actual_weight`, `perf_date`)
VALUES
  (10, 1, 3, 13, 13.5, "2019-02-09 02:16:10"),
  (20, 2, 15, 4, 11.00, "2021-01-09 03:20:10"),
  (30, 3, 9, 2, 11.5, "2024-03-14 04:18:10"),
  (40, 4, 1, 10, 3.00, "2023-04-19 05:40:10"),
  (50, 5, 4, 13, 11.5, "2015-01-05 06:55:10");

INSERT INTO `feedback` (`feedback_id`, `exercise_id`, `user_id`, `rating`)
VALUES
  (100, 1, 7572, 10),
  (200, 2, 9014, 9),
  (300, 3, 2710, 8),
  (400, 4, 3601, 7),
  (500, 5, 2624, 7);

INSERT INTO `exercises` (`exercise_id`, `workout_id`, `api_id`, `plan_sets`, `plan_reps`, `plan_weight`, `rest_time`, `exercise_name`)
VALUES
  (6, 48867, 1024, 4, 12, 50, 60, "Chest Press"),
  (7, 39681, 1025, 3, 15, 80, 90, "Squats");

INSERT INTO `user_preferences` (`preference_id`, `user_id`, `preferred_types`, `preferred_intensity`, `preferred_duration`, `preferred_exercise`)
VALUES
  (1, 3601, "Strength", "Advanced", 15, "Chest Press"),
(2, 2710, "Hypertrophy", "Intermediate", 20, "Bench Press"),
(3, 2624, "Enndurance", "Beginner", 10, "Squats"),
(4, 7572, "Strength", "Advanced", 30, "Deadlift"),
(5, 9014, "Endurance", "Beginner", 25, "Squats");



ERT INTO workout_plans (plan_id, user_id, plan_name, start_date, end_date, active)
VALUES (1, 3601, 'Strength Training Plan', '2024-10-01', '2024-12-31', TRUE);
       

INSERT INTO workouts (workout_id, plan_id, wk_date, cals, type, intensity, duration)
VALUES 
(1, 1, '2024-10-01', 300, 'Strength', 'Advanced', 45),
/*
    (2, 2, '2024-10-08', 400, 'Strength', 'Advanced', 60),
(3, 3, '2024-10-01', 500, 'Endurance', 'Beginner', 120),
(4, 4, '2024-10-08', 600, 'Endurance', 'Beginner', 125),
(5, 5, '2024-10-01', 250, 'Hypertrophy', 'Intermediate', 30),
(6, 6, '2024-10-08', 450, 'Hypertrophy', 'Intermediate', 60);
*/
INSERT INTO exercises (exercise_id, workout_id, api_id, plan_sets, plan_reps, plan_weight, rest_time, exercise_name)
VALUES 
(8, 1, 101, 4, 12, 50.0, 60, 'Bench Press'),
(9, 1, 102, 3, 10, 60.0, 90, 'Deadlift');

INSERT INTO user_preferences (preference_id, user_id, preferred_types, preferred_intensity, preferred_duration, preferred_exercise)
VALUES (1, 3601, 'Strength', 'Advanced', NULL, 'Bench Press');

INSERT INTO user_feedback (user_id, workout_id, rating, calories_burned)
VALUES (3601, 1, 5, 100),
    (2710, 94137, 6, 150),
    (2624, 65927, 7, 200),
    (9014, 39681, 8, 250),
    (7572, 48867, 9, 300);
