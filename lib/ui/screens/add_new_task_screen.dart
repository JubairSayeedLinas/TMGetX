import 'package:flutter/material.dart';
import 'package:tm_getx/data/models/network_response.dart';
import 'package:tm_getx/data/services/network_caller.dart';
import 'package:tm_getx/data/utils/urls.dart';
import 'package:tm_getx/ui/widgets/screen_background.dart';
import 'package:tm_getx/ui/widgets/user_profile_banner.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _desccriptionTEController = TextEditingController();
  bool _addNewTaskInProgress = false;

  Future<void> addNewTask() async {
    _addNewTaskInProgress = true;
    if(mounted){
      setState(() {

      });
    }
    Map<String, dynamic> requestBody = {
     "title": _titleTEController.text.trim(),
      "description": _desccriptionTEController.text.trim(),
      "status": "New",
    };
   final NetworkResponse response = await NetworkCaller().postRequest(Urls.createTask, requestBody);
    _addNewTaskInProgress = false;
    if(mounted){
      setState(() {

      });
    }
   if(response.isSuccess){
     _titleTEController.clear();
     _desccriptionTEController.clear();
    if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Add Task Successfully')));
    } else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Add Task Failed ')));
    }
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserProfileAppBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16,),
                  Text(
                    'Add new task',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(
                        hintText: 'Title'
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _desccriptionTEController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _addNewTaskInProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: () {
                            addNewTask();
                          },
                          child: const Icon(Icons.arrow_forward_ios)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}