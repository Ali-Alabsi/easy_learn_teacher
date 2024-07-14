import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/profile_controller.dart';
import '../../../../core/shared/theming/text_style.dart';
import 'call_me_in_help_screen.dart';
import 'review_in_help_screen.dart';

class LayoutHelpScreen extends StatelessWidget {
  LayoutHelpScreen({super.key});
  ProfileController obGet = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'مركز المساعده',
              style: TextStyles.font16BlackBold,
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "اتصل بنا",
                    style: TextStyles.font16BlackBold,
                  ),
                ),
                Tab(
                  child: Text(" التعليقات", style: TextStyles.font16BlackBold),
                ),
              ],
              onTap: (int i) {
                if (i == 0) {
                  obGet.changeToScreenCallMe();
                } else {
                  obGet.changeToScreenReview();
                }
              },
            ),
          ),
          body: GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (controller) {
              return controller.isScreenCallMe
                  ? CallMeInHelpScreen()
                  : ReviewInHelpScreen();
            },
          ),
        ));
  }
}
