import 'package:flutter/material.dart';

/// A widget that displays a notification with a given [message] and [backgroundColor].
///
/// The notification is displayed at the top of the screen with a fade-in animation.
/// After the given [duration], the notification is removed with a fade-out animation.
///
/// The notification is displayed with a [Material] widget and a [Container] widget.
/// The [Material] widget is used to provide a background color and a shadow.
/// The [Container] widget is used to provide padding and a border radius.
///
/// The notification is displayed with a [Text] widget.
/// The [Text] widget is used to display the given [message].
/// The [Text] widget is styled with the given [textStyle].
/// The [Text] widget is centered and has a maximum of 2 lines.
///
/// The notification is removed after the given [duration].
/// The notification is removed with a fade-out animation.
class CustomNotification extends StatefulWidget {
  const CustomNotification({
    required this.message,
    required this.textStyle,
    required this.radius,
    super.key,
    this.backgroundColor = Colors.black87,
    this.duration = const Duration(seconds: 3),
    this.icon,
  });

  final String message;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Duration duration;
  final BorderRadius radius;
  final Widget? icon;

  static OverlayEntry? _currentOverlay;

  static OverlayEntry? show({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    TextStyle? textStyle,
    Duration? duration,
    bool isSuccess = false,
    Widget? icon,
    BorderRadius radius = const BorderRadius.all(Radius.circular(64)),
  }) {
    _currentOverlay?.remove();
    _currentOverlay = null;

    final overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder:
          (context) => CustomNotification(
            message: message,
            backgroundColor: backgroundColor ?? (isSuccess ? Color(0xFF17B26A) : Color(0xFFF04438)),
            textStyle: textStyle ?? TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            duration: duration ?? const Duration(seconds: 3),
            icon: icon,
            radius: radius,
          ),
    );

    _currentOverlay = overlayEntry;
    overlayState.insert(overlayEntry);

    return overlayEntry;
  }

  static void hideCurrentNotification() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }

  @override
  State<CustomNotification> createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn, reverseCurve: Curves.easeOut));

    _animationController.forward();

    Future<void>.delayed(widget.duration - const Duration(milliseconds: 150), () {
      if (mounted) {
        _animationController.reverse().then((_) {
          CustomNotification._currentOverlay?.remove();
          CustomNotification._currentOverlay = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Positioned(
        top: MediaQuery.paddingOf(context).top + 5,
        left: 15,
        right: 15,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: widget.radius,
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
                ),
                child: switch (widget.icon == null) {
                  true => Text(
                    widget.message,
                    style: widget.textStyle,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  false => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.icon ?? const SizedBox(),
                      const SizedBox(width: 8),
                      Text(
                        widget.message,
                        style: widget.textStyle,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                },
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
