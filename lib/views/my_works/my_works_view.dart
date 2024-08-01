// my_works_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../detail/detail_view.dart';
import 'my_works_viewmodel.dart';

class MyWorksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyWorksViewModel()..loadUserData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: Consumer<MyWorksViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (viewModel.works.isEmpty) {
              return Center(child: Text('No works available.'));
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: viewModel.works.length,
                itemBuilder: (context, index) {
                  final post = viewModel.works[index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          print(post.tagId);
                          return ArtworkDetailPage(post: post);
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            post.image.url,
                            fit: BoxFit.cover,
                            height: 192,
                            width: 192,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
