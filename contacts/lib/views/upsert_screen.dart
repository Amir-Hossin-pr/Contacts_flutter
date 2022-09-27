import 'package:contacts/controllers/contacts_controller.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/widgets/upsert/input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpsertScreen extends StatelessWidget {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  int contactId = -1;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (ContactsController contactsController) {
      if (contactsController.currentContact.value.id != -1) {
        contactId = contactsController.currentContact.value.id;
        fullName.text = contactsController.currentContact.value.fullName;
        mobileNo.text = contactsController.currentContact.value.mobileNo;
      }
      return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text(contactId == -1
                  ? 'Create New Contact'
                  : 'Update ${fullName.text}'),
              leading: IconButton(
                onPressed: () {
                  contactsController.currentContact.value =
                      Contact(fullName: '', mobileNo: '', id: -1);
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              backgroundColor: contactId == -1 ? Colors.blue : Colors.amber,
            ),
            body: Column(
              children: [
                InputOutline(
                    hint: 'fullName'.tr,
                    lable: 'fullName'.tr,
                    errorText: 'fullNameRequired'.tr,
                    controller: fullName),
                InputOutline(
                    hint: 'mobileNo'.tr,
                    lable: 'mobileNo'.tr,
                    errorText: 'mobileRequired'.tr,
                    inputTtype: TextInputType.phone,
                    controller: mobileNo),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(15))),
                    onPressed: () async {
                      void clearForm() {
                        contactsController.currentContact.value =
                            Contact(fullName: '', mobileNo: '', id: -1);
                      }

                      void showSnackbar(String message, bool success) {
                        Get.snackbar('Action', message,
                            icon: success
                                ? const Icon(Icons.check)
                                : const Icon(Icons.close),
                            barBlur: 2,
                            isDismissible: true,
                            margin: const EdgeInsets.all(10),
                            snackPosition: SnackPosition.BOTTOM);
                      }

                      if (formKey.currentState!.validate()) {
                        if (contactId == -1) {
                          if (await contactsController.insertContact(
                              fullName.text, mobileNo.text)) {
                            Get.back();
                            showSnackbar(
                                '`${fullName.text}` Inserted Successfuly',
                                true);
                            clearForm();
                          }
                        } else {
                          if (await contactsController.updateContact(
                              contactId, fullName.text, mobileNo.text)) {
                            Get.back();
                            showSnackbar(
                                '`${fullName.text}` Updated Successfuly', true);
                            clearForm();
                          }
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('save'.tr),
                        const Icon(Icons.save),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
