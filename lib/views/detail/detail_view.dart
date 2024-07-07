import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'detail_viewmodel.dart';
import 'detail_widgets.dart';

class ArtworkDetailPage extends StatelessWidget {
  final String videoId; // Video ID'yi parametre olarak alıyoruz

  ArtworkDetailPage({required this.videoId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailViewModel(videoId: 'd66ACsHlWbc'), // Video ID'yi ViewModel'e geçiriyoruz
      child: Consumer<DetailViewModel>(
        builder: (context, viewModel, child) {
          return DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
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
                        label: "Lorem ipsum dolor sit amet consectetur. Dictum etiam duis nulla amet ultricies ultricies...",
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
              );
            },
          );
        },
      ),
    );
  }
}
