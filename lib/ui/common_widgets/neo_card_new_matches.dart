import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_friend_profile.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NeoCardNewMatches extends StatelessWidget {
  final SuggestedFriendModel friend;
  final VoidCallback onPressed;

  const NeoCardNewMatches({super.key, required this.friend, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeoIconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
                  child: Stack(
                    children: [
                      NeoFriendProfile(user: friend),
                      SizedBox(height: 8,),
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
                              onPressed: () => Navigator.of(context).pop(),
                              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                            ),
                            NeoIconButton(
                              child: Stack(
                                children: [
                                  Icon(Icons.chat_bubble, color: Colors.white, size: 32),
                                  Icon(Icons.chat_bubble_outline, color: Colors.black, size: 32),
                                ],
                              ),
                              backgroundColor: NeoColors.springGreen,
                              onPressed: () {
                                onPressed();
                                Navigator.of(context).pop();
                              },
                              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        height: 64,
        width: 64,
        padding: const EdgeInsets.all(0),
        backgroundColor: Colors.white,

        child: ClipRect(
          child:
              friend.imageUrl != null && friend.imageUrl!.isNotEmpty
                  ? Image.network(
                    friend.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value:
                              loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 60, color: Colors.grey);
                    },
                  )
                  : const Icon(Icons.person, size: 60, color: Colors.grey), // Placeholder icon
        ),
      ),
    );
  }
}
