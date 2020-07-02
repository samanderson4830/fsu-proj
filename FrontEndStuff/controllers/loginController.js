//const Customer = require('../models/customer');
//const Customer = require("../models/customer");

const login_page = (req,res) => {
    res.render('login');
}

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
   // login_new,
    login_page
}