import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../add_post/add_post_view.dart';
import 'my_works_viewmodel.dart';

class MyWorksPage extends StatefulWidget {
  @override
  _MyWorksPageState createState() => _MyWorksPageState();
}

class _MyWorksPageState extends State<MyWorksPage> {
  int _selectedIndex = 3; // profile icon

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyWorksViewModel>(
      create: (_) => MyWorksViewModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFB71C1C)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('My Works'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add, color: Color(0xFFB71C1C)),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPostView()),
                );
                if (result == true) {
                  Provider.of<MyWorksViewModel>(context, listen: false).fetchWorks();
                }
              },
            ),
          ],
        ),
        body: Consumer<MyWorksViewModel>(
          builder: (context, model, child) {
            if (model.works.isEmpty) {
              return const Center(child: Text('No works available.'));
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.filter_list, color: Colors.black),
                        onPressed: () {
                          //filtering logic
                        },
                      ),
                      Text('${model.works.length} items', style: const TextStyle(fontSize: 12, color: Colors.black)),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 60), //bottom navigation bar için padding
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: model.works.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Center(
                          child: Text(model.works[index]['name'] ?? 'No Name'),
                        ),
                      );
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red.shade900,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
}