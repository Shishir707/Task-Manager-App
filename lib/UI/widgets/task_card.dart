import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/UI/widgets/center_progress.dart';
import 'package:task_manager/UI/widgets/scaffold_message.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/my_urls.dart';
import 'package:task_manager/provider/delete_provider.dart';
import 'package:task_manager/provider/edit_provider.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isLoading = false;
  bool isDeleteInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.taskModel.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            widget.taskModel.description,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 4),
          Text(
            widget.taskModel.createdDate,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: setStatusColor(widget.taskModel.status),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  widget.taskModel.status,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Spacer(),
              Consumer<DeleteProvider>(
                builder: (context, value, child) =>
                    Visibility(
                      visible: isDeleteInProgress == false,
                      replacement: CenterCircularProgress(),
                      child: IconButton(
                        onPressed: _onTapDeleteTask,
                        icon: Icon(Icons.delete, color: Colors.red.shade300),
                      ),
                    ),
              ),
              Consumer<EditProvider>(builder: (context, value, child) =>
                  Visibility(
                    visible: isLoading == false,
                    replacement: CenterCircularProgress(),
                    child: IconButton(
                      onPressed: _onTapEditTask,
                      icon: Icon(Icons.edit, color: Colors.blue.shade300),
                    ),
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onTapDeleteTask() async {
    NetworkResponse response = await context.read<DeleteProvider>().deleteTask(
      id: widget.taskModel.id,
    );

    if (response.statusCode == 200) {
      trueScaffoldMessage(
        context,
        "${widget.taskModel.title} has been deleted successfully",
      );
    } else {
      falseScaffoldMessage(context, response.errorMessage);
    }
  }

  void _onTapEditTask() {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text('Change Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('New'),
                  trailing: isSelectedState('New') ? Icon(Icons.done) : null,
                  onTap: () {
                    onTapChangeStatus('New');
                  },
                ),
                ListTile(
                  title: Text('Progress'),
                  trailing: isSelectedState('Progress')
                      ? Icon(Icons.done)
                      : null,
                  onTap: () {
                    onTapChangeStatus('Progress');
                  },
                ),
                ListTile(
                  title: Text('Cancelled'),
                  trailing: isSelectedState('Cancelled')
                      ? Icon(Icons.done)
                      : null,
                  onTap: () {
                    onTapChangeStatus('Cancelled');
                  },
                ),
                ListTile(
                  title: Text('Completed'),
                  trailing: isSelectedState('Completed')
                      ? Icon(Icons.done)
                      : null,
                  onTap: () {
                    onTapChangeStatus('Completed');
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _updateStatus(String status) async {
    NetworkResponse response = await context.read<EditProvider>().changeStatus(
      id: widget.taskModel.id,
      status: status,
    );

    if (response.isSuccess) {
      Navigator.pop(context);
      trueScaffoldMessage(
        context,
        "Successfully changed status ${widget.taskModel.status} to $status",
      );
    } else {
      falseScaffoldMessage(context, response.errorMessage);
    }
  }

  bool isSelectedState(String status) {
    return widget.taskModel.status == status;
  }

  void onTapChangeStatus(String status) {
    if (isSelectedState(status)) return;
    _updateStatus(status);
  }

  Color setStatusColor(String status) {
    if (status == "New") {
      return Colors.purple;
    } else if (status == "Progress") {
      return Colors.blue;
    } else if (status == "Cancelled") {
      return Colors.red;
    } else if (status == "Completed") {
      return Colors.green;
    }
    return Colors.grey;
  }
}
