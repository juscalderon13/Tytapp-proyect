import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tytapp/src/models/client.dart';

class ClienteProvider {
  CollectionReference? _ref;

  ClienteProvider() {
    _ref = FirebaseFirestore.instance.collection("Clients");
  }

  Future<void> create(Cliente cliente) async {
    var errorMessage;

    try {
      return _ref!.doc(cliente.id).set(cliente.toJson());
    } catch (error) {
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

// esto esta en desarrollo
  /*Future<Cliente> getById(String id) async {
    DocumentSnapshot document =
        _ref!.doc(id).get() as DocumentSnapshot<Object?>;
    if (document.exists) {
      Cliente client =
          Cliente.fromJson(document.data() as Map<String, dynamic>);
      return client;
    } else {
      
    }
  }*/
}
