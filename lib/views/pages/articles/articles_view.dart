import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:flutter/material.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../utils/responsive.dart';
import '../../../utils/url_launch.dart';
import '../../../widgets/articles_detail_card.dart';
import 'articles_init.dart';

class ArticlesView extends StatelessWidget {
  const ArticlesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scholarDetail =
        Provider.of<ScholarDetailProvider>(context, listen: false)
            .scholarDetail;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: DynMouseScroll(
          durationMS: 100,
          builder: (context, controller, physics) {
            return ListView(
              controller: controller,
              physics: physics,
              padding: ResponsiveConfig.getPadding(context),
              children: [
                _buildArticleHeader(context),
                _getSpace(),
                Consumer<ScholarDetailProvider>(
                    builder: (context, scholar, child) {
                  if (scholar.scholarDetail == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: scholarDetail!.publications!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ArticlesDetailCard(
                            title:
                                scholarDetail.publications?[index].bib?.title,
                            topSubtitle: scholarDetail
                                .publications?[index].bib?.citation,
                            // bottomSubtitle: scholarDetail.publications?[index].bib?.pubYear,
                            leadingCitation: scholarDetail
                                .publications?[index].numCitations
                                .toString(),
                            onTap: () => UrlLaunch().redirectUrl(scholarDetail
                                .publications![index].citedbyUrl
                                .toString()),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (_, __) => _getSpace(),
                  );
                }),
              ],
            );
          }),
    );
  }

  Widget _buildArticleHeader(context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Articles',
          style: textTheme.headlineSmall,
        ),
      ],
    );
  }

  Widget _getSpace() {
    return SizedBox(height: 3);
  }
}
