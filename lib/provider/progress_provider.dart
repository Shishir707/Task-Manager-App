import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import '../data/service/network_caller.dart';
import '../data/utils/my_urls.dart';

class ProgressProvider extends ChangeNotifier {
  bool isProgressLoading = false;
  List<TaskModel> progressTask = [];

  Future<void> getProgressTask() async {
    isProgressLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        MyUrls.progressTasksUrl,
      );

      if (response.isSuccess) {
        progressTask.clear();
        for (Map<String, dynamic> jsonData in response.body['data']) {
          progressTask.add(TaskModel.fromJson(jsonData));
        }
      } else {
        debugPrint(response.errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isProgressLoading = false;
      notifyListeners();
    }
  }
}
