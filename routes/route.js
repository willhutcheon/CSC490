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
router.get('/users/update/:user_id', registrationController.getUser);
router.post('/users/update', registrationController.updateUser);
router.get('/preferences/update/:user_id', registrationController.getPreferences);
router.post('/preferences/update', registrationController.updatePreferences);
router.get('/preferences/create', (req, res) => {
    res.render('create-preferences', { error: null, message: null });
});
router.post('/preferences/create', registrationController.createPreferences);
module.exports = router;

// http://localhost:3000/recommendations?user_id=3601
// http://localhost:3000/users/create
// http://localhost:3000/users/update/2624
// http://localhost:3000/preferences/create
// http://localhost:3000/preferences/update/2710


// todo: allow users to crud accounts, progress tracking, injuries / injury status and accomidations, goals and goal tracking
// todo: allow users to crud workouts, exercises, and preferences
// todo: consider injury status in RL
// todo: auto increment user_preferences preference_id when creating new user preferences?

// db notes
// similar exercises should have the same workout_id in the exercises table ie legs should all have workout_id 2
// match types and intensities in the workouts table with the correct corresponding workout_id value in exercises table ie bench press workout_id values in exercises should be correlated to type strength in the workouts table
// exercise_id's can / must be different as they are different exercises
// need injuries table, might just need injuries column in user_preferences instead