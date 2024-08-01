import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../core/constants/bottom_navigation_bar.dart';
import '../../firebase_dao.dart'; // Import FirebaseDao
import '../../models/post.dart'; // Import Post model
import '../detail/detail_view.dart'; // Import DetailPage
import 'home_viewmodel.dart';
import 'home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(HomeState()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'muse',
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 34,
            ),
          ),
          centerTitle: true,
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, model, child) => ListView(
            children: <Widget>[
              _buildImageCarousel(model),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'For you',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              _buildForYouSection(),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildImageCarousel(HomeViewModel viewModel) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: viewModel.carouselImages
          .map((item) => Center(
        child: Image.asset(item, fit: BoxFit.cover, width: 1000),
      ))
          .toList(),
    );
  }

  Widget _buildForYouSection() {
    return FutureBuilder<List<Post>>(
      future: FirebaseDao().getTwoPosts(), // Fetch two posts
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching posts'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No posts available'));
        }

        final posts = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              final post = posts[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return ArtworkDetailPage(post: post);
                      },
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        post.image.url,
                        height: 173,
                        width: 173,
                        fit: BoxFit.cover,
                      ),

                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
