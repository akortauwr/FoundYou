import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/ui/profile/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
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
    if (today.month < user.birthday.month ||
        (today.month == user.birthday.month && today.day < user.birthday.day)) {
      age--;
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],  // jasne tło dla kontrastu z kartami
      appBar: AppBar(
        title: Text("Profil użytkownika"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Karta z informacjami o użytkowniku
              ProfileInfoCard(user: user, age: age),
              const SizedBox(height: 20),
              // Karta z przyciskami ustawień
              SettingsCard(
                onChangePassword: () => {},
                onLogout: () {
                  // Logika wylogowania
                  // vm.logout();
                  Navigator.pushNamed(context, '/login');
                },
                onTermsOfService: () {
                  // Logika regulaminu
                  Navigator.pushNamed(context, '/terms');
                },
                onRules: () {
                  // Logika zasad korzystania
                  Navigator.pushNamed(context, '/rules');
                },
                onEditProfile: () {
                  // Logika edytowania profilu
                  Navigator.pushNamed(context, '/edit_profile');
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
  const ProfileInfoCard({Key? key, required this.user, required this.age}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // delikatny cień
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Zdjęcie profilowe lub ikona domyślna
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: (user.imageUrl != null && user.imageUrl!.isNotEmpty)
                  ? NetworkImage(user.imageUrl!)
                  : null,
              child: (user.imageUrl == null || user.imageUrl!.isEmpty)
                  ? Icon(Icons.person, size: 50, color: Colors.grey[700])
                  : null,
            ),
            const SizedBox(height: 16),
            // Imię i wiek użytkownika
            Text(
              "${user.username}, $age",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Bio / opis użytkownika
            Text(
              user.bio,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Liczba znajomych
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.group, size: 20, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '${user.friendCount} znajomych',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Pasje użytkownika jako Chips
            if (user.passions.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pasje:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: user.passions.map((p) => Chip(
                  label: Text(p),
                  backgroundColor: Colors.grey[200],
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Widget karty ustawień z przyciskami "Zmień hasło" i "Wyloguj się"
class SettingsCard extends StatelessWidget {
  final VoidCallback onChangePassword;
  final VoidCallback onLogout;
  final VoidCallback onTermsOfService;
  final VoidCallback onRules;
  final VoidCallback onEditProfile;

  const SettingsCard({
    Key? key,
    required this.onChangePassword,
    required this.onLogout,
    required this.onTermsOfService,
    required this.onRules,
    required this.onEditProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Zmień hasło'),
            onTap: onChangePassword,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Regulamin'),
            onTap: onTermsOfService,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.rule),
            title: const Text('Zasady korzystania'),
            onTap: onRules,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edytuj dane'),
            onTap: onEditProfile,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Wyloguj się'),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}