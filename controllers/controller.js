"use strict";

const express = require("express");
const app = express();
const multer = require("multer");
app.use(multer().none());
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
const model = require("../models/model");

async function getAllUsers(req, res, next) {
    try {
        let users = await model.getAllUsers(); // Await the promise
        res.render("users-all", { users: users, title: 'All Users', user: req.user });
    } catch (error) {
        next(error);
    }
}
function recommendWorkouts(userPreferences, workouts) {
    return workouts.filter(workout => {
        const matchesType = workout.type.includes(userPreferences.fit_goal);
        const matchesLevel = workout.intensity === userPreferences.exp_level;
        const matchesDuration = !userPreferences.preferred_duration || workout.duration === userPreferences.preferred_duration;

        // Need to actually recommend an exercise
        const matchesExercise = !userPreferences.preferred_exercise || workout.exercise_name === userPreferences.preferred_exercise;
        
        // Need to consider users injury status
        // Need to consider users exercise history and trends, what burns most cals for them, ratings, etc.
        // DB column that can be incremented to show how many times a user does a workout? And then prioritizes
        // -> workouts that are done often
        // Decision trees?

        // return matchesType && matchesLevel;
        return matchesType && matchesLevel && matchesDuration && matchesExercise;
        // Now populate user_preferences table w relevant data
    });
}
async function getRecommendedWorkouts(req, res, next) {
    try {
        const userId = parseInt(req.query.user_id, 10);
        if (isNaN(userId)) {
            throw new Error('Invalid User ID');
        }
        const userPreferences = await model.getUserPreferences(userId); // Await the promise
        if (!userPreferences) {
            throw new Error('No preferences found for user.');
        }
        // const workouts = await model.getWorkouts(); // Await the promise
        const workouts = await model.getWorkouts(userId); // Await the promise
        const recommendedWorkouts = recommendWorkouts(userPreferences, workouts);

        res.render("recommended-workouts", {
            workouts: recommendedWorkouts,
            title: 'Recommended Workouts',
            user: { user_id: userId }
        });
    } catch (error) {
        next(error);
    }
}


// added
async function submitFeedback(req, res, next) {
    try {
        const { userId, workoutId, rating, caloriesBurned } = req.body;
        await model.storeUserFeedback(userId, workoutId, rating, caloriesBurned);
        res.send({ success: true });
    } catch (error) {
        next(error);
    }
}
module.exports = {
    getAllUsers,
    recommendWorkouts,
    getRecommendedWorkouts,
    submitFeedback
};
