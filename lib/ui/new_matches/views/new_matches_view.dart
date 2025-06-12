// presentation/widgets/new_matches_widget.dart
import 'dart:async'; // Potrzebne do StreamSubscription
import 'package:flutter/material.dart';
import 'package:found_you_app/routing/paths.dart';
import 'package:found_you_app/ui/common_widgets/neo_card_new_matches.dart';
import 'package:found_you_app/ui/new_matches/view_models/new_matches_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// --- KROK 1: Konwertuj na StatefulWidget ---
class NewMatchesView extends StatefulWidget {
  const NewMatchesView({super.key});

  @override
  State<NewMatchesView> createState() => _NewMatchesViewState();
}

class _NewMatchesViewState extends State<NewMatchesView> {
  StreamSubscription? _navigationSubscription;

  // --- KROK 2: Nasłuchuj na zdarzenia z ViewModelu ---
  @override
  void initState() {
    super.initState();
    // Użyj addPostFrameCallback, aby mieć pewność, że context jest gotowy do nawigacji
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<NewMatchesViewModel>();
      _navigationSubscription = vm.navigationEvents.listen((event) {
        // Sprawdź typ zdarzenia i wykonaj odpowiednią akcję
        if (event is NavigateToChat) {
          context.push('/chats/conversation/${event.chat.id}', extra: event.user);
        }
      });
    });
  }

  // --- KROK 3: Pamiętaj o anulowaniu subskrypcji ---
  @override
  void dispose() {
    _navigationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NewMatchesViewModel>();

    if (vm.isLoading && vm.suggestedFriends.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: Colors.black));
    }

    if (vm.suggestedFriends.isEmpty) {
      return const Center(child: Text("Brak nowych par.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
          color: Colors.black)));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Nowe pary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
        SizedBox(
          height: 84,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vm.suggestedFriends.length,
            itemBuilder: (context, index) {
              final friend = vm.suggestedFriends[index];
              return NeoCardNewMatches(
                friend: friend,
                // --- KROK 4: Uprość wywołanie w onPressed ---
                // Teraz tylko informujemy ViewModel o akcji użytkownika
                onPressed: () {
                  vm.selectFriend(friend);
                },
              );
            },
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
        ),
      ],
    );
  }
}
