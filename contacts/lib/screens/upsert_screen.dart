import 'package:contacts/utils/network.dart';
import 'package:contacts/widgets/upsert/input_text.dart';
import 'package:flutter/material.dart';

class UpsertScreen extends StatefulWidget {
  const UpsertScreen({super.key});

  static TextEditingController fullName = TextEditingController();
  static TextEditingController mobileNo = TextEditingController();

  @override
  State<UpsertScreen> createState() => _UpsertScreenState();
}

class _UpsertScreenState extends State<UpsertScreen> {
  @override
  Widget build(BuildContext context) {
    String _title = "Add New Contact";
    final _formKey = GlobalKey<FormState>();

    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_title),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Network.postData(
                          mobileNo: UpsertScreen.mobileNo.text,
                          fullName: UpsertScreen.fullName.text);
                      Navigator.pop(context);
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
