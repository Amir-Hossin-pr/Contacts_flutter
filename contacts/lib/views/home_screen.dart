import 'package:contacts/models/contact.dart';
import 'package:contacts/views/upsert_screen.dart';
import 'package:contacts/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Network.getData().then((value) {
      if (value) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.import_contacts_sharp),
        title: const Text('Contacts Online'),
        actions: [
          IconButton(
              onPressed: () async {
                if (await Network.getData()) {
                  setState(() {});
                }
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/upsert')?.then((value) async {
            await Network.getData();
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            trailing: IconButton(
              onPressed: () {
                Contact contact = Network.contacts[index];
                UpsertScreen.fullName.text = contact.fullName;
                UpsertScreen.mobileNo.text = contact.mobileNo;
                UpsertScreen.contactId = contact.id;
                Get.toNamed('/upsert')?.then((value) async {
                  await Network.getData();
                  setState(() {});
                });
              },
              icon: const Icon(Icons.edit),
            ),
            title: Text(Network.contacts[index].fullName),
            subtitle: Text(Network.contacts[index].mobileNo),
            onTap: () {
              var contact = Network.contacts[index];
              showDialog(
                  context: context,
                  builder: (builder) => AlertDialog(
                        actionsAlignment: MainAxisAlignment.center,
                        icon: const Icon(Icons.delete),
                        title: const Text('Delete Contact'),
                        content: Text(
                            'Are you sure to delete `${contact.fullName}` ?'),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed: () async {
                                var contact = Network.contacts[index];
                                if (await Network.deleteData(contact.id)) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'User ${contact.fullName} Deleted Successfuly',
                                              style: const TextStyle(
                                                  color: Colors.green))));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    'User ${contact.fullName} Not Deleted',
                                    style: const TextStyle(color: Colors.red),
                                  )));
                                }
                                await Network.getData();
                                setState(() {});
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Delete'),
                                  Icon(Icons.delete)
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Cancle'),
                                  Icon(Icons.cancel)
                                ],
                              ),
                            ),
                          )
                        ],
                      ));
            },
          );
        },
        itemCount: Network.contacts.length,
      ),
    );
  }
}
