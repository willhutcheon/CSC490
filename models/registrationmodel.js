"use strict";
const db = require("../models/db-conn");

async function createUser(params) {
    let sql = `
        INSERT INTO users (user_id, fname, lname, username, email, fit_goal, exp_level, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?);
    `;
    return await db.run(sql, params);
}
async function deleteUser(user_id) {
    let sql = `
        DELETE FROM users WHERE user_id = ?
    `;
    return await db.run(sql, [user_id]);
}
module.exports = {
    createUser,
    deleteUser
}