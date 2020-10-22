import React from 'react';

import './QuestionDetails.css';

export default function QuestionDetails(props) {
  const createdAt = new Date(props.question.created_at);
  return (
    <div className='container'>
      <h1> Hello from react</h1>
      <h2>{props.question.title}</h2>
      <p>
        {props.question.body}<br />
        <small>{ props.question.id ? props.question.author.full_name : ''}</small>
      </p>
      <p>
      <small>Seen {props.question.viewCount} times - Created at {createdAt.toString()}</small>
      </p>
    </div>
  )
}
