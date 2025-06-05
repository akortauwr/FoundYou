import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_view_data.dart';
import 'package:found_you_app/ui/near_you/view_models/near_you_view_model.dart';
import 'package:provider/provider.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NearYouView extends StatefulWidget {
  const NearYouView({Key? key}) : super(key: key);

  @override
  State<NearYouView> createState() => _NearYouViewState();
}

class _NearYouViewState extends State<NearYouView> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NearYouViewModel>();

    if (vm.isLoading && vm.items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.black),
      );
    }

    if (!vm.isLoading && vm.items.isEmpty) {
      return const Center(child: Text("No suggestions found near you."));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Suggested Friends Near You",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: vm.items.length,
            itemBuilder: (context, index) {
              final data = vm.items[index];
              return _buildAnimatedTile(data: data);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedTile({required SuggestedFriendViewData data}) {
    final vm = context.read<NearYouViewModel>();

    return AnimatedOpacity(
      opacity: data.isLiked ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: data.isLiked
            ? const SizedBox.shrink()
            : _buildTileContent(
          data: data,
          onTapLike: () => vm.likeUser(data),
        ),
      ),
    );
  }

  /// Teraz przyjmujemy cały SuggestedFriendViewData, nie tylko model.
  Widget _buildTileContent({
    required SuggestedFriendViewData data,
    required VoidCallback onTapLike,
  }) {
    final user = data.model; // łatwy alias

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: user.imageUrl != null && user.imageUrl!.isNotEmpty
                ? NetworkImage(user.imageUrl!)
                : const AssetImage('assets/images/default_avatar.png')
            as ImageProvider,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.bio,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTapLike,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  color: data.isLiked
                      ? NeoColors.tomatoRed
                      : Colors.transparent,
                ),
                const Icon(Icons.favorite_border, color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
