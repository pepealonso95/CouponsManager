const express = require('express')
const reportController = require('../controllers/report-controller')
const router = new express.Router()

router.get('/reports', reportController.getAllPromotions)
router.post('/reports', reportController.addPromotion)

module.exports = router