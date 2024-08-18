// ignore_for_file: camel_case_types

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ree extends StatefulWidget {
  const ree({super.key});

  @override
  State<ree> createState() => _reeState();
}

class _reeState extends State<ree> {
  final Future<FirebaseApp> fapp = Firebase.initializeApp();
  String realtimevalue = '0';
  String getoncevalue = '0';
  final TextEditingController _dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: fapp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("has error");
        } else if (snapshot.hasData) {
          return content();
        } else {
          return const CircularProgressIndicator();
        }
      },
    ));
  }

  Widget content() {
    DatabaseReference testref = FirebaseDatabase.instance.ref().child("count");
    testref.onValue.listen((event) {
      setState(() {
        realtimevalue = event.snapshot.value.toString();
      });
    });
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Real Time Counter: $realtimevalue"),
          const SizedBox(height: 20),
          TextField(
            controller: _dataController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Data to Store',
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              if (_dataController.text.isNotEmpty) {
                await testref.set(_dataController.text);
                _dataController.clear();
              } else {}
            },
            child: Container(
              height: 40,
              width: 150,
              color: Colors.green,
              child: const Center(
                child: Text("Store Data"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              final snapshot = await testref.get();
              if (snapshot.exists) {
                setState(() {
                  getoncevalue = snapshot.value.toString();
                });
              } else {}
            },
            child: Container(
              height: 40,
              width: 150,
              color: Colors.blue,
              child: const Center(
                child: Text("Get Once"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text("Get Once Value: $getoncevalue"),
        ],
      ),
    );
  }
}
