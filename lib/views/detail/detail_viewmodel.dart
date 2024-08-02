import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailViewModel extends ChangeNotifier {
  final String videoId; // Video ID'yi saklayacak

  DetailViewModelState state;

  DetailViewModel({required this.videoId})
      : state = DetailViewModelState(
    videoController: YoutubePlayerController(
      initialVideoId: videoId,  
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    ),
  );

  @override
  void dispose() {
    state.videoController.dispose();
    super.dispose();
  }
}

class DetailViewModelState {
  final YoutubePlayerController videoController;

  DetailViewModelState({required this.videoController});
}
