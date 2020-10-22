import React, { Component } from 'react';
import QuestionDetails from './QuestionDetails';
import AnswerDetailsList from './AnswerDetailsList';
import { Question } from '../requests';

class QuestionPage extends Component {
  constructor(props) {
    super(props); // in all React Class components you must always call the `super(props)` within the constructor
    this.state = {
      question: {}
    }
    this.deleteAnswer = this.deleteAnswer.bind(this) // if you pass down a function that needs access to `this` then you should .bind(this) within the constructor
  }

  componentDidMount() {
    Question.show(this.props.match.params.id)
      .then(question => {
        console.log(question);
        this.setState(() => {
          return {
            question: question
          }
        })
      })
  }

  deleteAnswer(id) { // this id will be the id of the question that should be deleted
    this.setState((currentState) => {
      const questionCopy = JSON.parse(JSON.stringify(currentState.question));
      const newAnswers = questionCopy.answers.filter((currentAnswer) => {
        return currentAnswer.id !== id;
      })
      questionCopy.answers = newAnswers
      return {
        question: questionCopy
      }
    })
  }

  render() {
    return(
      <main id='question-show-page'>
        <QuestionDetails question={this.state.question}></QuestionDetails>
        <h2>Answer Details</h2>
        <AnswerDetailsList answers={this.state.question.answers} handleDeleteAnswer={this.deleteAnswer}/>
      </main>
    )
  }
}

export default QuestionPage