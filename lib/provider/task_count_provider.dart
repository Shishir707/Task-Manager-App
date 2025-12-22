import 'package:flutter/cupertino.dart';
import 'package:task_manager/data/service/network_caller.dart';
import '../data/models/task_count_model.dart';
import '../data/utils/my_urls.dart';

class TaskCountProvider extends ChangeNotifier {
  bool isCountLoading = false;
  List<StatusCountModel> sumTask = [];

  Future<void> getCount() async {
    isCountLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        MyUrls.totalTaskUrl,
      );

      if (response.isSuccess) {
        if (response.isSuccess) {
          for (Map<String, dynamic> jsonData in response.body['data']) {
            sumTask.add(StatusCountModel.fromJson(jsonData));
          }
        }
      } else {
        debugPrint(response.errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isCountLoading = false;
      notifyListeners();
    }
  }
}
