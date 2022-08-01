import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;


import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:location/location.dart';
import 'package:marketplace_app/pages/city.dart';
import 'package:marketplace_app/pages/city_screen.dart';
import 'package:marketplace_app/pages/main_screen.dart';

import '../services/firebase_service.dart';

class LocationScreen extends StatefulWidget {
  static const String id = 'location-screen';

  final String popScreen;
  LocationScreen({this.popScreen});


  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  FirebaseService service = FirebaseService();


  bool loading = true;
  Location location = Location();


  String address= '';


  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String manualAddress;

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;




  Future<LocationData> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    List<geo.Placemark> placemarks =  await geo.placemarkFromCoordinates(_locationData.latitude, _locationData.longitude);
    setState(() {
      geo.Placemark  place= placemarks[0];
      address = '${place.street},${place.locality},${place.subLocality},${place.country}';
      countryValue = place.country;
    });





    return _locationData;
  }




  @override
  Widget build(BuildContext context) {

    /// fetching location from firestore

    if(widget.popScreen == null){
      service.users.doc(service.user.uid)
          .get().then((DocumentSnapshot document) {
        if(document.exists){
          if(document['address']!=null){
            if(mounted){
              setState(() {
                loading = false;
              });
             // Navigator.push(context, MaterialPageRoute(builder: (_)=>CityScreen()));
            }

          }else{
            setState(() {
              loading = true;
            });
          }

        }
      });
    }
    else{
      setState(() {
        loading = false;
      });
    }




    ///////////////////////////////////////////////////////////////////
    //progress dialog show

    ProgressDialog progressDialog  = ProgressDialog(
      context: context,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      loadingText: 'Fetching loading...',
      progressIndicatorColor: Theme.of(context).primaryColor,
    );
    ///////////////////////////////////////////////////////////////

    //Show bottom Screen to set location manually /////////////////

    showBottomScreen(context) {
      getLocation().then((value) {

        if (location != null) {
          progressDialog.dismiss();
          showModalBottomSheet(
              isScrollControlled: true,
              enableDrag: true,
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    AppBar(
                      automaticallyImplyLeading: false,
                      iconTheme: IconThemeData(color: Colors.black),
                      elevation: 1,
                      backgroundColor: Colors.white,
                      title: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.clear),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Location',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search City, area and neighbourhood',
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        progressDialog.show();
                        getLocation().then((value) {
                          if(value != null){
                            service.updateUser({
                              'location': GeoPoint(value.latitude,value.longitude),
                              'address': address,
                            }, context,widget.popScreen).then((value) {
                              progressDialog.dismiss();
                              //return Navigator.pushNamed(context, widget.popScreen);
                            });
                          }
                        });
                      },
                      horizontalTitleGap: 0.0,
                      leading: Icon(
                        Icons.my_location,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Use current location',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        location == null ?'Fetching location' :address,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade300,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 4, bottom: 4),
                        child: Text(
                          'CHOOSE CITY',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),

                    //////////////////////////////////////////////////////

                    Padding(
                      padding:  EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: CSCPicker(
                        layout: Layout.vertical,
                        dropdownDecoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        defaultCountry: DefaultCountry.Pakistan,
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                            manualAddress =
                            '$stateValue, $cityValue, $countryValue';
                          });
                          if(value != null){
                            service.updateUser({
                              'address': manualAddress,
                              'state':stateValue,
                              'city':cityValue,
                              'country': countryValue,
                            }, context,widget.popScreen);
                          }
                        },
                      ),
                    ),
                  ],
                );
              });
        }else {
          progressDialog.dismiss();
        }
      });
    }

    /////////////////////////////////////////////////////////////////////



    return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 65,
            ),
            Image.asset('assets/location.png'),
            SizedBox(
              height: 20,
            ),
            Text(
              'Where do want\n to buy/Sell Products',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'To enjoy al that we have to offer you\n we need to know where to look for them',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 30,
            ),
            loading
                ? Center(
              child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              ),
            )
                : ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Theme.of(context).backgroundColor),
              ),
              onPressed: () {


                // setState(() {
                //   loading = true;
                // });
                getLocation().then((value) {
                  if (value != null) {
                    service.updateUser({
                      'address' : address,
                      'location' : GeoPoint(value.latitude,value.longitude)
                    }, context,widget.popScreen);
                  }
                });
              },


              child: Container(

                width: 250,
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(CupertinoIcons.location_fill),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Around me',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: FutureBuilder<DocumentSnapshot>(
                  future: service.getUserData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data['address']);
                    }

                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColor),
                          ));
                    }
                    return Text(snapshot.data['address'],style: TextStyle(color: Colors.white),);
                  }),
            ),
            InkWell(
              onTap: () {
                progressDialog.show();
                showBottomScreen(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2),
                      )),
                  child: Text(
                    'Set location manually',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
