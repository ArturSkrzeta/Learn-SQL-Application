import React, { Component } from 'react';
import './App.css';
import { Header } from './components/Header'
import { Question } from './components/Question'
import { Button } from './components/Button'
import { getAllQuestions } from './services/AppService'

class App extends Component {

  state = {
    questions: []
  }

  getAllQuestions = () => {
    getAllQuestions()
    .then(questions => {
      // console.log(questions) //response from nodeJS
      this.setState({questions: questions}) // updating state according to what we get form nodeJS
    });
  };

  render() {

    return (
      <div className="App">
        <Header></Header>
        <div className="app_container">

          <div className="app_container_up">
            <Question questions={this.state.questions}></Question>
          </div>
          <div className="app_container_down">
            <Button getAllQuestions={this.getAllQuestions}></Button>
          </div>
        </div>
      </div>
    );
  }
}

export default App;
