var PromotionIds = [];
$( document ).ready(function() {

    if($('.plus-btn').length > 0){
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
                $(this).removeClass('selected btn-success');
                $(this).addClass('unselected btn-primary');
                $(this).html('+');
            }else{
                PromotionIds.push(id);
                $(this).removeClass('unselected btn-primary');
                $(this).addClass('selected btn-success');
                $(this).html('✔');
            }
        })
    }
});

