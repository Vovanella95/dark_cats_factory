import 'package:blocks/blocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocaleCubit', () {
    test('starts following the system locale', () {
      final cubit = LocaleCubit();
      addTearDown(cubit.close);

      expect(cubit.state, isNull);
    });

    test('toggle cycles through English, Russian, Spanish, then system', () {
      final cubit = LocaleCubit();
      addTearDown(cubit.close);

      cubit.toggle();
      expect(cubit.state, const Locale('en'));

      cubit.toggle();
      expect(cubit.state, const Locale('ru'));

      cubit.toggle();
      expect(cubit.state, const Locale('es'));

      cubit.toggle();
      expect(cubit.state, isNull);
    });

    test('toggle keeps cycling over repeated rounds', () {
      final cubit = LocaleCubit();
      addTearDown(cubit.close);

      const expectedRound = [
        Locale('en'),
        Locale('ru'),
        Locale('es'),
        null, // back to the system locale
      ];
      final actual = <Locale?>[cubit.state];

      for (var i = 0; i < 2 * expectedRound.length; i++) {
        cubit.toggle();
        actual.add(cubit.state);
      }

      expect(actual, [null, ...expectedRound, ...expectedRound]);
    });
  });
}
