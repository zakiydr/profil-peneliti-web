import 'package:flutter/material.dart';
import 'package:profile_peneliti/utils/ticker_provider.dart';
import 'package:profile_peneliti/view_model/tab_bar_view_model.dart';
import 'package:profile_peneliti/widgets/tabbar/profile_tab_bar.dart';
import 'package:profile_peneliti/widgets/tabbar/profile_tab_bar_view.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class MainProfileView extends StatelessWidget {
  const MainProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return TickerProviderWrapper(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            backgroundColor: Colors.grey.shade300,
            shape:
                const Border(bottom: BorderSide(width: 1, color: Colors.grey)),
            leading: IconButton(
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
            title: const Text('Scholar Profile'),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ]),
        drawer: const Drawer(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  minRadius: 48,
                                  maxRadius: 60,
                                ),
                                const Text(
                                  'Sirojul Munir',
                                ),
                                const Text(
                                    'Sekolah Tinggi Teknologi Terpadu Nurul Fikri (STT-NF)'),
                                RichText(
                                  text: const TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text:
                                                'Verified email at nurulfikri.ac.id - '),
                                        TextSpan(
                                          text: 'Homepage',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ]),
                                ),
                                Wrap(
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('Software Engineering'),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('Database'),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('Machine Learning'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue),
                              ),
                              color: Colors.white,
                              onPressed: () {},
                              icon: const Icon(Icons.notification_add_rounded))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Consumer<TabBarViewModel>(
                  builder: (context, value, child) {
                    if (!value.isInitialized) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ProfileTabBar(
                        tabs: value.tabs,
                        controller: value.profileTabController);
                  },
                ),
              ),
            ];
          },
          body: Consumer<TabBarViewModel>(
            builder: (context, value, child) {
              if (!value.isInitialized) {
                return const Center(child: CircularProgressIndicator());
              }
              return ProfileTabBarView(
                controller: value.profileTabController,
                article: _buildArticle(),
                citedBy: _buildCitedBy(),
                coAuthors: _buildCoAuthors(),
              );
            },
          ),
        ),
      ),
    );
  }

  ListView _buildCoAuthors() {
    return ListView.separated(
      itemCount: 3,
      itemBuilder: (context, index) {
        return ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
          ),
          title: Text('Nama Lengkap'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('STT Terpadu Nurul Fikri'),
              Text('Veritied email at ...'),
            ],
          ),
          trailing: IconButton(
              onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_rounded)),
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget _buildArticle() {
    return ListView.separated(
      // physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const ListTile(
          title: Text(
              'Perancangan Web E-Commerce Umkm Restoran Bakso Arema Menggunakan Framework Laravel'),
          subtitle: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('AZ Muchtar, S Munir'),
                Text('Jurnal'),
              ],
            ),
          ),
          trailing: Text('20'),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}

Widget _buildCitedBy() {
  List<DataColumn> dataColumn = [
    const DataColumn(
      numeric: false,
      label: Text(''),
    ),
    const DataColumn(
      numeric: true,
      label: Text('All'),
    ),
    const DataColumn(
      numeric: true,
      label: Text('Since 2019'),
    ),
  ];
  List<DataRow> dataRow = [
    const DataRow(
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Citations'),
              Text('h-index'),
              Text('i10-index'),
            ],
          ),
        ),
        DataCell(
          Column(
            children: [
              Text('data'),
              Text('data'),
              Text('data'),
            ],
          ),
        ),
        DataCell(
          Column(
            children: [
              Text('data'),
              Text('data'),
              Text('data'),
            ],
          ),
        ),
      ],
    ),
  ];
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              headingRowHeight: 56,
              dataRowMinHeight: 56,
              dataRowMaxHeight: 108,
              columns: dataColumn,
              rows: dataRow,
            ),
          ))
        ],
      ),
      // _buildChartCitedBy()
    ],
  );
}

BarChart _buildChartCitedBy() {
  return BarChart(
    BarChartData(
      barTouchData: BarTouchData(),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            // getTitlesWidget: (value, meta) {
            //   String text;
            //   switch (value.toInt()) {
            //     case 0:
            //     text =
            //   }
            //   return SideTitleWidget(child: text, axisSide: meta.axisSide);
            // },
          ),
        ),
      ),
    ),
  );
}
