const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.myFunction = functions.firestore
  .document('chat/{message}')
  .onCreate((snapshot, context) => { 

    return admin.messaging().sendToTopic('chat', {
      notification: {
        title: snapshot.data().userName,
        body: snapshot.data().text
      }
    });

    // const token = 'cD-HuodJSA2euNsRggTrsi:APA91bE2iJWKz1hBIyeXhO6nQSXuqXM8TKmtVdc5zXs9kz4jrKaARDCtvDIrg676L6k7GxeJzBicX1NksuZD-ghsfkYHHQDGnF2csq8cpj66huODTj5JRrqNyFIeJVb1Y-dvqx0tLSDs';
    // return admin.messaging().sendToDevice(token, {
    //   notification: {
    //     title: snapshot.data().userName,
    //     body: snapshot.data().text
    //   }
    // });
  });