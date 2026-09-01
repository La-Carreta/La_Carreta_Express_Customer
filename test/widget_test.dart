import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:la_carreta_express_cs/main.dart';
import 'package:la_carreta_express_cs/infraestructure/http/authenticated_api_client.dart';
import 'package:la_carreta_express_cs/infraestructure/http/session_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows login when there is no NestJS session', (tester) async {
    SharedPreferences.setMockInitialValues({});
    ApiClient.useInstanceForTesting(
      ApiClient(sessionStorage: MemorySessionStorage()),
    );
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(600, 1400);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Correo'), findsOneWidget);
  });
}
