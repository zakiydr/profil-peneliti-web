import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profile_peneliti/models/scholar_detail/scholar_detail.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/views/pages/overview/components/citation_bar_chart.dart';
import 'package:profile_peneliti/widgets/app_fa_icon.dart';
import 'package:provider/provider.dart';

class CitationChartCard extends StatefulWidget {
  const CitationChartCard({Key? key}) : super(key: key);

  @override
  State<CitationChartCard> createState() => _CitationChartCardState();
}

class _CitationChartCardState extends State<CitationChartCard> {
  bool isOnlyFiveYears = false;

  ScrollController _horizontalScroll = ScrollController();
  ScrollController _verticalScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    final scholarDetail = context.watch<ScholarDetailProvider>().scholarDetail;

    if (scholarDetail == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<int> citesYearKeys =
        scholarDetail.citesPerYear!.keys.map(int.parse).toList()..sort();

    final List<double> citesYearValues =
        scholarDetail.citesPerYear!.values.map((e) => e.toDouble()).toList();

    List<MapEntry<int, double>> citesList = List.generate(
      citesYearKeys.length,
      (index) => MapEntry(citesYearKeys[index], citesYearValues[index]),
    )..sort((a, b) => a.key.compareTo(b.key));

    int numberOfYearsToShow = isOnlyFiveYears ? 5 : 7;
    List<MapEntry<int, double>> displayedCitesList =
        citesList.length > numberOfYearsToShow
            ? citesList.sublist(citesList.length - numberOfYearsToShow)
            : citesList;

    List<BarChartGroupData> generateBarGroups() {
      return List.generate(
        displayedCitesList.length,
        (index) => BarChartGroupData(
          showingTooltipIndicators: [0],
          x: index,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(4),
              width: 15,
              color: Colors.blue,
              toY: displayedCitesList[index].value,
            ),
          ],
        ),
      );
    }

    List<BarChartGroupData> barGroups = generateBarGroups();

    // Improved Y-axis configuration calculation
    final YAxisConfig yAxisConfig = calculateYAxisConfig(
      displayedCitesList.map((e) => e.value).reduce(max),
    );

    final double maxY = yAxisConfig.maxY;
    final double interval = yAxisConfig.interval;

    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCitationInfo(textTheme, scholarDetail),
        const SizedBox(height: 30),
        CitationBarChart(
          citesList: displayedCitesList,
          yAxisConfig: yAxisConfig,
          textTheme: textTheme,
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text("Show only last 5 years"),
          value: isOnlyFiveYears,
          onChanged: (bool value) {
            setState(() {
              isOnlyFiveYears = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCitationInfo(TextTheme textTheme, ScholarDetail scholarDetail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Cited by',
                style: textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                isOnlyFiveYears
                    ? scholarDetail.citedby5Y.toString()
                    : scholarDetail.citedby.toString(),
                style: textTheme.displaySmall,
              ),
              Text(
                'Articles',
                style: textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        IconButton(
          icon: AppFaIcon(FontAwesomeIcons.upRightAndDownLeftFromCenter),
          onPressed: () {
            final List<int> citesYearKeys = scholarDetail.citesPerYear!.keys
                .map(int.parse)
                .toList()
              ..sort();

            final List<double> citesYearValues = scholarDetail
                .citesPerYear!.values
                .map((e) => e.toDouble())
                .toList();

            final List<MapEntry<int, double>> fullCitesList = List.generate(
              citesYearKeys.length,
              (index) => MapEntry(citesYearKeys[index], citesYearValues[index]),
            )..sort((a, b) => a.key.compareTo(b.key));

            final yAxisConfig = calculateYAxisConfig(
              fullCitesList.map((e) => e.value).reduce(max),
            );

// In _buildCitationInfo(), replace the showDialog part with:

            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const AppFaIcon(FontAwesomeIcons.xmark),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Scrollbar(
                            trackVisibility: true,
                            thumbVisibility: true,
                            controller: _verticalScroll,
                            child: SingleChildScrollView(
                              controller: _verticalScroll,
                              child: Scrollbar(
                                trackVisibility: true,
                                thumbVisibility: true,
                                controller: _horizontalScroll,
                                child: SingleChildScrollView(
                                  controller: _horizontalScroll,
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: CitationBarChart(
                                      citesList: fullCitesList,
                                      yAxisConfig: yAxisConfig,
                                      textTheme: textTheme,
                                      width: max(
                                        MediaQuery.of(context).size.width * 0.8,
                                        fullCitesList.length * 40.0,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  YAxisConfig calculateYAxisConfig(double highestValue) {
    double maxY;
    double interval;

    if (highestValue > 300) {
      // For values above 300, round up to nearest 100 and use 100 intervals
      maxY = ((highestValue + 99) ~/ 100) * 100.0;
      interval = 100;
    } else if (highestValue > 100) {
      // For values between 100 and 300, use 300 as max with 100 intervals
      maxY = 300;
      interval = 100;
    } else if (highestValue > 50) {
      // For values between 50 and 100, use 100 as max with 25 intervals
      maxY = 100;
      interval = 25;
    } else {
      // For values below 50, use 50 as max with 10 intervals
      maxY = 50;
      interval = 10;
    }

    return YAxisConfig(maxY: maxY, interval: interval);
  }
}

class YAxisConfig {
  final double maxY;
  final double interval;

  YAxisConfig({required this.maxY, required this.interval});
}
