import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_edit_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/bottom_navigation_bar.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});


  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  Map<String, dynamic> updatedFields = {};
  final ImagePicker _picker = ImagePicker();

  Future<void> _changeProfilePicture(ProfileEditViewModel viewModel) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      viewModel.updatePhotoUrl(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFB71C1C)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<ProfileEditViewModel>(context, listen: false)
                  .updateUserData();
              Navigator.of(context).pop();
            },
            child: const Text('Done',
                style: TextStyle(color: Color(0xFFB71C1C), fontSize: 20)),
          )
        ],
        centerTitle: false,
      ),
      body: Consumer<ProfileEditViewModel>(
        builder: (context, viewModel, child) => ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Text(viewModel.state.userName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _changeProfilePicture(viewModel),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade400,
                backgroundImage: viewModel.state.photoUrl.isNotEmpty
                    ? NetworkImage(viewModel.state.photoUrl) as ImageProvider
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            Center(
                child: TextButton(
                    onPressed: () => _changeProfilePicture(viewModel),
                    child: const Text(
                      "Change Profile Picture",
                      style: TextStyle(color: Color(0xFFB71C1C)),
                    ))),
            const SizedBox(height: 30),
            _buildTextField(viewModel.state.userName, 'Username',
                onChanged: viewModel.updateUsername),
            const SizedBox(height: 30),
            _buildTextField(viewModel.state.email, 'Email',
                onChanged: viewModel.updateEmail),
            const SizedBox(height: 30),
            _buildTextField(viewModel.state.location, 'Location',
                onChanged: (value) => viewModel.state.location = value),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
      ),
    );
  }

  Widget _buildTextField(String initialValue, String labelText,
      {required Function(String) onChanged, int maxLines = 1}) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: labelText,
      ),
      onChanged: onChanged,
    );
  }
}
