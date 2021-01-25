import React from 'react'

export const Question = ({questions}) => {

  if (questions.length === 0) return null

  const questionsContent = questions.map((question) => {
    return (
      <div className="question" key={question._id}>
        <h2>{question.quest_num}.</h2>
        <p id={question.quest_num} onClick={() => document.getElementById(question.quest_num).innerHTML = question.quest}>
          Click to open the question.
        </p>
        <p id={question._id} onClick={() => document.getElementById(question._id).innerHTML = question.answer}>
          Click to check the answer for the question {question.quest_num}!
        </p>
      </div>
    )
  })

  return(
      <div className="question_container">
        {questionsContent}
      </div>
  )
}
