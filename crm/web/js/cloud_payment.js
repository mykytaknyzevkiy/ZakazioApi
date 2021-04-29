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

function open3ds(dsUrl, transactionId, paReq, acsUrl) {
    var form = document.createElement("form");
    form.method = "POST";
    form.action = dsUrl;
    form.style.display = "none";

    var input = document.createElement("input");
    input.type = "hidden";
    input.name = "transactionId";
    input.value = transactionId;
    form.appendChild(input);

    var input2 = document.createElement("input");
    input2.type = "hidden";
    input2.name = "paReq";
    input2.value = paReq;
    form.appendChild(input2);

    var input3 = document.createElement("input");
    input3.type = "hidden";
    input3.name = "acsUrl";
    input3.value = acsUrl;
    form.appendChild(input3);

    document.body.appendChild(form);
    form.submit();
    document.body.removeChild(form);
}