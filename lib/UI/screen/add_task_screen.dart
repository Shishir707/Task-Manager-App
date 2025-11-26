import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';
import 'package:task_manager/UI/widgets/scaffold_message.dart';
import 'package:task_manager/UI/widgets/tm_appbar.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/my_urls.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _tittleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isCreateInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappbar(),
      body: ScreenBackground(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36),
                  Text('Add New Task', style: TextTheme.of(context).titleLarge),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _tittleController,
                    decoration: InputDecoration(hintText: 'Tittle'),
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return "Enter your tittle";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 6,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return "Enter your description";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: isCreateInProgress == false,
                    replacement: Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    ),
                    child: FilledButton(
                      onPressed: _onTapCreateNewTask,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapCreateNewTask() {
    if (_formKey.currentState!.validate()) {
      createTask();
    }
  }

  Future<void> createTask() async {
    isCreateInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title": _tittleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New",
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      MyUrls.createTask,
      body: requestBody,
    );

    if (response.isSuccess) {
      isCreateInProgress = false;
      clearController();
      trueScaffoldMessage(context, 'New task added');
    } else {
      falseScaffoldMessage(context, response.errorMessage);
    }

    setState(() {});
  }

  Future<void> clearController() async {
    _tittleController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tittleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
