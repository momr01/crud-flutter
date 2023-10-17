class Client {
  String? id;
  String? name;
  String? surname;
  String? phone;

  Client({this.id, this.name, this.surname, this.phone});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        id: json['_id'],
        name: json['name'],
        surname: json['surname'],
        phone: json['phone']);
  }
}
