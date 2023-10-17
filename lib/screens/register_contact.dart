import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rest_api_crud/api/client.request.dart';
import 'package:rest_api_crud/models/client.model.dart';
import 'package:rest_api_crud/screens/home_page.dart';
import 'package:rest_api_crud/screens/text_box.dart';

class RegisterContact extends StatefulWidget {
  const RegisterContact({super.key});

  @override
  State<RegisterContact> createState() => _RegisterContactState();
}

class _RegisterContactState extends State<RegisterContact> {
  //declaramos variables por cada caja de texto
  late TextEditingController controllerName;
  late TextEditingController controllerSurname;
  late TextEditingController controllerPhone;

//inicializamos variables anteriores
  @override
  void initState() {
    controllerName = TextEditingController();
    controllerSurname = TextEditingController();
    controllerPhone = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Registrar Contactos")),
      ),
      body: ListView(
        children: [
          TextBox(
            controller: controllerName,
            label: "Nombre",
          ),
          TextBox(
            controller: controllerSurname,
            label: "Apellido",
          ),
          TextBox(
            controller: controllerPhone,
            label: "Teléfono",
          ),
          ElevatedButton(
              onPressed: () {
                String name = controllerName.text;
                String surname = controllerSurname.text;
                String phone = controllerPhone.text;

                if (name.isNotEmpty && surname.isNotEmpty && phone.isNotEmpty) {
                  // Navigator.pop(context,
                  //     Client(name: name, surname: surname, phone: phone));
                  Client c = Client(name: name, surname: surname, phone: phone);
                  addClient(c).then((value) {
                    if (value.id != "") {
                      Navigator.pop(context, value);
                    }
                  });
                }
              },
              child: const Text("Guardar Contacto")),
        ],
      ),
    );
  }
}
