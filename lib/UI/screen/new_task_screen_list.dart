import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/UI/widgets/scaffold_message.dart';
import 'package:task_manager/UI/widgets/task_card.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/my_urls.dart';

import '../../data/models/task_count_model.dart';
import '../../provider/new_task_provider.dart';
import '../widgets/center_progress.dart';

class NewTaskScreenList extends StatefulWidget {
  const NewTaskScreenList({super.key});

  @override
  State<NewTaskScreenList> createState() => _NewTaskScreenListState();
}

class _NewTaskScreenListState extends State<NewTaskScreenList> {
  List<StatusCountModel> _totalTaskCount = [];

  @override
  void initState() {
    super.initState();
    context.read<NewTaskProvider>().getNewTask();
    getSumTask();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewTaskProvider>(
      builder: (context, provider, child) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            getSumTask();
          },
          child: provider.newTask.isNotEmpty
              ? ListView(
                  children: [
                    Visibility(
                      visible: provider.isNewLoading == false,
                      replacement: SizedBox(
                        height: 350,
                        child: CenterCircularProgress(),
                      ),
                      child: Column(
                        spacing: 8,
                        children: [
                          NewSummaryList(listCount: _totalTaskCount),
                          ListView.separated(
                            itemCount: provider.newTask.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (_, index) =>
                                TaskCard(taskModel: provider.newTask[index]),
                            separatorBuilder: (_, index) => SizedBox(height: 8),
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
                        "No New tasks found",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onTapAddNewTaskButton,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _onTapAddNewTaskButton() {
    Navigator.pushNamed(context, "/add-new");
  }

  Future<void> getSumTask() async {
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      MyUrls.totalTaskUrl,
    );

    if (response.isSuccess) {
      List<StatusCountModel> countList = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        countList.add(StatusCountModel.fromJson(jsonData));
      }
      _totalTaskCount = countList;
    } else {
      falseScaffoldMessage(context, response.errorMessage);
    }

    setState(() {});
  }
}

class NewSummaryList extends StatelessWidget {
  const NewSummaryList({super.key, required this.listCount});

  final List<StatusCountModel> listCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: ListView.builder(
        itemCount: listCount.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: Card(
              color: Colors.white,
              elevation: 0,
              margin: EdgeInsets.only(left: 5, top: 5),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Text(
                      listCount[index].sum.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      listCount[index].id,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
