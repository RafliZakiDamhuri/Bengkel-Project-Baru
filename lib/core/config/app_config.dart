/// Konfigurasi global aplikasi.
///
/// Endpoint & credential yang sebelumnya di-hardcode tersebar di beberapa
/// file (main.dart, controller, service) dipusatkan di sini agar mudah
/// dikelola dan konsisten.
class AppConfig {
  AppConfig._();

  /// URL basis Supabase.
  static const String supabaseUrl = 'https://hkuubnsamodgtlsgyhrv.supabase.co';

  /// Anon (publishable) key Supabase.
  static const String supabaseAnonKey =
      'sb_publishable_ucLnPqx9eVJ3RILC2HwE1w_CjsGgvvF';

  /// URL basis REST API (untuk upload file).
  static const String apiBaseUrl = 'https://api.indocool.co.id';
}
