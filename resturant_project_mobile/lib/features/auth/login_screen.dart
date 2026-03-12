import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDE7E3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Logo
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: const Color(0xffF9D6D8),
                    child: Icon(Icons.restaurant, color: Colors.red, size: 35),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Akiel",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Welcome! Login or Create an Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),

                  const SizedBox(height: 25),

                  /// Login / Signup switch
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F3F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const Expanded(
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// Email
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Email or Phone"),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your email or phone",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Password
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password"),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: const Icon(Icons.visibility_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// Remember me
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (v) {}),

                      const Text("Remember me"),

                      const Spacer(),

                      const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text("OR CONTINUE WITH"),

                  const SizedBox(height: 15),

                  /// Social buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Google"),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Facebook"),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      children: [
                        TextSpan(
                          text: "Sign Up Free",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
