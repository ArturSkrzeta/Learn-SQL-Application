const mongoose = require('mongoose');

const QuestionSchema = mongoose.Schema({
  quest_num: Number,
  quest: String,
  answer: String,
});

module.exports = mongoose.model('Questions', QuestionSchema);
