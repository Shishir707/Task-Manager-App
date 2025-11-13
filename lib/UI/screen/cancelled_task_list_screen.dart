import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/task_card.dart';

class CancelledTaskList extends StatefulWidget {
  const CancelledTaskList({super.key});

  @override
  State<CancelledTaskList> createState() => _CancelledTaskListState();
}

class _CancelledTaskListState extends State<CancelledTaskList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 8,),
          Expanded(
            child: TaskCard(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add),),
    );
  }
}

