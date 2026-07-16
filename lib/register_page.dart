import 'package:flutter/material.dart';
import 'package:project/custom_text_field.dart';
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

              color: Colors.black.withOpacity(0.6),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 250, top: 200),
                    child: Text(
                      'Register',
                      style: whiteTextStyle.copyWith(
                        fontSize: 50,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(right: 100),
                    child: Text(
                      'Welcome to the Smart Site System fo Oil Depots\nRegister as a member to experence',
                      style: whiteTextStyle.copyWith(fontWeight: medium),
                    ),
                  ),
                  SizedBox(height: 100),
                  TextFieldLogin(
                    hintName: 'Email',
                    textName: 'Email',
                    obsecureText: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldLogin(
                    hintName: 'Password',
                    textName: 'Password',
                    obsecureText: true,
                  ),
                  SizedBox(height: 30),
                  Container(
                    color: kBlueColor,
                    width: 500,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Sign up',
                        style: whiteTextStyle.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 250),
                ],
              ),
            ),
          ],
        ),
        // );,) Container(
        //   width: double.maxFinite,
        //   height: double.maxFinite,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(
        //         'assets/images/ChatGPT Image 16 Jul 2026, 10.08.17.png',
        //       ),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       Container(
        //         width: 700,
        //         height: 600,
        //         color: Colors.black.withOpacity(0.6),
        //         child: Column(
        //           children: [
        //             Container(
        //               child: Text(
        //                 'Hello world',
        //                 style: whiteTextStyle.copyWith(
        //                   fontSize: 20,
        //                   fontWeight: medium,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      ),
    );
  }
}
