const express = require('express');
const addQuestionsController = require('../controllers/addQuestionsController.js');
const router = express.Router(); //instance of a router object

//ROUTER
router.get('/', addQuestionsController.add_page);

module.exports = router;