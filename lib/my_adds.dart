import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:marketplace_app/product_details.dart';
import 'package:marketplace_app/provider/cat_provider.dart';
import 'package:marketplace_app/provider/product_provider.dart';
import 'package:marketplace_app/services/firebase_service.dart';
import 'package:marketplace_app/widget/add_images.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

class MyAdds extends StatefulWidget {
  @override
  _MyAddsState createState() => _MyAddsState();
}

class _MyAddsState extends State<MyAdds> {
  bool loading = false;
  var titleController = TextEditingController();
  var disController = TextEditingController();
  var brandController = TextEditingController();
  var priceController = TextEditingController();
  var conditionController = TextEditingController();
  var areaController = TextEditingController();
  var guarntController = TextEditingController();
  var addTypeController = TextEditingController();
  var colorController = TextEditingController();
  var nameController = TextEditingController();

  /// for car & bick
  TextEditingController fuelController = TextEditingController();
  TextEditingController transmissionController = TextEditingController();

  /// for mobile
  TextEditingController simController = TextEditingController();
  TextEditingController cameraController = TextEditingController();
  TextEditingController storageController = TextEditingController();
  TextEditingController imageController= TextEditingController();

  int view = 0;
  bool isFollowing = false;


 CollectionReference reference = FirebaseFirestore.instance.collection('products');

 _buildTextField(TextEditingController controller ){
   return Container(

     padding: EdgeInsets.symmetric(horizontal: 10,),
     decoration: BoxDecoration(
       color: Colors.white.withOpacity(0.3),
       borderRadius: BorderRadius.circular(10),
     ),
     child: TextField(
       controller: controller,
       decoration: InputDecoration(
         contentPadding: EdgeInsets.symmetric(horizontal: 13),
         border: InputBorder.none,
       ),
     ),
   );
 }
  buildTextField(TextEditingController controller ,String text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: TextStyle(fontSize: 16.sp),),
        SizedBox(height: 0.5.h,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 13),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }




  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CategoryProvider>(context);


    FirebaseService service = FirebaseService();

    var provider = Provider.of<ProductProvider>(context, listen: false);

    return Container(
      width: 100.w,
      //  color: Colors.white,
      child: FutureBuilder<QuerySnapshot>(
        future: service.products
            .where('sellerUid', isEqualTo: service.user.uid)
            .orderBy('postedAt')
            .get(),
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
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await service
                            .postView(
                          FirebaseAuth.instance.currentUser.uid,
                          context,
                        );
                        setState(() {
                          isFollowing = true;
                          view++;
                        });
                        provider.getProductDetails(data);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProductDetailScreen()));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 4.w,
                          ),
                          Container(
                            height: 12.h,
                            width: 12.h,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  data['image'][0],
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Container(
                              height: 13.h,
                              width: 21.h,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(data['brand'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(data['discretion'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10.sp)),
                                  Text('${data['price']} QAR'),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                titleController.text = data['title'];
                                brandController.text = data['brand'];
                                disController.text = data['discretion'];
                                priceController.text = data['price'];
                                conditionController.text = data['condition'];
                                areaController.text = data ['area'];

                                colorController.text = data['color'];
                                nameController.text = data ['name'];
                                guarntController.text =data['guarantee'];
                                addTypeController.text = data['adsType'];
                               // imageController.text = data['image'];

                                if (data['category'] == 'Cars' ||  data['category'] == 'Motorcycles') {
                                  fuelController.text = data ['fuel'];
                                  transmissionController.text = data['transmission'];
                                }


                                if (data['category'] == 'Mobiles'){
                                  simController.text= data['sim'];
                                  storageController.text = data['storage'];
                                  cameraController.text= data['camera'];
                                }
                                showMaterialModalBottomSheet(
                                  backgroundColor:Color(0xff8E7FC0),
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                        child: ListView(
                                          children: [
                                            SizedBox(height: 2.h,),
                                            Center(child: Text('Update Product Details',
                                              style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold),

                                            )),
                                            SizedBox(height: 3.h,),
                                            Text('Title',style: TextStyle(fontSize: 16.sp),),
                                            SizedBox(height: 0.5.h,),
                                            _buildTextField(titleController,),
                                            SizedBox(height: 1.h,),
                                            Text('Model',style: TextStyle(fontSize: 16.sp),),
                                            SizedBox(height: 0.5.h,),
                                            _buildTextField(brandController,),
                                            SizedBox(height: 1.h,),
                                            Text('Description',style: TextStyle(fontSize: 16.sp),),
                                            SizedBox(height: 0.5.h,),
                                            _buildTextField(disController, ),
                                            SizedBox(height: 1.h,),
                                            Text('price',style: TextStyle(fontSize: 16.sp),),
                                            SizedBox(height: 0.5.h,),
                                            _buildTextField(priceController, ),
                                            SizedBox(height: 1.h,),
                                            Text('Condition',style: TextStyle(fontSize: 16.sp),),
                                            SizedBox(height: 0.5.h,),
                                            _buildTextField(conditionController, ),
                                            SizedBox(height: 1.h,),
                                            Text('Area',style: TextStyle(fontSize: 16.sp),),
                                            SizedBox(height: 0.5.h,),
                                            _buildTextField(areaController, ),
                                            SizedBox(height: 1.h,),
                                            Text('Color',style: TextStyle(fontSize: 16.sp),),
                                            SizedBox(height: 0.5.h,),
                                            _buildTextField(colorController, ),
                                            SizedBox(height: 1.h,),
                                            Text('Name',style: TextStyle(fontSize: 16.sp),),
                                            SizedBox(height: 0.5.h,),
                                            _buildTextField(nameController, ),
                                            SizedBox(height: 1.h,),
                                            Text('Guarantee',style: TextStyle(fontSize: 16.sp),),
                                            SizedBox(height: 0.5.h,),
                                            _buildTextField(guarntController, ),
                                            SizedBox(height: 1.h,),
                                              buildTextField(addTypeController, 'Add type'),
                                            SizedBox(height: 1.h,),
                                            if (data['category'] == 'Cars' ||  data['category'] == 'Motorcycles')
                                              buildTextField(fuelController, 'Fuel'),
                                            SizedBox(height: 1.h,),
                                            if (data['category'] == 'Cars' ||  data['category'] == 'Motorcycles')
                                              buildTextField(transmissionController, 'Transmission'),
                                            SizedBox(height: 1.h,),


                                            if (data['category'] == 'Mobiles' )
                                              buildTextField(storageController, 'Storage'),
                                            SizedBox(height: 1.h,),
                                            if (data['category'] == 'Mobiles' )
                                              buildTextField(simController, 'Sim'),
                                            SizedBox(height: 1.h,),
                                            if (data['category'] == 'Mobiles' )
                                              buildTextField(cameraController, 'Camera'),
                                            SizedBox(height: 1.h,),

                                            Container(
                                                height: 12.h,
                                                child: AddImage()
                                            ),


                                            SizedBox(height: 1.h,),
                                            TextButton(
                                              onPressed: (){
                                                snapshot.data.docs[index].reference.update(
                                                    {
                                                      'discretion' : disController.text,
                                                      'title' :titleController.text,
                                                      'brand' : brandController.text,
                                                      'price': priceController.text,
                                                      'condition':conditionController.text,
                                                      'area' : areaController.text,
                                                      'adsType': addTypeController.text,
                                                      'guarantee':guarntController.text,
                                                      'name' : nameController.text,
                                                      'color' : colorController.text,
                                                      if (data['category'] == 'Cars' ||  data['category'] == 'Motorcycles')
                                                      'transmission':transmissionController.text,
                                                      'fuel': fuelController.text,

                                                      if(catProvider.urlList.isNotEmpty)
                                                        'image' : catProvider.urlList,


                                                      if (data['category'] == 'Mobiles' )
                                                      'camera' : cameraController.text,
                                                      'sim': simController.text,
                                                      'storage' : storageController.text,

                                                    }).whenComplete(() {
                                                  setState(() {

                                                    Navigator.pop(context);
                                                  });
                                                }
                                                );
                                              },

                                              child: Text('Update',style: TextStyle(color: Theme.of(context).primaryColor),),
                                              style: TextButton.styleFrom(
                                                  backgroundColor: Theme.of(context).splashColor
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                );
                              },
                              child: Container(
                                height: 3.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.white)),
                                child: Center(child: Text('Edit')),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1.5.h,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
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
                              child: Container(
                                height: 3.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.white)),
                                child: Center(
                                  child: Text('Delete'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1.5.h,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Share.share('https://pub.dev/packages/share');
                              },
                              child: Container(
                                height: 3.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Center(
                                  child: Text('Share'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Divider(
                      thickness: 0.2.h,
                      height: 0.3.h,
                      color: Theme.of(context).primaryColor == Colors.white
                          ? Color(0xffF0F0F0)
                          : Color(0xffF0F0F0),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
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
