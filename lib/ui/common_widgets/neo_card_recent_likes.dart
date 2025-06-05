import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NeoCardRecentLikes extends StatelessWidget {
  final SuggestedFriendModel friend;

  const NeoCardRecentLikes({
    super.key,
    required this.friend,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: NeoCard(
        color: NeoColors.randomPastel(),
        borderRadius: BorderRadius.circular(16),
        width: 124,
        child: Column(
          mainAxisSize: MainAxisSize.min, // So column doesn't expand infinitely
          children: [
            Container(
              width: 64, // Adjusted size for better proportionality
              height: 64,
              padding: const EdgeInsets.all(4), // Padding inside the circle
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 3), // Slightly thinner border
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(4, 4),
                    blurRadius: 0,
                  )
                ],
              ),
              child: ClipOval(
                child: friend.imageUrl != null && friend.imageUrl!.isNotEmpty
                    ? Image.network(
                  friend.imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
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
            const SizedBox(height: 12),
            Text(
              'Filip_guwnoooooo',//friend.username,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}