import 'package:botgpt/user.dart';
import 'package:botgpt/conversation.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

Future<void> main() async {
  const String token = "";
  const int adminId = 6559889263;
  final username = (await Telegram(token).getMe()).username;
  var teledart = TeleDart(token, Event(username!));
  List<String> conversation = [];

  teledart.start();

  // teledart
  //     .onMessage(
  //   entityType: 'bot_command',
  //   keyword: 'start',
  // )
  //     .listen(
  //   (message) async {
  //     Client user = await addUser(message);
  //     String chatResponse = await chatConversation(
  //       message.text ?? "Hello!",
  //       "Now user or admin entered the bot. This is data of user: ${user.toStr()}",
  //       conversation,
  //     );
  //     teledart.sendMessage(
  //       message.chat.id,
  //       chatResponse,
  //     );
  //   },
  // );

  teledart.onMessage().listen(
    (message) async {
      Client user = await addUser(message);
      String chatResponse = await chatConversation(
        message.text ?? "Hello!",
        message.chat.id == adminId
            ? "Now you are talking with admin of this bot. This is data of admin. You should response to admin: ${user.toStr()}"
            : "Now you are talking with user of this bot. This is data of user. You should response to user: ${user.toStr()}",
        conversation,
      );
      if (parseMessages(chatResponse)[0] != null &&
          parseMessages(chatResponse)[0] != '') {
        teledart.sendMessage(message.chat.id, parseMessages(chatResponse)[0]!);
      }
      if (parseMessages(chatResponse)[1] != null &&
          parseMessages(chatResponse)[1] != '') {
        teledart.sendMessage(message.chat.id, parseMessages(chatResponse)[1]!);
      }
    },
  );
}

List<String?> parseMessages(String input) {
  Map<String, String> result = {};

  List<String> parts = input.split("|");

  for (String part in parts) {
    List<String> keyValue = part.split("=>");

    if (keyValue.length == 2) {
      String key = keyValue[0].trim();
      String value = keyValue[1].trim();
      result[key] = value;
    }
  }

  return [
    result['forAdmin'],
    result['forUser'],
    result['forSystem'],
  ];
}
