const mysql = require('mysql');
const db = require('../models/db_connection');
const { render } = require('ejs');


const takeSurvey_page = (req,res) => {
    res.render('TakeSurvey');
}

const takeSurvey_code = (req,res) => {
    const code = req.query.code;
    db.query('SELECT survey_name FROM surveys_created WHERE survey_Id = ?', code, (err,result) => {
        if(err)
        throw err;
        else{
            //res.send(result);
            //var test1 = JSON.parse(result);

            obj = result[0].survey_name;
            console.log(obj);
            db.query('SELECT survey_ID FROM surveys_created WHERE survey_name = ?', obj, (err,thisResult) => {
                if(err)
                throw err;
                else{
                    //res.send(result);
                    
                    var test1 = {};
                    test1 = thisResult[0].survey_ID;
                    console.log(test1);
                    res.redirect('../survey');
                }
            })
            //res.redirect('../survey');
            //**** Now need to send this survey name to the survey page and make it generic. */
            // res.render('surveyPage', {
            //     _name : result[0].survey_name
            // });
        }
    })

    


    // let sql = "call BSA_Database.GetSurveyQuestions('?')", code;

    // db.query (sql, (err, result) => {
    //     if (err)
    //     {
    //         throw err;
    //     } else
    //     {
    //         console.log("Data found .....");
    //         res.send(result);
    //     }
    // });
}

module.exports = {
    takeSurvey_page,
    takeSurvey_code
}