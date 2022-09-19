import 'package:contacts/screens/upsert_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.import_contacts_sharp),
        title: const Text('Contacts Online'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
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
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            child: Text('${index + 1}'),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
          title: Text('Name'),
          subtitle: Text('09012421080'),
        ),
        itemCount: 5,
      ),
    );
  }
}
