import 'package:get/get.dart';
import '../../controller/add_controller.dart';
import '../../controller/add_project_controller.dart';
import '../../controller/app_controller.dart';
import '../../controller/login_controller.dart';
import '../../controller/profile_controller.dart';
import '../../controller/view_courses_controller.dart';




class DependencyInjection{
  static LoginController obGetLogin= Get.put(LoginController() , permanent: true);
  static AddController obGetAddCourses= Get.put(AddController() , permanent: true);
  static ViewCoursesController obGetEditCourses= Get.put(ViewCoursesController() , permanent: true);
  static ProjectController obGetAddProject= Get.put(ProjectController() , permanent: true);
  static AppController obGetApp= Get.put(AppController() , permanent: true);
  static ProfileController obGetProfile= Get.put(ProfileController() , permanent: true);
  // static DetailsCoursesController obGetCourses= Get.put(DetailsCoursesController() , permanent: true);
  // static TeacherController obGetTeacher= Get.put(TeacherController() , permanent: true);
  // static AppController obGetApp= Get.put(AppController() , permanent: true);
}
// SingUpController obGetSingUp = Get.put(SingUpController() , permanent: true);
// LoginController obGetLogin= Get.put(LoginController() , permanent: true);

// Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

//snapshot.data!.docs[index].id