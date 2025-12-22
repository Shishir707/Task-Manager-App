import 'package:flutter/cupertino.dart';
import 'package:task_manager/data/service/network_caller.dart';

import '../data/utils/my_urls.dart';

class DeleteProvider extends ChangeNotifier {
  bool isDeleteLoading = false;

  Future<NetworkResponse> deleteTask({required id}) async {
    isDeleteLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        MyUrls.deleteTaskUrl(id),
      );

      if (response.isSuccess) {
        return response;
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      return NetworkResponse(isSuccess: false, statusCode: -1);
    } finally {
      isDeleteLoading = false;
      notifyListeners();
    }
  }
}
