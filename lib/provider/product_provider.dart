import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductProvider with ChangeNotifier {

  DocumentSnapshot productData;
  DocumentSnapshot sellerDetails;

  List<String> urlList = [];

  getImage(url) {
    urlList.add(url);
    notifyListeners();
  }

  getProductDetails(details) {
    productData = details;
    notifyListeners();
  }

  getSellerDetails(details) {
    sellerDetails = details;
    notifyListeners();
  }
}
