"use strict";

const express = require("express");
const app = express();
const multer = require("multer");
app.use(multer().none());
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
const model = require("../models/registrationmodel");

async function createUser(req, res, next) {
    let { user_id, fname, lname, username, email, fit_goal, exp_level } = req.body;
    user_id = parseInt(user_id, 10);

    console.log("Received parameters:", { user_id, fname, lname, username, email, fit_goal, exp_level });
    if (isNaN(user_id)) {
        console.error("user_id is not a number:", req.body.user_id);
        return res.status(400).send({ error: "User ID must be a number" });
    }
    if (user_id && fname && lname && username && email && fit_goal && exp_level) {
        let params = [user_id, fname, lname, username, email, fit_goal, exp_level, new Date().toISOString()];
        console.log("Params for DB:", params);
        try {
            await model.createUser(params);
            res.status(201).send({ message: "User created successfully" });
        } catch (err) {
            console.error("Error while creating a new user, talk to Will", err.message);
            res.status(500).send({ error: "Failed to create user" });
            next(err);
        }
    } else {
        res.status(400).send({ error: "Missing required fields" });
    }
}
module.exports = {
    createUser
}