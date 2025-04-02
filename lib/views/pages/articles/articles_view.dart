import 'package:data_table_2/data_table_2.dart';
import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/theme/app_colors.dart';
import 'package:profile_peneliti/widgets/app_fa_icon.dart';
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: ResponsiveConfig.getPadding(context),
                child: _buildArticleHeader(context),
              ),
              _getSpace(),
              Expanded(
                child: Consumer<ScholarDetailProvider>(
                  builder: (context, scholar, child) {
                    if (scholar.scholarDetail == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: ResponsiveConfig.getPadding(context),
                      child: DataTable2(
                        headingRowColor: WidgetStatePropertyAll(AppColors.grey),
                        dataRowHeight: kMinInteractiveDimension * 3,
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 600,
                        scrollController: controller,
                        columns: [
                          DataColumn2(
                            label: Text(
                              'Citations',
                              style: textTheme.titleSmall,
                            ),
                            size: ColumnSize.S,
                            fixedWidth: 70,
                            numeric: true,
                          ),
                          DataColumn2(
                            label: Text(
                              'Title',
                              style: textTheme.titleSmall,
                            ),
                            size: ColumnSize.L,
                            fixedWidth: MediaQuery.sizeOf(context).width * .6,
                          ),
                          DataColumn2(
                            label: Text(
                              '',
                              style: textTheme.titleSmall,
                            ),
                            size: ColumnSize.S,
                            fixedWidth: 70,
                          ),
                        ],
                        rows: List<DataRow>.generate(
                          scholar.scholarDetail!.publications!.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    scholar.scholarDetail!.publications![index]
                                            .numCitations
                                            .toString() ??
                                        '0',
                                    style: textTheme.titleSmall,
                                  ),
                                ),
                              ),
                              DataCell(
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      scholar
                                              .scholarDetail!
                                              .publications![index]
                                              .bib
                                              ?.title ??
                                          '',
                                      maxLines: 5,
                                      style: textTheme.titleSmall,
                                    ),
                                    // const SizedBox(height: 4),
                                    Text(
                                      'Published: ${scholar.scholarDetail!.publications![index].bib?.pubYear}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                                // Uncomment and modify onTap as needed:
                                // onTap: () => UrlLaunch().redirectUrl(
                                //   scholar.scholarDetail!.publications![index]
                                //       .citedbyUrl
                                //       .toString(),
                                // ),
                              ),
                              DataCell(
                                IconButton(
                                  onPressed: () {
                                    UrlLaunch().redirectUrl(
                                      scholar.scholarDetail!
                                          .publications![index].citedbyUrl
                                          .toString(),
                                    );
                                  },
                                  icon: AppFaIcon(
                                    FontAwesomeIcons.upRightFromSquare,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
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
    return const SizedBox(height: 3);
  }
}
