import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'add_post_state.dart';
import 'add_post_viewmodel.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  _AddPostViewState createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  int _selectedIndex = 3; //profile page

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Add Work'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final state = Provider.of<AddPostState>(context, listen: false);
              if (state.formKey.currentState!.validate()) {
                final viewModel = AddPostViewModel(state: state);
                viewModel.submitPost();
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
                    await state.pickImage();
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
                _buildTextField(state.aboutWorkController, 'About work',
                    maxLines: 3),
                _buildTextField(state.artistController, 'Artist'),
                _buildTextField(state.typeController, 'Type'),
                _buildTextField(state.sizeController, 'Size'),
                _buildTextField(state.locationController, 'Location'),
                _buildTextField(state.priceController,
                    'Price'), //semboller eklenebileceği için keyboardType eklemedim
                _buildTextField(state.linkController, 'Link'),
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
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
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
