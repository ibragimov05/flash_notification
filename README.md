# Flash Notification

A lightweight and customizable Flutter package for displaying temporary, toast-like notifications.

<p align="center">
  <img src="https://github.com/ibragimov05/flash_notification/blob/main/screenshots/screenshot_1.png" alt="Flash notification" width="30%" />
  <img src="https://github.com/ibragimov05/flash_notification/blob/main/screenshots/screenshot_2.png" alt="Flash notification" width="30%" />
</p>

## Features

- 🎯 **Dismissible**: Can be dismissed by tapping on it
- 🎨 **Customizable**: Change colors, text styles, border radius, and more
- 🔣 **Icon Support**: Include optional icons in your notifications
- 📱 **Flexible Positioning**: Show notifications at different screen positions
- 🖱️ **Interaction**: Add tap callbacks for notification interaction

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flash_notification: ^0.0.1  # Replace with actual version
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
// Using the static method
FlashNotification.show(
  context: context,
  message: 'Hello, world!',
);

// Or using the context extension
context.showFlashNotification(
  message: 'Hello, world!',
);
```

### With Custom Styling

```dart
FlashNotification.show(
  context: context,
  message: 'Operation completed successfully!',
  backgroundColor: Colors.green,
  textStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  radius: BorderRadius.circular(10),
);
```

### With an Icon

```dart
FlashNotification.show(
  context: context,
  message: 'New notification received',
  icon: Icon(Icons.notifications, color: Colors.white),
);
```

### Custom Position

```dart
FlashNotification.show(
  context: context,
  message: 'Positioned at the bottom',
  position: FlashNotificationPosition(
    bottom: 20,
    left: 20,
    right: 20,
  ),
);
```

### With Custom Duration

```dart
FlashNotification.show(
  context: context,
  message: 'I will stay longer',
  duration: Duration(seconds: 5),
);
```

### Manual Dismissal

```dart
// Manually hide a notification
FlashNotification.hideCurrentNotification();

// Or using the context extension
context.hideFlashNotification();
```

## Example Project

For a complete working example, check the [example](https://github.com/ibragimov05/flash_notification/blob/main/example/lib/main.dart) directory.

## Contributing

Contributions are welcome! If you find a bug or want a feature:

1. Check if an issue already exists
2. Create a new issue if needed
3. Fork the repo
4. Create your feature branch (`git checkout -b feature/amazing-feature`)
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Additional information

- **GitHub**: [https://github.com/ibragimov05/flash_notification](https://github.com/ibragimov05/flash_notification)
- **Issues**: [https://github.com/ibragimov05/flash_notification/issues](https://github.com/ibragimov05/flash_notification/issues)

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/ibragimov05/flash_notification/blob/main/LICENSE) file for details.
