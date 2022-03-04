
function getXHR() {
    if (window.ActiveXObject) {
        return new ActivcXObject('Msxml2.XMLHTTP');
    } else if (window.XMLHttpRequest) {
        return new XMLHttpRequest();
    } else {
        return null;
    }
}

function alert_np(msg) {
    alert(msg);
    return false;
}

function CancelEnterKey() {

    var evt = (evt) ? evt : ((event) ? event : null);

    var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);

    if (evt.keyCode == 13) { return false; }
}

function sendRequest(url, param, method, callback) {

    XHR = getXHR();

    if (method) {
        new_method = method;
    } else {
        new_method = 'GET';
    }

    if (new_method != 'GET' && new_method != 'POST') {
        new_method = 'GET';
    }

    var new_param = (param == null || param == '') ? null : param;
    new_url = url;
    if (new_method == 'GET' && new_param != null) {
        new_url = new_url + '?' + new_param;
    }

    XHR.onreadystatechange = callback;
    XHR.open(new_method, new_url, true);
    XHR.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    XHR.send(new_method == 'POST' ? new_param : null);

}