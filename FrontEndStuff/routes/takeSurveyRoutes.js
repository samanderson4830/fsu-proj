const express = require('express');
const takeSurveyController = require('../controllers/takeSurveyController');
const router = express.Router();

router.get('/',takeSurveyController.takeSurvey_page);
router.get('/survey', takeSurveyController.takeSurvey_code);

module.exports = router;