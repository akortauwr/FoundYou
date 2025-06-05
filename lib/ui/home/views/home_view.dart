// presentation/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:found_you_app/ui/home/view_models/home_view_model.dart';
import 'package:found_you_app/ui/new_matches/views/new_matches_view.dart';
import 'package:found_you_app/ui/recent_likes/views/recent_likes_view.dart';
import 'package:found_you_app/ui/near_you/views/near_you_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pobieramy główny HomeViewModel (który jest ProxyProviderem łączącym trzy podrzędne)
    final homeVM = context.watch<HomeViewModel>();

    if (homeVM.isLoading) {
      // Pokaż wspólny spinner dopóki którakolwiek sekcja się ładuje
      return const Center(child: CircularProgressIndicator(color: Colors.black));
    }

    // Gdy żaden z pod-WM-ów nie ładuje – pokazujemy wszystkie podwidoki jeden pod drugim
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
      child: Column(
        children: const [
          NewMatchesView(),
          SizedBox(height: 16),
          RecentLikesView(),
          SizedBox(height: 16),
          NearYouView(),
        ],
      ),
    );
  }
}
