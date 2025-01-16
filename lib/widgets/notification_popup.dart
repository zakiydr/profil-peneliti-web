// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:profile_peneliti/services/notification_service.dart';

class NotificationPopup extends StatelessWidget {
  final List<PopupMenuEntry<dynamic>> Function(BuildContext) itemBuilder;
  const NotificationPopup({
    Key? key,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: '',
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16)),
      menuPadding: EdgeInsets.zero,
      color: Colors.white,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      position: PopupMenuPosition.under,
      icon: Icon(Icons.notifications_rounded),
      itemBuilder: itemBuilder,
      onOpened: () async {
        await NotificationService.showNotification(
            title: 'You have new citation',
            body: 'Your article have new citation',
            payload: "Notification Example");
      },
    );
  }
}
