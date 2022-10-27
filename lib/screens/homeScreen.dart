import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:journel/constants.dart';
import 'package:journel/screens/AddentryScreen.dart';
import 'package:journel/screens/readlistscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components.dart';



class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: w,
          height: h,
          decoration: KscreenBg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              JournyTitle(),
              SizedBox(height: h * 0.001),
              Image(
                image: AssetImage(
                  "images/book.png",
                ),
                width: w * 0.50,
                height: h * 0.20,
              ),
              SizedBox(
                height: h * 0.08,
              ),
              JournyButton(
                  label: ' Read Entries',
                  fn: () async {
                    await FirebaseFirestore.instance
                        .collection('entries')
                        .get()
                        .then((snapshot) {
                      List<QueryDocumentSnapshot> docList = snapshot.docs;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReadEntryList(docs: docList)));
                    });
                  }),
              SizedBox(height: 20),
              JournyButton(
                  label: "  Add Entry",
                  fn: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEntryScreen(),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
