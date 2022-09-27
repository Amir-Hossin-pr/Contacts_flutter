import 'package:contacts/controllers/contacts_controller.dart';
import 'package:contacts/controllers/translate_controller.dart';
import 'package:contacts/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final contactsController = Get.find<ContactsController>();
  final trasnlateController = Get.find<TranslateController>();

  @override
  Widget build(BuildContext context) {
    contactsController.getContacts();
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.import_contacts_sharp),
        title: Text('title'.tr),
        actions: [
          IconButton(
              onPressed: () async {
                await contactsController.getContacts();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'changeLang'.tr,
            onPressed: () {
              Get.bottomSheet(Container(
                color: Colors.white,
                child: Wrap(children: [
                  ListTile(
                    leading: const Icon(Icons.abc),
                    title: const Text('English'),
                    onTap: () {
                      trasnlateController.changeLanguage('en');
                      Get.back();
                      Get.snackbar(
                          'Language Change', 'Language Changed Successfuly',
                          icon: const Icon(Icons.translate),
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(15));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.abc),
                    title: const Text('فارسی'),
                    onTap: () {
                      trasnlateController.changeLanguage('fa');
                      Get.back();
                      Get.snackbar('تغییر زبان', 'زبان با موفقیت تغییر کرد',
                          icon: const Icon(Icons.translate),
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(15));
                    },
                  )
                ]),
              ));
            },
            child: const Icon(Icons.language),
          ),
          FloatingActionButton(
            tooltip: 'createNew'.tr,
            onPressed: () {
              Get.toNamed('/upsert')?.then((value) async {
                await contactsController.getContacts();
              });
            },
            child: const Icon(Icons.add),
          ),
        ],
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
                  Contact contact = contactsController.contacts[index];
                  Get.defaultDialog(
                      title: 'Delete Contact',
                      middleText:
                          'Are you sure to delete `${contact.fullName}`?',
                      textConfirm: 'Yes',
                      confirmTextColor: Colors.white,
                      textCancel: 'No',
                      onCancel: () {
                        Get.back();
                      },
                      onConfirm: () async {
                        var contact = contactsController.contacts[index];
                        if (await contactsController
                            .deleteContact(contact.id)) {
                          Get.back();

                          Get.snackbar('Success',
                              'User ${contact.fullName} Deleted Successfuly',
                              icon: const Icon(Icons.check),
                              isDismissible: true,
                              margin: const EdgeInsets.all(10),
                              snackPosition: SnackPosition.BOTTOM);

                          await contactsController.getContacts();
                        } else {
                          Get.back();

                          Get.snackbar(
                              'Error', 'User ${contact.fullName} Not Deleted',
                              icon: const Icon(Icons.error),
                              isDismissible: true,
                              margin: const EdgeInsets.all(10),
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      });
                },
              );
            },
            itemCount: contactsController.contacts.length,
          )),
    );
  }
}
