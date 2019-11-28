class PromotionError extends Error {
  constructor (message, status) {
    super()

    Error.captureStackTrace(this, this.constructor)

    this.name = this.constructor.name

    this.message = message ||
          'Something went wrong. Please try again.'

    this.status = status || 500
  }
}

class UnableToGetPromotions extends PromotionError {
  constructor (message) {
    super(message || 'Unable to get promotions.', 400)
  }
}

class UnableToCreatePromotionError extends PromotionError {
  constructor (message) {
    super(message || 'Unable to create promotion.', 400)
  }
}

module.exports = {
  UnableToCreatePromotionError,
  UnableToGetPromotions
}
