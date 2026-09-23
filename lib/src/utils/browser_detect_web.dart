import 'package:web/web.dart' as web;

/// Detects a Blink-based browser from the user agent.
///
/// - Chrome: contains "Chrome" (Safari also contains "Safari")
/// - Edge: contains "Edg" (no trailing 'e')
/// - Safari: contains "Safari" but not "Chrome"
/// - Firefox: contains "Firefox", no "Chrome"
/// - iOS browsers: all WebKit, contain "Safari"
bool get isBlinkBrowser {
  final userAgent = web.window.navigator.userAgent;
  return userAgent.contains('Chrome') || userAgent.contains('Edg');
}
