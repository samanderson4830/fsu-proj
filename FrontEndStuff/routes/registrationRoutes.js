const express = require('express');
const registrationController = require('../controllers/registrationController');
const router = express.Router();

router.get('/', registrationController.registration_page);

//router.post('/', registrationController.registration_new);

module.exports = router;