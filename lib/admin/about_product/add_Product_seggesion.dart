import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:marketplace_app/product_details.dart';
import 'package:marketplace_app/provider/cat_provider.dart';
import 'package:marketplace_app/provider/product_provider.dart';
import 'package:marketplace_app/services/firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductSeggesion extends StatefulWidget {
  @override
  _ProductSeggesionState createState() => _ProductSeggesionState();
}

class _ProductSeggesionState extends State<ProductSeggesion> {
  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CategoryProvider>(context);
    var provider = Provider.of<ProductProvider>(context);
    return Container(
      width: 100.w,
      //  color: Colors.white,
      child: FutureBuilder<QuerySnapshot>(
        future: service.products.orderBy('postedAt').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Some things wronge');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
                backgroundColor: Colors.grey[400],
              ),
            );
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: snapshot.data.size,
              itemBuilder: (BuildContext contexy, int index) {
                var data = snapshot.data.docs[index];
                return  ListTile(
                    onTap: () {
                      provider.getProductDetails(data);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ProductDetailScreen()));
                    },
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: 6.h,
                            width: 6.h,
                            child: Image.network(
                              data['image'][0],
                              fit: BoxFit.cover,
                            ))),
                    title: Text( data['brand']),
                    subtitle: Text( data['discretion'],overflow:TextOverflow.ellipsis ,),
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
                                              setState(() {

                                                deletePost(snapshot.data
                                                    .docs[index].id);
                                              });
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

                );
              });
        },
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
