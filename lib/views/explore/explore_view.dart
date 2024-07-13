import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../firebase_dao.dart';
import '../../models/post.dart';
import '../detail/detail_view.dart';
import 'explore_viewmodel.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExploreViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Explore'),
          centerTitle: true,
        ),
        body: Consumer<ExploreViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: viewModel.state.searchController,
                    onChanged: (value) {
                      viewModel.updateSearchQuery(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search, color: Colors.red.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.red.shade900,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.red.shade900,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.red.shade900,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.filter_list),
                          SizedBox(width: 8),
                          Icon(Icons.sort),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Post>>(
                    stream: FirebaseDao().readAllPosts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final posts = snapshot.data!;
                        return GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return ArtworkDetailPage(post: post);
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      post.image.imageUrl,
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      post.title,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          currentIndex: 1,
          selectedItemColor: Colors.red.shade900,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            // Implement navigation or other actions here
          },
        ),
      ),
    );
  }
}
