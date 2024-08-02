import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../firebase_dao.dart';
import '../../models/post.dart';
import '../../models/user.dart';

class ArtworkDetailPage extends StatefulWidget {

  final Post post;

  ArtworkDetailPage({required this.post});

  @override
  _ArtworkDetailPageState createState() => _ArtworkDetailPageState();
}

class _ArtworkDetailPageState extends State<ArtworkDetailPage> {
  late YoutubePlayerController _controller;
  bool isFavorite = false; // Favori durumu




  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.post.youtubeVideoLink) ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    _controller.addListener(() {
      if (_controller.value.playerState == PlayerState.ended) {
        _controller.seekTo(Duration.zero);
        _controller.play();
      }
    });
    _checkIfFavorite();
  }
  Future<void> _checkIfFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserM? userData = await FirebaseDao().getUserData(user.uid);
      if (userData != null) {
        setState(() {
          isFavorite = userData.savedPostIds.contains(widget.post.postId);
        });
      }
    }
  }
  Future<String> _getUserEmail(String userId) async {
    DocumentSnapshot userSnapshot =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userSnapshot['email'] ?? 'No Email Found';
  }
  void _showEmailDialog(String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Contact Information',textAlign: TextAlign.center,),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Email: $email'),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: email));
                    Navigator.of(context).pop(); // Dialog'u kapat
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Email copied to clipboard')),
                    );
                  },
                  child: Text('Copy to Clipboard',style: TextStyle(color: Colors.red),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Future<void> _toggleFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserM? userData = await FirebaseDao().getUserData(user.uid);
      if (userData != null) {
        if (isFavorite) {
          // Remove from favorites
          userData.savedPostIds.remove(widget.post.postId);
        } else {
          // Add to favorites
          userData.savedPostIds.add(widget.post.postId);
        }
        await FirebaseDao().updateUserData(userData);

        setState(() {
          isFavorite = !isFavorite;
        });
      }
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * 0.75, // Height to show part of the underlying page
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 95,height: 2,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.red.shade900,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.post.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                  IconButton(
                    icon: Icon(Icons.mode_comment_outlined,color: Colors.grey,),
                    onPressed: (){ print("basıldı");},
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                widget.post.tagId.tagId.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Artist',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            Text(
              widget.post.artist, // Example artist name, replace with actual artist data
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Location',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            Text(
              widget.post.location, // Example location, replace with actual location data
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Price',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            Text(
              widget.post.price,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              widget.post.description, // Example description, replace with actual description
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),

            Expanded(
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Kullanıcının email adresini al ve dialog'u göster
                  String email = await _getUserEmail(widget.post.userID);
                  _showEmailDialog(email);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red.shade900,
                  side: BorderSide(color: Colors.red.shade900),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Contact to Buy'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
