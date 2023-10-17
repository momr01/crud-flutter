import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextBox extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  const TextBox({super.key, this.controller, this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            labelText: label,
            suffix: GestureDetector(
              //borrar el contenido del input al hacer tap en X
              child: const Icon(Icons.close),
              onTap: () {
                controller?.clear();
              },
            )),
      ),
    );
  }
}
