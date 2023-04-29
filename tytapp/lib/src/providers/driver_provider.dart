import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tytapp/src/models/client.dart';
import 'package:tytapp/src/models/driver.dart';

class DriverProvider {
  CollectionReference? _ref;

  DriverProvider() {
    _ref = FirebaseFirestore.instance.collection("Drivers");
  }

  Future<void> create(Driver driver) async {
    var errorMessage;

    try {
      return _ref!.doc(driver.id).set(driver.toJson());
    } catch (error) {
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

//esto esta en desarrollo
  /*Future<Driver> getById(String id) async {
    DocumentSnapshot document =
        _ref!.doc(id).get() as DocumentSnapshot<Object?>;
    if (document.exists) {
      Driver driver = Driver.fromJson(document.data() as Map<String, dynamic>);
      return driver;
    } 
  }*/
}
