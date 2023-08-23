import 'package:flutter/material.dart';
import 'package:tm_getx/data/models/network_response.dart';
import 'package:tm_getx/data/models/summary_count_model.dart';
import 'package:tm_getx/data/models/task_list_model.dart';
import 'package:tm_getx/data/services/network_caller.dart';
import 'package:tm_getx/data/utils/urls.dart';
import 'package:tm_getx/ui/widgets/summary_card.dart';
import 'package:tm_getx/ui/widgets/task_list_tile.dart';
import 'package:tm_getx/ui/widgets/user_profile_banner.dart';
import 'package:tm_getx/ui/screens/update_task_status_sheet.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({Key? key}) : super(key: key);

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  bool _getProgressTaskInProgress = false;
  bool _getCountSummaryInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TaskListModel _taskListModel = TaskListModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getInProgressTask();
      getCountSummary();
    });
  }

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Summary Data Get Failed'),
        ));
      }
    }
    _getCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getInProgressTask() async{
    _getProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.inProgressTasks);

    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('get In Progress Data Get Failed'),
        ));
      }
    }
    _getProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }

  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response = await NetworkCaller().getRequest(
        Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element)=> element.sId == taskId);
      if(mounted){
        setState(() {

        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(' Delete failed'),));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UserProfileAppBar(),
            _getCountSummaryInProgress ? const LinearProgressIndicator()
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _summaryCountModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return SummaryCard(
                      title: _summaryCountModel.data![index].sId ?? 'New',
                      number: _summaryCountModel.data![index].sum ?? 0,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 4,
                    );
                  },
                ),
              ),
            ),

            Expanded(
              child: _getProgressTaskInProgress ? const Center(
                child: CircularProgressIndicator(),
              ) : ListView.separated(
                itemCount: _taskListModel.data?.length ?? 0,
                itemBuilder: (context, index){
                  return TaskListTile(
                    data: _taskListModel.data![index],
                    onDeleteTap: () {
                    deleteTask(_taskListModel.data![index].sId!);
                  },
                    onEditTap: () {
                    showStatusUpdateShowBottomSheet(_taskListModel.data![index]);
                  },
                  );

                },separatorBuilder: (BuildContext context, int index){
                return const Divider(height: 4,);
              } ,) ,)
          ],
        ),
      ),
    );
  }
  void showStatusUpdateShowBottomSheet(TaskData task){
    List<String> taskStatusList = ['New', 'Progress', 'Completed', 'Cancelled'];
    String _selectedTask = task.status!.toLowerCase();

    showModalBottomSheet(
        isScrollControlled: true
        ,context: context, builder: (context){
      return StatefulBuilder(
          builder: (context, updateState) {
            return UpdateTaskStatusSheet( task: task, onUpdate: (){
              getInProgressTask();
            });
          }
      );
    });
  }
}
