import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDE7E3),
      body: SafeArea(
        child: Center(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Logo
                    const Center(
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Color(0xffF9D6D8),
                        child: Icon(
                          Icons.restaurant,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// App Name
                    const Center(
                      child: Text(
                        "Akiel",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Center(
                      child: Text(
                        "Welcome! Login or Create an Account",
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
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
                          const Expanded(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// Full Name
                    const Text("FULL NAME"),
                    const SizedBox(height: 8),

                    TextField(
                      decoration: InputDecoration(
                        hintText: "John Doe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Email
                    const Text("EMAIL ADDRESS"),
                    const SizedBox(height: 8),

                    TextField(
                      decoration: InputDecoration(
                        hintText: "example@mail.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Phone
                    const Text("PHONE NUMBER"),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Container(
                          width: 80,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text("+20"),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "123 456 7890",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Password
                    const Text("PASSWORD"),
                    const SizedBox(height: 8),

                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "••••••••",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Confirm Password
                    const Text("CONFIRM PASSWORD"),
                    const SizedBox(height: 8),

                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "••••••••",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Terms
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (v) {}),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: "I agree to the ",
                              children: [
                                TextSpan(
                                  text: "Terms of Service",
                                  style: TextStyle(color: Colors.red),
                                ),
                                TextSpan(text: " and "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Create Account Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Create Account",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Login link
                    const Center(
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          children: [
                            TextSpan(
                              text: "Login",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
