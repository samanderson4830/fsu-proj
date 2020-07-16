const mysql = require('mysql');
const db = require('../models/db_connection');
const { render } = require('ejs');

//CONTROLLERS
const add_page = function (req, res) {
    res.render('addQuestions');
}

module.exports = {
    add_page
}