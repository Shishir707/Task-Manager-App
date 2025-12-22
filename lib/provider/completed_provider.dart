import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import '../data/service/network_caller.dart';
import '../data/utils/my_urls.dart';

class CompleteTaskProvider extends ChangeNotifier {
  bool isCompleteLoading = false;
  List<TaskModel> completeTask = [];

  Future<void> getCompletedTask() async {
    isCompleteLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        MyUrls.completedTasksUrl,
      );

      if (response.isSuccess) {
        completeTask.clear();
        for (Map<String, dynamic> jsonData in response.body['data']) {
          completeTask.add(TaskModel.fromJson(jsonData));
        }
      } else {
        debugPrint(response.errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isCompleteLoading = false;
      notifyListeners();
    }
  }
}
