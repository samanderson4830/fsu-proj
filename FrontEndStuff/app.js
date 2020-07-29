const express = require('express');
const morgan = require('morgan');
const mysql = require('mysql');
const bodyParser = require('body-parser');

const regRoutes = require('./routes/registrationRoutes');
const loginRoutes = require('./routes/loginRoutes');
const busRoutes = require('./routes/busRoutes');
const createSurveyRoutes = require('./routes/createSurveyRoutes');
const takeSurveyRoutes = require('./routes/takeSurveyRoutes');
const addQuestionsRoutes = require('./routes/addQuestionsRoutes');
const analyticsRoutes = require('./routes/analyticsRoutes');

//express app
const app = express();

//create var object
var obj = {};
//created a few variables to be used in busOwn ejs file
var companyName;
var fullName;
var customerID;
var surveyDescriptions;
var surveyNames; //array with all of account survey titles
//creating variables for createSurvey ejs files
var newSurveyTitle;
var newSurveyDescription;
//creating variable for add Questions ejs file
var addingToSurvey;
var formatForQuestion;
var questionString;
var questionID;
var surveyID;
//variable to keep track of valid login
var validLogin = 0;
//variable for analytics
var analyticsSurveyID;
var analyticsSurveyName;
var analyticsQuestions;
var analyticsQuestionIDs;
var analyticsAnswers; //array of answer objects that'll have an aString property and an aPercent property
var analyticsObject;

//register view engine
app.set('view engine', 'ejs');
app.set('views', 'engineViews');

//listen port requests
app.listen(3000,()=>{
    console.log('Server Started on 3000');
});

//static files - CSS and Images
app.use(express.static('css'));
app.use(express.static('images'));
app.use(express.static('scripts'));
app.use(express.urlencoded({extended:true})); // Used for sending chunk of data to database, used with the form data.
app.use(bodyParser.json());


//log incoming request 
app.use(morgan('tiny'));


//*********Redirects for the actual pages *************************/

app.get('/', (req, res) =>{
    //res.sendFile('./htmlPages/homePage.html', {root: __dirname});
    res.render('homePage');
})

app.get('/homePage', (req, res) =>{

    res.render('homePage');
})

//login routes
app.use('/Login', loginRoutes);

//registration routes
app.use('/registration', regRoutes);

//business owner routes
app.use('/busOwn', busRoutes);

//analytics routes
app.use('/analytics', analyticsRoutes);

//create survey routes
app.use('/createSurvey', createSurveyRoutes);

//add questions routes
app.use('/addQuestions', addQuestionsRoutes);

//take survey routes
app.use('/TakeSurvey', takeSurveyRoutes);

//surveyPage routes

app.get('/survey', (req, res) =>{

    res.render('surveyPage');
})

//Redirect if no matches with above -> will show 404 error page
app.use((req, res) => {
    res.status(404).render('404');
})
