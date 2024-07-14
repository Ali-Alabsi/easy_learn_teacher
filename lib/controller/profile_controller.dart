import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core/widget/awesome_dialog.dart';

class ProfileController extends GetxController {
  CollectionReference dataTeacher =
      FirebaseFirestore.instance.collection('teachers');
  GlobalKey<FormState> editProfileForm = GlobalKey();
  changeIsDark(bool value) {
    isDark = value;
    // if(isDark ==true){
    //   Get.changeTheme(ThemeData.light());
    // }else{
    //   Get.changeTheme(ThemeData.dark());
    // }
    update();
  }

  bool isLangArabic = true;
  bool isLangEng = false;
  bool isLangFrance = false;
  String nameLang = 'العربية';

  changeIsLang(String name) {
    if (name == 'er') {
      isLangArabic = true;
      isLangEng = false;
      isLangFrance = false;
      nameLang = 'العربية';
    } else if (name == 'en') {
      isLangArabic = false;
      isLangEng = true;
      isLangFrance = false;
      nameLang = 'الانجليزية';
    } else if (name == 'fr') {
      isLangArabic = false;
      isLangEng = false;
      isLangFrance = true;
      nameLang = 'الفرنسية';
    }
    update();
  }

// Edit Profile
  XFile? selectedImage;
  bool isDark = false;
  bool isLoadingEdit = false;

  Future<void> updateTeacher(context, name, work, cer, details) {
    isLoadingEdit = true;
    update();
    return dataTeacher
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'name': name, 'work': work,'certificates': cer,'details': details}).then((value) {
      isLoadingEdit = false;
      update();
      return AwesomeDialogFunction.awesomeDialogSuccess(
          context, 'تم بنجاح', 'تم عملية تعديل المعلم بنجاح');
    }).catchError((error) {
      isLoadingEdit = false;
      AwesomeDialogFunction.awesomeDialogError(
          context, 'خطاء', "Failed to update user: $error");
    });
  }

  addImageToProfile(image) async {
    selectedImage = await image;
    update();
  }

  bool isScreenCallMe = true;
  changeToScreenCallMe (){
    isScreenCallMe = true;
    print('a');
    update();
  }
  changeToScreenReview(){
    isScreenCallMe = false;
    update();
  }
}
