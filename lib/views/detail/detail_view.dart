import 'package:flutter/material.dart';
import 'package:muse/views/detail/detail_widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExploraPage(),
    );
  }
}

class ExploraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return DraggableScrollableSheet(
                  expand: false,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26.0),
                          topRight: Radius.circular(26.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: ArtworkDetailPage(),
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Text('Show Artwork Detail'),
        ),
      ),
    );
  }
}

class ArtworkDetailPage extends StatefulWidget {
  @override
  _ArtworkDetailPageState createState() => _ArtworkDetailPageState();
}

class _ArtworkDetailPageState extends State<ArtworkDetailPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'd66ACsHlWbc', // YouTube video ID'sini buraya ekleyin
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    _controller.addListener(_videoListener);
  }

  void _videoListener() {
    if (_controller.value.playerState == PlayerState.ended) {
      _controller.seekTo(Duration.zero);
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 10,
                child: Container(
                  width: 160,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Lorem Ipsum',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: CustomTextBox(label: "Digital Illustration", isTitle: false)),
              SizedBox(height: 8.0),
              Row(
                children: [
                  CustomTextBox(label: "Artist"),
                  Spacer(),
                  Text(
                    "90€",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
              CustomTextBox(label: "Lorem Ipsum"),
              CustomTextBox(label: "Size"),
              CustomTextBox(label: "Lorem Ipsum"),
              CustomTextBox(label: "Location"),
              CustomTextBox(label: "Lorem Ipsum, Istanbul, Turkiye"),
              SizedBox(height: 16.0),
              CustomTextBox(
                label:
                "Lorem ipsum dolor sit amet consectetur. Dictum etiam duis nulla amet ultricies ultricies...",
                isDescription: true,
              ),
              SizedBox(height: 45.0),
              Center(
                child: CustomButton(
                  text: "Contact to Buy",
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 16.0),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


