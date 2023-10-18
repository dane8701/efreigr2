import 'package:efreigrp2/controller/my_permission_gps.dart';
import 'package:efreigrp2/view/My_Map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyCheckMaps extends StatefulWidget {
  const MyCheckMaps({super.key});

  @override
  State<MyCheckMaps> createState() => _MyCheckMapsState();
}

class _MyCheckMapsState extends State<MyCheckMaps> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
        future: MyPermissionGps().init(),
        builder: (context,future){
          if(future.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }
          else
            {
              if(!future.hasData){
                return const Center(child:  Text("Pas de chance"));
              }
              else
                {
                  Position myPosition = future.data!;
                  return MyMap(position: myPosition,);
                }
            }
        }
    );
  }
}
