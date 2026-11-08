extension DurationFormatX on Duration {
  /// Countdown text: 4:58, 0:05.
  String get minutesSeconds {
    final seconds = inSeconds.remainder(Duration.secondsPerMinute);
    return '$inMinutes:${seconds.toString().padLeft(2, '0')}';
  }
}
