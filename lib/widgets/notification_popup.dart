// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/services/notification_service.dart';
import 'package:provider/provider.dart';

class NotificationPopup extends StatelessWidget {
  final List<PopupMenuEntry<dynamic>> Function(BuildContext) itemBuilder;
  const NotificationPopup({
    Key? key,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final citation = context.read<CitationProvider>();
    final scholar = context.read<ScholarDetailProvider>();
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
        final totalCitation = await citation.compareTotalCitation(
            scholar.scholarDetail!.citedby!.toInt(),
            scholar.scholarDetail!.scholarId.toString());
        await NotificationService.showNotification(
          title: 'Your article(s) has been cited',
          body:
              'You have $totalCitation new citation(s) (This is just a trigger test)',
          payload: "Open the application",
        );
      },
    );
  }
}
