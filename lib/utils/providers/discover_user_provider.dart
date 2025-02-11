import 'package:flutter/material.dart';
import 'package:mememates/models/User.dart';
import 'package:mememates/utils/storage/firestore.dart';

class DiscoverUserProvider extends ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = true;
  String? _error;
  bool _dataFetched = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUsers({bool forceRefresh = false}) async {
    if (_dataFetched && !forceRefresh) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    try {
      _users = await fetchAllUsers();
      _isLoading = false;
      _dataFetched = true;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      print("Something went wrong in the discover user provider: $e");
      _isLoading = false;
      notifyListeners();
    }
  }
}
