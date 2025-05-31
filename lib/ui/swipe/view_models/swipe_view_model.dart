import 'package:flutter/material.dart';

class SwapViewModel {
  final Profile currentProfile = Profile(
    name: 'Alina Mor',
    age: 27,
    location: 'Surabaya, Indonesia',
    imageUrl: 'https://example.com/alina_mor.jpg',
  );

  final List<ActionButton> bottomButtons = [
    ActionButton(icon: Icons.flash_on, bgColor: Colors.orange.shade100),
    ActionButton(icon: Icons.star, bgColor: Colors.blue.shade100),
    ActionButton(icon: Icons.chat_bubble, bgColor: Colors.green.shade100),
    ActionButton(icon: Icons.card_giftcard, bgColor: Colors.grey.shade200),
  ];
}

class Profile {
  final String name;
  final int age;
  final String location;
  final String imageUrl;

  Profile({
    required this.name,
    required this.age,
    required this.location,
    required this.imageUrl,
  });
}

class ActionButton {
  final IconData icon;
  final Color bgColor;

  ActionButton({required this.icon, required this.bgColor});
}
