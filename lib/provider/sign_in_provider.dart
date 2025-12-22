import 'package:flutter/cupertino.dart';
import '../UI/controller/auth_controller.dart';
import '../data/models/user_model.dart';
import '../data/service/network_caller.dart';
import '../data/utils/my_urls.dart';

class SignInProvider extends ChangeNotifier {
  bool isLoginLoading = false;

  Future<NetworkResponse> signIn({
    required Map<String, dynamic> requestBody,
  }) async {
    isLoginLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.postRequest(
        MyUrls.login,
        body: requestBody,
      );

      if (response.isSuccess) {
        UserModel userData = UserModel.fromJson(response.body['data']);
        String accessToken = response.body['token'];
        await AuthController.saveLoginData(accessToken, userData);
        return response;
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1);
    } finally {
      isLoginLoading = false;
      notifyListeners();
    }
  }
}
