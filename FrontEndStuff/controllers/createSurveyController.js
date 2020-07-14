const mysql = require('mysql');
const db = require('../models/db_connection');
const { render } = require('ejs');

//CONTROLLERS
const create_page = function (req, res) {
    res.render("createSurvey");
}

module.exports = {
    create_page
}