import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_learn_teacher/controller/view_courses_controller.dart';
import 'package:easy_learn_teacher/core/widget/button.dart';
import 'package:easy_learn_teacher/core/widget/image_cache_error.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/add_controller.dart';
import '../../../core/dependency_injection/dependency_injection.dart';
import '../../../core/shared/color.dart';
import '../../../core/shared/controller.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../../core/widget/app_text_form_filed.dart';
import '../../../core/widget/awesome_dialog.dart';
import '../../../core/widget/video_player/video_player.dart';

class EditCourses extends StatelessWidget {
  final String teacherId;
  final String name;
  final String details;
  final String price;
  final String descount;
  final String hours_counter;
  final String counter;
  final String categories;
  final String image;
  final String courseId;

  const EditCourses(
      {Key? key,
      required this.teacherId,
      required this.name,
      required this.details,
      required this.price,
      required this.descount,
      required this.hours_counter,
      required this.counter,
      required this.categories,
      required this.image,
      required this.courseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyController.titleEditCourses.text = name;
    MyController.detailsEditCourses.text = details;
    MyController.priceEditCourses.text = price;
    MyController.discountEditCourses.text = descount;
    MyController.hoursEditCourses.text = hours_counter;
    MyController.counterEditCourses.text = counter;
    MyController.categoriesEditCourses.text = categories;
    DependencyInjection.obGetEditCourses.url = image;
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل الكورس '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageProfileInEditCourses(image: image, name: name),
            SizedBox(
              height: 20,
            ),
            FormEditCourses(courseId: courseId),
          ],
        ),
      ),
    );
  }
}

class FormEditCourses extends StatelessWidget {
  const FormEditCourses({
    super.key,
    required this.courseId,
  });

  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: DependencyInjection.obGetEditCourses.editCoursesForm,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextFormFiled(
              noSpaceTextInputFormatter: false,
              controller: MyController.titleEditCourses,
              validator: (value) {
                if (value == '') {
                  return 'يجب ان لا يكون العنوان فارغ';
                }
              },
              hintText: 'عنوان الكورس',
              prefixIcon: Icon(Icons.title_outlined),
            ),
            SizedBox(
              height: 20,
            ),
            AppTextFormFiled(
              noSpaceTextInputFormatter: false,
              controller: MyController.detailsEditCourses,
              keyboardType: TextInputType.emailAddress,
              maxLines: 5,
              validator: (value) {
                if (value == '') {
                  return 'يجب ان لا يقل على 100 حرف ';
                }
              },
              hintText: 'التفاصيل',
              prefixIcon: Icon(Icons.info),
            ),
            SizedBox(
              height: 20,
            ),
            AppTextFormFiled(
              controller: MyController.hoursEditCourses,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == '') {
                  return 'يجب ان لا تكون القيمة فارغة';
                }
              },
              hintText: ' عدد الساعات',
              prefixIcon: Icon(Icons.watch_later),
            ),
            SizedBox(
              height: 20,
            ),
            AppTextFormFiled(
              controller: MyController.counterEditCourses,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == '') {
                  return 'يجب ان لا تكون القيمة فارغة';
                }
              },
              hintText: ' عدد المحاضرات',
              prefixIcon: Icon(Icons.video_camera_back),
            ),
            SizedBox(
              height: 20,
            ),
            AppTextFormFiled(
              controller: MyController.priceEditCourses,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == '') {
                  return 'يجب الا يكون الحقل فارغ';
                }
              },
              hintText: 'السعر',
              prefixIcon: Icon(Icons.price_change_rounded),
            ),
            SizedBox(
              height: 20,
            ),
            AppTextFormFiled(
              controller: MyController.discountEditCourses,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == '') {
                  return 'يجب الا يكون الحقل فارغ';
                }
              },
              hintText: 'الخصم',
              prefixIcon: Icon(Icons.discount),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'المحاضرات الخاصة بالكورس',
              style: TextStyles.font18mainColorBold,
            ),
            SizedBox(
              height: 10,
            ),
            ListLessonInEditCourses(courseId: courseId),
            SizedBox(
              height: 10,
            ),
            GetBuilder<ViewCoursesController>(
              builder: (controller) {
                return InkWell(
                    onTap: () {
                     controller.mainUploadVideo(context,courseId);
                    },
                    child: Text(
                      'اضافة محاضرات جديدة',
                      style: TextStyles.font14GreyW300,
                    ));
              }
            ),
            SizedBox(
              height: 20,
            ),
            GetBuilder<ViewCoursesController>(builder: (controller) {
              return controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : MainButton(
                      name: 'تعديل',
                      onPressed: () async {
                        if (controller.editCoursesForm.currentState!
                            .validate()) {
                          controller.updateCourse(context, courseId);
                          // await  controller.uploadVideos(context);
                        }
                      },
                    );
            }),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class ListLessonInEditCourses extends StatelessWidget {
  const ListLessonInEditCourses({
    super.key,
    required this.courseId,
  });

  final String courseId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewCoursesController>(
        init: ViewCoursesController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.dataCourses
                  .doc(courseId)
                  .collection('video')
                  .orderBy('video_id')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ItemInTuition(
                            icon: Icons.slow_motion_video_sharp,
                            index: index,
                            snapshot: snapshot,
                            coursesId: courseId,
                            controller: controller,
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: snapshot.data!.docs.length);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              });
        });
  }
}

class ImageProfileInEditCourses extends StatelessWidget {
  const ImageProfileInEditCourses({
    super.key,
    required this.image,
    required this.name,
  });

  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder<ViewCoursesController>(
          init: ViewCoursesController(),
          builder: (controller) {
            return Stack(
              children: [
                controller.selectedImage?.path == null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(image),
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey,
                        // View Image for Variable image
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              FileImage(File(controller.selectedImage!.path)),
                        ),
                      ),
                Positioned(
                    bottom: -0,
                    left: 110,
                    child: CircleAvatar(
                      child: IconButton(
                          onPressed: () {
                            ImagePicker()
                                .pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 20)
                                .then((value) {
                              controller.addImageToProfile(value, name);
                            });
                            // showImagePickerOption(context , image , selectedImage);
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                          )),
                    ))
              ],
            );
          }),
    );
  }
}

class ItemInTuition extends StatelessWidget {
  final ViewCoursesController controller;
  final String coursesId;
  final int index;
  final IconData icon;
  final bool isPaid;

  final snapshot;

  const ItemInTuition({
    super.key,
    required this.index,
    this.isPaid = false,
    required this.icon,
    required this.snapshot,
    required this.coursesId,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isPaid) {
          AwesomeDialogFunction.awesomeDialogError(context, 'خطاء في الدفع',
              'يرجى اولاُ دفع قيمتة الكورس حتى تستطيع المشاهدة');
        } else {
          Get.to(VideoApp(
            urlVideo: snapshot.data!.docs[index]['video_url'],
            videoId: snapshot.data!.docs[index].id,
            coursesId: coursesId,
          ));
        }
      },
      child: Container(
        height: 80,
        child: Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // CircleAvatar(
                        //   radius: 35,
                        //   backgroundImage:
                        //   AssetImage('assets/images/FlutterCourse.png'),
                        // ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: ProjectColors.greyColor300,
                          ),
                          child: Center(
                              child: Text(
                            '0${index + 1}',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                snapshot.data!.docs[index]['name'],
                                style: TextStyles.font20BlackW100,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                height: 4,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: ProjectColors.mainColor,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    icon,
                    color: Colors.blue,
                    size: 35,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      controller.deleteVideo(
                          context,
                          snapshot.data!.docs[index]['video_address'],
                          coursesId,
                          snapshot.data!.docs[index].id);
                    },
                    child: Icon(
                      Icons.delete,
                      color: ProjectColors.redColor,
                      size: 35,
                    ),
                  )
                  // SizedBox(
                  //   width: 107,
                  // ),
                ],
              ),
            )),
      ),
    );
  }
}
