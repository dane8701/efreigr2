import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efreigrp2/controller/my_firestore_helper.dart';
import 'package:efreigrp2/model/message.dart';
import 'package:efreigrp2/model/my_user.dart';
import 'package:efreigrp2/view/message_component.dart';
import 'package:flutter/material.dart';

class MyChatPage extends StatelessWidget {
  MyChatPage({Key? key, this.user}): super(key: key);
  final MyUser? user ;
  var msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.fullName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: StreamBuilder<List<Message>> (
                stream: MyFirestoreHelper().getMessage(user!.uid!),
                builder: (context, s1) {
                  if(s1.hasData) {
                    return StreamBuilder<List<Message>>(
                      stream: MyFirestoreHelper().getMessage(user!.uid!, false),
                      builder: (context, s2) {
                        if (s2.hasData) {
                          var messages = [...s1.data!, ...s2.data!];
                          messages.sort((i, j) => i.createdAt!.compareTo(j.createdAt!));
                          messages = messages.reversed.toList();
                          return messages.length == 0 ?
                            Center (
                              child: Text('Aucun message'),
                            ) : ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final msg = messages[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: MessageComponent(
                                  msg: msg,
                                ),
                              );
                            },
                          );
                        } else
                          return Center(child: CircularProgressIndicator());
                      },);
                  } else
                      return Center(child: CircularProgressIndicator());
                  },
              )),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: msgController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
                  ),
              ),
              IconButton(onPressed: () async {
                var msg = Message(
                  content: msgController.text,
                  createdAt: Timestamp.now(),
                  receiverUID: user!.uid,
                  senderUID: MyFirestoreHelper().user.uid
                );
                msgController.clear();
                await MyFirestoreHelper().sendMesssage(msg);
              }, icon: Icon(Icons.send))
            ],
          )
        ],
      ),
      ),
    );
    throw UnimplementedError();
  }

}