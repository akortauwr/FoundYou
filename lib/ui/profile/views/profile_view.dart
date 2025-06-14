import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/routing/paths.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_dialog.dart';
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

    final DateTime birthDate = DateTime.parse(user.birthday);

    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
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
                onTermsOfUse: () {
                  context.push('/profile${Paths.termsOfUse}');
                },
                onRules: () {
                  context.push('/profile${Paths.rules}');
                },
                deleteAccount: () async {
                  final bool? delete = await showDialog(
                    context: context,
                    builder:
                        (context) => Center(
                          child: NeoDialog(
                            content:
                                'Czy na pewno chcesz usunąć '
                                'konto?',
                          ),
                        ),
                  );
                  if (delete == true) {
                    await vm.deleteAccount();
                  }
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
  final VoidCallback onTermsOfUse;
  final VoidCallback onRules;
  final VoidCallback deleteAccount;

  const SettingsCard({
    super.key,
    required this.onChangePassword,
    required this.onLogout,
    required this.onTermsOfUse,
    required this.onRules,
    required this.deleteAccount,
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
          _buildTile(icon: Icons.description, title: 'Regulamin', onTap: onRules),
          const SizedBox(height: 16),
          _buildTile(icon: Icons.rule, title: 'Zasady korzystania', onTap: onTermsOfUse),

          const SizedBox(height: 16),
          _buildTile(icon: Icons.logout, title: 'Wyloguj się', onTap: onLogout),
          const SizedBox(height: 16),
          _buildTile(
            icon: Icons.delete_forever,
            title: 'Usuń konto',
            onTap: deleteAccount,
            backgroundColor: NeoColors.tomatoRed,
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color backgroundColor = NeoColors.mossGreen,
  }) {
    return Row(
      children: [
        NeoIconButton(
          onPressed: onTap,
          backgroundColor: backgroundColor,
          shadowOffset: const Offset(4, 4),
          child: Icon(icon, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
      ],
    );
  }
}
