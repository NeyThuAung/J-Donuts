import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/core.dart';

part 'section_data.freezed.dart';

/// One Home section's own loading / ready / failed state, so a failing
/// section never hides the others.
@freezed
sealed class SectionData<T> with _$SectionData<T> {
  const factory SectionData.loading() = SectionLoading<T>;
  const factory SectionData.ready(T data) = SectionReady<T>;
  const factory SectionData.failed(Failure failure) = SectionFailed<T>;
}

extension DataStateToSection<T> on DataState<T> {
  SectionData<T> toSection() => switch (this) {
    Success<T>(:final data) => SectionData.ready(data),
    Failed<T>(:final failure) => SectionData.failed(failure),
  };
}
