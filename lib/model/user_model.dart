// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class DatabaseModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String contact;

  DatabaseModel({
    required this.name,
    required this.contact,
  });
}