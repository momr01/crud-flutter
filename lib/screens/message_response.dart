import 'package:flutter/material.dart';

messageResponse(BuildContext context, String name) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text("Mensaje Informativo..."),
            content: Text("El contacto $name"),
          ));
}
