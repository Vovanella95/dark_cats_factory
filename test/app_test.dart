import 'package:flutter_test/flutter_test.dart';

import 'package:dark_cats_factory/app.dart';
import 'package:dark_cats_factory/pages/shell_page.dart';
import 'package:dark_cats_factory/pages/start_page.dart';
import 'package:dark_cats_factory/routing/app_routes.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(const DarkCatsFactoryApp());
    await tester.pumpAndSettle();
  }

  testWidgets('app starts on the start page', (tester) async {
    await pumpApp(tester);

    expect(find.byType(StartPage), findsOneWidget);
    expect(find.byType(ShellPage), findsNothing);
  });

  testWidgets('start page exposes the start action', (tester) async {
    await pumpApp(tester);

    expect(find.text('Start'), findsOneWidget);
  });

  testWidgets('tapping start navigates to the shell page', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();

    expect(find.byType(ShellPage), findsOneWidget);
    expect(find.byType(StartPage), findsNothing);
  });

  testWidgets('shell is reachable through its named route', (tester) async {
    await tester.pumpWidget(
      const DarkCatsFactoryApp(initialRoute: AppRoutes.shell),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ShellPage), findsOneWidget);
  });
}
