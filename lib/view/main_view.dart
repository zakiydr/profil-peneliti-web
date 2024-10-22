import 'package:flutter/material.dart';
import 'package:profile_peneliti/utils/ticker_provider.dart';
import 'package:profile_peneliti/view_model/tab_bar_view_model.dart';
import 'package:profile_peneliti/widgets/tabbar/profile_tab_bar.dart';
import 'package:profile_peneliti/widgets/tabbar/profile_tab_bar_view.dart';
import 'package:provider/provider.dart';

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
                                  maxRadius: 128,
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
                coAuthors: const Text('3'),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCitedBy() {
    return Column(
      children: [
        DataTable(
          columns: const [
            DataColumn(
              label: Text(''),
            ),
            DataColumn(
              label: Text('All'),
            ),
            DataColumn(
              label: Text('Since 2019'),
            ),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(
                  Text('Citations'),
                ),
                DataCell(
                  Text('250'),
                ),
                DataCell(
                  Text('245'),
                ),
              ],
            ),
          ],
        )
      ],
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
