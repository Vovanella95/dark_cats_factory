import 'package:blocks/blocks.dart';
import 'package:dark_cats_factory/l10n/app_localizations.dart';
import 'package:dark_cats_factory/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpSettings(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => LocaleCubit(),
        child: BlocBuilder<LocaleCubit, Locale?>(
          builder: (context, locale) => MaterialApp(
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: appSupportedLocales,
            home: const SettingsPage(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows the language setting following the system locale', (
    tester,
  ) async {
    await pumpSettings(tester);

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('System default'), findsOneWidget);
    expect(find.text('Switch language'), findsOneWidget);
  });

  testWidgets('switching the language cycles through all localizations', (
    tester,
  ) async {
    await pumpSettings(tester);

    // The test device resolves to English, so the null (system) state
    // renders in English as well.
    await tester.tap(find.text('Switch language'));
    await tester.pumpAndSettle();
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Настройки'), findsNothing);

    await tester.tap(find.text('Switch language'));
    await tester.pumpAndSettle();
    expect(find.text('Руский'), findsOneWidget);
    expect(find.text('Настройки'), findsOneWidget);

    await tester.tap(find.text('Сменить язык'));
    await tester.pumpAndSettle();
    expect(find.text('Español'), findsOneWidget);
    expect(find.text('Ajustes'), findsOneWidget);
    expect(find.text('Cambiar idioma'), findsOneWidget);

    // The fourth tap wraps around to the system locale.
    await tester.tap(find.text('Cambiar idioma'));
    await tester.pumpAndSettle();
    expect(find.text('System default'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Español'), findsNothing);
  });
}
