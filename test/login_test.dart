import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:login_app/data/models/login_model.dart";
import "package:login_app/view/screens/home_screen.dart";
import "package:login_app/view/screens/login_screen.dart";
import "package:login_app/view/widgets/input_login.dart";

void main() {

  testWidgets("find login button widget", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    final buttonFinder = find.widgetWithText(ElevatedButton, "Enviar");
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets("find input widget", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    final inputFinder = find.byType(InputLogin);
    expect(inputFinder, findsNWidgets(2));
  });

  group("LoginScreen - handleLogin", (){
    testWidgets("should display SnackBar on login failure", (tester) async {

      Future<bool> mockSendLogin(Login login) async {
        return false;
      }

      await tester.pumpWidget(MaterialApp(home: LoginScreen(sendLogin: mockSendLogin)));

      await tester.enterText(find.byType(InputLogin).first, "User");
      await tester.enterText(find.byType(InputLogin).last, "Password@12345");

      final buttonFinder = find.widgetWithText(ElevatedButton, "Enviar");
      await tester.tap(buttonFinder);

      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets("must navigate to HomeScreen on successful login", (tester) async {
      Future<bool> mockSendLogin(Login login) async {
        return true;
      }

      await tester.pumpWidget(MaterialApp(home: LoginScreen(sendLogin: mockSendLogin)));

      await tester.enterText(find.byType(InputLogin).first, "User");
      await tester.enterText(find.byType(InputLogin).last, "Password@12345");

      final buttonFinder = find.widgetWithText(ElevatedButton, "Enviar");
      await tester.tap(buttonFinder);

      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets("should displays CircularProgressIndicator while logging in", (tester) async {
      Future<bool> mockSendLogin(Login login) async {
        await Future.delayed(const Duration(seconds: 3));
        return true;
      }

      await tester.pumpWidget(MaterialApp(home: LoginScreen(sendLogin: mockSendLogin)));

      await tester.enterText(find.byType(InputLogin).first, "User");
      await tester.enterText(find.byType(InputLogin).last, "Password@12345");

      final buttonFinder = find.widgetWithText(ElevatedButton, "Enviar");
      await tester.tap(buttonFinder);

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

  });

}
