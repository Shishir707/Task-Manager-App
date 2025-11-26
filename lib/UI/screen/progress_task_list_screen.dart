import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/center_progress.dart';
import 'package:task_manager/UI/widgets/task_card.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../../data/service/network_caller.dart';
import '../../data/utils/my_urls.dart';
import '../widgets/scaffold_message.dart';

class ProgressTaskList extends StatefulWidget {
  const ProgressTaskList({super.key});

  @override
  State<ProgressTaskList> createState() => _ProgressTaskListState();
}

class _ProgressTaskListState extends State<ProgressTaskList> {
  bool isLoading = false;
  List<TaskModel> progressTaskList = [];

  @override
  void initState() {
    getProgressTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          getProgressTask();
        },
        child: progressTaskList.isNotEmpty
            ? ListView(
                children: [
                  Visibility(
                    visible: isLoading == false,
                    replacement: SizedBox(
                      height: 200,
                      child: CenterCircularProgress(),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        ListView.separated(
                          itemCount: progressTaskList.length,
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return TaskCard(taskModel: progressTaskList[index]);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 8);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/noTask.png'),
                    Text("No cancelled tasks found"),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddTaskButton() {
    Navigator.pushNamed(context, "/add-new");
  }

  Future<void> getProgressTask() async {
    isLoading = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      MyUrls.progressTasksUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> newList = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        newList.add(TaskModel.fromJson(jsonData));
      }
      progressTaskList = newList;
    } else {
      falseScaffoldMessage(context, response.errorMessage);
    }

    isLoading = false;
    setState(() {});
  }
}
