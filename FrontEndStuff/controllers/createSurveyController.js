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
    db.query("CALL AddSurvey(?, ?, ?, ?)", [customerID, newSurveyTitle, newSurveyDescription, 0], function (err, result) {
        if(err) throw err;
        else {
            // surveyNames.push(newSurveyTitle); //with new object array this won't work
            surveyDescriptions.push(newSurveyDescription);
            addingToSurvey = newSurveyTitle;
            db.query("CALL GetSurveyCustomerByID(?)", [customerID], function(err, result){
                if(err) throw err;
                else {
                    let index = surveyNames.length;
                    // console.log(result[0][index]); //grabs current survey info (need the survey_ID for object array)
                    surveyNames.push({
                        surveyName: newSurveyTitle,
                        surveyCode: result[0][index].survey_ID
                    });
                    res.redirect("/addQuestions");
                }
            });
        }
    });
}

module.exports = {
    create_page,
    create_new
}