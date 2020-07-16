const mysql = require('mysql');
const db = require('../models/db_connection');
const { render } = require('ejs');
//const Customer = require('../models/customer');
//const Customer = require("../models/customer");

const login_page = (req,res) => {
    res.render('login');
}

const login_new = function(req, res) {
    // Grabbing email from input tag and storing into emailInput variable
    let emailInput = req.body.email;
    // Calling the GetCustomersByEmail procedure from the Database and passing in emailInput 
    db.query("CALL GetCustomersByEmail(?)", [emailInput], function(err, result){
        if(err) throw err;
        else {
            // console.log(result[0]); test result
            //these three variable are defined globally in app.js and then defined with data grabbed from results
            companyName = result[0][0].company_name.toString();
            fullName = result[0][0].first_name + " " + result[0][0].last_name;
            customerID = result[0][0].customer_ID;

            //Calling the GetSurveyCustomerByID procedure from the Database and passing in customerID
            db.query("CALL GetSurveyCustomerByID(?)", [customerID], function(err, result){
                if(err) throw err;
                else {
                    //Creating an empty array to push whatever amount of surveys account has
                    surveyDescriptions = [];
                    surveyNames = [];
                    result[0].forEach(function(survey){
                        surveyNames.push(survey.survey_name);
                        surveyDescriptions.push(survey.quick_description);
                    }); 
                }
            });
            //After post request we redirect to businessOWnerLogin where variables are used on template
            res.redirect("/busOwn");
        }
    });
};

// const login_new = (req, res) => {
   
//     Customer.findOne({ email: req.query['email']}, function(err, result){
//         if(result == null) {
//             res.redirect('/Login');
//             //Need to popup "This email was not found" message hear
//         } else {
//             res.redirect('/busOwn');
//         }
//     });
   
// }

module.exports = {
    login_new,
    login_page
}