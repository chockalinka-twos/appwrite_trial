import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:twos_appwrite_trial/data/model/user.dart';
import 'package:twos_appwrite_trial/res/app_constants.dart';

class AuthState extends ChangeNotifier {
  Client client = Client();
  Account account;
  bool _isLoggedIn;
  User _user;
  String _error;

  bool get isLoggedIn => _isLoggedIn;
  User get user => _user;
  String get error => _error;

  AuthState() {
    _init();
  }

  _init() {
    _isLoggedIn = false;
    _user = null;
    account = Account(client);
    client.setEndpoint(AppConstant.endpoint).setProject(AppConstant.project);
    _checkIsLoggedIn();
  }

  _checkIsLoggedIn() async {
    try {
      _user = await _getAccount();
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {}
  }

  Future<User> _getAccount() async {
    try {
      Response<dynamic> res = await account.get();
      if (res.statusCode == 200) {
        return User.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  createAccount(String name, String email, String password) async {
    try {
      var result =
          await account.create(name: name, email: email, password: password);
      print(result);
    } catch (error) {
      print(error.message);
    }
  }

  logout() async {
    try {
      Response res = await account.deleteSession(sessionId: 'current');
      print(res.statusCode);
      _isLoggedIn = false;
      _user = null;
      notifyListeners();
    } catch (e) {
      _error = e.message;
      notifyListeners();
    }
  }

  login(String email, String password) async {
    try {
      Response result =
          await account.createSession(email: email, password: password);
      if (result.statusCode == 201) {
        _isLoggedIn = true;
        _user = await _getAccount();
        notifyListeners();
      }
    } catch (error) {
      print(error.message);
    }
  }
}
