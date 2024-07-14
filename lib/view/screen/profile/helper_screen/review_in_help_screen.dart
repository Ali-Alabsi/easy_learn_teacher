import 'package:flutter/material.dart';

import '../../../../core/shared/color.dart';
import '../../../../core/shared/theming/text_style.dart';
import '../../../../core/widget/app_text_form_filed.dart';


class ReviewInHelpScreen extends StatelessWidget {
  const ReviewInHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
          height: 40,

          decoration: BoxDecoration(
                color: ProjectColors.mainColor,
                borderRadius: BorderRadius.circular(20)),
                      child: TextButton(onPressed: (){}, child: Text('عام',
                      style: TextStyles.font14WhiteW500,))),
                  SizedBox(
                    width: 15,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ProjectColors.mainColor,
                          width: 3
                        ),
                          color: ProjectColors.whiteColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(onPressed: (){}, child: Text('اللهجات',
                        style: TextStyles.font16mainColorBold,))),
                  SizedBox(
                    width: 15,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ProjectColors.mainColor,
                              width: 3
                          ),
                          color: ProjectColors.whiteColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(onPressed: (){}, child: Text('الدورات',
                        style: TextStyles.font16mainColorBold,))),
                  SizedBox(
                    width: 15,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ProjectColors.mainColor,
                              width: 3
                          ),
                          color: ProjectColors.whiteColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(onPressed: (){}, child: Text('المسدد',
                        style: TextStyles.font16mainColorBold,))),
                ],
              ),
            ),
            SizedBox
              (
              height: 20,),
            Row(
              children: [
                Expanded(
                  child: AppTextFormFiled(hintText: 'Search' ,
                    prefixIcon: Icon(Icons.search) ,
                    suffixIcon: Icon(Icons.swap_horiz_outlined),)
                ),

              ],
            )
          ],
        ),
      ),

    );
  }
}
