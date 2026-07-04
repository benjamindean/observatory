import 'package:flutter/material.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubeVideo extends StatefulWidget {
  final String videoId;

  const YouTubeVideo({
    super.key,
    required this.videoId,
  });

  @override
  State<YouTubeVideo> createState() => _YouTubeVideoState();
}

class _YouTubeVideoState extends State<YouTubeVideo> {
  YoutubePlayerController? videoController;

  @override
  void initState() {
    videoController = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        mute: false,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return Center(
        child: const ObservatoryProgressIndicator(),
      );
    }

    return YoutubePlayer(
      controller: videoController!,
      aspectRatio: 16 / 9,
    );
  }

  @override
  void dispose() {
    videoController?.close();

    super.dispose();
  }
}
