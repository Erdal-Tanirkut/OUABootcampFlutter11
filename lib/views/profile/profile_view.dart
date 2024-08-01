import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/bottom_navigation_bar.dart';
import '../detail/detail_view.dart';
import '../profile_non_public/profile_non_public_view.dart';
import 'profile_viewmodel.dart';
import 'package:muse/views/add_post/add_post_view.dart';
import 'package:muse/models/post.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) => Text(
              viewModel.state.userName.isEmpty
                  ? 'Profile'
                  : viewModel.state.userName),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AddPostView()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileNonPublicPage()),
              );
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              //profile image
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade400,
                  backgroundImage: viewModel.state.photoUrl.isNotEmpty
                      ? NetworkImage(viewModel.state.photoUrl) as ImageProvider
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(viewModel.state.userName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Artist', style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(height: 5),
                    Text(viewModel.state.bio.isNotEmpty
                        ? viewModel.state.bio
                        : 'Write about yourself'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildStatColumn('works', viewModel.state.worksCount),
                    _buildStatColumn('sales', 8), //static data
                    _buildStatColumn('badges', 1), //static data
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _buildWorkSection(viewModel.state.userPosts),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),
    );
  }

  Widget _buildStatColumn(String label, int number) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(number.toString(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkSection(List<Post> posts) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16, //horizontal spacing
          mainAxisSpacing: 16, //vertical spacing
          childAspectRatio: 1,
        ),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          final post = posts[index];
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
                    height: 175,
                    width: 175,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
