const promotionService = require('../services/promotion-service')


const getAllPromotions = async (req, res) => {
    try {
        const promotions = await promotionService.getAllPromotions()
        res.json(promotions)
    } catch (error) {
        res.status(error.status).json(error.message)
    }
}

const addPromotion = async (req, res) => {
    try {
        const promotion = await promotionService.addPromotion(req.body)
        res.status(201).json(promotion)
    } catch (error) {
        res.status(error.status).json(error.message)
    }
}

module.exports = {
    getAllPromotions,
    addPromotion
}
      