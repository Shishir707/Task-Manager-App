import 'package:flutter/cupertino.dart';
import 'package:task_manager/data/service/network_caller.dart';

import '../data/utils/my_urls.dart';

class EditProvider extends ChangeNotifier {
  bool isEditLoading = false;

  Future<NetworkResponse> changeStatus({required id, required status}) async {
    isEditLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        MyUrls.updateTaskUrl(id, status),
      );

      if (response.statusCode == 200) {
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
      isEditLoading = false;
      notifyListeners();
    }
  }
}
