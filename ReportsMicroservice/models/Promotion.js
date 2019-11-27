const mongoose = require('mongoose')

const promotion = {
  iata_code: {
    type: String,
    trim: true
  },
  iso_code: {
    type: String,
    trim: true
  },
  birthdate: {
    type: Number,
    trim: true
  },
  promotionId: {
    type: Number,
    trim: true
  }
}

const PromotionIn = mongoose.model('Promotion', promotion)

module.exports = {
  PromotionIn
}
