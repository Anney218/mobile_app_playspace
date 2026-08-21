import 'package:flutter_test/flutter_test.dart';
import 'package:playspace/main.dart';

void main() {
  testWidgets('PlaySpace app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PlaySpaceApp());
    expect(find.byType(PlaySpaceApp), findsOneWidget);
  });
}
