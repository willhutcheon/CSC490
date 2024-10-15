"use strict";
const express = require("express");
const router = express.Router();
const controller = require("../controllers/controller");
const registrationController = require("../controllers/registrationcontroller");
router.get("/allusers", controller.getAllUsers);
router.get("/recommendations", controller.getRecommendedWorkouts);
router.post("/feedback", controller.submitFeedback);
router.get('/users/create', (req, res) => {
    res.render('create-user', { error: null, message: null });
});
router.post('/users/create', registrationController.createUser);
module.exports = router;

// http://localhost:3000/recommendations?user_id=3601