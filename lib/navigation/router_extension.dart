import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'index_page.dart';
import 'index_tab.dart';

extension RouterExtension on BuildContext {
  void selectIndexTab(IndexTab tab) => go(
    Uri(
      path: IndexPage.routePath,
      queryParameters: {IndexTab.queryKey: tab.name},
    ).toString(),
  );
}
