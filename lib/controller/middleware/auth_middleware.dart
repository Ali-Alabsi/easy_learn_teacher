
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AuthMiddleware extends GetMiddleware{
  @override
  redirect  (String? route){
    if(FirebaseAuth.instance.currentUser!=null ) return RouteSettings(name: '/Layout');
  }
}
