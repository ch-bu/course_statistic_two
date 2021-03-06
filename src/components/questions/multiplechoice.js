import React from "react"
import styled from 'styled-components'
import Swal from 'sweetalert2'
import Button from '../button'
import { StaticQuery, graphql } from "gatsby"
import Confetti from 'react-dom-confetti';

const Quiz = styled.div`
  width: 100%;
  margin: 4rem 0;

  p {
    font-weight: bold;
    margin-bottom: 10px;
  }

  @media only screen and (min-width: ${props => props.theme.breakpointOne}) {
    font-size: 1.1rem;
  }

  ul {
    list-style: none;
    margin: 0;
    padding: 10px;
    border: 1px solid #e6e6e6;
    margin-bottom: 15px;
  }
  
  li {
    /* padding: 0.8rem; */
    border-radius: 5px;
  }
`

const Label = styled.label`
  display: block;
  position: relative;
  padding-left: 35px;
  margin-bottom: 12px;
  padding: 10px 10px 10px 50px;
  cursor: pointer;
  font-size: 0.9rem;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;

  input {
    position: absolute;
    opacity: 0;
    cursor: pointer;
  }

  @media only screen and (min-width: ${props => props.theme.breakpointOne}) {
    font-size: 1.1rem;
  }
`

const Checkmark = styled.span`
  position: absolute;
  top: 13px;
  left: 5px;
  height: 25px;
  width: 25px;
  background-color: #eee;
  
  &:hover {
    background-color: #ccc;
  }

  &:checked {
    background-color: #ffefa2;
  }

  /* &:after {
    content: "";
    position: absolute;
    display: none;
    top: 9px;
    left: 9px;
    width: 8px;
    height: 8px;
    background: white;
  } */

  &::after {
    left: 9px;
    top: 9px;
    width: 8px;
    height: 8px;
    border: solid blue;
    border-width: 0 3px 3px 0;
    -webkit-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    transform: rotate(45deg);
  }
`

const Input = styled.input`
  position: absolute;
  cursor: pointer;

  &:checked ~ .checkmark {
    background-color: ${props => props.theme.primaryColor};
    /* border: 1px solid ${props => props.theme.darkColorLight}; */
    box-shadow: 5px 4px 25px 0 rgba(46,61,73,.4);
  }
`

const Answer = styled.div`
  margin-top: 15px;
  width: 100%;
  min-height: 100px;
  padding: 15px;
  border-radius: 5px;
  background-color: ${props => props.answerCorrect ? "#c7efc7" : "#ecbaba"};
  box-shadow: 5px 4px 25px 0 rgba(46,61,73,.4);
`;

class MultipleChoiceComponent extends React.Component {
  constructor(props) {
    super(props);

    this.questions = this.props.data.allMultiplechoiceYaml.edges;

    this.question = this.questions.filter((question) => {
      return question.node.question === this.props.question;
    })[0].node;

    // Shuffle answers
    this.shuffleAnswers(this.question.answers);
    
    var answers = {};
    var correctAnswers = {};
    for (let answer = 0; answer < this.question.answers.length; answer++) {
      answers[this.question.answers[answer].answer] = false;
      correctAnswers[this.question.answers[answer].answer] = this.question.answers[answer].correct;
    }

    this.confettiConfig = {
      angle: 90,
      spread: 45,
      startVelocity: 45,
      elementCount: 50,
      dragFriction: 0.1,
      duration: 3000,
      delay: 0,
      width: "10px",
      height: "10px",
      colors: ["#a864fd", "#29cdff", "#78ff44", "#ff718d", "#fdff6a"]
    };

    this.state = {
      size: "-1",
      answers: answers,
      correctAnswers: correctAnswers,
      showConfetti: false,
      answerCorrect: null,
      hint: "",
      buttonClicked: false
    };

    this.getAnswer = this.getAnswer.bind(this);
    this.updateChecked = this.updateChecked.bind(this);
    this.shuffleAnswers = this.shuffleAnswers.bind(this);
  }

  render() {

    let answer = "";
    if (this.state.buttonClicked) {
      if (this.state.answerCorrect) {
        answer = <Answer answerCorrect={true}>{"Well done!"}</Answer>;
      } else {
        answer = <Answer answerCorrect={false}>{this.state.hint}</Answer>;
      }
    }

    return (
      <Quiz key={this.question.name}>
        <p>{this.question.question}</p>
        <ul>
          {this.question.answers.map((item, i) => {
            return <li key={i} >
              <Label className="mc">{item.answer}
                <Input type="checkbox"
                       name={item.answer}
                       onClick={this.updateChecked} />
                <Confetti active={ this.state.showConfetti } config={ this.config }/>
                <Checkmark className="checkmark"></Checkmark>
              </Label>
            </li>;
          })}
        </ul>
        <Button onClick={this.getAnswer}>Submit Answer</Button>
        {answer}
      </Quiz>
    ); 
  }

  shuffleAnswers(array) {
    var currentIndex = array.length, temporaryValue, randomIndex;

    // While there remain elements to shuffle...
    while (0 !== currentIndex) {
  
      // Pick a remaining element...
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex -= 1;
  
      // And swap it with the current element.
      temporaryValue = array[currentIndex];
      array[currentIndex] = array[randomIndex];
      array[randomIndex] = temporaryValue;
    }
  
    return array;
  }

  getAnswer() {

    var equal = true;

    Object.entries(this.state.answers).forEach(
      ([key, value]) => value === this.state.correctAnswers[key] ? "" : equal = false
    );

    this.setState({
      buttonClicked: true
    });

    if (equal) {
      this.setState({
        showConfetti: true,
        answerCorrect: true
      }, () => {
        setTimeout(() => {
          this.setState({showConfetti: false})
        }, 1000);
      });
    } else {
      this.setState({
        answerCorrect: false,
        hint: this.question.hint
      });
    }
  }

  updateChecked(event) {
    var updatedAnswers = this.state.answers;
    updatedAnswers[event.target.name] = event.target.checked

    this.setState({
      answers: updatedAnswers,
      buttonClicked: false
    });
  }
}


export default props => (
  <StaticQuery
    query={graphql`
      query {
        allMultiplechoiceYaml {
          edges {
            node {
              id
              question
              hint
              answers {
                answer
                correct
              }
            }
          }
        }
      }
    `}
    render={data => <MultipleChoiceComponent data={data} {...props} />}
  />
)