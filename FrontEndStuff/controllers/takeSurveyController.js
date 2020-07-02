const mysql = require('mysql');
const db = require('../models/db_connection');


const takeSurvey_page = (req,res) => {
    res.render('TakeSurvey');
}

const takeSurvey_code = (req,res) => {
    const code = req.query.code;
    db.query('SELECT * FROM surveys_created WHERE survey_Id = ?', code, (err,result) => {
        if(err)
        throw err;
        else
        res.send(result);
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
