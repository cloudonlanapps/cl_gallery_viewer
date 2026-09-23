import 'browser_detect_stub.dart'
    if (dart.library.js_interop) 'browser_detect_web.dart'
    as platform;

/// Whether this is a Blink-based browser (Chrome, Edge, Opera), where
/// media_kit video playback works.
///
/// Always true on native platforms (iOS, Android, desktop): media_kit works
/// correctly there.
///
/// On web:
/// - Blink (Chrome, Edge, Opera): true — video playback works
/// - WebKit (Safari, every iOS browser): false — video shows a black screen
/// - Gecko (Firefox): false — video has issues
bool get isBlinkBrowser => platform.isBlinkBrowser;
