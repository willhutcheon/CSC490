"use strict";
const db = require("../models/db-conn");

async function createUser(params) {
    let sql = `
        INSERT INTO users (user_id, fname, lname, username, email, fit_goal, exp_level, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?);
    `;
    return await db.run(sql, params);
}
async function createPreferences(params) {
    let sql = `
        INSERT INTO user_preferences (preference_id, user_id, preferred_types, preferred_intensity, preferred_duration, preferred_exercise)
        VALUES (?, ?, ?, ?, ?, ?);
    `;
    return await db.run(sql, params);
}
async function deleteUser(user_id) {
    let sql = `
        DELETE FROM users WHERE user_id = ?
    `;
    return await db.run(sql, [user_id]);
}
async function updateUser(params) {
    let sql = `
        UPDATE users
        SET fname = ?, lname = ?, username = ?, email = ?, fit_goal = ?, exp_level = ?
        WHERE user_id = ?;
    `;
    return await db.run(sql, params);
}
async function updatePreferences(params) {
    let sql = `
        UPDATE user_preferences
        SET preferred_types = ?, preferred_intensity = ?, preferred_duration = ?, preferred_exercise = ?
        WHERE user_id = ?;
    `;
    return await db.run(sql, params);
}
async function getUser(user_id) {
    let sql = `
        SELECT * FROM users WHERE user_id = ?;
    `;
    return await db.get(sql, user_id);
}
async function getPreferences(user_id) {
    let sql = `
        SELECT * FROM user_preferences WHERE user_id = ?;
    `;
    return await db.get(sql, user_id);
}
module.exports = {
    createUser,
    deleteUser,
    updateUser,
    getUser,
    updatePreferences,
    getPreferences,
    createPreferences
}