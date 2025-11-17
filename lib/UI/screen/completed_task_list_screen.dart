import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/task_card.dart';

class CompletedTaskList extends StatefulWidget {
  const CompletedTaskList({super.key});

  @override
  State<CompletedTaskList> createState() => _CompletedTaskListState();
}

class _CompletedTaskListState extends State<CompletedTaskList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8),
            ListView.separated(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TaskCard();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 8);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
