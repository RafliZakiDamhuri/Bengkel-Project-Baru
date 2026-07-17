import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Auth/service/auth_service.dart';
import 'package:project/routes/routes_name.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> login() async {
    try {
      final response = await authService.login(
        email: emailController.text,
        password: passwordController.text,
      );
      if (response.user != null) {
        Get.snackbar(
          "Login Berhasil",
          'Login Kamu Berhasil',
          backgroundColor: Colors.green,
        );
        Get.offAllNamed(AppRouteName.cms);
      }
      update();
    } on AuthException catch (e) {
      Get.snackbar("Login gagal", e.message, backgroundColor: Colors.red);
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> register() async {
    try {
      final response = await authService.register(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (response.user != null) {
        Get.snackbar(
          "Berhasil",
          "Akun berhasil dibuat",
          backgroundColor: Colors.green,
        );
      }
      Get.offAllNamed(AppRouteName.cms);
    } on AuthException catch (e) {
      Get.snackbar("Register gagal", e.message, backgroundColor: Colors.red);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final user = Supabase.instance.client.auth.currentUser;
    print('Ini adlaah user :: $user');
    if (user == null) {
      return const RouteSettings(name: '/login');
    }

    return null;
  }
}
