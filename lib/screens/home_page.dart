import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rest_api_crud/api/client.request.dart';
import 'package:rest_api_crud/models/client.model.dart';
import 'package:rest_api_crud/screens/message_response.dart';
import 'package:rest_api_crud/screens/modify_contact.dart';
import 'package:rest_api_crud/screens/register_contact.dart';

class HomePage extends StatefulWidget {
  //final String? title;

  const HomePage({
    super.key, //this.title
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Client>? clients = [
  //   Client(name: 'Will', surname: 'Mora', phone: '155678909'),
  //   Client(name: 'Sam', surname: 'Perez', phone: "154678900"),
  //   Client(name: 'Marion', surname: 'Cotillard', phone: '154678977'),
  //   Client(name: 'Jhon', surname: 'Sehura', phone: '152345677')
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Center(child: Text(widget.title!)),
        title: const Center(
          child: Text("Mis Contactos"),
        ),
      ),
      body: getClients(context, listClients()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterContact()))
              .then((newContact) {
            if (newContact != null) {
              setState(() {
                //clients?.add(newContact);

                messageResponse(
                    context, newContact.name + " ha sido guardado!");
              });
            }
          });
        },
        tooltip: "Agregar Contacto",
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget getClients(BuildContext context, Future<List<Client>> futureClient) {
    return FutureBuilder(
      future: futureClient,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Container(
                alignment: Alignment.center,
                child: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              );
            }
            return snapshot.data != null
                ? clientList(snapshot.data)
                : Container(
                    alignment: Alignment.center,
                    child: const Center(
                      child: Text("Sin Datos"),
                    ),
                  );
          default:
            return const Text("Recarga la pantalla nuevamente!");
        }
      },
    );
  }

  Widget clientList(List<Client> clients) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ModifyContact(
                          client: clients[index],
                        ))).then((newContact) {
              if (newContact != null) {
                setState(() {
                  // clients.removeAt(index);
                  // clients.insert(index, newContact);

                  messageResponse(
                      context, newContact.name + " ha sido modificado!");
                });
              }
            });
          },
          onLongPress: () {
            //eliminar contacto
            removeClient(context, clients[index]);
          },
          title: Text("${clients[index].name} ${clients[index].surname}"),
          subtitle: Text(clients[index].phone.toString()),
          leading: CircleAvatar(
            child: Text(clients[index].name.toString().substring(0, 1)),
          ),
          trailing: const Icon(
            Icons.call,
            color: Colors.red,
          ),
        );
      },
      itemCount: clients.length,
    );
  }

  removeClient(BuildContext context, Client client) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Eliminar Cliente"),
              content: Text("Está seguro de eliminar a ${client.name}?"),
              actions: [
                TextButton(
                    onPressed: () {
                      //  setState(() {
                      //clients?.remove(client);
                      //   Navigator.pop(context);
                      deleteClient(client.id.toString()).then((value) {
                        if (value.id != '') {
                          setState(() {});
                          Navigator.pop(context);
                        }
                      });
                    },
                    // )
                    //  },
                    child: const Text(
                      "Eliminar",
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ));
  }
}

// class Client {
//   String? name;
//   String? surname;
//   String? phone;

//   Client({this.name, this.surname, this.phone});
// }
