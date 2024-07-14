import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_learn_teacher/view/screen/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/shared/controller.dart';
import '../core/widget/awesome_dialog.dart';

class LoginController extends GetxController{
   GlobalKey<FormState> loginForm = GlobalKey();
  bool isLoadingLogin = false;
  CollectionReference dataLoginTeacher = FirebaseFirestore.instance.collection('teachers');
  Future login(BuildContext context ,AsyncSnapshot<QuerySnapshot<Object?>> snapshot) async{
    try{
      isLoadingLogin = true;
      update();
      if( snapshot.data!.docs.length > 0){
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          if (snapshot.data!.docs[i]['active'] ==true) {
            try{
              final credential= await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: MyController.emailLogin.text,
                password: MyController.passwordLogin.text,
              );
              if(credential.user!= null) {
                await  AwesomeDialogFunction.awesomeDialogSuccess(context, 'تم عملية تسجيل الدخول بنجاح', 'أسم المستخدم وكلمة المرور صحيح');
                isLoadingLogin = false;
                Get.offAll(Layout());

              }
              isLoadingLogin = false;
            }
            on FirebaseAuthException catch (e) {
              isLoadingLogin = false;
              AwesomeDialogFunction.awesomeDialogError(context, 'Error', ' كلمة المرور خطاء ');
            }
            update();
            break;
          }else{
            isLoadingLogin = false;
            AwesomeDialogFunction.awesomeDialogError(context, 'Error', 'هذا الحساب مقيد ولم يتم الموافقة علية');

          }
        }}else{
        isLoadingLogin = false;
        AwesomeDialogFunction.awesomeDialogError(context, 'Error', 'هذا الحساب ليس موجود');

      }
    } catch (e){
      isLoadingLogin = false;
      print('Exception $e');
    }



  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

