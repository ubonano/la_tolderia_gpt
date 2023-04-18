import 'package:flutter/material.dart';

class AppStateConnection {
  static Widget loading() {
    return const Center(child: CircularProgressIndicator());
  }

  static Widget error({String error = 'Ha ocurrido un error'}) {
    return Center(child: Text(error));
  }
}
