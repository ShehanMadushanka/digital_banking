import 'package:flutter/material.dart';

class SelectingNotificationComponentImage extends StatefulWidget {
  String imgName;
  double height;
  double width;
  double radius;

  SelectingNotificationComponentImage({
    this.imgName,
    this.height = 35,
    this.width = 35,
    this.radius = 17,
  });

  @override
  _SelectingNotificationComponentImageState createState() =>
      _SelectingNotificationComponentImageState();
}

class _SelectingNotificationComponentImageState
    extends State<SelectingNotificationComponentImage> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: widget.radius,
      child: Image(
        image: AssetImage(widget.imgName),
        height: widget.height,
        width: widget.width,
        fit: BoxFit.fill,
      ),
    );
  }
}

class NotificationComponentImage extends StatefulWidget {
  String imgName;
  String readImgName;
  double height;
  double width;
  String tag;
  bool isRead;
  double radius;

  NotificationComponentImage({
    this.imgName,
    this.height = 35,
    this.width = 35,
    this.tag,
    this.isRead,
    this.readImgName,
    this.radius = 17,
  });

  @override
  _NotificationComponentImageState createState() =>
      _NotificationComponentImageState();
}

class _NotificationComponentImageState
    extends State<NotificationComponentImage> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: widget.radius,
      child: Image(
        image: widget.isRead
            ? AssetImage(widget.readImgName)
            : AssetImage(widget.imgName),
        height: widget.height,
        width: widget.width,
        fit: BoxFit.fill,
      ),
    );
  }
}
