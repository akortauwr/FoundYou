import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/chat_model/chat_model.dart';
import 'package:found_you_app/routing/paths.dart';
import 'package:found_you_app/ui/chats/view_models/chats_view_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Czaty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // Dobrze jest dodać, aby usunąć cień przy przezroczystym tle
      ),
      // Używamy operatora trójargumentowego '?' i ':' do logiki warunkowej
      body: vm.isLoading && vm.chats.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : vm.chats.isEmpty
          ? const Center(
        child: Text(
          "Brak czatów.",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: vm.chats.length,
        itemBuilder: (context, index) {
          final chat = vm.chats[index];
          return GestureDetector(
            onTap: () => context.push('${Paths.chats}/conversation/${chat.id}/', extra: chat.member),
            child: NeoCard(
              // Użyjmy marginesu pionowego dla lepszych odstępów
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: ListTile(
                // Lepiej użyć awatara użytkownika niż statycznej ikony
                leading: CircleAvatar(
                  // Załóżmy, że model 'member' ma imageUrl, podobnie jak w poprzednim widoku
                  backgroundImage: chat.member.imageUrl != null && chat.member.imageUrl!.isNotEmpty
                      ? NetworkImage(chat.member.imageUrl!)
                      : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                ),
                title: Text(chat.member.username),
                // Odkomentuj i upewnij się, że 'newestMessage' nie jest nullem
                subtitle: chat.newestMessage != null
                    ? Text(
                  chat.newestMessage!.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
                    : const SizedBox.shrink(), // Jeśli nie ma wiadomości, nie pokazuj nic
                // To pokazuje aktualny czas, a nie czas wiadomości!
                trailing: chat.newestMessage != null
                    ? Text(TimeOfDay.fromDateTime(chat.newestMessage!.createdAt).format(context))
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}