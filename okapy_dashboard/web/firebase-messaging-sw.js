importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');
    // TODO: Add SDKs for Firebase products that you want to use
    // https://firebase.google.com/docs/web/setup#available-libraries

    // Your web app's Firebase configuration
    // For Firebase JS SDK v7.20.0 and later, measurementId is optional
    const firebaseConfig = {
        apiKey: "AIzaSyB1-nKsavivxzcQMfrpyC_W22IA5B7TC6E",
    authDomain: "okapy-ddf9a.firebaseapp.com",
    projectId: "okapy-ddf9a",
    storageBucket: "okapy-ddf9a.appspot.com",
    messagingSenderId: "142981564123",
    appId: "1:142981564123:web:8cbfa97e4a6331492d6efe",
    measurementId: "G-LT7519XKNF"
  };

    // Initialize Firebase
firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function (payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
        notificationOptions);
});