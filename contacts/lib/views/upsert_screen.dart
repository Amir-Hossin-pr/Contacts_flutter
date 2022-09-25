import 'package:contacts/controllers/contacts_controller.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/widgets/upsert/input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

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
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              backgroundColor: contactId == -1 ? Colors.blue : Colors.amber,
            ),
            body: Column(
              children: [
                InputOutline(
                    hint: 'نام و نام خانوادگی',
                    lable: 'نام و نام خانوادگی',
                    errorText: 'لطفا نام را وارد کنید',
                    controller: fullName),
                InputOutline(
                    hint: 'موبایل',
                    lable: 'شماره موبایل',
                    errorText: 'لطفا شماره موبایل را وارد کنید',
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          message,
                          style: TextStyle(
                              color: success ? Colors.green : Colors.red),
                        )));
                      }

                      if (formKey.currentState!.validate()) {
                        if (contactId == -1) {
                          if (await contactsController.insertContact(
                              fullName.text, mobileNo.text)) {
                            showSnackbar(
                                '`${fullName.text}` Inserted Successfuly',
                                true);
                            clearForm();
                            Navigator.pop(context);
                          }
                        } else {
                          if (await contactsController.updateContact(
                              contactId, fullName.text, mobileNo.text)) {
                            showSnackbar(
                                '`${fullName.text}` Updated Successfuly', true);
                            clearForm();
                            Navigator.pop(context);
                          }
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('ثبت مخاطب'),
                        Icon(Icons.save),
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
