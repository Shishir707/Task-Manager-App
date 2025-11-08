import 'package:flutter/material.dart';

class TMappbar extends StatelessWidget implements PreferredSizeWidget{
  const TMappbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        spacing: 6,
        children: [
          CircleAvatar(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rahim Hasan',style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white
              )),
              Text('rahim@gmail.com', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white
              ))
            ],
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}