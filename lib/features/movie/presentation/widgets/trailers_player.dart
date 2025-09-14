import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TrailersPlayer extends StatefulWidget {
  const TrailersPlayer({super.key, required this.trailerId});

  final String trailerId;

  @override
  State<TrailersPlayer> createState() => _TrailersPlayerState();
}

class _TrailersPlayerState extends State<TrailersPlayer> {
  late YoutubePlayerController _trailerController;

  @override
  void initState() {
    super.initState();
    _trailerController = YoutubePlayerController.fromVideoId(
      videoId: widget.trailerId,
      autoPlay: true,
      params: const YoutubePlayerParams(showControls: false, loop: true, enableCaption: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(children: <Widget>[AspectRatio(aspectRatio: 5 / 3, child: YoutubePlayer(controller: _trailerController))]),
    );
  }
}
