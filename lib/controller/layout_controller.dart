import 'package:easy_learn_teacher/view/screen/add/add.dart';
import 'package:easy_learn_teacher/view/screen/courses/courses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../core/shared/variable.dart';
import '../view/screen/profile/profile.dart';
import '../view/screen/project/project.dart';

class LayoutController extends GetxController{

  int currentIndex = 2;
  List Screen =[
    Courses(),
    Project(),
    MainAdd( ),
    Courses(),
    Profile(),
  ];
  addTeacherId()async{
    teacherId =await FirebaseAuth.instance.currentUser!.uid;
    update();
  }
  List<String> nameScreen=[
    "الكورسات",
    "التطبيقات",
    "اضافة",
    "الدردشة",
    "البروفايل"
  ];
  changeCurrentIndex(int i){
    currentIndex = i;
    update();
  }
}