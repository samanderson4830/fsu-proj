const express = require('express');
const morgan = require('morgan');

//express app

const app = express();

//register view engine
app.set('view engine', 'ejs');
app.set('views', 'engineViews');

//listen port requests
app.listen(3000);

//static files - CSS and Images
app.use(express.static('css'));
app.use(express.static('images'));

//log incoming request 
app.use(morgan('tiny'));
// app.use((req,res,next) => {
//     console.log();
//     next();
// });

//*********Redirects for the actual pages *************************/

app.get('/', (req, res) =>{
    //res.sendFile('./htmlPages/homePage.html', {root: __dirname});
    res.render('homePage');
})

app.get('/homePage', (req, res) =>{

    res.render('homePage');
})

app.get('/Login', (req, res) =>{
    res.render('login');
})

app.get('/registration', (req, res) =>{
    res.render('registration');
})

app.get('/TakeSurvey', (req, res) =>{
    res.render('TakeSurvey');
})

//Redirect if no matches with above -> will show 404 error page
app.use((req, res) => {
    res.status(404).render('404');
})

//***********End of redirects*********************/