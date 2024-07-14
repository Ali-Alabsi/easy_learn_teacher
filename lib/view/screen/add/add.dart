import 'package:easy_learn_teacher/controller/add_controller.dart';
import 'package:easy_learn_teacher/controller/add_project_controller.dart';
import 'package:easy_learn_teacher/core/shared/color.dart';
import 'package:easy_learn_teacher/core/widget/button.dart';
import 'package:easy_learn_teacher/core/widget/image_cache_error.dart';
import 'package:easy_learn_teacher/view/screen/add/add_courses.dart';
import 'package:easy_learn_teacher/view/screen/add/add_project.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../../core/shared/variable.dart';
import '../../../core/widget/view_data_for_firebase_with_loading.dart';

class MainAdd extends StatelessWidget {

  const MainAdd({Key? key, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListItemCoursesInAddPage(teacherId:  teacherId,),
        Container(
          height: 6,
          width: double.infinity,
          color: ProjectColors.greyColors200,
        ),
        SizedBox(
          height: 15,
        ),
        ListItemProjectInAddPage(teacherId: teacherId,)
      ],
    );
  }
}

class ListItemProjectInAddPage extends StatelessWidget {
  final String teacherId ;
  const ListItemProjectInAddPage({
    super.key, required this.teacherId,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GetBuilder<ProjectController>(
            init: ProjectController(),
            builder: (controller) {
              return  ViewDataForFireBaseWithLoading(
                future: controller.dataProject.where('teacherId' , isEqualTo: teacherId).get(),
                widgetView: (snapshot){
                return  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'مشاريعي',
                            style: TextStyles.font20mainColorBold,
                          ),
                          Text(
                            'عرض الكل ',
                            style: TextStyles.font18GreyW400,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: snapshot.data.docs.length >0 ? ListView.separated(
                            itemBuilder: (context, index) {
                              return CardItemProjectInAddPage(
                                snapshot: snapshot,
                                index: index,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: snapshot.data.docs.length,): Center(child: Text('لا يوجد كورسات لك بعد يمكنك اضافة كورسات جديدة'),) ,
                      ),
                      MainButton(
                        name: 'اضافة مشروع جديد',
                        onPressed: () async {
                          Get.to(AddProject(teacherId: teacherId));
                        },
                        margin: EdgeInsetsDirectional.zero,
                      )
                    ],
                  );
                },
              );
            }));
  }
}

class CardItemProjectInAddPage extends StatelessWidget {
  final snapshot;
  final int index;
  const CardItemProjectInAddPage({
    super.key,required this.snapshot, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  child: ImageNetworkCache(
                    url: snapshot.data.docs[index]['image'][0],
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    snapshot.data.docs[index]['name'],
                    maxLines: 2,
                    style: TextStyles.font18mainColorBold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              snapshot.data.docs[index]['details'],
              style: TextStyles.font14GreyW300,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}

class ListItemCoursesInAddPage extends StatelessWidget {
  final String teacherId;
  const ListItemCoursesInAddPage({
    super.key, required this.teacherId,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GetBuilder<AddController>(
            init: AddController(),
            builder: (controller) {
              return ViewDataForFireBaseWithLoading(
                future: controller.dataCourses
                    .where('teacher_id', isEqualTo: teacherId)
                    .get(),
                widgetView: (snapshot) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'كورساتي',
                            style: TextStyles.font20mainColorBold,
                          ),
                          Text(
                            'عرض الكل ',
                            style: TextStyles.font18GreyW400,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 180,
                        child:snapshot.data!.docs.length >0 ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CardItemCoursesInAddPage(
                                index: index,
                                snapshot: snapshot,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 10,
                              );
                            },
                            itemCount: snapshot.data!.docs.length) : Center(child: Text('لا يوجد كورسات لك بعد يمكنك اضافة كورسات جديدة'),),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MainButton(
                        name: 'اضافة كورس جديد',
                        onPressed: () async {

                          Get.to(AddCourses(teacherId: teacherId,));
                        },
                        margin: EdgeInsetsDirectional.zero,
                      )
                    ],
                  );
                },
              );
            }));
  }
}

class CardItemCoursesInAddPage extends StatelessWidget {
  final snapshot;
  final int index;

  const CardItemCoursesInAddPage({
    super.key,
    required this.snapshot,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 160,
        width: 220,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF956CF7),
                Color(0xFFD276B6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.favorite,
                  size: 40,
                  color: ProjectColors.greyColors200,
                ),
                Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 70,
                    width: 70,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: ImageNetworkCache(
                      // url: snapshot.data.docs[index]['image'],
                      url:
                          'https://firebasestorage.googleapis.com/v0/b/teastlearingapp.appspot.com/o/user%2Funnamed.jpg?alt=media&token=5ddf5493-3021-4a9e-81ac-c46fcd09b348',
                    )),
              ],
            ),
            Text(
              snapshot.data.docs[index]['name'],
              style: TextStyles.font18WhiteBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
