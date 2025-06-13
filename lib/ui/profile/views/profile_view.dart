import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/routing/paths.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';
import 'package:found_you_app/ui/common_widgets/neo_select_display.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:found_you_app/ui/profile/view_models/profile_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();

    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final user = vm.userModel;
    if (user == null) {
      return const Center(child: Text('Brak danych użytkownika'));
    }

    final today = DateTime.now();
    int age = today.year - user.birthday.year;
    if (today.month < user.birthday.month || (today.month == user.birthday.month && today.day < user.birthday.day)) {
      age--;
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(32.0, 64, 32.0, 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileInfoCard(user: user, age: age),
              const SizedBox(height: 20),
              SettingsCard(
                onChangePassword: () {
                  context.push(Paths.resetPassword);
                },
                onLogout: () {
                  vm.logout();
                  context.go(Paths.login);
                },
                onTermsOfService: () {
                  Navigator.pushNamed(context, '/terms');
                },
                onRules: () {
                  Navigator.pushNamed(context, '/rules');
                },
                onEditProfile: () {
                  context.pushNamed('editData', extra: user);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final UserModel user;
  final int age;

  const ProfileInfoCard({super.key, required this.user, required this.age});

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      margin: const EdgeInsets.all(0),
      color: NeoColors.lightPurple,
      child: Column(
        children: [
          Container(
            width: 164,
            height: 164,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 4),
              boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(3, 3), blurRadius: 0)],
            ),
            child: user.imageUrl != null ? ClipOval(child: Image.network(user.imageUrl!)) : Container(),
          ),
          const SizedBox(height: 16),

          Text(
            "${user.username}, $age",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          NeoCard(
            borderRadius: const BorderRadius.all(Radius.zero),
            child: Text(
              user.bio,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),

          NeoCard(
            borderRadius: const BorderRadius.all(Radius.zero),
            width: 128,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.group),
                const SizedBox(width: 6),
                Text('${user.friendCount}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          if (user.passions.isNotEmpty) ...[NeoSelectDisplay(labels: user.passions, maxToShow: 5, fontSize: 16.0)],
        ],
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final VoidCallback onChangePassword;
  final VoidCallback onLogout;
  final VoidCallback onTermsOfService;
  final VoidCallback onRules;
  final VoidCallback onEditProfile;

  const SettingsCard({
    super.key,
    required this.onChangePassword,
    required this.onLogout,
    required this.onTermsOfService,
    required this.onRules,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(32),
      borderRadius: const BorderRadius.all(Radius.zero),

      child: Column(
        children: [
          _buildTile(icon: Icons.lock, title: 'Zmień hasło', onTap: onChangePassword),
          const SizedBox(height: 16),
          _buildTile(icon: Icons.description, title: 'Regulamin', onTap: onTermsOfService),
          const SizedBox(height: 16),
          _buildTile(icon: Icons.rule, title: 'Zasady korzystania', onTap: onRules),

          const SizedBox(height: 16),
          _buildTile(icon: Icons.edit, title: 'Edytuj dane', onTap: onEditProfile),
          const SizedBox(height: 16),
          _buildTile(icon: Icons.logout, title: 'Wyloguj się', onTap: onLogout),
        ],
      ),
    );
  }

  Widget _buildTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return Row(
      children: [
        NeoIconButton(
          onPressed: onTap,
          backgroundColor: NeoColors.mossGreen,
          shadowOffset: const Offset(4, 4),
          child: Icon(icon, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
      ],
    );
  }
}
