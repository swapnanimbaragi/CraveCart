document.addEventListener("DOMContentLoaded", function () {

    let qtyBoxes = document.querySelectorAll(".qty-box");

    qtyBoxes.forEach(function (box) {

        let minusBtn = box.querySelector(".minus");
        let plusBtn = box.querySelector(".plus");
        let quantityText = box.querySelector(".quantity");

        plusBtn.addEventListener("click", function () {
            let quantity = parseInt(quantityText.innerText);
            quantityText.innerText = quantity + 1;
        });

        minusBtn.addEventListener("click", function () {
            let quantity = parseInt(quantityText.innerText);

            if (quantity > 1) {
                quantityText.innerText = quantity - 1;
            }
        });

    });

});