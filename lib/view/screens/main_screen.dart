import 'package:crud_app/view/screens/add_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Add'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.person),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddUserScreen(),
              ));
        },
        label: const Text('Add user'),
        icon: const Icon(CupertinoIcons.person),
        elevation: 0.0,
        backgroundColor: Colors.teal.shade300,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        foregroundColor: Colors.black,
        tooltip: 'Click to add user',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
