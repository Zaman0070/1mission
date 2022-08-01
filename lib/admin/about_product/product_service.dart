import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/admin/about_product/add_Product_seggesion.dart';
import 'package:marketplace_app/product_list.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import 'package:sizer/sizer.dart';

import '../../product_details.dart';
import '../../provider/product_provider.dart';

class ProductSearch {
  final String title, description, category, price, brand, image;
  final num postDate;
  final DocumentSnapshot documentSnapshot;

  ProductSearch(
      {this.title,
        this.documentSnapshot,
        this.category,
        this.price,
        this.description,
        this.postDate,
        this.brand,
        this.image});
}

class ProductSearchService {
  search({context, productList, provider}) {
    var provider = Provider.of<ProductProvider>(context, listen: false);
    showSearch(
      context: context,
      delegate: SearchPage<ProductSearch>(
        onQueryUpdate: (s) => print(s),
        items: productList,
        searchLabel: 'Search Product',
        suggestion: ProductSeggesion(),
        failure: Center(
          child: Text('No Product found :('),
        ),
        filter: (product) => [
          product.title,
          product.description,
          product.category,
          product.brand
        ],
        builder: (product) => Column(
          children: [
            ListTile(
              onTap: () {
                provider.getProductDetails(product.documentSnapshot);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProductDetailScreen()));
              },
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      height: 6.h,
                      width: 6.h,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                      ))),
              title: Text(product.brand),
              subtitle: Text(product.title),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            height: 20.h,
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Are you sure?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    SizedBox(width: 5.w),
                                    ElevatedButton(
                                      onPressed: () {
                                       deletePost(product.documentSnapshot.id);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Delete'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: Icon(Icons.delete),
              )
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
  Future<void> deletePost(String postId) async {
    try {
      FirebaseFirestore.instance.collection('products').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

//17.30