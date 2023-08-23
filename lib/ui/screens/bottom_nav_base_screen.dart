import 'package:flutter/material.dart';
import 'package:tm_getx/ui/screens/cancelled_task_screen.dart';
import 'package:tm_getx/ui/screens/completed_task_screen.dart';
import 'package:tm_getx/ui/screens/in_progress_task_screen.dart';
import 'package:tm_getx/ui/screens/new_task_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedScreenIndex = 0;

  final List<Widget> _screens = const [
     NewTaskScreen(),
     InProgressScreen(),
     CancelledTaskScreen(),
     CompletedTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
          color: Colors.grey
        ),
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,
        onTap: (int index){
          _selectedScreenIndex = index;
          if(mounted){
            setState(() {

            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.account_tree), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel_outlined), label: 'Cancel'),
          BottomNavigationBarItem(icon: Icon(Icons.done_all), label: 'Completed'),
        ],
      ),
    );
  }
}
