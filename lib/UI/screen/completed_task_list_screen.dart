import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/UI/widgets/center_progress.dart';
import 'package:task_manager/UI/widgets/task_card.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/provider/completed_provider.dart';

import '../../data/service/network_caller.dart';
import '../../data/utils/my_urls.dart';
import '../widgets/scaffold_message.dart';

class CompletedTaskList extends StatefulWidget {
  const CompletedTaskList({super.key});

  @override
  State<CompletedTaskList> createState() => _CompletedTaskListState();
}

class _CompletedTaskListState extends State<CompletedTaskList> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<CompleteTaskProvider>().getCompletedTask();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CompleteTaskProvider>(
      builder: (context, provider, child) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            provider.getCompletedTask();
          },
          child: provider.completeTask.isNotEmpty
              ? ListView(
                  children: [
                    Visibility(
                      visible: provider.isCompleteLoading == false,
                      replacement: SizedBox(
                        height: 200,
                        child: CenterCircularProgress(),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          ListView.separated(
                            itemCount: provider.completeTask.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TaskCard(
                                taskModel: provider.completeTask[index],
                              );
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
                      Text(
                        "No completed tasks found",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onTapAddTaskButton,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _onTapAddTaskButton() {
    Navigator.pushNamed(context, "/add-new");
  }
}
