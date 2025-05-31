// presentation/widgets/new_matches_widget.dart
import 'package:flutter/material.dart';
import 'package:found_you_app/ui/common_widgets/neo_card_recent_likes.dart';
import 'package:found_you_app/ui/common_widgets/neo_circle_card.dart';
import 'package:found_you_app/ui/new_matches/view_models/new_matches_view_model.dart';
import 'package:provider/provider.dart';

class NewMatchesView extends StatelessWidget {
  const NewMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewMatchesViewModel(),
      child: Consumer<NewMatchesViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.suggestedFriends.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }

          if (viewModel.suggestedFriends.isEmpty) {
            return const Center(child: Text("No new matches found."));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "New Matches",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 220, // Adjust height to fit cards and text
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.suggestedFriends.length,
                  itemBuilder: (context, index) {
                    final friend = viewModel.suggestedFriends[index];
                    return NeoCardRecentLikes(friend: friend);
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Padding for the list itself
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}