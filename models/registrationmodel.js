"use strict";
const db = require("../models/db-conn");

async function createUser(params) {
    let sql = `
        INSERT INTO users (user_id, fname, lname, username, email, fit_goal, exp_level, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?);
    `;
    return await db.run(sql, params);
}
module.exports = {
    createUser
}