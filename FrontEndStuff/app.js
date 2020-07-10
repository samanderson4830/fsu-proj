const express = require('express');
const morgan = require('morgan');
const mysql = require('mysql');
const bodyParser = require('body-parser');


const regRoutes = require('./routes/registrationRoutes');
const loginRoutes = require('./routes/loginRoutes');
const busRoutes = require('./routes/busRoutes');
//const createSurveyRoutes = require('./routes/createSurveyRoutes');
const takeSurveyRoutes = require('./routes/takeSurveyRoutes');

// table routes for testing
const questionTable = require('./routes/QuestionTableRoute');
const answersTable = require('./routes/AnswerTableRoute');
const surveysCreatedTable = require('./routes/SurveysCreatedRoute');

//express app
const app = express();


var connection  = require('express-myconnection');
dbOptions = {
    host     : 'localhost',
    user     : 'root',
    password : 'Pass12345',
    database : 'BSA_Database'
}

//create var object
var obj = {};

//register view engine
app.set('view engine', 'ejs');
app.set('views', 'engineViews');


//static files - CSS and Images
app.use(express.static('css'));
app.use(express.static('images'));
app.use(express.static('scripts'));
app.use(express.urlencoded({extended:true})); // Used for sending chunk of data to database, used with the form data.
app.use(bodyParser.json());
app.use(connection(mysql, dbOptions, 'request'));

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

//create survey routes
//app.use('/createSurvey', createSurveyRoutes);

//take survey routes
app.use('/TakeSurvey', takeSurveyRoutes);


//testing tables routes
app.get('/questions', questionTable.list);
app.get('/answers', answersTable.list);
app.get('/surveysCreated', surveysCreatedTable.list);


//surveyPage routes
app.get('/survey', (req, res) =>{

    res.render('surveyPage');
})

//listen port requests
app.listen(3000,()=>{
    console.log('Server Started on 3000');
});

//Redirect if no matches with above -> will show 404 error page
app.use((req, res) => {
    res.status(404).render('404');
})


