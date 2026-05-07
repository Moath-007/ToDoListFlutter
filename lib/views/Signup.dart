import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/AuthProvider.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            // عرض الزر مباشرة بدون فحص isLoading
            ElevatedButton(
              onPressed: () async {
                String user = usernameController.text;
                String pass = passwordController.text;

                if (user.isNotEmpty && pass.isNotEmpty) {
                  // استدعاء دالة التسجيل من الـ Provider
                  bool success = await context.read<AuthProvider>().register(user, pass);

                  if (success) {
                    if (context.mounted) {

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Account created! Please login."), backgroundColor: Colors.green));

                      // تأخير بسيط ليرى المستخدم الرسالة ثم العودة للـ Login
                      Future.delayed(const Duration(seconds: 1), () {
                        if (context.mounted) Navigator.pop(context);
                      });
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Signup failed, try again"), backgroundColor: Colors.red));
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all fields"), backgroundColor: Colors.orange));
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}