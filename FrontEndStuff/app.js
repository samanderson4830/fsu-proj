const express = require('express');
const morgan = require('morgan');

const regRoutes = require('./routes/registrationRoutes');
const loginRoutes = require('./routes/loginRoutes');
const busRoutes = require('./routes/busRoutes');
const createSurveyRoutes = require('./routes/createSurveyRoutes');


//express app

const app = express();

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
//app.use(express.urlencoded({extended:true})); // Used for sending chunk of data to database, used with the form data.

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
app.use('/createSurvey', createSurveyRoutes);

app.get('/TakeSurvey', (req, res) =>{
    res.render('TakeSurvey');
})

//Redirect if no matches with above -> will show 404 error page
app.use((req, res) => {
    res.status(404).render('404');
})

//***********End of redirects*********************/