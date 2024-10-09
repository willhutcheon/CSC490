"use strict";
const express = require("express");
const router = express.Router();

const controller = require("../controllers/controller");
router.get("/allusers", controller.getAllUsers);
module.exports = router;