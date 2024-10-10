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

module.exports = {
    getAllUsers,
    getUserPreferences,
    getWorkouts
};
