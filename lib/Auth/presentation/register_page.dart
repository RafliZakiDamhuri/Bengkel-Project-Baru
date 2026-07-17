import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:project/Auth/controller/auth_controller.dart';
import 'package:project/custom_text_field.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/global%20widget/text_field_login.dart';
import 'package:project/theme/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                image: AssetImage('assets/images/ChatGPT Image 3.png'),
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
                              'Register',
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
                          await controllerContext.register();
                        },
                        width: 500,
                        title: 'Sign Up',
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
