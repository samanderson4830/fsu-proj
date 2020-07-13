const mysql = require('mysql');
const db = require('../models/db_connection');
const { render } = require('ejs');
//const Customer = require('../models/customer');
//const Customer = require("../models/customer");

const login_page = (req,res) => {
    res.render('login');
}

const login_new = function(req, res) {
    var emailInput = req.body.email;
    db.query("CALL GetCustomersByEmail(?)", [emailInput], function(err, result){
        if(err) throw err;
        else {
            console.log(result[0]);
            companyName = result[0][0].company_name.toString();
            res.redirect("/busOwn");
        }
    });
};

// const login_new = (req, res) => {
   
//     Customer.findOne({ email: req.query['email']}, function(err, result){
//         if(result == null) {
//             res.redirect('/Login');
//             //Need to popup "This email was not found" message hear
//         } else {
//             res.redirect('/busOwn');
//         }
//     });
   
// }

module.exports = {
    login_new,
    login_page
}