import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:tytapp/src/models/client.dart';
import 'package:tytapp/src/models/driver.dart';
import 'package:tytapp/src/providers/auth_provider.dart';
import 'package:tytapp/src/providers/client_provider.dart';
import 'package:tytapp/src/providers/driver_provider.dart';
import 'package:tytapp/src/utils/progress_dialog.dart';
import 'package:tytapp/src/utils/shared_pref.dart';

class LoginController {
  BuildContext? context;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthProvider? _authProvider;
  ProgressDialog? _progressDialog;

  //en desarrollo
  /*DriverProvider? _driverProvider;
  ClienteProvider? _clienteProvider;*/

  SharedPref? _sharedPref;
  String? _typeUser;

  Future? init(BuildContext context) async {
    this.context = context;
    _authProvider = new AuthProvider();
    //en desarrollo
    /*_driverProvider = new DriverProvider();
    _clienteProvider = new ClienteProvider();*/
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, "Espere un momento...");
    _sharedPref = new SharedPref();
    _typeUser = await _sharedPref?.read("typeUser");
  }

  void goToRegisterPage(BuildContext context) {
    if (_typeUser == "client") {
      Navigator.pushNamed(context, "ClientRegisterPage");
    } else if (_typeUser == "driver") {
      Navigator.pushNamed(context, "DriverRegisterPage");
    }
  }

  void login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    _progressDialog!.show();
    try {
      bool isLogin = await _authProvider!.login(email, password);
      _progressDialog!.hide();

      if (isLogin) {
        _progressDialog!.hide();

        // en desarrollo
        /*if (_typeUser == "client") {
          Cliente client =
              await _clienteProvider!.getById(_authProvider!.getUser()!.uid);
          if (client != null) {
            Navigator.pushNamedAndRemoveUntil(
                context, "ClientMapPage", ((route) => false));
          } else {
            final snackBar = SnackBar(
              content: const Text('El usuario no es valido'),
              action: SnackBarAction(
                label: 'Cerrar',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            await _authProvider!.signOut();
          }
        } else if (_typeUser == "driver") {
          Driver driver =
              await _driverProvider?.getById(_authProvider!.getUser()!.uid);
          print("Driver: $driver");

          if (driver != null) {
            Navigator.pushNamedAndRemoveUntil(
                context, "DriverMapPage", ((route) => false));
          } else {
            final snackBar = SnackBar(
              content: const Text('El usuario no es valido'),
              action: SnackBarAction(
                label: 'Cerrar',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            await _authProvider!.signOut();
          }
        }*/ //hasta aqui el metodo de desarrollo
        final snackBar = SnackBar(
          content: const Text('Inicio de sesion exitoso'),
          action: SnackBarAction(
            label: 'Cerrar',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: const Text('El usuario no se pudo autenticar'),
          action: SnackBarAction(
            label: 'Cerrar',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _progressDialog!.hide();
        print("el usuario no se pudo autenticar");
      }
    } catch (error) {
      final snackBar = SnackBar(
        content: const Text('El usuario no se pudo autenticar'),
        action: SnackBarAction(
          label: 'Cerrar',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _progressDialog!.hide();
      print("Error = $error");
    }
  }
}
