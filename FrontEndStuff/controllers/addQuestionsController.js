const mysql = require('mysql');
const db = require('../models/db_connection');
const { render } = require('ejs');

//helper function for add_question controller
//takes the format and question id to add correct type of answers
function formatQuestion(form, id) {
    //variables to promote D.R.Y. code
    let addAnswer = "CALL AddAnswer(?,?,?)";
    let callBack = function (err, result) {
        if (err) throw err;
        else {}
    };
    if (form === "AD") {
        db.query(addAnswer, [id, 1, "Strongly Agree"], callBack);
        db.query(addAnswer, [id, 2, "Agree"], callBack);
        db.query(addAnswer, [id, 3, "Disagree"], callBack);
        db.query(addAnswer, [id, 4, "Strongly Disagree"], callBack);
    }
    else if (form === "TF") {
        db.query(addAnswer, [id, 1, "True"], callBack);
        db.query(addAnswer, [id, 2, "False"], callBack);
    }
    else if (form === "OT") {
        for (let range = 1; range <= 10; range++) {
            db.query(addAnswer, [id, range, range.toString()], callBack);
        }
    }
    else if (form === "YN") {
        db.query(addAnswer, [id, 1, "Yes"], callBack);
        db.query(addAnswer, [id, 2, "No"], callBack);
    }
    else {}
};

//CONTROLLERS
const add_page = function (req, res) {
    res.render('addQuestions');
}

const add_question = function (req, res) {
    formatForQuestion = req.body.questionFormat;
    questionString = req.body.question;
    //Calling the GetSurveyCustomerByID procedure from the Database to grab last survey created's id
    db.query("CALL GetSurveyCustomerByID(?)", [customerID], function(err, result){
        if(err) throw err;
        else {
            //console.log(result[0]); //test result (see surveys it spits out)
            let lastSurveyIndex = -1;
            //range based loop to grab index of last survey because .length doesn't work with result object
            result[0].forEach(function(survey){
                lastSurveyIndex += 1;
            });
            surveyID = (result[0][lastSurveyIndex].survey_ID); //getting surveyID to be added to
            //console.log(result[0][lastSurveyIndex].survey_ID); //test result (see if we get correct survey_ID)
            if (questionString.length === 0 || questionString === "") {} //error checking on the string to see if it's empty
            else {
                //calling AddQuestions procedure if previous procedure runs successfully, add question in string to survey
                db.query("CALL AddQuestions(?,?,?)", [surveyID, 0, questionString], function(err, result) {
                    if (err) throw err;
                    else {
                        //calling GetQuestionID to then add answers to said question
                        db.query("CALL GetQuestionID (?)",[questionString], function(err, result){
                            if(err) throw err;
                            else {
                                questionID = result[0][0].question_ID;
                                formatQuestion(formatForQuestion, questionID);
                            }
                        });
                    }
                });
            }
        }
    });

    res.redirect('/addQuestions');
}

const add_finish = function (req, res) {
    db.query("CALL SetTotalQuestions(?)", [surveyID], function(err, result){
        if(err) throw err;
        else {}
    });
    res.redirect('/busOwn');
}

module.exports = {
    add_page,
    add_question,
    add_finish
}