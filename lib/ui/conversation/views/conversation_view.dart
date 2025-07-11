import 'package:flutter/material.dart';
import 'package:found_you_app/ui/common_widgets/neo_app_bar.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';
import 'package:found_you_app/ui/common_widgets/neo_text_field.dart';
import 'package:provider/provider.dart';

import '../view_models/conversation_view_model.dart';

class ConversationView extends StatefulWidget {
  const ConversationView({super.key});

  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConversationViewModel>();

    return Scaffold(
      appBar: NeoAppBar(text: vm.chatPartner.username),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: vm.messages.length,
                itemBuilder: (context, index) {
                  final msg = vm.messages[index];
                  final isMe = vm.isCurrentUser(msg.senderId);

                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: NeoCard(
                      color: isMe ? Colors.blue[100]! : Colors.grey[200]!,
                      borderRadius:
                          isMe
                              ? const BorderRadius.only(topRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                              : const BorderRadius.only(topLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(msg.content, style: const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Row(
                children: [
                  Expanded(child: NeoTextField(controller: _controller, label: 'Wiadomość')),
                  NeoIconButton(
                    child: const Icon(Icons.send),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        vm.sendMessage(_controller.text);
                        _controller.clear();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent + 60,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                          );
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
