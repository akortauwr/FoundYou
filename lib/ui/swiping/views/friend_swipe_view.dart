import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_button.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';
import 'package:found_you_app/ui/common_widgets/neo_select_display.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:found_you_app/ui/swiping/view_models/friend_swipe_view_model.dart';
import 'package:provider/provider.dart';

/// Ekran „swipe” użytkowników w stylu Tinder.
class UserSwipeView extends StatelessWidget {
  const UserSwipeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserSwipeViewModel>(
        builder: (_, viewModel, __) {
          if (viewModel.isLoading && viewModel.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.users.isEmpty) {
            return const Center(child: Text('Brak użytkowników do wyświetlenia.'));
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 64, 16, 32),
            child: Stack(
              children: [
                CardSwiper(
                  key: ValueKey(viewModel.users.length),
                  cardsCount: viewModel.users.length,
                  numberOfCardsDisplayed: min(3, viewModel.users.length),
                  onSwipe: (prevIndex, direction, _) {
                    final user = viewModel.users.elementAt(prevIndex);
                    viewModel.onSwipe(user, direction);
                    return true;
                  },
                  cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                    final user = viewModel.users.elementAt(index);
                    return _buildCard(context, user);
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NeoIconButton(
                        child: Icon(Icons.close),
                        backgroundColor: NeoColors.tomatoRed,
                        onPressed: () => viewModel.onSwipe(viewModel.users.last, 0),
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      ),
                      NeoIconButton(
                        child: Stack(
                          children: [
                            Icon(Icons.favorite, color: Colors.red, size: 32),
                            Icon(Icons.favorite_border, color: Colors.black, size: 32),
                          ],
                        ),
                        backgroundColor: NeoColors.springGreen,
                        onPressed: () => viewModel.onSwipe(viewModel.users.last, 1),
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, SuggestedFriendModel user) {
    return GestureDetector(
      child: NeoCard(
        margin: const EdgeInsets.only(bottom: 64),
        padding: const EdgeInsets.all(0),
        borderWidth: 6,
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child:
                  user.imageUrl != null
                      ? Image.network(user.imageUrl!, fit: BoxFit.cover)
                      : Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.person, size: 100, color: Colors.grey),
                      ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: NeoCard(
                color: Colors.white.withValues(alpha: 0.4),
                margin: const EdgeInsets.only(left: 8, right: 6, bottom: 16),
                borderRadius: BorderRadius.circular(0),
                boxShadow: const [BoxShadow(color: Colors.transparent, offset: Offset(0, 0))],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${user.username}, ${user.age}',
                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(user.bio, style: const TextStyle(color: Colors.black, fontSize: 14)),
                    const SizedBox(height: 4),
                    NeoSelectDisplay(labels: user.passions, maxToShow: 5),
                    const SizedBox(height: 8),
                    // Action buttons: like and decline
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
