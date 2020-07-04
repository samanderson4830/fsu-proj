const startButton = document.getElementById('start-btn');
const questionContainerElement = document.getElementById('question-container')
const questionElement = document.getElementById('question')
const answerButtonsElement = document.getElementById('answer-buttons')
const nextButton = document.getElementById('next-btn')
const thankButton = document.getElementById('thank-btn');

let currentQuestionIndex

startButton.addEventListener('click',startSurvey)
nextButton.addEventListener('click', () => {
    currentQuestionIndex++
    setNextQuestion()
})

function startSurvey() {
    console.log('Started')
    startButton.classList.add('hide')
    currentQuestionIndex = 0
    questionContainerElement.classList.remove('hide')
    setNextQuestion()

}

function setNextQuestion(){
    resetState()
    showQuestion(questions[currentQuestionIndex])
    
}

function showQuestion(question){
    questionElement.innerText = question.question
    question.answers.forEach(answer => {
        const button = document.createElement('button')
        button.innerText = answer.text
        button.classList.add('btn')
        //button.dataset = answer
        button.addEventListener('click',selectAnswer)
        answerButtonsElement.appendChild(button)
    });
}

function resetState(){
    nextButton.classList.add('hide')
    while(answerButtonsElement.firstChild){
        answerButtonsElement.removeChild
        (answerButtonsElement.firstChild)
    }
}

function selectAnswer(e){
    const selectedButton = e.target
    //const sendData =
    // Array.from(answerButtonsElement.children).forEach(button=>{
        
    // })
    if(questions.length > currentQuestionIndex+1){
    nextButton.classList.remove('hide')
    }
    else{
        // startButton.innerText = 'Thank You!'
        thankButton.classList.remove('hide')
        
    }
}

const questions = [
    {
        question: 'Is this cool?',
        answers: [
            {text: 'Yes'},
            {text: 'No'}
        ]
    },
    {
        question: 'Would you tell your friends this is cool?',
        answers: [
            {text: 'No'},
            {text: 'Nope'},
            {text: 'Ok, kinda'},
            {text: 'Duh, yes'}
        ]
    }
]
