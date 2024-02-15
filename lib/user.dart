import 'package:teledart/model.dart';

Set<Client> clients = <Client>{};

Future<Client> addUser(Message message) async {
  final user = message.from!;
  Client client = Client(
    name: user.firstName,
    username: user.username,
    userId: user.id,
    // chatId: message.chat.id,
  );
  clients.add(client);
  return client;
}

class Client {
  String? name;
  String? username;
  int? userId;
  // int? chatId;

  Client({
    this.name,
    this.username,
    this.userId,
    // this.chatId,
  });

  String toStr() {
    return "Firstname: $name, Username: $username, UserId: $userId"; // , ChatId: chatId
  }
}
