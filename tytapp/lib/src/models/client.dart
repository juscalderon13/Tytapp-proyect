import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  Cliente({
    required this.id,
    required this.nombreusuario,
    required this.email,
    required this.password,
  });

  String id;
  String nombreusuario;
  String email;
  String password;

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        nombreusuario: json["nombreusuario"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreusuario": nombreusuario,
        "email": email,
      };
}
