"use strict";
const db = require("../models/db-conn");

async function getAllUsers() {
    let sql = "SELECT * FROM users;";
    return await db.all(sql); // Await the promise
};

async function getUserPreferences(userId) {
    console.log("Fetching preferences for user ID:", userId);
    const sql = "SELECT fit_goal, exp_level FROM users WHERE user_id = ?;";
    const row = await db.get(sql, [userId]);
    console.log("User preferences fetched:", row);
    return row; // Return the fetched row
}

async function getWorkouts() {
    const sql = "SELECT * FROM workouts;";
    return await db.all(sql); // Await the promise
}

module.exports = {
    getAllUsers,
    getUserPreferences,
    getWorkouts
};
