import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sign_up_view.dart';
import 'sign_up_viewmodel.dart';

class SignUpState extends StatefulWidget {
  @override
  _SignUpStateState createState() => _SignUpStateState();
}

class _SignUpStateState extends State<SignUpState> {
  final SignUpViewModel viewModel = SignUpViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => viewModel,
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) {
          return SignUpView();
        },
      ),
    );
  }
}