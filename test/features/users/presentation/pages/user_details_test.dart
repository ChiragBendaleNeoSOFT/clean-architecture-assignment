import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';
import 'package:clean_architecture_assignment/features/users/presentation/screens/user_details.dart';
import 'package:clean_architecture_assignment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mockUser = UserEntity(
    id: 1,
    email: 'test@example.com',
    firstName: 'John',
    lastName: 'Doe',
    avatar: 'https://example.com/avatar.jpg',
  );

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // Add other supported locales if needed
          ],
          locale: const Locale('en'),
          home: Builder(
            builder: (context) {
              // Ensure localization is available to the screen
              return UserDetailsScreen(user: mockUser);
            },
          ),
        );
      },
    );
  }

  group('UserDetailsScreen', () {
    testWidgets('displays app bar with correct title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(UserDetailsScreen));
      final l10n = AppLocalizations.of(context)!;

      expect(find.text(l10n.userDetails), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
    });

    testWidgets('displays user information correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(UserDetailsScreen));
      final l10n = AppLocalizations.of(context)!;

      expect(find.text(l10n.userInformation), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(4)); // Including app bar title
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('navigates back when back button is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => UserDetailsScreen(user: mockUser),
                  );
                },
              ),
            );
          },
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(UserDetailsScreen), findsNothing);
    });

    testWidgets('avatar is displayed in circular shape', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final circleAvatar = tester.widget<CircleAvatar>(
        find.byType(CircleAvatar),
      );

      expect(circleAvatar.radius, equals(52.r));
      expect(find.byType(ClipOval), findsOneWidget);
    });
  });
}
