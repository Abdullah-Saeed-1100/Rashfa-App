import 'package:rashfa_app/constant/message.dart';

validInput(String val, int min, int max) {
  if (val.isEmpty) {
    return messageInputEmpty;
  }
  if (val.length < min) {
    return "$messageInputMin  $min";
  }
  if (val.length > max) {
    return "$messageInputMax  $max";
  }
}
