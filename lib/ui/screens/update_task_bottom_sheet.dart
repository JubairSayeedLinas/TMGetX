import 'package:flutter/material.dart';
import 'package:tm_getx/data/models/network_response.dart';
import 'package:tm_getx/data/models/task_list_model.dart';
import 'package:tm_getx/data/services/network_caller.dart';
import 'package:tm_getx/data/utils/urls.dart';

class UpdateTaskSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskSheet({super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskSheet> createState() => _UpdateTaskSheetState();
}

class _UpdateTaskSheetState extends State<UpdateTaskSheet> {
  late TextEditingController _titleTEController;

  late TextEditingController _desccriptionTEController;

  bool _updateTaskInProgress = false;

  @override
  void initState() {
    _titleTEController = TextEditingController(text: widget.task.title);
    _desccriptionTEController = TextEditingController(text: widget.task.description);
    super.initState();
  }

  Future<void> updateTask() async {
    _updateTaskInProgress = true;
    if(mounted){
      setState(() {

      });
    }
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _desccriptionTEController.text.trim(),
    };
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.createTask, requestBody);
    _updateTaskInProgress = false;
    if(mounted){
      setState(() {

      });
    }
    if(response.isSuccess){
      _titleTEController.clear();
      _desccriptionTEController.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task uodated Successfully')));
        widget.onUpdate();
      } else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task Failed ')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16,),
              Row(
                children: [
                  Text(
                    'Update task',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close))
                ],
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
                  visible: _updateTaskInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                      onPressed: () {
                         updateTask();
                      },
                      child: Text('Update')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}