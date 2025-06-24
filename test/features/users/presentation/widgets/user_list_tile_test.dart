import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';
import 'package:clean_architecture_assignment/features/users/presentation/pages/user_details.dart';
import 'package:clean_architecture_assignment/features/users/presentation/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';
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
          home: Scaffold(body: UserListTileWidget(user: mockUser)),
          routes: {
            '/user-details': (context) => UserDetailsScreen(user: mockUser),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/user-details') {
              return MaterialPageRoute(
                builder: (context) => UserDetailsScreen(user: mockUser),
              );
            }
            return null;
          },
        );
      },
    );
  }

  group('UserListTileWidget', () {
    testWidgets('displays user information correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2));
    });

    testWidgets('navigates to UserDetailsScreen on tap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.byType(UserDetailsScreen), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) => widget is UserDetailsScreen && (widget).user == mockUser,
        ),
        findsOneWidget,
      );
    });
  });
}
