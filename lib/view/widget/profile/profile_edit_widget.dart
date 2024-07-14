import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import '../../../controller/profile_controller.dart';
import '../../../core/shared/color.dart';

class EditImageInProfile extends StatelessWidget {
  final ProfileController controller;

  const EditImageInProfile({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          controller.selectedImage?.path == null
              ? CircleAvatar(
            child: CircleAvatar(
              radius: 70,
              child: Icon(
                Icons.account_circle,
                size: 140,
                color: ProjectColors.mainColor,
              ),
            ),
            radius: 73,
            backgroundColor: ProjectColors.mainColor,
          )
              : CircleAvatar(
            radius: 80,
            backgroundColor: Colors.grey,
            // View Image for Variable image
            child: CircleAvatar(
              radius: 80,
              backgroundImage:
              FileImage(File(controller.selectedImage!.path)),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: InkWell(
              onTap: () {
                ImagePicker()
                    .pickImage(source: ImageSource.gallery,
                    imageQuality: 20
                )
                    .then((value) {
                  controller.addImageToProfile(value);
                });
              },
              child: Container(
                padding: EdgeInsetsDirectional.all(4),
                child: Icon(
                  Icons.image_outlined,
                  color: ProjectColors.mainColor,
                ),
                decoration: BoxDecoration(
                    color: ProjectColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border:
                    Border.all(color: ProjectColors.mainColor, width: 3)),
              ),
            ),
          )
        ],
      ),
    );
  }
}