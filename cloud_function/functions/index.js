const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

exports.pushNotification = functions.firestore
    .document("events/{eventDocID}")
    .onWrite((event) => {
      console.log("Push notification event triggered");
      const valueObject = event.data.val();
      const payload = {
        notification: {
          title: valueObject.eventName,
          body: "Happening in " + valueObject.eventLocation,
          sound: "default",
        },
      };
      const options = {
        priority: "high",
        timeToLive: 60 * 60 * 24,
      };
      return admin.messaging()
          .sendToTopic("pushNotifications", payload, options);
    });
