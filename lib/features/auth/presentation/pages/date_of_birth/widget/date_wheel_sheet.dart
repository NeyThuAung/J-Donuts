import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../l10n/l10n.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/extensions/extensions.dart';
import '../../../../../../shared/styles/styles.dart';
import '../cubit/date_of_birth_cubit.dart';
import 'month_name.dart';

// Years offered, counting back from this year.
const _yearsShown = 120;
const _monthsInYear = 12;
// Days are not limited by month, so 31 April can be picked and is then
// rejected by the validator with a message.
const _maxDaysInMonth = 31;
const _monthFlex = 2;

Future<void> showDateWheelSheet(BuildContext context) {
  final cubit = context.read<DateOfBirthCubit>()..startPicking();
  return showModalBottomSheet<void>(
    context: context,
    // Sized to its content; the default 9/16 cap is too short on small phones.
    isScrollControlled: true,
    backgroundColor: context.appColors.surface,
    showDragHandle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular($styles.corner.lg),
      ),
    ),
    builder: (_) =>
        BlocProvider.value(value: cubit, child: const DateWheelSheet()),
  );
}

// Month, day and year wheels; each change updates the fields right away.
class DateWheelSheet extends StatefulWidget {
  const DateWheelSheet({super.key});

  @override
  State<DateWheelSheet> createState() => _DateWheelSheetState();
}

class _DateWheelSheetState extends State<DateWheelSheet> {
  final _thisYear = DateTime.now().year;
  late final FixedExtentScrollController _month;
  late final FixedExtentScrollController _day;
  late final FixedExtentScrollController _year;

  @override
  void initState() {
    super.initState();
    final state = context.read<DateOfBirthCubit>().state;
    _month = FixedExtentScrollController(initialItem: (state.month ?? 1) - 1);
    _day = FixedExtentScrollController(initialItem: (state.day ?? 1) - 1);
    _year = FixedExtentScrollController(
      initialItem: _thisYear - (state.year ?? _thisYear),
    );
  }

  @override
  void dispose() {
    _month.dispose();
    _day.dispose();
    _year.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DateOfBirthCubit>();
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          $styles.insets.lg,
          0,
          $styles.insets.lg,
          $styles.insets.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: $styles.size.wheelPickerHeight,
              child: Row(
                children: [
                  Expanded(
                    flex: _monthFlex,
                    child: _Wheel(
                      controller: _month,
                      count: _monthsInYear,
                      label: (i) => monthName(context, i + 1),
                      onChanged: (i) => cubit.monthPicked(i + 1),
                    ),
                  ),
                  Expanded(
                    child: _Wheel(
                      controller: _day,
                      count: _maxDaysInMonth,
                      label: (i) => '${i + 1}',
                      onChanged: (i) => cubit.dayPicked(i + 1),
                    ),
                  ),
                  Expanded(
                    child: _Wheel(
                      controller: _year,
                      count: _yearsShown,
                      label: (i) => '${_thisYear - i}',
                      onChanged: (i) => cubit.yearPicked(_thisYear - i),
                    ),
                  ),
                ],
              ),
            ),
            $styles.insets.md.toHeightSizedBox,
            AppButton(
              label: context.l10n.commonDone,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Wheel extends StatelessWidget {
  const _Wheel({
    required this.controller,
    required this.count,
    required this.label,
    required this.onChanged,
  });

  final FixedExtentScrollController controller;
  final int count;
  final String Function(int index) label;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: controller,
      itemExtent: $styles.size.wheelItemExtent,
      onSelectedItemChanged: onChanged,
      children: [
        for (var i = 0; i < count; i++)
          Center(
            child: Text(
              label(i),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.titleMedium,
            ),
          ),
      ],
    );
  }
}
