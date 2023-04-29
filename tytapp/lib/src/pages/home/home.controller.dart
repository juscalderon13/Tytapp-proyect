import 'package:flutter/material.dart';
import 'package:tytapp/src/providers/auth_provider.dart';
import 'package:tytapp/src/utils/shared_pref.dart';

class HomeController {
  BuildContext? context;
  SharedPref? _sharedPref;

  AuthProvider? _authProvider;
  String? _typeUser;

  Future? init(BuildContext context) async {
    this.context = context;
    _sharedPref = new SharedPref();
    _authProvider = new AuthProvider();
    _typeUser = await _sharedPref?.read("typeUser");
  }

  void checkIfUserIsAuth(BuildContext context) {
    bool? isSigned = _authProvider!.isSignedIn();
    if (isSigned != false || isSigned != null) {
      if (_typeUser == "client") {
        Navigator.pushNamedAndRemoveUntil(
            context, "ClientMapPage", ((route) => false));
      }
    }
  }

  void goToLoginPage(BuildContext context, String typeUser) {
    saveTypeUser(typeUser);
    Navigator.pushNamed(context, "LoginPage");
  }

  void saveTypeUser(String typeUser) async {
    // ignore: await_only_futures
    await _sharedPref?.save("typeUser", typeUser);
  }
}
