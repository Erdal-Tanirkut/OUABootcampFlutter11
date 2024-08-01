import 'package:muse/models/post.dart';

class ProfileState {
  String userName = '';
  String bio = '';
  String website = '';
  String photoUrl = '';
  int worksCount = 0;
  List<Post> userPosts = [];

  ProfileState({
    this.userName = '',
    this.bio = '',
    this.website = '',
    this.photoUrl = '',
    this.worksCount = 0,
    this.userPosts = const [],
  });
}
