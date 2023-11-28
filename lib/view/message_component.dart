import 'package:efreigrp2/model/my_user.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';

class MessageComponent extends StatelessWidget {
  final Message? msg;

  const MessageComponent({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var date = msg!.createdAt!.toDate().toLocal();
    // TODO: implement build
    return Row(
      mainAxisAlignment:
        msg!.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: msg!.isMe ? Colors.blue : Colors.black.withOpacity(.7),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft:
                      msg!.isMe ? Radius.circular(10) : Radius.circular(0),
                      bottomRight:
                      msg!.isMe ? Radius.circular(10) : Radius.circular(10))),
              constraints: BoxConstraints(
                  minWidth: 30, minHeight: 40, maxWidth: width / 1.1),
              child: Text(
                msg!.content!,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(right: 5, bottom: 5),
                child: Text(
                '${date.hour}h${date.minute}',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ))
          ],
        ),
      ],
    );
  }
}