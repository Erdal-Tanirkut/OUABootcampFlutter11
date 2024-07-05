import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center, //left arrow da ekranın ortasına geliyor
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              alignment: Alignment.topLeft,
              icon: Icon(Icons.arrow_back, color: Colors.red),
              onPressed: () {
                // TODO: Implement back navigation
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
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'example@gmail.com',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Implement forgot password navigation
                },
                child: Text(
                  'Forget Password?',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                // TODO: Implement sign-in logic
              },
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  // TODO: Implement sign-up navigation
                },
                child: Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
