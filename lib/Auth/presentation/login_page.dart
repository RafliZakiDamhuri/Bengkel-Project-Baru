import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Auth/controller/auth_controller.dart';
import 'package:project/global%20widget/customButton.dart';

import 'package:project/global%20widget/text_field_login.dart';
import 'package:project/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controllerContext) {
        return Scaffold(
          body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ChatGPT Image 1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 700,
                  height: MediaQuery.sizeOf(context).height,
                  color: Colors.black.withOpacity(0.6),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 200),
                            child: Text(
                              'Login',
                              style: whiteTextStyle.copyWith(
                                fontSize: 50,
                                fontWeight: medium,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Welcome to Indocool CMS',
                            style: whiteTextStyle.copyWith(fontWeight: medium),
                          ),
                        ],
                      ),
                      SizedBox(height: 100),
                      TextFieldLogin(
                        hintName: 'Email',
                        textName: 'Email',
                        obsecureText: false,
                        controller: controllerContext.emailController,
                      ),
                      SizedBox(height: 10),
                      TextFieldLogin(
                        hintName: 'Password',
                        textName: 'Password',
                        obsecureText: true,
                        controller: controllerContext.passwordController,
                      ),
                      SizedBox(height: 30),
                      customBlueAppBarButton(
                        onTap: () async {
                          await controllerContext.login();
                        },
                        width: 500,
                        title: 'Sign In',
                      ),

                      SizedBox(height: 250),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
