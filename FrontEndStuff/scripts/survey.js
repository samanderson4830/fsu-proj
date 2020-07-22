
const startButton = document.getElementById('start-btn');
const questionContainerElement = document.getElementById('question-container')
const questionElement = document.getElementById('question')
const answerButtonsElement = document.getElementById('answer-buttons')
const nextButton = document.getElementById('next-btn')
const thankButton = document.getElementById('thank-btn');
var totalQuestions
let currentQuestionIndex, questionArray, currentAnswerArray
var tempAnsArray, submitAnswersArray = [];

//*********************************************************************************** */
const db_totalQuestions = new XMLHttpRequest();
db_totalQuestions.open('GET', 'http://localhost:3000/TakeSurvey/offset');

db_totalQuestions.onload = function(){
    //console.log('GetRequestTest');
    //console.log(db_totalQuestions.responseText);
    totalQuestions = parseInt(db_totalQuestions.responseText);
    //console.log("Worked....");
};
db_totalQuestions.send();

//*********************************************************************************** */

//*********************************************************************************** */
const dbRequest = new XMLHttpRequest();
dbRequest.open('GET', 'http://localhost:3000/TakeSurvey/questions');

dbRequest.onload = function(){
   // console.log('GetRequestTest');
   // console.log(dbRequest.responseText);
    questionArray = JSON.parse(dbRequest.responseText);
    //console.log(questionArray[0].question_string);
};
dbRequest.send();

//*********************************************************************************** */

//*********************************************************************************** */
const dbAnswer = new XMLHttpRequest();
dbAnswer.open('GET', 'http://localhost:3000/TakeSurvey/answers');

dbAnswer.onload = function(){
    //console.log('GetRequestTest');
    //console.log(dbAnswer.responseText);
    currentAnswerArray = JSON.parse(dbAnswer.responseText);
    //console.log(currentAnswerArray[0].answer_string);
};
dbAnswer.send();

//*********************************************************************************** */



startButton.addEventListener('click',startSurvey)
nextButton.addEventListener('click', () => {
    currentQuestionIndex++
    setNextQuestion()
})

function startSurvey() {
    console.log('Started')
    //
    //Put database request here
    //
    startButton.classList.add('hide')
    currentQuestionIndex = 0
    submitAnswersArray, tempAnsArray = [];
    questionContainerElement.classList.remove('hide')
    setNextQuestion()

}

function setNextQuestion(){
    resetState()
    showQuestion(questionArray[currentQuestionIndex])
    //*********************************************************************************** */
    const dbAnswer = new XMLHttpRequest();
    dbAnswer.open('GET', 'http://localhost:3000/TakeSurvey/answers');

    dbAnswer.onload = function(){
        //console.log('GetRequestTest');
       // console.log(dbAnswer.responseText);
        currentAnswerArray = JSON.parse(dbAnswer.responseText);
        //console.log(currentAnswerArray[0].answer_string);
    };
    dbAnswer.send();

    //*********************************************************************************** */
    
}

function showQuestion(question){
    questionElement.innerText = question.question_string
    var i = 0;
    currentAnswerArray.forEach(answer_string => { //change "answers" to whatever the json string as... could be "answer_string"
        const button = document.createElement('button')
        button.innerText = currentAnswerArray[i].answer_string
        button.classList.add('btn')
        //button.dataset = answer
        button.addEventListener('click',selectAnswer)
        answerButtonsElement.appendChild(button)
        i++;
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
    addToArray(selectedButton)
    //const sendData =
    // Array.from(answerButtonsElement.children).forEach(button=>{
        
    // })
    if(questionArray.length > currentQuestionIndex+1){
    nextButton.classList.remove('hide')
    }
    else{
        // startButton.innerText = 'Thank You!'
        thankButton.classList.remove('hide')
        //http request to send array of answers out to database
        var i;
        for(i = 0; i < tempAnsArray.length; i++)
        {submitAnswersArray.push(tempAnsArray[i].innerText)}
        console.log(submitAnswersArray);
        var myJson = JSON.stringify(submitAnswersArray);
//***************************************************************** */
        const dbSendResult = new XMLHttpRequest();
        dbSendResult.open('POST', 'http://localhost:3000/TakeSurvey/sendResult', true);
        dbSendResult.setRequestHeader('Content-type', 'application/json');
        dbSendResult.onload = function () {
            var test = JSON.parse(dbSendResult.responseText);
            if (dbSendResult.readyState == 4 && dbSendResult.status == "201") {
                console.table(test);
            } else {
                console.error(test);
            }
        }
        dbSendResult.send(myJson);

//***************************************************************** */
        
    }
}

function addToArray(choice){
    tempAnsArray.push(choice);
}
