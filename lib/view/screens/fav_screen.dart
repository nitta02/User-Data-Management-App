import 'package:crud_app/controller/database_controller.dart';
import 'package:crud_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite User'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: FavDatabaseController.getFavData().listenable(),
        builder: (context, value, child) {
          Box<DatabaseModel> favBox = FavDatabaseController.getFavData();

          List favData = List.from(value.values);

          return ListView.builder(
            itemCount: favData.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white38,
                elevation: 10.0,
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text("Name : ${favData[index].name}"),
                  iconColor: Colors.black,
                  isThreeLine: true,
                  trailing: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Row(
                              children: [
                                Text('Are you sure?'),
                                Icon(
                                  CupertinoIcons.delete,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            content: const Text('Delete this'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  favBox.delete(favData[index].key);

                                  Navigator.pop(context);
                                },
                                child: const Text('Yes'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  subtitle: Text('Number : ${favData[index].contact}'),
                  leading: const Icon(CupertinoIcons.person),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
