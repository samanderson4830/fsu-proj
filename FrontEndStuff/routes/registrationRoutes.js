const express = require('express');
const registrationController = require('../controllers/registrationController');
const router = express.Router();

//ROUTES
//main registration page
router.get('/', registrationController.registration_page);
//post request page where new account info is processed
router.post('/newUser', registrationController.registration_new);

module.exports = router;