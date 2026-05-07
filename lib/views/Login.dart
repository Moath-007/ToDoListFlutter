import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/views/TaskScreen.dart';
import 'Signup.dart';
import '../services/AuthProvider.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // حقل اسم المستخدم
          TextField(
            controller: username,
            decoration: const InputDecoration(
              labelText: "Username",
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),

          // حقل كلمة المرور
          TextField(
            controller: password,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),

          // زر تسجيل الدخول
          ElevatedButton(
            onPressed: () async {
              // 1. استدعاء دالة الـ Login من الـ Provider
              bool success = await context.read<AuthProvider>().login(
                  username.text,
                  password.text
              );

              if (success) {
                // في حالة النجاح: الانتقال لشاشة المهام
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TaskScreen(),
                    ),
                  );
                }
              } else {
                // في حالة الفشل: عرض الرسالة القادمة من الباك إند
                if (context.mounted) {
                  // جلب رسالة الخطأ المخزنة في الـ Provider
                  final errorMsg = context.read<AuthProvider>().errorMessage;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMsg ?? "Login Failed!"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              "LOGIN",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 15),

          // رابط الانتقال لصفحة التسجيل
          TextButton(

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Signup()),
              );
            },
            child: const Text("Don't have an account? Sign Up"),
          ),
        ],
      ),
    );
  }
}