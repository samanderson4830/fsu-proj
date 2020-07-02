const express = require('express');
const morgan = require('morgan');
const mysql = require('mysql');

const regRoutes = require('./routes/registrationRoutes');
const loginRoutes = require('./routes/loginRoutes');
const busRoutes = require('./routes/busRoutes');
const createSurveyRoutes = require('./routes/createSurveyRoutes');
const takeSurveyRoutes = require('./routes/takeSurveyRoutes');
const bodyParser = require('body-parser');




//create connetion
const db = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : 'Pass12345',
    database : 'BSA_Database'
});

// connect server to database
db.connect ((err) => {
    if(err)
    {
        throw err;
    } else
    {
        console.log('MySQL connected ...');
    }
});


//express app

const app = express();

//connect to mongoDB

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

//create survey routes
//app.use('/createSurvey', createSurveyRoutes);

app.get ('/getCustomers',(req, res) => {
    let sql = "call BSA_Database.GetSurveyQuestions('4')";
    
    db.query (sql, (err, result) => {
        if (err)
        {
            throw err;
        } else
        {
            console.log("Data found .....");
            res.send(result);
        }
    });
});

//take survey routes
app.use('/TakeSurvey', takeSurveyRoutes);

//Redirect if no matches with above -> will show 404 error page
app.use((req, res) => {
    res.status(404).render('404');
})

//***********End of redirects*********************/