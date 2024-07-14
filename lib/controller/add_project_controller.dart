import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_learn_teacher/core/shared/controller.dart';
import 'package:easy_learn_teacher/core/widget/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProjectController extends GetxController{
  CollectionReference dataProject = FirebaseFirestore.instance.collection('app');
  bool isLoading = false;
  final picker = ImagePicker();
  List<String> listImageURL=[];
   String?  downloadUrl;
  final GlobalKey<FormState> addProjectForm = GlobalKey();
  addDataProjectToFireBase(context ,String teacherId) async{
    isLoading = true;
    update();
    await uploadFile(context, teacherId);
    await uploadImageToFirebase(context ,teacherId);
    if(listImageURL != [] && downloadUrl !=null  ){
      dataProject.add({
        'name': MyController.titleProject.text,
        'details': MyController.detailsProject.text,
        'price': MyController.priceProject.text,
        'discount': MyController.discountProject.text,
        'image': listImageURL,
        'start': '0',
        'teacherId':teacherId,
        'sourseCode': downloadUrl ,
      }).then((value){
        AwesomeDialogFunction.awesomeDialogSuccess(context, 'تم بنجاح ', 'تم عملية اضافة المشروع بنجاح');
        isLoading = false;
        update();
        cleanData();
      }).catchError((e){
        AwesomeDialogFunction.awesomeDialogError(context, 'خطأ ', 'حدث خطأ ما برجاء المحاولة مرة اخرى');
        isLoading = false;
        update();
      });
    }else{
      AwesomeDialogFunction.awesomeDialogError(context, 'خطأ ', 'حدث خطأ ما برجاء المحاولة مرة اخرى');
      isLoading = false;
      update();
    }

  }
  cleanData(){
    MyController.titleProject.text = '';
    MyController.detailsProject.text = '';
    MyController.priceProject.text = '';
    MyController.discountProject.text = '';
    listImageURL = [];
    downloadUrl = null;
  }

  Future<void> uploadFile(context,String teacherId) async {
    await AwesomeDialogFunction.awesomeDialogWarning(context, 'تنبية ', 'يجب عليك اختيار المشروع الذي تريد عرضة للبيع ويجب ان يكون يوافق المتطلبات او سوف يتم رفضة من قبل الادارة');
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = result.files.single;
      final storageRef = FirebaseStorage.instance.ref();
      final pathReference = storageRef.child("projects/$teacherId/${MyController.titleProject.text}/${file.name}");
      try {
        final snapshot= await pathReference.putFile(File(file.path! ));
         downloadUrl = await snapshot.ref.getDownloadURL();
       await  AwesomeDialogFunction.awesomeDialogSuccess(context, 'تم بنجاح ', 'تم عملية رفع المشروع بنجاح');
        print(downloadUrl);
      } on FirebaseException catch (e) {
        AwesomeDialogFunction.awesomeDialogError(context, 'خطأ ', 'حدث خطأ ما برجاء المحاولة مرة اخرى');
      }
    } else {
    }

  }





  Future<void> uploadImageToFirebase( context, teacherId) async {
    listImageURL=[];
    await AwesomeDialogFunction.awesomeDialogWarning(context, 'تنبية ', 'يجب عليك اضافة صور من المشروع الذي تريد عرضة للبيع ويفضل يكون عدد الصور بين 3 الى 5 وتكون توضح اهمية المشروع ');
    final pickedImages = await picker.pickMultiImage(imageQuality: 20);
    if (pickedImages != null && pickedImages.isNotEmpty) {
      // ignore: unused_local_variable
      int i=0;
     listImageURL=[];
      for (var pickedImage in pickedImages) {
        final imageFile = File(pickedImage.path);
        final storageReference = FirebaseStorage.instance.ref().child('projects/$teacherId/${MyController.titleProject.text}/images/${pickedImage.name}');
        await storageReference.putFile(imageFile);
        i++;
        final imageUrl = await storageReference.getDownloadURL();
        listImageURL.add(imageUrl);
        print('Image uploaded successfully. URL: $imageUrl');
      }
      print('counter of Image $i' );
      print('counter of Image $listImageURL' );
    } else {
    }
  }

}

