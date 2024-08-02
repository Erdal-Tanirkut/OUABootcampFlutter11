import 'package:flutter/material.dart';
import 'package:muse/views/sign_in/sign_in_viewmodel.dart';
import 'package:muse/views/sign_in/sign_in_view.dart';
import 'package:muse/views/sign_up/sign_up_viewmodel.dart';
import 'package:muse/views/sign_up/sign_up_view.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 304,
              height: 205.77, //desired height for the logo container
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20), //rounded corners
              ),
              child: Image.asset('assets/images/onboarding.jpg'),
            ),
            const SizedBox(height: 40),
            const Text(
              'Welcome to',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
              'muse',
              style: TextStyle(
                  color: Color(0xFFB71C1C),
                  fontFamily: 'DMSans',
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Discover and connect with artists from\n all over the wrold.',
              style: TextStyle(color: Colors.black87, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => SignUpViewModel(),
                      child: SignUpView(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB71C1C), // Button color
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), //rounded corners
                ),
                minimumSize: const Size(double.infinity, 50), //button size
              ),
              child: const Text('Create an account'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                const Text(
                  'Already have an account? ',
                  style: TextStyle(color: Colors.black54),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => SignInViewModel(),
                          child: SignInView(),
                        ),
                      ),
                    );
                  },
                  child: const Text('Sign in',
                      style: TextStyle(
                          color: Color(0xFFB71C1C),
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
