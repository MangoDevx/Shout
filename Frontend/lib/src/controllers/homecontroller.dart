import '../../auth.dart';

Future<void> signOut() async {
  await Auth().signOut();
}

Future<void> sendMessage(String message) async {
  // TODO: send message to server to broadcast to other devices

}