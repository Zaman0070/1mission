import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/firebase_service.dart';

class HomeAds extends StatelessWidget {

  FirebaseService service = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<QuerySnapshot>(
      future: service.ads
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Please Login');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(strokeWidth: 2,value: 2,));
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.size,
            itemBuilder: (BuildContext context , int index){
              var data = snapshot.data.docs[index];
              final List<dynamic> imageList = data['image'];

              final List<Widget> imageSliders = imageList
                  .map((data) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  child: Image.network(
                    data,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext ctx, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (
                        BuildContext context,
                        Object exception,
                        StackTrace stackTrace,
                        ) {
                      return const Text(
                        'Oops!! An error occurred. 😢',
                        style: TextStyle(fontSize: 16.0),
                      );
                    },
                  ),
                ),
              ))
                  .toList();

              _launchURL() async {
                var url = data['url'];
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              }

              return   InkWell(
                onTap: (){
                  _launchURL();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  height: 18.h,

                  child: FlutterCarousel(
                      items: imageSliders,
                      options: CarouselOptions(
                        height: 400.0,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 2),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: false,
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        pauseAutoPlayOnTouch: true,
                        pauseAutoPlayOnManualNavigate: true,
                        pauseAutoPlayInFiniteScroll: false,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        disableCenter: false,
                        showIndicator: true,
                        // slideIndicator: CircularSlideIndicator(),
                      )),
                ),
              );
            }
        );
      },
    );
  }
}
