const mysql = require('mysql');
const db = require('../models/db_connection');
const { render } = require('ejs');

const registration_page = (req,res) => {
    res.render('registration');
}

const registration_new = function (req, res) {
    //call AddCompany procedure and pass in value that are coming in via form inputs
    db.query("CALL AddCompany(?,?,?,?,?)", [req.body.email, req.body.code, req.body.companyName, req.body.firstName,
        req.body.lastName], function(err, result) {
        if (err) throw err;
        else {
            console.log(result[0]);
        }
    });
    //after account is made we redirect them to the login page
    res.redirect('/login');
}

module.exports = {
    registration_new,
    registration_page
}