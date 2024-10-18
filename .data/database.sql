--
-- File generated with SQLiteStudio v3.4.4 on Fri Oct 18 00:15:44 2024
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: exercises
CREATE TABLE IF NOT EXISTS exercises (
    exercise_id   INT           NOT NULL
                                UNIQUE,
    workout_id    INT           NOT NULL,
    api_id        INT           NOT NULL,
    plan_sets     INT           NOT NULL,
    plan_reps     INT           NOT NULL,
    plan_weight   DECIMAL       NOT NULL,
    rest_time     INT           NOT NULL,
    exercise_name VARCHAR (255) NOT NULL
                                DEFAULT 'Unknown',
    PRIMARY KEY (
        exercise_id
    ),
    FOREIGN KEY (
        workout_id
    )
    REFERENCES workouts (workout_id) ON DELETE CASCADE
);

INSERT INTO exercises (
                          exercise_id,
                          workout_id,
                          api_id,
                          plan_sets,
                          plan_reps,
                          plan_weight,
                          rest_time,
                          exercise_name
                      )
                      VALUES (
                          1,
                          48867,
                          3972,
                          13,
                          13,
                          24.5,
                          2,
                          'Unknown'
                      );

INSERT INTO exercises (
                          exercise_id,
                          workout_id,
                          api_id,
                          plan_sets,
                          plan_reps,
                          plan_weight,
                          rest_time,
                          exercise_name
                      )
                      VALUES (
                          2,
                          39681,
                          5858,
                          4,
                          11,
                          27.5,
                          23,
                          'Unknown'
                      );

INSERT INTO exercises (
                          exercise_id,
                          workout_id,
                          api_id,
                          plan_sets,
                          plan_reps,
                          plan_weight,
                          rest_time,
                          exercise_name
                      )
                      VALUES (
                          3,
                          94137,
                          6433,
                          2,
                          11,
                          31,
                          20,
                          'Unknown'
                      );

INSERT INTO exercises (
                          exercise_id,
                          workout_id,
                          api_id,
                          plan_sets,
                          plan_reps,
                          plan_weight,
                          rest_time,
                          exercise_name
                      )
                      VALUES (
                          4,
                          83779,
                          9233,
                          10,
                          3,
                          18.5,
                          19,
                          'Unknown'
                      );

INSERT INTO exercises (
                          exercise_id,
                          workout_id,
                          api_id,
                          plan_sets,
                          plan_reps,
                          plan_weight,
                          rest_time,
                          exercise_name
                      )
                      VALUES (
                          5,
                          65927,
                          2903,
                          13,
                          11,
                          24.5,
                          25,
                          'Unknown'
                      );

INSERT INTO exercises (
                          exercise_id,
                          workout_id,
                          api_id,
                          plan_sets,
                          plan_reps,
                          plan_weight,
                          rest_time,
                          exercise_name
                      )
                      VALUES (
                          6,
                          48867,
                          1024,
                          4,
                          12,
                          50,
                          60,
                          'Chest Press'
                      );

INSERT INTO exercises (
                          exercise_id,
                          workout_id,
                          api_id,
                          plan_sets,
                          plan_reps,
                          plan_weight,
                          rest_time,
                          exercise_name
                      )
                      VALUES (
                          7,
                          39681,
                          1025,
                          3,
                          15,
                          80,
                          90,
                          'Squats'
                      );

INSERT INTO exercises (
                          exercise_id,
                          workout_id,
                          api_id,
                          plan_sets,
                          plan_reps,
                          plan_weight,
                          rest_time,
                          exercise_name
                      )
                      VALUES (
                          8,
                          1,
                          101,
                          4,
                          12,
                          50,
                          60,
                          'Bench Press'
                      );

INSERT INTO exercises (
                          exercise_id,
                          workout_id,
                          api_id,
                          plan_sets,
                          plan_reps,
                          plan_weight,
                          rest_time,
                          exercise_name
                      )
                      VALUES (
                          9,
                          1,
                          102,
                          3,
                          10,
                          60,
                          90,
                          'Deadlift'
                      );


-- Table: feedback
CREATE TABLE IF NOT EXISTS feedback (
    feedback_id INT NOT NULL
                    UNIQUE,
    exercise_id INT NOT NULL,
    user_id     INT NOT NULL,
    rating      INT NOT NULL,
    PRIMARY KEY (
        feedback_id
    ),
    FOREIGN KEY (
        exercise_id
    )
    REFERENCES exercises (exercise_id) ON DELETE CASCADE,
    FOREIGN KEY (
        user_id
    )
    REFERENCES users (user_id) ON DELETE CASCADE
);

INSERT INTO feedback (
                         feedback_id,
                         exercise_id,
                         user_id,
                         rating
                     )
                     VALUES (
                         100,
                         1,
                         7572,
                         10
                     );

INSERT INTO feedback (
                         feedback_id,
                         exercise_id,
                         user_id,
                         rating
                     )
                     VALUES (
                         200,
                         2,
                         9014,
                         9
                     );

INSERT INTO feedback (
                         feedback_id,
                         exercise_id,
                         user_id,
                         rating
                     )
                     VALUES (
                         300,
                         3,
                         2710,
                         8
                     );

INSERT INTO feedback (
                         feedback_id,
                         exercise_id,
                         user_id,
                         rating
                     )
                     VALUES (
                         400,
                         4,
                         3601,
                         7
                     );

INSERT INTO feedback (
                         feedback_id,
                         exercise_id,
                         user_id,
                         rating
                     )
                     VALUES (
                         500,
                         5,
                         2624,
                         7
                     );


-- Table: user_feedback
CREATE TABLE IF NOT EXISTS user_feedback (
    user_id         INT,
    workout_id      INT,
    rating          INT,
    calories_burned INT,
    PRIMARY KEY (
        user_id,
        workout_id
    )
);

INSERT INTO user_feedback (
                              user_id,
                              workout_id,
                              rating,
                              calories_burned
                          )
                          VALUES (
                              3601,
                              1,
                              2,
                              2
                          );


-- Table: user_preferences
CREATE TABLE IF NOT EXISTS user_preferences (
    preference_id       INT           NOT NULL
                                      UNIQUE,
    user_id             INT           NOT NULL,
    preferred_types     VARCHAR (255),
    preferred_intensity VARCHAR (50),
    preferred_duration  INT,
    preferred_exercise  VARCHAR (255),
    PRIMARY KEY (
        preference_id
    ),
    FOREIGN KEY (
        user_id
    )
    REFERENCES users (user_id) ON DELETE CASCADE
);

INSERT INTO user_preferences (
                                 preference_id,
                                 user_id,
                                 preferred_types,
                                 preferred_intensity,
                                 preferred_duration,
                                 preferred_exercise
                             )
                             VALUES (
                                 1,
                                 3601,
                                 'Strength',
                                 'Advanced',
                                 NULL,
                                 'Bench Press'
                             );

INSERT INTO user_preferences (
                                 preference_id,
                                 user_id,
                                 preferred_types,
                                 preferred_intensity,
                                 preferred_duration,
                                 preferred_exercise
                             )
                             VALUES (
                                 2,
                                 2710,
                                 'Hypertrophy',
                                 'Beginner',
                                 20,
                                 'Squat'
                             );

INSERT INTO user_preferences (
                                 preference_id,
                                 user_id,
                                 preferred_types,
                                 preferred_intensity,
                                 preferred_duration,
                                 preferred_exercise
                             )
                             VALUES (
                                 3,
                                 2624,
                                 'Endurance',
                                 'Medium',
                                 30,
                                 'Squats'
                             );


-- Table: users
CREATE TABLE IF NOT EXISTS users (
    user_id    INT           NOT NULL
                             UNIQUE,
    fname      VARCHAR (50)  NOT NULL,
    lname      VARCHAR (50)  NOT NULL,
    username   VARCHAR (50)  NOT NULL,
    email      VARCHAR (255) NOT NULL,
    fit_goal   VARCHAR (255) NOT NULL,
    exp_level  VARCHAR (50)  NOT NULL,
    created_at DATETIME      NOT NULL,
    PRIMARY KEY (
        user_id
    )
);

INSERT INTO users (
                      user_id,
                      fname,
                      lname,
                      username,
                      email,
                      fit_goal,
                      exp_level,
                      created_at
                  )
                  VALUES (
                      7572,
                      'Ursa',
                      'Moses',
                      'Joseph F. Dudley',
                      'vulputate.dui.nec@icloud.ca',
                      'Strength',
                      'Beginner',
                      '2025-01-09 01:16:10'
                  );

INSERT INTO users (
                      user_id,
                      fname,
                      lname,
                      username,
                      email,
                      fit_goal,
                      exp_level,
                      created_at
                  )
                  VALUES (
                      9014,
                      'Nora',
                      'Anthony',
                      'Nadine L. Harrison',
                      'nunc.sed@aol.com',
                      'Endurance',
                      'Advanced',
                      '2024-11-09 01:16:10'
                  );

INSERT INTO users (
                      user_id,
                      fname,
                      lname,
                      username,
                      email,
                      fit_goal,
                      exp_level,
                      created_at
                  )
                  VALUES (
                      2710,
                      'Lucius',
                      'Puckett',
                      'Benedict Y. Meadows',
                      'cras.sed@yahoo.net',
                      'Hypertrophy',
                      'Beginner',
                      '2015-01-09 01:16:10'
                  );

INSERT INTO users (
                      user_id,
                      fname,
                      lname,
                      username,
                      email,
                      fit_goal,
                      exp_level,
                      created_at
                  )
                  VALUES (
                      3601,
                      'Connor',
                      'Hurst',
                      'Chaim D. Guy',
                      'vel.arcu@aol.net',
                      'Strength',
                      'Advanced',
                      '2024-01-09 01:16:10'
                  );

INSERT INTO users (
                      user_id,
                      fname,
                      lname,
                      username,
                      email,
                      fit_goal,
                      exp_level,
                      created_at
                  )
                  VALUES (
                      2624,
                      'Lila',
                      'Jacobson',
                      'Bryar Y. Richards',
                      'egestas.urna@icloud.net',
                      'Endurance',
                      'intermediate',
                      '2020-01-09 01:16:10'
                  );


-- Table: workout_performance
CREATE TABLE IF NOT EXISTS workout_performance (
    perf_id       INT      NOT NULL,
    exercise_id   INT      NOT NULL,
    actual_sets   INT      NOT NULL,
    actual_reps   INT      NOT NULL,
    actual_weight DECIMAL  NOT NULL,
    perf_date     DATETIME NOT NULL,
    PRIMARY KEY (
        perf_id
    ),
    FOREIGN KEY (
        exercise_id
    )
    REFERENCES exercises (exercise_id) ON DELETE CASCADE
);

INSERT INTO workout_performance (
                                    perf_id,
                                    exercise_id,
                                    actual_sets,
                                    actual_reps,
                                    actual_weight,
                                    perf_date
                                )
                                VALUES (
                                    10,
                                    1,
                                    3,
                                    13,
                                    13.5,
                                    '2019-02-09 02:16:10'
                                );

INSERT INTO workout_performance (
                                    perf_id,
                                    exercise_id,
                                    actual_sets,
                                    actual_reps,
                                    actual_weight,
                                    perf_date
                                )
                                VALUES (
                                    20,
                                    2,
                                    15,
                                    4,
                                    11,
                                    '2021-01-09 03:20:10'
                                );

INSERT INTO workout_performance (
                                    perf_id,
                                    exercise_id,
                                    actual_sets,
                                    actual_reps,
                                    actual_weight,
                                    perf_date
                                )
                                VALUES (
                                    30,
                                    3,
                                    9,
                                    2,
                                    11.5,
                                    '2024-03-14 04:18:10'
                                );

INSERT INTO workout_performance (
                                    perf_id,
                                    exercise_id,
                                    actual_sets,
                                    actual_reps,
                                    actual_weight,
                                    perf_date
                                )
                                VALUES (
                                    40,
                                    4,
                                    1,
                                    10,
                                    3,
                                    '2023-04-19 05:40:10'
                                );

INSERT INTO workout_performance (
                                    perf_id,
                                    exercise_id,
                                    actual_sets,
                                    actual_reps,
                                    actual_weight,
                                    perf_date
                                )
                                VALUES (
                                    50,
                                    5,
                                    4,
                                    13,
                                    11.5,
                                    '2015-01-05 06:55:10'
                                );


-- Table: workout_plans
CREATE TABLE IF NOT EXISTS workout_plans (
    plan_id    INT           NOT NULL
                             UNIQUE,
    user_id    INT           NOT NULL,
    plan_name  VARCHAR (255) NOT NULL,
    start_date DATE          NOT NULL,
    end_date   DATE          NOT NULL,
    active     BOOL          NOT NULL,
    PRIMARY KEY (
        plan_id
    ),
    FOREIGN KEY (
        user_id
    )
    REFERENCES users (user_id) ON DELETE CASCADE
);

INSERT INTO workout_plans (
                              plan_id,
                              user_id,
                              plan_name,
                              start_date,
                              end_date,
                              active
                          )
                          VALUES (
                              84179,
                              7572,
                              'plan1',
                              '2025-01-09',
                              '2025-35-26',
                              'True'
                          );

INSERT INTO workout_plans (
                              plan_id,
                              user_id,
                              plan_name,
                              start_date,
                              end_date,
                              active
                          )
                          VALUES (
                              18873,
                              9014,
                              'plan2',
                              '2024-11-09',
                              '2024-23-25',
                              'False'
                          );

INSERT INTO workout_plans (
                              plan_id,
                              user_id,
                              plan_name,
                              start_date,
                              end_date,
                              active
                          )
                          VALUES (
                              80156,
                              2710,
                              'plan3',
                              '2015-01-09',
                              '2025-27-22',
                              'True'
                          );

INSERT INTO workout_plans (
                              plan_id,
                              user_id,
                              plan_name,
                              start_date,
                              end_date,
                              active
                          )
                          VALUES (
                              23446,
                              3601,
                              'plan4',
                              '2024-01-09',
                              '2025-17-21',
                              'False'
                          );

INSERT INTO workout_plans (
                              plan_id,
                              user_id,
                              plan_name,
                              start_date,
                              end_date,
                              active
                          )
                          VALUES (
                              47699,
                              2624,
                              'plan5',
                              '2020-01-09',
                              '2024-19-21',
                              'False'
                          );

INSERT INTO workout_plans (
                              plan_id,
                              user_id,
                              plan_name,
                              start_date,
                              end_date,
                              active
                          )
                          VALUES (
                              1,
                              3601,
                              'Strength Training Plan',
                              '2024-10-01',
                              '2024-12-31',
                              1
                          );


-- Table: workouts
CREATE TABLE IF NOT EXISTS workouts (
    workout_id INT          NOT NULL
                            UNIQUE,
    plan_id    INT          NOT NULL,
    wk_date    DATE         NOT NULL,
    cals       INT          NOT NULL,
    type       VARCHAR (50) NOT NULL,
    intensity  VARCHAR (50) NOT NULL,
    duration   INT          NOT NULL,
    PRIMARY KEY (
        workout_id
    ),
    FOREIGN KEY (
        plan_id
    )
    REFERENCES workout_plans (plan_id) ON DELETE CASCADE
);

INSERT INTO workouts (
                         workout_id,
                         plan_id,
                         wk_date,
                         cals,
                         type,
                         intensity,
                         duration
                     )
                     VALUES (
                         48867,
                         8257,
                         '2024-10-14',
                         772,
                         'Endurance',
                         'Beginner',
                         30
                     );

INSERT INTO workouts (
                         workout_id,
                         plan_id,
                         wk_date,
                         cals,
                         type,
                         intensity,
                         duration
                     )
                     VALUES (
                         39681,
                         1299,
                         '2025-1-27',
                         965,
                         'Hypertrophy',
                         'Advanced',
                         25
                     );

INSERT INTO workouts (
                         workout_id,
                         plan_id,
                         wk_date,
                         cals,
                         type,
                         intensity,
                         duration
                     )
                     VALUES (
                         94137,
                         1968,
                         '2024-41-8',
                         353,
                         'Strength',
                         'Intermediate',
                         20
                     );

INSERT INTO workouts (
                         workout_id,
                         plan_id,
                         wk_date,
                         cals,
                         type,
                         intensity,
                         duration
                     )
                     VALUES (
                         83779,
                         5749,
                         '2025-59-16',
                         147,
                         'Endurance',
                         'Beginner',
                         15
                     );

INSERT INTO workouts (
                         workout_id,
                         plan_id,
                         wk_date,
                         cals,
                         type,
                         intensity,
                         duration
                     )
                     VALUES (
                         65927,
                         5837,
                         '2025-20-5',
                         533,
                         'Strength',
                         'Advanced',
                         10
                     );

INSERT INTO workouts (
                         workout_id,
                         plan_id,
                         wk_date,
                         cals,
                         type,
                         intensity,
                         duration
                     )
                     VALUES (
                         1,
                         1,
                         '2024-10-01',
                         300,
                         'Strength',
                         'Advanced',
                         45
                     );

INSERT INTO workouts (
                         workout_id,
                         plan_id,
                         wk_date,
                         cals,
                         type,
                         intensity,
                         duration
                     )
                     VALUES (
                         2,
                         1,
                         '2024-10-08',
                         400,
                         'Strength',
                         'Advanced',
                         60
                     );


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
