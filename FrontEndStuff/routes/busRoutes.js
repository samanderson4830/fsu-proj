const express = require('express');
const busOwnController = require('../controllers/busOwnController');
const router = express.Router();

router.get('/', busOwnController.bus_own_page);

//router.get('/goLogin', loginController.login_new);

module.exports = router;