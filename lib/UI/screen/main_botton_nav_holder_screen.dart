import 'package:flutter/material.dart';

import '../widgets/tm_appbar.dart';

class MainBottonNavHolderScreen extends StatefulWidget {
  const MainBottonNavHolderScreen({super.key});

  @override
  State<MainBottonNavHolderScreen> createState() =>
      _MainBottonNavHolderScreenState();
}

class _MainBottonNavHolderScreenState extends State<MainBottonNavHolderScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappbar(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int Index) {
          _selectedIndex = Index;
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
