import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('probe: rootBundle + codec decode', (tester) async {
    await tester.runAsync(() async {
      try {
        final data = await rootBundle.load('assets/cats/onyx.png');
        // ignore: avoid_print
        print('PROBE asset bytes=${data.lengthInBytes}');

        final codec = await ui.instantiateImageCodec(
          data.buffer.asUint8List(),
        );
        final frame = await codec.getNextFrame();
        // ignore: avoid_print
        print('PROBE decoded ${frame.image.width}x${frame.image.height}');

        const provider = AssetImage('assets/cats/onyx.png');
        final stream = provider.resolve(ImageConfiguration.empty);
        final completer = Completer<ui.Image>();
        stream.addListener(
          ImageStreamListener(
            (image, _) => completer.complete(image.image),
            onError: (Object error, StackTrace? _) => completer.completeError(error),
          ),
        );
        final image = await completer.future.timeout(
          const Duration(seconds: 5),
        );
        // ignore: avoid_print
        print('PROBE provider image ${image.width}x${image.height}');
      } catch (error) {
        // ignore: avoid_print
        print('PROBE ERROR $error');
      }
    });
  });
}
