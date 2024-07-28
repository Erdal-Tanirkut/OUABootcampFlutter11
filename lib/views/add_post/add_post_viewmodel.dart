import 'package:uuid/uuid.dart';

import '../../firebase_dao.dart';
import '../../models/image.dart';
import '../../models/post.dart';
import '../../models/tag.dart';
import 'add_post_state.dart';
import '';

class AddPostViewModel {
  final AddPostState state;
  final FirebaseDao _firebaseDao = FirebaseDao();

  AddPostViewModel({required this.state});

  Future<void> submitPost() async {
    //Sending post data
    // Benzersiz bir postId oluştur
    final postId = Uuid().v4();

    // Image'ı Firebase Storage'a yükle ve download URL'ini al
    String? imageUrl;
    if (state.imageFile != null) {
      imageUrl = await _firebaseDao.uploadImage(state.imageFile!.path);
    }

    // Yeni Post nesnesini oluştur
    final post = Post(
      userID: 'userID', // Burada kullanıcı ID'sini kullanın
      postId: postId,
      title: state.nameController.text,
      description: state.aboutWorkController.text,
      tagId: Tag(tagId: state.typeController.text), // Tipi Tag olarak kabul ediyoruz
      storageId: imageUrl ?? '', // Resmin Firebase Storage URL'si
      youtubeVideoLink: state.linkController.text,
      likeCount: 0, // Başlangıçta 0 beğeni
      image: ImageM(url: imageUrl ?? '', storagePath: '', imageUrl: '', storageId: ''), // Burada url alanı kullanıldı
    );

    // Post'u Firestore'a yaz
    await _firebaseDao.writePost(post);
    print("Submit post with image path: ${state.imageFile?.path}");
  }
}
