
$( document ).ready(function() {
   let report = JSON.parse($('#report').val());
   let promotions = Object.keys(report); 
   let html =  "";
   for (let i =0;i<promotions.length;i++){

    var myvar = '<div class=\'reportContainer\'>'+
    '    <div class=\'promotionContainer\'>'+
    '        <div class=\'promotionTitle\'>'+
    '            Promotion '+ report[promotions[i]].promotionId + 
    '        </div>'+
    '        <div class=\'promotionStatistics\'> Cities: '+
    '            <div class=\'promotionGroup\'>';
    let cities = Object.keys(report[promotions[i]].cities);
    let citiesHtml = ''; 
    for (let j = 0; j<cities.length;j++){
        let city =  '<div class=\'promtionStatistic\'>'+
        '                    <span class=\'promotionLabel\'>'+ cities[j]+ ':</span>'+
        '                    <span class=\'value\'>'+report[promotions[i]].cities[cities[j]] + '</span>'+
        '                </div>';
        citiesHtml += city;
    }
    myvar+=citiesHtml;
    myvar+= "</div></div>" +
    '        <div class=\'promotionStatistics\'> Countries: '+
    '            <div class=\'promotionGroup\'>';
    let countries = Object.keys(report[promotions[i]].countries);
    let countriesHtml = ''; 
    for (let j = 0; j<countries.length;j++){
        let city =  '<div class=\'promtionStatistic\'>'+
        '                    <span class=\'promotionLabel\'>'+ countries[j]+ ':</span>'+
        '                    <span class=\'value\'>'+report[promotions[i]].countries[countries[j]] + '</span>'+
        '                </div>';
        countriesHtml += city;
    }
    myvar+=countriesHtml;
    myvar+= "</div></div>" +
    '        <div class=\'promotionStatistics\'> Ages: '+
    '            <div class=\'promotionGroup\'>' + 
    '                <div class=\'promtionStatistic\'>'+
    '                    <span class=\'promotionLabel\'>18-25: </span>'+
    '                    <span class=\'value\'>'+report[promotions[i]].ages[18025]  +'</span>'+
    '                </div>'+
    '                <div class=\'promtionStatistic\'>'+
    '                    <span class=\'promotionLabel\'>25-40: </span>'+
    '                    <span class=\'value\'>'+report[promotions[i]].ages[25040]  +'</span>'+
    '                </div>'+
    '                <div class=\'promtionStatistic\'>'+
    '                    <span class=\'promotionLabel\'>40-60: </span>'+
    '                    <span class=\'value\'>'+report[promotions[i]].ages[40060]  +'</span>'+
    '                </div>'+
    '                <div class=\'promtionStatistic\'>'+
    '                    <span class=\'promotionLabel\'>60+: </span>'+
    '                    <span class=\'value\'>'+report[promotions[i]].ages[60]  +'</span>'+
    '                </div>'+
    '            </div>';
    myvar +=  '</div>'+
    '    </div>'+
    '</div>';
	html+= myvar;
   }
   $('#reportHtml').html(html);
});