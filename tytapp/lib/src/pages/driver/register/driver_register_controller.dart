import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:tytapp/src/models/driver.dart';
import 'package:tytapp/src/providers/auth_provider.dart';
import 'package:tytapp/src/providers/driver_provider.dart';
import 'package:tytapp/src/utils/progress_dialog.dart';

class DriverRegisterController {
  BuildContext? context;

  TextEditingController iDController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordconfirmController = TextEditingController();

  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
  TextEditingController pin3Controller = TextEditingController();
  TextEditingController pin4Controller = TextEditingController();
  TextEditingController pin5Controller = TextEditingController();
  TextEditingController pin6Controller = TextEditingController();

  AuthProvider? _authProvider;
  DriverProvider? _driverProvider;
  ProgressDialog? _progressDialog;

  Future? init(BuildContext context) {
    this.context = context;
    _authProvider = new AuthProvider();
    _driverProvider = new DriverProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, "Espere un momento...");
  }

  void register(BuildContext context) async {
    String iD = iDController.text.trim();
    String name = nameController.text;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String passwordconfirm = passwordconfirmController.text.trim();

    String pin1 = pin1Controller.text.trim();
    String pin2 = pin2Controller.text.trim();
    String pin3 = pin3Controller.text.trim();
    String pin4 = pin4Controller.text.trim();
    String pin5 = pin5Controller.text.trim();
    String pin6 = pin6Controller.text.trim();

    String placa = "$pin1$pin2$pin3$pin4$pin5$pin6";

    if (iD.isEmpty &&
        name.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        passwordconfirm.isEmpty) {
      final snackBar = SnackBar(
        content: const Text('Debe llenar todos los espacios'),
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
      return;
    }
    if (passwordconfirm != password) {
      final snackBar = SnackBar(
        content: const Text('Las contraseñas son diferentes'),
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
      return;
    }
    if (password.length < 6) {
      final snackBar = SnackBar(
        content: const Text('La contraseña debe tener al menos 6 caracteres'),
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
      return;
    }

    _progressDialog!.show();

    try {
      bool isRegister = await _authProvider!.register(email, password);

      if (isRegister) {
        // ignore: unnecessary_new
        Driver driver = new Driver(
            id: _authProvider!.getUser()!.uid,
            email: email,
            nombreusuario: name,
            password: password,
            dni: iD,
            placa: placa);
        //solicitud a la base de datos
        await _driverProvider!.create(driver);
        _progressDialog!.hide();

        final snackBar = SnackBar(
          content: const Text('Registro exitoso'),
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

        Navigator.pushNamedAndRemoveUntil(
            context, "DriverMapPage", ((route) => false));
        print("El usuario se registro correctamente");
      } else {
        _progressDialog!.hide();
        final snackBar = SnackBar(
          content: const Text('Error al momento de registrar'),
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
        print("error al momento de registrar");
      }
    } catch (error) {
      final snackBar = SnackBar(
        content: const Text('Error al momento de registrar'),
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
