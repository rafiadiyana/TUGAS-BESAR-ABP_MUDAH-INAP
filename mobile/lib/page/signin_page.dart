import 'package:course_hotel/config/app_route.dart';
import 'package:course_hotel/source/user_source.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';
import '../widget/button_custom.dart';
import 'package:course_hotel/page/signup_page.dart';

class SigninPage extends StatelessWidget {
  SigninPage({Key? key}) : super(key: key);
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      UserSource.signIn(controllerEmail.text, controllerPassword.text)
          .then((response) {
            print(response);
        if (response['success']) {
          DInfo.dialogSuccess(context,response['message']);
          DInfo.closeDialog(context,actionAfterClose: () {
            Navigator.pushReplacementNamed(context, AppRoute.home);
          });
        } else {
          DInfo.toastError(response['message']);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAsset.logo,
                        width: 250,
                        fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(height: 60),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign In\nTo Your Account',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: controllerEmail,
                        validator: (value) =>
                            value == '' ? "This field is required" : null,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          hintText: 'Email Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: AppColor.secondary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: controllerPassword,
                        obscureText: true,
                        validator: (value) =>
                            value == '' ? "This field is required" : null,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: AppColor.secondary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ButtonCustom(
                        label: 'Sign In',
                        isExpand: true,
                        onTap: () => login(context),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignupPage()),
                            );
                          },
                          child: const Text(
                          'Create New Account',
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
