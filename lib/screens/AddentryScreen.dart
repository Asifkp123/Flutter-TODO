import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:journel/components.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  TextEditingController titleControl = TextEditingController();
  TextEditingController entrycontrol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: KscreenBg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 14),
              JournyTitle(),
              Container(
                width: w * 0.8,
                padding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                decoration: ktextField,
                child: Center(
                  child: TextFormField(
                    controller: titleControl,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Entry title",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  width: w * 0.8,
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.5, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: SingleChildScrollView(
                    reverse: entrycontrol.text.length > 20 ? true : false,
                    child: TextFormField(
                        controller: entrycontrol,
                        cursorColor: Colors.white,
                        maxLines: 20,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "create New Entry",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ))),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              JournyButton(
                  label: "  Save",
                  fn: () async {
                    if (titleControl.text.isEmpty || entrycontrol.text.isEmpty)
                      print("Please Enter title and Entry");
                    else {
                      await FirebaseFirestore.instance
                          .collection('entries')
                          .add({
                            'Title': titleControl.text,
                            'Entry': entrycontrol.text,
                            'Date': DateFormat.yMMMEd()
                                .add_jm()
                                .format(DateTime.now()),
                          })
                          .then(
                            (value) => showFireBaseAlert(context),
                          )
                          .catchError((error) => showErrorAlert(context));
                      titleControl.clear();
                      entrycontrol.clear();
                    }
                  }),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  showFireBaseAlert(BuildContext context) {
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("OK"));
    AlertDialog alert1 = AlertDialog(
      title: Text("Data Upload Status"),
      content: Text("Entry Added Succesfully"),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (context) => alert1,
    );
  }

  showErrorAlert(BuildContext context) {
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("OK"));
    AlertDialog alert = AlertDialog(
      title: Text("Something Went Wrong"),
      content: Text("Entry Not Added Succesfully Due to Error"),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleControl.dispose();
    entrycontrol.dispose();
    super.dispose();
  }
}
