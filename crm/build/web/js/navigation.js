function getCurrentUrl() {
    // здесь получаем объект URL, а не строку!
    return new URL(window.location.href);
}

function currentPath() {
    const path = getCurrentUrl().pathname;
    return path.substr(1, path.length);
}

function currentSearch() {
    return getCurrentUrl().search;
}

function getQueryParams() {
    // здесь получаем массив с query-параметрами из объекта который получили вверху
    return new URLSearchParams(getCurrentUrl().search).toString().split('&').map(item => {
            const subItems = item.split('=');
            return {key: subItems[0], value: subItems[1]}
        }
    );
}

function changeUrl(path) {
    // здесь меняем новый адрес
    window.history.pushState(null, null,  path);
}