import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_learn_teacher/core/widget/button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/add_controller.dart';
import '../../../core/dependency_injection/dependency_injection.dart';
import '../../../core/shared/color.dart';
import '../../../core/shared/controller.dart';
import '../../../core/widget/app_text_form_filed.dart';
import '../../../core/widget/valid.dart';

class AddCourses extends StatelessWidget {
  final String teacherId;
  const AddCourses({Key? key, required this.teacherId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أضف كورس جديد'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: GetBuilder<AddController>(
                  init: AddController(),
                  builder: (controller) {
                    return Stack(
                      children: [
                        controller.selectedImage?.path == null
                            ? CircleAvatar(
                                radius: 80,
                              )
                            : CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.grey,
                                // View Image for Variable image
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: FileImage(
                                      File(controller.selectedImage!.path)),
                                ),
                              ),
                        Positioned(
                            bottom: -0,
                            left: 110,
                            child: CircleAvatar(
                              child: IconButton(
                                  onPressed: () {
                                    ImagePicker()
                                        .pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 20)
                                        .then((value) {
                                      controller.addImageToProfile(value);
                                    });
                                    // showImagePickerOption(context , image , selectedImage);
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                  )),
                            ))
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: DependencyInjection.obGetAddCourses.addCoursesForm,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    AppTextFormFiled(
                      noSpaceTextInputFormatter: false,
                      controller: MyController.titleCourses,
                      validator: (value) {
                        if (value == '') {
                          return 'يجب ان لا يكون العنوان فارغ';
                        }
                      },
                      hintText: 'عنوان الكورس',
                      prefixIcon: Icon(Icons.title_outlined),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextFormFiled(
                      noSpaceTextInputFormatter: false,
                      controller: MyController.detailsCourses,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 5,
                      validator: (value) {
                        if (value == '') {
                          return 'يجب ان لا يقل على 100 حرف ';
                        }
                      },
                      hintText: 'التفاصيل',
                      prefixIcon: Icon(Icons.info),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textFormFiledSelectOfListCategory(),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextFormFiled(
                      controller: MyController.hoursCourses,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == '') {
                          return 'يجب ان لا تكون القيمة فارغة';
                        }
                      },
                      hintText: ' عدد الساعات',
                      prefixIcon: Icon(Icons.watch_later),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextFormFiled(
                      controller: MyController.counterCourses,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == '') {
                          return 'يجب ان لا تكون القيمة فارغة';
                        }
                      },
                      hintText: ' عدد المحاضرات',
                      prefixIcon: Icon(Icons.video_camera_back),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextFormFiled(
                      controller: MyController.priceCourses,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == '') {
                          return 'يجب الا يكون الحقل فارغ';
                        }
                      },
                      hintText: 'السعر',
                      prefixIcon: Icon(Icons.price_change_rounded),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextFormFiled(
                      controller: MyController.discountCourses,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == '') {
                          return 'يجب الا يكون الحقل فارغ';
                        }
                      },
                      hintText: 'الخصم',
                      prefixIcon: Icon(Icons.discount),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GetBuilder<AddController>(builder: (controller) {
                      return controller.isLoading ?CircularProgressIndicator(): MainButton(
                        name: 'رفع',

                        onPressed: () async {
                          print(controller.selectedValue);
                          if (controller.addCoursesForm.currentState!.validate()) {
                           controller.addDataCoursesToFirebase(context ,teacherId);
                            // await  controller.uploadVideos(context);
                          }
                        },
                      );
                    })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container textFormFiledSelectOfListCategory() {
    return Container(
      child: GetBuilder<AddController>(builder: (controller) {
        return DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            fillColor: ProjectColors.mainColor.withOpacity(0.2),
            filled: true,
            prefixIcon: Icon(Icons.category),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            // Add more decoration..
          ),
          hint: const Text(
            'اختار تصنيف الكورس الخاص بك',
            style: TextStyle(fontSize: 14),
          ),
          items: controller.listCategoriesCourses
              .map((item) => DropdownMenuItem<String>(
                    value: item.id,
                    child: Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          validator: (value) {
            if (value == null) {
              return 'من فضلك قم ب اختيار التصنيف';
            }
            return null;
          },
          onChanged: (value) {
            controller.changSelectedValue( value.toString());
            //Do something when selected item is changed.
          },
          onSaved: (value) {


          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        );
      }),
    );
  }
}
