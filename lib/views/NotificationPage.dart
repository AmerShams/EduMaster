// ignore_for_file: must_be_immutable, file_names

import 'package:courseproject/controller/NotificationController.dart';
import 'package:courseproject/static/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});
  NotificationsController controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context),
      body: listView(context),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    double titleSize = MediaQuery.of(context).size.width * 0.05;
    return AppBar(
      title: Text(
        'Notifications',
        style: TextStyle(fontSize: titleSize),
      ),
    );
  }

  Widget listView(BuildContext context) {
    double separatorHeight = MediaQuery.of(context).size.width * 0.012;
    return GetBuilder<NotificationsController>(
      builder: (controller) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (i) {
                      controller.deletenotification(index);
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ],
              ),
              child: listViewItem(context, index),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: separatorHeight,
            );
          },
          itemCount: notifications.length,
        );
      },
    );
  }

  Widget listViewItem(BuildContext context, int index) {
    double iconSize = MediaQuery.of(context).size.width * 0.12;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(iconSize),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message(context, index),
                  timeAndDate(context, index),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixIcon(double iconSize) {
    return Container(
      height: iconSize,
      width: iconSize,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Icon(
        Icons.notifications,
        size: iconSize * 0.55,
        color: Colors.grey.shade700,
      ),
    );
  }

  Widget message(BuildContext context, int index) {
    double textSize = MediaQuery.of(context).size.width * 0.04;
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      text: TextSpan(
        text: 'Message |   ',
        style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: '${notifications[index][0]}',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget timeAndDate(BuildContext context, int index) {
    double textSize = MediaQuery.of(context).size.width * 0.03;
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${notifications[index][1]}",
            style: TextStyle(fontSize: textSize),
          ),
          Text(
            "${notifications[index][2]}",
            style: TextStyle(fontSize: textSize),
          ),
        ],
      ),
    );
  }
}
