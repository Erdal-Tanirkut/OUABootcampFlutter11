import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muse/views/onboarding/onboarding.dart';
import 'package:muse/views/sign_up/sign_up_state.dart';
import 'package:provider/provider.dart';
import 'sign_in_viewmodel.dart';
import '../explore/explore_view.dart';
import '../sign_up/sign_up_view.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignInViewModel>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(Icons.arrow_back, color: Color(0xFFB71C1C)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 50),
              Text(
                'Sign in now',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Please sign in to continue our app',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              TextField(
                onChanged: viewModel.setEmail,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: viewModel.setPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Implement forgot password navigation
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB71C1C),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  viewModel.signIn(context);
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: "Don't have an account? ",
                      ),
                      TextSpan(
                        text: 'Sign up',
                        style: const TextStyle(
                          color: Color(0xFFB71C1C),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpState()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
