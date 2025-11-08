import 'package:flutter/material.dart';

import '../widgets/tm_appbar.dart';

class MainBottonNavHolderScreen extends StatefulWidget {
  const MainBottonNavHolderScreen({super.key});

  @override
  State<MainBottonNavHolderScreen> createState() => _MainBottonNavHolderScreenState();
}

class _MainBottonNavHolderScreenState extends State<MainBottonNavHolderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappbar(),
    );
  }
}


