const express = require('express');
const takeSurveyController = require('../controllers/takeSurveyController');
const router = express.Router();

router.get('/',takeSurveyController.takeSurvey_page);
router.get('/survey', takeSurveyController.takeSurvey_code);
router.get('/questions', takeSurveyController.get_questions);
router.get('/answers', takeSurveyController.get_answers);
router.get('/offset', takeSurveyController.get_offset);

module.exports = router;