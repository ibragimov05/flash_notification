import 'package:flutter/material.dart';

import '../flash_notification.dart';

/// Extension on [BuildContext] to show a flash notification.
extension FlashContextX on BuildContext {
  /// Show a flash notification.
  void showFlashNotification({
    required String message,
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
    Widget? icon,
    BorderRadius? radius,
    FlashNotificationPosition? position,
    Duration? duration,
    bool testMode = false,
  }) => FlashNotification.show(
    context: this,
    message: message,
    backgroundColor: backgroundColor,
    textStyle: textStyle,
    duration: duration,
    icon: icon,
    radius: radius,
    position: position,
    testMode: testMode,
  );

  /// Hide the current flash notification.
  void hideFlashNotification() => FlashNotification.hideCurrentNotification();
}
