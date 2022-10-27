import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const KscreenBg = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color(0xff21d4fd),
      Color(0xffb721ff),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  ),
);

const KButtontext =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

const ktextField = BoxDecoration(
    color: Colors.black26, borderRadius: BorderRadius.all(Radius.circular(10)));
