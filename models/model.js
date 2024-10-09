"use strict";
const db = require("../models/db-conn");
const path = require("path");

function getAllUsers() {
    let sql = "SELECT * FROM users;";
    const data = db.all(sql);
    return data;
};
module.exports = {
    getAllUsers,
};