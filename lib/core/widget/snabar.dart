
 import 'package:flutter/material.dart';

snackBarWidget(context , title){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title')));
 }