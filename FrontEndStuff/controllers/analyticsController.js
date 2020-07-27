const mysql = require('mysql');
const db = require('../models/db_connection');
const { render } = require('ejs');

//CONTROLLERS

const analytics_page = function (req, res) {
    res.render('analytics');
}

module.exports = {
    analytics_page
}