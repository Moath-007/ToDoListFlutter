import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/AuthProvider.dart';
import '../services/TaskProvider.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إضافة مهمة جديدة")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "العنوان")),
            const SizedBox(height: 10),
            TextField(controller: descController, decoration: const InputDecoration(labelText: "الوصف")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final userId = context.read<AuthProvider>().user?.id;
                if (titleController.text.isNotEmpty && userId != null) {
                  await context.read<TaskProvider>().addTask(
                    titleController.text,
                    descController.text,
                    userId,
                  );
                  if (context.mounted) Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text("إضافة"),
            )
          ],
        ),
      ),
    );
  }
}
