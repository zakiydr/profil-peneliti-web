// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profile_peneliti/views/main_dashboard/main_dashboard_init.dart';
import 'package:provider/provider.dart';

import 'package:profile_peneliti/providers/features/dashboard_menu_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/dashboard_menu/dashboard_menu.dart';
import '../../../widgets/header.dart';
import 'components/quick_stats.dart';
import 'components/quick_stats_card.dart';
import 'components/dashboard_articles.dart';

class OverviewView extends StatelessWidget {
  OverviewView({
    Key? key,
  }) : super(key: key);

  final Map<int, int>? date = {};

  final space = SizedBox(
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Consumer<ScholarDetailProvider>(builder: (_, scholar, __) {
      return DynMouseScroll(
          durationMS: 100,
          builder: (context, controller, physics) {
            return ListView(
              controller: controller,
              physics: physics,
              padding: ResponsiveConfig.getPadding(context),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: ResponsiveConfig.getDeviceType(context) ==
                              DeviceType.desktop
                          ? 2
                          : 1,
                      child: Column(
                        children: [
                          if (ResponsiveConfig.getDeviceType(context) !=
                              DeviceType.desktop)
                            _buildSideItems(textTheme, context, scholar),
                          _buildDashboardTitle(context, textTheme),
                          space,
                          _buildQuickStats(scholar),
                          space,
                          _buildChartCard(textTheme, scholar, context),
                          space,
                          if (ResponsiveConfig.getDeviceType(context) !=
                              DeviceType.desktop)
                            _buildMostCitedArticles(scholar, textTheme),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    if (ResponsiveConfig.getDeviceType(context) ==
                        DeviceType.desktop)
                      Expanded(
                        flex: 1,
                        child: _buildSideItems(textTheme, context, scholar),
                      ),
                  ],
                ),
              ],
            );
          });
    });
  }

  Widget _buildSideItems(TextTheme textTheme, BuildContext context,
      ScholarDetailProvider scholar) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (ResponsiveConfig.getDeviceType(context) == DeviceType.desktop)
          Text(
            'User Profile',
            style: textTheme.headlineSmall,
          ),
        _buildUserProfile(scholar, textTheme),
        if (ResponsiveConfig.getDeviceType(context) == DeviceType.desktop)
          _buildMostCitedArticles(scholar, textTheme)
      ],
    );
  }

  Card _buildUserProfile(ScholarDetailProvider scholar, TextTheme textTheme) {
    Widget imgLoader(src) {
      if (scholar.scholarDetail == null) {
        return Icon(Icons.person);
      }
      return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            src,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ));
    }

    return Card(
      child: Column(
        children: [
          Container(
            child: ListTile(
              // tileColor: Colors.white,
              leading: imgLoader(scholar.scholarDetail?.urlPicture),
              title: Text(
                scholar.scholarDetail?.name.toString() ?? '',
                style: textTheme.titleSmall,
              ),
              subtitle: Text(
                  scholar.scholarDetail?.affiliation.toString() ?? '',
                  style: textTheme.labelSmall),
            ),
          ),
          // Container(
          //   height: 50,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemCount: scholar.scholarDetail?.interests?.length,
          //     itemBuilder: (context, index) {
          //       return TextButton(

          //           onPressed: () {},
          //           child: Text(
          //               scholar.scholarDetail?.interests?[index] ?? ''));
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _buildQuickStats(ScholarDetailProvider scholar) {
    return QuickStatsWidget(
      childAspectRatio: 4 / 2,
      crossAxisCount: 2,
      children: [
        QuickStatsCard(
          color: Colors.lightBlue,
          title: 'h-index',
          content: scholar.scholarDetail?.hindex.toString() ?? '',
        ),
        QuickStatsCard(
          color: Colors.orangeAccent,
          title: 'i10-index',
          content: scholar.scholarDetail?.i10Index.toString() ?? '',
        ),
      ],
    );
  }

  Widget _buildChartCard(TextTheme textTheme, ScholarDetailProvider scholar,
      BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cited by',
                  style: textTheme.headlineSmall,
                ),
              ],
            ),
            Text(
              scholar.scholarDetail?.citedby.toString() ?? '',
              style: textTheme.displaySmall,
            ),
            Text(
              'Articles',
              style: textTheme.bodyLarge,
            ),
            _buildBarChart(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTitle(BuildContext context, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (ResponsiveConfig.getDeviceType(context) == DeviceType.desktop)
          Text(
            'Dashboard',
            style: textTheme.headlineSmall,
          ),
        // IconButton(onPressed: () {}, icon: Icon(Icons.notifications_rounded)),
      ],
    );
  }

  Widget _buildMostCitedArticles(
      ScholarDetailProvider scholar, TextTheme textTheme) {
    final pubLength = scholar.scholarDetail!.publications!.length;
    return MostCitedArticles(
      itemCount: pubLength <= 10 ? pubLength : 10,
      itemBuilder: (context, index) {
        return ListTile(
          isThreeLine: true,
          title: Text(
            scholar.scholarDetail?.publications?[index].bib?.title ?? '',
            style: textTheme.titleMedium,
          ),
          subtitle: Text(
            scholar.scholarDetail?.publications?[index].bib?.citation ?? '',
            style: textTheme.bodyMedium,
          ),
          trailing: Text(
              scholar.scholarDetail?.publications?[index].numCitations
                      .toString() ??
                  '',
              style: textTheme.titleMedium),
          onTap: () {},
        );
      },
    );
  }

  Widget _buildBarChart(context) {
    // late barGroups;

    final scholarDetail =
        Provider.of<ScholarDetailProvider>(context).scholarDetail;

    // final List<double> citesYearList = [];

    // scholarDetail?.citesPerYear?.forEach(
    //   (key, value) => citesYearList.add(value.truncateToDouble()),
    // );

    final List<int> citesYearKeys =
        scholarDetail?.citesPerYear?.keys.map((e) => int.parse(e)).toList() ??
            [];
    final List<double> citesYearValues =
        scholarDetail?.citesPerYear?.values.map((e) => e.toDouble()).toList() ??
            [];

    double maxY = citesYearValues.isEmpty
        ? 100
        : citesYearValues.reduce((a, b) => a > b ? a : b);

    List<BarChartGroupData> generateBarGroups(int length) {
      if (length == 0) return [];

      return List.generate(
        length,
        (index) => BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              width: 15,
              color: Colors.blue,
              toY: index < citesYearValues.length ? citesYearValues[index] : 0,
            ),
          ],
        ),
      );
    }

    List<BarChartGroupData> barGroups = generateBarGroups(citesYearKeys.length);

    final int thisYear = int.parse(
      DateFormat('y').format(
        DateTime.now(),
      ),
    );

    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY + (maxY * 0.1),
          barTouchData: BarTouchData(
            enabled: true,
            touchCallback: (event, response) {},
            touchTooltipData: BarTouchTooltipData(),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < citesYearKeys.length) {
                    return Text('${citesYearKeys[index]}');
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString());
                },
                reservedSize: 30,
              ),
            ),
          ),
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                dashArray: [
                  10,
                  0,
                ],
                color: Colors.grey.withOpacity(.5),
                strokeWidth: 1,
              );
            },
            show: true,
            horizontalInterval: maxY / 5,
          ),
          borderData: FlBorderData(
              show: true, border: Border(bottom: BorderSide(width: .5))),
          barGroups: barGroups,
        ),
      ),
    );
  }
}
