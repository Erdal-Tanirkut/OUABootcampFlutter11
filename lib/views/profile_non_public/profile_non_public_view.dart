import 'package:flutter/material.dart';
import 'package:muse/views/my_works/my_works_view.dart';
import 'package:muse/views/sign_in/sign_in_view.dart';
import 'package:provider/provider.dart';
import '../../core/constants/bottom_navigation_bar.dart';
import 'profile_non_public_viewmodel.dart';

class ProfileNonPublicPage extends StatefulWidget {
  const ProfileNonPublicPage({super.key});

  @override
  _ProfileNonPublicPageState createState() => _ProfileNonPublicPageState();
}

class _ProfileNonPublicPageState extends State<ProfileNonPublicPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileNonPublicViewModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFB71C1C)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Profile'),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Color(0xFFB71C1C)),
              onPressed: () {
                //FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: Consumer<ProfileNonPublicViewModel>(
          builder: (context, model, child) {
            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildListTile(index);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            );
          },
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 2),
      ),
    );
  }

  Widget _buildListTile(int index) {
    List<Widget> tiles = [
      ListTile(
        leading: const Icon(Icons.edit),
        title: const Text('Edit Profile'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFB71C1C)),
        onTap: () {
          // Navigate to Edit Profile page
        },
      ),
      ListTile(
        leading: const Icon(Icons.sell),
        title: const Text('My Sales'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFB71C1C)),
        onTap: () {
          //Navigate to My Sales
        },
      ),
      ListTile(
        leading: const Icon(Icons.favorite),
        title: const Text('My Favourites'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFB71C1C)),
        onTap: () {
          // Navigate to My Favourites page
        },
      ),
      ListTile(
        leading: const Icon(Icons.event),
        title: const Text('Saved Events'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFB71C1C)),
        onTap: () {
          // Navigate to Saved Events page
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Settings'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFB71C1C)),
        onTap: () {
          // Navigate to Settings page
        },
      ),
      ListTile(
        leading: const Icon(Icons.help, color: Color(0xFFB71C1C)),
        title: const Text('Help'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFB71C1C)),
        onTap: () {
          // Navigate to Help page
        },
      ),
    ];

    return tiles[index];
  }
}
