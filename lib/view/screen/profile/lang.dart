
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/profile_controller.dart';
import '../../../core/shared/theming/text_style.dart';

class Lang extends StatelessWidget {
  const Lang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('اللغات', style: TextStyles.font18BlackBold,),
      ),
      body: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 15 , vertical: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('اللغات الشائعة ' ,style: TextStyles.font16BlackBold,),
            Container(
              padding: EdgeInsetsDirectional.only(start: 30),
              child: GetBuilder<ProfileController>(
                init: ProfileController(),
                builder:(controller)=> Column(
                  children: [
                    CheckboxListTile(value: controller.isLangArabic, onChanged: (value){ controller.changeIsLang('er');} ,title:  Text('العربية' , style: TextStyles.font14BlackBold,), ),
                    CheckboxListTile(value: controller.isLangFrance, onChanged: (value){ controller.changeIsLang('fr');} ,title:  Text('الفرنسي' , style: TextStyles.font14BlackBold,), ),
                    CheckboxListTile(value: controller.isLangEng, onChanged: (value){  controller.changeIsLang('en');} ,title:  Text('الانجليزي' , style: TextStyles.font14BlackBold,), ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
