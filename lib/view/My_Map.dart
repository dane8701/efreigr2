import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  Position position;
  MyMap({required this.position, super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  //variable
  late CameraPosition myPositionMaps;
  Completer<GoogleMapController> control = Completer();

  @override
  void initState() {
    // TODO: implement initState
    myPositionMaps = CameraPosition(target: LatLng(widget.position.latitude,widget.position.longitude),zoom: 14);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: ,
      initialCameraPosition: myPositionMaps,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: (controller){
        control.complete(controller);

      },
    );
  }
}
