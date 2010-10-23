
function validate_size(){
    if("" == document.getElementById("deliverable_estimated_size").value){
        document.getElementById("check_size").src = "/images/incorrect.png"
    }
    
    else{
        document.getElementById("check_size").src = "/images/correct.png"
    }
}
function validate_rate(){
    if("" == document.getElementById("deliverable_production_rate").value){
        document.getElementById("check_rate").src = "/images/incorrect.png"
    }
    else if(!("" == document.getElementById("deliverable_estimated_size").value)
        && !("" == document.getElementById("deliverable_production_rate").value)
        ){
        document.getElementById("check_effort").src = ""
        document.getElementById("deliverable_estimated_effort").disabled="true"
        document.getElementById("check_rate").src = "/images/correct.png"
    }
    else{
        document.getElementById("check_rate").src = "/images/correct.png"
    }
}
function validate_effort(){
    if("" == document.getElementById("deliverable_estimated_effort").value){
        document.getElementById("check_effort").src = "/images/incorrect.png"
    }
    else if(!("" == document.getElementById("deliverable_estimated_size").value)
        && !("" == document.getElementById("deliverable_estimated_effort").value)
        && ("" == document.getElementById("deliverable_production_rate").value)){
        document.getElementById("check_rate").src = ""
        document.getElementById("deliverable_production_rate").disabled="true"
        document.getElementById("check_effort").src = "/images/correct.png"
    }
    else if(!("" == document.getElementById("deliverable_production_rate").value)
        && !("" == document.getElementById("deliverable_estimated_effort").value)
        && ("" == document.getElementById("deliverable_estimated_size").value)){
        document.getElementById("check_size").src = ""
        document.getElementById("deliverable_estimated_size").disabled="true"
        document.getElementById("check_effort").src = "/images/correct.png"
    }
    else{
        document.getElementById("check_effort").src = "/images/correct.png"
    }
}

function onchange_effort(){
    if("" == document.getElementById("deliverable_estimated_size").value &&
        !("" == document.getElementById("deliverable_production_rate").value)&&
    !("" == document.getElementById("deliverable_estimated_effort").value)){
        document.getElementById("delveriable_estimated_size").disabled="true"
        document.getElementById("check_size").src = ""
        
    }
}
