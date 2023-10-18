import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efreigrp2/controller/my_firestore_helper.dart';
import 'package:efreigrp2/globale.dart';
import 'package:efreigrp2/model/my_user.dart';
import 'package:flutter/material.dart';

class MyAllPersonn extends StatefulWidget {
  const MyAllPersonn({super.key});

  @override
  State<MyAllPersonn> createState() => _MyAllPersonnState();
}

class _MyAllPersonnState extends State<MyAllPersonn> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: MyFirestoreHelper().cloudUsers.snapshots(),
        builder: (context,snap){
          if(snap.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else
            {
              if(!snap.hasData){
                return const Center(child:  Text("Aucune info"));
              }
              else
                {
                  List documents = snap.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                      itemBuilder: (context,index){
                      MyUser otherUser = MyUser.dataBase(documents[index]);
                      return Dismissible(
                        key: Key(otherUser.uid),
                        background: Container(
                          color: Colors.red,
                        ),
                        child: Card(
                          elevation: 5,
                          color: Colors.amberAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(otherUser.avatar ?? imageDefault),
                            ),
                            title: Text(otherUser.fullName),
                            subtitle: Text(otherUser.email),
                          ),
                        ),
                      );
                      }
                  );
                }
            }
        }
    );
  }
}
