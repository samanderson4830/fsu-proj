const mysql = require('mysql');
const db = require('../models/db_connection');

var code = 0;
let questionArray, answerArray, ansTrack, localAnsTrack

const takeSurvey_page = (req,res) => {
    res.render('TakeSurvey');
}

const takeSurvey_code = (req,res) => {
     code = req.query.code;
     ansTrack = 0; //tracks the current question number
    let sql1 = "call BSA_Database.GetSurveyByID(?)";
    db.query(sql1, [code], (err, results) => {
        if (err) throw err;
        else {
            console.log(results[0][0].survey_name+' Data found');
            obj = results[0][0].survey_name;
            //res.redirect('../survey');
        }
    });

    let sql = "call BSA_Database.GetSurveyQuestions(?)";

    db.query (sql,[code], (err, result) => {
        if (err)
        {
            throw err;
        } else
        {
            console.log("Data found .....");
            test2 = result[0];
            res.redirect(303,'../survey');
            //res.send(result[0]);
        }
    });
}

const get_questions = (req,res) => {
    let sql_question = "call BSA_Database.GetSurveyQuestions(?)";

    db.query (sql_question,[code], (err, result) => {
        if (err)
        {
            throw err;
        } else
        {
            console.log("Data found .....");
            
            questionArray = result[0];
            res.send(questionArray);
        }
    });

    
       
}

const get_offset = (req,res) => {
    let totalQuestion = "call BSA_Database.GetOffset(?)";

    db.query (totalQuestion,[code], (err, results) => {
        if (err)
        {
            throw err;
        } else
        {
            var totalQ = results;
            var sum = 0,i;
            for(i = 0; i < totalQ[0].length; i++)
            {
                sum += totalQ[0][i].total_questions
            }
            //console.log(totalQ[0][1].total_questions); //[0][0].total_questions
            console.log(sum); 
            ansTrack = sum +1; //ansTrack is the number to start on.
            localAnsTrack = sum+1
            
        }
    });
}

const get_answers = (req,res) => {
    let sql_answer = "call BSA_Database.GetSurveyAnswers(?)";

    db.query (sql_answer,[ansTrack], (err, result) => {
        if (err)
        {
            throw err;
        } else
        {
            console.log("Data found .....");
            
            answerArray = result[0];
            res.send(answerArray);
        }
    });
    ansTrack++;
}

const send_result = (req,res) => 
{    
    // parms: (1) ans_string ... (2) survey_ID ... (3) question_ID
    let sql_result = "CALL BSA_Database.AddResult(?, ?, ?)"; // MySQL query
    for (var key in req.body) 
    {
        if (req.body.hasOwnProperty(key)) // has value then call query
        {
            db.query(sql_result,[req.body[key], code, localAnsTrack], (err, result) => 
            {
                if(err) 
                {
                    throw err;
                } 
            })
            localAnsTrack++; // hold the question ID
        }
    }
}


module.exports = {
    takeSurvey_page,
    takeSurvey_code,
    get_answers,
    get_offset,
    send_result,
    get_questions
}