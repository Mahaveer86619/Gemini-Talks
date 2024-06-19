import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gemini_talks/features/landing/view/components/message_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgController = TextEditingController();

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

  _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Hero(
          tag: 'chat',
          child: MessageField(
            hintText: 'Message',
            controller: msgController,
          ),
        ),
      ],
    );
  }
}