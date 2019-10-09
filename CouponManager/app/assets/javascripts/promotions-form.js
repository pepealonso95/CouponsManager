var Counter = 0;
var ConditionObject = {};
var initialized = false;
$( document ).ready(function() {
    if($('#promotion_condition').length > 0&&!initialized){
        $("form").submit(function (e) { 
            saveCondition()
            return true;
        });
        initialized = $('#promotion_condition').val()==""
        if($('#promotion_condition').val()==""){
            ConditionObject = {};
            makeConditionChange(0,ConditionObject)
        }
         if(!initialized){
            ConditionObject = JSON.parse($('#promotion_condition').val());
            makeConditionChange(Counter, ConditionObject);
            initialized = true;
        }
    }

});

makeConditionChange = function (id, cond){
    if(initialized){
        getPrimitiveCondition($('#condition-element'+id), cond);
    }
    $('#select-condition-type'+id).change(function(){
        var id = $(this).attr('id').replace("select-condition-type", "");
        var value = $(this).val();
        if(value=="primitive"){
            getPrimitiveCondition($('#condition-element'+id), cond);
        }else if(value=="non-primitive"){
            getNestedCondition($('#condition-element'+id), cond);
        }else{
            cond = {};
        }
        saveCondition()
    });
    if(!initialized){
        if(!cond.hasOwnProperty('is_primitive')||cond.is_primitive){
            $('#select-condition-type'+id).val("primitive");
            getPrimitiveCondition($('#condition-element'+id), cond);
        }else{
            $('#select-condition-type'+id).val("non-primitive");
            getNestedCondition($('#condition-element'+id), cond);
        }
    }
}

onParameterChange = function (id, cond){
    $('#expresion-parameter'+id).change(function(){
        var value = $(this).val();
        cond.attribute = value;
        saveCondition()
    });
    if(!initialized){
        $('#expresion-parameter'+id).val(cond.attribute);
    }
}

onComparatorChange = function (id, cond){
    $('#comparator'+id).change(function(){
        var value = $(this).val();
        cond.comparator = value;
        saveCondition()
    });
    if(!initialized){
        $('#comparator'+id).val(cond.comparator);
    }
}

onOperatorChange = function (id, cond){
    $('#operator'+id).change(function(){
        var value = $(this).val();
        cond.operator = value;
        saveCondition()
    });
    if(!initialized){
        $('#operator'+id).val(cond.operator);
    }
}

onValueChange = function (id, cond){
    $('#compare-value'+id).on("keyup keydown change",function(){
        var value = $(this).val();
        cond.value = parseInt(value);
        saveCondition()
    });
    if(!initialized){
        $('#compare-value'+id).val(cond.value);
    }
}

getNewCondition = function (object, cond){
    var nextId = Counter++;
var myvar = '<div class="condition">'+
`    <select id="select-condition-type${nextId}" class="select-condition-type">`+
'    <option value="primitive">Condicion</option>'+
'    <option value="non-primitive">Subcondiciones</option>'+
'    </select><br>'+
`    <div id="condition-element${nextId}" class="selected-condition"></div>`+
'    </div>'+
'</div>';
    object.html(myvar);
    makeConditionChange(nextId, cond);
}


getPrimitiveCondition = function(object, cond){
    var nextId = Counter++;
    if(initialized){
        cond.is_primitive = true;
        cond.attribute = "TOTAL";
        cond.comparator = "GREAT";
        cond.value = 0;
    }

var myvar = `<div id="primitive-condition${nextId}" class="primitive-condition">`+
`    <select id="expresion-parameter${nextId}" class="expresion-parameter">`+
'    <option value="TOTAL">Total</option>'+
'    <option value="QUANTITY_PRODUCT_SIZE">Quantity / Product Size</option>'+
'    </select>'+
`    <select id="comparator${nextId}" class="comparator">`+
'    <option value="GREAT">></option>'+
'    <option value="GREAT_EQ">>=</option>'+
'    <option value="EQUALS">=</option>'+
'    <option value="NOT_EQUALS">=/</option>'+
'    <option value="LESS_EQ"><=</option>'+
'    <option value="LESS"><</option>'+
'    </select>'+
`    <input id="compare-value${nextId}" class="compare-value" type="number" name="compare-value" min="0" value="0">`+
'</div>';
object.html(myvar);
onParameterChange(nextId, cond);
onComparatorChange(nextId, cond);
onValueChange(nextId, cond);
}

getNestedCondition = function(object, cond){
    var nextId = Counter++;
    if(initialized){
        cond.is_primitive = false;
        cond.operator = "AND";
        cond.condition1 = {};
        cond.condition2 = {};
    }
    var myvar = `<div id="nested-condition${nextId}" class="nested-condition">`+
    `    <div id="sub-conditionA${nextId}" class="sub-conditionA"></div>`+
    `    <select id="operator${nextId}" class="operator">`+
    '        <option value="AND">AND</option>'+
    '        <option value="OR">OR</option>'+
    '    </select><br>'+
    `    <div id="sub-conditionB${nextId}" class="sub-conditionB"></div>`+
    '</div>';
    object.html(myvar);
    getNewCondition($(`#sub-conditionA${nextId}`), cond.condition1);
    getNewCondition($(`#sub-conditionB${nextId}`), cond.condition2);
    onOperatorChange(nextId, cond);
}

saveCondition = function(){
    $('#promotion_condition').val(JSON.stringify(ConditionObject));
}