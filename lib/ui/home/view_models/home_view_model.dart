import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/friends/friend_repository.dart';
import 'package:found_you_app/data/repositories/friends/friend_repository_network.dart';
import 'package:found_you_app/domain/models/friend_model/friend_model.dart';
import 'package:found_you_app/utils/command.dart';
import 'package:found_you_app/utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  //final FriendRepository _friendRepository;
  late Command1 getFriend;
  FriendModel? _friend;

  FriendModel? get friend => _friend;

  HomeViewModel() {

  }

  final List<UserProfile> newMatches = [
    UserProfile(name: 'Helena', imageUrl: 'https://example.com/image1.jpg'),
    UserProfile(name: 'Jessica', imageUrl: 'https://example.com/image2.jpg'),
    UserProfile(name: 'Jenny', imageUrl: 'https://example.com/image3.jpg'),
    UserProfile(name: 'Eleanor', imageUrl: 'https://example.com/image4.jpg'),
  ];

  final List<DateProfile> yourDates = [
    DateProfile(name: 'Carol', imageUrl: 'https://example.com/image5.jpg', bgColor: Colors.lightBlue.shade100),
    DateProfile(name: 'Anna', imageUrl: 'https://example.com/image6.jpg', bgColor: Colors.purple.shade100),
    DateProfile(name: 'Julie', imageUrl: 'https://example.com/image7.jpg', bgColor: Colors.orange.shade100),
  ];

  final List<UserProfileExtended> nearYou = [
    UserProfileExtended(name: 'Carol Sky', imageUrl: 'https://example.com/image8.jpg', location: 'Indonesia'),
    UserProfileExtended(name: 'Emma Brown', imageUrl: 'https://example.com/image9.jpg', location: 'Poland'),
  ];



  Future<Result<void>> _loadFriend(int friendId) async {

    return Result.ok(null);
  }
}

class UserProfile {
  final String name;
  final String imageUrl;

  UserProfile({required this.name, required this.imageUrl});
}

class DateProfile {
  final String name;
  final String imageUrl;
  final Color bgColor;

  DateProfile({required this.name, required this.imageUrl, required this.bgColor});
}

class UserProfileExtended {
  final String name;
  final String imageUrl;
  final String location;

  UserProfileExtended({required this.name, required this.imageUrl, required this.location});
}
