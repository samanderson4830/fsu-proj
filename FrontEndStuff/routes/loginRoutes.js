const express = require('express');
const loginController = require('../controllers/loginController');
const router = express.Router();

router.get('/', loginController.login_page);

//router.get('/goLogin', loginController.login_new);

module.exports = router;