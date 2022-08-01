import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace_app/provider/product_provider.dart';
import 'package:marketplace_app/services/firebase_service.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';

class DatabaseServices {



  static Future<int> followersNum(context) async {
    var product =Provider.of<ProductProvider>(context,listen: false);
    QuerySnapshot followersSnapshot =
        await followersRef.doc(product.productData['sellerUid']).collection('Followers').get();
    return followersSnapshot.docs.length;
  }

  static Future<int> followingNum(context) async {
    var product =Provider.of<ProductProvider>(context,listen: false);
    QuerySnapshot followingSnapshot =
        await followingRef.doc(product.productData['sellerUid']).collection('Following').get();
    return followingSnapshot.docs.length;
  }


  static void followUser(context) {
    FirebaseService service =FirebaseService();
    var product =Provider.of<ProductProvider>(context,listen: false);
    followingRef
        .doc(service.products.id)
        .collection('Following')
        .doc(service.user.uid)
        .set({});
    followersRef
        .doc(service.products.id)
        .collection('Follower')
        .doc(service.user.uid)
        .set({});

  // addActivity(currentUserId, null, true, visitedUserId);
  }

  static void unFollowUser(context) {
    FirebaseService service =FirebaseService();
    var product =Provider.of<ProductProvider>(context,listen: false);
    followingRef
        .doc(service.products.id)
        .collection('Following')
        .doc(service.user.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    followersRef
        .doc(service.products.id)
        .collection('Followers')
        .doc(service.user.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  static Future<bool> isFollowingUser(context) async {
    FirebaseService service =FirebaseService();
    var product =Provider.of<ProductProvider>(context,listen: false);

    DocumentSnapshot followingDoc = await followersRef
        .doc(service.products.id)
        .collection('Followers')
        .doc(service.user.uid)
        .get();
    return followingDoc.exists;
  }

}
