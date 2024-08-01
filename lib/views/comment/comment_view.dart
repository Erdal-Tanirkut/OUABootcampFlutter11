import 'package:flutter/material.dart';
import 'package:muse/core/constants/bottom_navigation_bar.dart';
import 'package:muse/firebase_dao.dart';
import 'package:muse/models/post.dart';
import 'package:provider/provider.dart';
import '../../models/comment.dart';
import 'comment_viewmodel.dart';


class CommentsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommentsViewModel>(context);
    final Post post;

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
      //bottomNavigationBar: CustomBottomNavigationBar(),
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

              },
              child: Text('Title'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
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
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.userID, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(comment.date, style: TextStyle(color: Colors.grey)),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  // Menü işlemleri
                },
              ),


          SizedBox(height: 10),
          Text(comment.description),
          SizedBox(height: 10),

            ],
          ),
        ],

    ));
  }
}
