

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../services/firebase_service.dart';

class CategoryProvider with ChangeNotifier {
  FirebaseService service = FirebaseService();

  DocumentSnapshot doc;
  DocumentSnapshot userDetails;
  String selectedCategory;
  // String selectedSubCategory;
  DocumentSnapshot sellerDetails;

  List<String> urlList = [];
  String urls;
  Map<String, dynamic> dataToFireStore = {};

  List<String> profile = [];
  Map<String, dynamic> person = {};

  getCategory(selectedCat) {
    selectedCategory = selectedCat;
    notifyListeners();
  }


  ///
  userGetData(details) {
    userDetails = details;
    notifyListeners();
  }



  getCatSnapshot(snapshot) {
    this.doc = snapshot;
    notifyListeners();
  }

  getImage( url) {
    urlList.add(url);
    notifyListeners();
  }
  singleGetImage(url) {
    url.add(url);
    notifyListeners();
  }

  getData(data) {
    dataToFireStore = data;
    notifyListeners();
  }

  getUserDetail() {
    service.getUserData().then((value) {
      userDetails = value;
      notifyListeners();
    });
  }

  getSellerDetails(details) {
    sellerDetails = details;
    notifyListeners();
  }

  clearData() {
    urlList = [];
    dataToFireStore = {};
    notifyListeners();
  }
  urlListClear(){
    urlList.clear();
    notifyListeners();
  }
}
