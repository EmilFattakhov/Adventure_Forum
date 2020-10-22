import React, { useState, useEffect } from 'react'
import QuestionDetails from './QuestionDetails';
import AnswerDetailsList from './AnswerDetailsList';
import { Question } from '../requests';

export default function QuestionPage(props) {
  const [question, setQuestion] = useState({});

  useEffect(() => {
    Question.show(props.match.params.id)
      .then(question => {
        setQuestion(() => {
          return question
        })
      })
  }, [])

  function deleteAnswer(id) {
    setQuestion((state) => {
      const questionCopy = JSON.parse(JSON.stringify(state));
      const newAnswers = questionCopy.answers.filter((currentAnswer) => {
        return currentAnswer.id !== id;
      })
      questionCopy.answers = newAnswers;
      return questionCopy
    })
  }

  return(
    <main id='question-show-page'>
      <QuestionDetails question={question}></QuestionDetails>
      <h2>Answer Details</h2>
      <AnswerDetailsList answers={question.answers} handleDeleteAnswer={deleteAnswer}/>
    </main>
  );
}
