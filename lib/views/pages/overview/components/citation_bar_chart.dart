import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:profile_peneliti/views/pages/overview/components/citation_chart.dart';

class CitationBarChart extends StatelessWidget {
  final List<MapEntry<int, double>> citesList;
  final YAxisConfig yAxisConfig;
  final TextTheme textTheme;
  final double? width;
  final double height;

  const CitationBarChart({
    Key? key,
    required this.citesList,
    required this.yAxisConfig,
    required this.textTheme,
    this.width,
    this.height = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barGroups = List.generate(
      citesList.length,
      (index) => BarChartGroupData(
        showingTooltipIndicators: [0],
        x: index,
        barRods: [
          BarChartRodData(
            borderRadius: BorderRadius.circular(4),
            width: 15,
            color: Colors.blue,
            toY: citesList[index].value,
          ),
        ],
      ),
    );

    return SizedBox(
      width: width,
      height: height,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: yAxisConfig.maxY,
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
                  if (index >= 0 && index < citesList.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${citesList[index].key}',
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
                  if (value % yAxisConfig.interval == 0) {
                    return Text(
                      value.toInt().toString(),
                      style: textTheme.bodySmall,
                    );
                  }
                  return const SizedBox.shrink();
                },
                reservedSize: 40,
                interval: yAxisConfig.interval,
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
              if (value % yAxisConfig.interval == 0) {
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
            horizontalInterval: yAxisConfig.interval,
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
    );
  }
}