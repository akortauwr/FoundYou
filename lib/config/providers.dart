import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository_network.dart';
import 'package:found_you_app/data/repositories/auth/auth_repositry_dev.dart';
import 'package:found_you_app/data/repositories/messenger/messenger_repository.dart';
import 'package:found_you_app/data/repositories/messenger/messenger_repository_network.dart';
import 'package:found_you_app/data/repositories/profile/profile_repository.dart';
import 'package:found_you_app/data/repositories/profile/profile_repository_network.dart';
import 'package:found_you_app/data/repositories/suggested_friends/suggested_friends_repository.dart';
import 'package:found_you_app/data/repositories/suggested_friends/suggested_friends_repository_network.dart';
import 'package:found_you_app/data/services/api/auth_api_client.dart';
import 'package:found_you_app/data/services/api/foundyou_api_client.dart';
import 'package:found_you_app/data/services/secure_storage_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final authApiClient = AuthApiClient();
final secureStorageService = SecureStorageService();

List<SingleChildWidget> get providersDev {
  return [ChangeNotifierProvider<AuthRepository>(create: (_) => AuthRepositoryDev())];
}

List<SingleChildWidget> get providersRemote {
  return [
    Provider<AuthApiClient>(create: (_) => authApiClient),
    Provider<SecureStorageService>(create: (_) => secureStorageService),
    Provider<FoundYouApiClient>(create: (_) => FoundYouApiClient()),
    ChangeNotifierProvider<AuthRepository>(
      create: (_) => AuthRepositoryNetwork(authApiClient: authApiClient, secureStorageService: secureStorageService),
    ),
    Provider<ProfileRepository>(
      create: (context) => ProfileRepositoryNetwork(apiClient: context.read<FoundYouApiClient>()),
    ),
    Provider<SuggestedFriendsRepository>(
      create: (context) => SuggestedFriendsRepositoryNetwork(apiClient: context.read<FoundYouApiClient>()),
    ),
    Provider<MessengerRepository>(
      create: (context) => MessengerRepositoryNetwork(apiClient: context.read<FoundYouApiClient>()),
    ),
  ];
}
