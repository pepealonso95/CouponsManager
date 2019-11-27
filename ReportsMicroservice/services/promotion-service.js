const moment = require('moment');
const Promotion = require('../models/Promotion')
const promotionError = require('./errors/promotion-error')

const getAllPromotions = async () => {
  try{

  const promotions = await Promotion.PromotionIn.find();
  console.log(promotions);
  let result = [];
  let knownPromotions = {};
  for (let i = 0 ; i< promotions.length; i++){
    let promotion = promotions[i];
    if (! (promotion.promotionId in knownPromotions)){
      knownPromotions[promotion.promotionId] = true;
      let filteredPromotions = promotions.filter(function (prom){ return prom.promotionId === promotion.promotionId });
      let objectResult = {promotionId: promotion.promotionId, cities:{}, ages: { 18025: 0, 25040:0, 40060: 0, 60: 0}, countries:{} };
      for (let j = 0; j<filteredPromotions.length;j++){
        let p = filteredPromotions[j];
        if (p.iata_code !==null && p.iata_code !== '')
          objectResult.cities[p.iata_code] = p.iata_code in objectResult.cities  ? objectResult.cities[p.iata_code] + 1 : 1;
        if (p.iso_code !==null && p.iso_code !== '')
          objectResult.countries[p.iso_code] = p.iso_code in objectResult.countries ? objectResult.countries[p.iso_code] + 1 : 1;
        if (p.birthdate !== DateRange.NOT_FOUND ){
          if (p.birthdate === DateRange.TEEN)
            objectResult.ages[18025]++;
          if (p.birthdate === DateRange.AVERAGE)
            objectResult.ages[25040]++;
          if (p.birthdate === DateRange.OLD)
            objectResult.ages[40060]++;
          if (p.birthdate === DateRange.VERY_OLD)
            objectResult.ages[60]++;
        }
      }
      result.push(objectResult);
    }
  }

  return result;
  }catch (err) {
    console.log(err);
    throw new promotionError.UnableToGetPromotions()
  }
}

const addPromotion = async (promotionToAdd) => {
  try {
    let dateRange = checkDate(promotionToAdd.birthdate);
    promotionToAdd.birthdate = dateRange;
    const promotion = new Promotion.PromotionIn(promotionToAdd);
    await promotion.save();
    return promotion;
  } catch (error) {
     console.log(error);
    throw new promotionError.UnableToCreatePromotionError()
  }
}

const checkDate = (date) =>{
  let result = DateRange.NOT_FOUND;

  if (moment(date, 'DD/MM/YYYY').isBetween( moment().subtract(25, 'years'), moment().subtract(18, 'years'))){
    result = DateRange.TEEN;
  } else if (moment(date, 'DD/MM/YYYY').isBetween( moment().subtract(40, 'years'), moment().subtract(25, 'years'))){
    result = DateRange.AVERAGE;
  } else if (moment(date, 'DD/MM/YYYY').isBetween( moment().subtract(60, 'years'), moment().subtract(40, 'years'))){
    result = DateRange.OLD;
  } else if (moment(date, 'DD/MM/YYYY').isBetween( moment().subtract(150, 'years'), moment().subtract(60, 'years'))){
    result = DateRange.VERY_OLD;
  }
  return result;
}

var DateRange = {
  NOT_FOUND: -1,
  TEEN: 1,
  AVERAGE: 2,
  OLD: 3,
  VERY_OLD: 4,
};


module.exports = {
  getAllPromotions,
  addPromotion
}
