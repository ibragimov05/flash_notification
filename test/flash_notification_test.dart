import 'package:flash_notification/flash_notification.dart';
import 'package:flash_notification/src/flash_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(FlashNotification.hideCurrentNotification);

  tearDown(FlashNotification.hideCurrentNotification);

  group('FlashNotification Tests', () {
    testWidgets('displays notification with default styling', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (context) => Center(
                    child: ElevatedButton(
                      onPressed: () => FlashNotification.show(context: context, message: 'Test notification', testMode: true),
                      child: const Text('Show Notification'),
                    ),
                  ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Notification'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Test notification'), findsOneWidget);

      final decoratedBox = tester.widget<DecoratedBox>(
        find.descendant(of: find.byType(FlashNotification), matching: find.byType(DecoratedBox)),
      );

      final decoration = decoratedBox.decoration as BoxDecoration;
      expect(decoration.color, const Color(0xFF17B26A));
    });

    testWidgets('displays notification with custom styling', (tester) async {
      const customColor = Colors.purple;
      const customStyle = TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (context) => Center(
                    child: ElevatedButton(
                      onPressed:
                          () => FlashNotification.show(
                            context: context,
                            message: 'Custom notification',
                            backgroundColor: customColor,
                            textStyle: customStyle,
                            testMode: true,
                          ),
                      child: const Text('Show Notification'),
                    ),
                  ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Notification'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Custom notification'), findsOneWidget);

      final decoratedBox = tester.widget<DecoratedBox>(
        find.descendant(of: find.byType(FlashNotification), matching: find.byType(DecoratedBox)),
      );

      final decoration = decoratedBox.decoration as BoxDecoration;
      expect(decoration.color, customColor);

      final textWidget = tester.widget<Text>(find.text('Custom notification'));
      expect(textWidget.style?.fontSize, customStyle.fontSize);
      expect(textWidget.style?.color, customStyle.color);
      expect(textWidget.style?.fontWeight, customStyle.fontWeight);
    });

    testWidgets('displays notification with icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (context) => Center(
                    child: ElevatedButton(
                      onPressed: () {
                        FlashNotification.show(
                          context: context,
                          message: 'Notification with icon',
                          icon: const Icon(Icons.info, color: Colors.white),
                          testMode: true,
                        );
                      },
                      child: const Text('Show Notification'),
                    ),
                  ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Notification'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Notification with icon'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('can be manually dismissed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (context) => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed:
                              () => context.showFlashNotification(message: 'Dismissible notification', testMode: true),
                          child: const Text('Show Notification'),
                        ),
                        ElevatedButton(
                          onPressed: () => context.hideFlashNotification(),
                          child: const Text('Hide Notification'),
                        ),
                      ],
                    ),
                  ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Notification'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Dismissible notification'), findsOneWidget);

      await tester.tap(find.text('Hide Notification'));
      await tester.pump();

      expect(find.text('Dismissible notification'), findsNothing);
    });

    testWidgets('uses custom position', (tester) async {
      const customBottom = 25.0;
      const customLeft = 30.0;
      const customRight = 30.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (context) => Center(
                    child: ElevatedButton(
                      onPressed:
                          () => FlashNotification.show(
                            context: context,
                            message: 'Custom position',
                            position: const FlashNotificationPosition(
                              bottom: customBottom,
                              left: customLeft,
                              right: customRight,
                            ),
                            testMode: true,
                          ),
                      child: const Text('Show Notification'),
                    ),
                  ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Notification'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Custom position'), findsOneWidget);

      final positionedWidget = tester.widget<Positioned>(
        find.ancestor(of: find.text('Custom position'), matching: find.byType(Positioned)),
      );

      expect(positionedWidget.bottom, customBottom);
      expect(positionedWidget.left, customLeft);
      expect(positionedWidget.right, customRight);
    });

    testWidgets('replaces previous notifications', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (context) => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () => context.showFlashNotification(message: 'First notification', testMode: true),
                          child: const Text('Show First'),
                        ),
                        ElevatedButton(
                          onPressed: () => context.showFlashNotification(message: 'Second notification', testMode: true),
                          child: const Text('Show Second'),
                        ),
                      ],
                    ),
                  ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show First'));
      await tester.pump();
      await tester.pump();

      expect(find.text('First notification'), findsOneWidget);

      await tester.tap(find.text('Show Second'));
      await tester.pump();
      await tester.pump();

      expect(find.text('First notification'), findsNothing);
      expect(find.text('Second notification'), findsOneWidget);
    });

    test('FlashNotificationPosition stores values correctly', () {
      const position = FlashNotificationPosition(top: 10, bottom: 20, left: 30, right: 40);

      expect(position.top, 10);
      expect(position.bottom, 20);
      expect(position.left, 30);
      expect(position.right, 40);
    });
  });
}
