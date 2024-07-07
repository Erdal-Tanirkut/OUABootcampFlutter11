// detail_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'detail_state.dart';

class DetailViewModel extends ChangeNotifier {
  late DetailState _state;

  DetailViewModel() {
    _initialize();
  }

  DetailState get state => _state;

  void _initialize() {
    YoutubePlayerController videoController = YoutubePlayerController(
      initialVideoId: 'd66ACsHlWbc',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    videoController.addListener(_videoListener);
    _state = DetailState(videoController);
  }

  void _videoListener() {
    if (_state.videoController.value.playerState == PlayerState.ended) {
      _state.videoController.seekTo(Duration.zero);
      _state.videoController.play();
    }
  }

  @override
  void dispose() {
    _state.videoController.removeListener(_videoListener);
    _state.videoController.dispose();
    super.dispose();
  }
}
