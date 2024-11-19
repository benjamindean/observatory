import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

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
    videoController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        forceHD: true,
        useHybridComposition: !kDebugMode,
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

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: videoController!,
        showVideoProgressIndicator: false,
        progressIndicatorColor: context.colors.scheme.primary,
        liveUIColor: context.colors.scheme.primary,
        progressColors: ProgressBarColors(
          playedColor: context.colors.scheme.primary,
          handleColor: context.colors.scheme.secondary,
        ),
      ),
      builder: (BuildContext context, Widget player) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            player,
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    videoController?.dispose();

    super.dispose();
  }
}
