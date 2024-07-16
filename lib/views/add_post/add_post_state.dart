import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostState with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;

  Future<void> pickImage() async {
    try {
      final XFile? selectedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (selectedImage != null) {
        imageFile = selectedImage;
        notifyListeners();
      }
    } catch (e) {
      print("Resim alma başarili olamadi: $e");
    }
  }

  final nameController = TextEditingController();
  final aboutWorkController = TextEditingController();
  final artistController = TextEditingController();
  final typeController = TextEditingController();
  final sizeController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final linkController = TextEditingController();

  void dispose() {
    nameController.dispose();
    aboutWorkController.dispose();
    artistController.dispose();
    typeController.dispose();
    sizeController.dispose();
    locationController.dispose();
    priceController.dispose();
    linkController.dispose();
    super.dispose();
  }
}
