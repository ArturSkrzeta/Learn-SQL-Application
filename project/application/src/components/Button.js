import React from 'react'

export const Button = ({getAllQuestions}) => {

    return(
        <div className="question_container">
          <div className="btn">
            <button type="button" onClick={(e) => getAllQuestions()}>Get Questions</button>
          </div>
        </div>
    )
}
