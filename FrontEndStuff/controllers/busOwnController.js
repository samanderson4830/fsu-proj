//const Customer = require("../models/customer");

const bus_own_page = (req,res) => {
    res.render('businessOwnerLogin');
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
    bus_own_page
}