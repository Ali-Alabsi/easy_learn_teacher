import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_learn_teacher/core/shared/controller.dart';
import 'package:easy_learn_teacher/core/widget/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import '../core/firebase_concepts/end_points.dart';
import '../core/widget/snabar.dart';

class AddController extends GetxController {

  bool isLoading = false;
  CollectionReference dataCourses =
      FirebaseFirestore.instance.collection('courses');

  CollectionReference dataCategories =
      FirebaseFirestore.instance.collection('categories');
  List listCategoriesCourses = [];
  String? selectedValue;

  changSelectedValue(value) {
    selectedValue = value;
    update();
  }

  List<String> listNameCategories = [];
  XFile? selectedImage;
  String? url;
  final GlobalKey<FormState> addCoursesForm = GlobalKey();

  addImageToProfile(image) async {
    selectedImage = await image;
    update();
  }

  addDataToListCategoriesCourses() async {
    QuerySnapshot dataCategoriesCoursesT =
        await FirebaseFirestore.instance.collection("categories").get();
    listCategoriesCourses.addAll(dataCategoriesCoursesT.docs);

    if (listNameCategories.length <= 0) {
      for (int i = 0; i < listCategoriesCourses.length; i++) {
        print(listCategoriesCourses[i]['name']);
        print('--------------------------------------------');
        listNameCategories.add(listCategoriesCourses[i]['name']);
        // print(listNameCategories);
      }
    }
  }

  addDataCoursesToFirebase(BuildContext context ,String teacherId) async {
    isLoading = true;
    update();
    if (selectedImage != null) {
      try {
        final imageUpload = await FirebaseStorage.instance
            .ref()
            .child('courses/${MyController.titleCourses.text}/profile.jpg');
        await imageUpload.putFile(File(selectedImage!.path));
        url = await imageUpload.getDownloadURL();
        print(imageUpload.fullPath);
        var docId = await FirebaseFirestore.instance
            .collection('${FireBaseKey.courses}')
            .add({
          '${FireBaseKey.name}': '${MyController.titleCourses.text}',
          '${FireBaseKey.details}': '${MyController.detailsCourses.text}',
          '${FireBaseKey.hours}': '${MyController.hoursCourses.text}',
          '${FireBaseKey.categories_id}': selectedValue,
          'teacher_id': teacherId,
          '${FireBaseKey.hours_counter}': '${MyController.counterCourses.text}',
          '${FireBaseKey.price}': '${MyController.priceCourses.text}',
          '${FireBaseKey.discount}': '${MyController.discountCourses.text}',
          '${FireBaseKey.image}': url,
          '${FireBaseKey.active}': false,
          '${FireBaseKey.evaluation}': '0',
        });
        print('Success----------------------------${docId.id}----------------');
        print('');
        await uploadVideos(context, docId.id);
        isLoading = false;
        update();
        AwesomeDialogFunction.awesomeDialogSuccess(context, 'تم العملية رفع الكورس  بنجاح', "تم عملية رفع جميع الكورسات بنجاح سوف يتم التاكد من المحتوى الخاص انه يوفق المتطلبات بعد ذلك سوف يتم عرض");
        cleanData();
        // snackBarWidget(context, '${m.message}');
      } on FirebaseAuthException catch (e) {
        snackBarWidget(context, 'error ');
        AwesomeDialogFunction.awesomeDialogError(
            context, 'Error', '${e.message}');
        isLoading = false;
        update();
      } catch (e) {
        AwesomeDialogFunction.awesomeDialogError(context, 'Error', '$e');
        isLoading = false;
        update();
      }
    } else {
      AwesomeDialogFunction.awesomeDialogError(
          context, 'Error', 'يرجى تحميل الصورة');
      isLoading = false;
      update();
    }
  }
  cleanData(){
    MyController.titleCourses.text = '';
    MyController.detailsCourses.text = '';
    MyController.hoursCourses.text = '';
    MyController.counterCourses.text = '';
    MyController.priceCourses.text = '';
    MyController.discountCourses.text = '';
    selectedImage = null;
    url = null;
  }

  final _storage = FirebaseStorage.instance;
  List _videoRefs = [];
  late String fileName;
  String? fillPath ;
  void _addVideoRef(String filePath) {
    fileName = basename(filePath);
    final videoRef = _storage
        .ref('courses/${MyController.titleCourses.text}/videos/$fileName');
    _videoRefs.add(videoRef);
    fillPath = videoRef.fullPath;
  }

  Future<void> uploadVideos(context, docId) async {
    fillPath =null;
    final pickedFiles = await ImagePicker().pickMultipleMedia();
    if (pickedFiles != null) {
      int i = 1;
      for (final pickedFile in pickedFiles) {
        final file = File(pickedFile.path);
        _addVideoRef(pickedFile.path);
        final snapshot = await _videoRefs.last.putFile(file);
        final downloadUrl = await snapshot.ref.getDownloadURL();
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
        i++;
      }
      isLoading = false;
      update();
      print('succc---------------------------------');
    } else {
      print('No videos selected');
    }
  }


  @override
  void onInit() async {
    addDataToListCategoriesCourses();
    // TODO: implement onInit
    super.onInit();
  }
}
