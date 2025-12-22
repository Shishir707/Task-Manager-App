import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/UI/widgets/center_progress.dart';
import 'package:task_manager/UI/widgets/task_card.dart';
import 'package:task_manager/provider/cancelled_provider.dart';

class CancelledTaskList extends StatefulWidget {
  const CancelledTaskList({super.key});

  @override
  State<CancelledTaskList> createState() => _CancelledTaskListState();
}

class _CancelledTaskListState extends State<CancelledTaskList> {
  @override
  void initState() {
    context.read<CancelledTaskProvider>().getCancelledTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CancelledTaskProvider>(
      builder: (context, provider, child) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            ();
          },
          child: provider.cancelledTask.isNotEmpty
              ? ListView(
                  children: [
                    Visibility(
                      visible: provider.isCancelLoading == false,
                      replacement: SizedBox(
                        height: 200,
                        child: CenterCircularProgress(),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          ListView.separated(
                            itemCount: provider.cancelledTask.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TaskCard(
                                taskModel: provider.cancelledTask[index],
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
                        "No cancelled tasks found",
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
