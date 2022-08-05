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
        title: '1Mission',
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




exports.followerNotification = functions.firestore.document('users/{userId}').onUpdate(
  async (change,context)=> {

    const userData = change.after.data();
    const followinId = userData.followers[userData.followers.length-1];

// send notification
    const query =  await database
    .collection("users")
    .doc(userData.uid)
    .collection("tokens");

var gettokenList = [];

//const tokens = query.docs.map((snap) => snap.id);
const token =await query.get().then(function(querySnapshot) {
querySnapshot.forEach(function(token) {
gettokenList.push(token.data()['token']);
});
});


 const detailsFollowingUser =  await database
    .collection("users")
    .doc(followinId);

 var followingUserNumber = [];

const number =await detailsFollowingUser.get().then(function(querySnapshot) {
  followingUserNumber.push(querySnapshot.data()['mobile']);
 
  });

       const payload = {
                notification: {
                title:`Started following you : ${followingUserNumber}`
               
      },
           data: {
              title: `Started following you : ${followingUserNumber}`
            
      }
  };

  admin.messaging().sendToDevice(gettokenList, payload).then((response) =>{
    console.log('Successfully sent message:', response);
     print('success');
  }).catch((error)=>{
    return console.log(error);
  });


  }
);


exports.likeNotification = functions.firestore.document('products/{productId}').onUpdate(
  async (change,context)=> {

    const productData = change.after.data();
    const likeId = productData.likes[productData.likes.length-1];

// send notification
    const query =  await database
    .collection("users")
    .doc(productData.sellerUid)
    .collection("tokens");

var gettokenList = [];

const token =await query.get().then(function(querySnapshot) {
querySnapshot.forEach(function(token) {
gettokenList.push(token.data()['token']);
});
});


 const detailsLike =  await database
    .collection("users")
    .doc(likeId);

 var likeNumber = [];

const number =await detailsLike.get().then(function(querySnapshot) {
  likeNumber.push(querySnapshot.data()['mobile']);
  });

       const payload = {
                notification: {
                title:`Started like you : ${likeNumber}`
               
      },
           data: {
              title: `Started like you : ${likeNumber}`
            
      }
  };

  admin.messaging().sendToDevice(gettokenList, payload).then((response) =>{
    console.log('Successfully sent message:', response);
     print('success');
  }).catch((error)=>{
    return console.log(error);
  });


  }
);

exports.faviourtNotification = functions.firestore.document('products/{productId}').onUpdate(
  async (change,context)=> {

    const productData = change.after.data();
    const faviouratId = productData.follower[productData.follower.length-1];

// send notification
    const query =  await database
    .collection("users")
    .doc(productData.sellerUid)
    .collection("tokens");

var gettokenList = [];

const token =await query.get().then(function(querySnapshot) {
querySnapshot.forEach(function(token) {
gettokenList.push(token.data()['token']);
});
});


 const detailsLike =  await database
    .collection("users")
    .doc(faviouratId);

 var likeNumber = [];

const number =await detailsLike.get().then(function(querySnapshot) {
  likeNumber.push(querySnapshot.data()['mobile']);
  });

       const payload = {
                notification: {
                title:`Started like you : ${likeNumber}`
               
      },
           data: {
              title: `Started like you : ${likeNumber}`
            
      }
  };

  admin.messaging().sendToDevice(gettokenList, payload).then((response) =>{
    console.log('Successfully sent message:', response);
     print('success');
  }).catch((error)=>{
    return console.log(error);
  });


  }
);




exports.comment = functions.firestore.document('products/{productId}/comments/{commentId}').onCreate(
  async (snapshot, context) => {
       const comments = snapshot.data().comment;
       const data = snapshot.data();

       const query =  await database
                 .collection("users")
                 .doc(data.sellerUid)
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
         body: `${data.name} comment on your ads : ${comments}`
     },
     data: {
      title: '1Mission',
      body: `${data.name} comment on your ads : ${comments}`
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










exports.publishAddNotification = functions.firestore.document('products/{productId}').onCreate(
  async (snapshot,context)=> {

    const productData = snapshot.data();
    const detailsLike =  await database
    .collection("users")
    .doc(productData.sellerUid);

 const followerIds = [];

const followerUid = await detailsLike.get().then(function(querySnapshot) {
  followerIds.push(querySnapshot.data()['followers']);
  //followerIds = querySnapshot.data()['followers'];
  });

  console.info(followerIds);


  for (const followerId of followerIds) {
    const query =   database
    .collection("users")
    .doc(followerId)
    .collection("tokens").then((query) =>  {
      return query
    });
    const gettokenList = [];


const token = await query.get().then(function(querySnapshot) {
  querySnapshot.forEach(function(token) {
  gettokenList.push(token.data()['token']);
  });
  });


  }








// publisherNo=[];

// const publisher = await detailsLike.get().then(function(querySnapshot) {
//   publisherNo.push(querySnapshot.data()['mobile']);
//   });




       const payload = {
                notification: {
                title:`Publish New Add : `

      },
           data: {
              title: `publish  add : `

      }
  };
  console.info(gettokenList, payload);

  admin.messaging().sendToDevice(gettokenList, payload).then((response) =>{
    console.log('Successfully sent message:', response);
     print('success');
  }).catch((error)=>{
    return console.log(error);
  });


  }
);







