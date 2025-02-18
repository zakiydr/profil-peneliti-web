import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:profile_peneliti/models/scholar_detail/scholar_detail.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:provider/provider.dart';

class CitationChart extends StatefulWidget {
  const CitationChart({Key? key}) : super(key: key);

  @override
  State<CitationChart> createState() => _CitationChartState();
}

class _CitationChartState extends State<CitationChart> {
  bool isOnlyFiveYears = false;

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
        SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipMargin: 0,
                  tooltipPadding: EdgeInsets.zero,
                  fitInsideHorizontally: true,
                  fitInsideVertically: false,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      rod.toY.round().toString(),
                      const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            color: Colors.white,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    );
                  },
                  getTooltipColor: (group) => Colors.transparent,
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 && index < displayedCitesList.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${displayedCitesList[index].key}',
                            style: textTheme.bodySmall,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // Only show labels at grid intervals
                      if (value % interval == 0) {
                        return Text(
                          value.toInt().toString(),
                          style: textTheme.bodySmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    reservedSize: 40,
                    interval: interval, // Set the interval for labels
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) {
                  // Only draw grid lines at intervals
                  if (value % interval == 0) {
                    return FlLine(
                      dashArray: [5, 5],
                      color: Colors.grey.withOpacity(0.3),
                      strokeWidth: 1,
                    );
                  }
                  return const FlLine(
                    color: Colors.transparent,
                    strokeWidth: 0,
                  );
                },
                show: true,
                horizontalInterval: interval,
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                  left: BorderSide.none,
                  right: BorderSide.none,
                  top: BorderSide.none,
                ),
              ),
              barGroups: barGroups,
            ),
          ),
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
    return Column(
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
