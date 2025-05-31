// presentation/widgets/neo_circle_card_widget.dart
import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart'; // Adjust path

class NeoCircleCard extends StatelessWidget {
  final SuggestedFriendModel friend;

  const NeoCircleCard({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 164,
        width: 120,
        decoration: BoxDecoration(
          color: NeoColors.randomPastel(),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black, // Random bright border color
            width: 4, // Slightly thinner border for better proportionality
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(6, 6), // Adjust shadow offset
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 24), // Padding inside the card
        margin: const EdgeInsets.only(bottom: 16, left: 8, right: 8), // Margin around the card
        child: Column(
          mainAxisSize: MainAxisSize.min, // So column doesn't expand infinitely
          children: [
            Container(
              width: 64, // Adjusted size for better proportionality
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: NeoColors.randomBright(), width: 3), // Slightly thinner border
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
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
              friend.username,
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