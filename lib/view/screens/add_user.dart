import 'package:crud_app/controller/database_controller.dart';
import 'package:crud_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final numberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: numberController,
              decoration: InputDecoration(
                  hintText: 'Number',
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
                      final data = DatabaseModel(
                        name: nameController.text,
                        contact: numberController.text,
                      );

                      final box = DatabaseController.getData();

                      box.add(data);

                      data.save();
                      nameController.clear();
                      numberController.clear();
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(CupertinoIcons.check_mark_circled),
                        Text('Save'),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {},
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
      )),
    );
  }
}
