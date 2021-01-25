const express = require('express');
const router = express.Router();
const Question = require('../models/Question');

// getting all questions
router.get('/', async (req, res) => {
  try {
    // console.log("Fetching data from db...")
    const questions = await Question.find()
    res.json(questions)
  } catch(err) {
    res.json({message: err})
  }
});

// exporting router to main.js
module.exports = router;
