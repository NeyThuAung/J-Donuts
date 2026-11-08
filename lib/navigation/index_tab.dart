enum IndexTab {
  home,
  rewards,
  orders,
  wallet,
  settings;

  static const queryKey = 'tab';

  // Unknown or missing values (old links, typos) open Home.
  static IndexTab fromQuery(String? value) => values.asNameMap()[value] ?? home;
}
