import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title of task',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Description of the task',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 4),
          Text('Date: 29 Jun 2022', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'New',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, color: Colors.red.shade300),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, color: Colors.blue.shade300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
