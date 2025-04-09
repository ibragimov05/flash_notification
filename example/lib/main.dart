import 'package:flash_notification/flash_notification.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    home: const MyHomePage(title: 'Flash Notification Example'),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Shows a flash notification.
  void _showFlashNotification() =>
      FlashNotification.show(context: context, message: 'Hello, world!');

  /// Shows a flash notification with an icon.
  void _showFlashNotificationWithIcon() => FlashNotification.show(
    context: context,
    message: 'Hello, world!',
    icon: const Icon(Icons.notification_add, color: Colors.white),
  );

  /// Shows a flash notification with a long duration.
  void _showFlashNotificationWithLongDuration() => FlashNotification.show(
    context: context,
    message: 'Hello, world!',
    duration: const Duration(seconds: 10),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FilledButton(
            onPressed: _showFlashNotification,
            child: Text('Flash notification'),
          ),
          FilledButton(
            onPressed: _showFlashNotificationWithIcon,
            child: Text('Flash notification with icon'),
          ),
          FilledButton(
            onPressed: _showFlashNotificationWithLongDuration,
            child: Text('Flash notification with long duration'),
          ),
        ],
      ),
    ),
  );
}
