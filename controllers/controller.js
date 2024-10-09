"use strict";

const express = require("express");
const app = express();
const multer = require("multer");
app.use(multer().none());
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
const model = require("../models/model");

function getAllUsers(req, res, next) {
    //req.session.returnTo = req.originalUrl;
    let users = model.getAllUsers();
    res.render("users-all", { users: users, title: 'All Users', user: req.user});
}
module.exports = {
    getAllUsers,
};