const mysql = require('mysql');
const db = require('../models/db_connection');
const { render } = require('ejs');

//CONTROLLERS
const create_page = function (req, res) {
    res.render("createSurvey");
}

const create_new = function (req, res) {
    newSurveyTitle = req.body.surveyTitle;
    newSurveyDescription = req.body.surveyDescription;
    db.query("CALL AddSurvey(?, ?, ?)", [customerID, newSurveyTitle, newSurveyDescription], function (err, result) {
        if(err) throw err;
        else {
            surveyNames.push(newSurveyTitle);
            surveyDescriptions.push(newSurveyDescription);
            addingToSurvey = newSurveyTitle;
            res.redirect("/addQuestions");
        }
    });
}

module.exports = {
    create_page,
    create_new
}