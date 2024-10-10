"use strict";
const express = require("express");
const router = express.Router();
const controller = require("../controllers/controller");
router.get("/allusers", controller.getAllUsers);
router.get("/recommendations", controller.getRecommendedWorkouts);
module.exports = router;

// http://localhost:3000/recommendations?user_id=3601