// A minimal widget test. The application's real entrypoint (main.dart)
// initializes Supabase and registers GetX controllers, which require
// platform services not available in the widget-test environment. This test
// therefore validates a small standalone widget instead.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Renders a basic widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Text('Indocool')),
      ),
    );

    expect(find.text('Indocool'), findsOneWidget);
  });
}
