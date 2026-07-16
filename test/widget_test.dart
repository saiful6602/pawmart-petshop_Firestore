import 'package:flutter_test/flutter_test.dart';
import 'package:pet_shop_app/app.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const PetShopApp());
    expect(find.byType(PetShopApp), findsOneWidget);
  });
}