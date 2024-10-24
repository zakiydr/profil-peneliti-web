import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainDashboard extends StatelessWidget {
  MainDashboard({super.key});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<int, int>? date = {};

  final String thisYear = DateFormat('y').format(
    DateTime.now(),
  );

  Map<int, int> formatXLabelAxis(int x) {
    Map<int, int> date = {};
    int value = x;
    for (int i = 0; i < x; i++) {
      date[i] = value--;
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Scholar Profile'),
            ),
            ListTile(
              onTap: () {},
              title: Text('Overview'),
            ),
            ListTile(
              title: Text('Articles'),
            ),
            ListTile(
              title: Text('Citations'),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 4 / 2,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('h-index'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Card(
            child: _buildBarChart(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Title'),
              Text('See All'),
            ],
          ),
          Card(
            child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile();
                },
                separatorBuilder: (_, __) => Divider(
                      indent: 8,
                      endIndent: 8,
                    ),
                itemCount: 15),
          )
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text('Jan');
                    case 1:
                      return Text('Feb');
                    case 2:
                      return Text('Mar');
                    case 3:
                      return Text('Apr');
                    default:
                      return Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString());
                },
                reservedSize: 30,
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            horizontalInterval: 5,
          ),
          borderData: FlBorderData(
            show: true,
          ),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(toY: 8, color: Colors.blue),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(toY: 10, color: Colors.blue),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(toY: 14, color: Colors.blue),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(toY: 15, color: Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
