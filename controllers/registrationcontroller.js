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
    // let user_id = req.body.user_id;
    // let fname = req.body.fname;
    // let lname = req.body.lname;
    // let username = req.body.username;
    // let email = req.body.email;
    // let fit_goal = req.body.fit_goal;
    // let exp_level = req.body.exp_level;
    if (user_id && fname && lname && username && email && fit_goal && exp_level) {
        let params = [user_id, fname, lname, username, email, fit_goal, exp_level];
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