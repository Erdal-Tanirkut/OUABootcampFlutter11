import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sign_in_viewmodel.dart';
import 'sign_in_view.dart';


class SignInState extends StatefulWidget {
  @override
  _SignInStateState createState() => _SignInStateState();
}

class _SignInStateState extends State<SignInState> {
  final SignInViewModel viewModel = SignInViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => viewModel,
      child: Consumer<SignInViewModel>(
        builder: (context, model, child) {
          return SignInView();
        },
      ),
    );
  }
}