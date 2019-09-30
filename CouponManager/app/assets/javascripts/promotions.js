var Counter = 0;
var ConditionObject = {};
$( document ).ready(function() {
    console.log( "ready!" );

    $('.select-condition-type').change(function(){
        var id = $(this).attr('id').replace("select-condition-type", "");;
        var value = $(this).val();
        if(value=="primitive"){
            var html = getPrimitiveCondition(id);
            $('#condition-element'+id).html(html);
        }else if(value=="non-primitive"){
            var html = getNestedCondition(id);
            $('#condition-element'+id).html(html);
        }
     });

});



addCondition = function(id){
    Counter++;
    ConditionObject[Counter] = {};
    var html = getNewCondition();
    $('#conditions').append(html);
    $('.select-condition-type').change(function(){
        var id = $(this).attr('id').replace("select-condition-type", "");;
        var html = getPrimitiveCondition(id);
        $('#condition-element'+id).html(html);
     });
}

getNewCondition = function (id){
    ConditionObject[id] = {isPrimitive: false}
var myvar = '<div class="condition">'+
`    <select id="select-condition-type${id+1}" class="select-condition-type">`+
'    <option value="none">None</option>'+
'    <option value="primitive">Condicion</option>'+
'    <option value="non-primitive">Subcondiciones</option>'+
'    </select>'+
`    <div id="condition-element${id+1}" class="selected-condition"></div>`+
'    </div>'+
'</div>';
	return myvar;

}




getPrimitiveCondition = function(id){

    ConditionObject[id] = {isPrimitive: false}

var myvar = `<div id="primitive-condition${id}" class="primitive-condition">`+
'    <select class="expresion-parameter">'+
'    <option value="TOTAL">Total</option>'+
'    <option value="PRODUCT_SIZE">Product Size</option>'+
'    <option value="QUANTITY">Quantity</option>'+
'    </select>'+
'    <select class="comparator">'+
'    <option value="GREATER">></option>'+
'    <option value="GREATER_EQUAL">>=</option>'+
'    <option value="EQUALS">=</option>'+
'    <option value="DIFFERENT">=/</option>'+
'    <option value="LESS_EQ"><=</option>'+
'    <option value="LESS"><</option>'+
'    </select>'+
'    <input class="compare-value" type="number" name="compare-value" min="1" max="5">'+
'</div>';

return myvar;
	

}

getNestedCondition = function(id){
    var nextId = id+1;
    var myvar = `<div id="nested-condition${nextId}" class="nested-condition">`+
    `    <div class="sub-conditionA">${getNewCondition(nextId)}</div>`+
    '    <select class="comparator">'+
    '        <option value="AND">AND</option>'+
    '        <option value="OR">OR</option>'+
    '    </select>'+
    `    <div class="sub-conditionB">${getNewCondition(nextId)}</div>`+
    '</div>';
    return myvar;
    
    }