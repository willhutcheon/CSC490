CREATE TABLE users (
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

CREATE TABLE workout_plans (
    plan_id int NOT NULL UNIQUE,
    user_id int NOT NULL,
  	plan_name varchar(255) NOT NULL,
    start_date date NOT NULL,
  	end_date date NOT NULL,
  	active bool NOT NULL,
    PRIMARY KEY (plan_id),
  	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
); 

CREATE TABLE workouts (
    workout_id int NOT NULL UNIQUE,
  	plan_id int NOT NULL,
  	wk_date date NOT NULL,
  	cals int NOT NULL,
    PRIMARY KEY (workout_id),
  	FOREIGN KEY (plan_id) REFERENCES workout_plans(plan_id) ON DELETE CASCADE
);  

CREATE TABLE exercises (
    exercise_id int NOT NULL UNIQUE,
  	workout_id int NOT NULL,
  	api_id int NOT NULL,
  	plan_sets int NOT NULL,
	plan_reps int NOT NULL,
  	plan_weight decimal NOT NULL,
  	rest_time int NOT NULL,
    PRIMARY KEY (exercise_id),
  	FOREIGN KEY (workout_id) REFERENCES workouts(workout_id) ON DELETE CASCADE
);  
CREATE TABLE workout_performance (
    perf_id int NOT NULL,
  	exercise_id int NOT NULL,
  	actual_sets int NOT NULL,
  	actual_reps int NOT NULL,
  	actual_weight decimal NOT NULL,
  	perf_date datetime NOT NULL,
    PRIMARY KEY (perf_id),
  	FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id) ON DELETE CASCADE
);  
CREATE TABLE feedback (
    feedback_id int NOT NULL UNIQUE,
  	exercise_id int NOT NULL,
  	user_id int NOT NULL,
  	rating int NOT NULL,
    PRIMARY KEY (feedback_id),
  	FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id) ON DELETE CASCADE ,
  	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);  


INSERT INTO `users` (`user_id`,`fname`,`lname`,`username`,`email`,`fit_goal`,`exp_level`,`created_at`)
VALUES
  (7572,"Ursa","Moses","Joseph F. Dudley","vulputate.dui.nec@icloud.ca","Donec","rhoncus.","2025-01-09 01:16:10"),
  (9014,"Nora","Anthony","Nadine L. Harrison","nunc.sed@aol.com","erat","velit","2024-11-09 01:16:10"),
  (2710,"Lucius","Puckett","Benedict Y. Meadows","cras.sed@yahoo.net","venenatis","nisl.","2015-01-09 01:16:10"),
  (3601,"Connor","Hurst","Chaim D. Guy","vel.arcu@aol.net","Aliquam","metus.","2024-01-09 01:16:10"),
  (2624,"Lila","Henry","Bryar Y. Richards","egestas.urna@icloud.net","augue","augue","2020-01-09 01:16:10");

