import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gemini_talks/core/themes/pallet.dart';
import 'package:gemini_talks/features/landing/view/components/message_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgController = TextEditingController();

  _onSendPressed(String msg) {
    //* send message
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _buildBody(),
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      automaticallyImplyLeading: true,
      actions: [
        GestureDetector(
          onTap: () {
            //* save chat to history
          },
          child: SvgPicture.asset(
            'assets/icons/save.svg',
            semanticsLabel: 'Save',
            width: 18,
            height: 18,
            theme: SvgTheme(
              currentColor: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {
            //* dont know what to do here
          },
          icon: Icon(
            Icons.more_vert_sharp,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  _buildMsgInput() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MessageField(hintText: 'Message', controller: msgController),
          Hero(
            tag: 'chat_btn',
            child: GestureDetector(
              onTap: () {
                _onSendPressed(msgController.text);
                setState(() {
                  msgController.clear();
                });
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Pallete.gradient1,
                      Pallete.gradient2,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Icon(
                  Icons.send,
                  size: 22,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildMsgInput(),
        ],
      ),
    );
  }
}
