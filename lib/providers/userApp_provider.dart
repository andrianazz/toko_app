import 'package:flutter/cupertino.dart';
import 'package:toko_app/models/userApp_model.dart';

class UserAppProvider with ChangeNotifier {
  UserAppModel _userApp = UserAppModel();

  UserAppModel get userApp => _userApp;

  set userApp(UserAppModel userApp) {
    _userApp = userApp;
    notifyListeners();
  }
}
