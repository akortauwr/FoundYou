import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_select_display.dart';

class NeoFriendProfile extends StatelessWidget {
  final SuggestedFriendModel user;

  const NeoFriendProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return NeoCard(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
