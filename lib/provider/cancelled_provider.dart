import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import '../data/service/network_caller.dart';
import '../data/utils/my_urls.dart';

class CancelledTaskProvider extends ChangeNotifier {
  bool isCancelLoading = false;
  List<TaskModel> cancelledTask = [];

  Future<void> getCancelledTask() async {
    isCancelLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        MyUrls.cancelledTasksUrl,
      );

      if (response.isSuccess) {
        cancelledTask.clear();
        for (Map<String, dynamic> jsonData in response.body['data']) {
          cancelledTask.add(TaskModel.fromJson(jsonData));
        }
      } else {
        debugPrint(response.errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isCancelLoading = false;
      notifyListeners();
    }
  }
}
