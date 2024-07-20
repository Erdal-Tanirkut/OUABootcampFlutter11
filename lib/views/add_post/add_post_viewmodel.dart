import 'add_post_state.dart';

class AddPostViewModel {
  final AddPostState state;

  AddPostViewModel({required this.state});

  Future<void> submitPost() async {
    //Sending post data
    print("Submit post with image path: ${state.imageFile?.path}");
  }
}
