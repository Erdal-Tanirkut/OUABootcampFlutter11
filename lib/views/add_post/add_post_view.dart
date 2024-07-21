import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
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
                  const SizedBox(height: 16),
                  _buildTextField(state.nameController, 'Name'),
                  const SizedBox(height: 16),
                  _buildTextField(state.aboutWorkController, 'About work', maxLines: 3),
                  const SizedBox(height: 16),
                  _buildTextField(state.artistController, 'Artist'),
                  const SizedBox(height: 16),
                  _buildTextField(state.typeController, 'Type'),
                  const SizedBox(height: 16),
                  _buildTextField(state.sizeController, 'Size'),
                  const SizedBox(height: 16),
                  _buildTextField(state.locationController, 'Location'),
                  const SizedBox(height: 16),
                  _buildTextField(state.priceController, 'Price'), //semboller eklenebileceği için keyboardType eklemedim
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
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: Text('Submit Post',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  const SizedBox(height: 20),
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
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.red.shade900,
          ),
        ),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
