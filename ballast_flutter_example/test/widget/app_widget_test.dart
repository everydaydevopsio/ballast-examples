import 'package:flutter_test/flutter_test.dart';
import 'package:ballast_flutter_example/main.dart';

void main() {
  testWidgets('App loads without errors', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.byType(MyApp), findsOneWidget);
  });
}
