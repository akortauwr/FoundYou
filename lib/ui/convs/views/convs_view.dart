import 'package:flutter/material.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/convs/view_models/convs_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ConversationsListView extends StatelessWidget {
  const ConversationsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConversationsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Twoje czaty')),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: vm.conversations.length,
        itemBuilder: (context, index) {
          final chat = vm.conversations[index];
          return GestureDetector(
            onTap: () => context.push('/chat/${1}'),
            child: NeoCard(
              child: ListTile(
                leading: Icon(Icons.person),
                // title: Text(chat.friend.username),
                // subtitle: Text(chat.lastMessage),
                trailing: Text(
                  TimeOfDay.fromDateTime(chat.lastMessageTime).format(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
