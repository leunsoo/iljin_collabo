function setComma(sender) {
    var val = sender.value;
    val = val.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
    val = val.replaceAll(',', '');
    val = Number(val).toString();
    val = val.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    sender.value = val;
}
function removeComma(sender) {
    var val = sender.value;
    val = val.replaceAll(',', '');
    sender.value = val;
}
function setCommaStyle(sender) {

    setComma(sender);
    sender.setAttribute('onfocus', 'removeComma(this);')
    sender.setAttribute('onblur', 'setComma(this);');
}