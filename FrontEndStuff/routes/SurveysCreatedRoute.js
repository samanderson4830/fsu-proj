const express = require('express');
var router = express.Router();
var db = require('../models/db_connection');


exports.list = function(req, res) {

    req.getConnection(function(err, db) {
        var query = db.query('SELECT * FROM surveys_created', function(err, rows) {
            if(err)
                console.log("Error selecting:  %s", err);
            res.render('surveyscreatedTable', {page_title: "Surveys Created Table Test", data:rows});
        });
    });
};