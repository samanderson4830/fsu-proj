const express = require('express');
const busOwnController = require('../controllers/busOwnController');
const router = express.Router();

router.get('/', busOwnController.bus_own_page);

router.post('/getAnalytics', busOwnController.bus_own_analytics);

module.exports = router;