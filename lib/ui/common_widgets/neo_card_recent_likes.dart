import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_friend_profile.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NeoCardRecentLikes extends StatelessWidget {
  final SuggestedFriendModel friend;
  final VoidCallback onLike;
  final VoidCallback onDisslike;

  const NeoCardRecentLikes({super.key, required this.friend, required this.onLike, required this.onDisslike});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
                  child: Stack(
                    children: [
                      NeoFriendProfile(user: friend),
                      const SizedBox(height: 8),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NeoIconButton(
                              backgroundColor: NeoColors.tomatoRed,
                              onPressed: () {
                                onDisslike();
                                Navigator.of(context).pop();
                              },
                              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                              child: const Icon(Icons.close),
                            ),
                            NeoIconButton(
                              backgroundColor: NeoColors.springGreen,
                              onPressed: () {
                                onLike();
                                Navigator.of(context).pop();
                              },
                              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                              child: const Stack(
                                children: [
                                  Icon(Icons.favorite, color: Colors.white, size: 32),
                                  Icon(Icons.favorite_border, color: Colors.black, size: 32),
                                ],
                              ),
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
        child: NeoCard(
          color: NeoColors.randomPastel(),
          borderRadius: BorderRadius.circular(16),
          width: 124,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,

                height: 64,
                padding: const EdgeInsets.all(4),

                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4), blurRadius: 0)],
                ),
                child: ClipOval(
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
                          : const Icon(Icons.person, size: 60, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                friend.username,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
