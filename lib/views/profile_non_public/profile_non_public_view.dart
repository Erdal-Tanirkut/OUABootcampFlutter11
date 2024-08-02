import 'package:flutter/material.dart';
import 'package:muse/views/profile/profile_view.dart';
import 'package:muse/views/profile_edit/profile_edit_view.dart';
import 'package:provider/provider.dart';
import '../../core/constants/bottom_navigation_bar.dart';
import '../profile/profile_viewmodel.dart';
import '../profile_edit/profile_edit_viewmodel.dart';
import '../sign_in/sign_in_view.dart';
import '../sign_in/sign_in_viewmodel.dart';
import 'profile_non_puclic_viewmodel.dart';
import '../../firebase_dao.dart';
import '../my_works/my_works_view.dart';

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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => ProfileViewModel(),
                  child: ProfilePage(),
                ),
              ));
            },
          ),
          title: const Text('Profile'),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Color(0xFFB71C1C)),
              onPressed: () {
                FirebaseDao().signOutUser();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => SignInViewModel(),
                      child: SignInView(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Consumer<ProfileNonPublicViewModel>(
          builder: (context, model, child) {
            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: 5,
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
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => ProfileEditViewModel(),
              child: ProfileEditPage(),
            ),
          ));
        },
      ),
      ListTile(
        leading: const Icon(Icons.sell),
        title: const Text('My Sales'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFB71C1C)),
        onTap: () {
          // Navigate to My Sales
        },
      ),
      ListTile(
        leading: const Icon(Icons.favorite),
        title: const Text('My Favourites'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFB71C1C)),
        onTap: () {
          // Navigate to My Favourites
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>  MyWorksPage(),
          ));
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Settings'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFB71C1C)),
        onTap: () {
          // Navigate to Settings
        },
      ),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('Log Out'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFB71C1C)),
        onTap: () {
          FirebaseDao().signOutUser();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => SignInViewModel(),
                child: SignInView(),
              ),
            ),
          );
        },
      ),
    ];

    return tiles[index];
  }
}
