

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/admin/about_user/user_search_List.dart';
import 'package:marketplace_app/pages/other_user_%20perfolie_screen.dart';
import 'package:marketplace_app/provider/cat_provider.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import 'package:sizer/sizer.dart';

class Users {
  final String number, image,uid;
  final DocumentSnapshot documentSnapshot;

  Users(
      {
        this.uid,
        this.number,
        this.documentSnapshot,
        this.image});
}

class UserSearchService {
  search({context, userList, provider}) {
    var provider = Provider.of<CategoryProvider>(context, listen: false);
    showSearch(
      context: context,
      delegate: SearchPage<Users>(
        onQueryUpdate: (s) => print(s),
        items: userList,
        searchLabel: 'Search Users',
        suggestion: UserSearchList(),
        failure: Center(
          child: Text('No Product found :('),
        ),
        filter: (user) => [
          user.number,
          user.uid
        ],
        builder: (user) => Column(
          children: [
            ListTile(
              onTap: () {
                provider.userGetData(user.documentSnapshot);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => OtherUserProfile()));
              },
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      height: 6.h,
                      width: 6.h,
                      child: Image.network(
                        user.image,
                        fit: BoxFit.cover,
                      ))),
              title: Text(user.number),
              subtitle: Text(user.uid),
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
                                        deleteUser(user.documentSnapshot.id);
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
  Future<void> deleteUser(String userId) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(userId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

//17.30