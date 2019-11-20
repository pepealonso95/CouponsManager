const Promotion = require('../models/Promotion')
const promotionError = require('./errors/promotion-error')

const getAllPromotions = async () => {
  try{

  const promotions = await Promotion.PromotionIn.aggregate(aggregatorOpts);
  let newPromotions = {};
  for (let i = 0 ; i< promotions.length; i++){
    let promotion = promotions[i];
    let object = newPromotions[promotions[i].promotionId] ;
    let keys = Object.keys(promotion);
    for (let j = 0 ; j < keys.length; j++){
      if (keys[j] in object){
        object[keys[j]]++;
      }else{
        object[keys[j]] = 1;
      }
    }
  }

  return promotions;
  }catch (err) {
    console.log(err);
    throw new promotionError.UnableToGetPromotions()
  }
}

const addPromotion = async (promotionToAdd) => {
  try {

    const promotion = new Promotion.PromotionIn(promotionToAdd)
    await promotion.save()

    return promotion
  } catch (error) {
     console.log(error);
    throw new promotionError.UnableToCreatePromotionError()
  }
}


module.exports = {
  getAllPromotions,
  addPromotion
}
