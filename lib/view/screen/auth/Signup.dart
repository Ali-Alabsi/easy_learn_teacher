import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../controller/sign_up_controller.dart';
import '../../../core/widget/button.dart';
import '../../widget/signup_widget.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AddImageInSignupPage(),
                SizedBox(
                  height: 30,
                ),
                FormInSignUp(),
                GetBuilder<SingUpController>(
                  // init: SingUpController(),
                  builder: (controller) {
                    if (controller.isLoading == false) {
                      return MainButton(
                        name: 'انشاء حساب ',
                        onPressed: () async {
                          if (controller.signUpForm.currentState!.validate()) {
                            // Get.toNamed('/Login');
                            await controller.singUpController(context);
                          }
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                ButtonCreateAccountInLoginScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddImageInSignupPage extends StatelessWidget {
  const AddImageInSignupPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 60),
      Center(
        child: GetBuilder<SingUpController>(
          init: SingUpController(),
          builder: (controller) {
            return Stack(
              children: [
                controller.selectedImage?.path == null
                    ? CircleAvatar(radius: 80,)
                    : CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey,
                        // View Image for Variable image
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(File(controller.selectedImage!.path)),
                        ),
                      ),
                Positioned(
                    bottom: -0,
                    left: 110,
                        child: CircleAvatar(
                          child: IconButton(
                              onPressed: () {
                                ImagePicker()
                                    .pickImage(source: ImageSource.gallery,
                                    imageQuality: 20
                                )
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
          }
        ),
      ),
    ]);
  }
}
