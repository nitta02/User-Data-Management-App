import 'package:crud_app/controller/database_controller.dart';
import 'package:crud_app/model/user_model.dart';
import 'package:crud_app/view/screens/add_user.dart';
import 'package:crud_app/view/screens/fav_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Add'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoriteScreen(),
                  ));
            },
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
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text("Name : ${boxData[index].name}"),
                  iconColor: Colors.black,
                  isThreeLine: true,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          editData(
                            boxData[index],
                            boxData[index].name.toString(),
                            boxData[index].contact.toString(),
                          );
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // Save the new instance in the "favContacts" Hive box
                          Hive.box<DatabaseModel>('favContacts').add(
                              DatabaseModel(
                                  name: boxData[index].name,
                                  contact: boxData[index].contact));
                        },
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text('Number : ${boxData[index].contact}'),
                  leading: const Icon(CupertinoIcons.person),
                  onLongPress: () {
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
                                boxData[index].delete();
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
        backgroundColor: Colors.white38,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        foregroundColor: Colors.black,
        tooltip: 'Click to add user',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> editData(
      DatabaseModel databaseModel, String name, String details) async {
    nameController.text = name;
    numberController.text = details;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: numberController,
                  decoration: InputDecoration(
                      hintText: 'Contact',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          databaseModel.name = nameController.text.toString();
                          databaseModel.contact =
                              numberController.text.toString();

                          databaseModel.save();
                          Navigator.pop(context);
                        },
                        child: const Row(
                          children: [
                            Icon(CupertinoIcons.check_mark_circled),
                            Text('Save Edit'),
                          ],
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Row(
                          children: [
                            Icon(CupertinoIcons.delete_left),
                            Text('Cancel'),
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
