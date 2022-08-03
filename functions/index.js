const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { firestore, auth } = require("firebase-admin");
const { user } = require("firebase-functions/v1/auth");
const { event } = require("firebase-functions/v1/analytics");

const serviceAccount = require("./sdk.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://market-place-app-a3445-default-rtdb.firebaseio.com"
});
const database = admin.firestore();

exports.pushNotification = functions.firestore.document('messages/{messageId}/chats/{chatId}').onCreate(
   async (snapshot, context) => {
        const message = snapshot.data().message;
        const data = snapshot.data();

        const query =  await database
                  .collection("users")
                  .doc(data.receiverId)
                  .collection("tokens");

        var tokenList = [];

        //const tokens = query.docs.map((snap) => snap.id);
       const token =await query.get().then(function(querySnapshot) {
        querySnapshot.forEach(function(token) {
            tokenList.push(token.data()['token']);
        });
    });


        const payload = {
            notification: {
          title: '1Mission',
          body:  message,
      },
      data: {
        title: 'New Alert',
        body:  message,
      }
  };
  admin.messaging().sendToDevice(tokenList, payload).then((response) =>{
    console.log('Successfully sent message:', response);
     print('success');
  }).catch((error)=>{
    return console.log(error);
  });
    }
);