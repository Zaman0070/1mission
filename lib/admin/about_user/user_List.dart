import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:marketplace_app/admin/about_user/search_users.dart';
import 'package:marketplace_app/provider/cat_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../pages/other_user_ perfolie_screen.dart';
import '../../services/firebase_service.dart';

class UserList extends StatefulWidget {

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  UserSearchService userSearchService = UserSearchService();
  FirebaseService service = FirebaseService();
  static List<Users> users = [];

  @override
  void initState() {
    service.users.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          users.add(
            Users(
                documentSnapshot: doc,
                uid: doc['uid'],
                number: doc['mobile'],
                image: doc['imageUrl']),
          );
        });
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryProvider>(context, listen: false);
    bool check = Theme.of(context).primaryColor == Colors.white ? true : false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text('All User'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        width: 100.w,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 6.h,
                //alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.w),
                    color: Color(0xffCCC6DA),
                    boxShadow: [
                      BoxShadow(
                        color: check ? Colors.grey : Colors.transparent,
                        blurRadius: 10.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: Offset(
                          0.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ]),
                child: InkWell(
                  splashColor: Color(0xff8E7FC0),
                  onTap: () {
                    setState(() {
                      userSearchService.search(context: context, userList: users,);
                    });
                  },
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      enabled: false,
                      hintText:'search users',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: service.users.orderBy('uid').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Some things wronge');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
                      child: Center(child: CircularProgressIndicator())
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data.size,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  ListTile(
                          onTap: () {
                            provider.userGetData(data);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => OtherUserProfile()));
                          },
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  height: 6.h,
                                  width: 6.h,
                                  child: Image.network(
                                    data['imageUrl'],
                                    fit: BoxFit.cover,
                                  ))),
                          title: Text( data['mobile']),
                          subtitle: Text( data['uid']),
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
                                                      deleteUser(snapshot.data
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

                        ),
                      );
                    });
              },
            ),
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
