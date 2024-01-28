// ignore_for_file: public_member_api_docs, sort_constructors_first
class Users {
  final int id;
  final String name;
  final String description;

  Users({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      id: json['id'], name: json['name'], description: json['description']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
