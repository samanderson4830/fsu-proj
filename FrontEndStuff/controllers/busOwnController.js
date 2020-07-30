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
    analyticsAnswers = [];
    analyticsSurveyQuestions = [];
    analyticsQuestionIDs = [];
    console.log(analyticsSurveyID);
    db.query("CALL GetSurveyByID(?)", [analyticsSurveyID], function(err, result) {
        if (err) throw err;
        else {
            // console.log(result[0][0]); //testing result, which should be survey info
            analyticsSurveyName = result[0][0].survey_name;
            
            db.query("CALL GetSurveyQuestions(?)", [analyticsSurveyID], function(err, result) {
                if(err) throw err;
                else {
                    //forEach loop throwing all the question strings into an array (analyticsSurveyQuestions)
                    result[0].forEach(function(question) {
                        // console.log(question.question_string);//testing if loops prints all question strings
                        analyticsSurveyQuestions.push(question.question_string);
                    });
                    analyticsSurveyQuestions.forEach(function(question, index) {
                        db.query("CALL GetAnalytics(?)", [question], function(err, result) {
                            if(err) throw err;
                            else {
                                console.log("index: " + index);
                                result[0].forEach(function(answer){
                                    analyticsObject = {};
                                    analyticsObject.aString = answer.answer_string;
                                    analyticsObject.qString = question;
                                    console.log(answer.answer_string);
                                    console.log(question);
                                    analyticsAnswers.push(analyticsObject);
                                });
                                if (index === analyticsSurveyQuestions.length - 1) {
                                    console.log("Object Array Contains: ********************");
                                    analyticsAnswers.forEach(function(ans){
                                        console.log(ans.aString);
                                        console.log(ans.qString);
                                    });
                                    analyticsAnswers.forEach(function(ans, index) {
                                        db.query("CALL GetPrecent(?,?,?)",[ans.aString, ans.qString, analyticsSurveyID],
                                        function(err, result) {
                                            if(err) throw err;
                                            else {
                                                console.log("Individual percent call************ index:" + index);
                                                console.log(result[0][0].thePrecent);
                                                ans.aPercent = result[0][0].thePrecent;
                                                if(index === analyticsAnswers.length - 1){
                                                    console.log("NEW NEW NEW Object Array Contains: ********************")
                                                    analyticsAnswers.forEach(function(ans, index){
                                                        console.log("index: " + index);
                                                        console.log(ans.aString);
                                                        console.log(ans.qString);
                                                        console.log(ans.aPercent);
                                                    });
                                                    res.redirect('/analytics');
                                                }
                                                else {}
                                            }
                                        });
                                    });
                                }
                                else {}
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
