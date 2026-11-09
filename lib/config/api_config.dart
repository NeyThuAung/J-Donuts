// Static mock API on GitHub Pages, published from assets/seed/v1.
abstract final class ApiConfig {
  static const baseUrl = 'https://neythuaung.github.io/J-Donuts/v1/';

  static const connectTimeout = Duration(seconds: 10);
  static const receiveTimeout = Duration(seconds: 15);

  static const retryDelays = [Duration(seconds: 1), Duration(seconds: 2)];
  static int get maxRetries => retryDelays.length;
}
