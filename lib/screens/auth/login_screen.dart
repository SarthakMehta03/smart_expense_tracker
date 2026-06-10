import 'package:flutter/material.dart';
import 'package:smart_expense_tracker/screens/auth/register_screen.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthService authService = AuthService();

  final  TextEditingController emailController = TextEditingController();
  final  TextEditingController passwordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Smart Expence Tracker",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),),

            const SizedBox(height: 30,),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 15,),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
                width: double.infinity,
                child:ElevatedButton(onPressed: () async {

                  final user  = await authService.loginUser(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim()
                  );

                  if (user != null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Successful"))
                    );
                  }

                }, child: const Text("Login"))),

            const SizedBox(height: 15),

            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterScreen()));
            }, child: const Text("Register"))

          ],
        ),
      ),

    );
  }
}
