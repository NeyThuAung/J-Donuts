import 'dart:async';

/// Emits [combine] of the latest values once both streams have emitted,
/// then again whenever either emits. Errors pass through; it closes when
/// both streams are done or the listener cancels.
Stream<R> combineLatest2<A, B, R>(
  Stream<A> first,
  Stream<B> second,
  R Function(A a, B b) combine,
) {
  final controller = StreamController<R>();
  final subscriptions = <StreamSubscription<Object?>>[];
  (A,)? latestFirst;
  (B,)? latestSecond;
  var openSources = 2;

  void emitIfReady() {
    final a = latestFirst, b = latestSecond;
    if (a != null && b != null) controller.add(combine(a.$1, b.$1));
  }

  void sourceDone() {
    if (--openSources == 0) unawaited(controller.close());
  }

  void listen() => subscriptions.addAll([
    first.listen(
      (value) {
        latestFirst = (value,);
        emitIfReady();
      },
      onError: controller.addError,
      onDone: sourceDone,
    ),
    second.listen(
      (value) {
        latestSecond = (value,);
        emitIfReady();
      },
      onError: controller.addError,
      onDone: sourceDone,
    ),
  ]);

  Future<void> cancel() async {
    await Future.wait(subscriptions.map((sub) => sub.cancel()));
    await controller.close();
  }

  controller
    ..onListen = listen
    ..onCancel = cancel;
  return controller.stream;
}
