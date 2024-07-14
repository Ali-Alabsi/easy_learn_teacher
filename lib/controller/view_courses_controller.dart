import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_learn_teacher/core/shared/controller.dart';
import 'package:easy_learn_teacher/core/widget/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../core/firebase_concepts/end_points.dart';

class ViewCoursesController extends GetxController {
  CollectionReference dataCourses =
      FirebaseFirestore.instance.collection('courses');
  final GlobalKey<FormState> editCoursesForm = GlobalKey();
  XFile? selectedImage;
  String? url;
  bool isLoading = false;

  addImageToProfile(image, name) async {
    selectedImage = await image;
    final imageUpload = await FirebaseStorage.instance
        .ref()
        .child('courses/${MyController.titleCourses.text}/profile.jpg');
    await imageUpload.putFile(File(selectedImage!.path));
    url = await imageUpload.getDownloadURL();
    print(imageUpload.fullPath);
    update();
  }

  Future<void> updateCourse(context, String courseId) {
    isLoading = true;
    update();
    return dataCourses.doc(courseId).update({
      'name': MyController.titleEditCourses.text,
      'details': MyController.detailsEditCourses.text,
      'price': MyController.priceEditCourses.text,
      'discount': MyController.discountEditCourses.text,
      'hours_counter': MyController.hoursEditCourses.text,
      'active': false,
      'counter': MyController.counterEditCourses.text,
    }).then((value) {
      AwesomeDialogFunction.awesomeDialogSuccess(
          context, 'تم  بنجاح', 'تم عملية التعديل بنجاح ');
      isLoading = false;
      update();
      return value;
    }).catchError((error) {
      isLoading = false;
      update();
      return error;


    });

  }

  String? i='1';

  Future<void> mainUploadVideo(context, docId) async {
    isLoading = true;
    update();
    AwesomeDialogFunction.awesomeDialogInputData(context, '', 'desc', () async{
      if (MyController.numberAddCourses.text != '') {
        i = MyController.numberAddCourses.text;
        final pickedVideo = await _pickVideo();
        if (pickedVideo != null) {
          await uploadVideo(context,pickedVideo ,docId);
        }
        isLoading = false;
        update();
      }
    }, () {
      isLoading = false;
      update();
      print('cancel');
    });

  }

  Future<XFile?> _pickVideo() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    return pickedVideo;
  }

  Future<void> uploadVideo(context, XFile video ,docId) async {
    final fileName1= video.name;
    final storageRef =
        FirebaseStorage.instance.ref().child('courses/${MyController.titleEditCourses.text}/videos/$fileName1');
    final uploadTask = await storageRef.putFile(File(video.path));
    final downloadUrl = await uploadTask.ref.getDownloadURL();
    final fileName = uploadTask.ref.name;
    final fillPath = uploadTask.ref.fullPath;
    print('Download URL: $downloadUrl');

    await FirebaseFirestore.instance
        .collection('${FireBaseKey.courses}')
        .doc(docId)
        .collection('${FireBaseKey.video}')
        .add({
      '${FireBaseKey.name}': fileName,
      'video_id': "$i",
      'video_url': downloadUrl,
      'video_address': fillPath
    });
    AwesomeDialogFunction.awesomeDialogSuccess(
        context, 'تم رفع الحاضره رقم $i  بنجاح', 'اسم المحاضرة $fileName');
    print('Video uploaded to: $downloadUrl');
    isLoading = false;
    update();
    print('succc---------------------------------');
  }

  deleteVideo(context, address, coursesId, doc) async {
    final storageRef = FirebaseStorage.instance.ref();
    final desertRef = storageRef.child(address);
    await desertRef.delete();
    await dataCourses.doc(coursesId).collection('video').doc(doc).delete();
    await AwesomeDialogFunction.awesomeDialogSuccess(
        context, 'تم بنجاح', 'تم عملية حذف المحاضرة بنجاح');
    update();
  }
}
