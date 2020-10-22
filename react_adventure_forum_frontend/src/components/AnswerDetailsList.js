import React from 'react'
import AnswerDetails from './AnswerDetails';

function AnswerDetailsList(props) {
  return(
    <>
      { props.answers ? props.answers.map( (answer, i) => {
        return <AnswerDetails id={answer.id} key={i} body={answer.body} author={answer.author} createdAt={answer.createdAt} handleDeleteAnswer={props.handleDeleteAnswer}/>
      }) : null }
    </>
  )
}

export default AnswerDetailsList;
