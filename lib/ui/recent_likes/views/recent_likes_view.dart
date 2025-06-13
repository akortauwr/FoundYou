import 'package:flutter/material.dart';
import 'package:found_you_app/ui/common_widgets/neo_card_recent_likes.dart';
import 'package:found_you_app/ui/recent_likes/view_models/recent_likes_view_model.dart';
import 'package:provider/provider.dart';

class RecentLikesView extends StatelessWidget {
  const RecentLikesView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RecentLikesViewModel>();

    if (vm.isLoading && vm.suggestedFriends.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: Colors.black));
    }

    if (vm.suggestedFriends.isEmpty) {
      return const Center(
        child: Text(
          "Brak nowych polubień.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Nowe polubienia", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),

        SizedBox(
          height: 184,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: vm.suggestedFriends.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final friend = vm.suggestedFriends[index];
              return NeoCardRecentLikes(
                friend: friend,
                onTap: () {
                  vm.likeUser(friend.id);
                },
              );
            },
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ],
    );
  }
}
