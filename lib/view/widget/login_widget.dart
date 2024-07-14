import 'package:easy_learn_teacher/view/screen/auth/Signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../controller/sign_up_controller.dart';
import '../../core/dependency_injection/dependency_injection.dart';
import '../../core/shared/controller.dart';
import '../../core/widget/app_text_form_filed.dart';
import '../../core/widget/button.dart';
import '../../core/widget/snabar.dart';
import '../../core/widget/valid.dart';


class ButtonCreateAccountInLoginScreen extends StatelessWidget {
   ButtonCreateAccountInLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'لا امتلك حساب ',
          style: TextStyle(color: Colors.grey),
        ),
        TextButton(
            onPressed: () {
              Get.toNamed('/signup');
            },
            child: Text('أنشاء حساب'))
      ],
    );
  }
}

class ListLoginInAntherAccount extends StatelessWidget {
  const ListLoginInAntherAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.facebook,
                size: 30,
              )),
          CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.email,
                size: 30,
              )),
          CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.apple,
                size: 30,
              ))
        ],
      ),
    );
  }
}

class NameOfAntherLogin extends StatelessWidget {
  const NameOfAntherLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          alignment: Alignment.topLeft,
          width: 94,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
          ),
        ),
        Text(
          'or continue with',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Arial Rounded MT Bold',
            fontWeight: FontWeight.w400,
            // height: 0,
            letterSpacing: 1.28,
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          width: 94,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: TextButton(
            onPressed: () {},
            child: Text(
              'نسيت كلمة المرور ؟',
              style: TextStyle(color: Colors.grey),
            )));
  }
}

class FormEmailAndPasswordInLoginScreen extends StatelessWidget {
  const FormEmailAndPasswordInLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: DependencyInjection.obGetLogin.loginForm,
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            AppTextFormFiled(
              controller: MyController.emailLogin,
              keyboardType: TextInputType.emailAddress,
              validator: (value){
                if(isEmail(value!) ==false){
                  return 'هذا الايميل غير صحيح';
                }
              },
              hintText: 'البريد الالكتروني',
              prefixIcon: Icon(Icons.email),

            ),
            SizedBox(
              height: 30,
            ),
            GetBuilder<SingUpController>(
                init: SingUpController(),
                builder: (obGet) {
                  return AppTextFormFiled(
                    controller: MyController.passwordLogin,
                    validator: (value){
                      if(isPassword(value!) ==false){
                        return 'كلمة المرور ضعية';
                      }
                    },

                    hintText: 'كلمة المرور',
                    prefixIcon: Icon(Icons.lock),
                    obscureText: obGet.isPassword,
                    suffixIcon: InkWell(
                        onTap: () {
                          obGet.changeIsPassword();

                        },
                        child: obGet.isPassword
                            ? Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Colors.black,
                              )),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class ButtonInLoginScreen extends StatelessWidget {
  final LoginController controller;
  final BuildContext buildContext;
  const ButtonInLoginScreen({
    super.key,required this.controller, required this.buildContext,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.dataLoginTeacher.where('email',isEqualTo: MyController.emailLogin.text).get(),
      builder: (context , snapshot) {
        return MainButton(name: 'LOGIN',onPressed: ()async {
           if(controller.loginForm.currentState!.validate()){
             await controller.login(buildContext ,snapshot);
           }
          // mm( 'alii' ,'aa@gmail.com' , '1234567' ,'59433224'  );

        },
          margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
        );
      }
    );
  }
}
