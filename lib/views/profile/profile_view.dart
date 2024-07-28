import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muse/views/my_works/my_works_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  late DocumentSnapshot userDoc;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    user = FirebaseAuth.instance.currentUser!;
    userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('user_name'),
        title: Text(userDoc.exists ? userDoc['username'] : 'Loading...'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile_image.jpg'), // Profil resminin asset yolu
            ),
            SizedBox(height: 10),
            Text(
              'user_name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Artist',
              style: TextStyle(fontSize: 16, color: Colors.grey),
                MaterialPageRoute(
                    builder: (context) => MyWorksPage()),
              );

            },
          ),
        ],
      ),
      body: userDoc.exists
          ? SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(height: 10),
            Text(
              userDoc['username'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Lorem ipsum dolor sit amet',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            InkWell(
              child: Text(
                'www.website.com',
                style: TextStyle(fontSize: 14, color: Colors.blue),
              ),
              onTap: () => _launchURL('https://www.website.com'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileStat(title: 'works', count: 12),
                ProfileStat(title: 'sales', count: 8),
                ProfileStat(title: 'badges', count: 4),
              "Artist",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileStat(title: 'works', count: 10),
                ProfileStat(title: 'sales', count: 9),
                ProfileStat(title: 'badges', count: 8),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.filter_list),
                      SizedBox(width: 8),
                      Icon(Icons.sort),
                      SizedBox(width: 8),
                      Text('12 item'),
                      Text('20 items'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    
              itemCount: 6, // Örnek veri için, gerçek veriyi buradan alabilirsiniz
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Öğeye tıklama işlemleri
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Text(
                        'Lorem ipsum',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }

  void _launchURL(String url) async {
    // URL açma işlemleri burada yapılacak
  }
}

class ProfileStat extends StatelessWidget {
  final String title;
  final int count;

  ProfileStat({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            '$count',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
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
        currentIndex: 3, 
        selectedItemColor: Colors.red.shade900,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          
        },
      ),
    );
  }

  void _launchURL(String url) async {
  }
}

class ProfileStat extends StatelessWidget {
  final String title;
  final int count;

  ProfileStat({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            '$count',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          MenuTile(icon: Icons.person, title: 'Edit Profile'),
          MenuTile(icon: Icons.local_offer, title: 'My Sales'),
          MenuTile(icon: Icons.work, title: 'My Works'),
          MenuTile(icon: Icons.event, title: 'Saved Events'),
          MenuTile(icon: Icons.settings, title: 'Settings'),
          MenuTile(icon: Icons.help, title: 'Help'),
        ],
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
        currentIndex: 3, 
        selectedItemColor: Colors.red.shade900,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          
        },
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;

  MenuTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.red.shade900),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        
      },
    );
  }
}
