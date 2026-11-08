import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../shared/styles/styles.dart';
import 'otp_box.dart';

// One hidden field behind the boxes: typing fills the next box, backspace
// empties the last one, and a pasted or SMS-filled code fills them all.
class OtpCodeInput extends StatefulWidget {
  const OtpCodeInput({
    super.key,
    required this.controller,
    required this.length,
    required this.semanticsLabel,
    required this.onChanged,
    this.enabled = true,
    this.hasError = false,
    this.shakeCount = 0,
  });

  final TextEditingController controller;
  final int length;
  final String semanticsLabel;
  final ValueChanged<String> onChanged;
  final bool enabled;
  final bool hasError;

  /// The boxes shake each time this changes.
  final int shakeCount;

  @override
  State<OtpCodeInput> createState() => _OtpCodeInputState();
}

class _OtpCodeInputState extends State<OtpCodeInput>
    with SingleTickerProviderStateMixin {
  final _focusNode = FocusNode();
  late final _shake = AnimationController(
    vsync: this,
    duration: AppMotion.shake,
  );

  @override
  void didUpdateWidget(OtpCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shakeCount != oldWidget.shakeCount) _onWrongCode();
    if (widget.enabled && !oldWidget.enabled) _focusNode.requestFocus();
  }

  void _onWrongCode() {
    unawaited(HapticFeedback.mediumImpact());
    if (!context.reduceMotion) unawaited(_shake.forward(from: 0));
  }

  @override
  void dispose() {
    _shake.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shake,
      builder: (context, child) => Transform.translate(
        offset: Offset(shakeOffset(_shake.value), 0),
        child: child,
      ),
      child: SizedBox(
        height: $styles.size.otpBoxHeight,
        child: Stack(
          children: [
            Positioned.fill(child: _boxes()),
            Positioned.fill(child: _hiddenField(context)),
          ],
        ),
      ),
    );
  }

  Widget _boxes() => ListenableBuilder(
    listenable: Listenable.merge([widget.controller, _focusNode]),
    builder: (context, _) {
      final code = widget.controller.text;
      return Row(
        spacing: $styles.insets.xs,
        children: [
          for (var i = 0; i < widget.length; i++)
            Expanded(
              child: OtpBox(
                digit: i < code.length ? code[i] : null,
                isActive: _focusNode.hasFocus && i == code.length,
                hasError: widget.hasError,
              ),
            ),
        ],
      );
    },
  );

  // Transparent text and cursor; it only takes the input and the paste menu.
  Widget _hiddenField(BuildContext context) {
    const invisible = Colors.transparent;
    return Semantics(
      label: widget.semanticsLabel,
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        autofocus: true,
        keyboardType: TextInputType.number,
        autofillHints: const [AutofillHints.oneTimeCode],
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(widget.length),
        ],
        onChanged: widget.onChanged,
        showCursor: false,
        style: const TextStyle(color: invisible),
        cursorColor: invisible,
        decoration: const InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          filled: false,
          counterText: '',
        ),
      ),
    );
  }
}
