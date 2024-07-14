import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/profile_controller.dart';
import '../../../core/shared/color.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../widget/profile/profile_widget.dart';


class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            return FutureBuilder(
                future: controller.dataTeacher
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Container(
                        padding: EdgeInsetsDirectional.only(
                            bottom: 10, start: 25, end: 25),
                        child: Container(
                          // color: Colors.blue,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 70),
                                child: Container(
                                  padding: EdgeInsetsDirectional.only(top: 70),
                                  decoration: BoxDecoration(
                                      color: ProjectColors.whiteColor,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                            color: ProjectColors.greyColor
                                                .withOpacity(0.5),
                                            offset: Offset.zero,
                                            blurRadius: 4,
                                            spreadRadius: 4)
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data['name'],
                                        style: TextStyles.font18BlackBold,
                                      ),
                                      Text(
                                        data['work'],
                                        style: TextStyles.font18GreyW400,
                                      ),
                                      ListItemAllInProfile(),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  child: ShowImageInProfile(
                                    data: data,
                                  )),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                });
          }),
    );
  }
}
