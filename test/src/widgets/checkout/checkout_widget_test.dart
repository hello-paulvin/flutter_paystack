import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_paystack/src/widgets/checkout/checkout_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/widget_builder.dart';

void main() {
  group("$CheckoutWidget", () {
    var charge = Charge()
      ..amount = 20000
      ..currency = "USD"
      ..email = 'customer@email.com';

    group("custom logo", () {
      testWidgets("is supplied", (tester) async {
        final checkoutWidget = buildTestWidget(
          CheckoutWidget(
            method: CheckoutMethod.card,
            charge: charge,
            fullscreen: false,
            logo: Container(),
          ),
        );

        await tester.pumpWidget(checkoutWidget);

        await tester.pumpAndSettle();

        expect(find.byKey(Key("Logo")), findsOneWidget);
        expect(find.byKey(Key("PaystackBottomIcon")), findsOneWidget);
        expect(find.byKey(Key("PaystackLogo")), findsOneWidget);
        expect(find.byKey(Key("PaystackIcon")), findsNothing);
        expect(find.byIcon(Icons.lock), findsOneWidget);
        expect(find.byKey(Key("SecuredBy")), findsOneWidget);
      });

      testWidgets("is not passed", (tester) async {
        final checkoutWidget = buildTestWidget(
          CheckoutWidget(
            method: CheckoutMethod.bank,
            charge: charge,
            fullscreen: false,
            logo: null,
          ),
        );

        await tester.pumpWidget(checkoutWidget);

        await tester.pumpAndSettle();

        expect(find.byKey(Key("Logo")), findsNothing);
        expect(find.byKey(Key("PaystackBottomIcon")), findsNothing);
        expect(find.byKey(Key("PaystackIcon")), findsOneWidget);
        expect(find.byKey(Key("PaystackLogo")), findsOneWidget);
        expect(find.byIcon(Icons.lock), findsOneWidget);
        expect(find.byKey(Key("SecuredBy")), findsOneWidget);
      });
    });

    group("card", () {
      testWidgets("card checkout is displayed for selectable method",
          (tester) async {
        final checkoutWidget = buildTestWidget(
          CheckoutWidget(
            method: CheckoutMethod.selectable,
            charge: charge,
            fullscreen: false,
            logo: Container(),
          ),
        );

        await tester.pumpWidget(checkoutWidget);
        await tester.pumpAndSettle();
        expect(find.byKey(Key("CardCheckout")), findsOneWidget);
      });

      testWidgets("card checkout is displayed for card method", (tester) async {
        final checkoutWidget = buildTestWidget(
          CheckoutWidget(
            method: CheckoutMethod.selectable,
            charge: charge,
            fullscreen: false,
            logo: Container(),
          ),
        );

        await tester.pumpWidget(checkoutWidget);
        await tester.pumpAndSettle();
        expect(find.byKey(Key("CardCheckout")), findsOneWidget);
      });

      testWidgets("card checkout is not displayed for bank method",
          (tester) async {
        final checkoutWidget = buildTestWidget(
          CheckoutWidget(
            method: CheckoutMethod.bank,
            charge: charge,
            fullscreen: false,
            logo: Container(),
          ),
        );

        await tester.pumpWidget(checkoutWidget);
        await tester.pumpAndSettle();
        expect(find.byKey(Key("CardCheckout")), findsNothing);
      });
    });

    group("email", () {
      testWidgets("is displayed when `hideEmail` is false", (tester) async {
        final checkoutWidget = buildTestWidget(
          CheckoutWidget(
            method: CheckoutMethod.selectable,
            charge: charge,
            fullscreen: false,
            hideEmail: false,
            logo: Container(),
          ),
        );

        await tester.pumpWidget(checkoutWidget);
        await tester.pumpAndSettle();
        expect(find.byKey(Key("ChargeEmail")), findsOneWidget);
      });

      testWidgets("is not displayed when `hideEmail` is true", (tester) async {
        final checkoutWidget = buildTestWidget(
          CheckoutWidget(
            method: CheckoutMethod.selectable,
            charge: charge,
            fullscreen: false,
            hideEmail: true,
            logo: Container(),
          ),
        );

        await tester.pumpWidget(checkoutWidget);
        await tester.pumpAndSettle();
        expect(find.byKey(Key("ChargeEmail")), findsNothing);
      });

      testWidgets("is not displayed when no email is passed", (tester) async {
        final checkoutWidget = buildTestWidget(
          CheckoutWidget(
            method: CheckoutMethod.selectable,
            charge: charge..email = null,
            fullscreen: false,
            hideEmail: true,
            logo: Container(),
          ),
        );

        await tester.pumpWidget(checkoutWidget);
        await tester.pumpAndSettle();
        expect(find.byKey(Key("ChargeEmail")), findsNothing);
      });
    });

    group("amount", () {
      testWidgets("is displayed when `hideAmount` is false", (tester) async {
        final checkoutWidget = buildTestWidget(
          CheckoutWidget(
            method: CheckoutMethod.selectable,
            charge: charge,
            fullscreen: false,
            hideAmount: false,
            logo: Container(),
          ),
        );

        await tester.pumpWidget(checkoutWidget);
        await tester.pumpAndSettle();
        expect(find.byKey(Key("DisplayAmount")), findsOneWidget);
      });

      testWidgets("is not displayed when `hideAmount` is true", (tester) async {
        final checkoutWidget = buildTestWidget(
          CheckoutWidget(
            method: CheckoutMethod.selectable,
            charge: charge,
            fullscreen: false,
            hideAmount: true,
            logo: Container(),
          ),
        );

        await tester.pumpWidget(checkoutWidget);
        await tester.pumpAndSettle();
        expect(find.byKey(Key("DisplayAmount")), findsNothing);
      });
    });
  });
}