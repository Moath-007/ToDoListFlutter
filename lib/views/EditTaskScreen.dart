import 'package:flutter/material.dart';
import '../models/TaskModel.dart';
import 'package:provider/provider.dart';
import '../services/AuthProvider.dart';
import '../services/TaskProvider.dart';


class EditTaskScreen extends StatelessWidget {
  final TaskModel task;
  EditTaskScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
    final descController = TextEditingController(text: task.description);

    return Scaffold(
      appBar: AppBar(title: const Text("تعديل المهمة")),
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
                  await context.read<TaskProvider>().updateTask(
                    task.id,
                    titleController.text,
                    descController.text,
                    userId,
                  );
                  if (context.mounted) Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text("حفظ التعديلات"),
            )
          ],
        ),
      ),
    );
  }
}