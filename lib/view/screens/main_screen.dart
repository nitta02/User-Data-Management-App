import 'package:crud_app/controller/database_controller.dart';
import 'package:crud_app/model/user_model.dart';
import 'package:crud_app/view/screens/add_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

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
      body: ValueListenableBuilder<Box<DatabaseModel>>(
        valueListenable: DatabaseController.getData().listenable(),
        builder: (context, value, child) {
          var boxData = value.values.toList().cast<DatabaseModel>();

          return ListView.builder(
            itemCount: boxData.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white38,
                elevation: 10.0,
                margin: EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text("Name : ${boxData[index].name}"),
                  iconColor: Colors.black,
                  isThreeLine: true,
                  trailing: Icon(Icons.edit),
                  subtitle: Text('Details : ${boxData[index].contact}'),
                  leading: Icon(CupertinoIcons.person),
                  onLongPress: () {},
                ),
              );
            },
          );
        },
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
