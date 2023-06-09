import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';


class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _admin = types.User(
    id: const Uuid().v4(),
    firstName: "Joel",
    lastName: "Ayertey"
  );

  final _user = types.User(
    id: const Uuid().v4(),
    firstName: "Jane",
    lastName: "Doe"
  );

  final List<types.Message> _messages = [];

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  void initState() {
    super.initState();

    final userMessage1 = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: "Hi",
    );

    final adminMessage1 = types.TextMessage(
      author: _admin,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: "Hi, how can i help you today?",
    );

    final userMessage2 = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: "I requested for waste collection yesterday and it still hasn't been collected",
    );

    final adminMessage2 = types.TextMessage(
      author: _admin,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: "Sorry about that, please provide me with the waste collection request ID",
    );


    _addMessage(userMessage1);
    _addMessage(adminMessage1);
    _addMessage(userMessage2);
    _addMessage(adminMessage2);
}

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          l10n!.lbl_help,
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        showUserAvatars: false,
        showUserNames: true,
        user: _user,
        theme: DefaultChatTheme(
          backgroundColor: theme.scaffoldBackgroundColor,
          primaryColor: theme.colorScheme.primary,
          inputBackgroundColor: theme.colorScheme.surface,
          inputPadding: EdgeInsets.zero,
          secondaryColor: theme.colorScheme.surface,
          sendButtonIcon: const Icon(CupertinoIcons.paperplane_fill),
          receivedMessageBodyTextStyle: theme.textTheme.bodyMedium!,
          userNameTextStyle: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold
          ),
          sentMessageBodyTextStyle: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.onPrimary
          ),
          inputTextStyle: theme.textTheme.bodyMedium!,
          inputTextColor: theme.colorScheme.onSurface,
          inputBorderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          inputTextDecoration: const InputDecoration(
            fillColor: Colors.transparent
          )
        ),
      ),
    );
  }
}
