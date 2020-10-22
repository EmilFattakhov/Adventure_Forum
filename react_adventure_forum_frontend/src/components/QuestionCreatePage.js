import React, { useState } from 'react';
import NewQuestionForm from './NewQuestionForm';
import { Question } from '../requests';

function QuestionCreatePage(props) {
  // useState allows us to add state to a functional component
  // the function accepts the default state as an argument and returns an array with 2 values. The first value within the array is the state (getter). The second value within the array is a function to update the state (setter).
  const [newQuestionParams, setNewQuestionParams] = useState({
    title: '',
    body: ''
  });
  const [errors, setErrors] = useState({});

  function updateQuestionParams(params) {
    setNewQuestionParams((state) => {
      console.log(params);
      console.log(state);
      const newQuestionparamsCopy = {...state};
      return {
        ...newQuestionparamsCopy,
        ...params
      }
    })
  }

  function createQuestion() {
    Question.create(newQuestionParams)
      .then(res => {
        if(res.id) {
          props.history.push(`/questions/${res.id}`)
        }
        if (res.errors) {
          setErrors(() => {
            return {
              errors: res.errors
            }
          })
        }
      });
  }

  return(
    <main id='question-create-page'>
      {
        Object.keys(errors).map(key => {
          return(
          <div>{key} {errors[key].join(', ')}</div>
          )
        })
      }
      {/* we pass this.createQuestion to a child component because we want event's on a child component to trigger an update to state */}
      <NewQuestionForm
        handleSubmit={createQuestion}
        title={newQuestionParams.title}
        body={newQuestionParams.body}
        updateQuestionParams={updateQuestionParams}
      />
      {/* Remember! when you pass down a method as a function through props the `this` value within the, now, function will be the global scope! So we need to make sure we bind the method to force the `this` value to be QuestionCreatePage */}
    </main>
  )
}

export default QuestionCreatePage;
