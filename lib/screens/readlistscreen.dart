import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journel/components.dart';
import 'package:journel/screens/AddentryScreen.dart';
import 'package:journel/constants.dart';
import 'package:flutter/material.dart';

class ReadEntryList extends StatefulWidget {
  final List<QueryDocumentSnapshot> docs;
  const ReadEntryList({
    Key? key,
    required this.docs,
  }) : super(key: key);

  @override
  State<ReadEntryList> createState() => _ReadEntryListState();
}

class _ReadEntryListState extends State<ReadEntryList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: KscreenBg,
        child: widget.docs.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const JournyTitle(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Expanded(
                      child: Center(
                    child: Text(
                      "Please Add Entry",
                      style: KButtontext,
                    ),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  JournyButton(
                      label: "Add Entry",
                      fn: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AddEntryScreen();
                        }));
                      })
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  JournyTitle(),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return EntryTile(
                            title: widget.docs.elementAt(index)['Title'],
                            entry: widget.docs.elementAt(index)['Entry'],
                            dateTime: widget.docs.elementAt(index)['Date'],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: widget.docs.length),
                  ),
                  SizedBox(height: 20),
                  JournyButton(
                      label: " Back",
                      fn: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    height: 38,
                  )
                ],
              ),
      )),
    );
  }
}
