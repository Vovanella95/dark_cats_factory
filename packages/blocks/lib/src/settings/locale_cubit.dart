import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Locales the application supports, in [LocaleCubit.toggle] order.
const appSupportedLocales = <Locale>[Locale('en'), Locale('ru'), Locale('es')];

/// Holds the locale the application is displayed in.
///
/// The `null` state means "follow the system locale". [toggle] switches to
/// the next supported locale and wraps around to the system locale after
/// the last one.
final class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit() : super(null);

  /// Switches to the next locale of [appSupportedLocales].
  void toggle() {
    final current = state;
    if (current == null) {
      emit(appSupportedLocales.first);
      return;
    }
    final index = appSupportedLocales.indexOf(current);
    final isLast = index == appSupportedLocales.length - 1;
    emit(isLast ? null : appSupportedLocales[index + 1]);
  }
}
