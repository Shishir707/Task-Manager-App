import 'package:flutter/material.dart';
import 'package:task_manager/UI/screen/new_task_screen_list.dart';
import 'package:task_manager/UI/screen/progress_task_list_screen.dart';
import '../widgets/tm_appbar.dart';
import 'cancelled_task_list_screen.dart';
import 'completed_task_list_screen.dart';

class MainBottomNavHolderScreen extends StatefulWidget {
  const MainBottomNavHolderScreen({super.key});

  @override
  State<MainBottomNavHolderScreen> createState() =>
      _MainBottomNavHolderScreenState();
}

class _MainBottomNavHolderScreenState extends State<MainBottomNavHolderScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    NewTaskScreenList(),
    ProgressTaskList(),
    CancelledTaskList(),
    CompletedTaskList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappbar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label, color: Colors.purple),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.hourglass_top, color: Colors.blue),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined, color: Colors.red),
            label: 'Cancel',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle, color: Colors.green),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}
