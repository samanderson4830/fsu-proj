const express = require('express');
const createSurveyController = require('../controllers/createSurveyController');
const router = express.Router(); //instance of a router object

//ROUTES
router.get('/', createSurveyController.create_page);

//exports the router
module.exports = router;