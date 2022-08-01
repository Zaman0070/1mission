import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    FirebaseService service = FirebaseService();
    return FutureBuilder<DocumentSnapshot>(
      future:  service.users.doc(service.user.uid).get(),
        builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasError){
          return Text('Some thing went wrong');
        }
        if(snapshot.hasData && ! snapshot.data.exists){
          return Text("Address not selected ");
        }
        if(snapshot.connectionState == ConnectionState.done){
          Map<String,dynamic> data = snapshot.data.data();

          if(data['address'] == null){

            GeoPoint latlng = data['location'];
            service.getAddress(latlng.latitude, latlng.longitude).then((address) {
              return address;
            });
          }else{
            return address(data['address'], context);
          }
          //return appBar('Update location', context);

        }
        return address('Fetching Loading', context);
        }

    );
  }

  Widget address(address,context){
    return  Container(
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.location_solid),
              SizedBox(width: 10,),
              Flexible(
                  child: Text(address,style: TextStyle(fontSize:13, color: Colors.white),)),
            ],
          ),
    );
  }

}
