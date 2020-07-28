//const Customer = require("../models/customer");
const mysql = require('mysql');
const db = require('../models/db_connection');
const { render } = require('ejs');

const bus_own_page = (req,res) => {
    res.render('businessOwnerLogin');
}

const bus_own_analytics = function(req,res) {
    //testing to see if variable for surveyID was passed correctly from busOwn script
    // console.log(req.body.survey);
    analyticsSurveyID = req.body.survey;
    db.query("CALL GetSurveyByID(?)", [analyticsSurveyID], function(err, result) {
        if (err) throw err;
        else {
            console.log(result[0]); 
        }
    });
}

module.exports = {
    bus_own_page,
    bus_own_analytics
}