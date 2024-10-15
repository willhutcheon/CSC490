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
        let users = await model.getAllUsers();
        res.render("users-all", { users: users, title: 'All Users', user: req.user });
    } catch (error) {
        next(error);
    }
}
// content based filtering
/* function recommendWorkouts(userPreferences, workouts) {
    return workouts.filter(workout => {
        const matchesType = workout.type.includes(userPreferences.fit_goal);
        const matchesLevel = workout.intensity === userPreferences.exp_level;
        const matchesDuration = !userPreferences.preferred_duration || workout.duration === userPreferences.preferred_duration;

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
} */
async function getRecommendedWorkouts(req, res, next) {
    try {
        const userId = parseInt(req.query.user_id, 10);
        if (isNaN(userId)) {
            throw new Error('Invalid User ID');
        }
        const userPreferences = await model.getUserPreferences(userId);
        if (!userPreferences) {
            throw new Error('No preferences found for user.');
        }
        // const workouts = await model.getWorkouts();
        const workouts = await model.getWorkouts(userId);
        if (!workouts || workouts.length === 0) {
            throw new Error('No workouts available.');
        }
        // const recommendedWorkouts = recommendWorkouts(userPreferences, workouts);
        const recommendedWorkout = await model.recommendWorkoutsWithRL(userPreferences, workouts, userId);
        res.render("recommended-workouts", {
            // workouts: recommendedWorkouts,
            workouts: [recommendedWorkout],
            title: 'Recommended Workouts',
            user: { user_id: userId }
        });
    } catch (error) {
        next(error);
    }
}
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
    // recommendWorkouts,
    getRecommendedWorkouts,
    submitFeedback
}


// todo: allow users to crud accounts, progress tracking, injuries / injury status and accomidations, goals and goal tracking

// db notes
// similar exercises should have the same workout_id in the exercises table ie legs should all have workout_id 2
// match types and intensities in the workouts table with the correct corresponding workout_id value in exercises table ie bench press workout_id values in exercises should be correlated to type strength in the workouts table
// exercise_id's can / must be different as they are different exercises