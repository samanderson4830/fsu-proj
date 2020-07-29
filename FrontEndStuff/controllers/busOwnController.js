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
            // console.log(result[0][0]); //testing result, which should be survey info
            analyticsSurveyName = result[0][0].survey_name;
            
            db.query("CALL GetSurveyQuestions(?)", [analyticsSurveyID], function(err, result) {
                if(err) throw err;
                else {
                    analyticsSurveyQuestions = [];
                    //forEach loop throwing all the question strings into an array (analyticsSurveyQuestions)
                    result[0].forEach(function(question) {
                        // console.log(question.question_string);//testing if loops prints all question strings
                        analyticsSurveyQuestions.push(question.question_string);
                    });
                    //forEach loop throwing all questionIDs in an array (analyticsQuestionIDs)
                    analyticsSurveyQuestions.forEach(function(questionString) {
                        db.query("CALL GetQuestionID(?)", [questionString], function(err, result) {
                            if(err) throw err;
                            else {
                                analyticsQuestionIDs = [];
                                result[0].forEach(function(ids){
                                    // console.log(ids.question_ID); //testing if loop prints out all questionIDs
                                    analyticsQuestionIDs.push(ids.question_ID);
                                });
                                analyticsQuestionIDs.forEach(function (qID) {
                                    db.query("CALL GetAnswersByQuestionID(?)", [qID], function(err, result) {
                                        if(err) throw err;
                                        else {
                                            // analyticsObject = {}; //declaring new object
                                            result[0].forEach(function(answers){
                                                console.log(answers.answer_string); //declaring new object
                                            });
                                        }
                                    });
                                });

                            }
                        });
                    });
                }
            }); 
        }
    });
}

module.exports = {
    bus_own_page,
    bus_own_analytics
}