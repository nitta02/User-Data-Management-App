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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent.shade400,
          elevation: 0.0,
        ),
        scaffoldBackgroundColor: Colors.blueAccent.shade400,
        fontFamily: "Lexend",
      ),
      home: const MainScreen(),
    );
  }
}
