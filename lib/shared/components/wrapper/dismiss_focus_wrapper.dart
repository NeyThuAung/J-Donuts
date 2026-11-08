import 'package:flutter/widgets.dart';

// Tapping anywhere outside a field removes its focus and closes the keyboard.
class DismissFocusWrapper extends StatelessWidget {
  const DismissFocusWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _dismissFocus(context),
      child: child,
    );
  }

  void _dismissFocus(BuildContext context) {
    final scope = FocusScope.of(context);
    if (!scope.hasPrimaryFocus) scope.unfocus();
  }
}
