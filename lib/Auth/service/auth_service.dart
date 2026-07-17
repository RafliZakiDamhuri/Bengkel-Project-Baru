import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> register({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signUp(email: email, password: password);
  }

  Future<void> createProfile({
    required String id,
    required String email,
  }) async {
    await supabase.from('profiles').insert({
      'id': id,
      'email': email,
      'role': 'admin',
      'is_active': true,
    });
  }
}
