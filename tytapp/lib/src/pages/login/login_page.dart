import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:tytapp/src/pages/login/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _con = new LoginController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _bannerApp(context),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                const SizedBox(width: 25),
                _textDescripcion(),
              ],
            ),
            Row(
              children: <Widget>[
                const SizedBox(width: 25),
                _textDescripcion2()
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            _textFieldEmail(),
            const SizedBox(
              height: 15,
            ),
            _textFieldPassword(),
            const SizedBox(
              height: 25,
            ),
            _buttonLogin(),
            _txtNoTienesCuenta()
          ],
        ),
      ),
    );
  }

  Widget _bannerApp(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.23,
        color: Colors.amber,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/img/logo_tytapp.png",
                  width: 70,
                  height: 70,
                ),
                _textTypeBanner("Tytapp", 80)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            _textTypeEslogan("Sin esperas, seguro y confiable.", 17)
          ],
        ),
      ),
    );
  }

  Widget _textTypeBanner(String texto, double tamanio) {
    return Text(
      texto,
      style: TextStyle(
          fontSize: tamanio,
          color: Colors.white,
          fontFamily: "Run",
          fontWeight: FontWeight.bold,
          shadows: <Shadow>[
            Shadow(
                offset: Offset(10.0, 10.0),
                blurRadius: 3.0,
                color: Color.fromARGB(10, 10, 10, 0))
          ]),
    );
  }

  Widget _textTypeEslogan(String texto, double tamanio) {
    return Text(
      texto,
      style: TextStyle(
          fontSize: tamanio, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget _textDescripcion() {
    return const Text("Continua con tu",
        style: TextStyle(fontSize: 23, color: Colors.black54));
  }

  Widget _textDescripcion2() {
    return Text(
      "Inicio de sesion",
      style: TextStyle(
          fontSize: 27,
          color: Colors.blueGrey[900],
          fontWeight: FontWeight.bold),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _con.emailController,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          labelStyle: TextStyle(color: Colors.blueGrey[900]),
          fillColor: Colors.amber,
          hintText: "correo@gmail.com",
          labelText: "Correo electronico",
          suffixIcon: Icon(
            Icons.email_outlined,
            color: Colors.blueGrey[900],
          ),
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          labelStyle: TextStyle(color: Colors.blueGrey[900]),
          labelText: "Contraseña",
          suffixIcon: Icon(
            Icons.lock_open_rounded,
            color: Colors.blueGrey[900],
          ),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: ElevatedButton(
        onPressed: () => _con.login(context),
        style: ElevatedButton.styleFrom(primary: Colors.blueGrey[900]),
        child: Stack(
          children: const <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "Iniciar Sesion",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: Icon(Icons.arrow_forward_ios),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _txtNoTienesCuenta() {
    return GestureDetector(
      onTap: () => _con.goToRegisterPage(context),
      child: Container(
        child: Text("No tienes cuenta?",
            style: TextStyle(fontSize: 15, color: Colors.grey[600])),
      ),
    );
  }
}
