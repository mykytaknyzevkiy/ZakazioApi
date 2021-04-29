function createCyptograf(cardNum, cardExpMount, cardExpYear, cardHoldenName, cardCvv) {

    document.getElementById("cp_card_num").value = cardNum;
    document.getElementById("cp_card_exp_mount").value = cardExpMount;
    document.getElementById("cp_card_exp_year").value = cardExpYear;
    document.getElementById("cp_card_cvv").value = cardCvv;
    document.getElementById("cp_card_name").value = cardHoldenName;

    checkout = new cp.Checkout(
        // public id из личного кабинета
        "pk_81a3630bdf32633b8b1e1626dea96",
        // тег, содержащий поля данных карты
        document.getElementById("paymentFormSample"));

    var result = checkout.createCryptogramPacket();

    if (result.success) {
        return result.packet;
    } else {
        return null;
    }
}

function copy(text) {
    var input = document.createElement('textarea');
    input.innerHTML = text;
    document.body.appendChild(input);
    input.select();
    var result = document.execCommand('copy');
    document.body.removeChild(input);
    return result;
}