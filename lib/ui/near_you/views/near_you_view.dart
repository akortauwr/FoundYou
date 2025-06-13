import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_friend_profile.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:found_you_app/ui/near_you/view_models/near_you_view_model.dart';
import 'package:provider/provider.dart';

class NearYouView extends StatefulWidget {
  const NearYouView({super.key});

  @override
  State<NearYouView> createState() => _NearYouViewState();
}

class _NearYouViewState extends State<NearYouView> {
  final _listKey = GlobalKey<AnimatedListState>();
  final List<SuggestedFriendModel> _localFriends = [];
  bool _isInitialDataLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  Future<void> _loadInitialData() async {
    if (!mounted) return;
    final vm = context.read<NearYouViewModel>();

    await vm.fetchSuggestedFriends();

    if (!mounted) return;
    final initialFriends = vm.suggestedFriends;

    for (int i = 0; i < initialFriends.length; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      if (!mounted) return;
      _localFriends.add(initialFriends[i]);
      _listKey.currentState?.insertItem(i);
    }

    if (mounted) {
      setState(() {
        _isInitialDataLoaded = true;
      });
    }
  }

  Future<void> _handleLike(SuggestedFriendModel user, int index) async {
    final vm = context.read<NearYouViewModel>();
    if (vm.isLikingUser(user.id)) return;

    final removedItem = _localFriends.removeAt(index);
    _listKey.currentState?.removeItem(
      index,

      (context, animation) => _buildAnimatingTile(removedItem, animation),
      duration: const Duration(milliseconds: 400),
    );

    final bool success = await vm.likeUser(user.id);

    if (!success && mounted) {
      await Future.delayed(const Duration(milliseconds: 500));
      _localFriends.insert(index, removedItem);
      _listKey.currentState?.insertItem(index);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text("Failed to like user. Please try again.")));
    }
  }

  Widget _buildAnimatingTile(SuggestedFriendModel user, Animation<double> animation) {
    return SizeTransition(
      key: ValueKey(user.id),
      sizeFactor: animation,
      child: _buildTile(user: user, onTap: () {}, backgroundColor: NeoColors.tomatoRed),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NearYouViewModel>();

    if (vm.isLoading && !_isInitialDataLoaded) {
      return const Center(child: CircularProgressIndicator(color: Colors.black));
    }

    if (!vm.isLoading && _localFriends.isEmpty && _isInitialDataLoaded) {
      return const Center(
        child: Text(
          "Brak użytkowników w pobliżu.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Blisko ciebie", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
        AnimatedList(
          key: _listKey,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          initialItemCount: _localFriends.length,
          itemBuilder: (context, index, animation) {
            final user = _localFriends[index];
            return SizeTransition(
              key: ValueKey(user.id),
              sizeFactor: animation,
              child: _buildTile(user: user, onTap: () => _handleLike(user, index), backgroundColor: Colors.white),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTile({required SuggestedFriendModel user, required VoidCallback onTap, required backgroundColor}) {
    final isLiking = context.watch<NearYouViewModel>().isLikingUser(user.id);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
                child: NeoFriendProfile(user: user),
              ),
            );
          },
        );
      },
      child: NeoCard(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 4)),
              child: CircleAvatar(
                radius: 24,
                backgroundImage:
                    user.imageUrl != null && user.imageUrl!.isNotEmpty
                        ? NetworkImage(user.imageUrl!)
                        : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.bio,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child:
                  isLiking
                      ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.0, color: Colors.black),
                      )
                      : Stack(
                        children: [
                          Icon(Icons.favorite, color: backgroundColor),
                          const Icon(Icons.favorite_border, color: Colors.black),
                        ],
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
