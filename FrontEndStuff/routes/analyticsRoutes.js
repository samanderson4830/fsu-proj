const express = require('express');
const analyticsController = require('../controllers/analyticsController.js');
const router = express.Router(); //instance of a router object

//ROUTES

router.get("/", analyticsController.analytics_page);

module.exports = router;