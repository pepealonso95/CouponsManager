const mongoose = require('mongoose')

const promotion = {
  iata_code: {
    type: String,
    required: true,
    trim: true
  },
  iso_code: {
    type: String,
    required: true,
    trim: true
  },
  birthdate: {
    type: String,
    required: true,
    trim: true
  },
  promotionId: {
    type: Number,
    required: true,
    trime: true
  }
}

const PromotionIn = mongoose.model('Promotion', promotion)

module.exports = {
  PromotionIn
}
