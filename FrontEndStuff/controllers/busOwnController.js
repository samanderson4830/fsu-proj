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
                        console.log(question.question_string);//testing if loops prints all question strings
                        analyticsSurveyQuestions.push(question.question_string);
                    });
                    //forEach loop throwing all questionIDs in an array (analyticsQuestionIDs)
                    analyticsSurveyQuestions.forEach(function(questionString, index) {
                        db.query("CALL GetQuestionID(?)", [questionString], function(err, result) {
                            if(err) throw err;
                            else {
                                analyticsQuestionIDs.push(result[0][0].question_ID);
                                db.query("CALL GetAnswersByQuestionID(?)", [analyticsQuestionIDs[index]], function(err, result) {
                                        if(err) throw err;
                                        else {
                                            //console.log(result[0]); //testing answer info that comes through
                                            // console.log(analyticsQuestionIDs.indexOf(3));
                                            result[0].forEach(function(answers, index1){
                                                analyticsObject = {}; //declaring new object
                                                analyticsObject.aString = answers.answer_string;
                                                analyticsObject.qID = answers.question_ID;
                                                analyticsObject.sID = analyticsSurveyID;
                                                analyticsObject.qString = analyticsSurveyQuestions[analyticsQuestionIDs.indexOf(answers.question_ID)];
                                                db.query("CALL GetPrecent(?,?,?)", [analyticsObject.aString, analyticsObject.qString, analyticsObject.sID],
                                                 function (err, result) {
                                                     if(err) throw err;
                                                     else {
                                                         //console.log(result[0]);
                                                         if (result[0][0].thePrecent === null) {
                                                             analyticsObject.aPercent = 0;
                                                         }
                                                         else {
                                                             analyticsObject.aPercent = result[0][0].thePrecent;
                                                         }
                                                        //console.log("Index: " + index);
                                                        //console.log("result[0].length: " + result[0].length);
                                                        analyticsAnswers.push(analyticsObject);
                                                        //console.log("object array: " + analyticsAnswers.length);
                                                        if (index === analyticsSurveyQuestions.length - 1 && index1 === result[0].length) {
                                                            //console.log("MAIN INDEX: " + index);
                                                            //console.log("object array: " + analyticsAnswers.length);
                                                            res.redirect('/analytics');
                                                        }
                                                        else {}
                                                     }
                                                 });
                                            });
                                        }
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
