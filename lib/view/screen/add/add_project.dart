import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_learn_teacher/controller/add_project_controller.dart';
import 'package:easy_learn_teacher/core/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../controller/add_controller.dart';
import '../../../core/dependency_injection/dependency_injection.dart';
import '../../../core/shared/color.dart';
import '../../../core/shared/controller.dart';
import '../../../core/widget/app_text_form_filed.dart';

class AddProject extends StatelessWidget {
  final String teacherId;
  const AddProject({Key? key, required this.teacherId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أضف مشروع جديد'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FormAddDataProject(teacherId: teacherId)
          ],
        ),
      ),
    );
  }

  Container textFormFiledSelectOfListCategory() {
    return Container(
      child: GetBuilder<AddController>(builder: (controller) {
        return DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            fillColor: ProjectColors.mainColor.withOpacity(0.2),
            filled: true,
            prefixIcon: Icon(Icons.category),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            // Add more decoration..
          ),
          hint: const Text(
            'اختار تصنيف الكورس الخاص بك',
            style: TextStyle(fontSize: 14),
          ),
          items: controller.listCategoriesCourses
              .map((item) => DropdownMenuItem<String>(
            value: item.id,
            child: Text(
              item['name'],
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ))
              .toList(),
          validator: (value) {
            if (value == null) {
              return 'من فضلك قم ب اختيار التصنيف';
            }
            return null;
          },
          onChanged: (value) {
            controller.changSelectedValue( value.toString());
            //Do something when selected item is changed.
          },
          onSaved: (value) {


          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        );
      }),
    );
  }
}

class FormAddDataProject extends StatelessWidget {
  const FormAddDataProject({
    super.key,
    required this.teacherId,
  });

  final String teacherId;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: DependencyInjection.obGetAddProject.addProjectForm,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            AppTextFormFiled(
              noSpaceTextInputFormatter: false,
              controller: MyController.titleProject,
              validator: (value) {
                if (value == '') {
                  return 'يجب ان لا يكون العنوان فارغ';
                }
              },
              hintText: 'عنوان المشروع',
              prefixIcon: Icon(Icons.title_outlined),
            ),
            SizedBox(
              height: 20,
            ),
            AppTextFormFiled(
              noSpaceTextInputFormatter: false,
              controller: MyController.detailsProject,
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
              controller: MyController.priceProject,
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
              controller: MyController.discountProject,
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
            GetBuilder<ProjectController>(builder: (controller) {
              return controller.isLoading ?CircularProgressIndicator(): MainButton(
                name: 'رفع',

                onPressed: () async {
                  if (controller.addProjectForm.currentState!.validate()) {
                    controller.addDataProjectToFireBase(context,teacherId);

                  }
                },
              );
            }
            )
          ],
        ),
      ),
    );
  }
}
