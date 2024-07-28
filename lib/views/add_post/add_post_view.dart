import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../explore/explore_view.dart';
import 'add_post_state.dart';
import 'add_post_viewmodel.dart';
import '../my_works/my_works_viewmodel.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({Key? key}) : super(key: key);

  @override
  _AddPostViewState createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  int _selectedIndex = 3; // profile icon

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddPostState(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFB71C1C)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Add Work'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add, color: Color(0xFFB71C1C)),
              onPressed: () async {
                final state = Provider.of<AddPostState>(context, listen: false);
                if (state.formKey.currentState!.validate()) {
                  final viewModel = AddPostViewModel(state: state);
                  await viewModel.submitPost();
                  Provider.of<MyWorksViewModel>(context, listen: false).fetchWorks(); //postları(works) güncellemek
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        body: Consumer<AddPostState>(
          builder: (context, state, child) {
            return Form(
              key: state.formKey,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      await state.pickImage(context);
                    },
                    child: Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: state.imageFile == null
                          ? const Icon(Icons.add_a_photo, size: 50)
                          : Image.file(File(state.imageFile!.path)),
                    ),
                  ),
                  _buildTextField(state.nameController, 'Name'),
                  _buildTextField(state.aboutWorkController, 'About work', maxLines: 3),
                  _buildTextField(state.artistController, 'Artist'),
                  _buildTextField(state.typeController, 'Type'),
                  _buildTextField(state.sizeController, 'Size'),
                  _buildTextField(state.locationController, 'Location'),
                  _buildTextField(state.priceController, 'Price'), //semboller eklenebileceği için keyboardType eklemedim
                  _buildTextField(state.linkController, 'Link'),
                  const SizedBox(height: 20),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(state.nameController, 'Name'),
                  const SizedBox(height: 16),
                  _buildTextField(state.aboutWorkController, 'About work', maxLines: 3),
                  const SizedBox(height: 16),
                  _buildTextField(state.typeController, 'Type'),
                  const SizedBox(height: 16),
                  _buildTextField(state.linkController, 'Link'),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (state.formKey.currentState!.validate()) {
                          final viewModel = AddPostViewModel(state: state);
                          await viewModel.submitPost();

                          Provider.of<MyWorksViewModel>(context, listen: false).fetchWorks(); //postları(works) güncellemek
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ExplorePage(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        backgroundColor: const Color(0xFFB71C1C), // Düğmenin arka plan rengi
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
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
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red[900],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
