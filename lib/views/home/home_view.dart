import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/bottom_navigation_bar.dart';
import 'home_viewmodel.dart';
import 'home_state.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeState>(
      create: (_) => HomeViewModel().state,
      child: Scaffold(
        appBar: AppBar(
          title: Text('muse'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Add menu logic
              },
            ),
          ],
        ),
        body: Consumer<HomeState>(
          builder: (context, state, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ImageCarousel(),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'For You',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.filter_list, color: Colors.black),
                        SizedBox(width: 8),
                        Icon(Icons.sort, color: Colors.black),
                        SizedBox(width: 8),
                        Text('Items'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return const Card(
                          child: Center(
                            child:
                                Icon(Icons.image, size: 50, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _controller = PageController();
  final List<String> _images = [
    'https://gmk.org.tr/uploads/file/8647040459ae427e385b079123faaa44.jpg', //deneme için url verdim, sonrasında pubspec.yaml'a ekleme yapılacak 
    'https://gmk.org.tr/uploads/file/ad64e365ceef13785f278aa5a876ac98.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 200.0, //Height of the images
          width: double.infinity,
          child: PageView.builder(
            controller: _controller,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    _images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_images.length, (index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                num selected = _controller.hasClients
                    ? (_controller.page ?? _controller.initialPage)
                    : 0.0;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: selected == index ? 12.0 : 8.0,
                  height: selected == index ? 12.0 : 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        selected == index ? Colors.red.shade900 : Colors.grey,
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
