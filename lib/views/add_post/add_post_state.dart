import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostState with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;

  Future<void> pickImage(BuildContext context) async {
    final ImageSource? source = await _showImageSourceDialog(context);
    if (source == null) return;

    try {
      final XFile? selectedImage = await _picker.pickImage(source: source);
      if (selectedImage != null) {
        imageFile = selectedImage;
        notifyListeners();
      }
    } catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future<ImageSource?> _showImageSourceDialog(BuildContext context) async {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a picture'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  final nameController = TextEditingController();
  final aboutWorkController = TextEditingController();
  final typeController = TextEditingController();
  final linkController = TextEditingController();

  void dispose() {
    nameController.dispose();
    aboutWorkController.dispose();
    typeController.dispose();
    linkController.dispose();
    super.dispose();
  }
}
