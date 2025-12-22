import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/UI/widgets/center_progress.dart';
import 'package:task_manager/UI/widgets/task_card.dart';
import 'package:task_manager/provider/progress_provider.dart';

class ProgressTaskList extends StatefulWidget {
  const ProgressTaskList({super.key});

  @override
  State<ProgressTaskList> createState() => _ProgressTaskListState();
}

class _ProgressTaskListState extends State<ProgressTaskList> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<ProgressProvider>().getProgressTask();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressProvider>(
      builder: (context, provider, child) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            provider.getProgressTask();
          },
          child: provider.progressTask.isNotEmpty
              ? ListView(
                  children: [
                    Visibility(
                      visible: provider.isProgressLoading == false,
                      replacement: SizedBox(
                        height: 200,
                        child: CenterCircularProgress(),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          ListView.separated(
                            itemCount: provider.progressTask.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TaskCard(
                                taskModel: provider.progressTask[index],
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
                        "No progress tasks found",
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
