import 'package:flutter/material.dart';
import 'package:rest_api_crud/api/client.request.dart';
import 'package:rest_api_crud/models/client.model.dart';
import 'package:rest_api_crud/screens/text_box.dart';

class ModifyContact extends StatefulWidget {
  final Client? client;
  const ModifyContact({super.key, this.client});

  @override
  State<ModifyContact> createState() => _ModifyContactState();
}

class _ModifyContactState extends State<ModifyContact> {
  late TextEditingController controllerName;
  late TextEditingController controllerSurname;
  late TextEditingController controllerPhone;

  String? id;

//inicializamos variables anteriores
  @override
  void initState() {
    Client? c = widget.client;
    id = c?.id;
    controllerName = TextEditingController(text: c?.name);
    controllerSurname = TextEditingController(text: c?.surname);
    controllerPhone = TextEditingController(text: c?.phone);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Modificar Contacto")),
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

                // if (name.isNotEmpty && surname.isNotEmpty && phone.isNotEmpty) {
                //   Navigator.pop(context,
                //       Client(name: name, surname: surname, phone: phone));
                // }
                if (name.isNotEmpty && surname.isNotEmpty && phone.isNotEmpty) {
                  // Navigator.pop(context,
                  //     Client(name: name, surname: surname, phone: phone));
                  Client c = Client(
                      id: id, name: name, surname: surname, phone: phone);
                  modifyClient(c).then((value) {
                    if (value.id != "") {
                      Navigator.pop(context, value);
                    }
                  });
                }
              },
              child: const Text("Actualizar Contacto"))
        ],
      ),
    );
  }
}
