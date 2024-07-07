// detail_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'detail_viewmodel.dart';
import 'detail_widgets.dart';

class ArtworkDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailViewModel(),
      child: Consumer<DetailViewModel>(
        builder: (context, viewModel, child) {
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
                        controller: viewModel.state.videoController,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
