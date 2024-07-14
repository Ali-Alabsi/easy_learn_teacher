

import 'package:flutter/material.dart';

import '../../../../core/shared/color.dart';
import '../../../../core/shared/theming/text_style.dart';


class CallMeInHelpScreen extends StatelessWidget {
  const CallMeInHelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       color: ProjectColors.moreGrayColor,
       child: Padding(
         padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),

           child: ListView(
             children: [
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 15),
                 height: 60,
                 decoration: BoxDecoration(
                     color: ProjectColors.whiteColor,
                     borderRadius: BorderRadius.circular(20)
                 ),
                 child: Row(
                   children: [
                     Icon(Icons.check_box_outlined,),
                     SizedBox(width: 20,),
                     Text("خدمه العملاء",style: TextStyles.font16BlackBold,),
                   ],
                 ),
               ),
               SizedBox(
                 height: 25,),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 15),
                 height: 60,
                  decoration: BoxDecoration(
                      color: ProjectColors.whiteColor,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                   children: [
                     Icon(Icons.whatshot,),
                     SizedBox(width: 20,),
                     Text("واتس اب",style: TextStyles.font16BlackBold,),
                   ],
                 ),
               ),
               SizedBox(
                 height: 20,),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 15),
                 height: 60,
                 decoration: BoxDecoration(
                     color: ProjectColors.whiteColor,
                     borderRadius: BorderRadius.circular(20)
                 ),
                 child: Row(
                   children: [
                     Icon(Icons.webhook,),
                     SizedBox(width: 20,),
                     Text("موقع الكتروني",style: TextStyles.font16BlackBold,),
                   ],
                 ),
               ),
               SizedBox(
                 height: 20,),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 15),
                 height: 60,
                 decoration: BoxDecoration(
                     color: ProjectColors.whiteColor,
                     borderRadius: BorderRadius.circular(20)
                 ),
                 child: Row(
                   children: [
                     Icon(Icons.facebook,),
                     SizedBox(width: 20,),
                     Text("فيس بوك",style: TextStyles.font16BlackBold,),
                   ],
                 ),
               ),
               SizedBox(
                 height: 20,),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 15),
                 height: 60,
                 decoration: BoxDecoration(
                     color: ProjectColors.whiteColor,
                     borderRadius: BorderRadius.circular(20)
                 ),
                 child: Row(
                   children: [
                     Icon(Icons.wb_twilight,),
                     SizedBox(width: 20,),
                     Text("تويتر",style: TextStyles.font16BlackBold,),
                   ],
                 ),
               ),
               SizedBox(
                 height: 20,),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 15),
                 height: 60,
                 decoration: BoxDecoration(
                     color: ProjectColors.whiteColor,
                     borderRadius: BorderRadius.circular(20)
                 ),
                 child: Row(
                   children: [
                     Icon(Icons.install_mobile,),
                     SizedBox(width: 20,),
                     Text("انستقرام",style: TextStyles.font16BlackBold,),
                   ],
                 ),
               ),
             ],
           ),
         ),
     ),


    );
  }
}
