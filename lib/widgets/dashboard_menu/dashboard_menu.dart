import 'package:flutter/material.dart';
import 'package:flutter_app_badge/flutter_app_badge.dart';
import 'package:profile_peneliti/providers/features/dashboard_menu_provider.dart';
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/utils/responsive.dart';
import 'package:profile_peneliti/views/pages/overview/overview_view.dart';
import 'package:provider/provider.dart';

import '../../providers/features/publication_provider.dart';
import '../../theme/app_colors.dart';
import 'dashboard_menu_tiles.dart';

class DashboardMenu extends StatelessWidget {
  const DashboardMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scholar = context.read<ScholarDetailProvider>();
    final citation = context.read<CitationProvider>();
    final publication = context.read<PublicationProvider>();
    return Drawer(
      backgroundColor: AppColors.lightGrey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Consumer<DashboardMenuProvider>(
              builder: (_, menu, __) => ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    color: Colors.white,
                    padding: ResponsiveConfig.getPadding(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo-sttnf.png',
                          width: 60,
                        ),
                        Text(
                          'Scholar Profile',
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  DashboardTiles(
                    leading: const Icon(Icons.dashboard),
                    title: 'Overview',
                    selected: menu.selectedIndex == 0,
                    onTap: () => menu.goToOverview(context),
                  ),
                  DashboardTiles(
                    leading: Icon(Icons.article_rounded),
                    title: 'Articles',
                    selected: menu.selectedIndex == 1,
                    onTap: () => menu.goToArticles(context),
                  ),
                  // DashboardTiles(
                  //   title: 'Citation',
                  //   selected: menu.selectedIndex == 2,
                  //   onTap: () => menu.goToCitations(context),
                  // ),
                ],
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      final lastSavedScholarId = scholar.lastSavedScholarId;

                      final currentScholarId = scholar.scholarDetail?.scholarId;

                      return AlertDialog(
                        content: Text('Do you want to save this profile?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await scholar.saveData();
                              await citation.saveCitation(
                                  scholar.scholarDetail!.citedby!.toInt() - 5);
                              await publication.savePubCitations();

                              Navigator.pop(context);

                              if (lastSavedScholarId == currentScholarId) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.orange,
                                    content: Text('Profile is already saved'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text('Profile saved successfully'),
                                  ),
                                );
                              }
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Save Profile', style: textTheme.bodyMedium),
              ))
        ],
      ),
    );
  }
}
