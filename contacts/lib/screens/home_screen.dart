import 'package:contacts/screens/upsert_screen.dart';
import 'package:contacts/utils/network.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Network.getData();
    Future.delayed(Duration(seconds: 5)).then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.import_contacts_sharp),
        title: const Text('Contacts Online'),
        actions: [
          IconButton(
              onPressed: () {
                Network.getData();
                Future.delayed(Duration(seconds: 5)).then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => const UpsertScreen()));
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
              onPressed: () {},
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
                              onPressed: () {
                                Network.deleteData(index);
                                Navigator.pop(context);
                                setState(() {});
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10))),
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
                      )).then((value) {
                Network.getData();
                setState(() {});
              });
            },
          );
        },
        itemCount: Network.contacts.length,
      ),
    );
  }
}
