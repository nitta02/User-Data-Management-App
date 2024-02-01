import 'package:crud_app/model/user_model.dart';
import 'package:crud_app/view/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(DatabaseModelAdapter());
  await Hive.openBox<DatabaseModel>('userBox');

  await Hive.openBox<DatabaseModel>('favContacts');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(133, 133, 242, 0.494),
          elevation: 0.0,
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(133, 133, 242, 0.494),
        fontFamily: "Lexend",
      ),
      home: const MainScreen(),
    );
  }
}
