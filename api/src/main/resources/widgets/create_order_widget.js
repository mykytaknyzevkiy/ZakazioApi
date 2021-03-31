const appKey = "{{APP_KEY}}";

document.addEventListener('DOMContentLoaded', function() {
    initZakazy();
});

function outsideClick(event, notelem)	{
    // check outside click for multiple elements
    let clickedOut = true, i, len = notelem.length;
    for (i = 0;i < len;i++)  {
        if (event.target === notelem[i] || notelem[i].contains(event.target)) {
            clickedOut = false;
        }
    }
    if (clickedOut) return true;
    else return false;
}

function initZakazy() {
    const styles = ".modal {\n" +
        "    display: none;\n" +
        "    height: 100vh;\n" +
        "    width: 100%;\n" +
        "    background-color: rgba(25, 25, 25, 0.89);\n" +
        "    top: 0;\n" +
        "    left: 0;\n" +
        "    position: fixed;\n" +
        "}\n" +
        ".modal_active {\n" +
        "    display: flex;\n" +
        "    align-items: center;\n" +
        "    justify-content: center;\n" +
        "}\n" +
        ".modal__content {\n" +
        "    background-color: #fff;\n" +
        "    max-height: calc(100vh - 100px);\n" +
        "    max-width: calc(100vw - 100px);\n" +
        "    border-radius: 10px;\n" +
        "    overflow: hidden;\n" +
        "}\n" +
        ".modal__close {\n" +
        "    background-image: url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' x='0px' y='0px'%0Awidth='90' height='90'%0AviewBox='0 0 172 172'%0Astyle=' fill:%23000000;'%3E%3Cg fill='none' fill-rule='nonzero' stroke='none' stroke-width='1' stroke-linecap='butt' stroke-linejoin='miter' stroke-miterlimit='10' stroke-dasharray='' stroke-dashoffset='0' font-family='none' font-weight='none' font-size='none' text-anchor='none' style='mix-blend-mode: normal'%3E%3Cpath d='M0,172v-172h172v172z' fill='none'%3E%3C/path%3E%3Cg fill='%23ffffff'%3E%3Cpath d='M86,17.2c-37.9948,0 -68.8,30.8052 -68.8,68.8c0,37.9948 30.8052,68.8 68.8,68.8c37.9948,0 68.8,-30.8052 68.8,-68.8c0,-37.9948 -30.8052,-68.8 -68.8,-68.8zM112.9868,104.87987c2.24173,2.24173 2.24173,5.8652 0,8.10693c-1.118,1.118 -2.58573,1.67987 -4.05347,1.67987c-1.46773,0 -2.93547,-0.56187 -4.05347,-1.67987l-18.87987,-18.87987l-18.87987,18.87987c-1.118,1.118 -2.58573,1.67987 -4.05347,1.67987c-1.46773,0 -2.93547,-0.56187 -4.05347,-1.67987c-2.24173,-2.24173 -2.24173,-5.8652 0,-8.10693l18.87987,-18.87987l-18.87987,-18.87987c-2.24173,-2.24173 -2.24173,-5.8652 0,-8.10693c2.24173,-2.24173 5.8652,-2.24173 8.10693,0l18.87987,18.87987l18.87987,-18.87987c2.24173,-2.24173 5.8652,-2.24173 8.10693,0c2.24173,2.24173 2.24173,5.8652 0,8.10693l-18.87987,18.87987z'%3E%3C/path%3E%3C/g%3E%3C/g%3E%3C/svg%3E\");\n" +
        "    height: 30px;\n" +
        "    width: 30px;\n" +
        "    border: none;\n" +
        "    background-color: transparent;\n" +
        "    cursor: pointer;\n" +
        "    top: 20px;\n" +
        "    right: 20px;\n" +
        "    position: absolute;\n" +
        "    background-size: contain;\n" +
        "}\n" +
        ".modal__iframe,\n" +
        ".modal iframe {\n" +
        "    width: 100vw;\n" +
        "    height: 100vh;\n" +
        "    max-height: calc(100vh - 100px);\n" +
        "    max-width: 1200px;\n" +
        "}";

    const styleSheet = document.createElement("style")
    styleSheet.type = "text/css"
    styleSheet.innerText = styles
    document.head.appendChild(styleSheet)

    const modalBlock = document.createElement("div");
    modalBlock.className = "modal";

    const deactivatorBtn = document.createElement("button");
    deactivatorBtn.className = "modal__close";

    const contentBlock = document.createElement("div");
    contentBlock.className = "modal__content";

    const iframeBlock = document.createElement("iframe");
    iframeBlock.className = "modal__iframe";
    iframeBlock.src = "https://sdk.zakazy.online/order?key="+appKey;
    iframeBlock.frameBorder = "0";

    contentBlock.appendChild(iframeBlock);

    modalBlock.appendChild(deactivatorBtn);
    modalBlock.appendChild(contentBlock);

    deactivatorBtn.addEventListener('click', () => {
        modalBlock.classList.remove('modal_active')
    });

    document.addEventListener('keyup', (e) => {
        if (e.code === 'Escape' && modalBlock.classList.contains('modal_active')) {
            modalBlock.classList.remove('modal_active')
        }
    });

    modalBlock.addEventListener('click', function(e) {
        if (outsideClick(e, modalContent) && modalBlock.classList.contains('modal_active')) {
            modalBlock.classList.remove('modal_active')
        }
    });

    document.body.appendChild(modalBlock);

    //widgetModalInit('modal', 'activator', 'modal__close');
}

function openZakazyOrder() {
    const modalBlock = document.querySelector(`.modal`);
    modalBlock.classList.add('modal_active')
}