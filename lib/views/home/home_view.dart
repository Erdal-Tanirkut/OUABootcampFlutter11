import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../core/constants/bottom_navigation_bar.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16, //horizontal spacing
          mainAxisSpacing: 16, //vertical spacing
          childAspectRatio: 1,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Stack(alignment: Alignment.topRight, children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  //adding to favorites
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.favorite_border, color: Colors.black38),
            ),
          ]);
        },
      ),
    );
  }
}