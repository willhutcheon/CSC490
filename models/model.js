"use strict";
const db = require("../models/db-conn");

async function getAllUsers() {
    let sql = "SELECT * FROM users;";
    return await db.all(sql); // Await the promise
};

async function getUserPreferences(userId) {
    console.log("Fetching preferences for user ID:", userId);
    //const sql = "SELECT fit_goal, exp_level FROM users WHERE user_id = ?;";
    const sql = `
        SELECT fit_goal, exp_level, preferred_types, preferred_intensity, preferred_duration, preferred_exercise
        FROM users
        LEFT JOIN user_preferences ON users.user_id = user_preferences.user_id
        WHERE users.user_id = ?;
    `;
    const row = await db.get(sql, userId);
    console.log("User preferences fetched:", row);
    return row; // Return the fetched row
}

async function getWorkouts(userId) {
    // const sql = "SELECT * FROM workouts;";
    const sql = `
        SELECT w.*, e.exercise_name 
        FROM workouts w 
        JOIN exercises e ON w.workout_id = e.workout_id
        WHERE w.plan_id IN (
            SELECT plan_id 
            FROM workout_plans 
            WHERE user_id = ? 
            AND active = true
        );
    `;
    return await db.all(sql, userId); // Await the promise
}




//added
async function getUserFeedback(userId, workoutId) {
    const sql = `
        SELECT rating, calories_burned 
        FROM user_feedback 
        WHERE user_id = ? AND workout_id = ?;
    `;
    return await db.get(sql, [userId, workoutId]);
}

async function storeUserFeedback(userId, workoutId, rating, caloriesBurned) {
    const sql = `
        INSERT INTO user_feedback (user_id, workout_id, rating, calories_burned)
        VALUES (?, ?, ?, ?)
        ON CONFLICT (user_id, workout_id) DO UPDATE 
        SET rating = excluded.rating, calories_burned = excluded.calories_burned;
    `;
    return await db.run(sql, [userId, workoutId, rating, caloriesBurned]);
}

let QTable = {};

function getQValue(state, action) {
    return QTable[state]?.[action] || 0;
}

function updateQValue(state, action, reward, nextState) {
    const learningRate = 0.1;
    const discountFactor = 0.9;
    const currentQ = getQValue(state, action);
    const maxFutureQ = Math.max(...Object.values(QTable[nextState] || {}));
    const newQ = currentQ + learningRate * (reward + discountFactor * maxFutureQ - currentQ);
    if (!QTable[state]) QTable[state] = {};
    QTable[state][action] = newQ;
}

function calculateReward(feedback) {
    const ratingReward = feedback.rating;
    const performanceReward = feedback.calories_burned / 100;
    return ratingReward + performanceReward;
}

function chooseAction(state, availableWorkouts) {
    const epsilon = 0.1; // Exploration-exploitation trade-off
    if (Math.random() < epsilon) {
        // Exploration: choose random workout
        return availableWorkouts[Math.floor(Math.random() * availableWorkouts.length)];
    } else {
        // Exploitation: choose workout with highest Q-value
        return availableWorkouts.reduce((bestAction, workout) => {
            const qValue = getQValue(state, workout.workout_id);
            return (bestAction === null || qValue > getQValue(state, bestAction.workout_id)) ? workout : bestAction;
        }, null);
    }
}

async function recommendWorkoutsWithRL(userPreferences, workouts, userId) {
    const state = userPreferences.fit_goal + userPreferences.exp_level; // Simple state representation
    const availableWorkouts = workouts;
    // Choose a workout (action) based on current state
    const recommendedWorkout = chooseAction(state, availableWorkouts);
    // After the workout, get feedback from the user
    const feedback = await getUserFeedback(userId, recommendedWorkout.workout_id);
    const reward = calculateReward(feedback);
    // Update the Q-value based on feedback
    const nextState = state; // For simplicity, next state is the same as current in this example
    updateQValue(state, recommendedWorkout.workout_id, reward, nextState);
    return recommendedWorkout;
}

module.exports = {
    getAllUsers,
    getUserPreferences,
    getWorkouts,
    getUserFeedback,
    storeUserFeedback,
    getQValue,
    updateQValue,
    calculateReward,
    chooseAction,
    recommendWorkoutsWithRL
};
