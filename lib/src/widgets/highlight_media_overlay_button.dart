import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/media_control.dart';
import '../utils/browser_detect.dart';
import '../video_player_interface.dart';
import '../video_player_overlay_stub.dart'
    if (dart.library.js_interop) '../video_player_overlay.dart';
import 'audio_controller_audio_mute.dart';
import 'pop_over_video_player.dart';

VideoPlayerInterface _createOverlayPlayer() => OverlayVideoPlayer();

/// Platform-aware overlay control for highlight media.
///
/// When playing:
/// - On Native and Web/Blink: shows [AudioControllerAudioMute] (mute toggle)
/// - On Web/non-Blink: shows [PopOverVideoPlayer] (popup video button)
///
/// When paused: replaces the normal button with a blinking play indicator.
/// Tapping the blinking button resumes playback.
class HighlightMediaOverlayButton extends ConsumerWidget {
  const HighlightMediaOverlayButton({required this.videoUrl, super.key});

  /// The video URL for the popup player (used on non-Blink browsers).
  final String videoUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPaused = ref.watch(mediaControlProvider.select((s) => s.isPaused));

    if (isPaused) {
      return BlinkingPauseButton(
        onPressed: () => ref.read(mediaControlProvider.notifier).togglePause(),
      );
    }

    if (isBlinkBrowser) {
      return const AudioControllerAudioMute();
    }

    return PopOverVideoPlayer(
      videoUrl: videoUrl,
      playerFactory: _createOverlayPlayer,
    );
  }
}

/// A blinking play button indicating the media is paused.
///
/// Pulses opacity to draw attention. Tapping resumes playback.
class BlinkingPauseButton extends StatefulWidget {
  const BlinkingPauseButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  State<BlinkingPauseButton> createState() => BlinkingPauseButtonState();
}

class BlinkingPauseButtonState extends State<BlinkingPauseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController blinkController;

  @override
  void initState() {
    super.initState();
    blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.4, end: 1).animate(
        CurvedAnimation(parent: blinkController, curve: Curves.easeInOut),
      ),
      child: OverlayIconButton(
        icon: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
        onPressed: widget.onPressed,
      ),
    );
  }
}
