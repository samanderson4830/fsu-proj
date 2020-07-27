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
    let passwordInput = req.body.code;

    console.log(req.body.email);
    console.log(req.body.code);

    db.query("CALL Login(?, ?)", [emailInput, passwordInput], function (err, result){
        if (err) throw err;
        else {
            // console.log(result[0][0].isValidLogin); //test result of valid login variable spit out by procedure
            validLogin = result[0][0].isValidLogin;
            if (validLogin === 1) {
                // Calling the GetCustomersByEmail procedure from the Database and passing in emailInput 
                db.query("CALL GetCustomersByEmail(?)", [emailInput], function(err, result){
                    if(err) throw err;
                    else {
                        //console.log(result[0]); //test result (see if company data is correct)
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
                                console.log(result[0]); //test result (see what surveys are spit out)
                                result[0].forEach(function(survey){
                                    //adding an object that stores survey's name and id
                                    surveyNames.push({
                                        surveyName: survey.survey_name,
                                        surveyCode: survey.survey_ID
                                    });
                                    surveyDescriptions.push(survey.quick_description);
                                });
                                // surveyNames.forEach(function(survey) { //test that object is added and accessed correctly
                                //     console.log(survey.surveyName);
                                //     console.log(survey.surveyCode);
                                // }); 
                            }
                        });
                        //After post request we redirect to businessOWnerLogin where variables are used on template
                        res.redirect("/busOwn");
                    }
                });
            }
            else {
                res.redirect('/Login');
            }
        }
    });
};

module.exports = {
    login_new,
    login_page
}