import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profile_peneliti/constants/app_routes.dart';
import 'package:profile_peneliti/models/scholar_detail/scholar_detail.dart';
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/dashboard_menu_provider.dart';
import 'package:profile_peneliti/providers/features/publication_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/providers/features/scholars_provider.dart';
import 'package:profile_peneliti/utils/url_launch.dart';
import 'package:profile_peneliti/widgets/articles_detail_card.dart';
import 'package:profile_peneliti/widgets/app_fa_icon.dart';
import 'package:profile_peneliti/widgets/notification_popup.dart';
import 'package:provider/provider.dart';

import '../utils/responsive.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final scholar = Provider.of<ScholarDetailProvider>(context, listen: false);
    final citation = Provider.of<CitationProvider>(context, listen: false);
    final publication =
        Provider.of<PublicationProvider>(context, listen: false);
    return Card(
      shape: ContinuousRectangleBorder(),
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                if (ResponsiveConfig.getDeviceType(context) !=
                    DeviceType.desktop)
                  IconButton(
                    onPressed: () {
                      context
                          .read<DashboardMenuProvider>()
                          .controlMenu(context);
                    },
                    icon: AppFaIcon(
                      FontAwesomeIcons.bars,
                    ),
                  ),
                _buildSearchButton(context, textTheme),
              ],
            ),
            Wrap(
              children: [
                _buildNotificationPopup(
                    context, citation, scholar, publication),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationPopup(
      BuildContext context,
      CitationProvider citation,
      ScholarDetailProvider scholar,
      PublicationProvider publication) {
    final style = Theme.of(context).textTheme;

    return FutureBuilder<int>(
      future: citation.compareTotalCitation(
          scholar.scholarDetail!.citedby!.toInt(),
          scholar.scholarDetail!.scholarId.toString()),
      builder: (context, citationSnapshot) {
        if (citationSnapshot.hasData) {
          return Badge(
            offset: Offset(0, 0),
            textStyle: style.labelSmall,
            label: Text('${citationSnapshot.data}'),
            isLabelVisible: citationSnapshot.data != 0 ? true : false,
            child: FutureBuilder<int>(
              future: publication.comparePublicationCitations(),
              builder: (context, pubCitationSnapshot) {
                return FutureBuilder<List<Publication>>(
                  future: publication.getChangedPublications(),
                  builder: (context, changedPublicationsSnapshot) {
                    if (changedPublicationsSnapshot.hasData) {
                      return NotificationPopup(itemBuilder: (context) {
                        final changedPublications =
                            changedPublicationsSnapshot.data!;

                        return [
                          PopupMenuItem(
                            padding: EdgeInsets.all(16),
                            child:
                                Text('Notifications', style: style.titleLarge),
                            enabled: false,
                          ),
                          PopupMenuItem(
                            padding: EdgeInsets.zero,
                            enabled: false,
                            child: changedPublications.isEmpty
                                ? Center(child: Text('No new citations'))
                                : Container(
                                    width: 500,
                                    height: 400,
                                    child: ListView.separated(
                                      padding: EdgeInsets.all(16),
                                      shrinkWrap: true,
                                      itemCount: changedPublications.length,
                                      itemBuilder: (context, index) {
                                        final publication =
                                            changedPublications[index];
                                        return ListTile(
                                          title: Text(
                                            'Someone just cited your article!',
                                            style: style.titleMedium,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: RichText(
                                            // textAlign: TextAlign.justify,
                                            text: TextSpan(
                                              style: style.bodyMedium,
                                              children: [
                                                TextSpan(text: 'You have '),
                                                TextSpan(
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    text:
                                                        "${publication.numCitations.toString()} "),
                                                TextSpan(
                                                    text:
                                                        "new citations on your article entitled "),
                                                TextSpan(
                                                    style: style.bodyMedium!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                    text:
                                                        '"${publication.bib?.title}"'),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            UrlLaunch().redirectUrl(publication
                                                .citedbyUrl
                                                .toString());
                                          },
                                        );
                                      },
                                      separatorBuilder: (_, __) => Divider(),
                                    ),
                                  ),
                          ),
                          PopupMenuItem(
                            enabled: false,
                            child: Divider(
                              height: 2,
                            ),
                          ),
                        ];
                      });
                    }
                    return SizedBox.shrink();
                  },
                );
              },
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  InputDecoration _searchFieldDecoration() {
    return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: AppFaIcon(FontAwesomeIcons.magnifyingGlass),
        hintText: 'Search Scholar...');
  }

  Widget _buildSearchButton(BuildContext context, TextTheme textTheme) {
    if (ResponsiveConfig.getDeviceType(context) == DeviceType.desktop) {
      return Container(
        width: ResponsiveConfig.getDeviceType(context) == DeviceType.desktop
            ? 300
            : 200,
        child: TextField(
          readOnly: true,
          onTap: () {
            context.read<ScholarsProvider>().prepareForSearch();
            Navigator.pushNamed(context, AppRoutes.search);
          },
          style: textTheme.bodyMedium,
          decoration: _searchFieldDecoration(),
        ),
      );
    }
    return IconButton(
        onPressed: () {
          context.read<ScholarsProvider>().prepareForSearch();
          Navigator.pushNamed(context, AppRoutes.search);
        },
        icon: AppFaIcon(
          FontAwesomeIcons.magnifyingGlass,
        ));
  }
}
