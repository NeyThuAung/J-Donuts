import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../l10n/l10n.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/extensions/extensions.dart';
import '../../../../../../shared/styles/styles.dart';
import '../../../widget/validation_messages.dart';
import '../cubit/date_of_birth_cubit.dart';
import 'date_wheel_sheet.dart';
import 'month_name.dart';

// Month, Day and Year as three read-only fields; any of them opens the wheels.
class DateFields extends StatelessWidget {
  const DateFields({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<DateOfBirthCubit, DateOfBirthState>(
      buildWhen: (previous, current) =>
          previous.year != current.year ||
          previous.month != current.month ||
          previous.day != current.day ||
          previous.validationError != current.validationError,
      builder: (context, state) {
        final hasError = state.validationError != null;
        final month = state.month;
        void open() => showDateWheelSheet(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DateField(
              hint: l10n.authDobMonth,
              value: month == null ? null : monthName(context, month),
              hasError: hasError,
              onTap: open,
            ),
            $styles.insets.md.toHeightSizedBox,
            _DateField(
              hint: l10n.authDobDay,
              value: state.day?.toString(),
              hasError: hasError,
              onTap: open,
            ),
            $styles.insets.md.toHeightSizedBox,
            _DateField(
              hint: l10n.authDobYear,
              value: state.year?.toString(),
              hasError: hasError,
              onTap: open,
            ),
            AppAnimatedSize(
              duration: AppMotion.fieldState,
              child: _Error(text: state.validationError?.message(l10n)),
            ),
          ],
        );
      },
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.hint,
    required this.value,
    required this.hasError,
    required this.onTap,
  });

  final String hint;
  final String? value;
  final bool hasError;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final value = this.value;
    final radius = BorderRadius.circular($styles.corner.xs);
    return Semantics(
      button: true,
      label: hint,
      value: value,
      excludeSemantics: true,
      child: Material(
        color: colors.surface,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: AnimatedContainer(
            duration: context.motion(AppMotion.fieldState),
            curve: AppMotion.standard,
            padding: EdgeInsets.all($styles.insets.md),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: hasError ? colors.accent : colors.surface,
                width: $styles.size.focusBorder,
              ),
            ),
            child: Text(
              value ?? hint,
              style: context.textTheme.bodyLarge?.copyWith(
                color: value == null ? colors.textSecondary : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({required this.text});

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
