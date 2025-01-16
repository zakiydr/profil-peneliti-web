import 'package:flutter/material.dart';
import 'package:profile_peneliti/models/scholars/scholars.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/views/search/search_init.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../providers/features/scholars_provider.dart';
import '../../utils/responsive.dart';
import '../../widgets/search_textfield.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  final page = 1;
  final limit = 10;
  @override
  Widget build(BuildContext context) {
    final scholarsProvider =
        Provider.of<ScholarsProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SearchInit(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: ResponsiveConfig.getPadding(context),
                child: SearchTextField(
                  hintText: 'Ex: Wahyu Universitas Indonesia',
                  controller: scholarsProvider.searchController,
                  focusNode: scholarsProvider.searchFocusNode,
                  onSearch: (value) {
                    scholarsProvider.fetchScholars(value, page, limit);
                  },
                ),
              ),
              Expanded(
                child: Consumer<ScholarsProvider>(
                  builder: (context, value, child) {
                    final scholars = value.scholars;
                    switch (value.state) {
                      case LoadingStates.initial:
                        return Container();
                      case LoadingStates.loading:
                        return Center(child: CircularProgressIndicator());
                      case LoadingStates.empty:
                        return Center(
                            child: Container(child: Text('Not found')));
                      case LoadingStates.success:
                        return _buildSearchView(scholars, textTheme);
                      case LoadingStates.error:
                        return Center(
                          child: Container(
                            child: Text('Failed retrieving data'),
                          ),
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchView(
    Scholars? scholars,
    TextTheme textTheme,
  ) {
    int itemCount() {
      if (scholars!.count! <= limit) {
        return scholars.count!.toInt();
      } else {
        return limit;
      }
    }

    return ListView.separated(
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                "${scholars!.authors![index].urlPicture}",
              ),
              child: ClipOval(
                  // borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                "${scholars.authors![index].urlPicture}",
                // fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              )),
            ),
            title: Text(
              scholars.authors![index].name.toString(),
              style: textTheme.titleMedium,
            ),
            subtitle: Text(
              scholars.authors![index].affiliation.toString(),
              style: textTheme.labelMedium,
            ),
            onTap: () {
              final scholarDetailProvider =
                  context.read<ScholarDetailProvider>();

              Navigator.of(context).pushNamed('/dashboard');

              scholarDetailProvider
                  .fetchScholarProfile(scholars.authors![index].scholarId)
                  .catchError((error) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to load scholar details')));
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              height: 5,
            ),
        itemCount: itemCount());
  }
}
