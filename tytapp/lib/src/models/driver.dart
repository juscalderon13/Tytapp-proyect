import 'dart:convert';

Driver driverFromJson(String str) => Driver.fromJson(json.decode(str));

String driverToJson(Driver data) => json.encode(data.toJson());

class Driver {
  Driver({
    required this.id,
    required this.nombreusuario,
    required this.email,
    required this.password,
    required this.dni,
    required this.placa,
  });

  String id;
  String nombreusuario;
  String email;
  String password;
  String dni;
  String placa;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        nombreusuario: json["nombreusuario"],
        email: json["email"],
        password: json["password"],
        dni: json["dni"],
        placa: json["placa"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreusuario": nombreusuario,
        "email": email,
        "dni": dni,
        "placa": placa,
      };
}
