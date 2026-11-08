import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/validators/validators.dart';

part 'name_cubit.freezed.dart';
part 'name_state.dart';

// No request here: the names travel on to Date of birth, which registers.
@injectable
class NameCubit extends Cubit<NameState> {
  NameCubit() : super(const NameState());

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  String get firstName => normalizeName(firstNameController.text);

  /// Null when left empty.
  String? get lastName {
    final name = normalizeName(lastNameController.text);
    return name.isEmpty ? null : name;
  }

  void firstNameChanged(String input) =>
      emit(state.copyWith(firstNameError: validateFirstName(input)));

  void lastNameChanged(String input) =>
      emit(state.copyWith(lastNameError: validateLastName(input)));

  void firstNameLeft() => emit(state.copyWith(showFirstNameError: true));

  void lastNameLeft() => emit(state.copyWith(showLastNameError: true));

  /// True when both names are valid; otherwise reveals their messages.
  bool submit() {
    if (state.canContinue) return true;
    emit(state.copyWith(showFirstNameError: true, showLastNameError: true));
    return false;
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    return super.close();
  }
}
