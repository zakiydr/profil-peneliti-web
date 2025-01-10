// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
    );
  }
}
