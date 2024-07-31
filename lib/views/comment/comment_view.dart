import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'comment_model.dart';
import 'comments_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommentsViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: CommentsPage(),
      ),
    );
  }
}

class CommentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommentsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildAddCommentSection(context),
              SizedBox(height: 20),
              _buildCommentList(viewModel),
            ],
          ),
        ),
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
        currentIndex: 3, // Profile tabını varsayılan olarak seçili yapalım
        selectedItemColor: Colors.red.shade900,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          // Burada sayfa değişimi işlemlerini yapabilirsiniz
        },
      ),
    );
  }

  Widget _buildAddCommentSection(BuildContext context) {
    final viewModel = Provider.of<CommentsViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add a comment', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/profile_image.jpg'), // Profil resminin asset yolu
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: viewModel.commentController,
                decoration: InputDecoration(
                  hintText: 'What are your thoughts?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                viewModel.addComment();
              },
              child: Text('Title'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red.shade900,
              ),
            ),
            SizedBox(width: 10),
            TextButton(
              onPressed: () {
                viewModel.commentController.clear();
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCommentList(CommentsViewModel viewModel) {
    return Column(
      children: viewModel.comments
          .map((comment) => _buildCommentItem(viewModel, comment))
          .toList(),
    );
  }

  Widget _buildCommentItem(CommentsViewModel viewModel, Comment comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(comment.profileImage), // Profil resminin asset yolu
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.username, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(comment.timeAgo, style: TextStyle(color: Colors.grey)),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  // Menü işlemleri
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(comment.content),
          SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up_alt_outlined),
                onPressed: () {
                  viewModel.likeComment(comment);
                },
              ),
              Text('${comment.likes} likes'),
              SizedBox(width: 20),
              IconButton(
                icon: Icon(Icons.chat_bubble_outline),
                onPressed: () {
                  // Cevaplama işlemi
                },
              ),
              Text('${comment.replies} replies'),
            ],
          ),
        ],
      ),
    );
  }
}

