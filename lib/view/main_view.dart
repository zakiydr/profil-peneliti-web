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
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
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
                              text: const TextSpan(children: [
                                TextSpan(
                                    text:
                                        'Verified email at nurulfikri.ac.id - '),
                                TextSpan(
                                  text: 'Homepage',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
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
              SliverToBoxAdapter(
                child: Consumer<TabBarViewModel>(
                  builder: (
                    context,
                    value,
                    child,
                  ) {
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
                  article: const Text('1'),
                  citedBy: const Text('2'),
                  coAuthors: const Text('3'),
                  controller: value.profileTabController);
            },
          ),
        ),
      ),
    );
  }
}
