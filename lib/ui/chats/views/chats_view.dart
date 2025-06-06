import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/chat_model/chat_model.dart';
import 'package:found_you_app/ui/chats/view_models/chats_view_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/conversation/view_models/conversation_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Twoje czaty')),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: vm.chats.length,
        itemBuilder: (context, index) {
          final chat = vm.chats[index];
          return GestureDetector(
            onTap: () => context.push('/chat/${chat.id}', extra: chat.member),
            child: NeoCard(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(chat.member.username),
                // subtitle: Text(chat.newestMessage.content),
                trailing: Text(TimeOfDay.fromDateTime(DateTime.now()).format(context)),
              ),
            ),
          );
        },
      ),
    );
  }
}
