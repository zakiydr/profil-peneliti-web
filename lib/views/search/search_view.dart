import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profile_peneliti/extension/string_extension.dart';
import 'package:profile_peneliti/models/scholars/scholars.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/views/search/search_init.dart';
import 'package:profile_peneliti/widgets/app_fa_icon.dart';
import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';
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
    final google = context.read<GoogleAuthProvider>();
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
                    // scholarsProvider.fetchScholars(value, page, limit);
                    scholarsProvider.fetchScholars(value);
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
                        return const Center(child: CircularProgressIndicator());
                      case LoadingStates.empty:
                        return Center(
                            child: Container(
                                child: const Text('Profile not found')));
                      case LoadingStates.success:
                        return _buildSearchView(scholars, textTheme);
                      case LoadingStates.error:
                        return Center(
                          child: Container(
                            child: const Text('Failed retrieving data'),
                          ),
                        );
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
    double radius = 50;

    return ListView.separated(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipOval(
              // radius: 30,
              // backgroundColor: Colors.transparent,
              // child: CachedNetworkImageProvider(
              //   headers: {
              //     "Access-Control-Allow-Headers":
              //         "Access-Control-Allow-Origin, Accept"
              //   },
              //   scholars!.authors![index].urlPicture.toString(),
              // ),
              child: CachedNetworkImage(
                height: radius,
                width: radius,
                fit: BoxFit.cover,
                imageUrl: scholars.authors![index].urlPicture.toString(),
                httpHeaders: const {
                  "Access-Control-Allow-Headers":
                      "Access-Control-Allow-Origin, Accept"
                },
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const AppFaIcon(FontAwesomeIcons.circleExclamation),
              ),
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

              Navigator.of(context).pushNamed(AppRoutes.dashboard);

              scholarDetailProvider
                  .fetchScholarProfile(scholars.authors![index].scholarId ?? '')
                  .catchError((error) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Failed to load scholar details')));
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
        itemCount: scholars!.authors!.length);
  }
}
