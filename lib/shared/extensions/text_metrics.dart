import 'package:flutter/widgets.dart';

extension TextMetricsX on BuildContext {
  // Tall Latin and stacked Myanmar glyphs, so either script fits.
  static const _sampleLine = 'ÁgကျွိုA';

  /// Height [lines] lines of [style] take at the current text scale, laid out
  /// for real; for fixed-height horizontal lists that must not clip.
  double textLinesHeight(TextStyle? style, int lines) {
    final painter = TextPainter(
      text: TextSpan(
        text: List.filled(lines, _sampleLine).join('\n'),
        style: style,
      ),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(this),
      maxLines: lines,
    )..layout();
    final height = painter.height;
    painter.dispose();
    return height;
  }
}
