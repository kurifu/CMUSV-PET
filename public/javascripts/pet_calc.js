check_rate = document.getElementById("check_rate").src
check_effort = document.getElementById("check_effort").src
check_size = document.getElementById("check_size").src

correct_pic = "/images/correct.png"
incorrect_pic = "/images/incorrect.png"
default_pic = "/images/default.png"

//ass
check = "ass"
function check_all(size,effort,rate){
    if("" == size.value){
        check_size = default_pic
    }
    else if(!("" == size.value) && !("" == rate.value)){
        check_effort = default_pic
        check_size = correct_pic
    }

    else if(!("" == size.value) && !("" == effort.value)){
        check_rate = default_pic
       check_size.src = correct_pic
    }
    else if("" == size.value &&(!("" == rate.value))
        && (!("" == effort.value))){
        check_size.src = default_pic
       
    }
    else if("" == size.value && rate.disabled && !("" == effort.value)){
       check_size = incorrect_pic
        check_rate = default_pic
    }
    else if("" == size.value && effort.disabled && !("" == rate.value)){
        check_size = incorrect_pic
        check_effort = default_pic
    }
    else{
        check_size = correct_pic
    }
}

function validate_size(){
    if(isNaN(document.getElementById("deliverable_estimated_size").value)){
        document.getElementById("calc").
            innerHTML = "Please enter numeric values"
        document.getElementById("check_size").src = "/images/incorrect.png"
    }
    else{
    if("" == document.getElementById("deliverable_estimated_size").value){
        document.getElementById("check_size").src = "/images/incorrect.png"
    }
    else if(!("" == document.getElementById("deliverable_estimated_size").value)
        && !("" == document.getElementById("deliverable_production_rate").value)
        ){
        document.getElementById("check_effort").src = "/images/default.png"
        document.getElementById("deliverable_estimated_effort").disabled="true"
        document.getElementById("check_size").src = "/images/correct.png"
    }
    else if(!("" == document.getElementById("deliverable_estimated_size").value)
        && !("" == document.getElementById("deliverable_estimated_effort").value)
        ){
        document.getElementById("check_rate").src = "/images/default.png"
        document.getElementById("deliverable_production_rate").disabled="true"
        document.getElementById("check_size").src = "/images/correct.png"
    }
    else if("" == document.getElementById("deliverable_estimated_size").value
        &&(!("" == document.getElementById("deliverable_production_rate").value)
        && (!("" == document.
        getElementById("deliverable_estimated_effort").value)))){
        document.getElementById("check_size").src = "/images/default.png"
        document.getElementById("deliverable_estimated_size").disabled="true"
    }

    else{
        document.getElementById("check_size").src = "/images/correct.png"
    }
    }
}
function validate_rate(){

    if(isNaN(document.getElementById("deliverable_production_rate").value)){
        document.getElementById("calc").
            innerHTML = "Please enter numeric values"
        document.getElementById("check_rate").src = "/images/incorrect.png"
    }
    else{

    if("" == document.getElementById("deliverable_production_rate").value){
        document.getElementById("check_rate").src = "/images/incorrect.png"
    }
    else if(!("" == document.getElementById("deliverable_estimated_effort").value)
        && !("" == document.getElementById("deliverable_production_rate").value)
        ){
        document.getElementById("check_size").src = "/images/default.png"
        document.getElementById("check_rate").src = "/images/correct.png"
    }
    else if(!("" == document.getElementById("deliverable_estimated_size").value)
        && !("" == document.getElementById("deliverable_production_rate").value)
        ){
        document.getElementById("check_effort").src = "/images/default.png"
        document.getElementById("check_rate").src = "/images/correct.png"
    }
    else if("" == document.getElementById("deliverable_production_rate").value
        &&(!("" == document.getElementById("deliverable_estimated_size").value)
        && (!("" == document.getElementById("deliverable_estimated_effort").value)))){
        document.getElementById("check_rate").src = "/images/default.png"
        
    }
    else if(document.getElementById("deliverable_estimated_size").disabled){
            if(""==document.getElementById("deliverable_production_rate").value)
                {
                     document.getElementById("check_rate")
                     .src = "/images/incorrect.png"
                    document.getElementById("check_size")
                    .src = "/images/incorrect.png"
                }

    }
    else{
        document.getElementById("check_rate").src = "/images/correct.png"
    }
    }
}
function validate_effort(){

    if(isNaN(document.getElementById("deliverable_estimated_effort").value)){
        document.getElementById("calc").
            innerHTML = "Please enter numeric values"
        document.getElementById("check_effort").src = "/images/incorrect.png"
    }
    else{
    if("" == document.getElementById("deliverable_estimated_effort").value){
        document.getElementById("check_effort").src = "/images/incorrect.png"
    }
    else if(!("" == document.getElementById("deliverable_estimated_size").value)
        && !("" == document.getElementById("deliverable_estimated_effort").value)
        && ("" == document.getElementById("deliverable_production_rate").value)){
        document.getElementById("check_rate").src = "/images/default.png"
        document.getElementById("check_effort").src = "/images/correct.png"
    }
    else if(!("" == document.getElementById("deliverable_production_rate").value)
        && !("" == document.getElementById("deliverable_estimated_effort").value)
        && ("" == document.getElementById("deliverable_estimated_size").value)){
        document.getElementById("check_size").src = "/images/default.png"
        document.getElementById("check_effort").src = "/images/correct.png"
    }
    else{
        document.getElementById("check_effort").src = "/images/correct.png"
    }
    }
}


function reset(){

    document.getElementById("deliverable_estimated_size").value=""
    document.getElementById("deliverable_estimated_effort").value=""
    document.getElementById("deliverable_production_rate").value=""

    
    document.getElementById("check_rate").src="/images/default.png"
    document.getElementById("check_size").src="/images/default.png"
    document.getElementById("check_effort").src="/images/default.png"

    document.getElementById("calc").innerHTML = ""

}

function calculate(){

    
    if("" == document.getElementById("deliverable_estimated_size").value &&
       "" == document.getElementById("deliverable_estimated_effort").value &&
       "" == document.getElementById("deliverable_production_rate").value ){
        document.getElementById("calc")
        .innerHTML = "Please enter two values";
    }
  
    else{
         document.getElementById("calc")
        .innerHTML = "";
    if(!("" == document.getElementById("deliverable_estimated_size").value) &&
       !("" == document.getElementById("deliverable_estimated_effort").value)){
            size = parseFloat(document.getElementById
            ("deliverable_estimated_size").value)
            effort = parseFloat(document.getElementById
            ("deliverable_estimated_effort").value)
         rate = effort/size
        document.getElementById("deliverable_production_rate").value = rate
        document.getElementById("check_size").src = "/images/default.png"
        document.getElementById("check_effort").src = "/images/default.png"
        }
   else if(!("" == document.getElementById("deliverable_estimated_size").value)
      && !("" == document.getElementById("deliverable_production_rate").value)){
            size = parseFloat(document.getElementById
            ("deliverable_estimated_size").value)
            rate = parseFloat(document.getElementById
            ("deliverable_production_rate").value)
         effort = size * rate
        document.getElementById("deliverable_estimated_effort").value = effort
        document.getElementById("check_size").src = "/images/default.png"
        document.getElementById("check_rate").src = "/images/default.png"
        }
    else if(!("" == document.getElementById("deliverable_estimated_effort")
    .value) &&
       !("" == document.getElementById("deliverable_production_rate").value)){
            rate = parseFloat(document.getElementById
            ("deliverable_production_rate").value)
            effort = parseFloat(document.getElementById
            ("deliverable_estimated_effort").value)
         size = effort / rate
        document.getElementById("deliverable_estimated_size").value = size
        document.getElementById("deliverable_estimated_size").disabled=false
        document.getElementById("check_rate").src = "/images/default.png"
        }
}
}