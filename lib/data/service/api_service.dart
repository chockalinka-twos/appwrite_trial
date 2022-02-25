import 'package:appwrite/appwrite.dart';
import 'package:twos_appwrite_trial/res/app_constants.dart';

class ApiService {
  static ApiService _instance;
  Client _client;
  Account _account;
  Database _db;

  ApiService._internal() {
    _client =
        Client(endPoint: AppConstant.endpoint).setProject(AppConstant.project);
    _account = Account(_client);
    _db = Database(_client);
  }
  static ApiService get instance {
    if (_instance == null) {
      _instance = ApiService._internal();
    }
    return _instance;
  }

  Future login({email, password}) {
    return _account.createSession(email: email, password: password);
  }

  Future signup({String name, String email, String password}) {
    return _account.create(email: email, password: password, name: name ?? "");
  }
}
