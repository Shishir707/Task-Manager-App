import 'package:flutter/material.dart';

class NewTaskScreenList extends StatefulWidget {
  const NewTaskScreenList({super.key});

  @override
  State<NewTaskScreenList> createState() => _NewTaskScreenListState();
}

class _NewTaskScreenListState extends State<NewTaskScreenList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 68,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: EdgeInsets.only(left: 5,top: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(children: [Text('12',style: TextTheme.of(context).titleLarge,),
                      Text('New',style: TextTheme.of(context).labelSmall,)
                    ]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
