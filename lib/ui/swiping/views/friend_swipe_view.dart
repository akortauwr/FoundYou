import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_button.dart';
import 'package:found_you_app/ui/common_widgets/neo_friend_profile.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';
import 'package:found_you_app/ui/common_widgets/neo_select_display.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:found_you_app/ui/swiping/view_models/friend_swipe_view_model.dart';
import 'package:provider/provider.dart';

/// Ekran „swipe” użytkowników w stylu Tinder.
class UserSwipeView extends StatefulWidget {
  const UserSwipeView({super.key});

  @override
  State<UserSwipeView> createState() => _UserSwipeViewState();
}

class _UserSwipeViewState extends State<UserSwipeView> {
  final CardSwiperController _swiperController = CardSwiperController();

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

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
                  controller: _swiperController,
                  key: ValueKey(viewModel.users.length),
                  cardsCount: viewModel.users.length,
                  numberOfCardsDisplayed: min(3, viewModel.users.length),
                  allowedSwipeDirection: const AllowedSwipeDirection.only(
                    left: true,
                    right: true,
                  ),
                  onSwipe: (prevIndex, currentIndex, direction) {
                    if(direction == CardSwiperDirection.none) {
                      return false; // No swipe action
                    }
                    final user = viewModel.users.elementAt(prevIndex);
                    viewModel.onSwipe(user, direction);
                    return true;
                  },
                  cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                    final user = viewModel.users.elementAt(index);
                    return NeoFriendProfile(user: user);
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
                        onPressed: () => _swiperController.swipe(CardSwiperDirection.left),
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      ),
                      NeoIconButton(
                        child: Stack(
                          children: [
                            Icon(Icons.favorite, color: Colors.white, size: 32),
                            Icon(Icons.favorite_border, color: Colors.black, size: 32),
                          ],
                        ),
                        backgroundColor: NeoColors.springGreen,
                        onPressed: () => _swiperController.swipe(CardSwiperDirection.right),
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
}
