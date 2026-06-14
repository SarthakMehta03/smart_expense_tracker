import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;

  final AuthService authService = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose(){
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),

            const SizedBox(height: 25,),

            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name",border: OutlineInputBorder()),
            ),

            const SizedBox(height: 15,),

            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email",border: OutlineInputBorder()),
            ),

            const SizedBox(height: 15,),

            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password",border: OutlineInputBorder()),
            ),

            const SizedBox(height: 25,),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () async {

                setState(() {
                  isLoading = true;
                });

                final user = await authService.registerUser(
                    email: emailController.text.trim(),

                    password: passwordController.text.trim()
                );
                setState(() {
                  isLoading = false;
                });

                if (user != null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Registration Successful"))
                  );
                }

              }, child: isLoading ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ) : const Text("Create Account"),),
            ),

            const SizedBox(height: 15,),
            TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Alredy a User ? login"))
          ],
        ),
      ),
    );
  }
}
