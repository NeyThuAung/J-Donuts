import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../../../shared/styles/styles.dart';
import '../../../../../domain/entity/banner_entity.dart';
import 'banner_card.dart';

// Banners that auto-play (brief); paused while the user drags, while the
// tab is hidden, and under Reduce Motion.
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key, required this.banners});

  // Each card takes this share of the width, so the next one peeks in.
  static const viewportFraction = 0.8;

  final List<BannerEntity> banners;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final _controller = PageController(
    viewportFraction: BannerCarousel.viewportFraction,
  );
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    if (context.reduceMotion || widget.banners.length < 2) return;
    _timer = Timer.periodic(AppMotion.carouselInterval, (_) => _showNext());
  }

  void _showNext() {
    if (!mounted || !_controller.hasClients) return;
    if (!TickerMode.valuesOf(context).enabled) return;
    final current = _controller.page?.round() ?? 0;
    unawaited(
      _controller.animateToPage(
        (current + 1) % widget.banners.length,
        duration: AppMotion.carouselSlide,
        curve: AppMotion.emphasized,
      ),
    );
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification is ScrollStartNotification &&
        notification.dragDetails != null) {
      _timer?.cancel();
    } else if (notification is ScrollEndNotification) {
      _startAutoPlay();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: PageView.builder(
        controller: _controller,
        padEnds: false,
        itemCount: widget.banners.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsetsDirectional.only(
            start: index == 0 ? $styles.grid.pageMargin : $styles.insets.xs,
            end: $styles.insets.xs,
          ),
          child: BannerCard(banner: widget.banners[index], index: index),
        ),
      ),
    );
  }
}
