// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:crud_app/model/db_helper.dart';
import 'package:crud_app/model/user.dart';

class HomeScreen extends StatefulWidget {
  final Users? user;
  const HomeScreen({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final nameController = TextEditingController();
  final idController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Crud'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DatabaseHelper.addUser(Users(id: na, name: name, description: description));
        },
        child: TextFormField(
          controller: nameController,
        ),
      ),
    );
  }
}
