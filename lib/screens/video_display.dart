import 'package:flutter/material.dart';
import 'package:lms_edutekzila/models/video.dart';
import 'package:video_player/video_player.dart';
import 'package:lms_edutekzila/widgets/video_player_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDisplay extends StatefulWidget {
  const VideoDisplay({Key? key, required this.video}) : super(key: key);
  final Video video;
  @override
  _VideoDisplayState createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    print(widget.video.url.toString());
    controller = VideoPlayerController.network(widget.video.url.toString())
      ..addListener(() {})
      ..setLooping(true)
      ..initialize().then((value) => controller!.play());
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? url = widget.video.url;
    final String? desc = widget.video.desc;
    final String? title = widget.video.title;
    String videoId;
    videoId = YoutubePlayer.convertUrlToId(url!)!;
    print(videoId);
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Module"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title!),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.red,
                  handleColor: Colors.green,
                ),
                onReady: () {
                  // _controller.addListener(listener);
                },
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                  // TotalDuration(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
