//const Customer = require('../models/customer');

const registration_page = (req,res) => {
    res.render('registration');
}

// const registration_new = (req, res) => {
//     const customer = new Customer(req.body);

//     customer.save()
//     .then((result) => {
//         res.redirect('/Login'); //redirects to login page
//     })
//     .catch((err) => {
//         console.log(err);
        
//     })
// }

module.exports = {
   // registration_new,
    registration_page
}