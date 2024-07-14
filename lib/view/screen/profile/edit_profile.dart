import 'dart:io';
import 'package:easy_learn_teacher/core/dependency_injection/dependency_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/profile_controller.dart';
import '../../../core/shared/controller.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../../core/widget/app_text_form_filed.dart';
import '../../../core/widget/button.dart';
import '../../widget/profile/profile_edit_widget.dart';
class EditProfile extends StatelessWidget {
  const EditProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تعديل الحساب', style: TextStyles.font18BlackBold),
      ),
      body: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            return FutureBuilder(
                future: controller.dataTeacher.doc(FirebaseAuth.instance.currentUser!.uid).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      MyController.nameEditProfile.text = snapshot.data!['name'];
                      MyController.workEditProfile.text = snapshot.data!['work'];
                      MyController.certificatesEditProfile.text = snapshot.data!['certificates'];
                      MyController.detailsEditCourses.text = snapshot.data!['details'];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SingleChildScrollView(
                          child: Form(
                            key: DependencyInjection.obGetProfile.editProfileForm,
                            child: Column(
                              children: [
                                EditImageInProfile(controller: controller),
                                SizedBox(
                                  height: 20,
                                ),
                                AppTextFormFiled(
                                  validator: (value){
                                    if (value!.isEmpty) {
                                      return 'يجب ادخال اسم المستخدم';
                                    }
                                  },
                                  hintText: 'اسم المستخدم ',
                                  prefixIcon: Icon(Icons.account_circle),
                                  controller: MyController.nameEditProfile,
                                    noSpaceTextInputFormatter:false
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                AppTextFormFiled(
                                  validator: (value){
                                    if (value!.isEmpty) {
                                      return 'يجب ادخال الوظيفة';
                                    }
                                  },
                                  noSpaceTextInputFormatter:false,
                                  hintText: 'الوظيفة',
                                  prefixIcon: Icon(Icons.work),
                                  controller: MyController.workEditProfile,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                AppTextFormFiled(
                                  validator: (value){
                                    if (value!.isEmpty) {
                                      return 'يجب ادخال الشهادة';
                                    }
                                  },
                                  noSpaceTextInputFormatter:false,
                                  hintText: 'الشهادة',
                                  prefixIcon: Icon(Icons.school),
                                  controller: MyController.certificatesEditProfile,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                AppTextFormFiled(
                                  validator: (value){
                                    if (value!.length < 100) {
                                      return 'يجب ادخال التفاصيل بحيث لا يقل عن 100 حرف';
                                    }
                                  },
                                  noSpaceTextInputFormatter:false,
                                  maxLines: 4,
                                  hintText: 'التفاصيل',
                                  prefixIcon: Icon(Icons.info),
                                  controller: MyController.detailsEditProfile,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                controller.isLoadingEdit ? CircularProgressIndicator() :MainButton(
                                  name: 'تعديل الحساب',
                                  onPressed: () async {
                                    if(controller.editProfileForm.currentState!.validate()){
                                      await controller.updateTeacher(
                                        context,
                                        MyController.nameEditProfile.text,
                                        MyController.workEditProfile.text,
                                        MyController.certificatesEditProfile.text,
                                        MyController.detailsEditProfile.text,
                                      );
                                      Get.back();
                                    }

                                  },
                                  margin:
                                  EdgeInsetsDirectional.symmetric(horizontal: 0),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                });
          }),
    );
  }
}


