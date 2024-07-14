import 'package:easy_learn_teacher/core/shared/color.dart';
import 'package:easy_learn_teacher/core/widget/button.dart';
import 'package:easy_learn_teacher/core/widget/image_cache_error.dart';
import 'package:easy_learn_teacher/view/screen/courses/edit_courses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/view_courses_controller.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../../core/shared/variable.dart';
import '../../../core/widget/view_data_for_firebase_with_loading.dart';

class Courses extends StatelessWidget {

  const Courses({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('كورساتي', style: TextStyles.font20mainColorBold,),
          SizedBox(
            height: 20,
          ),
          ListItemCoursesInCoursesView(teacherId: teacherId),
        ],
      ),
    );
  }
}

class ListItemCoursesInCoursesView extends StatelessWidget {
  const ListItemCoursesInCoursesView({
    super.key,
    required this.teacherId,
  });

  final String teacherId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<ViewCoursesController>(
          init: ViewCoursesController(),
          builder: (controller) {
            return ViewDataForFireBaseWithLoading(
              widgetView: (snapshot) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return CardItemCoursesInPageCourses(
                        index: index,
                        snapshot: snapshot,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: snapshot.data.docs.length);
              },
              future:controller.dataCourses.where('teacher_id',isEqualTo: teacherId).get(),
            );
          }
      ),
    );
  }
}

class CardItemCoursesInPageCourses extends StatelessWidget {
  final  snapshot;
  final int index;
  const CardItemCoursesInPageCourses({
    super.key,required this.snapshot, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: ProjectColors.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ImageNetworkCache(
                    url:  snapshot.data.docs[index]['image'],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    snapshot.data.docs[index]['name'],
                    style: TextStyles.font20mainColorBold,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              snapshot.data.docs[index]['details'],
              maxLines: 6,
              style: TextStyles.font14GreyW300,
            ),
            SizedBox(
              height: 15,
            ),
            MainButton(
              color: Colors.green,
              name: 'تعديل',
              onPressed: () {
                Get.to(EditCourses(
                    teacherId:  snapshot.data.docs[index]['teacher_id'],
                    name:  snapshot.data.docs[index]['name'],
                    details:  snapshot.data.docs[index]['details'],
                    price:  snapshot.data.docs[index]['price'],
                    descount:  snapshot.data.docs[index]['discount'],
                    hours_counter:  snapshot.data.docs[index]['hours_counter'],
                    counter:  snapshot.data.docs[index]['counter'],
                    categories:  snapshot.data.docs[index]['categories'],
                  image: snapshot.data.docs[index]['image'],
                  courseId: snapshot.data.docs[index].id,
                ));
              },
              height: 55,
              margin: EdgeInsetsDirectional.zero,
            )
          ],
        ),
      ),
    );
  }
}
