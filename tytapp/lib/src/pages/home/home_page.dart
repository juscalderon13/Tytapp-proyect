import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:tytapp/src/pages/home/home.controller.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _con = new HomeController();
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
    _con.init(context); //Iniciando nuestro Controlador

    return Scaffold(
      body: Container(
        //el box decoration te permite hacer un degradado de colores de Bgraund
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [Colors.white12, Colors.white30])),
        //esta columna es la principal de la pagina
        child: Column(
          children: <Widget>[
            //este widget inserta la forma curveada
            _BannerApp(context),
            const SizedBox(height: 15),
            Row(
              children: <Widget>[
                const SizedBox(width: 30),
                _textDescripcion2()
              ],
            ),
            const SizedBox(height: 60),
            _imagTypeUsuario("assets/img/pasajero.png", context, "client"),
            const SizedBox(
              height: 5,
            ),
            _textTypeUsuario("Pasajero"),
            const SizedBox(
              height: 30,
            ),
            _imagTypeUsuario("assets/img/driver.png", context, "driver"),
            const SizedBox(
              height: 5,
            ),
            textTypeConductor("Conductor"),
          ],
        ),
      ),
    );
  }

  Widget _BannerApp(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.28,
        color: Colors.amber,
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Row(
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

  Widget textTypeConductor(String texto) {
    return Text(
      texto,
      style: TextStyle(
          fontSize: 20,
          color: Colors.blueGrey[900],
          fontWeight: FontWeight.bold),
    );
  }

  Widget _textTypeUsuario(String texto) {
    return Text(
      texto,
      style: TextStyle(
          fontSize: 20,
          color: Colors.blueGrey[900],
          fontWeight: FontWeight.bold),
    );
  }

  Widget _textTypeSubtitulo(String texto) {
    return Text(
      texto,
      style: const TextStyle(
          fontSize: 23, color: Colors.grey, fontWeight: FontWeight.bold),
    );
  }

  Widget _imagTypeUsuario(
      String direccionImagen, BuildContext context, String typeUser) {
    return GestureDetector(
      onTap: () => _con.goToLoginPage(context, typeUser),
      child: PhysicalModel(
        color: Colors.black,
        elevation: 13.0,
        shape: BoxShape.circle,
        child: CircleAvatar(
          backgroundImage: AssetImage(direccionImagen),
          radius: 55,
          backgroundColor: Colors.amber,
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
          shadows: const <Shadow>[
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

  Widget _textDescripcion2() {
    return Text(
      "Bienvenido(a), por favor selecciona \nel tipo de usuario con el que deseas \niniciar sesion o registrarte: ",
      style: TextStyle(
          fontSize: 24,
          color: Colors.blueGrey[900],
          fontWeight: FontWeight.bold),
    );
  }
}
