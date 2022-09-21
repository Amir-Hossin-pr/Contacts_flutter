import 'package:contacts/utils/network.dart';
import 'package:contacts/widgets/upsert/input_text.dart';
import 'package:flutter/material.dart';

class UpsertScreen extends StatefulWidget {
  const UpsertScreen({super.key});

  static TextEditingController fullName = TextEditingController();
  static TextEditingController mobileNo = TextEditingController();
  static int contactId = -1;

  @override
  State<UpsertScreen> createState() => _UpsertScreenState();
}

class _UpsertScreenState extends State<UpsertScreen> {
  @override
  Widget build(BuildContext context) {
    String title = UpsertScreen.contactId == -1
        ? "Add New Contact"
        : 'Edit `${UpsertScreen.fullName.text}`';

    final formKey = GlobalKey<FormState>();

    return Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            leading: IconButton(
              onPressed: () {
                UpsertScreen.contactId = -1;
                UpsertScreen.fullName.text = "";
                UpsertScreen.mobileNo.text = "";
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            backgroundColor:
                UpsertScreen.contactId == -1 ? Colors.blue : Colors.amber,
          ),
          body: Column(
            children: [
              InputOutline(
                  hint: 'نام و نام خانوادگی',
                  lable: 'نام و نام خانوادگی',
                  errorText: 'لطفا نام را وارد کنید',
                  controller: UpsertScreen.fullName),
              InputOutline(
                  hint: 'موبایل',
                  lable: 'شماره موبایل',
                  errorText: 'لطفا شماره موبایل را وارد کنید',
                  inputTtype: TextInputType.phone,
                  controller: UpsertScreen.mobileNo),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15))),
                  onPressed: () async {
                    void clearForm() {
                      UpsertScreen.contactId = -1;
                      UpsertScreen.fullName.text = "";
                      UpsertScreen.mobileNo.text = "";
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
                      if (UpsertScreen.contactId == -1) {
                        if (await Network.postData(
                            mobileNo: UpsertScreen.mobileNo.text,
                            fullName: UpsertScreen.fullName.text)) {
                          showSnackbar(
                              '`${UpsertScreen.fullName.text}` Inserted Successfuly',
                              true);
                          clearForm();
                          Navigator.pop(context);
                        }
                      } else {
                        if (await Network.pustData(
                            mobileNo: UpsertScreen.mobileNo.text,
                            fullName: UpsertScreen.fullName.text,
                            id: UpsertScreen.contactId)) {
                          showSnackbar(
                              '`${UpsertScreen.fullName.text}` Updated Successfuly',
                              true);
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
  }
}
