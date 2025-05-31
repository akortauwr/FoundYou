import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/friend_model/dev_friend_model.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';

/// Pojedyncza karta profilu znajomego.
class FriendCard extends StatelessWidget {
  final SuggestedFriendModel friend;
  const FriendCard({Key? key, required this.friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // wymuś konkretną wysokość kart
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // szare tło lub obrazek
              Positioned.fill(
                child: Container(color: Colors.grey),
              ),

              // gradient na dole karty
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // imię i wiek
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Text(
                  '${friend.username}, ${friend.age}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
