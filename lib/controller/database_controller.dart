import 'package:crud_app/model/user_model.dart';
import 'package:hive/hive.dart';

class DatabaseController {
  static Box<DatabaseModel> getData() => Hive.box('userBox');
}
