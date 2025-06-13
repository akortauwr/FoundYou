import 'package:flutter/material.dart';
import 'package:found_you_app/ui/home/view_models/home_view_model.dart';
import 'package:found_you_app/ui/near_you/views/near_you_view.dart';
import 'package:found_you_app/ui/new_matches/views/new_matches_view.dart';
import 'package:found_you_app/ui/recent_likes/views/recent_likes_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeVM = context.watch<HomeViewModel>();

    if (homeVM.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.black));
    }

    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
      child: Column(
        children: [
          SizedBox(height: 24),
          NewMatchesView(),
          SizedBox(height: 24),
          RecentLikesView(),
          SizedBox(height: 24),
          NearYouView(),
        ],
      ),
    );
  }
}
