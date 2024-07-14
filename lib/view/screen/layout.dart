import 'package:easy_learn_teacher/controller/layout_controller.dart';
import 'package:easy_learn_teacher/view/screen/add/add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../core/shared/color.dart';
import '../../core/shared/theming/text_style.dart';
import '../../core/shared/variable.dart';
import '../../core/widget/awesome_dialog.dart';
import 'auth/Login.dart';
import 'courses/courses.dart';

class Layout extends StatelessWidget {


  Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('الصفحة الرئسية'), actions: [
        SizedBox(
          width: 20,
        ),
        InkWell(
          child: Icon(Icons.exit_to_app),
          onTap: () {
            AwesomeDialogFunction.awesomeDialogQuestion(
                context, 'تنبية', 'هل تريد تسجيل الخروج ؟', () {
              Get.offAll(Login());
              FirebaseAuth.instance.signOut();
            }, () {});
          },
        ),
        SizedBox(
          width: 15,
        ),
      ]),
      bottomNavigationBar: Card(
        color: ProjectColors.whiteColor,
        elevation: 3,
        child: GetBuilder<LayoutController>(
            init: LayoutController()..addTeacherId(),
            builder: (controller) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: GNav(
                    selectedIndex: controller.currentIndex,
                    textStyle: TextStyles.font16mainColorBold,
                    rippleColor: Colors.grey,
                    hoverColor: Colors.grey,
                    haptic: true,
                    tabBorderRadius: 15,
                    onTabChange: (i) {
                      controller.changeCurrentIndex(i);
                    },
                    tabActiveBorder: Border.all(color: Colors.black, width: 1),
                    // tabBorder: Border.all(color: Colors.grey, width: 1),
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 900),
                    gap: 8,
                    color: Colors.black87,
                    activeColor: ProjectColors.mainColor,
                    iconSize: 24,
                    tabBackgroundColor:
                        ProjectColors.mainColor.withOpacity(0.1),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    tabs: [
                      GButton(
                        icon: Icons.menu_book,
                        text: 'الكورسات',
                      ),
                      GButton(
                        icon: Icons.apps,
                        text: 'المشاريع',
                      ),
                      GButton(
                        style: GnavStyle.oldSchool,
                        backgroundColor:
                            ProjectColors.mainColor.withOpacity(0.5),
                        rippleColor: ProjectColors.mainColor,
                        iconSize: 35,
                        active: false,
                        padding: EdgeInsetsDirectional.all(5),
                        icon: Icons.add,
                        text: 'اضافة',
                      ),
                      GButton(
                        icon: Icons.chat,
                        text: 'الدردشات',
                      ),
                      GButton(
                        icon: Icons.account_circle,
                        text: 'البروفايل',
                      )
                    ]),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: GetBuilder<LayoutController>(
          init: LayoutController()..addTeacherId(),
          builder: (controller) {
        return Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 15),
            child:teacherId =='' ? CircularProgressIndicator(): controller.Screen[controller.currentIndex]);
      }),
    );
  }
}
