document.addEventListener("DOMContentLoaded",function(){

const qtyBoxes=document.querySelectorAll(".qty-box");

qtyBoxes.forEach(function(box){

const minus=box.querySelector(".minus");
const plus=box.querySelector(".plus");
const qty=box.querySelector(".quantity");

if(minus && plus){

plus.addEventListener("click",function(){

qty.innerText=parseInt(qty.innerText)+1;

});

minus.addEventListener("click",function(){

let value=parseInt(qty.innerText);

if(value>1){

qty.innerText=value-1;

}

});

}

});

});