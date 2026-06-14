import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  bool isLoading = false;

  final AuthService authService = AuthService();

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final user = await authService.registerUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration Successful"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                isLoading ? null : register,
                child: isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child:
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text(
                  "Create Account",
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Already a User? Login",
              ),
            ),
          ],
        ),
      ),
    );
  }
}