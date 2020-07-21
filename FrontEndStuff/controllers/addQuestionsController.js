const mysql = require('mysql');
const db = require('../models/db_connection');
const { render } = require('ejs');

//CONTROLLERS
const add_page = function (req, res) {
    res.render('addQuestions');
}

const add_question = function (req, res) {
    format = req.body.questionFormat;
    
    res.redirect('/addQuestions');
}

module.exports = {
    add_page,
    add_question
}