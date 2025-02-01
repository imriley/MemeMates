import 'package:flutter/foundation.dart';
import 'package:mememates/models/User.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void updateUser(User user) {
    _user = user;
    notifyListeners();
  }
}
