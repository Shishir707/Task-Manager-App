import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/scafold_message.dart';
import 'package:task_manager/UI/widgets/task_card.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/my_urls.dart';

class NewTaskScreenList extends StatefulWidget {
  const NewTaskScreenList({super.key});

  @override
  State<NewTaskScreenList> createState() => _NewTaskScreenListState();
}

class _NewTaskScreenListState extends State<NewTaskScreenList> {
  bool isLoading = false;
  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    super.initState();
    getNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Visibility(
          visible: isLoading == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: Column(
            spacing: 8,
            children: [
              const SizedBox(height: 8),
              _NewSummaryList(),
              ListView.separated(
                itemCount: _newTaskList.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (_, index) =>
                    TaskCard(taskModel: _newTaskList[index]),
                separatorBuilder: (_, index) => SizedBox(height: 8),
              ),
            ],
          ),
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

  Future<void> getNewTask() async {
    isLoading = true;
    print('ok');
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      MyUrls.newTaskList,
    );

    if (response.isSuccess) {
      List<TaskModel> newList = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        newList.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = newList;
    } else {
      falseScaffoldMessage(context, response.errorMessage);
    }

    isLoading = false;
    setState(() {});
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
                  Text('12', style: Theme.of(context).textTheme.titleLarge),
                  Text('New', style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
