import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_learn_teacher/core/shared/variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../controller/app_controller.dart';
import '../../../core/dependency_injection/dependency_injection.dart';
import '../../../core/shared/color.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../../core/widget/image_cache_error.dart';


class Project extends StatelessWidget {
  const Project({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GetBuilder<AppController>(
              init: AppController()..addDataToListApp(),
              builder: (controller) {
                return FutureBuilder(
                    future: controller.dataApp.where('teacherId',isEqualTo: teacherId).get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                              itemBuilder: (context, index) => InkWell(
                                onTap: (){
                                  // Get.to(ViewDetailsView(appId: controller.listApp[index].id));
                                },
                                child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CarouselSlider(
                                              options: CarouselOptions(height: 210),
                                              items: imageAppInProject(index)),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${snapshot.data!.docs[index]['name']}",
                                                  style: TextStyles
                                                      .font18mainColorBold,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '${snapshot.data!.docs[index]['details']}',
                                                  style: TextStyles.font14GreyW300,
                                                  maxLines: 4,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .only(
                                                                        bottom: 8),
                                                            child: Icon(
                                                              Icons.star,
                                                              color: ProjectColors
                                                                  .amberColor,
                                                              size: 25,
                                                            )),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Center(
                                                            child: Text(
                                                          '${snapshot.data!.docs[index]['start']}',
                                                          style: TextStyles
                                                              .font18GreyW400,
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                      ],
                                                    ),
                                                    Text(
                                                      "${snapshot.data!.docs[index]['price']} \$",
                                                      style: TextStyles
                                                          .font18mainColorBold,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 15,
                                  ),
                              itemCount: snapshot.data!.docs.length);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    });
              }),
        ));
  }
}

List<Widget>  imageAppInProject (int index){
  return
    [
      for (int i = 0; i < DependencyInjection.obGetApp.imageCount![index]; i++) ...[
        Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: ImageNetworkCache(url: DependencyInjection.obGetApp.listApp[index]['image'][i], fit: BoxFit.contain,)
          // child: Image.network(DependencyInjection.obGetApp.listApp[index]['image'][i] , fit: BoxFit.cover)
        )
      ],
    ];

}