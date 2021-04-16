importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyB3oEdhcmf18rBVs0hPuv4FxpONIYATFJ0",
    authDomain: "zakazio-56c70.firebaseapp.com",
    databaseURL: "https://zakazio-56c70.firebaseio.com",
    projectId: "zakazio-56c70",
    storageBucket: "zakazio-56c70.appspot.com",
    messagingSenderId: "548924249412",
    appId: "1:548924249412:web:273f60270282052670b311",
    measurementId: "G-9S1JZQW4CN"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});