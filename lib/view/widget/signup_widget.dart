//Gallery
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/sign_up_controller.dart';
import '../../core/shared/controller.dart';
import '../../core/widget/app_text_form_filed.dart';
import '../../core/widget/valid.dart';
import '../screen/auth/Login.dart';


// GetXCon obGet = Get.put(Sin());

Future pickImageFromGallery(context) async {
  final returnImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (returnImage == null) return;
  // setState(() {
  //   selectedIMage = File(returnImage.path);
  // _image = File(returnImage.path).readAsBytesSync();
  // });
  Navigator.of(context).pop(); //close the model sheet
}

//Camera
Future pickImageFromCamera(context, selectedIMage, image) async {
  final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
  if (returnImage == null) return;
  // setState(() {
  selectedIMage = File(returnImage.path);
  image = File(returnImage.path).readAsBytesSync();
  // });
  Navigator.of(context).pop();
}

class ButtonCreateAccountInLoginScreen extends StatelessWidget {
  const ButtonCreateAccountInLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ' امتلك حساب ',
          style: TextStyle(color: Colors.grey),
        ),
        TextButton(
            onPressed: () {
              Get.toNamed('/Login');
            },
            child: Text('تسجيل الدخول'))
      ],
    );
  }
}

void showImagePickerOption(BuildContext context, image, selectedIMage) {
  showModalBottomSheet(
      backgroundColor: Colors.blue[100],
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      pickImageFromGallery(image);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      pickImageFromCamera(context, selectedIMage, image);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

class FormInSignUp extends StatelessWidget {
  const FormInSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingUpController>(
      init: SingUpController(),
      builder: (controller) {
        return Form(
          key: controller.signUpForm,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                AppTextFormFiled(
                  noSpaceTextInputFormatter: false,
                  controller: MyController.nameSignup,
                  validator: (value){
                    if(value ==''){
                      return 'يجب ان يحتوي على اسم';
                    }
                  },
                  hintText: 'اسم المستخدم',
                  prefixIcon: Icon(Icons.account_circle),
                ),
                SizedBox(
                  height: 20,
                ),
                AppTextFormFiled(
                  controller: MyController.emailSignup,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(isEmail(value!) ==false){
                      return 'هذا الايميل غير صحيح';
                    }
                  },
                  hintText: 'الايميل',
                  prefixIcon: Icon(Icons.email),
                ),
                SizedBox(
                  height: 20,
                ),
                AppTextFormFiled(
                  controller: MyController.passwordSignup,
                  validator: (value){
                    if(isPassword(value!) ==false){
                      return 'كلمة المرور ضعية';
                    }
                  },
                  hintText: 'كلمة المرور ',
                  prefixIcon: Icon(Icons.lock),
                ),
                SizedBox(
                  height: 20,
                ),
                AppTextFormFiled(
                  noSpaceTextInputFormatter: false,
                  controller: MyController.workSignup,
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value == ''){
                      return 'يجب الا يكون الحقل فارغ';
                    }
                  },
                  hintText: 'العمل',
                  prefixIcon: Icon(Icons.work),
                ),
                SizedBox(
                  height: 20,
                ),
                AppTextFormFiled(
                  noSpaceTextInputFormatter: false,
                  controller: MyController.cerSignup,
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value == ''){
                      return 'يجب الا يكون الحقل فارغ';
                    }
                  },
                  hintText: 'الدورات او الشهدات الذي حصل عليها',
                  prefixIcon: Icon(Icons.school),
                ),
                SizedBox(
                  height: 20,
                ),
                AppTextFormFiled(
                  noSpaceTextInputFormatter: false,
                  controller: MyController.detailsSignup,
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value == '' || value!.length < 100){
                      return 'يجب ان لا يقل محتوى الحقل عن 100 حرف';
                    }
                  },
                  hintText: 'التفاصبل والخبرات السابقة',
                  prefixIcon: Icon(Icons.info),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
