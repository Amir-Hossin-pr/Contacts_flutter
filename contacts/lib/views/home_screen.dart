import 'package:contacts/controllers/contacts_controller.dart';
import 'package:contacts/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final contactsController = Get.find<ContactsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.import_contacts_sharp),
        title: const Text('Contacts Online'),
        actions: [
          IconButton(
              onPressed: () async {
                await contactsController.getContacts();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/upsert')?.then((value) async {
            await contactsController.getContacts();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() => ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Contact contact = contactsController.contacts[index];
                    contactsController.currentContact.value = contact;
                    Get.toNamed('/upsert')?.then((value) async {
                      await contactsController.getContacts();
                    });
                  },
                  icon: const Icon(Icons.edit),
                ),
                title: Text(contactsController.contacts[index].fullName),
                subtitle: Text(contactsController.contacts[index].mobileNo),
                onTap: () {
                  var contact = contactsController.contacts[index];
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
                                    var contact =
                                        contactsController.contacts[index];
                                    if (await contactsController
                                        .deleteContact(contact.id)) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'User ${contact.fullName} Deleted Successfuly',
                                                  style: const TextStyle(
                                                      color: Colors.green))));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        'User ${contact.fullName} Not Deleted',
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )));
                                    }
                                    await contactsController.getContacts();
                                  },
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(10)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
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
            itemCount: contactsController.contacts.length,
          )),
    );
  }
}
