var PromotionIds = [];
$( document ).ready(function() {
    generateCode();
    $("form").submit(function (e) { 
        $('#promotions').val(JSON.stringify(PromotionIds));
        var promo = $('#promotions').val();
        return true;
    });
    $('.plus-btn').click(function (){
        var id = $(this).attr('id');
        if (PromotionIds.includes(id)){
            var index = PromotionIds.indexOf(id);
            if (index > -1) {
                PromotionIds.splice(index, 1);
            }
            $(this).removeClass('selected');
            $(this).addClass('unselected');
            $(this).html('+');
        }else{
            PromotionIds.push(id);
            $(this).removeClass('unselected');
            $(this).addClass('selected');
            $(this).html('-');
        }
    })
});

generateCode = function(){
    // PromotionIds.push({jeje: 'dfdf'});
    // var jua = { promotionIds: 'hola', 'authenticity_token': $('meta[name=csrf-token]').attr("content") };
    // $.ajax({
    //     url: "/promotions/getCode",
    //     type: "post",
    //     data: jua,
    //     success: function(data) {
    //         console.log(data);
    //     },
    //     error: function(data) {
    //         console.log
    //     }
    //   });
}