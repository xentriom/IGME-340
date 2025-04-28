import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Don\'t use your real name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: DefaultTextStyle.merge(
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  child: Text("Login"),
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                // Do nothing bc i dont have time for this
              },
              child: DefaultTextStyle.merge(
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
                child: Text(
                  "By Clicking Continue, you are agreeing to the Terms of Use including the arbitration clause and you are acknowledging the Privacy Policy.",
                ),
              ),
            ),

            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12,
              children: [
                TextButton(
                  onPressed: () {
                    // Do nothing bc i dont have time for this
                  },
                  child: DefaultTextStyle.merge(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                    child: Text("Terms"),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    // Do nothing bc i dont have time for this
                  },
                  child: DefaultTextStyle.merge(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                    child: Text("Privacy"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
