import 'dart:async';

import 'package:flutter/material.dart';

/// Waits until [provider] delivers a decoded image.
///
/// The image codec runs on the real event loop, which fake async cannot
/// drive, so this must be called inside [WidgetTester.runAsync]. Waiting
/// also warms the image cache, so later [Image]s paint without a race.
Future<void> waitForImage(ImageProvider provider) {
  final completer = Completer<void>();
  provider
      .resolve(const ImageConfiguration())
      .addListener(
        ImageStreamListener(
          (_, _) => completer.complete(),
          onError: (Object error, StackTrace? stackTrace) =>
              completer.completeError(error, stackTrace),
        ),
      );
  return completer.future;
}
