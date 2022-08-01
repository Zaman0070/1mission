import 'dart:io';
import 'dart:math';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:marketplace_app/my_adds.dart';
import 'package:marketplace_app/provider/cat_provider.dart';
import 'package:marketplace_app/widget/favi.dart';
import 'package:marketplace_app/widget/follower_screen.dart';
import 'package:marketplace_app/widget/following.dart';
import 'package:marketplace_app/widget/likes.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';
import '../provider/product_provider.dart';
import '../services/firebase_service.dart';
import '../services/phone_service.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {

  bool loading = false;

  Future<void> updateUser(provider, Map<String, dynamic> data, context) {
    return service.users.doc(service.user.uid).update(data).then((value) {
      // saveProductToDb(provider,context);
      Navigator.pop(context);
      //Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update location'),
        ),
      );
    });
  }

  var nameController = TextEditingController();
  var countryCodeController = TextEditingController(text: '+92');
  var phoneController = TextEditingController(text: '92');
  var detailController = TextEditingController();
  FirebaseService service = FirebaseService();
  TabController controller;

  final ImagePicker _picker = ImagePicker();
  bool uploading = false;
  final picker = ImagePicker();





  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
    //bottomSheet();
  }

  PhoneService auth = PhoneService();
  bool dataIsThere = false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryProvider>(context,listen: false);
   // var productData = provider.productData;
    convertToAgo(DateTime input) {
      Duration diff = DateTime.now().difference(input);

      if (diff.inDays >= 1) {
        return '${diff.inDays} d(s) ago';
      } else if (diff.inHours >= 1) {
        return '${diff.inHours} h(s) ago';
      } else if (diff.inMinutes >= 1) {
        return '${diff.inMinutes} m(s) ago';
      } else if (diff.inSeconds >= 1) {
        return '${diff.inSeconds} s(s) ago';
      } else {
        return 'just now';
      }
    }
    Widget commentData(){
      return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('products').doc().collection('comments').orderBy('time').snapshots(),
            builder: ( context,snapshot ){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else{
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data.size,
                    itemBuilder:  (BuildContext context, int index){
                      var comment = snapshot.data.docs[index];
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 3.w),
                        child: Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 3.w,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(comment['name'],style: TextStyle(fontSize: 14.sp),),
                                        SizedBox(height: 1.h,),
                                        Text(convertToAgo(DateTime.fromMicrosecondsSinceEpoch(comment['time'])),
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    SizedBox(width: 5.w,),
                                    Text(comment['comment'],style: TextStyle(fontSize: 14.sp),),

                                  ],
                                ),
                                PopupMenuButton(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Text("Delete"),
                                      value: 1,
                                      onTap: (){

                                      },
                                    ),
                                  ],
                                  icon: Icon(Icons.more_vert_outlined),
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    }
                );


              }
            }
        ),
      );
    }

    var catProvider = Provider.of<CategoryProvider>(context);
    Color circleColor = Theme.of(context).primaryColor == Colors.white
        ? Color(0xff38205A)
        : Color(0xff8E7FC0);
    Color backgroundColor = Theme.of(context).backgroundColor;
    ProgressDialog progressDialog = ProgressDialog(
      context: context,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      loadingText: 'Please wait',
      progressIndicatorColor: Theme.of(context).primaryColor,
    );

    void showConfirmDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: FutureBuilder<DocumentSnapshot>(
                future: service.getUserData(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.data == null) {
                    return CircleAvatar();
                  }
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.hasData && !snapshot.data.exists) {
                    return Text('Document does not exist');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor),
                    ));
                  }
                  detailController.text = snapshot.data['description'];
                  nameController.text = snapshot.data['name'];
                  phoneController.text = snapshot.data['mobile'];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            translate('content'),
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            decoration: InputDecoration(
                                labelText: translate('mobnum'),
                                helperText: translate('mobdet')),
                            maxLength: 13,
                            validator: (value) {
                              if (value.isEmpty) {
                                return translate('mobdet');
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            decoration:
                                InputDecoration(helperText: 'Enter your name'),
                            maxLength: 10,
                            validator: (value) {
                              if (value.isEmpty) {
                                return translate('mobdet');
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: detailController,
                            decoration: InputDecoration(
                                helperText: 'Enter your 2 line discription'),
                            maxLength: 75,
                            validator: (value) {
                              if (value.isEmpty) {
                                return translate('mobdet');
                              }
                              return null;
                            },
                          ),
                          MaterialButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {

                                updateUser(
                                        catProvider,
                                        {
                                          'mobile': phoneController.text,
                                          'description': detailController.text,
                                          'name': nameController.text,
                                        },
                                        context)
                                    .then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                });
                              },
                            child: Text(
                              translate('confirm'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          });
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(

              height: 39.5.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: Theme.of(context).backgroundColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Container(
                        height: 26.h,
                        width: 100.h,
                        child: FutureBuilder<DocumentSnapshot>(
                            future: service.getUserData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.data == null) {
                                return Container();
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).primaryColor),
                                ));
                              }
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    snapshot.data['name'],
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 3.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            provider.userGetData(snapshot.data);
                                            Navigator.push(context, MaterialPageRoute(builder: (_)=>FollowersScreen()));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                translate('followers'),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 0.7.h,
                                              ),
                                              Text(
                                               '${ snapshot.data['followers'].length}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 36,
                                          backgroundColor: Colors.white,
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 33,
                                                backgroundImage:
                                                NetworkImage(
                                                     snapshot.data['imageUrl']

                                                ),
                                              ),
                                              Positioned(
                                                bottom: -5,
                                                right: -15,
                                                child: IconButton(
                                                    onPressed: () {
                                                      bottomSheet();
                                                    },
                                                    icon: Icon(
                                                      Icons.add_a_photo,
                                                      size: 20,
                                                      color: Colors
                                                          .cyanAccent.shade100,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            provider.userGetData(snapshot.data);
                                            Navigator.push(context, MaterialPageRoute(builder: (_)=>FollowingScreen()));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                translate('following'),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 0.7.h,
                                              ),
                                              Text(
                                              '${snapshot.data['following'].length}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    snapshot.data['uid'],
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    snapshot.data['mobile'],
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(snapshot.data['description'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ))
                                ],
                              );
                            }),
                      ),
                    ),
                    SizedBox(height: 1,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            splashColor: Color(0xff8E7FC0),
                            onTap: () {
                              Share.share('https://pub.dev/packages/share');
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.share,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 1.h,
                                ),
                                Text(
                                  translate('share'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            splashColor: Color(0xff8E7FC0),
                            onTap: () {
                              showConfirmDialog();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 1.h,
                                ),
                                Text(
                                  translate('edit'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      indicatorColor: Theme.of(context).splashColor,
                      labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
                      controller: controller,
                      tabs: [
                        Tab(
                          text: translate('active'),
                          icon: Image.asset(
                            'assets/icons/tasks.png',
                            height: 2.5.h,
                            color: Colors.grey[200],
                          ),
                        ),
                        Tab(
                          text: translate('favourite'),
                          icon: Image.asset(
                            'assets/icons/love.png',
                            height: 2.5.h,
                            color: Colors.grey[200],
                          ),
                        ),
                        Tab(
                          text: translate('comment'),
                          icon: Image.asset(
                            'assets/icons/comment.png',
                            height: 2.5.h,
                            color: Colors.grey[200],
                          ),
                        ),
                        Tab(
                          text: translate('like'),
                          icon: Image.asset(
                            'assets/icons/like.png',
                            height: 2.5.h,
                            color: Colors.grey[200],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  MyAdds(),
                  Fav(),
                commentData(),
                 Likes(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget bottomSheet(){
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: const Text('Camera'),
          onPressed:  (BuildContext context)  {
           setState(() {
             getImage(ImageSource.camera).whenComplete((){
             }
             );
           });
            Navigator.pop(context);
          },
        ),
        BottomSheetAction(
          title: const Text('Gallery'), onPressed: (BuildContext context)    {
        setState(() {
        getImage(ImageSource.gallery);
        });
        Navigator.pop(context);
        },

        ),
      ],
      cancelAction: CancelAction(title: const Text('Cancel')),
    );
  }






  Future getImage(ImageSource source) async {
    // Get image from gallery.
    var image = await picker.pickImage(source: source);
    setState(() {
       _uploadImageToFirebase(File(image.path));
    });
  }

  Future<void> _uploadImageToFirebase(File image) async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation = 'images/image$randomNumber.jpg';

      // Upload image to firebase.
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(imageLocation);
      final UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask;
      setState(() {
        _addPathToDatabase(imageLocation);
      });
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> _addPathToDatabase(String text) async {
    try {
      // Get image URL from firebase
      final ref = FirebaseStorage.instance.ref().child(text);
      var imageString = await ref.getDownloadURL();

      // Add location and url to database
      await FirebaseFirestore.instance
          .collection('users')
          .doc(service.user.uid)
          .update({
        'imageUrl': imageString,
      });
    } catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          });
    }
  }
  Future<void> deleteComment(String commentId,String postId) async {
    try {
      FirebaseFirestore.instance.collection('products').doc(postId).collection('comments').doc(commentId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

class Record {
  final String url;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['location'] != null),
        assert(map['url'] != null),
        url = map['url'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<:$url>";
}
