// presentation/widgets/recent_likes_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:found_you_app/ui/common_widgets/neo_card_recent_likes.dart';
import 'package:found_you_app/ui/common_widgets/neo_circle_card.dart';
import 'package:found_you_app/ui/recent_likes/view_models/recent_likes_view_model.dart';

class RecentLikesView extends StatelessWidget {
  const RecentLikesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RecentLikesViewModel>();

    if (vm.isLoading && vm.suggestedFriends.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: Colors.black));
    }

    if (vm.suggestedFriends.isEmpty) {
      return const Center(child: Text("No recent likes found."));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Recent Likes",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        // Załóżmy, że NeoCardRecentLikes przyjmuje SuggestedFriendModel jako „like”
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vm.suggestedFriends.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final friend = vm.suggestedFriends[index];
            return NeoCardRecentLikes(friend: friend);
          },
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ],
    );
  }
}
