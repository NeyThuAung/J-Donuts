import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../extensions/extensions.dart';
import '../../styles/styles.dart';
import '../motion/app_animated_size.dart';

// White field from the auth designs. The border fades to cyan on focus and
// pink on error; the error message slides open underneath.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.errorText,
    this.prefixText,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.autofillHints,
    this.onChanged,
    this.onSubmitted,
    this.onFocusLost,
  });

  final TextEditingController controller;
  final String hintText;

  /// Shown under the field; null hides it.
  final String? errorText;
  final String? prefixText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// For rules that show their message only after the user leaves the field.
  final VoidCallback? onFocusLost;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _focusNode = FocusNode();
  var _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _hasFocus = _focusNode.hasFocus);
    if (!_hasFocus) widget.onFocusLost?.call();
  }

  @override
  Widget build(BuildContext context) {
    final duration = context.motion(AppMotion.fieldState);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedContainer(
          duration: duration,
          curve: AppMotion.standard,
          decoration: _decoration(context),
          child: _field(context),
        ),
        AppAnimatedSize(
          duration: AppMotion.fieldState,
          child: _FieldError(text: widget.errorText),
        ),
      ],
    );
  }

  BoxDecoration _decoration(BuildContext context) {
    final colors = context.appColors;
    final borderColor = widget.errorText != null
        ? colors.accent
        : _hasFocus
        ? colors.primary
        : colors.surface;
    return BoxDecoration(
      color: colors.surface,
      borderRadius: BorderRadius.circular($styles.corner.xs),
      border: Border.all(color: borderColor, width: $styles.size.focusBorder),
      boxShadow: _hasFocus ? $styles.shadow.soft : null,
    );
  }

  Widget _field(BuildContext context) {
    final textTheme = context.textTheme;
    final prefixText = widget.prefixText;
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      style: textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: widget.hintText,
        // prefixIcon, not prefixText: the design shows it while empty too.
        prefixIcon: prefixText == null
            ? null
            : Padding(
                padding: EdgeInsetsDirectional.only(
                  start: $styles.insets.md,
                  end: $styles.insets.sm,
                ),
                child: Text(
                  prefixText,
                  style: textTheme.bodyLarge?.copyWith(
                    color: context.appColors.textSecondary,
                  ),
                ),
              ),
        prefixIconConstraints: const BoxConstraints(),
        filled: false,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.all($styles.insets.md),
      ),
    );
  }
}

class _FieldError extends StatelessWidget {
  const _FieldError({required this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final text = this.text;
    if (text == null) return const SizedBox(width: double.infinity);
    return Padding(
      padding: EdgeInsets.only(top: $styles.insets.xs),
      child: Semantics(
        liveRegion: true,
        child: Text(
          text,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.appColors.accent,
          ),
        ),
      ),
    );
  }
}
