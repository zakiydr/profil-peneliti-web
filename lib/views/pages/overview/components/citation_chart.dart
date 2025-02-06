import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:provider/provider.dart';

class CitationChart extends StatefulWidget {
  const CitationChart({super.key});

  @override
  State<CitationChart> createState() => _CitationChartState();
}

class _CitationChartState extends State<CitationChart> {
  bool isOnlyFiveYears = false; // Toggle for showing only the last five years

  @override
  Widget build(BuildContext context) {
    final scholarDetail = context.read<ScholarDetailProvider>().scholarDetail;

    final List<int> citesYearKeys =
        scholarDetail?.citesPerYear?.keys.map(int.parse).toList() ?? [];
    final List<double> citesYearValues =
        scholarDetail?.citesPerYear?.values.map((e) => e.toDouble()).toList() ??
            [];

    List<MapEntry<int, double>> citesList = List.generate(
      citesYearKeys.length,
      (index) => MapEntry(citesYearKeys[index], citesYearValues[index]),
    );

    citesList.sort((a, b) => a.key.compareTo(b.key));

    // Adjust this to control the number of years displayed
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
              borderRadius: BorderRadius.circular(0),
              width: 15,
              color: Colors.blue,
              toY: displayedCitesList[index].value,
            ),
          ],
        ),
      );
    }

    List<BarChartGroupData> barGroups = generateBarGroups();

    double dynamicMax(double number) {
      if (number <= 0) return 0;
      int value = number.ceil();
      int magnitude = (log(value) / log(10)).floor();
      double base = pow(10, magnitude).toDouble();
      int firstDigit = (value / base).floor();
      return firstDigit <= 1
          ? base
          : firstDigit <= 2
              ? 2 * base
              : firstDigit <= 5
                  ? 5 * base
                  : 10 * base;
    }

    final textTheme = Theme.of(context).textTheme;
    final scholar = context.read<ScholarDetailProvider>();

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
        Text(
          isOnlyFiveYears
              ? scholar.scholarDetail!.citedby5Y.toString()
              : scholar.scholarDetail!.citedby.toString(),
          style: textTheme.displaySmall,
        ),
        Text(
          'Articles',
          style: textTheme.bodyLarge,
        ),
        SizedBox(height: 30),
        SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: dynamicMax(
                  displayedCitesList.map((e) => e.value).reduce(max)),
              barTouchData: BarTouchData(
                enabled: true,
                touchCallback: (event, response) {},
                touchTooltipData: BarTouchTooltipData(
                  tooltipMargin: 0,
                  tooltipPadding: EdgeInsets.zero,
                  fitInsideHorizontally: true,
                  fitInsideVertically: false,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final text = '${rod.toY.round()}';

                    return BarTooltipItem(
                      text,
                      TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: List.generate(
                            10,
                            (index) => Shadow(
                                blurRadius: 10,
                                color: Colors.white,
                                offset: Offset(0, 0)),
                          )),
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
                        return Text('${displayedCitesList[index].key}');
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
                    dashArray: [10, 0],
                    color: Colors.grey.withOpacity(.5),
                    strokeWidth: 1,
                  );
                },
                show: true,
                horizontalInterval: dynamicMax(
                        displayedCitesList.map((e) => e.value).reduce(max)) /
                    10,
              ),
              borderData: FlBorderData(
                  show: true, border: Border(bottom: BorderSide(width: .5))),
              barGroups: barGroups,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
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
}
