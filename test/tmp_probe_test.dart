import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('probe: does AssetImage resolve inside fake async?', (tester) async {
    const provider = AssetImage('assets/cats/onyx.png');
    final stream = provider.resolve(ImageConfiguration.empty);
    var got = false;
    var size = Size.zero;
    stream.addListener(
      ImageStreamListener((image, _) {
        got = true;
        size = Size(
          image.image.width.toDouble(),
          image.image.height.toDouble(),
        );
      }),
    );
    await tester.pumpAndSettle();
    // ignore: avoid_print
    print('fake-async got=$got size=$size');
  });
}
