import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/UI/controller/auth_controller.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';
import 'package:task_manager/UI/widgets/center_progress.dart';
import 'package:task_manager/UI/widgets/scaffold_message.dart';
import 'package:task_manager/UI/widgets/tm_appbar.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/my_urls.dart';
import '../widgets/photo_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();

  XFile? pickedImage;

  bool isUpdateInProgress = false;

  @override
  void initState() {
    final UserModel userModel = AuthController.userData!;
    _emailController.text = userModel.email;
    _firstController.text = userModel.firstName;
    _lastController.text = userModel.lastName;
    _mobileController.text = userModel.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappbar(fromUpdateProfile: true),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                SizedBox(height: 60),
                Text(
                  'Update Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: _chooseImage,
                  child: PhotoPicker(pickedImage: pickedImage),
                ),
                TextFormField(
                  controller: _emailController,
                  enabled: false,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                TextFormField(
                  controller: _firstController,
                  decoration: InputDecoration(hintText: 'First name'),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "Enter first name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastController,
                  decoration: InputDecoration(hintText: 'Last name'),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "Enter last name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(hintText: 'Mobile'),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "Enter mobile number";
                    } else if (value.length < 11) {
                      return "Enter 11 digit phone number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passController,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (String? value) {
                    String password = value ?? "";
                    if (password.isNotEmpty && password.length < 6) {
                      return "Enter a password at least 6 letter";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Visibility(
                  visible: isUpdateInProgress = true,
                  replacement: CenterCircularProgress(),
                  child: FilledButton(
                    onPressed: _onTapUpdateProfileButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _chooseImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage = image;
      setState(() {});
    }
  }

  void _onTapUpdateProfileButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    isUpdateInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailController.text,
      "firstName": _firstController.text.trim(),
      "lastName": _lastController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };

    if (_passController.text.isNotEmpty) {
      requestBody["password"] = _passController.text;
    }

    if (pickedImage != null) {
      Uint8List imgBytes = await pickedImage!.readAsBytes();
      requestBody["photo"] = base64Encode(imgBytes);
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      MyUrls.updateProfile,
      body: requestBody,
    );

    if (response.isSuccess) {
      requestBody["_id"] = AuthController.userData?.id;
      await AuthController.updateUserData(UserModel.fromJson(requestBody));
      trueScaffoldMessage(context, "Profile Updated Successfully!");
    } else {
      falseScaffoldMessage(context, response.errorMessage);
    }
  }
}
