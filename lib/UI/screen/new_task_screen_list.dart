import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/task_card.dart';

class NewTaskScreenList extends StatefulWidget {
  const NewTaskScreenList({super.key});

  @override
  State<NewTaskScreenList> createState() => _NewTaskScreenListState();
}

class _NewTaskScreenListState extends State<NewTaskScreenList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            const SizedBox(),
            _NewSummaryList(),
            ListView.separated(
              itemCount: 10,
              primary: false,
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
        onPressed: _onTapAddNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTaskButton() {
    Navigator.pushNamed(context, "/add-new");
  }
}

class _NewSummaryList extends StatelessWidget {
  const _NewSummaryList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.only(left: 5, top: 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Text('12', style: TextTheme.of(context).titleLarge),
                  Text('New', style: TextTheme.of(context).labelSmall),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
