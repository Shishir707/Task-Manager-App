import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import '../data/service/network_caller.dart';
import '../data/utils/my_urls.dart';

class NewTaskProvider extends ChangeNotifier {
  bool isNewLoading = false;
  List<TaskModel> newTask = [];

  Future<void> getNewTask() async {
    isNewLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        MyUrls.newTasksUrl,
      );

      if (response.isSuccess) {
        newTask.clear();
        for (Map<String, dynamic> jsonData in response.body['data']) {
          newTask.add(TaskModel.fromJson(jsonData));
        }
      } else {
        debugPrint(response.errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isNewLoading = false;
      notifyListeners();
    }
  }
}
